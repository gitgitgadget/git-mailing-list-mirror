From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/7] git-log.txt: generalize <since>..<until>
Date: Mon, 22 Apr 2013 11:00:28 +0530
Message-ID: <1366608631-21734-5-git-send-email-artagnon@gmail.com>
References: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 07:30:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU9L3-0005j7-2e
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 07:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab3DVFaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 01:30:46 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:46131 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab3DVFao (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 01:30:44 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so2897558dan.33
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 22:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=z73i02TCZjrD5y0+4AevXQ98ZCuSuiA2+hEBi9aVlrA=;
        b=im9Frm3QrtEeT3vjLiCi9aY0ymQcWRloIF0BxwGQilYMi/UMg6a/Rcx3VOIxtc/gTX
         BdOXrZvpF+WPHhVVbdp6TNEQUgxvXZz8/6eNVK9pE1Zh6slputTgTZ6GIrX3e3UKvqon
         OqAsWRsOhEtYD/cC/378bfP3oK4+UDx9x5s99wJ+n3YT7lro8mzOMJblcdZotNcQnkV6
         w995W2Ueu/aGMSbicP493jL4YhHlkfpPjSPdN03vff/v5iTJLCJMjIFfqflumYahEYS2
         AYvwfUBQOSU/PWbQPTB6zBqW1YsXtHp1uolDkR+Wca1/yJUno4K5aBH5cgbbYUkDvrmS
         hBog==
X-Received: by 10.66.232.196 with SMTP id tq4mr10981093pac.167.1366608644294;
        Sun, 21 Apr 2013 22:30:44 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id em2sm11144653pbb.0.2013.04.21.22.30.42
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 22:30:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221990>

'<since>..<until>' is misleading, as there are many other forms that
'git log' can accept as an argument.  Replace it with <revision range>,
referring to the section "Specifying Ranges" in revisions.txt, and
rewrite the section appropriately.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-log.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 64cc337..9576695 100644
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
+	<revision range> is specified, it defaults to `HEAD` (i.e. the
+	whole history leading to the current commit).  `origin..HEAD`
+	specifies all the commits reachable from the current commit
+	(i.e. `HEAD`), but not from `origin`. For a complete list of
+	ways to spell <revision range>, see the "Specifying Ranges"
+	section of linkgit:gitrevisions[7].
 
 [\--] <path>...::
 	Show only commits that are enough to explain how the files
-- 
1.8.2.1.501.gd2949c7
