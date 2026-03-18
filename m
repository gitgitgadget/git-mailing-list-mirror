Received: from sonic301-30.consmr.mail.ne1.yahoo.com (sonic301-30.consmr.mail.ne1.yahoo.com [66.163.184.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DEA63CB
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 01:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796188; cv=none; b=hfocQa4B1fpYKF69ubnoMTcPL+5yhDKVo7CIH7QhFsbfCE2BbzfKJMi/LP553rLr+THVf8J7aYIUGlWtmZL0x20kUyqa75NEi1dJhl7NK6lgP+XBNLmhTJvzPMrnTYS9KOze9aD/IUF1RDTWLTG+XZX7Gda2JORd1Gp6x12FKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796188; c=relaxed/simple;
	bh=Xz9QD4rtIqyJFeCOSBKRdSN4yEWb8iVAxGbH6jbMAf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=YUq84bxZ6iS1x05J3S2R11KkKU3k+Ec67Wp9S81dGsDAzMPT5Ej2CDg1lpojnBOv2XcJbQpC9wQvOXIPi0jkNBkTWHgCsxK/BnvbQ2wHsHPG5J8IVu5ySqC/53X6xPezl8AKKgMyrl9Ux188U3JDYy6FXyYSoEwJpbYjbU6Ftf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Vt2x+aZV; arc=none smtp.client-ip=66.163.184.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Vt2x+aZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773796186; bh=/fWi2k9DeuehNmaQ/KHnHk+pOJ52wyZjRMOBNo4e32M=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Vt2x+aZVX3TqeFyM9e8xaxXc5eqqGWUDrqvwfHYMMkp+pKbAASvbrwMJ5XrbbSz8Jnd6fU6667rmqJLuZ4t06LSf77hX0LhO/Drm+lH0fc374738cRIimvHnmobzpAJzI3JbYOMqx5ajt3gNQf6W/6CeqBA5ibhjSTnBE5MmjpOnAI/vpt0tN6MCjaa//QbNuauDq5g1rN1AzLTONEqO2Ml7rIEdvSDd5z6dyzf4O1W82CU2AX7n94nJ+sIlGO2EM8j3nAaFqas8SfIQt60A5ZX0IdYHpWW6YRqIUFdC0zaD8OtXdbgfBYPQDD0WmK/XBx1icFzyB59AYEQ2uXCvnQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773796186; bh=lFihBU5ZsbGAbKJ+9vCfu2OzpoVTdFXB7a5Hepke+pl=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=a/jtLcmNtiPIyGssbQ2gBvFWUVUeOwlgMvyiXWJ0QBLxux5z/zk/n1DEsIFtmLRi4EpgjNY97VsOEExTYnV7kVMoUQqX6h9p6ajwmiBEn/wSv4lL/SjdvvOMOV++jAu5HRaCYFAzC985hQGobm8TnvUkNk+XKsQ3/FJakn/a6M3Xk9bxzCO56D7FEl4euDN1GCcyPt/G8cLlPBotV8CI2Uc886XvzSi/9M5pPzgA6BKPY+vqvP5pwTCSlT/WkKQ+mBJOJhIyJ5LfOSU++DIYv39RHvzZMAZFc7MDhb8NWdLd+p2sVUBJZTkXWXFFl5EAb2BVXv5bRoit5AjhD0TlZg==
X-YMail-OSG: 5Qk7y7wVM1kdB2nw2xjjwG5.2Lm0DfavZKaGpzoRkA7RcGeSMt_kv0EhuQNge2O
 HVo5v0QYzB70kpraCtMj0udOLrD9A0Gg.3.2XrhlSveLXJb4yEBDicF2E_ZdnD1u_oH9VwploVMu
 h0z5AcELUEpU1hzH82BveVySy6kF.eFwK5KRfyhm7VnVyq_INVlNk4DEY45JrneGO62QN2MG2xic
 wrfw8EknlwEFau0AOoXySv.CQ5fM5ojKapIfx7pgzWIe9vmeY_.5GMfTFIHP3jw0DHfWNq2vfkVE
 06B95tJ.ip6EhJudobz4aeDXGiAeXDXUzRuAu3EXDsP6P5Q47B0H6.Yq5wuWNFOf.kBoJT5Fh.Aq
 bpR8M0ncl8Vx_si2rAJaCBKNC9iEr6WbmS.1HhNq_LIRtIFcSdiuuRG0Fzog0nBjKrzovbZrMERQ
 n_24iteCPzCUOni_oapYotY4k9uEQRigWWwIcD4yXOANkBorYK.XXMHCsgeKWYQW37lYUkGbRjn_
 nLDMJS7htKY.lSUYRR3bOPwUWiu8J.ytGKNy3xXCyI34LW8S9WKtcZXfRJ_buHGHgWpUMwNhPx_J
 JFKQ3hvPaTdjqE9e68AlZDNZ2EAakMYHzPAzhD5b6KZ3nrur0nrdbJ168q1IWaWojqXIuU5uYmxD
 ncBcahfWpjgsOi70Wi_P38Bs1pg1IlCHx6ORs4Kvsk_CdCE3eDng8zycJWnqd864q0R.sJIzMm.h
 wA.3Z2.FOn.Qul2M1ElUsqTNBe3nDYlbtqGu5l5TsmVYbC5Q4pretjZXsmI3aRUflFrSwLDAyz1.
 zuGgk9XUdBRTZIresTU1k9tcVa7eh_31_Zbm2bHkdQiQ8DyMAWJywieoyWK3BtaUXKfSFOsx_02D
 erzrPyvj9ZYC5ccdJBaHuVoQbgqY1E69qiHp.mOy4q9IyBzonqO2wVAnqXZ1hOaQ1AqiEp32vKIg
 IX9yaphoIXhFR6K2jIvA3kugTS8TAtx_SMHYcqQxJJSEIB1pESGPUl2ow48sPf8.2VPdgT4.sTv.
 yLNaqY2g5PJuWJcYhfZmh822Cv4XbrAhGGjKxMpGabmd12oMbDTVkfg_J5wsWKpR3kZD3uOVMgqH
 nAOepOOo9W8YFO9_Ffq0nC2LgLIr0U6C.mQCNLq7H82uTDLtxH908pHdf81BtBKuqgnvw4qqzfBl
 WwtSEWEMc5lnlmt2u5NQY2.mMigdRtvZnTCnPZO6cE11TCIbCXiar4TFsjWkVkGbcfHIMcxYPZFK
 Vflm49yJuJBFNwUg6IIAGrbaYeRX_lpBGhqm4T9Yl9t.31aRcE3JIQ7QcWeSNPvXjtBku15LYHbL
 k3lb_RpwMF7XD.RZSBlSBvsWFVFapxs4jExW4qqGwcRD_awre82D_j4trBDtSBkPBDImqDKAOAli
 GK6DwhNv8Qg56cI1L3sl1JLOaPRBYw0jpj0dE8_AitTDNhtBnbUT4qSCNh_CIiTslz_u388I4mdB
 .XBwh5Vvh4yJxN1rsVLDLznp.4oRrwEq04RdkDb4TxrZqrleHZKYf9QsS3a3zgsg0Y0MwUjrfmGx
 _7mV_DIC2.fd0b_A3KINqZeLiNsRV0pMysabZlIQou_PD_bh5b1bW9fqajEuEabebDWkCjlisThk
 eYuRmZnIJAbcCH97lpTNAFYZlvAZ3XTJJkeybQG20lGLSD3284Uml4ZS7cLXoPIOpODi49Ffg9y8
 i2FTq7UUmlugJ6X3hCGEkRGCSWhQXBCUJFd0lmXXYf20dBzvnlPV7xpqKS33QIoFFPk.wPSJ2f.8
 CynpDMzZfKJC_e5BP9j3NKM_cYXvuzvBpV2yuyLBPjULh63WXxnda3yQm_Qqr282zkVbSDR3FuL.
 n04i.CDw5S7K2mJs3tcyfdNjibSSMP4l77LTho.hW25dvK0flAFBK4J3g1AgJVV44WuagZk9m8pP
 EYDLJVaFrBP6T2gdxNTkAruNqM0WYGGhlTdKIz3DeIKjZ79Zefg1YPJKgmRIXcwPe9F1WmXCX5wI
 Yh1bkIATlV0h71qbd1JxoqPaTWEyLqlc1CittOlGaiXRXQ2CWY5X7Cj4f.ERCH5pCMZ6kGAGWHVl
 qn86nM7AaI7RbvuRMJMnWYKt1rs_ynKcA6MosNjkoM3tP4A2cn4mcH.tegZkJwHzbgdWpfDKDAct
 eKVSI1KOVhZHrh7Tre067hwumxAaYmxPyUhIkGTQZonb1zkG7W4wS4co_bohwoxSLAKfGUcpG2RK
 3YbPKK74ODtQkoCUnAWEu97o57vXDkefK3WNU6wzb4LidwHvpqcyJmoRQeknp32NWuGI4r47jK27
 GFDjXS58V0CVeNFV7Spr1b.thrrU5i5L.K.22wWYCUQ--
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 323fc6e6-46d6-45b7-b23f-10b0782933ca
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 18 Mar 2026 01:09:46 +0000
Received: by hermes--production-bf1-697f88457-xrkwd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b7357723e8467b9a934337b883852de0;
          Wed, 18 Mar 2026 00:39:18 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	gitster@pobox.com,
	Jialong Wang <jerrywang183@yahoo.com>
Subject: [GSoC PATCH] object-name: turn INTERPRET_BRANCH_* constants into enum values
Date: Tue, 17 Mar 2026 20:39:17 -0400
Message-ID: <20260318003917.84792-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260318003917.84792-1-jerrywang183.ref@yahoo.com>

Replace the INTERPRET_BRANCH_* preprocessor constants with enum values and use the enum type where these flags are stored or passed around.

This keeps the existing bitmask semantics, but gives the branch-name interpretation flags a dedicated type instead of plain unsigned values.
---
 builtin/branch.c |  2 +-
 object-name.c    |  7 +++++--
 object-name.h    | 11 +++++++----
 refs.c           |  3 ++-
 refs.h           |  3 ++-
 5 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a1a43380d0..6ef6a7ca0f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -228,7 +228,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	int ret = 0;
 	int remote_branch = 0;
 	struct strbuf bname = STRBUF_INIT;
-	unsigned allowed_interpret;
+	enum interpret_branch_name_allowed allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 	int branch_name_pos;
diff --git a/object-name.c b/object-name.c
index 7b14c3bf9b..fbf7c5dbf0 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1660,7 +1660,8 @@ static int interpret_empty_at(const char *name, int namelen, int len, struct str
 
 static int reinterpret(struct repository *r,
 		       const char *name, int namelen, int len,
-		       struct strbuf *buf, unsigned allowed)
+		       struct strbuf *buf,
+		       enum interpret_branch_name_allowed allowed)
 {
 	/* we have extra data, which might need further processing */
 	struct strbuf tmp = STRBUF_INIT;
@@ -1692,7 +1693,9 @@ static void set_shortened_ref(struct repository *r, struct strbuf *buf, const ch
 	free(s);
 }
 
-static int branch_interpret_allowed(const char *refname, unsigned allowed)
+static int branch_interpret_allowed(
+	const char *refname,
+	enum interpret_branch_name_allowed allowed)
 {
 	if (!allowed)
 		return 1;
diff --git a/object-name.h b/object-name.h
index cda4934cd5..a544b65235 100644
--- a/object-name.h
+++ b/object-name.h
@@ -101,9 +101,12 @@ int set_disambiguate_hint_config(const char *var, const char *value);
  * If the input was ok but there are not N branch switches in the
  * reflog, it returns 0.
  */
-#define INTERPRET_BRANCH_LOCAL (1<<0)
-#define INTERPRET_BRANCH_REMOTE (1<<1)
-#define INTERPRET_BRANCH_HEAD (1<<2)
+enum interpret_branch_name_allowed {
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
+	enum interpret_branch_name_allowed allowed;
 
 	/*
 	 * If ^{upstream} or ^{push} (or equivalent) is requested, and the
diff --git a/refs.c b/refs.c
index 6fb8f9d10c..b3b39ce37f 100644
--- a/refs.c
+++ b/refs.c
@@ -740,7 +740,8 @@ static char *substitute_branch_name(struct repository *r,
 	return NULL;
 }
 
-void copy_branchname(struct strbuf *sb, const char *name, unsigned allowed)
+void copy_branchname(struct strbuf *sb, const char *name,
+		     enum interpret_branch_name_allowed allowed)
 {
 	int len = strlen(name);
 	struct interpret_branch_name_options options = {
diff --git a/refs.h b/refs.h
index d98c1fc591..8a5b034f8a 100644
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
+		     enum interpret_branch_name_allowed allowed);
 
 /*
  * Like copy_branchname() above, but confirm that the result is
-- 
2.51.0

