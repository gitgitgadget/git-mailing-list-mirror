From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/7] git-log.txt: generalize <since>..<until>
Date: Sun, 21 Apr 2013 14:20:50 +0530
Message-ID: <1366534252-12099-6-git-send-email-artagnon@gmail.com>
References: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:51:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpzS-0008Hv-Pr
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab3DUIvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:51:12 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:40611 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab3DUIvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:51:09 -0400
Received: by mail-pb0-f53.google.com with SMTP id un15so196714pbc.12
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=K3o5c76JKFm5kxJPRg1WWXJ8SINln06cv/0lybYzzWY=;
        b=x3bicYN6rn8ZehzPZxw60SJU4mbFJsItNadrggcS9aR4KmSi/ZF06w+9jC5u8UiIfG
         PKMY6q6PL/NYsqwZy7NFa+NoeG+mYlJKo2ykG8AtK1DfdSeCNvHC8FGSNpNUs651vOet
         dbdgaLVeQ1/QwnU979ZGxPAAanLjzAhGyMZjHw2RgxZR99qC3oVtWn/2K1JoESF2N+bT
         wEmhS4/qf4ntFnhNVIyGAJ07MiAUcOXLTM6eO9g1IGmX2J2bC7uY9K3p1jXDb5tLgKeg
         4glvHPZvPJvrvjTd4qk0NeYb//3TC3jl5AaHHT1bXhdjQmAEL1QijwIozij10uxwmx2e
         bsdw==
X-Received: by 10.66.154.76 with SMTP id vm12mr23204636pab.106.1366534269393;
        Sun, 21 Apr 2013 01:51:09 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id mm9sm20241909pbc.43.2013.04.21.01.51.07
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 01:51:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221932>

'<since>..<until>' is misleading, as there are many other forms that
'git log' can accept as an argument.  Replace it with <revision range>,
referring to the section "Specifying Ranges" in revisions.txt, and
rewrite the section appropriately.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-log.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 64cc337..c238475 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -9,7 +9,7 @@ git-log - Show commit logs
 SYNOPSIS
 --------
 [verse]
-'git log' [<options>] [<since>..<until>] [[\--] <path>...]
+'git log' [<options>] [<revision range>] [[\--] <path>...]
 
 DESCRIPTION
 -----------
@@ -62,12 +62,14 @@ produced by --stat etc.
 	Note that only message is considered, if also a diff is shown
 	its size is not included.
 
-<since>..<until>::
-	Show only commits between the named two commits.  When
-	either <since> or <until> is omitted, it defaults to
-	`HEAD`, i.e. the tip of the current branch.
-	For a more complete list of ways to spell <since>
-	and <until>, see linkgit:gitrevisions[7].
+<revision range>::
+	Show only commits in the specified revision range.  When no
+	<revision range> is specified, it defaults to 'HEAD' (ie. the
+	whole history leading to the current commit).  master..HEAD
+	specifies all the commits reachable from 'HEAD', but not from
+	'master'. For a complete list of ways to spell
+	<revision range>, see the "Specifying Ranges" section of
+	linkgit:gitrevisions[7].
 
 [\--] <path>...::
 	Show only commits that are enough to explain how the files
-- 
1.8.2.1.501.gd2949c7
