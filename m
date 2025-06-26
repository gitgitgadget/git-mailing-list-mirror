Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7421CC62
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944219; cv=none; b=Out2pFGJudAeKxtKCf4n8fYFopnViEcqJ0GSB6lRTTzRFYGJJ+bwMkpO5Rz2cj+H4k+tYQ6pzSwl9PoOrCs7cPnBWgUXrhNY2OT2bCmyxItsbfX2qkXSF6r42mKMPL+f6tvhdalpde6FnTQvFDLkwQUishdcsoBgeGEmZbMZZxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944219; c=relaxed/simple;
	bh=pUurWL7Q7PH4Y6spn7H6jnRWt4JnQPEpDOF0MzfYvv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUcacEhZ7MHY4OA9S/qm8sk8A/W2q8G/NJn8TjsUhXCt6lqkhdPlkEIEAiHcF///bwDORkBpNL0lrfS9atowIRxnz1uSCy0WPZpHImduuaquaZJtmL1vD40qUG2q51kEfnpxq9DuKMevHARWuc0ZOHwGOQvk+NYNEATSWkaohnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJFaH2CS; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJFaH2CS"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso858141a12.0
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750944216; x=1751549016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2t9yzub1kSGXfG9WpW6PhENOkQvoIuA1KBTSIBaDL0=;
        b=dJFaH2CSMi9b93iWilSxKh/jcg4w/DrQxz6f1Toq77L7aUeF8dy0pjjA/VyWJ/SM2D
         8JHcz0IbYb1dD4kVL7u9Sw8cLgZG+LckcaXtKnnpYSHLnrgUWxJTWFkcyE7xsNibiVmS
         4BBHMNUzJQBx06dTX+JFtuzzNhv1thS9Pxu6TAgC17sx0MJiqzk7PbUahr9rifXfwCP7
         +jwnA6AUVYdcMzyXJ2XwKEAQPpx1Ccbhg5KsFz82JpsLiM3dbTMw5QLMZn2GBCF4QWr0
         t6X/YcUfZbZjS9wcDw7M5bXFbJBJdPCzNzASoXCf6rYjdELnHc2gQNHmL2RZZmP3Es0I
         g4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750944216; x=1751549016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2t9yzub1kSGXfG9WpW6PhENOkQvoIuA1KBTSIBaDL0=;
        b=J8swxVGVgmqkP3Re8Leysv3vwiRlXin7ooidAWmtvFkxVzEjzMFDCbR44EWKF8inh1
         en774mVDP/CpZHdbwh/v7+lFZvOugfbPA1wMQcNBPrjiW78jcBxWAWrEMor9BTV3nERe
         B4wWCgPaE778iWgBqdqGdVDtDHR2SxUEQklKbvotX4+vEXkmpMH6XXALZg2cPJcAB6+1
         E/E4L1D+SBoitbcFOIbDdTXU1jeQTRZYUhnCrOuj9Ood00/noygEJWXda5R2ZEn3fkFf
         dDi0UZQA0IiCN9aAnTu10FfsL6pMthBWObOvUr9cA2Klif7mdRpIh3P4D8nH0meUUVot
         1CFA==
X-Gm-Message-State: AOJu0YzeVhMCEo9RI5y5FhiJ0ncpyfOr7U3Gkh93WUAHzBKuXz86ymsh
	W/Q7SrTdYqXnILPNSx0vWQRgJNFwED+QewrK8UAqM++OFNkq6hpOFkJ2L5+LxE3hucs=
X-Gm-Gg: ASbGncstMI/Njs6qdHiTjyDoS+EWxel5smbz47PZxa7CX2EGr8I4VoB+zfM0dQ/uSmV
	LVg8detJCV/arQheVJe354RIrf6wqed7qgxN8V9oHsvnD4Eu74oubT+tTUo3WkeAdnoZjJOfM7Z
	+bDvbJwajk0Ju9zLXJw4VRsc/Fqzg8pXCDNTt8d2muhN4/v5gyySuOPAyeg6wDSeBFI+3OYqwOZ
	NGMjhamr/IZdqvfc4CQVXRWtN0zCczGdd+xCiCpjNIIvJPV9GvRjpBKwyWs3C7+mrR7YQQVzy5b
	Mj/mApj8yyIFl4hEen4xdi2bAL5JM5Efp4Mzw6Z0PSKY/yL1XJ8w9qemGVnuanTXtY6mkRflbOl
	0RStm
X-Google-Smtp-Source: AGHT+IEUFrOMqWUHUSFdTPe3yaqwNdaeJZv3fs88W+GeAdwTEjWMlygbCOBbb90jl/jxLsASWs+Iqg==
X-Received: by 2002:a17:90b:38c6:b0:312:daf3:bac9 with SMTP id 98e67ed59e1d1-315f26ae21bmr8061461a91.34.1750944215786;
        Thu, 26 Jun 2025 06:23:35 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c96:9e23:a08a:9fda:a9ee:44b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f53edd8dsm4245936a91.45.2025.06.26.06.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 06:23:34 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	phillip.wood123@gmail.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [GSOC PATCH] commit: avoid scanning trailing comments when 'core.commentChar' is "auto"
Date: Thu, 26 Jun 2025 18:52:33 +0530
Message-ID: <20250626132233.414789-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
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
`84c9dc2` (commit: allow core.commentChar=auto for character auto
selection) but did not exhibt this issue at that time.

The bug was introduced in commit `a6c2654` (rebase -m: fix --signoff
with conflicts) where Git started writing conflict comments to the file
at 'rebase_path_message()'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---

I came across this bug when working on a patch series that removes 
the global variables related to the "commentChar" config options.

 builtin/commit.c           |  6 +++++-
 t/t3418-rebase-continue.sh | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

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
index 127216f722..a8e89a250b 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -328,6 +328,24 @@ test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebas
 	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
 '
 
+test_expect_success 'no change in comment character due to conflicts markers with core.commentChar=auto' '
+	test_commit base file &&
+	git checkout -b branch-a &&
+	test_commit A file &&
+	git checkout -b branch-b base &&
+	test_commit B file &&
+	test_must_fail git rebase branch-a &&
+	printf "B\nA\n" >file &&
+	git add file &&
+	write_script fake-editor <<-\EOF &&
+	exit 0
+	EOF
+	FAKE_EDITOR="$(pwd)/fake-editor" &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git -c core.commentChar=auto rebase --continue &&
+	# Check that "#" is still the comment character.
+	test_grep "# Changes to be committed:" .git/COMMIT_EDITMSG
+'
+
 test_orig_head_helper () {
 	test_when_finished 'git rebase --abort &&
 		git checkout topic &&
-- 
2.49.0

