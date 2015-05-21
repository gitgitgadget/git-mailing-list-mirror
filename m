From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] doc: fix inconsistent spelling of "packfile"
Date: Thu, 21 May 2015 09:27:05 +0200
Message-ID: <1432193225-3502-1-git-send-email-ps@pks.im>
References: <xmqqr3qaledb.fsf@gitster.dls.corp.google.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 09:27:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvKtT-0000P5-IO
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 09:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbbEUH1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 03:27:47 -0400
Received: from sender1.zohomail.com ([74.201.84.157]:24425 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbEUH1q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 03:27:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=eGOGTXGU6OuOpX4ZIlg7pW9zjB6jTdjY8UxUvzez0RcKDwv080S86l6NNs6G3e4g0rkNMP9BVBQj
    nyUHqiT0PLntShlzPhCjQrBI36e6ohY0rBr7Z+UHCAr3y5FeTrLDpghASWIUg9PLy27je5VKYEhi
    W5C+dlYuAkhqqzQrHos=  
Received: from localhost (x55b3850b.dyn.telefonica.de [85.179.133.11]) by mx.zohomail.com
	with SMTPS id 1432193263041432.1117025650791; Thu, 21 May 2015 00:27:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
In-Reply-To: <xmqqr3qaledb.fsf@gitster.dls.corp.google.com>
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT  SGR3_0_08055_4
X-ZohoMail-Owner: <1432193225-3502-1-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 85.179.133.11
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269565>

Fix remaining instances where "pack-file" is used instead of
"packfile".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
This patch now also fixes instances where we refer to EBNF-style
command line parameters, as discussed by Junio and Peff.

 Documentation/git-index-pack.txt          | 10 +++++-----
 Documentation/git-unpack-objects.txt      |  2 +-
 Documentation/technical/pack-protocol.txt |  4 ++--
 Documentation/user-manual.txt             |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 7a4e055..49621da 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -9,9 +9,9 @@ git-index-pack - Build pack index file for an existing packed archive
 SYNOPSIS
 --------
 [verse]
-'git index-pack' [-v] [-o <index-file>] <pack-file>
+'git index-pack' [-v] [-o <index-file>] <packfile>
 'git index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>]
-                 [<pack-file>]
+		  [<packfile>]
 
 
 DESCRIPTION
@@ -37,11 +37,11 @@ OPTIONS
 
 --stdin::
 	When this flag is provided, the pack is read from stdin
-	instead and a copy is then written to <pack-file>. If
-	<pack-file> is not specified, the pack is written to
+	instead and a copy is then written to <packfile>. If
+	<packfile> is not specified, the pack is written to
 	objects/pack/ directory of the current Git repository with
 	a default name determined from the pack content.  If
-	<pack-file> is not specified consider using --keep to
+	<packfile> is not specified consider using --keep to
 	prevent a race condition between this process and
 	'git repack'.
 
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 894d20b..07d4329 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -9,7 +9,7 @@ git-unpack-objects - Unpack objects from a packed archive
 SYNOPSIS
 --------
 [verse]
-'git unpack-objects' [-n] [-q] [-r] [--strict] < <pack-file>
+'git unpack-objects' [-n] [-q] [-r] [--strict] < <packfile>
 
 
 DESCRIPTION
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 812d857..fc09c63 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -465,7 +465,7 @@ contain all the objects that the server will need to complete the new
 references.
 
 ----
-  update-request    =  *shallow ( command-list | push-cert ) [pack-file]
+  update-request    =  *shallow ( command-list | push-cert ) [packfile]
 
   shallow           =  PKT-LINE("shallow" SP obj-id LF)
 
@@ -491,7 +491,7 @@ references.
 		      *PKT-LINE(gpg-signature-lines LF)
 		      PKT-LINE("push-cert-end" LF)
 
-  pack-file         = "PACK" 28*(OCTET)
+  packfile          = "PACK" 28*(OCTET)
 ----
 
 If the receiving end does not support delete-refs, the sending end MUST
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 68978f5..7147519 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3164,7 +3164,7 @@ objects.  (Note that linkgit:git-tag[1] can also be used to create
 "lightweight tags", which are not tag objects at all, but just simple
 references whose names begin with `refs/tags/`).
 
-[[pack-files]]
+[[packfiles]]
 How Git stores objects efficiently: pack files
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.4.1
