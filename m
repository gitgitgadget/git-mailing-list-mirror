Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91372613
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307958; cv=none; b=fWMOqAvD54tZsEJfpGocmn09jrmJSX6UW7+AE0YP0jnGnw08fNH2nvtOsggaRA36pNBUxVZwgt4wN0aGsWRmLbVKWURpCTTGQJazuRBOlOlSBM72LaQLTkxWJaYJ7lNtERRFfn5tt3tGb+CKSttLUp7LZYOeI+79BzHK6xsnXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307958; c=relaxed/simple;
	bh=RA86GvJADDRxmp+wO/t0AFE6tShZdF5O6EhDnN3TCDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNLOCu4/6hwj3vx+hVeXLoPgi1oDPiy6VarJFHKxw/gWbOQqpt6NgftAVND1vWatObmv30nOtEoO0emDU8dB5w+Y8tgFkX/t+0L5jlCN9poZgU/8BX+C6VRY1kYjh3nS382/cGyYGfRnj9TI3/cI1MnPUjVCq41nziee+qO+4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ki+OAgG8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki+OAgG8"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-236470b2dceso19386075ad.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751307956; x=1751912756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBIq9Kmu0yuwBLXLzbyEKbgUxVBXlCcznhTT1K8RfAw=;
        b=Ki+OAgG8q3EnpnLRH2WzJ8o5jZ64ggfdkKwIsyOU0wY2LbewTheycaAi9uRA786mV4
         aDhJ0dsds6RVlvcq3A3aQwr3ILs7TPAK9NZSEYtQru6+M+wpLALWzRiIFqGtfv7Yw7as
         4n0eTix8Juf+ur+BQFK9YzVz2bxte4sDqK2OY6D5NuO3D25cMh+o5UKl9sCFb2z6jkLm
         sjDXylr9qpXwpx/FjzSUIdr8AZblwTdr65hlB/ergnkXdhMDfpY/A44eidDQBjkPmimE
         WosQcS6rhjfQmtHSz/G1GRsybHUzLiZm8VcOo3xTKcVIsVRp2VakLJrhxi3wZ/tv9irI
         3Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751307956; x=1751912756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBIq9Kmu0yuwBLXLzbyEKbgUxVBXlCcznhTT1K8RfAw=;
        b=KDSLB1scbYwwzUcmSSW2BfPQxz1cJHkJMLSu3jB4KesBKlA8ft12mMuri13cQRcE2T
         JpTrt6t72fU/uq2jePST4dnY2rqbrkm/LeHlVrC3SFqt/UGQT6rd2gTf0LR4STMhPwxI
         aBCBdM4hAy14FsjGozTHQx5XRY9lmL7Xr2q4gqNVY+vAYKgWS/Ry3ZYGy+vES1SFwv9D
         EShL/SK2wawJ3gwb/pzaNfE+h5Jgtq+G8ftEDz5ud2lolIvvgX04jdy3Ti75fNxCnd8T
         Xjoh4la2PT0S12CVg2CosYgaLY0xfwsq/Hj3ngIlzLt5iLa69/fUpCE7gqFWUAusGCVl
         lnyw==
X-Forwarded-Encrypted: i=1; AJvYcCWy/g6cAkzDcEYAH2G9sTeM8oKNa6RiIckDS0IbiQZJrvuavCvtLdmXG1nY4qQt+qddlMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9OjNzTVFKYYXYzKUoRugDhboIbcEZ7YYQrTJr1hqY4FjFobC
	F1sRkQjPBCl44Qjy0PuoG5hpqjbLIQCngYWWZS/N1ojLNnpF8FbYJPWo
X-Gm-Gg: ASbGncuyoW7/NRkbOskS2I0vHn5RfkcFZuArzkOJbiOfNvLkAETeDYOM2nOzucS0dTG
	R6yewFAEnfKTvFOVxMszh2LswhpJit6vApXE1fh+Zm8KKSq6uQk7ys2rXK6HlpilIsz7usSq2IT
	bMOSH7srnP3Jg+00onWs0ff95mvaFWR+vJwtoVXc2hlibRpBm6O72deVy8G0j+a/YfidaYNFpWh
	7GAMs9qaEQoQhbIjPCLNUr4RyyPVos1So2SN6wb8WFFOv1WLjQB3TEZniFxlMIm+ZMFMGIx6J0B
	nQIYR4Rr9SXlhuk5ecZvRIMcnPfuoACCws1WCshYYOAjnyBtlfQqR0nOhkFII1qqAPh8T6SqzFV
	eBFOV
X-Google-Smtp-Source: AGHT+IFHgd2VPf+0495Ww8vI+T68d0gKWd8pym3HbvWqlRAesYBooTe/EggzaVwd0xzHJIS2VahAPA==
X-Received: by 2002:a17:903:1983:b0:235:1962:1bf4 with SMTP id d9443c01a7336-23ac3afd47dmr207882945ad.14.1751307955436;
        Mon, 30 Jun 2025 11:25:55 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c20:3d25:645c:9adb:1b15:c2cc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f542708esm14367030a91.30.2025.06.30.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:25:55 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	phillip.wood123@gmail.com,
	shyamthakkar001@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v3] commit: avoid scanning trailing comments when 'core.commentChar' is "auto"
