Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940F3624B8
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160289; cv=none; b=QlPKBclK4Cv1JyCCFwVKOawQ9QYOax2+bbpyd4V7GDX7Ia+RGT7sURxdnOHdIIdFVSLSWgAlBN8YoV5OrfdtbQtfX6nzvhAyNkkBZtqMB5fYwTfIVIO7c31n75TprMVGpLKfk3zPnKQfZCh/Tve/pNczsTUt//BXQgMpAfSx2kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160289; c=relaxed/simple;
	bh=eWaV0FVRXfhEyQRWtGtRPTxwTnaqjewwFvIvEMOD5wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7kBPUxelRD8WiDSWhWC4pdagPRl85k2o6+0x+NpP+iGJer57BbX96vp65A53U5uJTfVIM+a/KBUZVXW2wjdawBYv+A/9M0k/hc0bVT+WqFBb0D4CtrL9M82f+3V6F1Oy1oCaValouZf9MUeMDrFh5m5sIgpIvkNoxAe+Xp/22g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lYzFiFkp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kK1eUr+J; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lYzFiFkp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kK1eUr+J"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CD8EB1D0011B;
	Thu, 11 Jun 2026 02:44:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 02:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781160287;
	 x=1781246687; bh=6RQgDuL1lka1VG0REOorcBlJ9lAIxPLVc8wxaJ3SheE=; b=
	lYzFiFkpuq0BEIe/P4T+Cmf0jezmhq6DQ3IkZiUmLHaGSUG3H6dh6RW9PR2ueXes
	h2MjbQv4eQCmPKUXRoP3YYudvrNmPDlicsXRcTXx26uuKpObBojjC7qSLj/Aa18O
	olhmUVnh1XFgL9qjE8SfiVljEFCmj2C1rgwg63iIRifF44Nxn8ORY8tp+ZiIEP1g
	Spq1ltPWDlle/E4ZgyHiPc3Wqud309W9H5YIezVuAcpng4+3SWZDgDcoMUt+zPF5
	S0DVj/b4U6lSHIasp8IiForIij+F6JVCpKUN8xFsPGluyYIE/CrTuqVeWHvVwzCC
	v7SIvVNxJw8mnpA+dK4A9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781160287; x=
	1781246687; bh=6RQgDuL1lka1VG0REOorcBlJ9lAIxPLVc8wxaJ3SheE=; b=k
	K1eUr+Ju8eYnc71sv9Whbt/Fz3A0Qlx67MK1koX2/wA+WB/pBSqbRV28jCEEk3xM
	xIR+kloQNWzN/duQ3ZPdzSFZi3nguO/UQosdvY0xdz57O9NYV7rV5hR1FZd/UdXV
	vCyBleI/knwSNp0UCi0UIslGk+RcAILOSsMmZYVH0bDW2jhn3X1AAJ/mGZ6OthLz
	hj2fE7b+HdEDlguUWTDDPXS23Infw4XBMUACZwYgqpetAjRaHUKpL7TKdUTzhLeu
	3P9V/RPNkcgF5DuyPcpoTb7uPrx5m60w4jwoXsdQU6XEr1hTWUpHaBLSKpTGm0pQ
	PX4CAhvGAITZMpCTBkkpQ==
X-ME-Sender: <xms:X1kqal_qoe49_T0Z_wUGqgCPZWWtcL-xKlsgRDldXPeXAmQeOL5emg>
    <xme:X1kqavvDqV13O5rFwgud-PAZt3k37BGO-8QEraqHiVq4iX9kGn27oaOOfT1TQpn6b
    OChY_hBKgyt0E1o1-5VPtSzq7tkcoFZBBFK2Uab8o5_dexo9vC7>
X-ME-Received: <xmr:X1kqagrqCPHA74KKsFiOTXD653XKXI7Jioi4sHMPP-W0MsIUUx_44mEdBJWSHKifCoSan4sn-Z9Wdt4L-MPMr4gdO8wid6HTVX0zDUYOo_0K>
X-ME-Proxy-Cause: dmFkZTEgOgQISNYbw02BKlBveYltMYDawH6oVDDyq4v/XsTt80pelvfF1llMQQ1I+xKgAS
    f62Eieju+wnEZifEsf/Br9Odax4T6Cfa2NKsGSxfar9Xf+7QJ4NX5d757rQx1eVrWHtKGH
    oXfVdEwtqMNmNKNsPvvD1fcV5Bb6NRAKIHGtnJbrJkgNw1M9/23N/GTs2Qxu7OIMyZighy
    aedSFqGzhTBMe5Ful8ZLyJfG0/nONpNQWd0WMss6YgsDotIuGGwW5VpCNczUHoc2dLn1YW
    IHlXwMauta246yeYchI9ZiYTlRGdeRknkPFlf4NRBlhv0engcU3pd6DlQWx2prIj9C37sZ
    L8eq9dbBzfYs2l1wPFv58VdgKMy2qqAshLe9aDkrrkvw7Zaa/XKR/bvsmYEz8ZPVSZJG1/
    6bmLw4DuvyfSyoDDTpq5rKZS9ZdLpEhH22HcFkwXJ3kO1nVFcOooiPEr8ZsKz8dUbYyr34
    7QKoVE69w3vHnNeLWb/h/5p1z7zON1w77Rm/dtpi9f/4xNj0BJJz/0C9OpktS0xA/waLFI
    UEd6EWyNncGeKCDGiRG/PitAl3ZAe+INu96fuIDNIACoj0rBLBPWhrPHphBQ0vTOFLPAAK
    m/9JzghRljVUOksfyX1+KC4Nwc3+OLgqQ/aQBS5yAzF+3JnFxld/O5mg2ahg
