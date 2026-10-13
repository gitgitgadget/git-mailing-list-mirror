Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331B3C1F54
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902183; cv=none; b=dWzlL8ck5lctMjl/RGatvusOZPw1yTJN7exaTmpIpZoZJmLZ9RlFfjYLI8LMkti5TXD3ERPwFMf8PZeQj4SFQw6vpKvGhGg6PBWiR4QUGohr7MuDoq59XMi2ajvGG5D3GVCNPIu5s0N+WuwDI3PAHC890tiMvVEQb06+bzUfkR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902183; c=relaxed/simple;
	bh=L5CYe3O1suOe929u8TQuAHm/UXhuDNmIH3cmnNc59Gw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ue8UkKfVLlFlCK6b4H6d94uvME64TEp3GK8Vr7e2pcWwTECb4x8kD6UYd7Ih1gv3x8+mym/i7AxVdIKAJaeiGg5sIjWswbIMjDUYZw0SBOB7dJvknoH53/VAkDFO7eyPmx9EzoDh0bjHnGBeUS7u06rhILy0lOYYFt0M0UQkKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frDMBdPy; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frDMBdPy"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-504db7f7870so2178138b6e.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902181; x=1792506981; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9CQSEsqMsStLU6J4arcPuaXlaUHJGbkPDn3yNJ293jM=;
        b=frDMBdPyFt7HuljOsUgF+eHCTqqlVTOOmZCzeBhO1CJIr1NfL+uOpPteCnsMW8T2hC
         AAsio2RDX+BUBVLkyu05nKx9LnqF4m1Q/c92CDK8VrhxoKTzxM8Q2l9WoDMnnhJDeWLw
         tpwb7XoZOZMEwBgviqaNvCohP6BcLX6BjGlLyx5DWw5u11EKf4Vq+BrEJgb0N1P543X6
         ztyQgt1LhDJ797dI7VxvJ9xv0FpNRqkjF2oV2QJ9+HC49giaa86qVIm7pf1pfW52pVtY
         ZMHmZBsbLe7EnVbi/hBXK1S1/IboAKtcw7ZJnGX0525Yi3a6erLk0GntvmhEjt1cvNx6
         lBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902181; x=1792506981;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CQSEsqMsStLU6J4arcPuaXlaUHJGbkPDn3yNJ293jM=;
        b=DxhnmPYI3ekFZrnNC5qrHAZT/qBERZ6bMXTLS1WiPyoQk7DUBr5Js8LKXMkwViJb2E
         SoNsRXGiYDCYfRicTPN3zVyZuKEMnRfyl2Po/CG7tBhy+Tew8MmnSAEcW4nFqi/x0ulm
         3lsWHdXMB8X1FYTzRxhQFiCfgj+XmOYZJms3lfoEVM3nbUFRRSToVHsgO74IINh278CB
         sv7dNjlje6LA65p1YxhU7yVaNzWEiAeZQB0VFHXYqr1tP5pWagzvBtX3Lp+4UibbM3lk
         2B2gh/Lm+CDh57K9tHlps20rGP3QJ5hayL7FMxrBemh8hSMyaqmO8KMopmV/kJOkMfNU
         Fl9A==
X-Gm-Message-State: AFq9FYLxWXfc8UcRD52Ry1wtH3iIifxuFNr0sm7r7F9AEt7ruD9kJ9aB
	4+qAAlF0utVXm9EsTwk1UvBkmQnQC2imrekiZe/5zBi53CwECdN5QEIPDIbbDpLa
