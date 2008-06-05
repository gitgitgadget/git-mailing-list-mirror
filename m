From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v2] git-for-each-ref.txt: minor improvements
Date: Thu,  5 Jun 2008 15:38:34 +0200
Message-ID: <1212673114-15751-1-git-send-email-LeWiemann@gmail.com>
References: <1212664752-12160-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <lewiemann@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 15:39:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Fgj-0008Qj-W1
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 15:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241AbYFENil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 09:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754185AbYFENil
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 09:38:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:44637 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbYFENik (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 09:38:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so366147fgg.17
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=A7Roas86DIFh/dzueXHmRsJyvKOYzYJ+gujAaBN0aV0=;
        b=ApIKGYwg6LtOe7g5VNsiz+3+4xBa2loneegUTfxKehEFgeyzehFG0+LpIq0sYp6Y2z
         tVoFNpagt3oWFlwPVo7FNVuv5S6skK+G+CudqUxyQ8Mmeuw1Oar/6JC8VBXQAZ4hQAI+
         MFDJQnUUrtCxUW+J3RYudrwnSBMYlkGGmv694=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=JYt5XbgDkiP8+ZUnkhblFdkhKvXStmZSxQlCwpWnJfbEX/peiH+pI1+eUU7wPD1JJD
         cNKBi6DSeohZrHEyrkYXJYXwztDUfOA9ORPQwW6BlR1JdtvHVO+HfZV/ZvlfDFpQsWnP
         ZXOjRFNCSKEOjG5Bme/vik2M046GsdWLtDffo=
Received: by 10.86.73.3 with SMTP id v3mr2092908fga.68.1212673119091;
        Thu, 05 Jun 2008 06:38:39 -0700 (PDT)
Received: from fly ( [91.33.197.196])
        by mx.google.com with ESMTPS id e11sm3495822fga.4.2008.06.05.06.38.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Jun 2008 06:38:38 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K4Ffm-00046P-B2; Thu, 05 Jun 2008 15:38:34 +0200
X-Mailer: git-send-email 1.5.6.rc1.9.g69bbf.dirty
In-Reply-To: <1212664752-12160-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83931>

From: Lea Wiemann <lewiemann@gmail.com>

Rewrapped synopsis and removed wrong asterisk behind --count option;
clarified --sort=<key> description for multiple keys; documented that
for-each-ref supports not only glob patterns but also prefixes like
"refs/heads" as patterns.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Added more fixes/improvements since v1.

 Documentation/git-for-each-ref.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f1f90cc..4ffc65f 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -8,8 +8,7 @@ git-for-each-ref - Output information on each ref
 SYNOPSIS
 --------
 [verse]
-'git-for-each-ref' [--count=<count>]\*
-                   [--shell|--perl|--python|--tcl]
+'git-for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
                    [--sort=<key>]\* [--format=<format>] [<pattern>]
 
 DESCRIPTION
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
+	If given, only refs are shown that match againt the pattern
+	either using fnmatch(3) or literally, in the latter case up to
+	a slash or entirely.
 
 --shell, --perl, --python, --tcl::
 	If given, strings that substitute `%(fieldname)`
-- 
1.5.6.rc1.9.g69bbf.dirty
