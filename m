From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch 3/5] Create html documents for all files in
 Documentation/RelNotes
Date: Sat, 6 Oct 2012 17:55:58 +0200 (CEST)
Message-ID: <343092834.269729.1349538958985.JavaMail.ngmail@webmail08.arcor-online.net>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker66@arcor.de
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 17:56:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKWjc-0003eW-U7
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 17:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074Ab2JFP4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 11:56:04 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:55483 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754199Ab2JFP4A (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 11:56:00 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id 0DACD30698
	for <git@vger.kernel.org>; Sat,  6 Oct 2012 17:55:59 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id F064E7FE4B7;
	Sat,  6 Oct 2012 17:55:58 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id EF8F75A624;
	Sat,  6 Oct 2012 17:55:58 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-01.arcor-online.net EF8F75A624
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349538958; bh=QzXyxrWJi19ZZIm6l+Tfsk0IzVvxKLBc9Kotybmugk8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=odchyiIpw0pd6MWDqBdT6u6rUbYNwPuO/wEU3dyPzlhyXPmfntsVn+nuJiYRFaJBk
	 dxMLgbGMZmtWbPsZ2m471Pn0i6NuGeGggyIUSPrVPPKHWm4Ru8DFJhcZ7QXlX1HSY1
	 GleS01hwTfiZLkI7BGNF+ciFmFLR8kkxht/1PYrU=
Received: from [94.217.29.222] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 6 Oct 2012 17:55:58 +0200 (CEST)
In-Reply-To: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.29.222
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207154>

- create html for all release note files
- fix some asciidoc layout problems

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/Makefile             | 2 ++
 Documentation/RelNotes/1.5.2.1.txt | 6 ------
 Documentation/RelNotes/1.6.0.2.txt | 6 ------
 Documentation/RelNotes/1.6.1.3.txt | 4 ----
 Documentation/RelNotes/1.6.1.4.txt | 3 ---
 Documentation/RelNotes/1.6.1.txt   | 6 ------
 6 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 86594f6..80eb06d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -24,6 +24,7 @@ SP_ARTICLES = user-manual
 SP_ARTICLES += howto/revert-branch-rebase
 SP_ARTICLES += howto/using-merge-subtree
 SP_ARTICLES += howto/using-signed-tag-in-pull-request
+RELNOTES = $(patsubst %.txt,%,$(wildcard RelNotes/*.txt))
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 API_DOCS += technical/index-format
 API_DOCS += technical/pack-format
@@ -35,6 +36,7 @@ API_DOCS += technical/racy-git
 API_DOCS += technical/send-pack-pipeline
 API_DOCS += technical/shallow
 API_DOCS += technical/trivial-merge
+API_DOCS += $(RELNOTES)
 SP_ARTICLES += $(API_DOCS)
 SP_ARTICLES += technical/api-index
 
diff --git a/Documentation/RelNotes/1.5.2.1.txt b/Documentation/RelNotes/1.5.2.1.txt
index ebf20e2..d41984d 100644
--- a/Documentation/RelNotes/1.5.2.1.txt
+++ b/Documentation/RelNotes/1.5.2.1.txt
@@ -45,9 +45,3 @@ Fixes since v1.5.2
   - git-fastimport --import-marks was broken; fixed.
 
   - A lot of documentation updates, clarifications and fixes.
-
---
-exec >/var/tmp/1
-O=v1.5.2-65-g996e2d6
-echo O=`git describe refs/heads/maint`
-git shortlog --no-merges $O..refs/heads/maint
diff --git a/Documentation/RelNotes/1.6.0.2.txt b/Documentation/RelNotes/1.6.0.2.txt
index e1e24b3..7d8fb85 100644
--- a/Documentation/RelNotes/1.6.0.2.txt
+++ b/Documentation/RelNotes/1.6.0.2.txt
@@ -79,9 +79,3 @@ Fixes since v1.6.0.1
   packfile.
 
 Also contains many documentation updates.
-
---
-exec >/var/tmp/1
-O=v1.6.0.1-78-g3632cfc
-echo O=$(git describe maint)
-git shortlog --no-merges $O..maint
diff --git a/Documentation/RelNotes/1.6.1.3.txt b/Documentation/RelNotes/1.6.1.3.txt
index 6f0bde1..cd08d81 100644
--- a/Documentation/RelNotes/1.6.1.3.txt
+++ b/Documentation/RelNotes/1.6.1.3.txt
@@ -26,7 +26,3 @@ Fixes since v1.6.1.2
 * RPM binary package installed the html manpages in a wrong place.
 
 Also includes minor documentation fixes and updates.
-
-
---
-git shortlog --no-merges v1.6.1.2-33-gc789350..
diff --git a/Documentation/RelNotes/1.6.1.4.txt b/Documentation/RelNotes/1.6.1.4.txt
index 0ce6316..ccbad79 100644
--- a/Documentation/RelNotes/1.6.1.4.txt
+++ b/Documentation/RelNotes/1.6.1.4.txt
@@ -39,6 +39,3 @@ Fixes since v1.6.1.3
   This fix was first merged to 1.6.2.3.
 
 Also includes minor documentation fixes and updates.
-
---
-git shortlog --no-merges v1.6.1.3..
diff --git a/Documentation/RelNotes/1.6.1.txt b/Documentation/RelNotes/1.6.1.txt
index adb7cca..7b152a6 100644
--- a/Documentation/RelNotes/1.6.1.txt
+++ b/Documentation/RelNotes/1.6.1.txt
@@ -278,9 +278,3 @@ release, unless otherwise noted.
 
 * "gitweb" did not mark non-ASCII characters imported from external HTML fragments
   correctly.
-
---
-exec >/var/tmp/1
-O=v1.6.1-rc3-74-gf66bc5f
-echo O=$(git describe master)
-git shortlog --no-merges $O..master ^maint
-- 
1.7.11.msysgit.1
