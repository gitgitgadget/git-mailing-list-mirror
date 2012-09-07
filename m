From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: [PATCH] ls-remote: document the '--get-url' option
Date: Fri,  7 Sep 2012 08:41:19 +0200
Message-ID: <1347000079-7945-1-git-send-email-stefan.naewe@gmail.com>
References: <7v7gs63mio.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Stefan Naewe <stefan.naewe@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 08:51:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9sPy-000390-R3
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 08:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864Ab2IGGvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 02:51:47 -0400
Received: from mail96.atlas.de ([194.156.172.86]:18560 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab2IGGvq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 02:51:46 -0400
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Sep 2012 02:51:46 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 1428710125;
	Fri,  7 Sep 2012 08:41:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id XEGil_LARmhM; Fri,  7 Sep 2012 08:41:35 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Fri,  7 Sep 2012 08:41:35 +0200 (CEST)
Received: from as100897.atlas.de (as100897.atlas.de [10.200.54.96])
	by mgsrv01.atlas.de (Postfix) with ESMTP id EC12A27171;
	Fri,  7 Sep 2012 08:41:34 +0200 (CEST)
Received: by as100897.atlas.de (Postfix, from userid 1000)
	id D3EED140DB; Fri,  7 Sep 2012 08:41:34 +0200 (CEST)
X-Mailer: git-send-email 1.7.12
In-Reply-To: <7v7gs63mio.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204947>

While looking for a way to expand the URL of a remote
that uses a 'url.<name>.insteadOf' config option I stumbled
over the undocumented '--get-url' option of 'git ls-remote'.
This adds some minimum documentation for that option.

And while at it, also add that option to the '-h' output.

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---
 Documentation/git-ls-remote.txt | 4 ++++
 builtin/ls-remote.c             | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 7a9b86a..a2ebf1d 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -42,6 +42,10 @@ OPTIONS
 	it successfully talked with the remote repository, whether it
 	found any matching refs.
 
+--get-url::
+	Expand the URL of the given remote repository taking into account any
+	"url.<base>.insteadOf" config setting (See linkgit:git-config[1]).
+
 <repository>::
 	Location of the repository.  The shorthand defined in
 	$GIT_DIR/branches/ can be used. Use "." (dot) to list references in
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 41c88a9..25e83cf 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -5,7 +5,7 @@
 
 static const char ls_remote_usage[] =
 "git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]\n"
-"                     [-q|--quiet] [--exit-code] [<repository> [<refs>...]]";
+"                     [-q|--quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]";
 
 /*
  * Is there one among the list of patterns that match the tail part
-- 
1.7.12
