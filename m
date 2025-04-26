Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFFD1C5F05
	for <git@vger.kernel.org>; Sat, 26 Apr 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745651459; cv=none; b=JwNxNVcFU8P/9Uf8V4ZBdsYZ7JRcOr4VuMpj6R+wA5IrlxU/z97DbXUP9LBbpRs4olheOJP7ovJCWHH5r8ab22CDz+618l75Yj0uh1nry5ok1drLGcrcnyzANEyPhKTK+UlXEspVf8EPlfXZc9e94Ww+Q4MzKLK9YAqRUHbG85I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745651459; c=relaxed/simple;
	bh=dmuoKojJKshfbZFLbfPbIKSF3HQxHAlGmcGnSaTScMo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=hke/VRzLeR3cuSuwvn4cGioFRQ+zsVQyToDC8f0rNkWWTv77PWOJlk385JC6Q7sxqgIhRTnr74WrJGG8TFZ/F+GNhGj2poN5+EzdiniMMMxuJ5n1oTf2UAGBSsH9qPmggxl9LEMB566yu5upBUT+p+PFcKvKZIXisuQFZB3y4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyfKx2gR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyfKx2gR"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so13047145e9.1
        for <git@vger.kernel.org>; Sat, 26 Apr 2025 00:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745651454; x=1746256254; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BvSgg/PEzsXVpAv7yXEiDMrcGZNhLscfhME6/GR6IQw=;
        b=kyfKx2gRZzRitv+5Y7GaRRjxzOn0H3w8LWC7vcke4Ls5J8u59B0P+b3/Y6J7JGPKj9
         1WGmBXXUdAY3cMzyqAglL7YuwvFzeivUDfKFCxnUy/abQBKgfgFivnlvvyW9ApNASag9
         SZ72Ufy074rwDR5Eg6YIo2PSycvDAbaPGYxejhjyPfPvo9+PTglAsTfVagvlddbV3TSl
         QQrPjmMvtGztfK2dK62KXtdKvH9ZNSnBvRqoWIeyajoOe9tdAQJ6Z6R+bddrxJSK8Dvw
         UJxwz7lq090JzxllNULLJ9HgeZ7BgTvIz/AXw70mVc1OC/Oozhch1SwMydZVPSYW8BoT
         VjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745651454; x=1746256254;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvSgg/PEzsXVpAv7yXEiDMrcGZNhLscfhME6/GR6IQw=;
        b=X8tkHVNJlYMufaVIf0r43CsgEQP8+qJ0UF1gI1nkrhvIizRHHuKqPH3go5vURJ94sL
         rmmlkb9giz8XjhQxUxJiB56PUpu6HTSHqMj0Kt36WSkhiyYr2MYbVk+50jfaWSJ8oeJf
         Rk+ajtZ8wTTlmmmDCRTz3u41JHDtWcZUcIpBCQI55yDiTaXEsoeyFALB8Al/DAZIhDDY
         MJIJ5xtDr28cJnE18qS1TPYDGxVkJCjq6VaGg5t+iZdzn6zdC/qkkZTOynAhPPTKxK4k
         2T4uIlchg5sXQTz1yUo2cW+oJYy77BNdnnnLG/4VHaEgZCV9/5vg0vd9+9jfaOqSK0Rh
         0SWg==
X-Gm-Message-State: AOJu0Yw+GDVxp91uzDU2w3PWRgnXnSprboQWoOdQXtVpvaBdRNdpSnIA
	yS00Iuo+XOp1ikmLiKjFclEV7Dl7n8ngn+r7HiuNuKgUWK+8mfysgwqadg==
X-Gm-Gg: ASbGnctSXFlRbY4939SBsvwRZ9d5jWeJhNyG3XoX+VFao8lrrVfiakFrh+C/GCAEO5V
	0nyvoBwyHMGS7kouwnxtLDw6oO1RdPWiXwhRmrJelDhWqbE8QL8TeOO5trmtk8stjB5ifxtDty6
	Ejq4CO3Tr1fmga3xucRdmYROcR9Tnnywtg/FLguxQtkA288hKG3gj6Z3pQbNKmc/OgzwInhdCRV
	RvHhcAuRX3xtyfGmHpm1igWmymCuaiODaJP3eTAUdXnb+pbTodG3aB5YpbTVr40SX9FKKJ2e7kl
	lY63feMJpab/yaiDKVFHtCyllZtUS/KHtPhcoPVGtA==
