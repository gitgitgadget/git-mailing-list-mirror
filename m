From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch 2/5] Create html documents for all files in
 Documentation/technical
Date: Sat, 6 Oct 2012 17:55:06 +0200 (CEST)
Message-ID: <652323221.269712.1349538906380.JavaMail.ngmail@webmail08.arcor-online.net>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker66@arcor.de
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 17:55:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKWin-0003JJ-O1
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 17:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943Ab2JFPzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 11:55:11 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:55164 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755869Ab2JFPzK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 11:55:10 -0400
Received: from mail-in-20-z2.arcor-online.net (mail-in-20-z2.arcor-online.net [151.189.8.85])
	by mx.arcor.de (Postfix) with ESMTP id 6CAB03AECC2
	for <git@vger.kernel.org>; Sat,  6 Oct 2012 17:55:06 +0200 (CEST)
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net [151.189.21.57])
	by mail-in-20-z2.arcor-online.net (Postfix) with ESMTP id 646FE6FA4FE;
	Sat,  6 Oct 2012 17:55:06 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 56251CC4F1;
	Sat,  6 Oct 2012 17:55:06 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-17.arcor-online.net 56251CC4F1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349538906; bh=F/4YGABfxVvsowkwDr3izs4pGZ0HgfNY/yyVw57i2yY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=r5UpRTpYhJ0zq4+N5a7b24RCks4Z7JQwyBGBHFLYB72oSpRZ1HgqdtUSI3/vfhHu1
	 LRGs53WN+evFr5eOVX05SNct/NAI/f/Di0a+Na4bh/hYTGlMLEai968GdtHushwp+f
	 fDuJkowEGxEjG/Am4t4RB8dlDWQn0YCY/u3ELZmg=
Received: from [94.217.29.222] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 6 Oct 2012 17:55:06 +0200 (CEST)
In-Reply-To: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.29.222
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207153>

- add missing files
- fix some asciidoc layout problems

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/Makefile                    | 12 ++++++++++-
 Documentation/technical/index-format.txt  |  2 +-
 Documentation/technical/pack-format.txt   |  8 +++----
 Documentation/technical/pack-protocol.txt |  7 +++---
 Documentation/technical/shallow.txt       |  8 ++++++-
 Documentation/technical/trivial-merge.txt | 36 +++++++++++++++----------------
 6 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 267dfe1..86594f6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -25,6 +25,16 @@ SP_ARTICLES += howto/revert-branch-rebase
 SP_ARTICLES += howto/using-merge-subtree
 SP_ARTICLES += howto/using-signed-tag-in-pull-request
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
+API_DOCS += technical/index-format
+API_DOCS += technical/pack-format
+API_DOCS += technical/pack-heuristics
+API_DOCS += technical/pack-protocol
+API_DOCS += technical/protocol-capabilities
+API_DOCS += technical/protocol-common
+API_DOCS += technical/racy-git
+API_DOCS += technical/send-pack-pipeline
+API_DOCS += technical/shallow
+API_DOCS += technical/trivial-merge
 SP_ARTICLES += $(API_DOCS)
 SP_ARTICLES += technical/api-index
 
