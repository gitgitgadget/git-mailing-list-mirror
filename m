Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040973;
	b=NojiD1bctvX+OXav7uMUjAQG4Nw3CxWYZ4rOJAWtXWhDNLl19sj3OeJ+G2+2ME0ajfxV
	 g2gZcbAjeMIz3GQW1Ulob0l4HZ+sGXwM32lnEkPtA68XFYNmy+3NTivDcTjzcI9we3TJO
	 983F9OU7VKg1Fy5IWmGnWpAn7o1sW+bXJ7GurldeUoMHIe+kNjLiVFF542SguoXYefIN5
	 EOVk7OnuCV/UAEt7zLMr1Votr3rcKJgtj8aSQvvij2IW3Pc48/KjyQbkzVGX6G0vk8jLU
	 m5QBNP4b2heY6vhF71dghZfRFxqdmyMKTrBMgBSlUHicDFtCTDzejEdaCa+UkaBm7rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=dHVD7g7q0JqxphSjNJf5Nrolkt9CoWX1Z5wwJbXP+DA=;
	b=vr3J6XlEDzM9ChilPHvkaPVUmamA3x/Fw+5UB7uXhmQcPUFEuLwfVPfw4rN1xI2OZbJC
	 eCG0AjnsWiU5NdaVPGLziCZ0bZ0ej94dCi+H5J+OfGLmAqPI4YVQKMtdYl7w8m5WTJ8Nf
	 Z3yOaL5WQUCl7CSliQcIAIK3oFyl58eFaOwh0fecFF1VQRcHrakdXwdnapUSnzS1UNby8
	 0au6ltSVA6RZuVNdrrLsz3HVRaq2KMwTLPPX8QNTNTld0nwOBOZQOVh5zRCZnljt0JWUM
	 WTQwghU0hR30jT/3/5h9kpuraLUe3P7X+QjDcc8oE1KG+tMT8nh0H3OMh+CgTPfnSGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="grBRT/7f";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEFF606A337
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AEFF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grBRT/7f
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ea7190aea1so5606065ad.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040972; x=1794645772; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dHVD7g7q0JqxphSjNJf5Nrolkt9CoWX1Z5wwJbXP+DA=;
        b=grBRT/7fYOvbmrkpc/DaoVRhOgcW29GX+G0dw2xxxewEcNcqkR1M3F+QGaPOxQqymB
         OfuL2qsNosNOJ5EMYyycmAFM5rIksd/yvgT77PyYeTr1NLYHrovbn3KERfgeO/yQQuKd
         9wwD0Ui+efU9Ew0dUgmhc4CM7QAui0qumG/RmEdgwnJwwz8xxhoNrXDZ+X5W/9vCOLeo
         W8MQkKB9QV37yoj2hEOVwMmykpuFMcayloV/mMo6DDkoCrbvWcaDjPNCZa4TjKupyo8w
         +j4hu44pcNqIoyzGNh4LbG0hvgZQkbUd/B9bzCsPYbBkEdunah78SpsYUuqjhnnwjvPe
         is+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040972; x=1794645772;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dHVD7g7q0JqxphSjNJf5Nrolkt9CoWX1Z5wwJbXP+DA=;
        b=I9lnzHu9Vf7iBjshVSFSD2+D5b03atGsMP6DoiEBynf1slQvhalgu/lLySqjrAEqQy
         HJJ7hmw5agU7ZOJdSC1RZjua6pFsBw7t7rS1jiujdO7WEEyV520+QO+7pkQBlOZle5NW
         PQ5UG7pqnc7P4r4kHsK+O51PxPdErl6POUWwxMqnspCEMlzuZXmKUvMtlRKvveEKDRdA
         /p1tvGX3Cte+BjGxTifOQYGoNq4XGLTxwWiaGbctbJtvDvajTXSxN/j/9NjPZfDNaM9i
         Um959axKPJYRbX97lEXF+bOcg1RBiaJec+6HLTNlK0lueumxMWuJp1wdgMPmB1a8UU/J
         mdIQ==
