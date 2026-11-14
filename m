Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682100;
	b=fVslSYCffEO+w5gV2DJaxleQPQ52BKCCaV9wkoJ7zbcAIEMtgpDFHt8HGxpPF8YJrhJg
	 J+1cuIRal89nto2sc/g2TPxDRboFpzOT5e7nyRrTWNZG1ZHIyowCUreprNuLDSvnxOI48
	 Y1yKsg2r8m1ODNEIeZ3Zw/ncwQX+KVTsd1rnXbZeyyfk+Er5wY5wzSdI5v7QZBrAHja6h
	 1wZaYgQzfWgfPvqaBiBiJNFnp3V/S++PlrKMJO5QgFYSdaGlTVpmcMpVIZwPVZ5doE5pp
	 HERyBSSg58ZdeKzRpmJwTl46npo2dZ0gepYqb1sP//7GL5DPlOLh9VeFsj3CyqGCG7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vLokX4QUu4qzYIv3Nn0aOH3CaSWj15rPdZZMle35yt4=;
	b=qzPZ+srT+c2YeuokPSQPi42M7QbXrPieBEjqBS+5+Zd/7pby1iOS6oIQ4H+uowhmLLdV
	 k5ekALfX0q23hDO4/wTUNnIrkvN5iLeM0yCf/c6fxMq7i+hPXVzb3UYzoPYj0vPl0sBUG
	 DK+rwjkOHo0gMLPQT+N3Ndh8PWUa6yPjxRIo4qTUGjvamk8I/51KFCU6zFDvP+F66raH3
	 ICqF0LAuyqWWY8rxHE/L9xQoJKU+9wTdG2jRFYV3jSnuWp7pLZUQEUQ3CCEmaqyCLvViB
	 SKuNm7XYcVveX/VkYVxFBXY95tBsd6+DToKL2FjwAjn6g0jCEArgo2v3XQvGXCDUjKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FZ4iHHTv;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BBD606A331
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 18:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69BBD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FZ4iHHTv
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so2335335e9.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 10:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794682099; x=1795286899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vLokX4QUu4qzYIv3Nn0aOH3CaSWj15rPdZZMle35yt4=;
        b=FZ4iHHTvnbPdoZPpLFEpTXpt+1lqrgk4vZPl4KvGWijXhblBSf1j3DAXeK0L29FO2T
         bcpVPFg23oRXwJuEG5tGBweu5UuyaSM7PaNfwZpi1sK/Eo72n+kzp4ekmhPyMbhSRGS2
         AMCWwGP389bpjVL7Z9QsHAOVV4/WkWzzr109Ko0nlO7S1DeB7V4oz81M5WIAdKZCI+XN
         MI0vE9Ix3H3hv822ZvlVmYNAjZCluAyF0hQlu4A1KblPTn7ADkK6eJ3CvYRl1TqIGQIw
         EYO6Fr6xH0iTgPzjrkr6gEA3hMDzW6g6sYYMUhLeK9dV2uKxcQWMArS5b4+7j70j9iHu
         dh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794682099; x=1795286899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vLokX4QUu4qzYIv3Nn0aOH3CaSWj15rPdZZMle35yt4=;
        b=xlA9pxJI3poryzGY3VhvoNAuqMnJ/Mm38T8y93ObdOaj7Na5rWXNjbop9KdLqrS2bG
         yjvdghC/AR8PQee6E0mdqA6UAzvxrz1NubeMcehCkyQtFoq4N7oma4csodMiaHMjNNlT
         ffvQJs86ZaOtu0IbkysZVPaojvgOhEAbJl/rN3ykdr4OvizpRMw4w+JUcAkPAPhXGiDm
         9gI2AM3Z4YuasBwHhLS7yQ1yg7xkDR4w99Z9pXNPEIAZyBIopxzlrQAmmLK7p/4BdUhi
         Gm6ERZTcT+C2EU/hvKDBDd502+Ikcs8wKs9X8Ldia3RZWYB2+fNN3ploxKPHJW2DVuLI
         Nvgg==
