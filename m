Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040992;
	b=kvvs6pTywpgRB7qUPlT1srSYM8zk94LCXUY2qvvOGaClUxBvXfxMZgDFCk9zXETNtynG
	 MrFjoAXRewleoW4YnAfkONUukWtKgkA0q9piShTAv2O/bTZg9oORCRSLI3t1Cp7IRFLxS
	 vqLf26jLiCc68mQ945Dw1ng9QR+3GEoEnpjubLrC6kRcZ3zpTOo5Wz14op4x5lwr6/8pw
	 Vgj3K6gXi9h/VhT0ffiUXm+yp2wtlv+J6y+D7w+gzuZRgzG+GiXoic4y4/0Y5zxTCb0jJ
	 n8m3dqowwc/0U0TUoFczbmjFJjp3A4Z05ojTNcPZui/WH9b3LxBRAZOTfsDi9+VQ0yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=/gfvyYztMNMcuWo19mp9PGU0KAO9W0nIWcv6rMLkPmA=;
	b=txcqGmJAQS1x4UTaWRbqDiL9IzQ2jrTO35rlJlFJPCt4aEQHapIK6HoYcP99B1pts3mK
	 1z2HGoSU8fRJvOT7xK1/oOeF5+G2t0nfW4F1MZBJoql0IaPH3FIDODqKygL+WZkfDVwA1
	 MD9ZfrSMdNFxtA/x8AsdwZha4jZBQ2vxhbSMFXNu/zbQAk6RGM5KgLuXw6UiQ7yOlv8eX
	 Da2pAZAUA2ONnUFo69/1kRj0E3QmqfvTZPFufOyDbR/amaxxGUdMOLYIFC9vduvsUoLzm
	 O5hz4LQIKNhZLXoDwLGDOgnH+pGNrLAfPBBec8UmgCGJi1prCFIS1PgfRJx5eh2udyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=almYsYPR;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E3606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 399E3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=almYsYPR
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e985106c0cso10699835ad.2
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040992; x=1794645792; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/gfvyYztMNMcuWo19mp9PGU0KAO9W0nIWcv6rMLkPmA=;
        b=almYsYPRno8xwQFMZxPa6RLQW+5cPBa+cyIFAvMIaVc6Ov5RmcHZSWiz7lSYf4uePI
         ZXRauY6KzhhdsoQ4GfxWn/zamzpjTHwW4oTDdF/4WZxFuaDzR/UcMjDpEXEsTGkKB1Ga
         T9ud1bK/u12yFJBSQAiSU8OfzTIxVKI5q2XHJst2dz5fu3oSWL26WxnWumOm7BAyoAHa
         ba9Ey2jt8VafBSXsb3yx1FOr63TnBt2wfqkM0DkPaz9Bcl1+m2/Sha4SAYQIAnV/QH4o
         Wo6TaNs3saREWq+bOYYGbPdhwjMjVTmLrdfxEo5gx3J+30Au54QLDQWclpcIY94pBVhc
         G2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040992; x=1794645792;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/gfvyYztMNMcuWo19mp9PGU0KAO9W0nIWcv6rMLkPmA=;
        b=XmjQRVIT/evFSUPNa4JLK60vrFXLL9lvLPAdE9fETLn87Xql6BqFuqxGcuv1ZhnNM1
         gfVhg6ZNwLqWZpHFWT/2yruMCofJnQA+XiRU5TineVgj88bW3XxFYzHwnNDjD8BYlime
         YvRz6p5bKmBmnqntGCvQxcVLsBWjabm/C0NH+ioClFZyJrx4DowlzLOAEFTvyLNh2Q2w
         308kO5Xu0Pzfn8747b+U4+7oOW05sNiF1/NGHqHtSfrw7l+eah9hxsPiYqYkbeQ/26y5
         4DVwETIPKGayb0r0kk4mPMMIBJvXXX2E3jAfLyY5ot5FpA1gemvv3wjURQCKerlvSJzq
         9MyA==
