From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: cloning empty repo
Date: Sun, 24 Jun 2007 19:01:57 -0400
Message-ID: <20070624230157.GM17393@spearce.org>
References: <467E8808.7030903@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Marijn Schouten (hkBst)" <hkBst@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 01:02:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2b6C-0000By-0h
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 01:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbXFXXCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 19:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbXFXXCE
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 19:02:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48858 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbXFXXCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 19:02:01 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I2b5a-0007vN-6z; Sun, 24 Jun 2007 19:01:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 38C9720FBAE; Sun, 24 Jun 2007 19:01:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <467E8808.7030903@gentoo.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50839>

"Marijn Schouten (hkBst)" <hkBst@gentoo.org> wrote:
> is there any reason why cloning an empty repository should result in an error
> instead of a succesfully cloned empty repo?

There's nothing to clone.  The repository is empty.

If you create a Git repository using `git init` and then create
another one also using `git init` then both repositories are empty,
and an empty repository is identical to every other empty repository.

So if you want to setup an empty repository and then clone nothing,
you actually can just setup another empty repository and configure
the 'origin' remote:

	mkdir a; cd a; git init; cd ..

	mkdir b; cd b; git init
	# now a and b are identical

	git remote add origin ../a/.git
	# now b is a "clone" of a's nothingness...

-- 
Shawn.
