Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040986;
	b=UJj2RY1vz3nIkOix2odAPwPj56llstg4sfXHVw5YuP8scmYYsxvBy0Ro6sSz8dY+F/x8
	 lKyiwYwnHLzEwd4RVe+vOn3uUrj/uDdW6TN0JTHkpIUkMweXGfg7+Hblth0p9cFxlMmQo
	 XnczF7rsH8Ncf3XJZ3h/qCqwk3aKcjnBjnvu3il3Vxw8jIkv1VS50HHwQ2fgvUHC6JLC3
	 xgNI5OAbl05VuDBTf8GunjZHxHFSc74TvURBBwxHBGQQHbnsvka0zaZhX3FCvr3LdoldL
	 dSKqCymO39lbjH3K9fjLUK3uOIJrP2NYZCS10QmuOkB6+QJSgrX1cErsEmrjeM9wSYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=70YQV640hVujJKSJXbMhugcN3W8fdQKTdQG2zJl56g0=;
	b=MWPbOmfw0raaZ01Xcrl2yz0sMrD62ZS4aaWcQT8+CzfMF1WfgitZIj6GjNs58bya61jn
	 E45dT8vp0KurUFp77gyjCkgi/kEANk2877FfNj7mSwFVfHXPculTOoDRca1xgpmgxvqt1
	 mm/258wZQCnuDESRyL2PcLMniz/O+CqsZHhiiQaaYqnNXHeuPhi+SfsR18qLXmn0lFvO2
	 tOvelCJAt2EKt1eehBs5hN0RH6fv51DDQgFNMRX9IUKpH/R22KrV6Z8YSy894X7U+EDhW
	 KEY37ZDoteJUKF12JhZKVrtm41RpKGeEFw9x80tZ4UWzi+1E/5HwygMYkpf6a1d1Afg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bVZ6pyQK;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277F606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8277F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bVZ6pyQK
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ed1414df17so5320195ad.2
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040986; x=1794645786; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=70YQV640hVujJKSJXbMhugcN3W8fdQKTdQG2zJl56g0=;
        b=bVZ6pyQKUgpBrsS2X1dUbf+g6rbarj688jdHOQFy7Xkg9m8Xoa1XrAWUwpFtrAZbyk
         IBXrNf3XWYtgXOob2OISus8S2IwdcX/T693pqfxkihtzk3TMNZNh3rN/yjNnt9JyJDbp
         L3mIFMHiLRNN7OBEJav7mWsiVnpbx61mDLC1LRTPSQYOx/r8uoGUBYdOU1DS8AEIz5Ih
         9ML/XdEew9cBxRFmQp1dW/JPHxmE5xrr0IcrRh/ygScP9eCzX+Ml8m8c8gWn44m2jkww
         nIpaaFzUV2rCX5k9E/4nfM93awSDegukOFfMB80/Ls8gcO/MdfKmIjxbKL4CiCCR7/GC
         Y08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040986; x=1794645786;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=70YQV640hVujJKSJXbMhugcN3W8fdQKTdQG2zJl56g0=;
        b=T4hPloM6z+nF69oVV1SAxAhnLMfliGMIAweVllsVf3sZJAF313zLvp7pcslrV1guoT
         Vrp/Ibit6kcc90ReVsiKGZNMdoYjkBwQSDWcYByNugriMVAGTl4f9XrGsBixcA1u2XyH
         BBlR85jkHzbOxnltV/EwP+1oL7FmE6rf3brwkXAgfcbmO9fTXbXlIRKuRRJgK2fSIH9z
         ibhvs9Q3WTyRRKgw0SLAA4imFQSbs4RuLtY8djd4MA47CcG+63AEQNzd0WK9unQrOVWI
         0wlQaXkkznFixp/aSH7b08JOp/DB7BjCri+2IMtjBR++1cfSI/ADpopRkPq7tueKdzPz
         MrbQ==
