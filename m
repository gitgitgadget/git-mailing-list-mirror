From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] Modified flag field type in rev_list_info struct in
 bisect.h. There is no need for flag field to be signed, as it is not supposed
 to be used as decimal.
Date: Fri, 25 Mar 2016 12:54:07 -0400
Message-ID: <CAPig+cRVBMbCikO2aCC0wXXgB4_P+XMNvNQfk+jhPWcZUbLfdQ@mail.gmail.com>
References: <1458848469-12663-1-git-send-email-motroniii@gmail.com>
	<1458848469-12663-2-git-send-email-motroniii@gmail.com>
	<CAGZ79kZmzo+f9YF1K1oC2GfOrzdaojmrca7bUm3cBRoDreeA-g@mail.gmail.com>
	<56F44788.2050509@gmail.com>
	<CAPig+cQcviTXYAGBTATgYXoaPtvxxeOUtCGYkLyW5oTFvLjEUA@mail.gmail.com>
	<CAGZ79kaF42yCFWdvqqDSAZbWmUo0UVJGbXCci1LF=ne+cixZ0A@mail.gmail.com>
	<xmqqr3ez5bcf.fsf@gitster.mtv.corp.google.com>
	<56F534D0.7050104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: work <motroniii@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:54:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajV03-00084E-CX
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 17:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbcCYQyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 12:54:10 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35712 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbcCYQyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 12:54:08 -0400
Received: by mail-vk0-f65.google.com with SMTP id e185so8317497vkb.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=adfQJGDOt8SP2khMFVALbXZNLjy10iuDKwei7awua+A=;
        b=tFbXgiVI1DHwhdFBEzcHBiZp1Ex14PeN3esBZ6Vxh6W7jD51IJi4Zdngg6tOL4kmle
         pZm730hkKgn9P9iOtH6RTi1+SA0Q+CQFbfrPz64eAqov4FLe39GqG9OjI+YKJzOowyMS
         cdjQpkUX+mYe7/nzUflJgvLb84TsNWJO/jOXAVxT6dcYfV+EPKuWlR+j3uj/NEG1hCzA
         wKuZQNKCV0BPhnNA84jOyTboLVIPEmJu5jWJMe2VW/mtfBZVNjp6zXddzjRsPur/FL8Z
         vjxN7DWbQeWyjkGe4Qqekm2j3G/n+xoa+XU2fjbkzBnvpUyGrCZWaJ3xg5FmIaaaIB+6
         192w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=adfQJGDOt8SP2khMFVALbXZNLjy10iuDKwei7awua+A=;
        b=gu8y7/nZ6AhV2qWD1Dce7i9a/SbEf1TOEMNPu0LBQ9edCbEo8XT/j2KUQRUrCGm3SY
         NeDSAoe6PSGcqRo95z5TueqSC6TNc0q9rEgPzjXzZxvJOQ9k9tS5idHG6V+mrZmkiq0a
         9/tr6w7pTQbY3/WEHhRPsbVFAmjtaLjA1FY5BOTT16oiJqv5g0mekWYF2lOzFr+HKR5B
         V6AHucMlIxas5IkJyWNodxYyV2t7G3hRmZUFCuuDkgOMX1cJzC1MPLoUvpiWVriZNNB5
         m5CeARaXbz9YZIMIwp3u2Rhq1P+lmSiNYs3BGSp62/N4YiULuDdkVYkrM3L/p42U5I1N
         /7jA==
X-Gm-Message-State: AD7BkJKHT4KnRbJcl8XLut+HwhnClz0GjB7/dK9DXDg0YwHOsntAFWI98dBpXA2P3hvUCmf4XA+CPlwIbjazAA==
X-Received: by 10.31.21.4 with SMTP id 4mr7730102vkv.151.1458924847773; Fri,
 25 Mar 2016 09:54:07 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 25 Mar 2016 09:54:07 -0700 (PDT)
In-Reply-To: <56F534D0.7050104@gmail.com>
X-Google-Sender-Auth: rsF5vY9U9kNmiSyTx56EAqrgI-o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289904>

[please respond inline rather than top-posting]

On Fri, Mar 25, 2016 at 8:53 AM, work <motroniii@gmail.com> wrote:
> On 03/25/2016 09:18 AM, Junio C Hamano wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>> Maybe my exposure to the code was accidentally in a way such that
>>> I ever only saw the version without int.
>>
>> The older part of the code tends to spell flag words with "unsigned"
>> without "int", which is primarily historical fault of mine.
>
> Yep. Thanks for your remarks. I have made a bit more research about using
> old rev_list_info struct (with signed int flag) and realized, that it
> doesn't appear in expressions, where using signed integer will differ from
> unsigned one.
> I'll take using 'unsigned' instead of 'unsigned int' in account, so if
> needed, I can remake the patch in order to get it accepted.

If I read Junio's response correctly, "unsigned int" is indeed
preferred over "unsigned", so no need to change that part, but the
commit message needs improvement, and other reviewer comments should
be addressed.

And, yes, the expectation is that you will re-roll the patch (one or
more times) in response to issues pointed out by reviewers. As a GSoC
applicant, this is especially important since a big part of working on
this project is being responsive to review comments, and GSoC mentors
will examine your reviewer interaction when selecting applicants.
