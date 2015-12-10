From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/8] update-index: use enum for untracked cache options
Date: Thu, 10 Dec 2015 11:37:53 +0100
Message-ID: <CAP8UFD3+gsHZuaBweP83or=rEh-LFnz6=ycBCeuhApxp0PzN1A@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-3-git-send-email-chriscool@tuxfamily.org>
	<xmqq1tawlpqw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 11:38:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6ybo-0006dW-CX
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 11:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbbLJKh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 05:37:56 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33136 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbLJKhz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 05:37:55 -0500
Received: by lfaz4 with SMTP id z4so53619343lfa.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 02:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1YEQJvvghOdk6c63OZgSdIA58KQZZy/xTfxl6RsoAas=;
        b=KseDWFCiJRbUlyTVEgsciRZUn2wTdj2/H+dMW27D/EcA2naLefeNAuV+F2RxuObouE
         kEQNDol/gkR9Vwt4+eFQpj5+t2Dh+0amXuRZ49uMQ58dtn8ZtMwOHM6xHMfbABXMn7BV
         9Nu3QJimqgIJEZhXoDw5mcxmmcfQdoJA+nsItJmEskGrJT8UOx9HwnwPNyN7yTOFMx6h
         vgPurcLXOlUHZX331X8HIwKFc3kk6zwslDxbQjIUA23gdj+pMFSX5UrPS1UtmvKn56ak
         C+1BkXJiWczoGjTwCpOXt5u+C+JF/pYZx3hSArNfGMZpoAKLOMA+XuPOBcG4dqTky2JC
         ysRQ==
X-Received: by 10.25.142.84 with SMTP id q81mr4032294lfd.77.1449743873811;
 Thu, 10 Dec 2015 02:37:53 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Thu, 10 Dec 2015 02:37:53 -0800 (PST)
In-Reply-To: <xmqq1tawlpqw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282215>

On Tue, Dec 8, 2015 at 8:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/update-index.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index 6f6b289..246b3d3 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -35,6 +35,14 @@ static int mark_skip_worktree_only;
>>  #define UNMARK_FLAG 2
>>  static struct strbuf mtime_dir = STRBUF_INIT;
>>
>> +/* Untracked cache mode */
>> +enum uc_mode {
>> +     UNDEF_UC = -1,
>> +     NO_UC = 0,
>> +     UC,
>> +     FORCE_UC
>> +};
>> +
>
> With these, the code is much easier to read than with the mystery
> constants, but did you consider making UC_ a common prefix for
> further ease-of-reading?  E.g.
>
>     UC_UNSPECIFIED
>     UC_DONTUSE
>     UC_USE
>     UC_FORCE
>
> or something?

Ok, I will use what you suggest.

Thanks,
Christian.
