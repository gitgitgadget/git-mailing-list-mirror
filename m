Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040974;
	b=vrveiBbCjqU1ddpvTP9FIPEFCgwzmyBwmYXMcxNGGpPquoD8dn5u0cxCHpRye7L3Gjdr
	 lHwyszcaYG9bcI9NSuRoTA9fHbsLpPRe3frXionMthVzokQJvEr7X4xFq39e6O3HDhcfV
	 /7chOukymDFS26GN4NqD8b0Ebi9aRVrVu7GzeuptgBvUysec4gYYSxhAtVxaPEVa8huQv
	 zdeJWIjlOmK+Ey9r3aTrsl+0QiZgUa5kZdNMZIJ9X8R9Q3Kmiqiu/VGrt7O9o5Dkma7Ug
	 lArPN9VcC+weEg7Z/q2z1iICOOm0dt2+Emctnb+frwjz36LurpDBYo9ArgV6bIdwyfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=E7BOw0W0YZ3W9dE/5Blf8KNYleV2LimHU5+tu0CwZRQ=;
	b=BI2wec/zemZEDHyzM1KvWGjeIoYWiABE2EyCGni4EeubqphaHJ7o9GDmmrCXBlqMwN7k
	 mDz3C7UuwMiNpWmjslfYdyB4JwxbJMDTEob+MAYsb22d9FyhcDbJOpWoLmYE9lUJd+xKd
	 /x88rQTirUVdLMcb+J42iJL6hk0Ih8OcSYovw6Fu7/pfd7JseGdJ8t+JCk+j8lgTMbjHn
	 Dv/qgCMgrDQ5RpM8H2joRjxfwDW0fzorBYP98XfWWSfsJFqtqAMck7Rp2Eq57yBcnhsz5
	 Yc9pufkTdhlul63HX68OLYvsTTAWVcDLsb+n7oHlIjFiv462TuW0lTCKW4XTKm+dJAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X8tAz2wN;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC4606A330
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DAC4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X8tAz2wN
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso788190a91.2
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040974; x=1794645774; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E7BOw0W0YZ3W9dE/5Blf8KNYleV2LimHU5+tu0CwZRQ=;
        b=X8tAz2wNXLerG9RqSOPVBGCkKw1+vyslto26EWK0iQp20BXafpxiwBoRmtYHKVnawQ
         wWS1BtuHqV/MO4tgmB/snGPKBsLGqr9ubzZWLaJv25vo6ZmfCZTXztirTiPfK0IqKyKi
         38LAodd/IIb3wHJEIYkViLTn4FUmMciN/VVgsY4vLL+ya49utTMvKfraHhJKy02nqNYP
         7VnSqCIjISD8D1PnTtbse3MuoDnpl+1U+8GD3YRyZUK3r85HVHp0upavpXYn8ml14m9v
         Ab4PICZnOtepxXHlCAayYxpl7LEBUiO7wv5stWL7G7eWVc5AYgPnxIn6WClbV6v59ZUA
         AldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040974; x=1794645774;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7BOw0W0YZ3W9dE/5Blf8KNYleV2LimHU5+tu0CwZRQ=;
        b=Krm8UaJBxF0s0QZ1rKlCx4dZJx39vqKFJzKSowmXT9rxQK4dSlPjBGpcCXT1KjVjiE
         VJ+iHkHI7BDSGFwu9AYh1y4ib1cJVEy+j3QNd3uT/7XrONp5F+OmI0hT2rUax+/iX+wR
         WjsheikQiKN1qLvv0pi2kCb+byeHfn1ZCnPFaprutEMrHCqtDd1ip3+eYXccUtL+Qa0O
         wRFoADuFq2zd+ZR5p38u0nvWp3oBjAA2Rgc9qD/xUJ8gLxvoo7cgeVwUYlppIFOH+lhu
         dLWSGJ9FgEVNZeR7sDawd5fTyLlxXAXF4riczeI4fivc1LEy3tla3/2W8p/tbuQCHt1U
         JdpA==
X-Gm-Message-State: APuU4Z9cmHD0tCLUzMmGsy/723wqaatq0mqjtBpzw3hxqbDZVX7Wt34H
	gy21iUI36nl+ULJ86QqMAO3LRjrgl9ePkapQFRINX1WSWNFdKnS1MxiT+q4tMWfJ
