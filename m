Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793337453;
	b=yu9k9SrAwQPs0997gtpdkEfkXC30HvqeHWIdkOkwdjFX6HohmVFVh+D+VzAaQFI4rdcx
	 4QvG0NDt/F1GTnlNtF1vR5vvslNKFVjDUaY/8R3p7FOvm9YAOrDHTCarjDjDms5E3IG/b
	 MWtV1ZYH3N7hNNW7q32R5NSlOl4INcZPcccLbuwn1IeZ3Of5JWybhnmqfCgPnEI0crUFM
	 aPFP8PC+HqtvDQndYyZEpcRl25SkOrCaF7oroOYax3unwZywf+fscfH7fpnfK84qXBl0E
	 7h4FRTaWoaK663pIK6eDLsZ2UIosgMRt9UCTPP0O1tDOXTBJHC4/egrJc+vMTdDfl2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793337453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=IzDjqdOHWAiK+KdsxbHryF1w0oCjsA5PZ4HzbPY8qm8=;
	b=N7awn+NRzsgmaCRBJirvmTKFNIgXsg3Gmsn/vJcSjyKEdoLkTKwPwURZqS4fHQjrh9Ne
	 LAnRdQlL6xforMEH4Jn5fO7Mst8Yn2EPSdCSDFN8ZLaFHvIjsc/wUk88djB8IIxP8XdRC
	 L0GQJFWOFaGSeBXjVkB4a0PN5J4UG30vT1o9eWtGXoif1wFn22MPdrzLAeslKtxis/e23
	 3PCi20kuVF7REs5cvpk74fRQ67IPFJWbxEXQj6M4zn6fI4SORY0b5o/Z1sfIraXcwRnqr
	 W4PmcpwhoHcxWsImvkU9VYgCfZmE/k5bhGyJiuG9DrfH2WwOD7YdS5nha7MlSQRCqsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YtMCsrub;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F12606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 05:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F12606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YtMCsrub
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35b2c599f43so817069eec.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 22:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793337452; x=1793942252; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IzDjqdOHWAiK+KdsxbHryF1w0oCjsA5PZ4HzbPY8qm8=;
        b=YtMCsrubyNS496J34oaEfTSAqaX1vS5tyxrn0vNRt14PSChN5WaHiL59iJT0obaSai
         zRnkufkceX1wbxIQuJqVQIsE6HXYZkHphXRwpgg5mfQZiPVh7ZNm1B/iigAqbiusDp0v
         st4eacTUk1fWrtM9TyMUPobXwYflmbN2kcKbVL3Z3eW6kNq9Yw4+sNO4cyCVQ5Uk7rXB
         lRdl5hCWdy7tMYXWBgsUdVivHpqRgiIMfjRCHt8P5u6E7VpUnSDq+N95KFa8nE2Cbqwp
         kDUSD6U/gzHeASuUSs1Yh7IZOWFFc2odzSZ3o9mTwOn++xd7Y4pSH4eJHVUOTVukdfIq
         oTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793337452; x=1793942252;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IzDjqdOHWAiK+KdsxbHryF1w0oCjsA5PZ4HzbPY8qm8=;
        b=tzFk79gl1nbMyPOJYnzyYBJpg+O/Dq3DByO+2HBLkqrnnOwZqcTUE0mdF8FHVYKeST
         4tCZQT0tKLv8sbzAhaGamw284FxKJjHAWoRMm2papm4LwqJCF33mUidpmZZKELYXNEg5
         RUyAdEmZqIwrW4ovVyJnlN80CQ1MnGViBZwkc1WAh8Clljp0gRwn5qzt1bYzfXghAJOD
         scakS4crAv3Fp2Y4Y833eqDjYc8V+fRykqyF29Db+CAngyRStYwQ1u+5OpPLxZH7c4u4
         2EU8EMGa5NTyrQH0MUc23Q9BalQ13k0suvN8MVNGbylePahmkuu/TS98wZQw2ZzIi277
         Ebyw==
X-Gm-Message-State: AFq9FYIwW73xBxSWFKTf/6CKjFYa+qmSxhXpx5lD92T7tpkWCvOhAhte
	G21CVP811ASVff5gw+hwzLL9sX9ejtl/1D4lqF/a8/zex16DFPZ7HIrNdKGWYpr3
