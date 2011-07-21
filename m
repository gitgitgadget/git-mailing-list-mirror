From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] gitignore: add top level patch ignore rule
Date: Thu, 21 Jul 2011 15:02:01 +0200
Message-ID: <4E282349.4040404@drmicha.warpmail.net>
References: <1311113877.2643.2.camel@vitaliy-Vostro-1400> <4E268D2F.50201@drmicha.warpmail.net> <CAGTPOqeF6LneWCg_du5dDfzFp7QV_jGg1t4u23sziTN+uHQyXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Vitaliy Ivanov <vitalivanov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 15:02:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjstI-0007Kw-N3
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 15:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab1GUNCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 09:02:08 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:53896 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751888Ab1GUNCF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2011 09:02:05 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A22B6209C9;
	Thu, 21 Jul 2011 09:02:03 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 21 Jul 2011 09:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=dhYDylUmwD193f+IhaHt/Z
	hObOA=; b=sIiqbqYpXNyJb4jpXIF3XYYhqdNKrQzMcU1QfNbTakdc9WObB4nlIg
	9hw4hb83jqmgaw9/AfrZfgCpXDY26pBOYgGJzIpW5q3IzrQyGWp3Ng4IPlq+bbXe
	wjg9nHOzM02EjgvltJIoGboItnWCiXeg9/kHoohvy+LMRQNcj8r08=
X-Sasl-enc: 81kTutMOS1Ot+Vt7+E20yhiy7A2vBCFFfkn6Aetd8kZe 1311253323
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 06751452A52;
	Thu, 21 Jul 2011 09:02:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <CAGTPOqeF6LneWCg_du5dDfzFp7QV_jGg1t4u23sziTN+uHQyXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vitaliy Ivanov venit, vidit, dixit 21.07.2011 14:54:
> Michael,
> 
> On Wed, Jul 20, 2011 at 11:09 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Vitaliy Ivanov venit, vidit, dixit 20.07.2011 00:17:
>>> Add top level ignore rule for patches created by format-patch command.
>>
>> Please don't.
>>
>> The tracked ignore file is for ignoring products and artefacts of our
>> build process. format-patch is not part of this process, and the
>> existence of *.patch files depends on your workflow. But what is much
>> worse: In
>>
>> git status
>> git format-patch rev-spec
>> git send-email *.patch
>>
>> it is very easy to send out the wrong patches (along with the right
>> ones), because your patch hides them from status. Also, I can't clean
>> them up with "git clean -f" any more. I would have to use "git clean -f
>> -x" which would clean the build products also (and force a rebuild).
>>
>> So, your patch makes a format-patch based workflow much worse. What
>> problem does it try to solve?
> 
> I will not insist. You may know it better but git as is a public
> project where anyone can create and send patches. So it seems to me
> basic workflow for sharing changes.

Well sure it is. We do that and discuss the merits of patches.

I do use format-patch/send-email, and as I explained, your patch would
make that more difficult. If there is something that it makes better
that may outweigh it. Can you explain what improvement this (ignoring
*.patch) introduces?

>>
>>> On the way, reorganize ignore rules and add comments.
>>
>> How and why do you reorganize?
> 
> Just to be able to find specific rule faster. Global rules are now all
> together same is for top level root rules.

That may be a sensible cleanup, and it's good to describe that in the
commit message. Also, in general, we try to separate reorganisation
patches from those which introduce functional changes. (One may argue
whether adding *.patch falls into the latter category, though.)

[patch snipped]

Michael
