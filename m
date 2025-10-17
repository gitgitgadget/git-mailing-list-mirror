Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2BC231A23
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760671053; cv=none; b=n2CfCpbmJc0fnpCH2PRXLdZ+SQMVTuONQQgvrDRZjH/17fI/rgmR+eqYw1VZAgSk5WFvaoBm6wXw9MY5Ns12rt/49xGzbrkgVcFXDYY2yv+KVcbOTlP7ZRy/C6LbXRv/fa6bRK9dkfPOYGY62Sqn2MBy8NhzwrGfwPliuKPMfeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760671053; c=relaxed/simple;
	bh=/lQH8Dk0DePpOztUSkERPDAN17csW9rIa1OiHW9ziJ0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fARupB7AyrI3lApELW5SNOXSZ4vigHKaehmiEg0yl6GRo3ORiW6F2tzP/YCfojNc2nj2gEoo6rq4463/HXz+dO/DfoyngYkcGJti22RTOQB2xlPXbVyxBCMdWf1W4mePNyJTM1Y9WhfATBStISylVdmF9FFlTdaSTdcWer7Boiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kn00KQ+P; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn00KQ+P"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-339d53f4960so1473370a91.3
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 20:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760671050; x=1761275850; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dBargCkOfeYpQ6FJ6O5HiPgyOAJqHAVBfmVpWaT6z6Y=;
        b=kn00KQ+PTgd9u0Db0WYvdXIYksv0SPtYvBk8qingvcEaP1VCGFSmCP+gD62LPbCeY4
         YDgs6viBRZ4D8orABQk/QMi+s0kxPTCGyJKujDXNihAiQnM25vFTmbU/z65i5zo3YD17
         hU4J6Ns3WOVKcll8VTTjK7VAhocyNZmyUyRFLfq/b2+rwU3drgvB59HDgv6UV/UFJLia
         3HE44cvZRAo9MkvnP9d1wIfMDDrZ154Qxvz5Nae+W34e1ei9og9hYRV8k2K9siK8n1PN
         W1Z7ValH+fwfDF73hMWRL5zQ32HokxktsfqI5dcpI+q+qOjmIu8dTr5OyTA7rQyAed8x
         Gq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760671050; x=1761275850;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBargCkOfeYpQ6FJ6O5HiPgyOAJqHAVBfmVpWaT6z6Y=;
        b=vBv1KkPLe1ymbmwiiqqDF1/8s165oFsWvaKP1eeoZ5e9sKALcPX/raPZ0yjzaorKsE
         uf3Vkz0S2sLlhZ8QJKXUY++lYHgfYTpaHr2qDJqVJFj/3HRbbdBcN0koUqqPhvCoPEqO
         JHl6RoqpDu/aP3yrqrIC8ZFqYdBoXNUqIY4WC92mjZrKbXsmBWxy5QAV/GjtDfU81LCR
         IfnvEbBuEp11dQ2t/P5Mm9xG5EdB4F6M9rZleN4h4cOSViRPLTLlHuooc0CT3Ski01d9
         sb88Ni6izELinUI49a4PtPoSTUDJT+YoJhXgA4XXL4/2JRwyLcFO+Q0qEsogV78lXf88
         wZlw==
X-Gm-Message-State: AOJu0YyhpPoJSo+1jkU9K4XJPxHUb0a8N67T5AkOsc6xfXlsvczKPSPA
	6Fafc83+9A22GGtXS+qO2947qRsuAMAZ3uilDB7agNSyIE7D1RHDsWEs2fV42g==
X-Gm-Gg: ASbGnctx670/2uSJK1dDP4Y960hKZKDt/Nd5vMzukuVe0Ua+hKccbUZG2F9rthuA3Z6
	p6fa0CVHM/v4sSGKYcj2TnNmFjGjowrn+/sL03jDwC8oGNOpelw54HU/xk5IY+DvdN4l2eHNzar
	cuEeTh2aeILEoVw7IVuEl686gDy0ciX/uVkl0JluetQ/4WqfDjDMnaI/EiYZsugqdrUY/sM0k8U
	xOTnICF/1I2lB8O6+jpthBGGpgoGlWC7dINq7z9Z41HNsIp6Pn+NWFEhlnySMrzD3DvBKYOkKCA
	3jJARY3jyHjAHEHUM9GO4osTV3z1hrJF9YxpjunWLKfkdTTBHyZ6a45c6Nc7YMYglBTr5bJC7sy
	Se5sJWE6Eb4BZTNtLfxcf6Rp30kjHQzdJH5XX/RjHAQKY6IEwiRYZTlOD3MsGUFefLrkuNv/lKu
	sitw8b