X-Gm-Message-State: APuU4Z81gH4tNpfpSSbwMSNfCdGda45f6rDZLRbXefc7P7+fM3MaoGME
	g5e+coaS1am/zIoK0HSatyk0Zm+szWMQSLs2dOxeR1rLHL6HUgsa9wN8msffIg==
X-Gm-Gg: AYBFou0mPhqPBSm4o0VxJpZK6AI6TZ/k/jbNsWtTbAY6ltDFmcE9t6ryGiKZaZhZzWY
	glNtHEf3ucpYIwtw7/I0BPwvDuUDqndDtF0ZUycUTT0eS5+U5doVsKq1ucM5IjM5RYf+jjWmHDJ
	zCbhQsRXPxrxQdZ8vdrc5Thd+5nQwkb3DZvjVdoYwnvzwfz8cDLtU8ZChFejyW9mONczc19iir9
	OPw3dCk2hFLUgeiuAGRkjmm/Mpz7OnX7FvBi1RYil+Fdj8SBWreBn9+Mo7L6+ZFeRo6ntzh6w9H
	ItQPXNgN79nOoa0eEp16FirkN7BiQl59B4P9IwNa4wQQ8+ZaoMw6EShH6Yqav88OsY7EZvrvrhF
	LXfcHHGB0Nv+aBsU7/V/RBzSAPqZcPdOQdV1io6CKyKXB/wS7tVbDObamNDV95Jc96360phAcPj
	8JaurBIVHM2la/Yq9IvCPAsh35HRcT+PDNz4L6lw7siu4lZhX9PJMfoaDrQ+u/PhT/SJxykbEwn
	Ea+EJlITVxsz2iUr0DcLIxPuMnLu2YXJGy7nf+BPdBfynH7VyPAs7l1qo19EJcNb3J6L8rmsvVy
	ppDvDHuZP/B3lGk7SyjG6Le8RZ987SsaVQ==
X-Received: by 2002:a17:902:ec82:b0:2e3:1e96:7f1a with SMTP id d9443c01a7336-2ed4022bc93mr53855475ad.0.1794040972424;
        Sat, 07 Nov 2026 00:42:52 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d837fesm12012185ad.65.2026.11.07.00.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:42:50 -0800 (PST)
Message-Id: <a9a3f4b705f98f0957bc9645395f4c68875b2896.1794040967.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:33 +0000
Subject: [PATCH 01/15] rebase -i: handle NULL value for
 rebase.missingCommitsCheck
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A rebase.missingCommitsCheck without a value, as in

  [rebase]
  missingCommitsCheck

or "git -c rebase.missingCommitsCheck", makes "git rebase -i"
segfault as it writes the todo list: get_missing_commit_check_level()
passes the NULL value to strcasecmp().

The setting takes "ignore", "warn" or "error", not a bool. Read it
with repo_config_get_string_tmp(), which rejects a missing value with
config_error_nonbool(), as ba176db511 (config: handle NULL value when
parsing non-bools, 2023-12-07) did for other settings.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 rebase-interactive.c          | 2 +-
 t/t3404-rebase-interactive.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 809f76a87b..4eb628ee8f 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -30,7 +30,7 @@ static enum missing_commit_check_level get_missing_commit_check_level(void)
 {
 	const char *value;
 
-	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value) ||
+	if (repo_config_get_string_tmp(the_repository, "rebase.missingcommitscheck", &value) ||
 			!strcasecmp("ignore", value))
 		return MISSING_COMMIT_CHECK_IGNORE;
 	if (!strcasecmp("warn", value))
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff11abb2f2..813ad2a83d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1562,6 +1562,13 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'rebase -i rejects rebase.missingCommitsCheck without a value' '
+	rebase_setup_and_clean missing-commit &&
+	test_when_finished "test_might_fail git rebase --abort" &&
+	test_must_fail git -c rebase.missingCommitsCheck rebase -i --root 2>err &&
+	test_grep "missing value for .rebase.missingcommitscheck." err
+'
+
 test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
 	test_config rebase.missingCommitsCheck ignore &&
 	rebase_setup_and_clean missing-commit &&
-- 
gitgitgadget

