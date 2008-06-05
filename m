From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] git-for-each-ref.txt: minor fixes
Date: Thu,  5 Jun 2008 22:54:15 +0200
Message-ID: <1212699255-26640-1-git-send-email-LeWiemann@gmail.com>
References: <7vwsl31zfq.fsf@gitster.siamese.dyndns.org>
Cc: Lea Wiemann <lewiemann@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 22:56:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MUx-00018E-MH
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762082AbYFEUyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753138AbYFEUyX
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:54:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:23823 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682AbYFEUyU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:54:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so464158fgg.17
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 13:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=p1zg2CRTuyXNVjDUrCGoKFD5ncD4Xo1rRHD1giHAGmk=;
        b=k7UjmhaZo7J7hNNZqkkPkn/ca/bdenW19het42L4T6qrihig6XamzNrGuMP6gb0NXM
         1WtH02Vr+OwUlAbCC0N87m9+sMV7toGYHx3QgyRdafdDjL4httJNOFPIcyrMgrcYBhPf
         kDDDMwbTYNyy44SOEzKp3/DQnqpK6MVlHpqh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=wgqUx4rIPFP2wThsKnhN5J5BLp6IhBVgPubqv0/YQS25lZTSQ7A/935LW6XWuSsqq1
         kXF+U38H9h9L0+Vk4yPkzZv6lTain/ixv9f5eWCM/wOfJV/axVzT7D7Hpr82UTis2ZIH
         IcHfYz8V1VsqZjNRGZBh/yoQORYcfxc+Dy05c=
Received: by 10.86.60.14 with SMTP id i14mr2813235fga.75.1212699258426;
        Thu, 05 Jun 2008 13:54:18 -0700 (PDT)
Received: from fly ( [91.33.234.84])
        by mx.google.com with ESMTPS id e11sm4215465fga.4.2008.06.05.13.54.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Jun 2008 13:54:17 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K4MTP-0006w2-Ru; Thu, 05 Jun 2008 22:54:15 +0200
X-Mailer: git-send-email 1.5.6.rc1.9.g69bbf.dirty
In-Reply-To: <7vwsl31zfq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83980>

From: Lea Wiemann <lewiemann@gmail.com>

Rewrapped synopsis and removed wrong asterisk behind --count option;
clarified --sort=<key> description for multiple keys; documented that
for-each-ref supports not only glob patterns but also prefixes like
"refs/heads" as patterns, and that multiple patterns can be given.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Junio C Hamano wrote:
> I suspect we might want to make it even more explicit that this
> is "match from the beginning"

Sure; see if you like this one (the only change since v3 is under
<pattern>) or v3 better.

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
