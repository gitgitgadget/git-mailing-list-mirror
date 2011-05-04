From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Tagging Commits] feedback / discussion request
Date: Wed, 04 May 2011 11:21:19 +0200
Message-ID: <4DC11A8F.5020408@drmicha.warpmail.net>
References: <BANLkTik5-Ygh0YwN=j+ibLhP6==ots_MXQ@mail.gmail.com> <BANLkTimTmkufMnY5dJtDD6BWxs=vsDTygA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Richard Peterson <richard@rcpeterson.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 11:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHYGu-0001zE-Sd
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 11:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab1EDJVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 05:21:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42126 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751699Ab1EDJVW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2011 05:21:22 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4AD04205B7;
	Wed,  4 May 2011 05:21:22 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 04 May 2011 05:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=lV1o9E5+/RTQo2Kir0KzGWjGPJ0=; b=pDwaoABGbxidkRHIL65yWeryciCjqWsWetHVAQZAQA2TEggUJsvwwzH6UbeFf9AhQx6QkB3aL7OeBS1vU5vSZegEZOnrR3OeNqgRTCZysDBvvJ3xCaNFVkGOMBv4m+Ko5RwXAtDLDmzsalSYNdcfIE5sL8s6a+qNAFPbzsFGwiQ=
X-Sasl-enc: nEmYp7JtLpIqnuZwbyy3r/65FXLbezM1M4BTe619Loh/ 1304500882
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A9D53407F0C;
	Wed,  4 May 2011 05:21:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BANLkTimTmkufMnY5dJtDD6BWxs=vsDTygA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172730>

Sverre Rabbelier venit, vidit, dixit 04.05.2011 01:49:
> Heya,
> 
> On Wed, May 4, 2011 at 01:36, Richard Peterson <richard@rcpeterson.com> wrote:
>> Thank you, and please give feedback. I'm no git pro - just a guy with an
>> idea. Based on your feedback, Eric and I will steer our implementation.
> 
> Have you looked at git notes? They seem relevant. You could use them
> to sign commits after the fact, and by multiple people, etc.
> 

Exactly. Sign and store sig in refs/notes/sigs:

git rev-parse <commit> | gpg -sa | git notes --ref=sigs append -F- <commit>

Verify:

git notes --ref=sigs show <commit> | gpg

You can sign any object (blob, tree...) that way, of course.

Everything else (meaning of this sig, just like the meaning of a signed
tag or a s-o-b line) is a matter of project policy.

Michael
