From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/4] completion: add completer for rev-parse
Date: Fri, 28 Jun 2013 19:48:07 +0530
Message-ID: <1372429088-385-4-git-send-email-artagnon@gmail.com>
References: <1372429088-385-1-git-send-email-artagnon@gmail.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 28 16:21:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsZYR-0001hh-Tw
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 16:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105Ab3F1OVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 10:21:36 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:52919 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab3F1OVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 10:21:32 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so1053991pde.18
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zlwrC2uaiyG8e7D8qCgwFG8zzjSYNjMgJHZAr7QO+w0=;
        b=jBPw9ErLeeiuPNvqhXvMsBCSNcxAgkTNeHpX5oPaj4Bl+zbgOTUELCrMDhOXO3aKVN
         K/IMTrEbrZrUrsSS9+t8GB+PCCougDSzAdlqIdaDfH4P0rFprLYxhHakeEgqKGFrTSs6
         jvWgU06cSo/jSAM9cMyo8mAtUuMhUqFeLM0J293qdC69NR3BDljLUTQtKAFWHEpD4YBr
         STglD8PSKO/mlIVXkcv3q/9yheRc8IBV7uIjd4+r3yJ86DLEvWjiFSUBEVvElQs7KTik
         RYvHMW10RdB8PCHyCv261PXlhyb60ZN2RpRiQ2+NPWbYgJh0sKst2aYYka/FF15Jkhqj
         u8xw==
X-Received: by 10.66.251.202 with SMTP id zm10mr11767013pac.53.1372429292393;
        Fri, 28 Jun 2013 07:21:32 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id iq6sm8397665pbc.1.2013.06.28.07.21.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 07:21:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.585.g9832cb9
In-Reply-To: <1372429088-385-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229206>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 278018f..f2959a7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2247,6 +2247,20 @@ _git_reset ()
 	__gitcomp_nl "$(__git_refs)"
 }
 
+_git_rev_parse ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--short --show-toplevel --is-inside-work-tree
+			--symbolic-full-name --verify
+			"
+               return
+               ;;
+	esac
+	__gitcomp_nl "$(__git_refs)"
+}
+
 _git_revert ()
 {
 	case "$cur" in
-- 
1.8.3.1.585.g9832cb9