X-Gm-Gg: AYBFou3E3aLJvwBpeK1CMyolj3/SasdY8xbhjp5efgtxhg/G64gjZneQHhN3RwYy/TW
	9bCBmZFAGTBqBcHmIJBHmk2vvjM7xkzagF/5p2hCCmYCB5tfaEFSvd4AkyWux2IAc1z1IH6goBA
	7PH532Z/N+j4llZB3+ddjjg3aNWWgI6WpPmBcozL8z97innM+VAwzD42JzapF3+PGebipcWyQJg
	UoYYFiroj6oKkvhTIotO19eGAkFkUqTnJ0eml1GPYovJ5SqkmCqXiGpTqm+Cs1KZnwTxMsh0gAR
	rrk+8rfgOM1jAJV5hGf4z/XlBZO4TekcijH+z3bklJrhAHxD5BBSn0tApzHFZWaQRmwMPG1ccMD
	UNGGhnScYuPnZBLAWS5TtOfxB0qyTGjOltY6NAeN3dA1iTK5rYZTs3sFVBW1xUj5TtOatyyzQmk
	LdgCGG42qxJUprNCQxjoUsnlKcg4WIYhxZE+1R+kgg3YTM5GqqYZSOlbXG3l2RNlJriMma6foV7
	NRZW6BigMssMHJej7dxUG/mbEjQiEyYrHkT+bwquoOIWPNYVQ6O+d290JyfpHMobO/l3DXshAqY
	C4IYAh3wR+1COwAAG9MoK0AUkX7jBYQwvA==
X-Received: by 2002:a17:90b:5848:b0:3ac:7872:d1b7 with SMTP id 98e67ed59e1d1-3b0db6f1832mr5089865a91.32.1794040973592;
        Sat, 07 Nov 2026 00:42:53 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm2541125a91.0.2026.11.07.00.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:42:53 -0800 (PST)
Message-Id: <74ab5bfc62c5f686450a6361d2bc6493b764a81e.1794040967.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:34 +0000
Subject: [PATCH 02/15] odb: handle NULL values for core.alternateRefs* config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A core.alternateRefsCommand or core.alternateRefsPrefixes without a
value makes "git fetch", "git receive-pack" and
"git rev-list --alternate-refs" segfault in a repository that borrows
objects from an alternate: fill_alternate_refs_command() passes the
NULL value to strvec_push() or strvec_split().

Both settings take a string. Read them with
repo_config_get_string_tmp(), which rejects a missing value with
config_error_nonbool(), as the previous commit does for
rebase.missingCommitsCheck.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 odb.c                     | 4 ++--
 t/t5618-alternate-refs.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/odb.c b/odb.c
index 0200e26f21..ed59cfc989 100644
--- a/odb.c
+++ b/odb.c
@@ -379,7 +379,7 @@ static void fill_alternate_refs_command(struct repository *repo,
 {
 	const char *value;
 
-	if (!repo_config_get_value(repo, "core.alternateRefsCommand", &value)) {
+	if (!repo_config_get_string_tmp(repo, "core.alternateRefsCommand", &value)) {
 		cmd->use_shell = 1;
 
 		strvec_push(&cmd->args, value);
@@ -391,7 +391,7 @@ static void fill_alternate_refs_command(struct repository *repo,
 		strvec_push(&cmd->args, "for-each-ref");
 		strvec_push(&cmd->args, "--format=%(objectname)");
 
-		if (!repo_config_get_value(repo, "core.alternateRefsPrefixes", &value)) {
+		if (!repo_config_get_string_tmp(repo, "core.alternateRefsPrefixes", &value)) {
 			strvec_push(&cmd->args, "--");
 			strvec_split(&cmd->args, value);
 		}
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index 2fb6d549d3..13abd81e98 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -58,4 +58,13 @@ test_expect_success 'log --source shows .alternate marker' '
 	test_cmp expect actual
 '
 
+test_expect_success 'alternateRefsCommand and alternateRefsPrefixes need a value' '
+	test_must_fail git -c core.alternateRefsCommand \
+		rev-list --alternate-refs 2>err &&
+	test_grep "missing value for .core.alternateRefsCommand." err &&
+	test_must_fail git -c core.alternateRefsPrefixes \
+		rev-list --alternate-refs 2>err &&
+	test_grep "missing value for .core.alternateRefsPrefixes." err
+'
+
 test_done
-- 
gitgitgadget

