From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v7 01/40] apply: move 'struct apply_state' to apply.h
Date: Tue, 14 Jun 2016 13:07:35 +0200
Message-ID: <CAP8UFD2uoQy9eNvMiBXvfk0g0kA_Nn6ekoRxEWCRwKbMSwDMsA@mail.gmail.com>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
 <20160613160942.1806-2-chriscool@tuxfamily.org> <xmqq7fdsbt6z.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 13:07:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCmC7-0003Sc-RZ
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 13:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbcFNLHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 07:07:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33535 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbcFNLHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 07:07:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id r5so21525356wmr.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YoWCsCR2TwV7l6CqA8rd8EFLPBKRWihtx9B4TnNcuBw=;
        b=Q3wO3lMg+KmUv2OXX0vQMUSxpgOwpI5Q4+P3OLP7MzEE0+1t6kkWYeZKbnt8Yw8qii
         TVGY0IkfuQ7goTpnTQy5fOQ9x0pSRwxgyQlix9Cl4mh84ldAeRyXSWC4alSeiIgRGHJ0
         nCmMoROeGnpjBt8V9qCNuu4nBMvMz6f9E4q/oOpwq6MKebuKJ5N2g51M/QXWSP2nKQUK
         mYZqCzNguZf8MM2wGHhLKD0Jg5VxeOPTNQ1+BgjoRyscJt7f3xF6rAg7otqBCzPrAsu0
         0TU57KqJOquW3yDe3i9mit8s2DW4TPtPPWVXpSQHDXtY+zQlMz13LgbVwCmb0ax7IAUy
         3oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YoWCsCR2TwV7l6CqA8rd8EFLPBKRWihtx9B4TnNcuBw=;
        b=MWxxm1t3WosnyxOGu0u9HSi8v6iq1sdJ8kOnljO71TbevpLQWRxJuJv8ZD1P93pbvT
         1Y6L01vCgZoRwzRD9xbRbIPJdqjMb9rizVvsSc+tOhdn11J0GHVMrKtb5tlGNptv9aIc
         Xh7PXluOiJ0TeI1QuncOvyVVxYGm+/unl3FcKUcHUjKDmHu0I7pA4y3tZIY/7cr6paqt
         n0pus1YgYxwDmB3NKar/hjKni5+gJSofPkHMi3mt5Iaou9nPRqDIiqTsAsvvIs2U90ah
         SN1yN5hFzFdHwCz7tPWQyIXqtDzkuB+1dhIU5o2DoMm5AQ1Alr49blQzMCGRuxMkeZZs
         FC0A==
X-Gm-Message-State: ALyK8tLgPPF0OTVFt7gk4blfTnBlvlySlrJ2gVIe5EQl0qeCYqEisV5+jzuDOO4fMbds64vTAjcDsyL6ETvPLA==
X-Received: by 10.194.239.163 with SMTP id vt3mr5561412wjc.78.1465902456588;
 Tue, 14 Jun 2016 04:07:36 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Tue, 14 Jun 2016 04:07:35 -0700 (PDT)
In-Reply-To: <xmqq7fdsbt6z.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297285>

On Tue, Jun 14, 2016 at 12:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> To libify `git apply` functionality we must make 'struct apply_state'
>> usable outside "builtin/apply.c".
>>
>> Let's do that by creating a new "apply.h" and moving
>> 'struct apply_state' there.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  apply.h         | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  builtin/apply.c |  98 +-----------------------------------------------------
>>  2 files changed, 101 insertions(+), 97 deletions(-)
>>  create mode 100644 apply.h
>>
>> diff --git a/apply.h b/apply.h
>> new file mode 100644
>> index 0000000..9a98eae
>> --- /dev/null
>> +++ b/apply.h
>> @@ -0,0 +1,100 @@
>> +#ifndef APPLY_H
>> +#define APPLY_H
>> +
>> +enum ws_error_action {
>> +     nowarn_ws_error,
>> +     warn_on_ws_error,
>> +     die_on_ws_error,
>> +     correct_ws_error
>> +};
>> +
>> +enum ws_ignore {
>> +     ignore_ws_none,
>> +     ignore_ws_change
>> +};
>> +
>> +/*
>> + * We need to keep track of how symlinks in the preimage are
>> + * manipulated by the patches.  A patch to add a/b/c where a/b
>> + * is a symlink should not be allowed to affect the directory
>> + * the symlink points at, but if the same patch removes a/b,
>> + * it is perfectly fine, as the patch removes a/b to make room
>> + * to create a directory a/b so that a/b/c can be created.
>> + *
>> + * See also "struct string_list symlink_changes" in "struct
>> + * apply_state".
>> + */
>> +#define SYMLINK_GOES_AWAY 01
>> +#define SYMLINK_IN_RESULT 02
>
> Everything below is agreeable, but all the names that are made
> public above by this change do not sound specific enough to "apply".
> I wonder if they should get "apply" somewhere in their names to
> avoid confusion coming from the namespace contamination...

Yeah, I will add "apply" in the names.

Thanks,
Christian.
