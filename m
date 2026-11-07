Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063572;
	b=0Uvf6hzesMqkAlNrpZghQ7OMWyzA4qGKw0l25cysoSpTST4I5Tr4lpMRDmrG0dTe8N74
	 LFdeMXdZRL86WgY8FJolAEEDaZ2aq1DINeoHb7GUlPm9ttNRBhyVI5YYs6qg8nPlE5UFd
	 JLK9CRUlp8BKRk4z1MFKDPKBmNG8kUr15fD4rB+COlq8Wm9JbmAfzpi3eSjkmXPsypgxT
	 SuPpuoZyc6uSU4dAm/I7IOIfZ3oMwEjYDzU2cl7X8p+3FoUlj2h4GiakhMxn4ps0Sldku
	 SjKqLK0RL6GbcFEQYXMcwgMpP3S/8q1KGD79/COZaEq+w1Gf0fzM0OEpDLjYpPbJEuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=MkPoeS8t+pNVm6xseyGHw5julQHMhTeaHmkMnOxfNKw=;
	b=fjBmXqZXrSo+fTNR5eP0hNhUKfziaCdHNSkUrLOmQgZ6EbePl9RvGrY3oteQ+Rbgu4bw
	 DNnamKjLdcgbQJZloDXr+357TYt8GKDy5JxOPtR1J2XI9KK0FEY3nH5dGhTkAPh0Rvice
	 NcwGUckThHu/x6St5Qb9ST7mEBAKM+7zOx9vworAqmSaL7urfRb8MSegqzuLs2QuVvJvi
	 l5BSSlkAce5y7i46A3OdX10CA7m6ohiJm2chppqC5PunBdTH2NMm145sQPv7zjnbYqS8M
	 0Dwp+eerxH8IduhGX5P9AxSJq5BBTquDQMTVH2W0EnQ9tcF6M+X96QcQxiNPMXywK8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lAiL/Dqb";
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3760A260A
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 14:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51E3760A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lAiL/Dqb
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f84a55e31aso1097794a34.2
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 06:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794063571; x=1794668371; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MkPoeS8t+pNVm6xseyGHw5julQHMhTeaHmkMnOxfNKw=;
        b=lAiL/DqbpAgYBENslxaO9tMBNtCHIG/RmmFxw8a09bWfkeF4GzvB5pv5OyRbbiDcmj
         LZCgIBX65EVfQ/lKcsLoy/Ms7INM/QVQ+bdbCzRZ4/OuTl+o/9myLiAG29qmWFBpc382
         UC1+6lMpfIz0kG/Ujvx8JzFEkhGXOvEtggHKSUqqtCjn0+wfxiGY85PQORNiAiIpuR+j
         HVpm2XHh/rGE9xirNV4QB7z/OQX5bYMhhpHPJxBNHN1J8rvby77CKtiTC4f8A0IqkJr9
         0o2VhzNrTH68UY2gMaO9Yd6bH3wLbMMalzrOQQRoxEiwT18ru8HszCNY0OG2Dipp3K+U
         AwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794063571; x=1794668371;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MkPoeS8t+pNVm6xseyGHw5julQHMhTeaHmkMnOxfNKw=;
        b=Kev2JO26c0WkpOCckRYPmttVnFYYhpg8YBCsG/y4dkOUFPKTJaieZcvEQwFzVOFhed
         vNGdB2Iy6oYrwQg1OyWVpW/Bd+n/78D735dZWz/ltC2vaogTzaUBiQwMQ1uBG2Gd9E04
         SLfAwQLho0h0Ch+wt9m5d4wTI59YeRXos5brrS9W1xXjFrxQDkdgNSf3vIb2TwAqvekB
         ZjaRwTdidMwo/XP6bFxtf26N3rm9k9X6z2h11AmqCgG1C7mJBWIiMCVwuybZNsA2yYHQ
         C3cyMA41fecFZ4ZCfe2XRPa033bbNh8MMQf8aGPT5sXE4RmN3XfVZATnmwZMpqNVQGoH
         KCnw==
X-Gm-Message-State: APuU4Z9HPKCc25QpyHOFenRxfJG3PFJsgiO+v7IVr7yKIHwV0/a4FSzb
	zS5h8y+4EQ/oqUy/ZkL3NEdtFMIQzJ61efFvm5kJRo5HouDhrg/XUVilK4ukXKQY
