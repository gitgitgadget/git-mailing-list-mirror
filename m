From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Wed, 7 Feb 2007 19:12:57 -0500
Message-ID: <20070208001257.GB2469@spearce.org>
References: <20070206023111.GB9222@spearce.org> <45C81C33.6010704@gmail.com> <20070206061817.GB10508@spearce.org> <Pine.LNX.4.64.0702062347060.20138@iabervon.org> <20070207091351.GA1632@diana.vm.bytemark.co.uk> <Pine.LNX.4.63.0702071216330.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070207225532.GA1970@spearce.org> <Pine.LNX.4.63.0702080054180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwuY-00051l-M9
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161482AbXBHANF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161358AbXBHANF
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:13:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48230 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161482AbXBHANE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:13:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEwu9-0000Vl-G0; Wed, 07 Feb 2007 19:12:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E09ED20FBAE; Wed,  7 Feb 2007 19:12:57 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702080054180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39012>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Ah! I overlooked that feature. Certainly, this makes gfi (could we please 
> call it "fast-import", please?) very useful for history rewriting 
> purposed.

Heh.  I was actually sort of thinking of renaming it git-gfi.  :)

git-fast-import is just too long to write.  And for some reason I
have been writing it a lot lately.  #git, email, git-fast-export's
manual page (which is now also the largest manual page in all
of Git!).

But of course the better name is git-fast-import.  Stealing a
three-letter non-hypen-containing name for a tool the user never
is meant to run by hand is just evil.


I haven't even tried to use fast-import for general history
rewriting, let alone benchmarked it against something like git-split
or Cogito's rewriting tool, but I'd be willing to be that fast-import
is faster.  The internal ``cache'' that it uses for the tree
construction is lightweight enough that gfi can probably recreate
only the modified trees, compress and hash them, and output what
it needs to, in the time it takes to fork+exec git-commit-tree.

-- 
Shawn.