@@ -231,7 +241,7 @@ clean:
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
 	$(RM) *.pdf
 	$(RM) howto-index.txt howto/*.html doc.dep
-	$(RM) technical/api-*.html technical/api-index.txt
+	$(RM) technical/*.html technical/api-index.txt
 	$(RM) $(cmds_txt) *.made
 	$(RM) manpage-base-url.xsl
 
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 9d25b30..57d6f91 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -1,7 +1,7 @@
 GIT index format
 ================
 
-= The git index file has the following format
+== The git index file has the following format
 
   All binary numbers are in network byte order. Version 2 is described
   here unless stated otherwise.
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 1803e64..a7871fb 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -1,7 +1,7 @@
 GIT pack format
 ===============
 
-= pack-*.pack files have the following format:
+== pack-*.pack files have the following format:
 
    - A header appears at the beginning and consists of the following:
 
@@ -34,7 +34,7 @@ GIT pack format
 
   - The trailer records 20-byte SHA1 checksum of all of the above.
 
-= Original (version 1) pack-*.idx files have the following format:
+== Original (version 1) pack-*.idx files have the following format:
 
   - The header consists of 256 4-byte network byte order
     integers.  N-th entry of this table records the number of
@@ -123,8 +123,8 @@ Pack file entry: <+
 
 
 
-= Version 2 pack-*.idx files support packs larger than 4 GiB, and
-  have some other reorganizations.  They have the format:
+== Version 2 pack-*.idx files support packs larger than 4 GiB, and
+   have some other reorganizations.  They have the format:
 
   - A 4-byte magic number '\377tOc' which is an unreasonable
     fanout[0] value.
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index d51e20f..25e1fbe 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -117,7 +117,7 @@ A few things to remember here:
 - The repository path is always quoted with single quotes.
 
 Fetching Data From a Server
-===========================
+---------------------------
 
 When one Git repository wants to get data that a second repository
 has, the first can 'fetch' from the second.  This operation determines
@@ -134,7 +134,8 @@ with the object name that each reference currently points to.
 
    $ echo -e -n "0039git-upload-pack /schacon/gitbook.git\0host=example.com\0" |
       nc -v example.com 9418
-   00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow no-progress include-tag
+   00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack thin-pack 
+                side-band side-band-64k ofs-delta shallow no-progress include-tag
    00441d3fcd5ced445d1abc402225c0b8a1299641f497 refs/heads/integration
    003f7217a7c7e582c46cec22a130adf4b9d7d950fba0 refs/heads/master
    003cb88d2441cac0977faf98efc80305012112238d9d refs/tags/v0.9
@@ -421,7 +422,7 @@ entire packfile without multiplexing.
 
 
 Pushing Data To a Server
-========================
+------------------------
 
 Pushing data to a server will invoke the 'receive-pack' process on the
 server, which will allow the client to tell it which references it should
diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 559263a..0502a54 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -1,6 +1,12 @@
-Def.: Shallow commits do have parents, but not in the shallow
+Shallow commits
+===============
+
+.Definition
+*********************************************************
+Shallow commits do have parents, but not in the shallow
 repo, and therefore grafts are introduced pretending that
 these commits have no parents.
+*********************************************************
 
 The basic idea is to write the SHA1s of shallow commits into
 $GIT_DIR/shallow, and handle its contents like the contents
diff --git a/Documentation/technical/trivial-merge.txt b/Documentation/technical/trivial-merge.txt
index 24c8410..c79d4a7 100644
--- a/Documentation/technical/trivial-merge.txt
+++ b/Documentation/technical/trivial-merge.txt
@@ -74,24 +74,24 @@ For multiple ancestors, a '+' means that this case applies even if
 only one ancestor or remote fits; a '^' means all of the ancestors
 must be the same.
 
-case  ancest    head    remote    result
-----------------------------------------
-1     (empty)+  (empty) (empty)   (empty)
-2ALT  (empty)+  *empty* remote    remote
-2     (empty)^  (empty) remote    no merge
-3ALT  (empty)+  head    *empty*   head
-3     (empty)^  head    (empty)   no merge
-4     (empty)^  head    remote    no merge
-5ALT  *         head    head      head
-6     ancest+   (empty) (empty)   no merge
-8     ancest^   (empty) ancest    no merge
-7     ancest+   (empty) remote    no merge
-10    ancest^   ancest  (empty)   no merge
-9     ancest+   head    (empty)   no merge
-16    anc1/anc2 anc1    anc2      no merge
-13    ancest+   head    ancest    head
-14    ancest+   ancest  remote    remote
-11    ancest+   head    remote    no merge
+ case  ancest    head    remote    result
+ ----------------------------------------
+ 1     (empty)+  (empty) (empty)   (empty)
+ 2ALT  (empty)+  *empty* remote    remote
+ 2     (empty)^  (empty) remote    no merge
+ 3ALT  (empty)+  head    *empty*   head
+ 3     (empty)^  head    (empty)   no merge
+ 4     (empty)^  head    remote    no merge
+ 5ALT  *         head    head      head
+ 6     ancest+   (empty) (empty)   no merge
+ 8     ancest^   (empty) ancest    no merge
+ 7     ancest+   (empty) remote    no merge
+ 10    ancest^   ancest  (empty)   no merge
+ 9     ancest+   head    (empty)   no merge
+ 16    anc1/anc2 anc1    anc2      no merge
+ 13    ancest+   head    ancest    head
+ 14    ancest+   ancest  remote    remote
+ 11    ancest+   head    remote    no merge
 
 Only #2ALT and #3ALT use *empty*, because these are the only cases
 where there can be conflicts that didn't exist before. Note that we
-- 
1.7.11.msysgit.1
