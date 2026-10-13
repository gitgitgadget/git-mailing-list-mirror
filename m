Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702352ED20
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922936; cv=none; b=bmqYYfe2rfpJSPglCmOHyjrH5R5Ldn5O9FcvBJyJqfLTniH+03vt/yugwMXV14aTAoEb10ML2ynK3lCVBxbnryatVO4jpZnvzAGMar7IQmL8n/jybXNOn3RnJJuwHkqxlVpsEVLCh6XWVfsvqNoNBaMDL7qiPaKFu/awMpGjRLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922936; c=relaxed/simple;
	bh=L5CYe3O1suOe929u8TQuAHm/UXhuDNmIH3cmnNc59Gw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WrXl0K77LwqEWiwmkV894qXx0bkn2RNG3Fvrwiy6b19K7Y7JqpqBDjlEpLCaWea6fdEQcKOR7FbdqC0mTu8zi9HlAEfQpReFTr/Kl2yxSFoopGpxVk72OKZD6XDh6xbaTk5HtuR5Vw7pudvTT2Azn7PpBnfWD/2IOhRcM1EM5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRAWdEbx; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRAWdEbx"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-490d838b425so1967977fac.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922933; x=1792527733; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9CQSEsqMsStLU6J4arcPuaXlaUHJGbkPDn3yNJ293jM=;
        b=dRAWdEbxvxLrRQN2puWync//fCksv0Wr/goX3wygL7rFglpvpLA5L8mTuzmG7kOM9d
         BwDukfPR6hXLESli8yL6tRqEARQySsnoF+XWnOkfXOd/h5WnmeqTjyob6YlZmQ1yJolv
         cknCjAI9gRkbUcg8X78GrmtG6UpVYouTlPOmhI8tapWCM/rmz1iVY8mMyOonR60+xVGu
         WaXZsg6MMR+wyT2VG+ewskkFTHDo/HBuWE5i46++qtIo+e7ZewtJ19JEyWZNUuhv/YfT
         wbAMucHd3fswHIFJrwiEmF16myfPCfK3aeel/J/1MBf+2h2wlBlAz262D8OwnlEMY2Ya
         5WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922933; x=1792527733;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CQSEsqMsStLU6J4arcPuaXlaUHJGbkPDn3yNJ293jM=;
        b=A+HZxsx1SIk4ZmMnDv8QOerBczPe6pbwge8NlMdSC4idWRClZy+t0rD727tTLTXTx9
         WRNNz/ntfFAmB2MuOcJNQvf6ekRfca+Rk59ApBn4apAtaniJy0uQx1MNyv++yEnsobA+
         IhtU2a//HHPJ6XHOVae5kavtbbWbCy2npmBdGTRH/C5weIDdfCBAta5xZYC7crtaNjPN
         B02Q2iAl6tq3lJew81mLwJUmT+JhzkUCtx3TsR6noD+GIEfhO8kipqTtKbGAV3Zqe0m9
         6HLEu0YD3U43vMpqpZnjgwMbw92RYAh1lGzN19gTsQaBRtXaESIpLJErZr9KVoghCGv5
         6VGw==
X-Gm-Message-State: AFq9FYJ3KRbv+k2sSJaTS5uOimo5U05ZiSEX6UGFh44il+x7akFk3Bc0
	Z47Y2zOfhrbKSJXw4uCMZyu4oUuSJCKSPX2X3q05fy/y/SU9OR/Dm135NgY9bg==
X-Gm-Gg: AYBFou3+BqZWNHeNTOOfKXnzkc9XdmDJ1BrQQHkLD40O86wfIee2MJV6D//ykgDDycY
	1yrGYQcKI9ZtLcrQBA/vADDMJ74eZwdxtWtukRJYY8sf5G0yuDB7qqz5AhRDGFf/sBU9k0QCxYp
	eBXWMkZL+I/5bN31Iwz6FZjsC81O96szku7KPPXANEdTyhBFQ9gXYQ47KmBPldXrDZ7sjzdsIAS
	KaoyyZLTLvuubDtal51deXTvKbpeWPVQYQLctuUJp78XN8Et6FkQiV8XYT2HxYXo25W2RsQemH8
	yrRk9YbBBuXU/9Ak1wiCPiP7aa+UrbHU4URi2dIT2/jKepPpQYAqD1Lk65TjgdAXScIyVXwl/Xy
	1dat7y5O1FxOT7SedWa3N7rLf/uOMnnkSV0JACjSG+/vwKbhex9IZSzFzMYT8auc+lPOwKolPSN
	CVqCzS4HGK3coOh6dcxtdWtYzMzrFOEEwfkROmbW5V3DJwQ6u7eGJjTnxbTuhaSXWCZKUWuDVQ4
	A==
X-Received: by 2002:a05:6808:191e:b0:500:5e36:3a9d with SMTP id 5614622812f47-50c54f02c2fmr14402990b6e.30.1791922932882;
        Tue, 13 Oct 2026 13:22:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.15.229.147])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-518a72a6048sm9844967b6e.5.2026.10.13.13.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:22:12 -0700 (PDT)
Message-Id: <e9b2c1dae2cd11783a66f0afdce53dfad78b43d8.1791922928.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.v6.git.1791922928.gitgitgadget@gmail.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v6.git.1791922928.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Oct 2026 20:22:07 +0000
Subject: [PATCH v6 1/2] blame: harden ignore-revs parser and tag peeling
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

