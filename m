From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/2] Add support for ~/.ssh/config BatchMode
Date: Tue, 16 Sep 2008 15:52:09 -0700
Message-ID: <20080916225209.GC22021@spearce.org>
References: <1221579869-27835-1-git-send-email-spearce@spearce.org> <1221579869-27835-2-git-send-email-spearce@spearce.org> <200809170046.31859.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:53:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfjQR-0006hD-Tq
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 00:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbYIPWwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 18:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbYIPWwL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 18:52:11 -0400
Received: from george.spearce.org ([209.20.77.23]:59941 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbYIPWwK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 18:52:10 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 884DD38360; Tue, 16 Sep 2008 22:52:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809170046.31859.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96040>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> tisdagen den 16 september 2008 17.44.29 skrev Shawn O. Pearce:
> > Connections created through batch processes (e.g. those started by
> > cron) don't have a terminal to interact with a user through.  A
> > common way to disable password prompting with OpenSSH is to setup
> > a Host block in ~/.ssh/config with "BatchMode yes" enabled, thus
> > telling the client not to prompt for passphases or passwords.
> 
> That did not work when any of the identities in  ~/.ssh matched. Though
> I specifically told jgit to use an identity that should not work, it found another
> that did. During setup all identities are loaded and made available to JSch.

Yes, that's a known bug.
 
> That bug is not related to this code (so I pushed it) other than it made it tricky
> to test. OpenSSH only tries the identity I tell it to, or default  if not told.

I have a plan on how to fix it.  I just didn't find the time today
to actually implement it.  I'll put an issue on the issue tracker
with my thoughts on how IdentityFile can be implemented correctly.
If I don't get to it this week maybe someone else can, it looks
pretty simple on the surface.

-- 
Shawn.
