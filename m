From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Sun, 4 May 2008 17:52:08 -0400
Message-ID: <20080504215208.GG29038@spearce.org>
References: <86wsm9dbhk.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Sun May 04 23:53:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsm90-0000T8-0c
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 23:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853AbYEDVwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 17:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbYEDVwN
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 17:52:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38736 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbYEDVwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 17:52:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jsm7l-0002BP-J4; Sun, 04 May 2008 17:52:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AC85A20FBAE; Sun,  4 May 2008 17:52:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <86wsm9dbhk.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81202>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> 
> repeat by:
>     0) download the OSX ZFS drivers
>     1) Make a ZFS partition on OSX.
>     2) Clone git.git to the ZFS partition
>     3) immediately type git-status:
> 
>     # On branch master
>     # Untracked files:
>     #   (use "git add <file>..." to include in what will be committed)
>     #
>     #       "gitweb/test/Ma\314\210rchen"
>     nothing added to commit but untracked files present (use "git add" to track)

Isn't this just the normal HFS+ name mangling?

Apparently the ZFS port to Mac OS X includes the same braindamaged
UTF normalization that is applied to HFS+ volumes, which means
they have reused the code or pushed it higher in their VFS layer.
Linus has started to add support for teaching Git about this sort
of brain damaged filesystem, but nobody has implemented the Mac OS
X specific name hashing function required to make Git see that the
name it got from the readdir(3) call is the same name Git passed
to the OS, just encoded differently.

-- 
Shawn.