X-Gm-Gg: AYBFou3towzSwlKF0gL4PhysXFpAwxtTM8+DFsgO6n7B8uIa0BByQLeZ5sr8TR0E0Qw
	NQfL9jS8jWXh4GQ5vJOA/woXG5A53CVFzyA8cbsN9WFisknTcjQQk0cAPxLUaVp20WQH478Nr9Z
	5SSZbMzVn9eXJZ+rsB1M3AylC3eSrMG/Y64JSoa8BbxsWTWaPzO5Qur/bhhVHvLem0th5I6A8pG
	WGj7LRBiVxufSoxD6qA7F03zgnSVBcfH0cwANkzQsoATF2PwrOG0wveJyKsFjOp8n+roHJsTExB
	9ATqs1rcQyarnMMDNTk0CL9QuXX+7lA9o1hiU3f4ZYYKMWzYnp2CwwRIptPsreuUhqQ8R7T1DU7
	Q4wdE8CUJ7UmBo7I/CzhxstsoJX3S/Lu3l8JrV1MezIzRlbvinSAmdeALFfnTacPu6CSAi9CZ/m
	unzKrAmS3PJNmAvX5XqdaNPI4sQzW/U6L4TFo2d9BWwWPzqmTrzozkyBMJoUYQW3mid2O9j2GaV
	RwSbt8s4BqTtzyFpsWLwatdQfjXvmyi6bVIMTTy7E7QwJwdJSrB7B7tJcarFm0ZtxuaWdxlFqB4
	I/TcM0CSK3E0kh262JU21OTS4s6rBBycbg==
X-Received: by 2002:a05:693c:88cb:20b0:343:9eb1:9940 with SMTP id 5a478bee46e88-36a423e8150mr2141676eec.26.1793337451939;
        Thu, 29 Oct 2026 22:17:31 -0700 (PDT)
Received: from [10.116.151.240] ([117.213.200.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4239ca82sm3714705eec.0.2026.10.29.22.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:17:31 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
Date: Fri, 30 Oct 2026 10:47:20 +0530
Subject: [PATCH] doc: config/log: fix typo in git config docs
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-config-typo-v1-1-f9797f518c43@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA2MD3eT8vLTMdN2SyoJ8XQtDyyTLpNTk1CTjNCWgjoKi1LTMCrBp0bG
 1tQBHQDC8XQAAAA==
X-Change-ID: 20261030-config-typo-819b9beceb3f
To: git@vger.kernel.org
Cc: Hardik Kumar <hardikxk@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793337450; l=955;
 i=hardikxk@gmail.com; s=20260827; h=from:subject:message-id;
 bh=AngNRrBbkq6JCZP6Wbqi6YtOgfberI6ECJsQtTJHA1A=;
 b=rFc+dRQrJZ6q9E7SGxCC8chDg51GKDkiNAFeAsO4EYhuqeWPZe3vrQ97e54QiGwoE6TryFzDu
 4Thi7n9kXuBDtwVI8nFXZUUKCZ6CNgT1F39SSvtuyhmZPSL2QO10XBQ
X-Developer-Key: i=hardikxk@gmail.com; a=ed25519;
 pk=56yFuFlLHAdRemUZghoGHVCijEX767atrut3dPD0thQ=

Fix an obvious spelling error in `Documentation/config/log.adoc`
"overriden" -> "overridden"

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
 Documentation/config/log.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index f7dfce69b5..cb82f521ab 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -61,7 +61,7 @@ This is the same as the `--decorate` option of the `git log`.
 
 `log.graphIndent`::
 	If `true`, indent visual roots when rendering the graphs with `--graph`.
-	Set true by default. It can be overriden with `--[no-]graph-indent`.
+	Set true by default. It can be overridden with `--[no-]graph-indent`.
 
 `log.showRoot`::
 	If true, the initial commit will be shown as a big creation event.

---
base-commit: b9e5cff1803ab24582201ef059516eb16014b9d9
change-id: 20261030-config-typo-819b9beceb3f

