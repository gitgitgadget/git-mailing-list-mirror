From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: tig show <commit> not working anymore?
Date: Thu, 16 Sep 2010 15:52:18 +0200
Message-ID: <4C922112.404@drmicha.warpmail.net>
References: <20100916125337.GG5785@bowser.ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>
To: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
X-From: git-owner@vger.kernel.org Thu Sep 16 15:52:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwEsw-0003BW-5E
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 15:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869Ab0IPNwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 09:52:14 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51709 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754566Ab0IPNwN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 09:52:13 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6F1E3551;
	Thu, 16 Sep 2010 09:52:13 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 16 Sep 2010 09:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6jKUCQbu0dTkBQacEW2UxeWd3Og=; b=NZcDeWFN+V+i53+jijjHTKT5setH/hUKnzXrRe3lQyvdxiAl/RVAwvJu3FAZdHjgtbW3Rer6Tbcl+3Skkx/dyjQhESG6YQsZk4ASizadQutXh+4DiwMd0mI7biPCkNMbDCXrOSpI8OL1eDSvZenrps4C8bIsQmX7zW31bgzakzg=
X-Sasl-enc: Yrq/uUbOM710kxK5/4xcRCDMV7ZRc1yZdUM95EOgJ+vm 1284645133
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CB21F5E1999;
	Thu, 16 Sep 2010 09:52:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <20100916125337.GG5785@bowser.ece.utexas.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156330>

Kumar Appaiah venit, vidit, dixit 16.09.2010 14:53:
> Hi!
> 
> I observed that, since commit
> 53c089443cd9885fa677becee4bf7ffd56c3c357, tig show <commit> doesn't
> seem to work the same way as I had expected it to. The documentation
> update doesn't seem to indicate that this was to be expected (or I
> didn't understand it properly). Could someone please confirm that
> tig show <commit> should actually do something similar to git show <commit> | tig ?

It seems that since that tig commit, "tig show <commit>" shows HEAD
rather than <commit>. OTOH, "tig <commit>" does navigate to <commit>.

The reason is that tig passes %(commit), not %(revargs), to git show for
the "show" subcommand, but the obvious simple patch breaks diff view. I
guess somewhere in the codepath one has to differentiate between those.
cc'ing Mr. Tig...

Michael
