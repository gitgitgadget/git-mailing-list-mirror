From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v5] git-for-each-ref.txt: minor improvements
Date: Thu,  5 Jun 2008 23:01:38 +0200
Message-ID: <1212699698-26935-1-git-send-email-LeWiemann@gmail.com>
References: <1212699255-26640-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 23:02:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MbY-0003Sz-0X
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 23:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbYFEVBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 17:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbYFEVBp
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 17:01:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:38014 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYFEVBo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 17:01:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so465925fgg.17
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=TzPKpdyMc+hKOQUaGMPSAmnLFkiaLbKLvVn8tplds9U=;
        b=mY8UVk4deMGcQPlK0NVpxk8fAAz46DUIX2gKWZbvVmF+r7Qqm+xIp3l2CWcCZ9lh1t
         xeywHAW3KD1oSdxoDgKySoEtKNs3ONOXDWa6IZ7QRS72LlbB+OYT5h4LUNgF6En5B+a3
         lp1dp+QuDRTBHmcpYEYvaqH8OXESx8mLE8nmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=Vue2SrjZvv5Jf0OcrguvW4hs30fmlhu3Vptn+wA55uVeyfJTb4JTgU61rpOFFm5u3O
         XPZxrDrGYsM8L/+dLi4lJPbEVQVkbhs24IJLpqmBv6PbjdiRCyRVBL70k2zVJ1O+mUWX
         R0JZYw5sHhsx6NE3TxE4H64+r1qAIA+fHqsR8=
Received: by 10.86.70.8 with SMTP id s8mr2865941fga.31.1212699701056;
        Thu, 05 Jun 2008 14:01:41 -0700 (PDT)
Received: from fly ( [91.33.234.84])
        by mx.google.com with ESMTPS id l12sm4217193fgb.6.2008.06.05.14.01.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Jun 2008 14:01:40 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K4MaY-00070z-Lt; Thu, 05 Jun 2008 23:01:38 +0200
X-Mailer: git-send-email 1.5.6.rc1.9.g69bbf.dirty
In-Reply-To: <1212699255-26640-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83982>

Rewrapped synopsis and removed wrong asterisk behind --count option;
clarified --sort=<key> description for multiple keys; documented that
for-each-ref supports not only glob patterns but also prefixes like
"refs/heads" as patterns, and that multiple patterns can be given.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
... and fixed the subject line.  Sorry for spamming the list!

 Documentation/git-for-each-ref.txt |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f1f90cc..87c8389 100644
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
@@ -48,9 +48,10 @@ OPTIONS
 	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
 
 <pattern>::
-	If given, the name of the ref is matched against this
-	using fnmatch(3).  Refs that do not match the pattern
-	are not shown.
+	If one or more patterns are given, only refs are shown that
+	match againt at least one pattern, either using fnmatch(3) or
+	literally, in the latter case matching completely or from the
+	beginning up to a slash.
 
 --shell, --perl, --python, --tcl::
 	If given, strings that substitute `%(fieldname)`
-- 
1.5.6.rc1.9.g69bbf.dirty
