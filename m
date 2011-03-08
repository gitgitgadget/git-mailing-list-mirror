From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: how to list commits on branch since last merge
Date: Tue, 08 Mar 2011 09:48:50 +0100
Message-ID: <4D75ED72.8030203@drmicha.warpmail.net>
References: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 09:52:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwseg-0000Qh-Dj
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 09:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545Ab1CHIwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 03:52:18 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50096 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751239Ab1CHIwR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 03:52:17 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 10CC220B70;
	Tue,  8 Mar 2011 03:52:17 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 08 Mar 2011 03:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=wNobj0S8aR96m4K++MDC/+rIdfo=; b=Zvhnc4AI7xmWJL/eT9+lC9edtE7ZKirHwSkQhLfrz4D4KijL1DMkYInOVzhTtgtFP5VDA0QLYjj1qcKDmcQEMrjTRHlHgOQvOlsmSVJZyA/3NoWBP3UjGnLcYeddLpOlwKtyJDUKOHp4piFUWsaWh+0DKdoJfx/eN4dOdTODmt8=
X-Sasl-enc: Jg/zYldM72RtC+LuqeE9ulufgCVctObYVcEaZSanU9Zz 1299574336
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6F9C3440BE3;
	Tue,  8 Mar 2011 03:52:16 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168647>

Jay Soffian venit, vidit, dixit 08.03.2011 08:24:
> Given this history:
> 
> o---o---x---o---...    foo
>  \       \
>   o---o---m---o---...  bar
> 
> I want to list the commits on bar newer than merge m (the last merge
> from foo). merge-base returns x.
> 
> I feel like I'm going to face-palm upon reply, but the only way I see
> to do it is:
> 
>   $ git rev-list --ancestry-path $(git merge-base foo bar)..bar
> 
> Or by greping the output of rev-list --merges --parents foo..bar
> looking for the merge base.
> 
> I must be missing something obvious, since this feels like it should
> be a common operation. :-)

Have you tried:

git rev-list --ancestry-path --left-right foo...bar

If the ">" commits are the ones that you want you only have to wait for
the "--right-only" option which is cooking in pu. And grep '^>' for now ;)

Michael
