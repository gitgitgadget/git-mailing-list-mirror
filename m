From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: libreoffice merge(tool?) issue #3 ...
Date: Wed, 23 Feb 2011 14:22:11 +0100
Message-ID: <4D650A03.8030106@drmicha.warpmail.net>
References: <1298388877.32648.171.camel@lenovo-w500>	 <4D63F2C5.2080505@drmicha.warpmail.net> <1298398479.32648.184.camel@lenovo-w500> <4D64ED12.5050802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: michael.meeks@novell.com, git@vger.kernel.org, kendy@novell.com,
	Norbert Thiebaud <nthiebaud@gmail.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Feb 23 14:25:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsEik-0001KU-F6
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 14:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417Ab1BWNZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 08:25:28 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52552 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754277Ab1BWNZ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 08:25:27 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4132420820;
	Wed, 23 Feb 2011 08:25:27 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 23 Feb 2011 08:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=RliqsAjrU0tr+Hf31pH8sftQcTE=; b=mePtg/nxcLCtA/U2T26RWxIZGnaeSIloTNk7QjUMPLhjcW6bQAIWwAMUuYbUr1MnPGfUt13CVDtEnQA0pgt8vSZxpUv/U3H7nyy26ptN0ZVV2rcrJCFBx1W8EQEH8QZ3Pe9PQLd/IohTE9ncYkkK+HRklWtKHjliKUvPA/i+auA=
X-Sasl-enc: YPHnM0vkfnjY35F/9WG9Wb+S24jvUm7UZqr/L2kC45kE 1298467526
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 806BD400931;
	Wed, 23 Feb 2011 08:25:26 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <4D64ED12.5050802@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167692>

Michael J Gruber venit, vidit, dixit 23.02.2011 12:18:
> Note that you're merging branches which are way off,
> 
> git rev-list --count --left-right
> origin/integration/dev300_m98...stage/ooo/dev300
> 3566    3126
> 
> and that the merge base is quite old:
> 
> af61642 (#i105937# Fixed a few remaining gradient glitches, 2010-01-16)

Following up on this:

git rev-list --count --left-right
origin/integration/dev300_m98...stage/ooo/dev300
3566    3126

git rev-list --count --left-right --no-merges
origin/integration/dev300_m98...stage/ooo/dev300
2794    2180

git rev-list --count --left-right --no-merges --cherry-pick
origin/integration/dev300_m98...stage/ooo/dev300
1136    528

That is, 2500 of these different commits are patch-equivalent
(cherry-picks). I don't think "merge" is the best tool to combine "fake"
branches like those. You may be better off with rebase... Although I'm
wondering what the branch policy was that lead to this.

Michael
