From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] completion: add deprecated __git_complete_file ()
Date: Sat,  8 Jun 2013 00:39:28 +0530
Message-ID: <1370632168-25298-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:11:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul24f-0008Pr-Az
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757079Ab3FGTLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:11:41 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:49068 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576Ab3FGTLk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:11:40 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so2285424pdi.16
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=5V13UGdiyjs/uD3+TgR5j45EqlhvPOvGar5ZXE03zks=;
        b=zT4WhdJgLB3cT5J3Q7tFdj6818OZtW7rSs7zRrmfDqjTqzOZHA3G6/fh9lkgEEhWrJ
         nFHFbKcvgoRFzlx+pnKk0ik4CV4zdeRyzaI5vIWkdAOQS4qG1Hbrv4GX/4R5EQ8mWz2a
         KvrEkfgrJbOE+M+bjleGacxqiwxdwWu8++NIUt73F0WWzo8Wb8nag57tiPoot4ovlQCA
         i3KnVFz5mHQDGSB65UcWNDkpNdY6dmTvFdJvqtARzp3V6hUVmlOmmDG7aAx/N5O71m8k
         rqWjp/WzDwe/3oIO5Afu/90ZWRVBY6X869I1ykcj9+6YwnR+nq4EnQCLOOG41GOXzGmL
         IPGw==
X-Received: by 10.66.145.67 with SMTP id ss3mr4274648pab.18.1370632300229;
        Fri, 07 Jun 2013 12:11:40 -0700 (PDT)
Received: from localhost.localdomain ([122.164.162.188])
        by mx.google.com with ESMTPSA id xz1sm4378337pab.5.2013.06.07.12.11.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 12:11:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.244.g98dd9db.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226676>

77c130 (completion: clarify ls-tree, archive, show completion,
2013-06-02) removed __git_complete_file () because it had no callers
left in the file.  However, to avoid breaking user scripts that may
depend on this, add it back as a deprecated alias.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Based on pu.

 contrib/completion/git-completion.bash | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d0a9ba4..0fb81c9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -489,6 +489,11 @@ __git_complete_revlist_file ()
 	esac
 }
 
+# no callers; deprecated alias
+__git_complete_file ()
+{
+	__git_complete_revlist_file
+}
 
 # __git_complete_index_file requires 1 argument:
 # 1: the options to pass to ls-file
-- 
1.8.3.244.g98dd9db.dirty
