From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Sun, 22 Jul 2007 22:09:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:09:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICig2-0003N7-BP
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 23:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbXGVVJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 17:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbXGVVJP
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 17:09:15 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:52476 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751608AbXGVVJO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 17:09:14 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 79B25C610F
	for <git@vger.kernel.org>; Sun, 22 Jul 2007 22:09:12 +0100 (BST)
Received: (qmail 27340 invoked by uid 103); 22 Jul 2007 22:09:12 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3722. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.030098 secs); 22 Jul 2007 21:09:12 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 22 Jul 2007 22:09:12 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0707221956210.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53319>

On Sun, 22 Jul 2007, Johannes Schindelin wrote:

>
> Inspired by contrib/workdir/git-new-workdir, the flag --new-workdir (or
> its shortcut, -n) can be used to create a new working directory for the
> newly created branch.  All information, except which branch is checked
> out (and therefore also the index), will be symlinked from the current
> repository.
>
> Example:
>
> 	$ git branch -n ~/my-new-topic xy-problem
>
> will create a branch called "xy-problem", which is initially identical
> to the current branch, and check out the new branch in ~/my-new-topic/.
> You will be able to cherry-pick from, log and diff with the branch
> "xy-problem" in the current repository, since most of the metadata is
> shared.
>
> Conversely, you can access all the branches in the current repository
> from ~/my-new-topic/, too.
>
> A word of warning: switching to _same_ branch that is checked out in
> the other repository is asking for trouble.  You are really working not
> only on the same object database, but also the same (i.e. not copied)
> refs namespace.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 	IMHO this is a better syntax than what is in contrib/, and "git
> 	branch" is probably the right place for such a thing, from a
> 	user's perspective.

Surely checkout would make more sense than branch?  You are effectively 
checking out into a new directory ... also you may want to get an existing 
branch (certainly most of my usage of new-workdir is checking out existing 
branches, e.g. to look at - as in build and play with - an interesting 
branch that someone else has pushed out).

Definitely in favour of moving this into git proper though.

-- 
Julian

  ---
Lack of capability is usually disguised by lack of interest.