X-Gm-Gg: AYBFou2+69UpQMQbUEDHPGUmkjGO7P4irGER+pDuinlzSQ+hEguzWs8JLoHTEsUU98V
	IqayJzK0H1sagRJlVVOMsYqHMd22P3ddOn2xU9L++OYsjA1dVwKnubDn4+iN8DE36Jz9jtNoUeP
	JLXfLDmdaIEuDdNnFe7q5QvOQ8TfyXNdCs9x4YYJp3z1Eer7yGvnjxuJkWuacZt8xE1yTOuJkyK
	ymPYgyBDQkGg+xTBIzHnblD3s8iCUGbaD1abUNiygUjB4Rjs/+1YYT2JmqT9D7sLfLA8oGVylLX
	F+LUrmD1u13Xp473CWLBAlSw924MIEe3NBT2trxwgnkdCeYJc9PCGwOeslstFUA/dF45+XY5sqQ
	+cLKnJ8Vv9669tNiSpTWClVqOH5I63zZR2FalgK8c3321fvrrOhtQGOvd/0cwkqN6G8cMn/LpfF
	OSFtbmCnUAre0UrAwkdKr4oYr0VLAeb2JkjFHRdhUmJ+ZBo9AhN5tNV9dozsspgj85TgslDCYdJ
	2uh5ag8q2J6Znpk6f5WpRPV5iYmqKGtMlSdzdYOeV+UJ+Gymq4ZCtslwx1hDs3Jmpef5P0xrQU9
	b6N9KtdtBiKbPC5KI9T8XPxGGUoddvo=
X-Received: by 2002:a05:6830:349b:b0:81e:a323:f3bc with SMTP id 46e09a7af769-85f1cf57480mr5703612a34.13.1794063571394;
        Sat, 07 Nov 2026 06:59:31 -0800 (PST)
Received: from [127.0.0.1] ([4.150.182.93])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dbb2956sm4411996a34.7.2026.11.07.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:59:29 -0800 (PST)
Message-Id: <b4378b352769cdcc2e9cfdf40efe173123ea9ab4.1794063565.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 14:59:23 +0000
Subject: [PATCH 1/3] t/helper: rename test-genzeros.c to test-genbytes.c
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

The next commit adds a "genbytes" command to this file and turns
"genzeros" into a thin wrapper around it.  Rename the file in a
separate step first, so that git can detect the rename and the actual
changes show up as a regular diff, which is easier to review.

No functional changes.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Makefile                                      | 2 +-
 t/helper/meson.build                          | 2 +-
 t/helper/{test-genzeros.c => test-genbytes.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename t/helper/{test-genzeros.c => test-genbytes.c} (100%)

diff --git a/Makefile b/Makefile
index c2a6098484..8d214286e0 100644
--- a/Makefile
+++ b/Makefile
@@ -825,8 +825,8 @@ TEST_BUILTINS_OBJS += test-env-helper.o
 TEST_BUILTINS_OBJS += test-example-tap.o
 TEST_BUILTINS_OBJS += test-find-pack.o
 TEST_BUILTINS_OBJS += test-fsmonitor-client.o
+TEST_BUILTINS_OBJS += test-genbytes.o
 TEST_BUILTINS_OBJS += test-genrandom.o
-TEST_BUILTINS_OBJS += test-genzeros.o
 TEST_BUILTINS_OBJS += test-getcwd.o
 TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-hash.o
diff --git a/t/helper/meson.build b/t/helper/meson.build
index ae513b4cdc..f99688c49b 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -22,8 +22,8 @@ test_tool_sources = [
   'test-example-tap.c',
   'test-find-pack.c',
   'test-fsmonitor-client.c',
+  'test-genbytes.c',
   'test-genrandom.c',
-  'test-genzeros.c',
   'test-getcwd.c',
   'test-hash-speed.c',
   'test-hash.c',
diff --git a/t/helper/test-genzeros.c b/t/helper/test-genbytes.c
similarity index 100%
rename from t/helper/test-genzeros.c
rename to t/helper/test-genbytes.c
-- 
gitgitgadget

