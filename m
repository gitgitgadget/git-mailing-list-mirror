From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] prompt: fix tracked files for zsh
Date: Sun, 21 Apr 2013 17:32:29 -0500
Message-ID: <CAMP44s0xMX2-sDzouYtCRzqRQLHOCdUDR_+G-50Mv9wG2P+EFQ@mail.gmail.com>
References: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
	<m2fvyk8fb8.fsf@igel.home>
	<7vli8cuv5j.fsf@alter.siamese.dyndns.org>
	<m2a9or907f.fsf@igel.home>
	<CAMP44s36TO6DQ_3j7rSOoOM6QS-Y0DW_z6WX_GF3ODFfupb6jg@mail.gmail.com>
	<7vehe3sfwv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 00:32:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU2oG-0006zD-5q
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 00:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab3DUWcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 18:32:32 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36804 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab3DUWcb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 18:32:31 -0400
Received: by mail-lb0-f176.google.com with SMTP id y8so5067633lbh.21
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 15:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=WuZYNUrg6910fRdUgzPJ5gAUnERq8Y1lsIebjwHca8g=;
        b=TpXGyjAaiDMvbIfzMNng2GnkJkEXQ4j73vjCsK0UNrvAqAryvS5mhCPnCWVUo5MT5C
         AujSWE9Vc2iwAI2yUSpH3XZfCz440hUcNsy4uSPi6VBz93XvMh2A+hB0uNsfFuLsCgcA
         cVAaJPmhykMT4c0NzTc4MhJtbIdqLo3hYZdA0UijHdPr00hzlSs1d8MuBHZXbUi493+Q
         JOt0iFy1LhT9TUeOk1ogw4dnvvkWbhOSEi5Z55PbakY4Y8j4QIV0D1Qir+6W5cl/uir7
         OTjKOV7EJf7A0dATZJwHleSjaeOPnK42ommtDZM62u6Ls5hS6vPQCxx1xCOVuJO8kwJC
         rH+Q==
X-Received: by 10.152.20.134 with SMTP id n6mr63045lae.19.1366583549975; Sun,
 21 Apr 2013 15:32:29 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sun, 21 Apr 2013 15:32:29 -0700 (PDT)
In-Reply-To: <7vehe3sfwv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221981>

On Sun, Apr 21, 2013 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Apr 21, 2013 at 2:02 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>>>
>>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>>
>>>>>> +                           if [ -n "${ZSH_VERSION-}" ]; then
>>>>>> +                                   u="%%"
>>>>>> +                           else
>>>>>> +                                   u="%"
>>>>>> +                           fi
>>>>>
>>>>> aka u="%${ZSH_VERSION:+%}"
>>>>
>>>> Do you need/want a colon there?  Even if it is empty, as long as it
>>>> is defined we would want this, no?
>>>
>>> The original wouldn't.
>>
>> I thought you were trying to improve the original ;)
>
> OK, so I _think_ everybody is in agreement that the patch should
> look like this.  OK?
>
> -- >8 --
> From: Felipe Contreras <felipe.contreras@gmail.com>
> Subject: [PATCH] prompt: fix untracked files for zsh
>
> With "bash.showUntrackedFiles" option,

Not exactly correct, it can also be GIT_PS1_SHOWUNTRACKEDFILES.

> presense of untracked files
> is signalled by adding a per-cent sign '%' to the prompt.  But
> because '%' is used as an escape character to introduce prompt
> customization in zsh (just like bash prompt uses '\' to escape \u,
> \h, etc.), we need to say '%%' to get a literal per-cent.

Otherwise it's fine.

Cheers.

-- 
Felipe Contreras
