From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 15:41:35 +0100
Message-ID: <4D5BE21F.7020106@drmicha.warpmail.net>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com> <20110216023645.GA7085@sigill.intra.peff.net> <20110216032047.GA2858@elie> <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com> <20110216085114.GA9413@sigill.intra.peff.net> <AANLkTik_F=d1CjNVfj35wgv0pL1LefOMnttXjs=s2wCQ@mail.gmail.com> <20110216095415.GA12578@sigill.intra.peff.net> <AANLkTimj9NCR2Kkiz82WW1qx1NY-ptS4Qn2yzPqoLGP0@mail.gmail.com> <20110216100622.GA12971@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 15:44:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppicb-0002bf-1p
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 15:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab1BPOon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 09:44:43 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51169 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751174Ab1BPOom (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 09:44:42 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6E0BC20A96;
	Wed, 16 Feb 2011 09:44:41 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 16 Feb 2011 09:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ihjVOBhX+p++VVll5+rC7rX6GRA=; b=c1OBXzR9EmwCT0rHSNvKRBEeqziiXrr+cLkVx2iTFPse26u7AfEABpSpZRXDLqU3tRWKpcP22+HLu0zl8/cVS3usJxsU1dXgqOq+Ud0VPZ8R9oTJokvdpL5GNa1y63r0h37UExmS8K7hRJdictNcQ7BexVkrXpdPtVoC5McSXbs=
X-Sasl-enc: Mwz6DafG5RPShFlhC2Lx6gEOrdzSluEENhokBCvBhCuv 1297867481
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 92AC0443266;
	Wed, 16 Feb 2011 09:44:40 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110216100622.GA12971@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166967>

Jeff King venit, vidit, dixit 16.02.2011 11:06:
> On Wed, Feb 16, 2011 at 09:58:52AM +0000, Sverre Rabbelier wrote:
> 
>> On Wed, Feb 16, 2011 at 09:54, Jeff King <peff@peff.net> wrote:
>>> So? Your question was whether index state is precious. If it's precious,
>>> shouldn't we be keeping a history of it?
>>
>> I don't think it's quite _that_ precious, but the only operation that
>> I regularly use that can blow away my carefully constructed index as
>> side effect of doing something else is `git commit -a`.
> 
> OK, so how precious is it? :)

Maybe it's a bit precious, but not overly...

> 
> If you want to have an option that specifically prevents the "git commit
> -a" muscle memory thing, then go for it. I'm guessing it is the most
> common "oops" one. Even with an index reflog, you might want it on top.
> 
> But it just seems silly to me to not protect at the same time against
> the other ways you can lose state from the index.
> 
> -Peff

so that keeping one backup would be enough? I.e. an automated way of
doing "cp index index.bak" before an index update and some "reset"
incarnation to revive the copy?

Michael