X-Gm-Message-State: APuU4Z/xp3MSy08+pVptcm2G0S/EVvOFB4TUx4hlBvSaxfImxj56kcJG
	aoP1anmFwhm6dK6ZqUGfip7ySMST37Pit7hcLmt2wNleGWzJnbVmtI67C9wcX0kx
X-Gm-Gg: AYBFou3lZEQZP9/hIJUvGI7qg/uYNyd45d5raKZAZBtBbK4CCRoHndRoP6mDVkPmmmq
	XPKPFWcKQArWVsrdxFQBEYyvs0ZGcucsul0zKdXfVcfk2JALsYI6bnzOaD8TCD2zTD2+7ILvdyq
	O3ibSoz8yIfGWUQDVehQi1RX+ufWiYe6znF5kcIdOf3+QGtYvtGCg7V8puYnUDJyOinmGNLJYkK
	0Yn1igZ9TMllG8HXgus4/tk8bDi1GSNyAWaJbcm0iQ/yDf1OYj8TNq1/M/RWeiXKUkuuJjflDAH
	NbRA8KdQDlqcO5NRHpCOt/mRyLWsofxI9GuSaULY0U9VU8nLn8hO7poBgWGhkNYHvk91jbxl9NY
	0zvDhvi6D+fIbrYVV38wBszcNEB5je3mSrpzhAxa78Z+0dFtQ7/mbAMxrLA8H7sg7oTF2XeW4vB
	OwpeJ22vFcMgcPX4LJ+2bdRVfRPXLsV75kstpEAm3mDppFFPsylYy4gk3qIeFbWhra271QHTTs9
	hsxzpF04W1ySpPH3eb8M5kJ1JCraBFTpHFELiH4TYhTDVOGpn8E/JFOGPoYv+H0EXb+rzDJnemT
	oRY8Li70cuKZBnn3kBRFa5YlZEqvYOaBrA==
X-Received: by 2002:a17:902:e946:b0:2ea:192a:13b8 with SMTP id d9443c01a7336-2ed416abaffmr57340855ad.20.1794040991590;
        Sat, 07 Nov 2026 00:43:11 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f234sm12021225ad.46.2026.11.07.00.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:43:11 -0800 (PST)
Message-Id: <b4bcaf19ecbf0fc0e165f098c00dccf42985fdd9.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:44 +0000
Subject: [PATCH 12/15] scalar: handle NULL value for scalar.repo
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

A scalar.repo without a value makes "scalar reconfigure --all"
segfault: get_scalar_repos() passes the NULL value to
string_list_append(), which copies it with xstrdup().

Reject a missing value with config_error_nonbool(). This cannot break
a working setup, as "scalar register" always writes scalar.repo with
a path.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 scalar.c          | 5 ++++-
 t/t9210-scalar.sh | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/scalar.c b/scalar.c
index a80d8ee3ff..4fe4b2a647 100644
--- a/scalar.c
+++ b/scalar.c
@@ -652,8 +652,11 @@ static int get_scalar_repos(const char *key, const char *value,
 {
 	struct string_list *list = data;
 
-	if (!strcmp(key, "scalar.repo"))
+	if (!strcmp(key, "scalar.repo")) {
+		if (!value)
+			return config_error_nonbool(key);
 		string_list_append(list, value);
+	}
 
 	return 0;
 }
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index c8463d0ac4..137765d3b8 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -288,6 +288,11 @@ test_expect_success '`reconfigure -a` removes stale config entries' '
 	test_cmp expect scalar.repos
 '
 
+test_expect_success '`reconfigure -a` rejects scalar.repo without a value' '
+	test_must_fail scalar -c scalar.repo reconfigure -a 2>err &&
+	test_grep "missing value for .scalar.repo." err
+'
+
 test_expect_success 'scalar delete without enlistment shows a usage' '
 	test_expect_code 129 scalar delete
 '
-- 
gitgitgadget

