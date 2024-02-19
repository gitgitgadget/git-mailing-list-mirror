Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D9524BD
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375263; cv=none; b=osRDzoOSEa8/E0dIRULvCNtM4tN44JrVDdLEBRdNiDPF/nZkUclCgyFC37n31N8a1LKJhR4PwJ4wRrKK1NTbtHYBzrX59BHjzHP4NG66/emDv2Le04v6q+BtXdGVCEdJRroxGUX0T6g48Xk6eHxsLZIQPJ5CZ+U1GSoVdxZ/fyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375263; c=relaxed/simple;
	bh=QwxgUHu4B2ZB+VwSAgYHG0f2dYLWyQVulAheO4CwTuM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=izN8HZRIi8nLFmiElO4lbnV4CJdcVsG7WruVVvPcanpD1o1TU8nf9+5IvZOpxCZsgN7pZQj4BK6ntTR4h/ysJHufVLhfy0t2fgHYEM3cMJohB9ZRMpbfugyFBndTx8K8nf9daci+/uaNmaXqqHwjHi2RMbcv/RviY5mXhhPOCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMxHsINr; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMxHsINr"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d094bc2244so66116191fa.1
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 12:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708375259; x=1708980059; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9mbfwI7VcZ2C41tv4BgrKjEdjfU6BInjS/WEgMDWhA=;
        b=JMxHsINrt5m5t9pfUMgXcDmwJpMxcdv0vJQk/L3nS2UanLlZW620BNPtAlDFFEbTic
         Wro/Dn6u+gIUJHEQe+BmqXS50Cf8/o19nWAkXlhy+hEXHeYV7lPvUZxXwHNa1ts+sTQY
         OdFkVmc4dYEPUlo6gWp0t2c5dJjhb/ntVxia9kP8m/pd1uP9uyqJrON/k0zvqx4BzNJY
         Ufa/Vs11kABBe+wtLtUWMOwswrCAoQLox5CcIaR9AmIaPyXdOEKP0eItO4RNnTa9bfzh
         Zo460pCME51PCxnNvI6rWW2m3gHqeG5hbB9qFXe+cCy/7ZbXDehAIMhFTfK1j5mdExEY
         6dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708375259; x=1708980059;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9mbfwI7VcZ2C41tv4BgrKjEdjfU6BInjS/WEgMDWhA=;
        b=KX60Jmi5tUt5XXW0KOovfWjAGrSOrG4XnJPdDDTK0o1EQ2V9BscIPXlZ4vhrlaL4qa
         /XBXrLZ4mgVUas3yKBcH3Q8wMiU5WO9rbG4AjQH+vdUCKb7Lsi4a6ewcQwoN7NH6uE1B
         8WOc7rzhDyA/Am+3PZAMAwkQPzIWoR04pdWShGj0jfmwmkUbSQCaq6uSx5V/AU+lNqZp
         3Wns4EGNgGORua6YyvSMMctDjAaL1nO01b4fEDNWkxu71RfOYmUZWjQzEp1u3DS/YLKD
         +c7k3o8Xg8Z0QQ7RVm8wY++89Wblq5osufwGvg4m+v8wZfWcLGpSjjVDdQCw5z1XzBPQ
         rEew==
X-Gm-Message-State: AOJu0YyZ4LAopcj+fGDjGvh/wKiP2XVHAsLJZkE5fWG4/gCTCXppAT9p
	A/MZmWglROFR+Hs5OBucwaYI56Zxj9/QAjEuB5cvCaiR84FYnkshf/6GCRST
X-Google-Smtp-Source: AGHT+IFhotyLRRONTAfHg3o3OGFmzdddSOnhldbM3VL0xv6xY8jwWY8vBg8HLErEpN0vdyua11snWQ==
X-Received: by 2002:a05:651c:684:b0:2d2:4703:1ac2 with SMTP id x4-20020a05651c068400b002d247031ac2mr77037ljb.32.1708375259341;
        Mon, 19 Feb 2024 12:40:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bce08000000b004107dfa6aebsm12164628wmc.28.2024.02.19.12.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 12:40:59 -0800 (PST)
Message-ID: <pull.1676.v2.git.git.1708375258296.gitgitgadget@gmail.com>
In-Reply-To: <pull.1676.git.git.1708296694988.gitgitgadget@gmail.com>
References: <pull.1676.git.git.1708296694988.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 19 Feb 2024 20:40:58 +0000
Subject: [PATCH v2] libsecret: retrieve empty password
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
    
    cc: Patrick Steinhardt ps@pks.im

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1676%2Fhickford%2Flibsecret-empty-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1676/hickford/libsecret-empty-v2
Pull-Request: https://github.com/git/git/pull/1676

Range-diff vs v1:

 1:  877bbfb72ed ! 1:  2cdcba20622 libsecret: retrieve empty password
     @@ contrib/credential/libsecret/git-credential-libsecret.c: static int keyring_get(
       				c->password = g_strdup(parts[0]);
      +			} else {
      +				g_free(c->password);
     -+				c->password = strdup("");
     ++				c->password = g_strdup("");
       			}
       			for (int i = 1; i < g_strv_length(parts); i++) {
       				if (g_str_has_prefix(parts[i], "password_expiry_utc=")) {


 contrib/credential/libsecret/git-credential-libsecret.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index 215a81d8bae..90034d0cf1e 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -164,6 +164,9 @@ static int keyring_get(struct credential *c)
 			if (g_strv_length(parts) >= 1) {
 				g_free(c->password);
 				c->password = g_strdup(parts[0]);
+			} else {
+				g_free(c->password);
+				c->password = g_strdup("");
 			}
 			for (int i = 1; i < g_strv_length(parts); i++) {
 				if (g_str_has_prefix(parts[i], "password_expiry_utc=")) {

base-commit: 3e0d3cd5c7def4808247caf168e17f2bbf47892b
-- 
gitgitgadget
