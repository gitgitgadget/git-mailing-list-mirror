From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: git gc & deleted branches
Date: Thu, 8 May 2008 22:52:19 +0200 (CEST)
Message-ID: <alpine.LSU.1.10.0805082232070.4260@bianca.dialin.t-online.de>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de> <20080508183926.GA30613@sigill.intra.peff.net> <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de> <48235D99.2040407@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 08 22:53:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuD7I-0007ne-8P
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 22:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762024AbYEHUwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 16:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbYEHUwa
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 16:52:30 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37639 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764678AbYEHUw1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2008 16:52:27 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C9122106B53;
	Thu,  8 May 2008 16:52:24 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 08 May 2008 16:52:24 -0400
X-Sasl-enc: P2W4HTKYqWqe+F00lFWF7XP3zBTg37X/kbty9Q9jB/+H 1210279944
Received: from [192.168.2.100] (p549A4064.dip.t-dialin.net [84.154.64.100])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A5C85C6AF;
	Thu,  8 May 2008 16:52:23 -0400 (EDT)
In-Reply-To: <48235D99.2040407@nrlssc.navy.mil>
User-Agent: Alpine 1.10 (LSU 1032 2008-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81562>

On Thu, 8 May 2008, Brandon Casey wrote:
> Possibly that object got packed? git-prune only removes loose objects. 
> Try 'git gc --prune' which will call git-repack with the -a option.

Thanks, Brandon - that did the trick :-)

> Just know that each one of the config options that you set to zero, 
> including the one Jeff suggested setting to "now", is a safety mechanism 
> that is there to ensure that you never ever lose data and that mistakes 
> are recoverable.

I am aware of this. However, at work I am unfortunately bound to a very 
restrictive filesystem quota on central development servers, so every 
single byte counts in (our official versioning control system is ClearCase 
where less space is required due to working tree and history being 
supplied through virtual filesystems).

> And be assured that the objects referenced by a deleted branch will be 
> removed from the repository eventually as long as 'git gc --prune' is 
> run periodically.

Ok. I did not know about the 'prune' option yet as it neither mentioned in 
the "Git Tutorial" nor "Everyday Git", there only 'git gc' is used with no 
options.

Regards

Guido
