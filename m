From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Clarify how repository service parameters are used
Date: Wed, 29 Aug 2007 12:14:20 +0300
Organization: Private
Message-ID: <absa3doz.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 11:10:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQJZP-00031h-K9
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 11:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbXH2JKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 05:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336AbXH2JKe
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 05:10:34 -0400
Received: from main.gmane.org ([80.91.229.2]:58350 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753407AbXH2JKd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 05:10:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IQJZD-0002uz-RP
	for git@vger.kernel.org; Wed, 29 Aug 2007 11:10:27 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 11:10:27 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 11:10:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:0vmKEFjok+OS4b5p/pUzfHHq6Y4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56915>

At upload-archive service, mention repository option
daemon.uploadarchive. Add a paragrah and example to show how the
service parameters are added to the repository's config file.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-daemon.txt |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index f902161..0aeff70 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -164,7 +164,21 @@ upload-pack::
 	item to `false`.
 
 upload-archive::
-	This serves `git-archive --remote`.
+	This serves `git-archive --remote`. This is the
+        repository setting `daemon.uploadarchive`.
+
+Instead of globally using `--enable=service`, it might be more
+advisable to configure these items by repository basis. The
+configuration file is ./config, supposing that the repository
+was created with `git --bare init [--share]`. The services would
+be listed as:
+
+------------------------------------------------
+...
+[daemon]
+        uploadpack    = true
+        uploadarchive = true
+------------------------------------------------
 
 EXAMPLES
 --------
-- 
1.5.3.rc5

    Available also from git repository http://cante.net/~jaalto/git/git
    Branch: Documentation/git-daemon.txt+clarify-how-repo-DAEMON-parms-are-used