X-Gm-Gg: AYBFou2e0MA5y0e1/llghrglv+2Kqyw+ncTkr3ytikz/CGzgoa5kKN7G+2HGI/9SxxJ
	fjiF6SPdngOUaGcF+pjHig7U//j/u0csE/HH/lh7bcfyuKUDSO0YZdeXSsIx+p0D+QrBeAL8xmg
	2xuaFLHTwZsEd1fxeQeTmKQ9MwaxBqw3zcI6WsYIASMqbalwxWJFD4M+X9Iakzo04j3/rMgXE4r
	c3ZDD3Wx+no8QqrF3DlgrpBPas6rqO4k4uHy8oiK/lt9wkHhe5LijeKMw+W2stFxzSS7yg3BSff
	S5s2Vm5YHHujXcqZY7UbX64PMxF3hRVaeyopgolKIg+LaW8mQ8UhAtg4jNTMdn/vL+hfS4DUjc4
	EFwLj33tT2C3pEUWgVF3TTTes0o/xQJKh+D6d7IvZmb7MPDKw3wnZCuTHLkF627anT4JLmLBM2F
	NznqNgd0jDHBrUZX28G3DXasDxiTU/7qOyt9CM5GCr9JMLdRT0OqVS9wdkrNHOtcq+v5XM7s72k
	BY=
X-Received: by 2002:a05:6808:14ca:b0:4f3:6c2b:5f22 with SMTP id 5614622812f47-50c553d1a44mr11482854b6e.29.1791902181032;
        Tue, 13 Oct 2026 07:36:21 -0700 (PDT)
Received: from [127.0.0.1] ([48.221.153.206])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1a230494sm14513499b6e.13.2026.10.13.07.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:36:20 -0700 (PDT)
Message-Id: <e9b2c1dae2cd11783a66f0afdce53dfad78b43d8.1791902175.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.v5.git.1791902175.gitgitgadget@gmail.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v5.git.1791902175.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Oct 2026 14:36:14 +0000
Subject: [PATCH v5 1/2] blame: harden ignore-revs parser and tag peeling
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Abhijeetsingh Meena <abhijeet040403@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ravi Mistry <rmistry@google.com>,
    Ravi Mistry <rmistry@google.com>

From: Ravi Mistry <rmistry@google.com>

Currently, blame.ignoreRevsFile and --ignore-revs-file only read paths
explicitly configured by the user, which cannot point to an
attacker-controlled file under Git's threat model. An upcoming commit
will teach git-blame(1) and git-annotate(1) to automatically read
.git-blame-ignore-revs by default if it exists, exposing the
ignore-revs parser (oidset_parse_file_carefully() in oidset.c) and its
tag-peeling callback (peel_to_commit_oid() in builtin/blame.c) to
upstream-controlled content at a well-known path.

Harden both code paths before enabling the default ignore-revs file:

- In oidset_parse_file_carefully(), strbuf_getline() reads up to the
  next newline and records the full line length in sb.len, including
  any embedded NUL bytes. However, strchr(sb.buf, '#') and
  parse_oid_hex_algop(sb.buf, &oid, &p, algop) treat sb.buf as a
  NUL-terminated string. If a line contains an embedded NUL byte after
  a valid object name (such as "<oid>\0garbage" or "<oid>\0# comment"),
  *p is '\0' and trailing bytes on the line are silently ignored.
  Reject any line containing an embedded NUL byte via memchr() before
  stripping comments and whitespace.
