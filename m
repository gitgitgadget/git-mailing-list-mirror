From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [egit-dev] Re: jgit problems for file paths with non-ASCII
	characters
Date: Thu, 26 Nov 2009 11:57:36 -0800
Message-ID: <20091126195736.GV11919@spearce.org>
References: <4B0D356D.1080709@syntevo.com> <200911252211.55137.robin.rosenberg@dewire.com> <20091126005423.GM11919@spearce.org> <4B0E7DF5.9040007@syntevo.com> <alpine.DEB.1.00.0911261546350.7500@intel-tinevez-2-302> <4B0E9F69.9040502@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 20:57:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDkTG-0008Q9-HW
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 20:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbZKZT5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 14:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbZKZT5a
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 14:57:30 -0500
Received: from george.spearce.org ([209.20.77.23]:54505 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbZKZT53 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 14:57:29 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 517B838433; Thu, 26 Nov 2009 19:57:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4B0E9F69.9040502@syntevo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133828>

Thomas Singer <thomas.singer@syntevo.com> wrote:
> > You mean we should do the same thing as Apple with HFS?  Are you serious?
> 
> Yes, I'm serious. IMHO there should be a defined clear encoding used for
> files names in the repository. Otherwise you don't know what you can expect
> by reading it - it could mean anything. File names are in fact strings which
> are based on characters. To convert characters to bytes (or visa versa) you
> need to know the encoding.

That's likely not going to fly.  HFS+ has changed their decomposition
rules at least once, which means the byte sequence for the same
character sequence would differ, and a tree or commit hash would
come out different depending upon which rules you were following.
See [1] for details on what HFS+ does.

Also, Linus has previously stated HFS+ chose the worst possible
way to encode the names.  Getting Linus to admit he was wrong is
impossible, getting Linus to accept the HFS+ encoding rules as the
standard format used in a Git repository is not likely to happen.
Fortunately Linus carries a slightly smaller stick in Git than he
used to, but he is quite vocal and people tend to listen.

[1] http://developer.apple.com/mac/library/technotes/tn/tn1150.html#UnicodeSubtleties

-- 
Shawn.
