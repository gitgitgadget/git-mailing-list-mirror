From: Petr Baudis <pasky@suse.cz>
Subject: Re: Best way to generate a git tree containing only a subset of commits from another tree?
Date: Thu, 23 Mar 2006 01:25:43 +0100
Message-ID: <20060323002543.GU18185@pasky.or.cz>
References: <Pine.LNX.4.64.0603221920260.22475@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 01:25:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMDdj-0001LF-7U
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 01:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWCWAZR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 19:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWCWAZR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 19:25:17 -0500
Received: from w241.dkm.cz ([62.24.88.241]:4837 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932573AbWCWAZP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 19:25:15 -0500
Received: (qmail 9384 invoked by uid 2001); 23 Mar 2006 01:25:43 +0100
To: Anton Altaparmakov <aia21@cam.ac.uk>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603221920260.22475@hermes-2.csi.cam.ac.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17837>

Dear diary, on Wed, Mar 22, 2006 at 08:28:52PM CET, I got a letter
where Anton Altaparmakov <aia21@cam.ac.uk> said that...
> Preferable I would like to do it so that later when Linus has pulled from 
> my /usr/src/linux-2.6 tree, I do a "git pull" of Linus' tree from 
> /usr/src/my-big-tree and it all works correctly and I don't end up with 
> the same commits twice.
> 
> Is that possible at all?

Not with Git - you will end up with the same commits twice, once when
you originally committed them and once coming cherry-picked from your
linux-2.6 tree through Linus' tree.

> If not what can I do to do it cleanly?  Does git help in any way or do I 
> literally have to export all my commits from /usr/src/my-big-tree to diff 
> style patches and then throw away the tree, clone Linus tree after he has 
> pulled my /usr/src/linux-2.6 tree and commit all my generated diff patches 
> again?  That would be rather horrible to have to do...

Yes, that's the way to go, but actually it's not horrible at all because
there's a tool to help you - check out StGIT, which will let you
maintain a stack of patches on top of a git tree and do all sorts of
cool stuff with them (including rebasing them to new tree revision, the
most important thing for you).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