X-Google-Smtp-Source: AGHT+IGPyKPDNZMKxvJKq+EdiznRjF00dpd5V3ig8jLKk+cbU051J91AaWNuJlmjdiLYfXbm3bxshA==
X-Received: by 2002:a05:600c:4509:b0:43c:f8fc:f69a with SMTP id 5b1f17b1804b1-440ab77d34amr15102625e9.4.1745651453898;
        Sat, 26 Apr 2025 00:10:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2ad112sm79908885e9.24.2025.04.26.00.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 00:10:53 -0700 (PDT)
Message-Id: <pull.1903.git.1745651452869.gitgitgadget@gmail.com>
From: "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 26 Apr 2025 07:10:52 +0000
Subject: [PATCH] replace-refs: fix support of qualified replace ref paths
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
Cc: Tao Klerks <tao@klerks.biz>,
    Tao Klerks <tao@klerks.biz>

From: Tao Klerks <tao@klerks.biz>

The enactment of replace refs in
replace-object.c#register_replace_ref() explicitly uses the last
portion of the ref "path", the substring after the last slash, as the
object ID to be replaced. This means that replace refs can be
organized into different paths; you can separate replace refs created
for different purposes, like "refs/replace/2012-migration/*". This in
turn makes it practical to store prepared replace refs in different ref
paths on a git server, and have users "map" them, via specific
refspecs, into their local repos; different types of replacements can
be mapped into different sub-paths of refs/replace/.

The only way this didn't "work" is in the commit decoration process,
in log-tree.c#add_ref_decoration(), where different logic was used to
obtain the replaced object ID, removing the "refs/replace/" prefix
only. This inconsistent logic meant that more structured replace ref
paths caused a warning to be printed, and the "replaced" decoration to
be omitted.

Fix this decoration logic to use the same "last part of ref path"
logic, fixing spurious warnings (and missing decorations) for users
of more structured replace ref paths. Also add tests for qualified
replace ref paths.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    replace-refs: fix support of qualified replace ref paths

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1903%2FTaoK%2Fstructured-replace-ref-decoration-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1903/TaoK/structured-replace-ref-decoration-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1903

 log-tree.c                       |  5 +++--
 t/t4207-log-decoration-colors.sh | 17 +++++++++++++++++
 t/t6050-replace.sh               | 10 ++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index a4d4ab59ca0..6a87724527b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -163,10 +163,11 @@ static int add_ref_decoration(const char *refname, const char *referent UNUSED,
 
 	if (starts_with(refname, git_replace_ref_base)) {
 		struct object_id original_oid;
+		const char *slash = strrchr(refname, '/');
+		const char *hash = slash ? slash + 1 : refname;
 		if (!replace_refs_enabled(the_repository))
 			return 0;
-		if (get_oid_hex(refname + strlen(git_replace_ref_base),
-				&original_oid)) {
+		if (get_oid_hex(hash, &original_oid)) {
 			warning("invalid replace ref %s", refname);
 			return 0;
 		}
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 2e83cc820a1..f80684efcff 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -131,4 +131,21 @@ ${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	cmp_filtered_decorations
 '
 
+test_expect_success 'test replace decoration for nested replace path' '
+	test_when_finished remove_replace_refs &&
+
+	CURRENT_HASH=$(git rev-parse --verify HEAD) &&
+	git replace --graft HEAD HEAD~2 &&
+	git update-ref refs/tmp/tmpref refs/replace/$CURRENT_HASH &&
+	git update-ref -d refs/replace/$CURRENT_HASH &&
+	git update-ref refs/replace/nested-path/abc/$CURRENT_HASH refs/tmp/tmpref &&
+
+	git log --decorate -1 HEAD >actual &&
+	test_grep "replaced" actual &&
+
+	git --no-replace-objects log --decorate -1 HEAD >actual &&
+	test_grep ! "replaced" actual
+
+'
+
 test_done
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index aa1b5351873..9b06baa1439 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -546,4 +546,14 @@ test_expect_success '--convert-graft-file' '
 	test_grep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
 '
 
+test_expect_success 'replace ref in a nested path' '
+	git cat-file commit $HASH2 >actual &&
+	R=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
+	git update-ref refs/replace/abc1/$HASH2 $R &&
+	git show $HASH2 >actual &&
+	test_grep "O Thor" actual &&
+	git --no-replace-objects show $HASH2 >actual &&
+	test_grep "A U Thor" actual
+'
+
 test_done

base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
-- 
gitgitgadget
