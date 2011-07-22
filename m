From: Vitaliy Ivanov <vitalivanov@gmail.com>
Subject: Re: [PATCH] gitignore: add top level patch ignore rule
Date: Fri, 22 Jul 2011 16:20:27 +0300
Message-ID: <CAGTPOqdQNBMueCxjvwKHFmdX4YgPSuHwV2GKT5DVysndqgPo=Q@mail.gmail.com>
References: <1311113877.2643.2.camel@vitaliy-Vostro-1400>
	<4E268D2F.50201@drmicha.warpmail.net>
	<CAGTPOqeF6LneWCg_du5dDfzFp7QV_jGg1t4u23sziTN+uHQyXA@mail.gmail.com>
	<4E282349.4040404@drmicha.warpmail.net>
	<CAGTPOqcd5G=NG83wgnH80nqNsS1FYwtRp4QjaB=oU5NkPts_Hg@mail.gmail.com>
	<4E283C9E.2050000@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 15:20:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkFec-0006WQ-7P
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 15:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334Ab1GVNU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 09:20:29 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:62161 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab1GVNU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 09:20:28 -0400
Received: by eye22 with SMTP id 22so2278188eye.2
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3/YDplncE0/WimNls1hom7WBZqnsvRv7H7DYxsUwa48=;
        b=QRzUnLK4w/TR7aBFOZx5hEWuwH70NSLRs3Or3iqBCRG2lc0YI7tok7EKxiOOLtX9h7
         QSALQuP8xaoMaA5AVDUudoYVResoJfVAcL1pptSmgOl8GPwJtYVJrhk1o0Cqn+rMvCB3
         W9loH2Z3wRt5y/mE5jGjjQsIiOd5ICVlzrthw=
Received: by 10.213.9.4 with SMTP id j4mr688360ebj.148.1311340827092; Fri, 22
 Jul 2011 06:20:27 -0700 (PDT)
Received: by 10.213.10.144 with HTTP; Fri, 22 Jul 2011 06:20:27 -0700 (PDT)
In-Reply-To: <4E283C9E.2050000@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177642>

On Thu, Jul 21, 2011 at 5:50 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> On 11-07-21 09:22 AM, Vitaliy Ivanov wrote:
>> On Thu, Jul 21, 2011 at 4:02 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Vitaliy Ivanov venit, vidit, dixit 21.07.2011 14:54:
>>>> Michael,
>>>>
>>>> On Wed, Jul 20, 2011 at 11:09 AM, Michael J Gruber
>>>> <git@drmicha.warpmail.net> wrote:
>>>>> Vitaliy Ivanov venit, vidit, dixit 20.07.2011 00:17:
>>>>>> Add top level ignore rule for patches created by format-patch command.
>>>>>
>>>>> Please don't.
>>>>>
>>>>> The tracked ignore file is for ignoring products and artefacts of our
>>>>> build process. format-patch is not part of this process, and the
>>>>> existence of *.patch files depends on your workflow. But what is much
>>>>> worse: In
>>>>>
>>>>> git status
>>>>> git format-patch rev-spec
>>>>> git send-email *.patch
>>>>>
>>>>> it is very easy to send out the wrong patches (along with the right
>>>>> ones), because your patch hides them from status. Also, I can't clean
>>>>> them up with "git clean -f" any more. I would have to use "git clean -f
>>>>> -x" which would clean the build products also (and force a rebuild).
>>>>>
>>>>> So, your patch makes a format-patch based workflow much worse. What
>>>>> problem does it try to solve?
>>>>
>>>> I will not insist. You may know it better but git as is a public
>>>> project where anyone can create and send patches. So it seems to me
>>>> basic workflow for sharing changes.
>>>
>>> Well sure it is. We do that and discuss the merits of patches.
>>>
>>> I do use format-patch/send-email, and as I explained, your patch would
>>> make that more difficult. If there is something that it makes better
>>> that may outweigh it. Can you explain what improvement this (ignoring
>>> *.patch) introduces?
>>
>> I'm not sure how listing all the patches that you have under "git
>> status" will help you not to send a wrong one.
>
> Seeing various patch files in "git status" bothered me as well.
>
> So I put all my patches in a top-level patches/ directory, along with a
> patches/.gitignore file that ignores everything there.
>
> If that doesn't meet your needs, you could instead add a core.excludesfile
> entry to your ~/.gitconfig, and in there ignore *.patch files.
>
> So given those alternatives, I'm not convinced your patch is suitable for all
> git users.

Sure. It's not a problem. And thanks for describing workarounds here.
Actually, this issue is not bothering me a lot but I know that's a
usual practice to put patches to git ignore list.
That's why I proposed it to the list.


Vitaliy
