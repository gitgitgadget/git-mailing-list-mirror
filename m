From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/4] gitweb: Correct typo: '==' instead of 'eq' in git_difftree_body
Date: Mon, 4 Sep 2006 18:19:58 +0200
Message-ID: <200609041819.58737.jnareb@gmail.com>
References: <200609041810.09838.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 04 18:37:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKHRa-0002bY-6k
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 18:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWIDQhA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 12:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWIDQhA
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 12:37:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:9700 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751475AbWIDQg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 12:36:58 -0400
Received: by nz-out-0102.google.com with SMTP id n1so855142nzf
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 09:36:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bsOjR4gtjRrD8pwaWfzV+ANxNCCaQz/6jWyl5aWhVCq281CiJy5rPR7ntJGyYLLoIFsrx0VvxP4ymOX9ExFJIPITcMVTpduOcGfxT/pI7bNGEioUSr53STmEHTjpA+6rJaHtymZPvwf75tbjFkduJsGOFPyUnJlh4MeuJZSkqX0=
Received: by 10.65.232.12 with SMTP id j12mr3504466qbr;
        Mon, 04 Sep 2006 09:36:58 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id c5sm3859928qbc.2006.09.04.09.36.57;
        Mon, 04 Sep 2006 09:36:58 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609041810.09838.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26423>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This caused that the "commitdiff" version, with "patch" link to anchor
instead of "diff" link to "blobdiff" view was used even in "commit" view.

 gitweb/gitweb.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4240a30..e7d7bd7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1519,7 +1519,7 @@ sub git_difftree_body {
 			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff{'file'})},
 			              "blob");
-			if ($action == "commitdiff") {
+			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
 				print " | " .
@@ -1540,7 +1540,7 @@ sub git_difftree_body {
 			                             hash_base=>$parent, file_name=>$diff{'file'})},
 			              "blob") .
 			      " | ";
-			if ($action == "commitdiff") {
+			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
 				print " | " .
@@ -1586,7 +1586,7 @@ sub git_difftree_body {
 			                             hash_base=>$hash, file_name=>$diff{'file'})},
 			              "blob");
 			if ($diff{'to_id'} ne $diff{'from_id'}) { # modified
-				if ($action == "commitdiff") {
+				if ($action eq 'commitdiff') {
 					# link to patch
 					$patchno++;
 					print " | " .
@@ -1628,7 +1628,7 @@ sub git_difftree_body {
 			                             hash=>$diff{'to_id'}, file_name=>$diff{'to_file'})},
 			              "blob");
 			if ($diff{'to_id'} ne $diff{'from_id'}) {
-				if ($action == "commitdiff") {
+				if ($action eq 'commitdiff') {
 					# link to patch
 					$patchno++;
 					print " | " .
-- 
1.4.1.1
