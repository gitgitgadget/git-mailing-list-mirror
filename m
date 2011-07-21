From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] gitignore: add top level patch ignore rule
Date: Thu, 21 Jul 2011 15:29:58 +0200
Message-ID: <4E2829D6.9010409@drmicha.warpmail.net>
References: <1311113877.2643.2.camel@vitaliy-Vostro-1400> <4E268D2F.50201@drmicha.warpmail.net> <CAGTPOqeF6LneWCg_du5dDfzFp7QV_jGg1t4u23sziTN+uHQyXA@mail.gmail.com> <4E282349.4040404@drmicha.warpmail.net> <CAGTPOqcd5G=NG83wgnH80nqNsS1FYwtRp4QjaB=oU5NkPts_Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Vitaliy Ivanov <vitalivanov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 15:30:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjtKJ-0001ya-Fi
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 15:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968Ab1GUNaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 09:30:02 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:55500 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750899Ab1GUNaB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2011 09:30:01 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AD89A20A83;
	Thu, 21 Jul 2011 09:30:00 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 21 Jul 2011 09:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=27R2xzDK8jXhE12cYQjXXK
	3yjIo=; b=OtGGlA0ALsy6zbyQSPT42Xggz022PEkJW/0PjPSEcIgkEj39EKsqdZ
	5VRwRtayhgcpRAu5SNcSFWAIxkjZG4T6fgGMo2mk9uiJZyezEjOINJKtZIAjMLYu
	GqlL14btOvi9C3QPXdIzqvDajvctL6FxtJnhtTx4fWAtwQ9NBmRYg=
X-Sasl-enc: pynTvIT+1t3lqQm9fBmWMpU6QLo7vQ5P4/AALOZLZfhj 1311255000
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EBB9340B980;
	Thu, 21 Jul 2011 09:29:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <CAGTPOqcd5G=NG83wgnH80nqNsS1FYwtRp4QjaB=oU5NkPts_Hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vitaliy Ivanov venit, vidit, dixit 21.07.2011 15:22:
> On Thu, Jul 21, 2011 at 4:02 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Vitaliy Ivanov venit, vidit, dixit 21.07.2011 14:54:
>>> Michael,
>>>
>>> On Wed, Jul 20, 2011 at 11:09 AM, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:
>>>> Vitaliy Ivanov venit, vidit, dixit 20.07.2011 00:17:
>>>>> Add top level ignore rule for patches created by format-patch command.
>>>>
>>>> Please don't.
>>>>
>>>> The tracked ignore file is for ignoring products and artefacts of our
>>>> build process. format-patch is not part of this process, and the
>>>> existence of *.patch files depends on your workflow. But what is much
>>>> worse: In
>>>>
>>>> git status
>>>> git format-patch rev-spec
>>>> git send-email *.patch
>>>>
>>>> it is very easy to send out the wrong patches (along with the right
>>>> ones), because your patch hides them from status. Also, I can't clean
>>>> them up with "git clean -f" any more. I would have to use "git clean -f
>>>> -x" which would clean the build products also (and force a rebuild).
>>>>
>>>> So, your patch makes a format-patch based workflow much worse. What
>>>> problem does it try to solve?
>>>
>>> I will not insist. You may know it better but git as is a public
>>> project where anyone can create and send patches. So it seems to me
>>> basic workflow for sharing changes.
>>
>> Well sure it is. We do that and discuss the merits of patches.
>>
>> I do use format-patch/send-email, and as I explained, your patch would
>> make that more difficult. If there is something that it makes better
>> that may outweigh it. Can you explain what improvement this (ignoring
>> *.patch) introduces?
> 
> I'm not sure how listing all the patches that you have under "git
> status" will help you not to send a wrong one.

Well, in order to get this patch in, you will have to explain what it is
good for (not that I'd decide that, but that's my recommendation for
you). I've asked twice and I'm still waiting for an explanation.

OTOH, I've explained in detail why I consider this change bad. Please
reread my first reply.

> Also we are talking about /*.patch rule and not *.patch as with such rule:

Sure.

Michael
