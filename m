From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to safely remove a blob
Date: Tue, 15 Feb 2011 09:40:59 +0100
Message-ID: <4D5A3C1B.2030600@drmicha.warpmail.net>
References: <4D5A358F.2050906@ilt.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rolf Wester <rolf.wester@ilt.fraunhofer.de>
X-From: git-owner@vger.kernel.org Tue Feb 15 09:44:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpGW3-0003yh-J3
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 09:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab1BOIoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 03:44:05 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53872 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751268Ab1BOIoE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 03:44:04 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 456E3207DE;
	Tue, 15 Feb 2011 03:44:04 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 15 Feb 2011 03:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=czzyV093vms2QrJoj+bIxXPxTy4=; b=tujPmEbagLB+NrnEwHla8dYIwvvWwR9MTtvs1xfOIuZ12wRxYcaxE7LOQXYvlDh9oUiN6WgKAIs/MRjOIeWeiTz1E8V+XMryNXR9+me8X4foexjwZnVKpVNxKyi2SYhogIbY7FsvZV1QzSTXV3CmXlrKAjbuoB4ryxApuYLMJ2Q=
X-Sasl-enc: zs8xNCLwec13YxNyIhAnam4QiRo2vDl0sWgBI4siig9M 1297759443
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4C21644333B;
	Tue, 15 Feb 2011 03:44:03 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <4D5A358F.2050906@ilt.fraunhofer.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166827>

Rolf Wester venit, vidit, dixit 15.02.2011 09:13:
> Hello,
> 
> in one of my git repos I found an 102 MB object that probably came in there more or less occasionally.
> Its a blob and I would like to remove it safely. I tried to figure out how to do it but I was
> not very successful. I guess simply deleting the file could corrupt my repo or at least the clones of
> that repo.
> 
> I would be very appreciative for any help.

If nothing references that blob then it will go away eventually. The
last section of git-filter-branch's manpage (checklist for shrinking a
repo) details the steps you can take to get rid of it now. (You should
be already in the situation after applying filter-branch and removing
refs/original/*.) If the blob still persists then it is referenced.

Michael
