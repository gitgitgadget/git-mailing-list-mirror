From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 6/6] cogito: update documentation
Date: Sun, 17 Jul 2005 22:51:36 -0400
Message-ID: <20050718025130.11198.34570.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 04:51:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuLjJ-0008Ii-TS
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 04:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVGRCvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 22:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVGRCvh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 22:51:37 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:24957 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261502AbVGRCvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 22:51:36 -0400
Received: (qmail 60730 invoked from network); 18 Jul 2005 02:51:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=qIwElzh8MCOvAJznfbf1o7Sw7ugDQB6gGgahCK+3AcEQX+w5m/EZNEpkGqZM2VxVY4HNa9TBaTRwpEk+lVSxTY5jiW2xT30O1+DHbUeKM8J/Dxv+5zvK4xavB4MruuwdtnF52sWkqta6rIYb3HcYJid7L0S+ZTaySECGZCv1eY8=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp015.mail.yahoo.com with SMTP; 18 Jul 2005 02:51:35 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Update the documentation to add a README.osx and update requirements.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 README     |    2 ++
 README.osx |   31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/README b/README
--- a/README
+++ b/README
@@ -45,6 +45,8 @@ The following tools are optional but str
 
 	libcrypto (OpenSSL)
 	rsync
+	gnu coreutils (the gnu versions of stat, date and cp are
+	           preferred over the BSD variants)
 
 
         Starting a Fresh GIT Repository
diff --git a/README.osx b/README.osx
new file mode 100644
--- /dev/null
+++ b/README.osx
@@ -0,0 +1,31 @@
+This version of Cogito should work on OS X and other BSD variants.
+
+To install on OS X:
+
+1) Install darwinports (http://darwinports.opendarwin.org/) 2) type
+"make Portfile" 3) type "sudo port install"
+
+You may have to deal with md5 mismatches.  Either adjust the md5sum in
+your new Portfile or place the new tarball in
+/opt/local/var/db/dports/distfiles/cogito.
+
+Caveats:
+
+cg-pull on a local repository requires cp -u, a non-portable gnu
+extension.  This means that cg-pull, cg-clone and cg-update from a
+local repository are broken.
+
+Workaround #1: Use rsync for local clones.  I.e.  "cg-clone
+rsync://localhost/dir" instead of "cg-clone dir".  This loses the disk
+space savings of normally gained by cg-clone.
+
+Workaround #2: Use gnu cp.  "cd /opt/local/bin; sudo ln -s gcp cp".
+
+Recommendations:
+
+The gnu versions of "stat" and "date" are preferred over their BSD
+variants.
+
+"patch", "diff", "merge", "curl" and "rysnc" are required.  OS X.4
+includes recent versions of these tools.  If you are not running X.4,
+you may wish to check this.
