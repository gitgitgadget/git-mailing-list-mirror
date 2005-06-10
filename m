From: "Tommy M. McGuire" <mcguire@crsr.net>
Subject: [PATCH] Re: "git cvsimport"
Date: Fri, 10 Jun 2005 01:22:06 -0500
Message-ID: <20050610062206.GA3992@immutable.crsr.net>
References: <Pine.LNX.4.58.0506071556000.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 08:18:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgcqL-0008KD-B7
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 08:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVFJGWV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 02:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVFJGWV
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 02:22:21 -0400
Received: from [65.98.21.155] ([65.98.21.155]:62733 "EHLO immutable.crsr.net")
	by vger.kernel.org with ESMTP id S261481AbVFJGWP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 02:22:15 -0400
Received: from mcguire by immutable.crsr.net with local (Exim 3.35 #1 (Debian))
	id 1Dgcu6-0001Eg-00; Fri, 10 Jun 2005 01:22:06 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506071556000.2286@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 07, 2005 at 04:03:53PM -0700, Linus Torvalds wrote:
> I'd love it if somebody tested the remote case (and, if it works, sends me
> a patch that just removes the anal tests in git-cvsimport-script), and
> maybe even updated the information a bit more.. As it is, that
> Documentation/cvs-migration.txt file is a bit on the light side.
> 
> Finally, I don't know what to do about cvsps options. It seems that the 
> default time-fuzz is a bit too long for some projects, so at least that 
> one should be overridable. So my silly script is not exactly wonderful, 
> but I think it's more approachable than people doing the magic by hand 
> (and forgetting to set TZ to UTC and the "-A" flag etc etc).
> 
> 		Linus

This is the first of a short sequence of patches, which just removes the
tests in in git-cvs-import-script.  It does, indeed, just work.

Signed-off-by: Tommy McGuire <mcguire@crsr.net>

Remove unneeded sanity tests, allowing remote CVS repos.

---
commit 21b4b44a5deee7985f14d0f4776ad0d489092a96
tree a48fbf33e90511554077f2c18053f1c000c2edb5
parent 98a96b00b88ee35866cd0b1e94697db76bd5ddf9
author Tommy M. McGuire <mcguire@crsr.net> Thu, 09 Jun 2005 13:12:25 -0500
committer Tommy M. McGuire <mcguire@crsr.net> Thu, 09 Jun 2005 13:12:25 -0500

 git-cvsimport-script |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -7,7 +7,7 @@ fi
 
 export CVSROOT="$1"
 export MODULE="$2"
-if [ ! "$CVSROOT" ] || [ ! "$MODULE" ] || [ ! -d $CVSROOT ] || [ ! -d $CVSROOT/CVSROOT ] || [ ! -d $CVSROOT/$MODULE ] ; then
+if [ ! "$CVSROOT" ] || [ ! "$MODULE" ] ; then
 	echo "Usage: git cvsimport <cvsroot> <module>"
 	exit 1
 fi



!-------------------------------------------------------------flip-