Date: Mon, 30 Jun 2025 23:55:27 +0530
Message-ID: <20250630182527.69167-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626132233.414789-1-ayu.chandekar@gmail.com>
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When core.commentChar is set to "auto", Git selects a comment character
by scanning the commit message contents and avoiding any character
already present in the message.

If the message still contains old conflict comments (starting with a
comment character), Git assumes that character is in use and chooses a
different one. As a result, those existing comment lines are no longer
recognized as comments and end up being included in the final commit
message.

To avoid this, skip scanning the trailing comment block when selecting
the comment character. This allows Git to safely reuse the original
character when appropriate, keeping the commit message clean and free of
leftover conflict information.

Background:

The "auto" value for core.commentchar was introduced in the commit
84c9dc2c5a (commit: allow core.commentChar=auto for character auto
selection, 2014-05-17) but did not exhibit this issue at that time.

The bug was introduced in commit a6c2654f83 (rebase -m: fix --signoff
with conflicts, 2024-04-18) where Git started writing conflict comments
to the file at 'rebase_path_message()'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---

Thanks to Christian, Kristoffer, Junio and Phillip for their reviews!

Range-diff with v2:
1:  4e74e7a9a6 ! 1:  693f890a36 commit: avoid scanning trailing comments when 'core.commentChar' is "auto"
    @@ Commit message
     
         The "auto" value for core.commentchar was introduced in the commit
         84c9dc2c5a (commit: allow core.commentChar=auto for character auto
    -    selection, 2014-05-17) but did not exhibt this issue at that time.
    +    selection, 2014-05-17) but did not exhibit this issue at that time.
     
         The bug was introduced in commit a6c2654f83 (rebase -m: fix --signoff
         with conflicts, 2024-04-18) where Git started writing conflict comments
    @@ t/t3418-rebase-continue.sh: test_expect_success 'there is no --no-reschedule-fai
      '
      
     +test_expect_success 'no change in comment character due to conflicts markers with core.commentChar=auto' '
    -+	test_commit base file &&
     +	git checkout -b branch-a &&
    -+	test_commit A file &&
    -+	git checkout -b branch-b base &&
    -+	test_commit B file &&
    ++	test_commit A F1 &&
    ++	git checkout -b branch-b HEAD^ &&
    ++	test_commit B F1 &&
     +	test_must_fail git rebase branch-a &&
    -+	printf "B\nA\n" >file &&
    -+	git add file &&
    ++	printf "B\nA\n" >F1 &&
    ++	git add F1 &&
     +	GIT_EDITOR="cat >actual" git -c core.commentChar=auto rebase --continue &&
     +	# Check that "#" is still the comment character.
    -+	test_grep "^# Changes to be committed:$" actual
    ++	test_grep "^# Changes to be committed" actual
     +'
     +
      test_orig_head_helper () {


 builtin/commit.c           |  6 +++++-
 t/t3418-rebase-continue.sh | 13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fba0dded64..63e7158e98 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -688,6 +688,10 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	char candidates[] = "#;@!$%^&|:";
 	char *candidate;
 	const char *p;
+	size_t cutoff;
+
+	/* Ignore comment chars in trailing comments (e.g., Conflicts:) */
+	cutoff = sb->len - ignored_log_message_bytes(sb->buf, sb->len);
 
 	if (!memchr(sb->buf, candidates[0], sb->len)) {
 		free(comment_line_str_to_free);
@@ -700,7 +704,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	candidate = strchr(candidates, *p);
 	if (candidate)
 		*candidate = ' ';
-	for (p = sb->buf; *p; p++) {
+	for (p = sb->buf; p + 1 < sb->buf + cutoff; p++) {
 		if ((p[0] == '\n' || p[0] == '\r') && p[1]) {
 			candidate = strchr(candidates, p[1]);
 			if (candidate)
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 127216f722..b8a8dd77e7 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -328,6 +328,19 @@ test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
 	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
 '
 
+test_expect_success 'no change in comment character due to conflicts markers with core.commentChar=auto' '
+	git checkout -b branch-a &&
+	test_commit A F1 &&
+	git checkout -b branch-b HEAD^ &&
+	test_commit B F1 &&
+	test_must_fail git rebase branch-a &&
+	printf "B\nA\n" >F1 &&
+	git add F1 &&
+	GIT_EDITOR="cat >actual" git -c core.commentChar=auto rebase --continue &&
+	# Check that "#" is still the comment character.
+	test_grep "^# Changes to be committed" actual
+'
+
 test_orig_head_helper () {
 	test_when_finished 'git rebase --abort &&
 		git checkout topic &&
-- 
2.49.0