X-Google-Smtp-Source: AGHT+IGHn52sYTWEMk/Fr5+Wzu+WOYxm/uglhs0Jfhqq//Ib6lZ6qF8vaOW+NQFgQh8SxQO65MShbw==
X-Received: by 2002:a17:90a:ec8b:b0:32b:6145:fa63 with SMTP id 98e67ed59e1d1-33bcf860229mr2814111a91.4.1760671050354;
        Thu, 16 Oct 2025 20:17:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd7b3173asm1064429a91.12.2025.10.16.20.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:17:29 -0700 (PDT)
Message-Id: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Oct 2025 03:17:29 +0000
Subject: [PATCH] diff: stop output garbled message in dry run mode
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <yldhome2d2@gmail.com>

From: Lidong Yan <yldhome2d2@gmail.com>

In dry run mode, diff_flush_patch() should not produce any output.
However, in commit b55e6d36eb (diff: ensure consistent diff behavior
with ignore options, 2025-08-08), only the output during the
comparison of two file contents was suppressed. For file deletions
or mode changes, diff_flush_patch() still produces output. In
run_extern_diff(), set quiet to true if in dry run mode. In
emit_diff_symbol_from_struct(), directly return if in dry run mode.

Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
---
    diff: stop output garbled message in dry run mode
    
    In dry run mode, diff_flush_patch() should not produce any output.
    However, in commit b55e6d36eb (diff: ensure consistent diff behavior
    with ignore options, 2025-08-08), only the output during the comparison
    of two file contents was suppressed. For file deletions or mode changes,
    diff_flush_patch() still produces output. In run_extern_diff(), set
    quiet to true if in dry run mode. In emit_diff_symbol_from_struct(),
    directly return if in dry run mode.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2071%2Fbrandb97%2Ffix-diff-dry-run-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2071/brandb97/fix-diff-dry-run-v1
Pull-Request: https://github.com/git/git/pull/2071

 diff.c                  |  5 ++++-
 t/t4013-diff-various.sh | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 87fa16b730..4baf9b535e 100644
--- a/diff.c
+++ b/diff.c
@@ -1351,6 +1351,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	int len = eds->len;
 	unsigned flags = eds->flags;
 
+	if (o->dry_run)
+		return;
+
 	switch (s) {
 	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -4420,7 +4423,7 @@ static void run_external_diff(const struct external_diff *pgm,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	int quiet = !(o->output_format & DIFF_FORMAT_PATCH);
+	int quiet = !(o->output_format & DIFF_FORMAT_PATCH) || o->dry_run;
 	int rc;
 
 	/*
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 55a06eadb3..25fa452656 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -661,6 +661,27 @@ test_expect_success 'diff -I<regex>: ignore matching file' '
 	test_grep ! "file1" actual
 '
 
+test_expect_success 'diff -I<regex>: ignore all content changes' '
+	test_when_finished "git rm -f file1 file2" &&
+	: >file1 &&
+	git add file1 &&
+	: >file2 &&
+	git add file2 &&
+
+	rm -f file1 file2 &&
+	mkdir file2 &&
+	test_diff_no_content_changes () {
+		git diff $1 --ignore-blank-lines -I".*" >actual &&
+		test_line_count = 2 actual &&
+		test_grep "file1" actual &&
+		test_grep "file2" actual &&
+		test_grep ! "diff --git" actual
+	} &&
+	test_diff_no_content_changes "--raw" &&
+	test_diff_no_content_changes "--name-only" &&
+	test_diff_no_content_changes "--name-status"
+'
+
 # check_prefix <patch> <src> <dst>
 # check only lines with paths to avoid dependency on exact oid/contents
 check_prefix () {

base-commit: 143f58ef7535f8f8a80d810768a18bdf3807de26
-- 
gitgitgadget
