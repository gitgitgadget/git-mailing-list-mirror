From: Vitaliy Ivanov <vitalivanov@gmail.com>
Subject: Re: [PATCH] gitignore: add top level patch ignore rule
Date: Thu, 21 Jul 2011 16:22:51 +0300
Message-ID: <CAGTPOqcd5G=NG83wgnH80nqNsS1FYwtRp4QjaB=oU5NkPts_Hg@mail.gmail.com>
References: <1311113877.2643.2.camel@vitaliy-Vostro-1400>
	<4E268D2F.50201@drmicha.warpmail.net>
	<CAGTPOqeF6LneWCg_du5dDfzFp7QV_jGg1t4u23sziTN+uHQyXA@mail.gmail.com>
	<4E282349.4040404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 21 15:23:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjtDP-0007Lp-8y
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 15:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045Ab1GUNWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 09:22:54 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38657 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab1GUNWx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 09:22:53 -0400
Received: by ewy4 with SMTP id 4so1153479ewy.19
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jgPbWJSUwdOYdYAIIeYRBqt4c8YPSJNZ+/hh1hkzbHY=;
        b=pXCNoycrv0yTQpSAmDfa6GB6NuVYFMEVNTNl8K6M2kdaTmkliWGedkUKx7PP54WlJ2
         sl4f1mxPZqe7/pZxuNUUvzvV1EY0at/qm+OYBkivToG8dPbei0J093G1VHv+idu42e20
         C13qy6odiITD5vZMu6rZSBxoiUiwEqVNt7b9o=
Received: by 10.213.105.202 with SMTP id u10mr176681ebo.29.1311254572145; Thu,
 21 Jul 2011 06:22:52 -0700 (PDT)
Received: by 10.213.17.15 with HTTP; Thu, 21 Jul 2011 06:22:51 -0700 (PDT)
In-Reply-To: <4E282349.4040404@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2011 at 4:02 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Vitaliy Ivanov venit, vidit, dixit 21.07.2011 14:54:
>> Michael,
>>
>> On Wed, Jul 20, 2011 at 11:09 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Vitaliy Ivanov venit, vidit, dixit 20.07.2011 00:17:
>>>> Add top level ignore rule for patches created by format-patch command.
>>>
>>> Please don't.
>>>
>>> The tracked ignore file is for ignoring products and artefacts of our
>>> build process. format-patch is not part of this process, and the
>>> existence of *.patch files depends on your workflow. But what is much
>>> worse: In
>>>
>>> git status
>>> git format-patch rev-spec
>>> git send-email *.patch
>>>
>>> it is very easy to send out the wrong patches (along with the right
>>> ones), because your patch hides them from status. Also, I can't clean
>>> them up with "git clean -f" any more. I would have to use "git clean -f
>>> -x" which would clean the build products also (and force a rebuild).
>>>
>>> So, your patch makes a format-patch based workflow much worse. What
>>> problem does it try to solve?
>>
>> I will not insist. You may know it better but git as is a public
>> project where anyone can create and send patches. So it seems to me
>> basic workflow for sharing changes.
>
> Well sure it is. We do that and discuss the merits of patches.
>
> I do use format-patch/send-email, and as I explained, your patch would
> make that more difficult. If there is something that it makes better
> that may outweigh it. Can you explain what improvement this (ignoring
> *.patch) introduces?

I'm not sure how listing all the patches that you have under "git
status" will help you not to send a wrong one.
Also we are talking about /*.patch rule and not *.patch as with such rule:

[vitaliy.ivanov@vivanov git]$ git ls-files -i --exclude-standard
contrib/patches/docbook-xsl-manpages-charmap.patch
t/t4100/t-apply-1.patch
t/t4100/t-apply-2.patch
t/t4100/t-apply-3.patch
t/t4100/t-apply-4.patch
t/t4100/t-apply-5.patch
t/t4100/t-apply-6.patch
t/t4100/t-apply-7.patch
t/t4100/t-apply-8.patch
t/t4100/t-apply-9.patch
t/t4109/patch1.patch
t/t4109/patch2.patch
t/t4109/patch3.patch
t/t4109/patch4.patch
t/t4110/patch1.patch
t/t4110/patch2.patch
t/t4110/patch3.patch
t/t4110/patch4.patch
t/t4110/patch5.patch

>>>> On the way, reorganize ignore rules and add comments.
>>>
>>> How and why do you reorganize?
>>
>> Just to be able to find specific rule faster. Global rules are now all
>> together same is for top level root rules.
>
> That may be a sensible cleanup, and it's good to describe that in the
> commit message. Also, in general, we try to separate reorganisation
> patches from those which introduce functional changes. (One may argue
> whether adding *.patch falls into the latter category, though.)

Yeah, I should agree here. I can resend it w/o adding new rules but
simple reorganization and, of course, description for this change.

Vitaliy
