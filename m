From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 2 Aug 2007 23:12:39 -0400
Message-ID: <20070803031239.GL20052@spearce.org>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de> <alpine.LFD.0.999.0708021340450.8184@woody.linux-foundation.org> <46B26686.3010002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	users@cvs2svn.tigris.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 03 05:12:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGnat-0002dc-5Q
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 05:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857AbXHCDMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 23:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbXHCDMs
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 23:12:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56799 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbXHCDMr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 23:12:47 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IGnaX-0005bk-3V; Thu, 02 Aug 2007 23:12:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B3A8420FBAE; Thu,  2 Aug 2007 23:12:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46B26686.3010002@alum.mit.edu>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54665>

Michael Haggerty <mhagger@alum.mit.edu> wrote:
> 1. The helper branches should be deleted after the tag has been defined.
>  I simply couldn't figure out how to do this using git-fast-import, and
> git-fast-import complained when I tried to use a branch called
> "TAG_FIXUP" without the "refs/head/" prefix.

Two issues there:

* Deleting branches:

  I currently don't support this in fast-import, but I'll add support
  for it.  Its actually pretty simple to tell it to drop a branch,
  especially if the dang thing doesn't actually exist in the git
  repository yet (because its only in-memory).

* Creating a branch without refs/heads/ prefix:

  This is a bug.  I had good intentions by trying to verify the
  name was one that didn't contain special reserved characters,
  but I wound up also requiring you to create branches only in the
  refs/heads/ namespace.  That was not what I wanted to do.  I'm
  patching it tonight.

-- 
Shawn.
