Received: from sonic317-26.consmr.mail.bf2.yahoo.com (sonic317-26.consmr.mail.bf2.yahoo.com [74.6.129.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECB3EF678
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860992; cv=none; b=EAQGvIj8DQVbi1s+ZTNWym1HgwLcnh575xPv/D7oKI7h9sIbzqdeyH4Y67W+4wACOiBJjuQSftX2bWarf74rlBgXoIVHj1EnFBTGSPrExyoLZYQTdiKSlO/Qs0JOZm4VtXxJjvRf/1+aHpjjWpQQf9MtSj09Gdk4LynCFW+hdPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860992; c=relaxed/simple;
	bh=BGUvQtWBazFUUcC74l/RqVUCb77KHTznEEowRtIDv6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0TjxAnr8sZzTo5hVgucT1woKEuv0CmYFJGy+dAKXhyJV7U/UjmXtefCKFCb6RC9D9bahd1ugQ7Se8G+lN+r+Lc7wA2poF41Z4hF/39cySb4tju2BEkXvwO8BSl1BmU7XMymwEo58xlWh5qaXAdUyhMOTUBXbHVfl27Kc+gxl9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HZfJf+dA; arc=none smtp.client-ip=74.6.129.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HZfJf+dA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773860983; bh=mwZJpDbvICKzMqD+dOBIpJheMEahH0btHMLM4yVD6z0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HZfJf+dACPY4mXPih1EnEmPKMTfTBw+lqTcKdL4HdATxpchAx6IjtY7RZwj8BgFNO5QBkXBF1VYJbZpuUYN/uZHspZjvh6kj4CrpDffr1lk3JA4s7559dnNqY/QDQRwvjWC+ZWR+rbWpBYhj4TWclMNNeZjiIkDQQxnKVHQ2ANwid9ouauHf8Nx139oriYwg87yYz94lGIvvlm6rv9eeZStKEvRz7VhBZhG8CavH8xVGv6LL0c7jDi2ARpND36Ik6n3xC3x1a4zdnHNXWLyWETN6WdjZaYUsSEs0MLWJv4AmvpYbpoQjexUz2r0aPvWAuWb/75O+ju708Ms4XQl+MQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773860983; bh=ObixPGxV5Fwg0y+CE+pYx6oaeflKCeXMkz7iZR8Ga/S=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BJ5MMvi+MMBoyVA9at3Dkya8EApqkbOohlgxYNvoau7BzDi7GKEj0QagxS02kNvtekW3Yz2ZaSOYy7XTbqQdxJdWSMs2zpqZZ0ARqXPK1j2hReii7zcjf8q/yS5qz+DSNw8af598kNRGWaQWiCU0hHzTd9+w/g2mqJ7w6IVgVXpIOzy2PspHENQnORgsPP6XWYzDE0kZpbiryN4h3O+duzAl+MttfTzhHiLKikRKfO4AVOn8MstolEF1cmrLkznLKZk6HaRmI6BTuXHEq8/X2jlybW0jdiynCIS7puCRj4tqKnLgi5KEtYoiFn7QpwjQPHLX0jAllvvn3HcNVUayIQ==
X-YMail-OSG: Yw9DbuIVM1nkvbY8r0K1PXd8lzGO_ENjJ7PIqBU1mxItgOCM3huN2Xjr_tH6vdc
 EC96rWY6972wW6yQovmejasg0qGj3i.8DyW3XxOcCiX8kLPMVP3ryBNqxCgTvEaGCPq5WoN7SE.K
 A6JIcHNkTKa7y08Uv7z.QkpIO8GOy4RaU8eM2S_ec5_2FvqM0rSc7bDmv5f1hDTcid3sC9VopCAc
 xEqzNASBDlDNTcJZRbHviX4IfFD2G9rXQQ9Xeoy3GzsRUieO3g691ejBWtJnpCiWE3Zq8TMdTW3S
 xiShCvdnDOvkmOVf0ShJd3g3v1EsVCQAso_y2Ffh4mtD1cmeKZH2kcK4A3r.TPI2jxuBPSLOlH6n
 lBnmywrEEyTEfOzCyVzSBKiwwuiE9LNxvmRL9SeCGyPDmARXkykaB0wtRtuAD.v7bQwZedqJhyX5
 y2C0yd.N8JaXRhoRXYchYNyihw2uGDqRpDS4DNR8Vl..AGDL7mhGRNrdEYd8UroRqlAsKtxnyLDZ
 DkapJParo1J5BcR_X.bneYq4Qs3uB706ptz6aPVZZwNJ1op8L77LNjY8PyWPMmoSAgCEILm_fZMc
 uOTi.ERZm6Z6EUZ2M_fjpwXg.Q0XBYOrvwu9gn8_wMsWtCihzKjp7w3noQFlyk9QEtIaq8KU74X7
 2cUUSzP.awvaH2ktf3w509nD7brkJbUY.D3FGis0brLFJke5PnXwWCtChsbenyPRkUID7SUEd9Dl
 hco0dhXPYzES45cc0.pB5Drnf8qeAp2aKRlOQDiSYWm8kCzkbbnS9bkPR2DeRp0.e.Ol4YlS.zGD
 zUcMTqsAkSp3Ve1YK9FWfCKMi9kPFsU3Ms8chHSL.1xXz_BeUwfR_4LEBiVx1Ex__pImMY5p36d_
 ZWAzjEkqapZMplhjm5cNw09PelRkrC48bQZYjLzZybQbDZ_j_l2VTNs3aJXXNfwkxSTq2rRdwdzI
 4WbjXDA5UG4l5lo1Pq3e1egz1ahIPaxUppYbd0r_HYn.mLtAN0yx2JzwZBKKXxAG.aJb0SxRtmtr
 QtZGo9WRZgJxBU46d9enIwSRlLjdtuRbM9PXkePTM6ZOX.e6nioo.so5B_rZcmbY6TP8UVNn_xo9
 RyVZqmquCu2ry9HBnB4pOw72anC5pn4VvsjUHctDi_b8n.4ai_CyK6C7Z5vIZLk1bj.heSzSQEk2
 Dii6mmD62XNTDnj9ku4.OWfE_NYaTNNXaTkTrA6OSGguGhjxjQKp4mFBZvor0pNm8o7t7.EnUQry
 sabImz5B5ajOPp7cPDLWHHY25X1iwSDKYSq7Bx2Uky.REfAYiWka3NjnB6hPAnIB6yG3bSSoomx4
 3s..XA1Gdap__2UbYeHCIO58jpHaz6dbMX9cGCeyUndDODcIUoPFYyIkxZ7l6JDy.MCBFYECM5J9
 y9ibUhK68k4OznsYHbrzPn3XpgiF8rOJrC6QZEWiiY55wtSIwvH9Gw.HV9xafBQrjrnILmYBvpmo
 m8sqGcq260f0i4l9FXvXEbWEgm080WS9Ko1AFdotLY_SFXoDBCIAHLKk1M.7Ait_3M1QZoJSO3dY
 AQ9RzbjwLaj0.iM7oPWOCq.ICc3.pjESYBjk8RlT_mJNzpyCnirEtxlJJ_bURSQvN_cVy5kwX7Zx
 XgjUKJqXIuqw5pPVvr42Cl1GmU5imWozARwpFQU0M7eXXCd7.G.LbEriOpyQCT_j4s5HwBGBPBth
 jZ2zS0fiSBFOIhBq0zdHC4J0NbssvBkARj6nfXDialzHsWE0VRH_ZOZYD12fzLX.jpq4caal0zJI
 8_x0Iupi614CocQiB_AhVUGK9Qd19rFIVCJUj7uFm_WjWy2HqdcSpEyZi5UpeNlUxehWQyy0fpNn
 oZ31vAHVDRVcsN4zSoFTb79ob2xJyYCrMqMFmaG_9QyE4KLsNyhhnSLLfVZjU5lo3vTm0Em1HsZs
 HFJudz3l3.to4ShfoJE19gli3qdO675Os2dna2FlUeNzdmC2lgneVYM6gnrfY_qHgzkkXHCJzel0
 B3CM3JLE6QsvZYfqJrxu97xM82elsa2Z_brOlq1Xqp0I8A86fOoZscFmoO0qD57R8_9J70ZcQvHX
 KxI0ln60Ifw9cIvK9sCAOFO8uN0Ij__ZULuA9eOtxu9_dZyNQAU7VLxROw1.kU._pmK4VAMbSaKT
 mdmuKX2M02JqsYYcwYXM_feYSF4qcuTp3c28vgfomieCg7eFlZo79rmLfSKgfmd.BKhCDJmzbDif
 v_geGt3LffABDP9Xt5UQ2i09IznDHLX66G8oW0aWl0O0eK3A8ujwk7_O9s9jq4JqfkVToNtotPjG
 boYYPcIL0FaGM42BYNVNC7Vq.2b_unMoo
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: b490df39-2b00-4acd-a896-8349db546fe4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Wed, 18 Mar 2026 19:09:43 +0000
Received: by hermes--production-bf1-697f88457-dbpm9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9193f12581b10bee7941321f9cd6255f;
          Wed, 18 Mar 2026 19:09:42 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	Jialong Wang <jerrywang183@yahoo.com>
Subject: [GSoC PATCH v2] object-name: turn INTERPRET_BRANCH_* constants into enum values
Date: Wed, 18 Mar 2026 15:09:42 -0400
Message-ID: <20260318190942.22595-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318003917.84792-1-jerrywang183@yahoo.com>
References: <20260318003917.84792-1-jerrywang183@yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the INTERPRET_BRANCH_* preprocessor constants with enum
values and use that type where these flags are stored or passed
around.

These flags describe which kinds of branches may be considered during
branch-name interpretation, so represent them as an enum describing
branch kinds while keeping the existing bitmask semantics and
INTERPRET_BRANCH_* element names.

Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
---
v2:
 - rename the enum type to reflect that it describes branch kinds,
   not the allowed set itself
 - keep the INTERPRET_BRANCH_* enum element names unchanged
 - wrap updated declarations and commit message more conventionally

 builtin/branch.c |  2 +-
 object-name.c    |  6 ++++--
 object-name.h    | 11 +++++++----
 refs.c           |  3 ++-
 refs.h           |  3 ++-
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a1a43380d0..1572a4f9ef 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -228,7 +228,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	int ret = 0;
 	int remote_branch = 0;
 	struct strbuf bname = STRBUF_INIT;
-	unsigned allowed_interpret;
+	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 	int branch_name_pos;
diff --git a/object-name.c b/object-name.c
index 7b14c3bf9b..2b2a0435fd 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1660,7 +1660,8 @@ static int interpret_empty_at(const char *name, int namelen, int len, struct str
 
 static int reinterpret(struct repository *r,
 		       const char *name, int namelen, int len,
-		       struct strbuf *buf, unsigned allowed)
+		       struct strbuf *buf,
+		       enum interpret_branch_kind allowed)
 {
 	/* we have extra data, which might need further processing */
 	struct strbuf tmp = STRBUF_INIT;
@@ -1692,7 +1693,8 @@ static void set_shortened_ref(struct repository *r, struct strbuf *buf, const ch
 	free(s);
 }
 
-static int branch_interpret_allowed(const char *refname, unsigned allowed)
+static int branch_interpret_allowed(const char *refname,
+				    enum interpret_branch_kind allowed)
 {
 	if (!allowed)
 		return 1;
diff --git a/object-name.h b/object-name.h
index cda4934cd5..167a9154ea 100644
--- a/object-name.h
+++ b/object-name.h
@@ -101,9 +101,12 @@ int set_disambiguate_hint_config(const char *var, const char *value);
  * If the input was ok but there are not N branch switches in the
  * reflog, it returns 0.
  */
-#define INTERPRET_BRANCH_LOCAL (1<<0)
-#define INTERPRET_BRANCH_REMOTE (1<<1)
-#define INTERPRET_BRANCH_HEAD (1<<2)
+enum interpret_branch_kind {
+	INTERPRET_BRANCH_LOCAL = (1 << 0),
+	INTERPRET_BRANCH_REMOTE = (1 << 1),
+	INTERPRET_BRANCH_HEAD = (1 << 2),
+};
+
 struct interpret_branch_name_options {
 	/*
 	 * If "allowed" is non-zero, it is a treated as a bitfield of allowable
@@ -111,7 +114,7 @@ struct interpret_branch_name_options {
 	 * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any expansion is
 	 * allowed, even ones to refs outside of those namespaces.
 	 */
-	unsigned allowed;
+	enum interpret_branch_kind allowed;
 
 	/*
 	 * If ^{upstream} or ^{push} (or equivalent) is requested, and the
diff --git a/refs.c b/refs.c
index 6fb8f9d10c..18b28db6d4 100644
--- a/refs.c
+++ b/refs.c
@@ -740,7 +740,8 @@ static char *substitute_branch_name(struct repository *r,
 	return NULL;
 }
 
-void copy_branchname(struct strbuf *sb, const char *name, unsigned allowed)
+void copy_branchname(struct strbuf *sb, const char *name,
+		     enum interpret_branch_kind allowed)
 {
 	int len = strlen(name);
 	struct interpret_branch_name_options options = {
diff --git a/refs.h b/refs.h
index d98c1fc591..d65de6ab5f 100644
--- a/refs.h
+++ b/refs.h
@@ -1,6 +1,7 @@
 #ifndef REFS_H
 #define REFS_H
 
+#include "object-name.h"
 #include "commit.h"
 #include "repository.h"
 #include "repo-settings.h"
@@ -225,7 +226,7 @@ char *repo_default_branch_name(struct repository *r, int quiet);
  * repo_interpret_branch_name() for details.
  */
 void copy_branchname(struct strbuf *sb, const char *name,
-		       unsigned allowed);
+		     enum interpret_branch_kind allowed);
 
 /*
  * Like copy_branchname() above, but confirm that the result is
-- 
2.51.0