X-Gm-Message-State: APuU4Z+Qk9mdMlAW7r5GLVRp+YZh/TX/zwip1yv3KlGkEUgdukwo9fey
	9ziu9WEyHBGN7MI4S6RhdiHTru4iSKS2eF7o7oMJGNiRT6dodquEz8wlPAhi1JEC
X-Gm-Gg: AYBFou16pGd2NB8ZGIjKZFg+CCkwI6IWw6DZO2dvNtEv+ALS5SHVcUUHm+ILOOqmCv4
	4FzgRReO8IyQ4l99vx5efn2DgxlxhurtRnxdIwSAmR9eaAG0QB12TzvfxHeqDKXfbIqdbl+HnZ7
	YVC59cagHC9aT22c0IE2cQV3kEhFlVLCOaPRUb4rOf7PNwkNSGE0ymBh5cwKQSY/5Y+lfVQAUmo
	CSlyRpeOJOaubiQFYJCPQh3gpf8L33hjAUXzoIBJ/PcHtbtrvj2W/8vQ+1tuW98K0TlcgzeeuUP
	YAX6uK5IHLKVxWO6q3CUDBpxodAnAa9pXixC7QjFS6ZZuylIMzMHWPEXrCD0SYHznM6Ihv88WMn
	kY8CNXLL1S9sTY15R3PeCO41RHgmum7BY132cquKP1ZZtFYRrjR+tb8NOgKqY4/loQJmDSOOMRW
	qcldmgTqrL20Z8pvpAklDEBEOGQrnwwxOM77RcH7YSn8hRf4AzuEdur+G4XCqXNfgz7baRcW20J
	EDHVaGt9pVh+ARa17lW9ZdsoSN7/BYIyaDK8rb9chHsrtxXkkwwLJcTH/fm+aIflcr5F+G+6B30
	b/sJo7/PIoMs3ZRQILCC7Jk6a6wqLJhplFZgKFrrhCw6kGRdMaX91Zo=
X-Received: by 2002:a17:903:1a30:b0:2e2:c8a1:ab63 with SMTP id d9443c01a7336-2ed40aad8acmr58911135ad.17.1794040985843;
        Sat, 07 Nov 2026 00:43:05 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d40998sm11944085ad.34.2026.11.07.00.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:43:04 -0800 (PST)
Message-Id: <e10f1fc0ba4084584e11834ea98b8d8d8e353244.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:40 +0000
Subject: [PATCH 08/15] merge: handle NULL value for branch.<name>.mergeOptions
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

A branch.<name>.mergeOptions without a value makes "git merge"
segfault on that branch: git_merge_config() passes the NULL value to
xstrdup().

Reject a missing value with config_error_nonbool(), as
git_config_string() already does for the other strings that
git_merge_config() reads.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 builtin/merge.c  | 2 ++
 t/t7600-merge.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5b4eb23a83..fbabda97f8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -668,6 +668,8 @@ static int git_merge_config(const char *k, const char *v,
 	    skip_prefix(k, "branch.", &str) &&
 	    skip_prefix(str, branch, &str) &&
 	    !strcmp(str, ".mergeoptions")) {
+		if (!v)
+			return config_error_nonbool(k);
 		free(branch_mergeoptions);
 		branch_mergeoptions = xstrdup(v);
 		return 0;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 64fe21717d..d4963f1fee 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -552,6 +552,12 @@ test_expect_success 'merge c1 with c2 (squash in config)' '
 	test_cmp squash.1-5 .git/SQUASH_MSG
 '
 
+test_expect_success 'merge rejects branch.main.mergeOptions without a value' '
+	git reset --hard c1 &&
+	test_must_fail git -c branch.main.mergeOptions merge c2 2>err &&
+	test_grep "missing value for .branch.main.mergeoptions." err
+'
+
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'override config option -n with --summary' '
-- 
gitgitgadget

