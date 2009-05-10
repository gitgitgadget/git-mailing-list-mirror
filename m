From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Create $GIT_DIR/objects/pack if missing during
	renameAndOpenPack
Date: Sun, 10 May 2009 16:03:41 -0700
Message-ID: <20090510230341.GG30527@spearce.org>
References: <693615.98383.qm@web27802.mail.ukl.yahoo.com> <20090510213046.GC30527@spearce.org> <200905110059.50494.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Struberg <struberg@yahoo.de>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 11 01:04:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3I4F-0007Rn-HL
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 01:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbZEJXDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 19:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbZEJXDl
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 19:03:41 -0400
Received: from george.spearce.org ([209.20.77.23]:50579 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbZEJXDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 19:03:40 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 63841381D5; Sun, 10 May 2009 23:03:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200905110059.50494.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118758>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> s?ndag 10 maj 2009 23:30:46 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
> > index b2bcbb7..1eb40d4 100644
> > --- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
> > +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
> > @@ -1037,6 +1037,14 @@ public PackLock renameAndOpenPack(final String lockMessage)
> >  		final File finalIdx = new File(packDir, "pack-" + name + ".idx");
> >  		final PackLock keep = new PackLock(finalPack);
> >  
> > +		if (!packDir.exists() && !packDir.mkdir() && !packDir.exists()) {
> 
> Is there a lot to gain by this instead of just if (!packDir.mkdir() && !packDir.exists()) ?

No, not really.  But usually the directory exists, its rare when
it doesn't.

We probably just wasted more CPU time in our MUAs debating this than
it really costs in the long run.  I'm too #@!** lazy to go back
and amend this patch.  But you can amend it if it really bothers
you to do the "!exists && !mkdir && !exists".

-- 
Shawn.
