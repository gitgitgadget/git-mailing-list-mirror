Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283883BE641
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219046; cv=none; b=PtJpB4/WlkUeCY4iPP+YHqKDouqyMHE7607bQ/QlAdKO0cUbHszZ5cz80Vb9y+c62/Brm6sjh4MbEycxMWvrKhDpc7r0pvMmG/eosh/ynRAp6VvPGAsBkBuRn7u59CDkjq5+BsHxf1eBKP2UY6DdZT829EwHAqWzkX68PGBo1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219046; c=relaxed/simple;
	bh=Mx69Qx0yRQtjdMMkPhMaYw3JPFDYcJkoUXNzFbiPqHA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o/Kx08pBASadMXLUyWUtAOWIUeX7CiFa5GCvCNjQ6eUIzBaPMDCZm8XTs1U6K/aoXwI49KN0Nt91RqfDMU6o9LhYBZmp5lncyNLK6tcjf+DpUek/d7ndtHSP5E93S//8icIpr7J9oQJEI9UAOAflqj56uLYSSRpV5+zY/yWZIXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbnhKn0J; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbnhKn0J"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb3bae8d3eso1300989985a.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 01:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773219037; x=1773823837; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLdnDkENEUua1I9cI3WGI/IiXkaSv+J1aR9F6lzQLow=;
        b=DbnhKn0JdLdk4qhF7povvVxe+zMnwKrtpXn1OQysswOaaozPBectWu06NZGE/oleIZ
         IgqSl4TPq7um6dgQMphEMduTHjVo+BkHUgbfyLZEyLPa25GdnN8P8YriBDWZ/6xjXvek
         q7Cf3sCsgXplYj75r1Yc61NHCmwP6BzD4S7lhBAJyuVJXiWUczcg7uU1Gax8gI94vT00
         8EGkqXrZWWj3EYX/QnG9ttegaJIW/7JsK6k3xPbO+76D9BJ/Cc9rBpz9GOSKawcbJ7zs
         T2grEqT8PcTyMIGEC11uov19ehFgRNlBOaKloS3Xm/ZnIlsVLCTfMk0uWZXLE3KI7BtG
         LKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219037; x=1773823837;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tLdnDkENEUua1I9cI3WGI/IiXkaSv+J1aR9F6lzQLow=;
        b=t+/m/NQttGONegj/eUtaAhcEcNUe8OVTopMNGnWRvVciR+GUPOcdc1U9RUwZuL1aUL
         DV6lFniODr303p4ErTDe+I1CbgqnUS3/HknSrc7/aF+bC3tpJ3rXJaa29h3SO2Iqj5+R
         ZQTtWHk+4gr7RysKdg2yGkrNwjsJ0+UVe1wZU7syBciQGMXAX1y9CPv9YAISX1kB1BeG
         k+uEur2zmZHCW4hgW0nNc/tnLot8/GCmrpHFOHE7+661Mb9TJ0hip4LIBqwYQAv1h7KV
         rl0hFcvOGbDGIL7pkxVxlqs8yt71JJ/ukF4JBuRWfTgDMWJXBkzrLgqjYOPG8SmPHyF0
         hVNg==
X-Gm-Message-State: AOJu0YxWe51CQ0OMJb33m+d1jf17dRrpaLit1UEj2H3P+mqpcflFBsj3
	nomyszpXZ/FP4uLYhy/fJBmQXoNhsAcLR7pCL2ZfGAba+TYCsnlvKtxrdnabSgFe
X-Gm-Gg: ATEYQzzgkQ33/6rlTeCfP6P8Bq0GcV3ZnGwY2PaDk+iVCvcKSqdS0dv2CU8xN2lzsn0
	XRbNGyIAAGd8z6B+0vEMMUGVPl3wKnZMMHJEDp8m9ddtnZNyxUCxwm+m3e7ILdmzT+3X4jObrXq
	lK83mMg241QoQQ1AHY2DHsjqPEGzestYjAunRQnoZkznq4nLdNNqLBDCRanazxO+9n5XTn53mBs
	yIjwZePKr0HIl+GfdddkX3rrKUN8v6Im8sifivY2UVNFFaM5bIwSj36WHv5Igp2AsvRGdTDLrEM
	LmwduOR84a6A9+wNWZgC8hSUZ7AYdyzyU/FMWZ6P9CBwF/cBwxi04xMWaqzacl+2qf98n6oRlw/
	OdywYcoicOhuQ+0QZQChicMDoF+X86C84SGLJZWjzFdDcdEZoo54sjiSbftYpaiiaX2+ubHiFNy
	BK3el0pDvwKe9awAMO1hTPfuo=
X-Received: by 2002:a05:620a:40cf:b0:8c5:2f36:660f with SMTP id af79cd13be357-8cda1a82055mr223881085a.78.1773219037135;
        Wed, 11 Mar 2026 01:50:37 -0700 (PDT)
Received: from [127.0.0.1] ([40.81.42.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda210d972sm101962985a.28.2026.03.11.01.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:50:36 -0700 (PDT)
Message-Id: <b25ea22410a6f8a3e223ecfdf4941a72041844d0.1773219028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
References: <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
	<pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 08:50:27 +0000
Subject: [PATCH v4 4/5] Updating tests and unpack-tress.c [GSOC]
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

From: Arsh Srivastava <arshsrivastava00@gmail.com>

While submitting my previous commit found that
previous testcases weren't working properly
with my updates

So fixed the test updates and advice conflict issue.

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
---
 t/t6439-merge-co-error-msgs.sh | 4 ++++
 t/t7406-submodule-update.sh    | 2 ++
 unpack-trees.c                 | 6 +-----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 643c9368e0..6ebc1d2565 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -77,6 +77,8 @@ error: Your local changes to the following files would be overwritten by checkou
 	rep/one
 	rep/two
 Please commit your changes or stash them before you switch branches.
+Try using 'git checkout -m <branch>' for a quick fix.
+Please Note :- that using -m (merge) will not save your changes, rather would directly merge them. Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
 Aborting
 EOF
 
@@ -99,6 +101,8 @@ error: Your local changes to the following files would be overwritten by checkou
 	rep/one
 	rep/two
 Please commit your changes or stash them before you switch branches.
+Try using 'git checkout -m <branch>' for a quick fix.
+Please Note :- that using -m (merge) will not save your changes, rather would directly merge them. Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
 Aborting
 EOF
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 3adab12091..a359429bf5 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -212,6 +212,8 @@ test_expect_success 'submodule update should fail due to local changes' '
 	> error: Your local changes to the following files would be overwritten by checkout:
 	> 	file
 	> Please commit your changes or stash them before you switch branches.
+	> Try using '\''git checkout -m <branch>'\'' for a quick fix.
+	> Please Note :- that using -m (merge) will not save your changes, rather would directly merge them. Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone.
 	> Aborting
 	> fatal: Unable to checkout OID in submodule path '\''submodule'\''
 	EOF
diff --git a/unpack-trees.c b/unpack-trees.c
index 9449ee8203..cb4cdee9b9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -134,11 +134,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			  "Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone."
 			  )
 		      : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
-				"Please commit your changes or stash them before you switch branches.\n"
-			  "Try using 'git checkout -m <branch>' for a quick fix.\n"
-			  "Please Note :- that using -m (merge) will not save your changes, rather would directly merge them.\n"
-			  "Meaning if you are not able to resolve conflicts and does --hard reset your local changes would be gone."
-			  );
+				"Please commit your changes or stash them before you switch branches.");
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("Your local changes to the following files would be overwritten by merge:\n%%s"
-- 
gitgitgadget

