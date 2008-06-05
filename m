From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v3] git-for-each-ref.txt: minor improvements
Date: Thu,  5 Jun 2008 20:40:05 +0200
Message-ID: <1212691205-24399-1-git-send-email-LeWiemann@gmail.com>
References: <1212673114-15751-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <lewiemann@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 20:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4KPD-0007uV-M9
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 20:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126AbYFESkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 14:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759228AbYFESkl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 14:40:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:31924 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbYFESkk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 14:40:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so434107fgg.17
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=L+SfUq0VLMkMC9KdaKHdutneEkMHebq58tIvOIhBtAE=;
        b=lQHDIuyx3gIieqN4X+rMA82ABZnG9qtFAY/HW1aqW/Hccmr1G03zACPKSm+4MCEDRv
         Clr1jTumuZIJRRJn6uOJCbh8ijpzg5MpkDvpEEKUcXZbTMTXw9HXRHJaBC9PgXUfvodY
         PwOWUQAoSFuojKm/1tEWYoRDyjp5f1gKECV/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=pBFN2gnSrYvcTVpHhNCoFwrity/n3THnH30ftJIAyFvmoU+IaP2HL7HF5uJAShwqwT
         gvYE8O+hNFn3o1DAU1jP3SfcuNfPUqxis0Reo+v7qekTY6SOMtUNrqr2buw0ANebQlV1
         z9NYb+eIqiaFGBGCZ58t9mmYBNurD4+ehNkYk=
Received: by 10.86.87.13 with SMTP id k13mr2697985fgb.1.1212691237665;
        Thu, 05 Jun 2008 11:40:37 -0700 (PDT)
Received: from fly ( [91.33.234.84])
        by mx.google.com with ESMTPS id 12sm7545617fks.13.2008.06.05.11.40.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Jun 2008 11:40:07 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K4KNZ-0006MR-5L; Thu, 05 Jun 2008 20:40:05 +0200
X-Mailer: git-send-email 1.5.6.rc1.9.g69bbf.dirty
In-Reply-To: <1212673114-15751-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83954>

From: Lea Wiemann <lewiemann@gmail.com>

Rewrapped synopsis and removed wrong asterisk behind --count option;
clarified --sort=<key> description for multiple keys; documented that
for-each-ref supports not only glob patterns but also prefixes like
"refs/heads" as patterns, and that multiple patterns can be given.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Changed since v2: Also document that multiple patterns can be given.

 Documentation/git-for-each-ref.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f1f90cc..2ff4c2d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -8,9 +8,8 @@ git-for-each-ref - Output information on each ref
 SYNOPSIS
 --------
 [verse]
-'git-for-each-ref' [--count=<count>]\*
-                   [--shell|--perl|--python|--tcl]
-                   [--sort=<key>]\* [--format=<format>] [<pattern>]
+'git-for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
+                   [--sort=<key>]\* [--format=<format>] [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -32,8 +31,9 @@ OPTIONS
 <key>::
 	A field name to sort on.  Prefix `-` to sort in
 	descending order of the value.  When unspecified,
-	`refname` is used.  More than one sort keys can be
-	given.
+	`refname` is used.  You may use the --sort=<key> option
+	multiple times, in which case the last key becomes the primary
+	key.
 
 <format>::
 	A string that interpolates `%(fieldname)` from the
@@ -48,9 +48,9 @@ OPTIONS
 	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
 
 <pattern>::
-	If given, the name of the ref is matched against this
-	using fnmatch(3).  Refs that do not match the pattern
-	are not shown.
+	If one or more patterns are given, only refs are shown that
+	match againt at least one pattern, either using fnmatch(3) or
+	literally, in the latter case up to a slash or entirely.
 
 --shell, --perl, --python, --tcl::
 	If given, strings that substitute `%(fieldname)`
-- 
1.5.6.rc1.9.g69bbf.dirty
