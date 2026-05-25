Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BABF352F87
	for <git@vger.kernel.org>; Mon, 25 May 2026 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733812; cv=none; b=IdZUJkP4JIZjawMd5BDuoNZ+stTIK4xrjOTV20xjJBL0IBA8mOn1UjafMHC+d1/t1XqolWWhL1fO8uAvHuElVfA4TsN/Y3QUn3rYrORx0mBneaP29n+AN8opGRisav3kxUDx92zIxdi+TMBERwCBOKcGFYvFBdVvnaSFDSP0BNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733812; c=relaxed/simple;
	bh=84yWYtu8Ukcf8m2E5HX22zWAIn4XWBj6rYLxv8aDgTk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FiuUw7hf5lMdLdpaOthEQvdifHKDk8Ay8wXUVT7YF6Kst2k3izf+2PikOleuS+kVVNRrW5CwGRIJreFYvkYb3BwHaMxGe/pl4ezkZD8xYFma7N/sqsQnHX25vtPzFXR7stLjk3ZawZoRFsjPPeCZ3YwQWQhJPNt5sxsaX65xEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIUnAhQE; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIUnAhQE"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b7f937ef44so63231076d6.0
        for <git@vger.kernel.org>; Mon, 25 May 2026 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779733803; x=1780338603; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyGWZR2tdn1LCnaMOm/4BTqwL+ZMt1fcY7hE1un/QlA=;
        b=bIUnAhQEIEupwfKgRH5qecAZrJ0gdC+iHqmQflkCQtzcZLQWnzSl2ooYtotCzSc9ig
         41RGvTsong+79S0Fjx7AAFANUheQwmJT0GCESKZTX6RJm4u6uG1Vy/5C0L/eIOITek3d
         rY20k/K0Mpah9rbY0c7WYD+hZlIX1D6+MUNNHRmZ9TGe+6aUMij4VRdOpOVg1iFZEqOO
         VtoNOD2oeHF5jpUQ9N/iycOwPMWRHSl4gBe8KKHqK7b4w/Bmzo+uSYRJoRQSOsFNdQno
         JB9YqYAjIf9Mu0lzUNZYKiVARRzvm3LTj+WG53vTh+Qf6yfOuNylk4mBSiS6UqYgg7g5
         +2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779733803; x=1780338603;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AyGWZR2tdn1LCnaMOm/4BTqwL+ZMt1fcY7hE1un/QlA=;
        b=DDwX1miuaPCj4uy5Pp3zKPtJ9u8b0HxtAH/ubV+OkKqF9rJDM+GyGjn3DOezuo64eI
         CJggEvbgFFFqZSxUec/TXbQVW974hgx7X26ZHuP9H3HefX1qEsdJ/5fm2R2dsTTcBJIJ
         BUnJ5bRPWgaZHZkuj7tfw/WTN/3dbrfAgogcNB4ySomCIl8EtMwkBkWoSBICjwJ0JcM7
         wRP6ZTTkfIvV8yV7YTN3eZ3EdIahSyz2OKEmxfJg5ccUOz/u3+W3DAnNkrFCC0nx81sg
         OdigAOQ48R7NvO1GJmDaI3/o5D1Yge8MYzuOJ5Zx9W9JuANRLN13mjzEQG8lh1DY+wVA
         /ogQ==
X-Gm-Message-State: AOJu0YyHFvRZeIwwbYklvwpGQm/kbdZ3aIV3WpC8mYEkCgf24b6qlQk/
	esmwcEugKT1XhGjo+oVBuNv4eUBQ+yEUQgCN5VLI+NctxH1SWs+cOUGEsbMa6DVA
X-Gm-Gg: Acq92OF12ARWtTiJrX6YiAeHNQK9t+KcCa6/n28LvVdBuC0FofEDk8vVpGv/ELLO/cD
	meWvJQgVz5PxUxsxcee5u+6mdoL43AnrMvj1ChSQOxmrmoE/6I9dh2We7W5PoxhtRvtC+jigGV2
	r4KIMSUAGBdG6L49zjHEhLiexdiSRDhk7/rDBWEJDbQBwPgGV9/6oPCQWfdiOubpkEpBBF9Vqfh
	r1NlOBZFP2UcIq2hZojFrQH4gk743s6VjpxBIFxvV/HqEgOtBxZMKqSHkYjOeQlCEnmWgFLsrS8
	QCZt5KzrrMEdZMGaeG8V0CrBY77//SzTH4zQOBo+Z1pGyWuCsbNnghtJ4nZsF3MC3nwyFrKSkAi
	3QDQFQMj6WA/uvFLitIxV3CsXHKBiY8uE8weCgsIzKwU40OtXo7C454xcMKL43Gp7xlPFDaT4jI
	6rrRuaUsHxlywLzjadNj0oEUNsxNBaMo8oacJ9O4Z75Zr7sBUD
X-Received: by 2002:a05:6214:e83:b0:8b3:f59b:6c8 with SMTP id 6a1803df08f44-8cc7b5c2791mr242329486d6.31.1779733802860;
        Mon, 25 May 2026 11:30:02 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.180.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81316d44sm115499326d6.42.2026.05.25.11.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 11:30:02 -0700 (PDT)
Message-Id: <de6d85f9d756c294b3f450f75c2d62b01a64ec86.1779733799.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
	<pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 18:29:56 +0000
Subject: [PATCH v2 2/4] userdiff: add diff.<driver>.process config
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Add a new per-driver configuration key that specifies the command
for a long-running diff process.

The name follows filter.<driver>.process: a long-running subprocess
that stays alive across files within a single git invocation.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 userdiff.c | 7 +++++++
 userdiff.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index fe710a68bf..81c0bebcce 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -499,6 +499,13 @@ int userdiff_config(const char *k, const char *v)
 		drv->algorithm = drv->algorithm_owned;
 		return ret;
 	}
+	if (!strcmp(type, "process")) {
+		int ret;
+		FREE_AND_NULL(drv->process_owned);
+		ret = git_config_string(&drv->process_owned, k, v);
+		drv->process = drv->process_owned;
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index 827361b0bc..51c26e0d41 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -31,6 +31,8 @@ struct userdiff_driver {
 	char *textconv_owned;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
+	const char *process;
+	char *process_owned;
 };
 enum userdiff_driver_type {
 	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
-- 
gitgitgadget

