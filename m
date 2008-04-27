From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Documentation: More on --pretty with git-diff-tree
Date: Sun, 27 Apr 2008 19:40:42 +0200
Message-ID: <200804271940.44940.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 19:42:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqAsg-0008LL-4W
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757902AbYD0Rkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757892AbYD0Rkz
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:40:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:46732 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824AbYD0Rky (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:40:54 -0400
Received: by ug-out-1314.google.com with SMTP id z38so587961ugc.16
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 10:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=L2L3j/TPwOKwHXWyy6GqvTkt2rs8nOZH9SyJZbfZ510=;
        b=iwCW9HeNOZwUYdIYyfDNDaMn+F37wvursGoPnSPE5uPcDYtKElMLaaTBjWB9RSPeqfK2YmJjTQTNihoh8sLICDkuQRxHHaNypLcLV1hiO8LPIIEHD1kjryDetGNvNjwKBseVZZeJqfm3AmxE34O7bUQQdjQ+eAAVuPJXVIUmTqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nFiMZ3kH+GSiaXj8IqFsZEAL2FCWKElg4dHm/u/XKgVcSqoSovt47Az5htl4ECxHO/wSSzS7RlP8H1pRYRd46O9Ut8jlMvDoAtc1/nFLfxEmdUyegGrENNardGPv5G8FO2E4FvBP4P/J4yUmeXJgXYXyYQEe669Aa+KuUowfkuM=
Received: by 10.66.221.6 with SMTP id t6mr3641166ugg.0.1209318053172;
        Sun, 27 Apr 2008 10:40:53 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.207.149])
        by mx.google.com with ESMTPS id z40sm7885501ikz.4.2008.04.27.10.40.49
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Apr 2008 10:40:52 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80472>

Mention that --pretty=<format> option is used by git-diff-tree only
if both --stdin and -v options are provided.  Because of that it doesn't
make sense to list pretty formats in git-diff-tree(1); linking to
git-show(1) should be enough.

Above changes appear only in git-diff-tree(1) manpage.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I have stumbled upon this when trying to simplify generating
'commitdiff_plain' view in gitweb.

"make doc" compiles without errors, and produces expected result.

 Documentation/git-diff-tree.txt  |    6 +++++-
 Documentation/pretty-options.txt |    3 +++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 58d02c6..afe82e3 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -24,6 +24,7 @@ Note that "git-diff-tree" can use the tree encapsulated in a commit object.
 
 OPTIONS
 -------
+:git-diff-tree: 1
 include::diff-options.txt[]
 
 <tree-ish>::
@@ -104,7 +105,10 @@ include::pretty-options.txt[]
 	if the diff itself is empty.
 
 
-include::pretty-formats.txt[]
+Pretty Formats
+--------------
+
+For description of pretty formats see for example linkgit:git-show[1]
 
 
 Limiting Output
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 6d66c74..8c101b9 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -3,6 +3,9 @@
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
 	'full', 'fuller', 'email', 'raw' and 'format:<string>'.
+ifdef::git-diff-tree[]
+	This option is used for "git-diff-tree --stdin -v" combination.
+endif::git-diff-tree[]
 	When omitted, the format defaults to 'medium'.
 +
 Note: you can specify the default pretty format in the repository
-- 
1.5.5
