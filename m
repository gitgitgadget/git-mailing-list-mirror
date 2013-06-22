From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] completion: complete rebase --edit-todo
Date: Sat, 22 Jun 2013 17:23:10 +0530
Message-ID: <1371901990-10151-1-git-send-email-artagnon@gmail.com>
References: <1371888201-23675-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 13:56:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqMQi-0005D1-MA
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 13:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255Ab3FVL42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 07:56:28 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:55628 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab3FVL41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 07:56:27 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so8968035pbc.31
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 04:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IKD6ouZ2z3W5yOyoe4bjPUDDBKpjksTid2WRxIHEKwI=;
        b=WkwjKrMEAJps+qo0dzx9wpmYmCn87gVURTXNIqAzmqlnSSJfi+Z8Oitug89P4zBc60
         kSoQgp2gVipMzgftrqecG7DWMe7YA2jhlW2Jz9G7n2wh17I4vMhrVSz8/oAYwhPnhrdV
         3mKSMOLt9P3GNAZClpSgTfxIWLyY6O0Ozcl5ArRYFk0uLf2xhKy2w8onpj9XMhsqbPLz
         TeAKsQp/IFdGtwXDVy/23SjqLL7QrNhXCkz+MxmK2tA1XTSzb1HmFjN/8SBQquKumlAE
         s3Uqm+5KxkRz+c2asOlaFMVQ1UQ4nNP2KDdJ237bPscghuAxa2Dl3fp0Sjw5mFMNoU+X
         mdig==
X-Received: by 10.66.20.66 with SMTP id l2mr19884963pae.205.1371902186870;
        Sat, 22 Jun 2013 04:56:26 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id vz8sm10104983pac.20.2013.06.22.04.56.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 04:56:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.g3e7a5b4.dirty
In-Reply-To: <1371888201-23675-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228699>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6c3bafe..b51c9e3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1609,6 +1609,10 @@ _git_rebase ()
 {
 	local dir="$(__gitdir)"
 	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
+		if [ -e "$dir"/rebase-merge/interactive ]; then
+			__gitcomp "--continue --skip --abort --edit-todo"
+			return
+		fi
 		__gitcomp "--continue --skip --abort"
 		return
 	fi
-- 
1.8.3.1.487.g3e7a5b4.dirty
