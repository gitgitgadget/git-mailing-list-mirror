Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88CEAD3
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708296699; cv=none; b=OIK8N/lv6fIMMOQeLusboiTR3bQ0EVWRGIcKUf2fQu7p43h8JrYEE9PL1puNjXjiwbpYjq2VkLiCboIn20iq2SXjzIf176Pi7uMcNXtTyvMkVFl7oPgo27e+/36BrsP6/ZktuwVoJS4116d8kGPWaz5cbUTuFSZ5548KhYiM3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708296699; c=relaxed/simple;
	bh=lTPpC0mojoWtwtHKCtuSLp8EQEPgsY2SA+El0nYHyJ8=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=crFiBIwfYmw+EUWYbRPbPe5GcwLGlF5Je9ioWFFSNFcnRNf0+vigdWXXAWpDJreaMH95zb7p79JDteEZXt4eG9AatXvtjn6zk3iRNengeH6Xu0lwn+0cKGxNLhOfu42IxR5W68z0Tb8uw0uitogFjhKL0N7vEuAu9BUcIzpQWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9pioK67; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9pioK67"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d509c5706so134752f8f.2
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708296696; x=1708901496; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8zzBrgV9vtz4/nVIjzqktuhDcrPHWT+MwRhbAXEk6yg=;
        b=Z9pioK67shtMt/XOjYDmDl5i2plSkyvhE1oePnvKI7ZeXshKq0mFzTA2XdczOi8258
         SxjHkS0M2+7vEYqZ7vDminAmqpsbbTfUXmbEYMX4ownC+M9fllv51wWcYwqPRafQbrr+
         zt45McTj8YlfwfedW/THHRkv/e8ARzB4AN4GsilZTco0leogeMdXIuk3n2vUINrp/or2
         WDt6jBONQmMpvEaW6g9imdMrNeoaY5lOe44KPjd0MbxgASje4Qh+QRw8IXL5LY/o4r98
         NwZlOdsmB3fmVdLnGQjlie1OZZHV4mRJq1pN9X4vSD1B8iDRzY5R5hd0X+kH/fg/H8yn
         Zr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708296696; x=1708901496;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zzBrgV9vtz4/nVIjzqktuhDcrPHWT+MwRhbAXEk6yg=;
        b=S9D34N0DXhyLV44iuG8DkY/UOcvovEA/tmEQDdGldBZ28+x9Ziz3VJdYeCVE5R/8XT
         lYZjAT6be7n58S53rDR2bA0aQntZJUZivjpMinfafc0LD0XKZ5LUaJ0U8xNt4dUETiL2
         G83HiNiM9i2qnu/GkAl7wkcK/PWR6ThMCGAWsWzl5wcaRAdDFs6BuwSm8XzWGN6KUb1R
         v8k7bC7m/Imt3Xi5EPrNNM7od/m/NB9Rxol6R90VKh4qQl6dudwqhXE7bqkX7kqbWJgl
         NOi4cYEhC4CKLWADf/Q/t4+TPHxGNaA64d6H1gjVMXFjEBhsA/R0ucSW7iHu0JBN9+j5
         hDrg==
X-Gm-Message-State: AOJu0YwJVo4ItMnZYg2G5Pm6kV9c3BeXkF0Sc5b5O4TIyLw/Jwi0q1pL
	FLB3xEj8P0b5xcvX/kzaGF4ON1gIwFplMEDwkf7ztt2Ck69/BfTOyNBMuHpY
X-Google-Smtp-Source: AGHT+IFUiE8nw0QlDS8Hed8HT3+D5ED1WR7iNvtHSHudozJzGlKA/Lq0lyJGmjuhYnk5cKmCSjuRiA==
X-Received: by 2002:a5d:6784:0:b0:33d:3a02:8368 with SMTP id v4-20020a5d6784000000b0033d3a028368mr2299849wru.8.1708296695658;
        Sun, 18 Feb 2024 14:51:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0033940016d6esm8507056wrw.93.2024.02.18.14.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 14:51:35 -0800 (PST)
Message-ID: <pull.1676.git.git.1708296694988.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Feb 2024 22:51:34 +0000
Subject: [PATCH] libsecret: retrieve empty password
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
Cc: M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

Since 0ce02e2f (credential/libsecret: store new attributes, 2023-06-16)
a test that stores empty username and password fails when
t0303-credential-external.sh is run with
GIT_TEST_CREDENTIAL_HELPER=libsecret.

Retrieve empty password carefully. This fixes test:

    ok 14 - helper (libsecret) can store empty username

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    libsecret: retrieve empty password

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1676%2Fhickford%2Flibsecret-empty-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1676/hickford/libsecret-empty-v1
Pull-Request: https://github.com/git/git/pull/1676

 contrib/credential/libsecret/git-credential-libsecret.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index 215a81d8bae..d9e9e4fd524 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -164,6 +164,9 @@ static int keyring_get(struct credential *c)
 			if (g_strv_length(parts) >= 1) {
 				g_free(c->password);
 				c->password = g_strdup(parts[0]);
+			} else {
+				g_free(c->password);
+				c->password = strdup("");
 			}
 			for (int i = 1; i < g_strv_length(parts); i++) {
 				if (g_str_has_prefix(parts[i], "password_expiry_utc=")) {

base-commit: 3e0d3cd5c7def4808247caf168e17f2bbf47892b
-- 
gitgitgadget
