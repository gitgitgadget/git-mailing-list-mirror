From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] t5510: do not leave changed cwd
Date: Fri, 4 Mar 2016 14:04:16 +0100
Message-ID: <56D987D0.5030208@drmicha.warpmail.net>
References: <cover.1457088499.git.git@drmicha.warpmail.net>
 <f6499302a5dfb52bf6c9430581103da9569434a3.1457088499.git.git@drmicha.warpmail.net>
 <20160304115255.GB8355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 14:04:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abpP7-0003QL-0T
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 14:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbcCDNET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 08:04:19 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48965 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751380AbcCDNES (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 08:04:18 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 1BE732667A
	for <git@vger.kernel.org>; Fri,  4 Mar 2016 08:04:18 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 04 Mar 2016 08:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=/nnR9qFZSBGIp1vSs+VOed0xKRA=; b=OBF2Xo
	/YfL0ZJSMeBEnk9pk1C/ZYKqsvb6J68ls6j2aRfS0D5Xybz9S/TeCUXzW8RFL0or
	0V17op44S3GoVlzGvw0g6CgENlazilK1Jth3eoNq/Chtwa/YUhoWBMKpZaWIbJTb
	HzKTxLgRIdcvB3JiHB/xUC+XTq+MH3/KbTmOk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=/nnR9qFZSBGIp1v
	Ss+VOed0xKRA=; b=KejLdm2a55hcZ7kLDjKIXga+qxLp/kOr4/RcKQ0l6Oc8aDU
	k+AE84znCTwbnHkhneYtpOX0XH7sJWXkVyulO1m2yKnsFr6LvjkAXgJfgPtuxoqp
	YWFZPiJL7THkgi0zHjax3DG+6u7bbxs9xfnyGsmpZqcx82gr8b3xMDSXJfD0=
X-Sasl-enc: nBDt/14S78zVFhSAPFnb+NAf+4i6aI1rl9ICzw/QO6Q3 1457096657
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id A9AE8C00020;
	Fri,  4 Mar 2016 08:04:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160304115255.GB8355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288255>

Jeff King venit, vidit, dixit 04.03.2016 12:52:
> On Fri, Mar 04, 2016 at 11:53:50AM +0100, Michael J Gruber wrote:
> 
>> t5510 carefully keeps the cwd at the test root by using either subshells
>> or explicit cd'ing back to the root. Use a subshell for the last
>> subtest, too.
> 
> I doubt this caused the heisenbug you saw, as we should have an absolute
> path for the trash-dir, and we "cd" to its containing directory before
> deleting it. But this is definitely a good thing to be doing anyway, to
> prevent surprises for new tests added to t5510.

Absolutely ;)

Michael