- In peel_to_commit_oid(), odb_read_object_info() is called without
  OBJECT_INFO_SKIP_FETCH_OBJECT or OBJECT_INFO_QUICK, and deref_tag()
  calls parse_object() on tag targets without checking whether the
  target object exists locally first. In a partial clone, any missing
  commit OID or tag target listed in the ignore-revs file would trigger
  lazy promisor fetches and pack directory rescans during git-blame(1).
  Use odb_read_object_info_extended() with OBJECT_INFO_LOOKUP_REPLACE |
  OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK and peel OBJ_TAG
  objects one layer per iteration, verifying that each target object
  exists locally and matches the tag's declared type before parsing it.

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 builtin/blame.c              | 20 +++++++++++++++++--
 oidset.c                     |  3 +++
 t/t8013-blame-ignore-revs.sh | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 48d5251c6d..6741a7b9df 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -911,21 +911,37 @@ static int is_a_rev(const char *name)
 static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
 {
 	struct repository *r = ((struct blame_scoreboard *)cbdata)->repo;
+	enum object_type expected_type = OBJ_ANY;
 	struct object_id oid;
 
 	oidcpy(&oid, oid_ret);
 	while (1) {
+		unsigned flags = OBJECT_INFO_LOOKUP_REPLACE |
+				 OBJECT_INFO_SKIP_FETCH_OBJECT |
+				 OBJECT_INFO_QUICK;
+		struct object_info oi = OBJECT_INFO_INIT;
+		enum object_type kind;
 		struct object *obj;
-		int kind = odb_read_object_info(r->objects, &oid, NULL);
+
+		oi.typep = &kind;
+		if (odb_read_object_info_extended(r->objects, &oid, &oi,
+						  flags) < 0)
+			return -1;
+		if (expected_type != OBJ_ANY && kind != expected_type)
+			return -1;
 		if (kind == OBJ_COMMIT) {
 			oidcpy(oid_ret, &oid);
 			return 0;
 		}
 		if (kind != OBJ_TAG)
 			return -1;
-		obj = deref_tag(r, parse_object(r, &oid), NULL, 0);
+		obj = parse_object(r, &oid);
+		if (!obj || obj->type != OBJ_TAG)
+			return -1;
+		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			return -1;
+		expected_type = obj->type;
 		oidcpy(&oid, &obj->oid);
 	}
 }
diff --git a/oidset.c b/oidset.c
index c8ff0b385c..90d39204d3 100644
--- a/oidset.c
+++ b/oidset.c
@@ -85,6 +85,9 @@ void oidset_parse_file_carefully(struct oidset *set, const char *path,
 		const char *p;
 		const char *name;
 
+		if (memchr(sb.buf, '\0', sb.len))
+			die("invalid object name: %s", sb.buf);
+
 		/*
 		 * Allow trailing comments, leading whitespace
 		 * (including before commits), and empty or whitespace
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index cace00ae8d..70fe509a64 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -327,4 +327,42 @@ test_expect_success ignore_merge '
 	test_cmp expect actual
 '
 
+test_expect_success 'ignore-revs-file rejects lines with embedded NUL bytes' '
+	rev_b=$(git rev-parse B) &&
+	printf "%sQgarbage\n" "$rev_b" | q_to_nul >ignore_nul &&
+	test_must_fail git blame file --ignore-revs-file ignore_nul 2>err &&
+	test_grep "invalid object name:" err &&
+
+	printf "%sQ# comment\n" "$rev_b" | q_to_nul >ignore_nul_comment &&
+	test_must_fail git blame file --ignore-revs-file ignore_nul_comment 2>err &&
+	test_grep "invalid object name:" err
+'
+
+test_expect_success 'ignore-revs-file peels chained tags and skips missing tag targets' '
+	test_write_lines BB L2-modified L3 L4 L5 L6 L7 L8 CC >file &&
+	git add file &&
+	test_tick &&
+	git commit -m D &&
+	git tag -a -m "tag 1" D_TAG1 HEAD &&
+	git tag -a -m "tag 2" D_TAG2 D_TAG1 &&
+	git rev-parse D_TAG2 >ignore_tag_chain &&
+	git blame --line-porcelain file --ignore-revs-file ignore_tag_chain >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	test_config extensions.partialClone origin &&
+	test_config remote.origin.promisor true &&
+	test_config remote.origin.url /nonexistent &&
+	missing_oid=$(test_oid deadbeef) &&
+	bad_tag=$(printf "object %s\ntype commit\ntag bad-tag\ntagger T <t@example.com> 0 +0000\n\nmsg\n" "$missing_oid" |
+		git hash-object -t tag -w --stdin) &&
+	test_write_lines "$missing_oid" "$bad_tag" >ignore_bad_tag &&
+	git blame --line-porcelain file --ignore-revs-file ignore_bad_tag >blame_raw 2>err &&
+	test_must_be_empty err &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	git rev-parse HEAD >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

