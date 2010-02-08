From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: [PATCH] filter-branch: Fix error message for --prune-empty --commit-filter
Date: Sun,  7 Feb 2010 18:38:01 -0800
Message-ID: <1265596681-10561-1-git-send-email-jacob.helwig@gmail.com>
References: <1265596587-9949-1-git-send-email-jacob.helwig@gmail.com>
Cc: Jacob Helwig <jacob.helwig@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 03:38:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeJVt-0006Mm-D4
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 03:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483Ab0BHCiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 21:38:08 -0500
Received: from mail-px0-f189.google.com ([209.85.216.189]:64229 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab0BHCiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 21:38:05 -0500
Received: by pxi27 with SMTP id 27so3320664pxi.4
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 18:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/qljFiC7ZQOJsd+/MnHwoR4T2iFtT6QgQ/o1XITQaJI=;
        b=Cwv+WrKT6hI0vMuPQi/7QlfxSLAAFlWe/p5H5TtCuwmBJTpOjE1htN67FURytI1rll
         Hudh93NEmhJ0F5vqpiQ0lm51x5igff8mI5Jdq60eyCb6ZQ3/27mTC1CQosgDPA6/R7YB
         RczDYYgwd+ySZwV9lpViLkTcUaCyHHG5eJigc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oHfWWjJV14vpZxjXfbgXuu3Kaih2qNBphkEruRzYA1wicIVi15vyINm6kL9BNGV+k+
         MBGtSrAKfkd0iBaGSDC/esnN+8V9BZWKo9q2CVCKLL7q6oJk1S/PpNPYSI8FgMWR04Lt
         gs4cQwRX+58xR0B5xGjwN8l1U/wllyMhF0F1E=
Received: by 10.115.65.40 with SMTP id s40mr527490wak.96.1265596684801;
        Sun, 07 Feb 2010 18:38:04 -0800 (PST)
Received: from localhost.localdomain ([96.225.220.117])
        by mx.google.com with ESMTPS id 22sm2812688pzk.14.2010.02.07.18.38.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 18:38:04 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc1.50.g8424
In-Reply-To: <1265596587-9949-1-git-send-email-jacob.helwig@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139277>

Running filter-branch with --prune-empty and --commit-filter, no longer
incorrectly reports that you had tried to run '--filter-commit' in
combination with '--prune-empty'.

Signed-off-by: Jacob Helwig <jacob.helwig@gmail.com>
---

Sorry for the re-send.  Forgot the SOB...

 git-filter-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index e95845c..88fb0f0 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -207,7 +207,7 @@ t,)
 ,*)
 	;;
 *)
-	die "Cannot set --prune-empty and --filter-commit at the same time"
+	die "Cannot set --prune-empty and --commit-filter at the same time"
 esac
 
 case "$force" in
-- 
1.7.0.rc1.50.g8424
