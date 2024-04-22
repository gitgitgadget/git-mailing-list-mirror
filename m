Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671CC4CDF9
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781700; cv=none; b=TsRtWekY/3NvUhr3QktEu+h/sY3t9opJxdNPp3Wo6e6idgkSQVGDwB7vZMICJumJnEk7PJa2e/zWse9XQ5/kgsqAa612GxbFZjeqgRYw5LOKy2ItA88x/dwqGOspXJqIuk2jXgpeUhFPOAlDco0d6o5Rn54ZaRqMVBuUPVeoroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781700; c=relaxed/simple;
	bh=MJuWY/vNgeKjp0VY6MibY2ZRMmLHOGz5C9aX5kpYJ20=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=s3noVleNRZbmR0RTvD4uRgepO9BFzufEn+JOfQ0d6/qveXG3TqAnScz0QG67luKI/f0GytJurQGtIGqksDAG2OyXgDJRk8/n7+iJhEh6H4QIfwFPuUef9Q0xTmdHWMhCPfG73CuqkBXMf7RCSDse61Yk/jzJZcW9K8T29DYJyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6bMNO2r; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6bMNO2r"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a4f291f9dso5631695e9.2
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 03:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713781696; x=1714386496; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sRRjbJ4L5UdvrfqDabMS1z2kHYKSiVET1lorPx5HHhQ=;
        b=V6bMNO2r1S21D9+AuarTUk6Bp6CvP+sFmMT577m1ytaqiqgtXyB2nY77eCablI8nHW
         YBcHkjQFixQk0C4bQvMZPfi1PaD31URakfdgn1pZTJ2g3eYOR9s4ZMJCW8TxsCUfl27d
         /r7MpxXdDEqv+FEi8fmoToL7tkh9EYFqLhiUVvCPVR0B/b8/IG3WsaRBxEr947IH7bDE
         6AHbIAE0pUkHvpGvsZuCZ5kzQm8HhPYaIexM90kZXXrIUab2vzkES1RclGyWMplV5M0d
         q71VlQ04r9PFvZL7R1NWOWQrhl0t7BkYLFfL8dckFE3e0NGL4e6NBrDgjgHyvAVws2bn
         VLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713781696; x=1714386496;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRRjbJ4L5UdvrfqDabMS1z2kHYKSiVET1lorPx5HHhQ=;
        b=fRpj9aeVOki8dkOAymXS+wddxuH+DarH2p1q/jOG7TXWNj/7QbyGvtMrivjVZJIs7X
         noB2QNkvG/0Ga6TXlD8AAGQwfL4TlXlmf/ItSoqjsZgvgGq2XWdBsgnEs5H4rR/FR1dp
         KoScUdNXDzElfAwIeWk7W0uyRU7gpSliWFP753cV8ZFtvwFGz0DKmftmaUeUk3a+8iXZ
         EAR+7jshrHYc82kHLW7TVMEZDc814WxE+tgRed84Uaf0ZTW4LurtQ8pGFlkI5MnTkTMa
         o4wi1WJxXv+XMZAPvLfTb4zg5aYYc2NObeVrt6f/sKeqb9mSbRdq7CJMWw8j5pfp0VRh
         UsIQ==
X-Gm-Message-State: AOJu0YxnU7gnkvkOsU3u0hfFwxjCJvnbfk88Tc6C/ppcrydU0BwwP5Ff
	X5LBtgFnSi5JmJ+6RpTlRUNWVzVlhzdzGCE03+CTBCWhdBBBA4e/975vbw==
X-Google-Smtp-Source: AGHT+IE4uXVZtJcnpqy3IkusffIR+HHFLo38V19nFqwcMFcfb/1k9+Sd8QXbyNttMEaRIHkN7cc5Xg==
X-Received: by 2002:a05:600c:154c:b0:418:2602:fc3d with SMTP id f12-20020a05600c154c00b004182602fc3dmr6720272wmg.28.1713781695788;
        Mon, 22 Apr 2024 03:28:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm16177637wmo.34.2024.04.22.03.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:28:15 -0700 (PDT)
Message-Id: <pull.1722.git.1713781694490.gitgitgadget@gmail.com>
From: "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Apr 2024 10:28:14 +0000
Subject: [PATCH] stash: fix "--staged" with binary files
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
Cc: Jeff King <peff@peff.net>,
    "Randall S. Becker" <randall.becker@nexbridge.ca>,
    Adam Johnson <me@adamj.eu>,
    Adam Johnson <me@adamj.eu>

From: Adam Johnson <me@adamj.eu>

"git stash --staged" would crash with binary files, after saving the stash.
This behaviour dates back to the addition of the feature in 41a28eb6c1
(stash: implement '--staged' option for 'push' and 'save', 2021-10-18).
Adding the "--binary" option of "diff-tree" fixes this. The "diff-tree" call
in stash_patch() also omits "--binary", but that is fine since binary files
cannot be selected interactively.

Helped-By: Jeff King <peff@peff.net>
Helped-By: Randall S. Becker <randall.becker@nexbridge.ca>
Signed-off-by: Adam Johnson <me@adamj.eu>
---
    stash: fix "--staged" with binary files

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1722%2Fadamchainz%2Faj%2Fstash-binary-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1722/adamchainz/aj/stash-binary-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1722

 builtin/stash.c  | 4 ++--
 t/t3903-stash.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 062be1fbc07..7751bca868e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1205,8 +1205,8 @@ static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
 	}
 
 	cp_diff_tree.git_cmd = 1;
-	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
-		     oid_to_hex(&info->w_tree), "--", NULL);
+	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "--binary",
+		     "-U1", "HEAD", oid_to_hex(&info->w_tree), "--", NULL);
 	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
 		ret = -1;
 		goto done;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 00db82fb245..a7f71f8126f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -393,6 +393,15 @@ test_expect_success 'stash --staged' '
 	test bar,bar4 = $(cat file),$(cat file2)
 '
 
+test_expect_success 'stash --staged with binary file' '
+	printf "\0" >file &&
+	git add file &&
+	git stash --staged &&
+	git stash pop &&
+	printf "\0" >expect &&
+	test_cmp expect file
+'
+
 test_expect_success 'dont assume push with non-option args' '
 	test_must_fail git stash -q drop 2>err &&
 	test_grep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''drop'\''" err

base-commit: ae3196a5ea84a9e88991d576020cf66512487088
-- 
gitgitgadget
