From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: caching commit patch-ids for fast git-cherry
Date: Thu, 29 May 2008 18:13:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805291809340.13507@racer.site.net>
References: <7f9d599f0805291001mdbb4b42q6f3a1b79bc9bc4e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Thu May 29 19:15:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1liv-0003ZK-54
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 19:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756706AbYE2ROg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 13:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756643AbYE2ROf
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 13:14:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:34261 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756373AbYE2ROe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 13:14:34 -0400
Received: (qmail invoked by alias); 29 May 2008 17:14:32 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO none.local) [132.187.25.128]
  by mail.gmx.net (mp011) with SMTP; 29 May 2008 19:14:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bHUwTt9DbedMbNHqz/m4ZEKcASoCOiKvhI8UEsG
	H6YBsO8cVUGQBC
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7f9d599f0805291001mdbb4b42q6f3a1b79bc9bc4e9@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83219>

Hi,

On Thu, 29 May 2008, Geoffrey Irving wrote:

> I'm planning to use cherry picking to manage long term syncing between 
> cvs/perforce and git repositories.  This means I'll have scripts running 
> git-cherry between branches with hundreds of uncommon commits, and I 
> want git-cherry to be much, much, faster.
> 
> It looks like I can do this by caching commit->patch-id pairs from
> commit_patch_id() in patch-ids.c to a file, say
> $GIT_DIR/commit-patch-id-cache.  The file would be binary and append
> only, and could be blown away if .  Any suggestions / concerns before
> I write this?  Is there any reusable efficient map code for storing
> the commit->patch-id map, or should I just mirror the blocked storage
> + binary search used for struct patch_ids?

I would store the stuff sorted, so that the lookup is fast, generation 
less so.

For inspiration, you might want to look at the "notes" branch in my 
personal fork:

http://repo.or.cz/w/git/dscho.git?a=shortlog;h=refs/heads/notes

Hth,
Dscho