X-Gm-Message-State: APuU4Z/+x+3eP0el6h0rLPzMAaQCWTrNWi2Y7imZiepQVjZbs4PMwMmR
	At93nQou3itTovCqtGZQ/AU8MFsprE0ZLLlkNpqP0sVpyoALeT8yeNsk1oLv+w9BCLo=
X-Gm-Gg: AYBFou1JiTVOVCi1Tndnku6sn8cpkgpozR3V2Do097ccaH+y+pFa13jhwKVxI+8w/mn
	pQWv/R98StZ0lFIZIrEvt90x+FwyZzCx6aX6skGC6ubpMxZRubcT84/H/mHmzAu/1KF+yh7ReGA
	XibbLAP9v5pVBFbDNqihEd62fBk/FsGVYVBthCXvmTwalC8V7LsnlsIeaasLiltpw28zWxZbW2H
	viZrr7yPcdVzl3m1yPGuHQlpZI48KB/x9Jzoh3gMBS1yYpl9QQruM8fwB9CnnOS4PqWL29WShLz
	QRE+W6ZYH0WROGbDU59RhONMDQ0MaZEVGxOX0XYEBXAEf3YW4ciCt9c3qj46/ptork2L1qAJDc4
	jnUD3ioFM2c3BhwoCUT4a9LSPoj7Md/rF164E0JP10lp1NFkXXITmp+zOzj7IbSML7bmwcTXoaz
	KpgIldUHfJlIyq4OM2l1qgAsvnRj0Cjp6Tfq2nioAuHhlACuq+5SDKZ9RGFUZeuqI37t3ybl6qi
	CEzYLWTzRpPyzboIPh4AD6K4hWaQKpb94oUM8jOnUl74yPaEMz8zrNQT8YvHdBzSr2tf6jm6+rZ
	DyF+6EPEU7dyZ0txzcQia96sd2E1CaaGvGqAOJ/LRqUyLifsz1i/1Ip0R5QRJ+3TNmYnii+N0fw
	L70cicQZrwTjUbPMZE4KazdvYsUgZcOpUk/6OIgjIrO1C7JwGATjN5Sqo/Sv2ZnDOPZj8N71fPj
	ID8EWhdVfl9kPhpFBFIy/w8B8vu654H5tKxBVIIVD297kizESi2OxoIg==
X-Received: by 2002:a05:600c:3486:b0:4a2:c2b:a91b with SMTP id 5b1f17b1804b1-4bb55a6a828mr141888255e9.10.1794682098724;
        Sat, 14 Nov 2026 10:48:18 -0800 (PST)
