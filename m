From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH] MSVC: allow enabling CURL
Date: Thu, 27 Mar 2014 11:34:27 +0400
Message-ID: <1395905668-32005-1-git-send-email-marat@slonopotamus.org>
Cc: Marat Radchenko <marat@slonopotamus.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 08:58:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT5D7-0007gi-R2
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 08:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbaC0H6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 03:58:22 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:51965 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbaC0H6T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 03:58:19 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WT4po-0000m9-4L; Thu, 27 Mar 2014 11:34:44 +0400
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245265>

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/vcbuild/scripts/clink.pl | 2 ++
 config.mak.uname                | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index 4374771..a87d0da 100755
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -33,6 +33,8 @@ while (@ARGV) {
 		push(@args, "libeay32.lib");
 	} elsif ("$arg" eq "-lssl") {
 		push(@args, "ssleay32.lib");
+	} elsif ("$arg" eq "-lcurl") {
+		push(@args, "libcurl.lib");
 	} elsif ("$arg" =~ /^-L/ && "$arg" ne "-LTCG") {
 		$arg =~ s/^-L/-LIBPATH:/;
 		push(@args, $arg);
diff --git a/config.mak.uname b/config.mak.uname
index 6069a44..cfc2a93 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -340,7 +340,6 @@ ifeq ($(uname_S),Windows)
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
-	NO_CURL = YesPlease
 	NO_GETTEXT = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
-- 
1.9.1