X-ME-Proxy: <xmx:X1kqaknrIjhpaqrbTXu5-DSwXfy5K6tW4m2eL_eFF96jV-K6cdf0Bw>
    <xmx:X1kqasxBVGV4rDogRJs-zpUcCTZHaiERwtpq23fcdB6vU3YASoUl8w>
    <xmx:X1kqakk3pQV7NurLOGUP1UjdSeJcE8ruB_9RErQlvss6aGUUSQDZWw>
    <xmx:X1kqatfS5Pdq9F7dtzVdUdHyUPHwW9tpCYxECtyHtpBqxmo9TTvj8Q>
    <xmx:X1kqaksz4E4oRqOV-okoVxkKKa1D8wG-0GzqtPqoqOBWBqY0SYKvJdBb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 02:44:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98a2f3ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 06:44:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 08:44:39 +0200
Subject: [PATCH v2 1/7] builtin/init: stop modifying global
 `git_work_tree_cfg` variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-setup-drop-global-state-v2-1-a6f7269c841d@pks.im>
References: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
In-Reply-To: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When executing git-init(1) we need to figure out the final location of
the worktree. This location can be configured in a couple of ways: via
an environment variable, via the preexisting "core.worktree" config in
case we're reinitializing, or implicitly when reinitializing a non-bare
repository.

When checking for the worktree location in "builtin/init-db.c" we
populate any potentially-discovered value both by setting the global
`git_work_tree_cfg` variable and via `set_git_work_tree()`, which
ultimately ends up modifying `struct repository::worktree`.

Modifying `git_work_tree_cfg` is unnecessary though: we configure the
worktree in `create_default_files()`, and that function derives the
worktree location via `repo_get_work_tree()`. Consequently, propagating
the worktree via `set_git_work_tree()` is sufficient.

Stop munging `git_work_tree_cfg` and make it file-local to "setup.c" and
function-local to `cmd_init_db()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/init-db.c | 4 ++++
 environment.c     | 3 ---
 environment.h     | 1 -
 setup.c           | 3 +++
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index c55517ad94..01bc27904e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -229,6 +229,8 @@ int cmd_init_db(int argc,
 
 	if (!is_bare_repository_cfg) {
 		const char *git_dir_parent = strrchr(git_dir, '/');
+		char *git_work_tree_cfg = NULL;
+
 		if (git_dir_parent) {
 			char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
 			git_work_tree_cfg = real_pathdup(rel, 1);
@@ -243,6 +245,8 @@ int cmd_init_db(int argc,
 		if (access(repo_get_work_tree(the_repository), X_OK))
 			die_errno (_("Cannot access work tree '%s'"),
 				   repo_get_work_tree(the_repository));
+
+		free(git_work_tree_cfg);
 	}
 	else {
 		if (real_git_dir)
diff --git a/environment.c b/environment.c
index fc3ed8bb1c..4e86335f25 100644
--- a/environment.c
+++ b/environment.c
@@ -100,9 +100,6 @@ int auto_comment_line_char;
 bool warn_on_auto_comment_char;
 #endif /* !WITH_BREAKING_CHANGES */
 
-/* This is set by setup_git_directory_gently() and/or git_default_config() */
-char *git_work_tree_cfg;
-
 /*
  * Repository-local GIT_* environment variables; see environment.h for details.
  */
diff --git a/environment.h b/environment.h
index ccfcf37bfb..5d6e4e6c1b 100644
--- a/environment.h
+++ b/environment.h
@@ -149,7 +149,6 @@ int have_git_dir(void);
 
 extern int is_bare_repository_cfg;
 int is_bare_repository(void);
-extern char *git_work_tree_cfg;
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
diff --git a/setup.c b/setup.c
index b4652651df..52228b42a1 100644
--- a/setup.c
+++ b/setup.c
@@ -31,6 +31,9 @@ enum allowed_bare_repo {
 	ALLOWED_BARE_REPO_ALL,
 };
 
+/* This is set by setup_git_directory_gently() and/or git_default_config() */
+static char *git_work_tree_cfg;
+
 static struct startup_info the_startup_info;
 struct startup_info *startup_info = &the_startup_info;
 const char *tmp_original_cwd;

-- 
2.54.0.1189.g8c84645362.dirty

