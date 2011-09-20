From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] contrib/hooks: adapt default Debian install location for
	contrib hooks
Date: Tue, 20 Sep 2011 11:19:14 +0000
Message-ID: <20110920111914.17913.qmail@d29ca435be5a3d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 13:26:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5ySo-0002o0-U7
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 13:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417Ab1ITLZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 07:25:58 -0400
Received: from a.ns.smarden.org ([109.68.224.7]:53518 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754028Ab1ITLZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 07:25:57 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Sep 2011 07:25:56 EDT
Received: (qmail 17914 invoked by uid 1000); 20 Sep 2011 11:19:14 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181756>

Placing the contrib hooks into /usr/share/doc/ wasn't a good idea in the
first place.  According to the Debian policy they should be located in
/usr/share/git-core/, so let's put them there.

Thanks to Bill Allombert for reporting this through
 http://bugs.debian.org/640949

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 contrib/hooks/post-receive-email     |    4 ++--
 templates/hooks--post-receive.sample |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index fa6d41a..ba077c1 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -11,11 +11,11 @@
 # will have put this somewhere standard.  You should make this script
 # executable then link to it in the repository you would like to use it in.
 # For example, on debian the hook is stored in
-# /usr/share/doc/git-core/contrib/hooks/post-receive-email:
+# /usr/share/git-core/contrib/hooks/post-receive-email:
 #
 #  chmod a+x post-receive-email
 #  cd /path/to/your/repository.git
-#  ln -sf /usr/share/doc/git-core/contrib/hooks/post-receive-email hooks/post-receive
+#  ln -sf /usr/share/git-core/contrib/hooks/post-receive-email hooks/post-receive
 #
 # This hook script assumes it is enabled on the central repository of a
 # project, with all users pushing only to it and not between each other.  It
diff --git a/templates/hooks--post-receive.sample b/templates/hooks--post-receive.sample
index 7a83e17..e48346e 100755
--- a/templates/hooks--post-receive.sample
+++ b/templates/hooks--post-receive.sample
@@ -12,4 +12,4 @@
 # see contrib/hooks/ for a sample, or uncomment the next line and
 # rename the file to "post-receive".
 
-#. /usr/share/doc/git-core/contrib/hooks/post-receive-email
+#. /usr/share/git-core/contrib/hooks/post-receive-email
-- 
1.7.5.4
