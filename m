Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C642DA3D
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791757300; cv=none; b=jnHCB8o3cslkMvj0Fc6hIHEPxUjCbpkVeIQNebW55976BD/c4AenXtOsWnZ2CxbSLRwy9WglH+5nIf+RT7a1FQ45gJSUamnxvXF/2PDs3FG3e536VKFEk/0/LzLPk/WO5/2WiKBO03y5KL6kCzpMyMELNVQldKbsC4STn9f4hH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791757300; c=relaxed/simple;
	bh=Gz259xWDpmT5yaeuNlGQvpIy/TCwlx+3f8k5yF3gP9o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TBygPtto6wcv+BEuMUiPkn/yI9gNVR/6Tg0EAugjoAt5y+O7FdRGApovmKUB5ilkOOEEhhU3V5O+amUbhVc9TrvthjrRGn+1AMcRotTtTMBqmM7LE3+oKoySfAX42Vy7D0aktQdayQb0SGjGAbaSzu1wG7teKFnwNRwfjNaatj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiLTzpJu; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiLTzpJu"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-359d729379fso569080eec.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791757298; x=1792362098; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VKwp/HZCGNHqzQLg5FaubiD1lrh9fuuEwHrXkpVQ2NQ=;
        b=HiLTzpJuvYch1pHIYU9YxZ+kTCbYiXW182k5egKSfNAiWC4yShc2VSUHE6rL4vt6JR
         s83rbfmDLBv333hdzysaZsAue/QEKRDPPEqUqge7iAwjNfo3fgeee3Fp26TkdGp97joD
         ijGGwLPTxNVNkm03K0fKbiB6R7vpv9g21WXqDPSPx7WPd8rX9dcf80MKz3OEdjNDlFdN
         XS529DK3nIkDwT/24xUurwspG2VnT41cOdkRpfBXivlPkJv+4m+NY6VcTRT1d5NchMEM
         GJrYhjoXiocNjUxBUiUCp+ed/zOomPQEMrODtX3drpHFjq659RKd31CSHdkKDV8ReUMR
         bk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791757298; x=1792362098;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VKwp/HZCGNHqzQLg5FaubiD1lrh9fuuEwHrXkpVQ2NQ=;
        b=Y+5BRM8AiUkkHZTmA305UMJnRS7n7Rw3KsrdnFkYAao7rM67D4FBOEaf8y3e2Mi4bO
         dmODKUMvhNP6DFk/J7FGMs1+NoOCKxeX6im4E5us6lPA3KQTswTmcyI+JxH+VzBiBAg5
         sIwrKmXuAS4szRX6aHxuApWxrLhf/j7B0ZGefqyng/YGbBLa/g3Vav6K8n+B2p0dCauU
         gOtxNi21Qv32n0jxmMDvDSXJL9dH3pM4L8zSWxYi0FSC39alk8tWUNwNoVgrFcEZpVUf
         ch/nG/Yk6IPQDfmmekNAEsvsTLGsOqmQebHgMK2yGpD4jK2KMaSknQrH5CQ9wViAqhI8
         rYbw==
X-Gm-Message-State: AFq9FYItBdAcT0kFSwYffGbfNY1Zu6iZrDSJsmN9Oj/stQy/DmbI8xdS
	0QdlzOdRJzjzljDPxIty+UFDJms/dQsS+0ymlCvgQuAoy3IfFOA+Ymww2nVsBOdL
X-Gm-Gg: AYBFou0xZGPQHDsRPFN30/ydBOdhpvo+K1z0zdb8n/7NlkHUeJ1CH0grNwck+ifO+Sa
	hjPYQ9sgKH3WdKz2yFY6fbBS1IxO9DMI4ck6VC/VW8SzMJosWXZuZDsruwpJyUO1wzVdzJAwb0N
	M5y1lFete5jLaFa85o8swSFg6/NAALmktTnlYEJbUll5O5BvfGHGHx1F6waM0D1b4F60edsLj4z
	SO+ecuBYfFWB3haYW4jJcNrYEpr7JdFqNr6ztO/5zGs15FNu5Bzbk53HGV6HoU1XAlE8eyAgny4
	D3VdTVEGXP3BIiPGlUhI0WaTKcpRVudlNQ64HwPtpIPzO5yvqK9u2nEEWZPXhqNtc292D+LuMIK
	QnBlFOxUrT/2PfSYPgPdac/VVMTZRY8JrWpVYQwGWkDYSh8ceSAnbLMkgXmqEhfUeaowIhzaZa/
	/nYtTj9F7NVG30onzMFQabv2SRyTXaT+RE2/WbQmmheVSdVOTsbNcZKVwDrMf5Z6OjWjZkVZl1z
	xibGhqUW/Y=
X-Received: by 2002:a05:693c:60d8:b0:35a:6891:96f3 with SMTP id 5a478bee46e88-35a6891a75amr2581275eec.40.1791757297498;
        Sun, 11 Oct 2026 15:21:37 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.103.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm28668552eec.27.2026.10.11.15.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 15:21:36 -0700 (PDT)
Message-Id: <2e12486c0d5dd8b94393b08413a85a8d47f86edd.1791757294.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.v3.git.1791757294.gitgitgadget@gmail.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v3.git.1791757294.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Oct 2026 22:21:32 +0000
Subject: [PATCH v3 1/2] blame: harden ignore-revs parser and tag peeling
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
    Ravi Mistry <rmistry@google.com>,
    Ravi Mistry <rmistry@google.com>

From: Ravi Mistry <rmistry@google.com>

Currently, blame.ignoreRevsFile and --ignore-revs-file only read paths
explicitly configured by the user, which cannot point to an
attacker-controlled file under Git's threat model. An upcoming commit
will teach git-blame(1) and git-annotate(1) to automatically read the
HEAD:.git-blame-ignore-revs blob by default if it exists, exposing the
ignore-revs parser (oidset_parse_file_carefully() in oidset.c) and its
tag-peeling callback (peel_to_commit_oid() in builtin/blame.c) to
upstream-controlled content at a well-known path.

Harden both code paths before enabling the default blob:

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

