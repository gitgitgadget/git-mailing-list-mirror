From: Francis Daly <francis@daoine.org>
Subject: [PATCH] Tweaks to make asciidoc play nice.
Date: Wed, 5 Apr 2006 23:25:17 +0100
Message-ID: <20060405222517.GA4202@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Roeland <marco.roeland@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Apr 06 00:25:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRGRS-0006QV-FU
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 00:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWDEWZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 18:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWDEWZb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 18:25:31 -0400
Received: from craic.sysops.org ([217.75.2.2]:21632 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S932098AbWDEWZb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 18:25:31 -0400
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.13.1/8.12.11) with SMTP id k35MPH2O004215;
	Wed, 5 Apr 2006 23:25:17 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.5
X-Spam-Checker-Version: SpamAssassin 3.0.5 (2005-11-28) on craic.sysops.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18455>

Once the content has been generated, the formatting elves can reorder
it to be pretty...

Signed-off-by: Francis Daly <francis@daoine.org>

---

The manpage formatting needed to stop things being ugly is
nontrivial. In this case, an option has multi-paragraph content,
some of which should be displayed preformatted.

"+" means "this next paragraph is a continuation of the same section"
"--" means "the next paragraphs are all continuations -- don't worry
     about all the other "+"s
"------" means "the next content is preformatted"
"------", the blank line, and the extra indentation within ------ are 
     there because docbook-xsl stylesheets are odd in different ways.
     This combination makes the preformatted text be visually distinct 
     with both versions 1.68 and 1.69. Without that oddness, we could
     use either just ------ or just indentation. Ho hum.

 Documentation/git-commit.txt |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

e46caf57bc2d09c032b992f9024226acd2d68fbc
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index ec8b562..0a7365b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -83,15 +83,16 @@ OPTIONS
 	the current tip as parents -- so the current top commit is
 	discarded.
 +
+--
 It is a rough equivalent for:
-+
-$ git reset --soft HEAD^
-+
-$ ... do something else to come up with the right tree ...
-+
-$ git commit -c ORIG_HEAD
-+
+------
+	$ git reset --soft HEAD^
+	$ ... do something else to come up with the right tree ...
+	$ git commit -c ORIG_HEAD
+
+------
 but can be used to amend a merge commit.
+--
 
 -i|--include::
 	Instead of committing only the files specified on the
-- 
1.2.4.g3488

-- 
Francis Daly        francis@daoine.org
