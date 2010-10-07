From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] Documentation: update-index: -z applies also to --index-info
Date: Thu,  7 Oct 2010 15:23:17 +0200
Message-ID: <d3f7e6795adeccbf7746547842d6b65732d568eb.1286457739.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org,
	=?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 15:28:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3qWd-0005Xs-BZ
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 15:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760581Ab0JGNXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 09:23:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47291 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab0JGNXW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 09:23:22 -0400
Received: by fxm4 with SMTP id 4so320631fxm.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=QhoVM3tVR6tqopztEc+pAvvmzhhJp+AnkYNYzH6KXaY=;
        b=ngLWRIhAclMgbjgaqQuhDuZ6SkqqDVGqXEn50D3iESXZEJMDD8w1KP4aN2eqK+FEIr
         c2Ze7iUKidGfcPBRZLFyQiZhh3etDgJGjMnTbJ5E4ZnXQpmTPa1MQipWKSIWYg6wcXAn
         OJNAqUOGmwUtc45zpNfS5piCKauJgKVGgu8jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=eoRAv1Ogns5krZvhYnYGRr9yPuN6U86QjZE0Bc8ZQrUs5heqC+oEL2ebd5Rgv+TGtu
         q20Vfry6WUpw/TUgKt90UXHe2EMnvqpmB0Kl86jfd3FBw95+LFChLEQJ6Tu9dgZXVcq/
         NxVdPVkK7GN6a1NOSLI6kXy1OigYtV4Qz1vSU=
Received: by 10.223.114.139 with SMTP id e11mr1003830faq.68.1286457800518;
        Thu, 07 Oct 2010 06:23:20 -0700 (PDT)
Received: from localhost (p5B0F784F.dip.t-dialin.net [91.15.120.79])
        by mx.google.com with ESMTPS id j14sm1008976faa.23.2010.10.07.06.23.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 06:23:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158398>

Also mention, that --stdin and --index-info needs to be the last
option supplied and indicate this in the usage string.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

We may like the usage string like this:

[[-z] --stdin | --index-info]

to make it also clear, that -z applies only to --stdin or --index-only.
---
 Documentation/git-update-index.txt |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 74d1d49..4441d7c 100644 Documentation/git-update-index.txt
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -18,8 +18,9 @@ SYNOPSIS
 	     [--skip-worktree | --no-skip-worktree]
 	     [--ignore-submodules]
 	     [--really-refresh] [--unresolve] [--again | -g]
-	     [--info-only] [--index-info]
-	     [-z] [--stdin]
+	     [--info-only]
+	     [-z]
+	     [--stdin] [--index-info]
 	     [--verbose]
 	     [--] [<file>]*
 
@@ -72,7 +73,7 @@ OPTIONS
 	Directly insert the specified info into the index.
 
 --index-info::
-        Read index information from stdin.
+        Read index information from stdin (Must be last option).
 
 --chmod=(+|-)x::
         Set the execute permissions on the updated files.
@@ -138,14 +139,15 @@ you will need to handle the situation manually.
 --stdin::
 	Instead of taking list of paths from the command line,
 	read list of paths from the standard input.  Paths are
-	separated by LF (i.e. one path per line) by default.
+	separated by LF (i.e. one path per line) by default
+	(Must be last option).
 
 --verbose::
         Report what is being added and removed from index.
 
 -z::
-	Only meaningful with `--stdin`; paths are separated with
-	NUL character instead of LF.
+	Only meaningful with `--stdin` or `--index-info`; paths are
+	separated with NUL character instead of LF.
 
 \--::
 	Do not interpret any more arguments as options.
-- 
1.7.1.1067.g5aeb7
