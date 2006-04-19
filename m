From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Document git-clone --reference
Date: Tue, 18 Apr 2006 20:19:48 -0400
Message-ID: <20060419001948.GC8915@spearce.org>
References: <1145404132.16166.97.camel@shinybook.infradead.org> <20060418235658.GB8915@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dwmw2@infradead.org
X-From: git-owner@vger.kernel.org Wed Apr 19 02:19:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW0QG-0001gf-7m
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 02:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWDSATx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 20:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWDSATx
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 20:19:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:28357 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750929AbWDSATx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 20:19:53 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FW0Q0-0006E2-Pa; Tue, 18 Apr 2006 20:19:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DE6A920FBB4; Tue, 18 Apr 2006 20:19:48 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060418235658.GB8915@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18890>

The new --reference flag introduced to git-clone in
GIT 1.3.0 was not documented but is rather handy.
So document it.

Also corrected a minor issue with the documentation for the
-s flag; the info/alternates file name was spelled wrong.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

  Shawn Pearce <spearce@spearce.org> wrote:
  >   git clone --reference=/foo git://remote/foo
  > 
  > would do the trick.  This is new in 1.3.0.  I just noticed its also
  > not documented in 1.3.0.  :-)

 Documentation/git-clone.txt |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

base 6625864c8ce9868ba4ab41165d97084f3f04bbed
last 66a5bd88d2a8d9d64d86733852fbaba9caa756b0
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 9ac54c2..131e445 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-clone' [-l [-s]] [-q] [-n] [--bare] [-o <name>] [-u <upload-pack>]
+	  [--reference <repository>]
 	  <repository> [<directory>]
 
 DESCRIPTION
@@ -46,10 +47,18 @@ OPTIONS
 -s::
 	When the repository to clone is on the local machine,
 	instead of using hard links, automatically setup
-	.git/objects/info/alternatives to share the objects
+	.git/objects/info/alternates to share the objects
 	with the source repository.  The resulting repository
 	starts out without any object of its own.
 
+--reference <repository>::
+	If the reference repository is on the local machine
+	automatically setup .git/objects/info/alternates to
+	obtain objects from the reference repository.  Using
+	an already existing repository as an alternate will
+	require less objects to be copied from the repository
+	being cloned, reducing network and local storage costs.
+
 --quiet::
 -q::
 	Operate quietly.  This flag is passed to "rsync" and
@@ -112,6 +121,16 @@ Make a local clone that borrows from the
 ------------
 
 
+Clone from upstream while borrowing from an existing local directory::
++
+------------
+$ git clone --reference my2.6 \
+	git://git.kernel.org/pub/scm/.../linux-2.7 \
+	my2.7
+$ cd my2.7
+------------
+
+
 Create a bare repository to publish your changes to the public::
 +
 ------------
-- 
1.3.0.rc4.g8060
