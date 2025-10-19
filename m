Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5EBF50F
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760878671; cv=none; b=bGR+m6M2i6rqqfagtLlxX9E0Amj4v1b11cY0nRymZpidPKTkfCppC4iohvh55699ZDfcsmEMgwlzG7qQkeSibrrXL+fyV3bMy2C8frpiwDRx/Lvby0/u5uL3z4+/YWkgaX7Fx+Wkkh1l0u4fpxj3/1t2PLHj88KAA9RQ6UE3zWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760878671; c=relaxed/simple;
	bh=GvGjFEmy6sxEkVTsfY7WjF0XFDAJwS22L8AP8cMUpHk=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=OOLLU5PAi+/yZsRVT1gfa+1ul8TcbF3NOQFmfLfd47328694CjSuU6xcrWJffnLaiM3/n/EEoNmrUTGDAQMtJ65sAtGNvu748YBWcHE+6UbFw1Nnivz0rtLX4G5ODJXW/nDGwLP7Xv1YpeAiKdd9oArv0W0eiXOdU56CshFrJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8vh1oy2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8vh1oy2"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f5d497692so4384137b3a.1
        for <git@vger.kernel.org>; Sun, 19 Oct 2025 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760878668; x=1761483468; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q1OV+YiLHkAoQ2KQ/gikWgG+KYIsIr3cRdAf3ktwW0o=;
        b=h8vh1oy2jJ+KHG2uK4EZCssuXewUpi2lG8CWk6mlEzsjZTjv5YWJOte283A8mZyW1j
         hBpNCRsRSCqvz8F49WCVJbq9yTuEfr4PofLRlJhXP728e2OS3VtABepe6hQIqKBXo2q0
         LH5ZImtZLAWPCdNu4Qpz1y2GGwy5tEBObbgEb0AguL5pWbizcjWmDvZBsCjax36245GA
         dv0LeCM+xu4JYuCup8Lq7cJY6rPyolnJEbbO2nvWcYlBdtIz2O7m6WDG1QQpQgKZl0a9
         PMKvnfIdKhSS8BzbtxcXXIbc6UnWWFtVAPXM5puUhuhFY2gWpsNJZvjiClKRJ85NSI8l
         NgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760878668; x=1761483468;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1OV+YiLHkAoQ2KQ/gikWgG+KYIsIr3cRdAf3ktwW0o=;
        b=rKubZj2Jj8lmIAmbYhzxq27WvRVvB/VBR6gnqjxTHLttujkS2XSe8BzsUrJdkeomUL
         69mNE4b4cOToDWjYx/mXEloWT6YrYSFn/kT92lQGDF6n3lufn83CU4uGb0LeEVgFXZAS
         Wr7VeeLBcWjXXrBecu/hIPJ/j8uWpmHjmfrL3bALrSkGkQ7zOJr+1absDGq3I17kruAj
         LKmtUpsxuqk7kSKZ2wlqEAqB47kByJcRZXs5da1de4KVYzzy97kGM89oOv/xvTAH+bPf
         IXTNdYHLFfsNIyCyDmIK9E+wi7/4PUS7I/fTD06cipekQP3vUKpDqeCEe5uwBck+txsQ
         jIqw==
X-Gm-Message-State: AOJu0YwaW9yig0KVEGGfHLRO4zouRV8z/zVDwrFBMA21Wkf+zb2pQJ1d
	gzMJKcw31BT8pyEcIqpDSnOzbslaO06qp7TrVM0u9/HncGA77LgDMovjW7EuJg==
