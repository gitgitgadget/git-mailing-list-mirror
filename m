From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: Overriding ~/.gitconfig using GIT_CONFIG
Date: Mon, 29 Aug 2011 13:16:06 +0100
Message-ID: <1314620166.5939.282.camel@rex>
References: <1313163498.14274.505.camel@rex>
	 <7vr54qmodf.fsf@alter.siamese.dyndns.org>
	 <7vmxfemnc4.fsf@alter.siamese.dyndns.org> <1313181853.14274.535.camel@rex>
	 <20110828130555.GA56765@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Nguy?? n =?UTF-8?Q?Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, GIT Mailing-list <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 14:16:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy0lc-0001TN-N5
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 14:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556Ab1H2MQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 08:16:36 -0400
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:58173 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781Ab1H2MQf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 08:16:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7TCGQhL002812;
	Mon, 29 Aug 2011 13:16:26 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 17826-07; Mon, 29 Aug 2011 13:16:21 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7TCGE7O002806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Aug 2011 13:16:15 +0100
In-Reply-To: <20110828130555.GA56765@gmail.com>
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180309>

On Sun, 2011-08-28 at 06:05 -0700, David Aguilar wrote:
> On Fri, Aug 12, 2011 at 09:44:13PM +0100, Richard Purdie wrote:
> > My problem isn't that I want to specify a specific .gitconfig file, I
> > just need it to ignore the one in $HOME. I'm happy for the .git/config
> > file to be used, in fact I need it to be.
> 
> If you're writing a tool then it should restrict itself to
> git's plumbing commands.  You should be able to do just about
> anything without needing to worry about differences in
> configuraiton.  Git commands almost always provide a way to
> override configuration through the use of flags.
> 
> The plumbing commands are listed in the main git manpage.
> See "Low-level commands (plumbing)" here:
> http://www.kernel.org/pub/software/scm/git/docs/
> 
> What is the specific problem solved by overriding the
> configuration?  It may be possible to solve it without needing
> to get too complicated.

I'm not sure writing my own porcelain makes sense in this case.

The tool in question is a build system which is primarily interested in
building software. Sometimes the software we want to build is "bleeding
edge" and hence rather than download tarballs, we want to interact
directly with SCMs like git to obtain it.

The commands I'm using are the likes of "git clone" and "git fetch"
although we do use commands listed under the plumbing section too such
as ls-remote and read-tree. We do "cache" checkouts and support
automatically noticing changes and updating/building.

What I do want to be able to say is "ignore whatever the user might have
put in their ~/.gitconfig file" since I've open bug reports about people
putting things in there that break builds.

The fetch/clone commands do what I need, apart from being influenced by
userconfig so reimplementing them myself doesn't seem like a good
approach.

Cheers,

Richard

-- 
Linux Foundation
http://www.yoctoproject.org/