Received: from localhost.localdomain ([212.88.111.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac0e3fsm128620355e9.5.2026.11.14.10.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:48:18 -0800 (PST)
From: Wasswa Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: tangajoris@gmail.com,
	Wasswa Edson <edsonwasswa54@gmail.com>
Subject: [PATCH v2 2/3] credential: move each subcommand into its own function
Date: Sat, 14 Nov 2026 21:47:51 +0300
Message-ID: <20261114184752.1417-3-edsonwasswa54@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20261114184752.1417-1-edsonwasswa54@gmail.com>
References: <20261104202228.24642-1-edsonwasswa54@gmail.com>
 <20261114184752.1417-1-edsonwasswa54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmd_credential() handles all of its subcommands inline, sharing a
single "struct credential" and dispatching with a chain of
strcmp() calls.

Move each subcommand into its own function with the signature
expected by parse-options' subcommand callbacks, in preparation for
switching the dispatch to OPT_SUBCOMMAND() in the next commit.

The only change in behavior is that an unknown subcommand is now
rejected before reading a credential from the standard input.

Signed-off-by: Wasswa Edson <edsonwasswa54@gmail.com>
---
 builtin/credential.c | 102 +++++++++++++++++++++++++++++++------------
 1 file changed, 75 insertions(+), 27 deletions(-)

diff --git a/builtin/credential.c b/builtin/credential.c
index 72e7b2af4e..d6ba21a2cb 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -9,13 +9,75 @@
 static const char usage_msg[] =
 	"git credential (fill|approve|reject|capability)";
 
+static int cmd_credential_fill(int argc UNUSED, const char **argv UNUSED,
+			       const char *prefix UNUSED,
+			       struct repository *repo UNUSED)
+{
+	struct credential c = CREDENTIAL_INIT;
+
+	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
+		die("unable to read credential from stdin");
+
+	credential_fill(the_repository, &c, 0);
+	credential_next_state(&c);
+	credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
+
+	credential_clear(&c);
+	return 0;
+}
+
+static int cmd_credential_approve(int argc UNUSED, const char **argv UNUSED,
+				  const char *prefix UNUSED,
+				  struct repository *repo UNUSED)
+{
+	struct credential c = CREDENTIAL_INIT;
+
+	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
+		die("unable to read credential from stdin");
+
+	credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
+	credential_approve(the_repository, &c);
+
+	credential_clear(&c);
+	return 0;
+}
+
+static int cmd_credential_reject(int argc UNUSED, const char **argv UNUSED,
+				 const char *prefix UNUSED,
+				 struct repository *repo UNUSED)
+{
+	struct credential c = CREDENTIAL_INIT;
+
+	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
+		die("unable to read credential from stdin");
+
+	credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
+	credential_reject(the_repository, &c);
+
+	credential_clear(&c);
+	return 0;
+}
+
+static int cmd_credential_capability(int argc UNUSED,
+				     const char **argv UNUSED,
+				     const char *prefix UNUSED,
+				     struct repository *repo UNUSED)
+{
+	struct credential c = CREDENTIAL_INIT;
+
+	credential_set_all_capabilities(&c, CREDENTIAL_OP_INITIAL);
+	credential_announce_capabilities(&c, stdout);
+
+	credential_clear(&c);
+	return 0;
+}
+
 int cmd_credential(int argc,
 		   const char **argv,
-		   const char *prefix UNUSED,
-		   struct repository *repo UNUSED)
+		   const char *prefix,
+		   struct repository *repo)
 {
 	const char *op;
-	struct credential c = CREDENTIAL_INIT;
 
 	repo_config(the_repository, git_default_config, NULL);
 
@@ -24,29 +86,15 @@ int cmd_credential(int argc,
 		usage(usage_msg);
 	op = argv[1];
 
-	if (!strcmp(op, "capability")) {
-		credential_set_all_capabilities(&c, CREDENTIAL_OP_INITIAL);
-		credential_announce_capabilities(&c, stdout);
-		return 0;
-	}
-
-	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
-		die("unable to read credential from stdin");
-
-	if (!strcmp(op, "fill")) {
-		credential_fill(the_repository, &c, 0);
-		credential_next_state(&c);
-		credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
-	} else if (!strcmp(op, "approve")) {
-		credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
-		credential_approve(the_repository, &c);
-	} else if (!strcmp(op, "reject")) {
-		credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
-		credential_reject(the_repository, &c);
-	} else {
-		usage(usage_msg);
-	}
+	if (!strcmp(op, "fill"))
+		return cmd_credential_fill(argc - 1, argv + 1, prefix, repo);
+	if (!strcmp(op, "approve"))
+		return cmd_credential_approve(argc - 1, argv + 1, prefix, repo);
+	if (!strcmp(op, "reject"))
+		return cmd_credential_reject(argc - 1, argv + 1, prefix, repo);
+	if (!strcmp(op, "capability"))
+		return cmd_credential_capability(argc - 1, argv + 1, prefix,
+						 repo);
 
-	credential_clear(&c);
-	return 0;
+	usage(usage_msg);
 }
-- 
2.53.0