X-Gm-Gg: ASbGnct7k/YWGtJ0Aw7gaMu6yrKdrLi5IJnaGqjTp331rRLjsK7vr70ayay+mHN8nda
	vektoLMnNeeoPdNWUq57aZf9NMCzUi1MFfopr1yqg/L+O3vom3mO9U8QiGzlw370YtaJyps8l/a
	dqN8vrCWlWBMiwevAYx8NtlBxwHIwsfGaxrgqjZsh+oh2R2SBWD/UAdScrvh5WMaiu+lkBzGM2m
	jkX3+4/TY+X6JqkEE5PWk2/XpgaB75BWPbuB2xhNguO9KtGC8Tzwk4WX9TI+DqN7PI/A9QUZadu
	AnDH0dCRC56bQqCh1RHz/9QoqXPEdzMqXLs1rulwZbNr+2LgUtHWqDJSdaCZ0JtxA6aYmV4Bw00
	R8L7oRfkn/P3B18naOjP0kqRV3Jn5n6Tw6sd14if8MPwkbnTk+uU9t5gpDMoYWZk6H3lJ7q6i4h
	MqvAihz5QU2jBCBwQ=
X-Google-Smtp-Source: AGHT+IFzaFmnZkHHzpU4gCIssdCOUailpyMg/r/Q9OZe2T99qKZXGSfWqsUhmZlbXBJUvADM6qbgIA==
X-Received: by 2002:a05:6a00:3d06:b0:781:19e1:c4c8 with SMTP id d2e1a72fcca58-7a220a69eb6mr10782712b3a.9.1760878668171;
        Sun, 19 Oct 2025 05:57:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f254esm5456794b3a.45.2025.10.19.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:57:47 -0700 (PDT)
Message-Id: <pull.2073.git.git.1760878666840.gitgitgadget@gmail.com>
From: "KIYOTA Fumiya via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 19 Oct 2025 12:57:46 +0000
Subject: [PATCH] completion: complete some 'git log' options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Revi Ewer <revi.ewer@example.com>,
    Ill Takalook <ill.takalook@example.net>,
    KIYOTA Fumiya <kiyota-f@asahi.com>,
    KIYOTA Fumiya <aimluck.kiyota@gmail.com>

From: KIYOTA Fumiya <aimluck.kiyota@gmail.com>

1. '--exclude=' option to 'git log' and 'git shortlog' are missing. Add the
option to __git_log_shortlog_options.

2. The `--committer` option in `git log` requires a pattern, such as
`--committer=ba`, but in `git shortlog`, specifying a pattern results in
an error: “error: option `committer' takes no value.” Therefore, I’ll
handle them as separate options for completion rather than a shared one.

Signed-off-by: KIYOTA Fumiya <aimluck.kiyota@gmail.com>
---
    completion: complete some 'git log' options
    
     1. '--exclude=' option to 'git log' and 'git shortlog' are missing. Add
        the option to __git_log_shortlog_options.
    
     2. The --committer option in git log requires a pattern, such as
        --committer=ba, but in git shortlog, specifying a pattern results in
        an error: “error: option `committer' takes no value.” Therefore,
        I’ll handle them as separate options for completion rather than a
        shared one.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2073%2FFKbelm%2FlogCompletion-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2073/FKbelm/logCompletion-v1
Pull-Request: https://github.com/git/git/pull/2073

 contrib/completion/git-completion.bash | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e3d88b0672..73abea31b4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2218,7 +2218,7 @@ __git_log_gitk_options="
 "
 # Options that go well for log and shortlog (not gitk)
 __git_log_shortlog_options="
-	--author= --committer= --grep=
+	--author= --grep= --exclude=
 	--all-match --invert-grep
 "
 # Options accepted by log and show
@@ -2296,6 +2296,7 @@ __git_complete_log_opts ()
 			$__git_log_shortlog_options
 			$__git_log_gitk_options
 			$__git_log_show_options
+			--committer=
 			--root --topo-order --date-order --reverse
 			--follow --full-diff
 			--abbrev-commit --no-abbrev-commit --abbrev=
@@ -3229,7 +3230,7 @@ _git_shortlog ()
 		__gitcomp "
 			$__git_log_common_options
 			$__git_log_shortlog_options
-			--numbered --summary --email
+			--committer --numbered --summary --email
 			"
 		return
 		;;

base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
-- 
gitgitgadget
