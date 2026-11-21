Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795282561;
	b=13puCzetH7VL8Mgjc9aO0btoqbzB2347Y64vIhAEJrzaJ/rGDlIB94+tE8qKyfythEBk
	 XDHR6whH5AshX20UDCHkKcPFGoeKUw0id1gqfLblDFs2z8si6hqry/jdcBmAif9Fzo0qO
	 oNS4NS/X4+KP8qJnuUe1kkfqP1rqGR6rfrv4B1A/5Xzjas9/vYWQ39cJOee6tcS/NAEK8
	 BYWlBJ6njvWMFtfqkwhsxyfEW2RFqWjcS5mi9FRLBHjEK1avugLbV+2q/VGlWZHIw0An7
	 KaI+xwsC4+jShC7VwPbmrSuB1ji5JHUt7GQw/sA0F8nZnMs+UERD4UvfzAcTSXQvgNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=JXeTEyLnAy1Ffy131kvgpeleKf47wwIWjuGfmt3GC5c=;
	b=NylIiWFp41KssZjvXIe7xRpKOAHpb1tsu4N0+tGOC7EjIwxFy3+onW6VeZ79CGUiX+eh
	 bEoH127O2AT7YRcdhPbLTPCTdOEdhoelRCgbxM8Txo6k/rk2lq5D8quXOrq4/dwvVQ0mM
	 Xjj561HMUSYn7Re+7xwb7+nJIVgwB6qBF2HazpCC5Opm/2dG4rIiR8IbOZLPSJs1ucuDl
	 uzWf4NK9QEqLzcjCV2LQz9/ZZrye9dkPcuhWzAwVRB1QywMKAipM/EC2fTwwOKJFOxAYX
	 vzORrX6DUZuSebylJy6ezpgPsRV1gEpwlkRKP9QZUJrjnHxDatdh6Dpx5/e/ANFXmmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N8FeQVSU;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9839F606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 17:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9839F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N8FeQVSU
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso835371a12.2
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 09:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795282560; x=1795887360; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JXeTEyLnAy1Ffy131kvgpeleKf47wwIWjuGfmt3GC5c=;
        b=N8FeQVSU1IT3zlgbFDD0pIx6RdN5tR19Op/KP9FzaegFstacZyhnZykXxB5VEU8R4x
         ncdBDCduFg4p4BjLY2d4Qb2VeknxANeht7aXgEwpyIlf9vciDVdMV8m0Ed+7MReIjie1
         Db0fHnxvpGUaHSos2x98g4YK5HlNa8bSPXqsFgSyTc26ZdblgxtVpoRQyTW5isrOaFKy
         4bEAX635L1wnLmvukrWyhFXzRe2f60J4uR5fq8HOVq0j/xOcmwsj1BDm6+72WBF9eU1H
         UR/RiCVeFWgaACKj7kmDd3vlFnlSTZuD+xZTSX9blCW+K5KXB/H71O5Xt2T1NrzUzNKg
         t47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795282560; x=1795887360;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JXeTEyLnAy1Ffy131kvgpeleKf47wwIWjuGfmt3GC5c=;
        b=QM3CxTQwjG5meYeNmaHj+Wx80Y+ju2MtscJKj1u5VD8Me8YsBpLkOKkM17pfAqvNf5
         2Ew/hOTqamTkUyHTiXszCznumuPo2lOtYp11cdmbVVglELSNFqy/Y19KjVKP9c0k81e2
         LI1zuxzq1v68q6W416kzZvhdpIG94HUYE1bLNAEYjTxjZRd2jtbVIIJtrhLetCjMZUb5
         jdNUM6KtUFk5rUf1cceshYhM3onQnt5XfEDsAGPOtZRTDQXz1hTeOQvPCV1IAaVT0gV5
         rB7BP62jvZn7mvmJWBrW2ZUkMNEORiifb2YfJW/BRyod21uENFI4eLs4LjV5siE1DWWW
         rw+Q==
X-Gm-Message-State: APuU4Z85TGTtd1yKL3jRf0Hdsi51pAoVHZlUxDLG13JPx22FU/tyhNeE
	3KzmalEgT8dR7c7LcgVNSf7HXXirKZSFxZQlFZGLCO+QC/ljx9c7LUyZGnxQ6g==
X-Gm-Gg: AZFdTZfbbqooXQ0bg77OjZTbbs2IvISH3cxIL7KZg2xEcZkShsvGOdbb2YO1QB9P57q
	Yh2/scfMTYsBQZJ9gtbxCvhkcxD9sN/bOoCr4xzU0dsPPoMVFH4NRqFA5E0LgJQMyoZ0bio79+b
	Tj5Mtck/8ezpAfb4c96OgFiESFjqMyt6lWMU/Joq9qEbvYHIUyi3X2yH2xTLRPBCZ9LoRbOni83
	6bv2tgY1/etbeHH1/M0UABe/TMxqFPNGFB/TazIGVKvdVgPf/XZI6CNvSd2RuIckesKVDm+2aOu
	X5mBNTT0nrrHtW7nGZeH2ihE9LpLb5mJ635fFMJO1hEYDDeYZei+AeRJKQFjxzFThVng3/SPbBp
	7W+YwgklVRMUuG9rKhsIB9j7URQAiRO5tnY2yC7IR66rTVJO/GVhHBU/m/eA4M9J7MB+2nUa3Me
	02kmJlGQtMV3G67zPt5QYbjeOq5ztAr2Ltm0udlY90qDrK+uP7tKjXTmkCWt7dJY90TxOiFNtwh
	ohDSzAJh9K8SjjlAYpKZHG1bgC3/hDlrUKL/0B1ZYOGmZ32W37ERQe6SEU8LTm82s3KuxbGwQ0f
	DgFKU7MZU9fHAq+C6J+7YUMKeRj2luwf
X-Received: by 2002:a17:90b:1d03:b0:3ab:31e6:12fc with SMTP id 98e67ed59e1d1-3b41c5574f0mr6509077a91.0.1795282559835;
        Sat, 21 Nov 2026 09:35:59 -0800 (PST)
Received: from [127.0.0.1] ([4.149.237.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b73b2b3sm2541543a91.2.2026.11.21.09.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:35:59 -0800 (PST)
Message-Id: <pull.2500.v3.git.git.1795282558789.gitgitgadget@gmail.com>
In-Reply-To: <pull.2500.git.git.1795279741855.gitgitgadget@gmail.com>
References: <pull.2500.git.git.1795279741855.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 17:35:58 +0000
Subject: [PATCH v3] setup: fix incorrect word in code comment
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
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

Fix an incorrect word problem in line 271 of setup.c:

will only complain about an inexisting file.

Change it to 'non-existent'.

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    setup: fix incorrect word in code comment
    
    Changes since v1:
    
     * Update commit message from grammar to incorrect word
     * Change word to non-existent instead of non-existing Changes since v2:
     * Really change word to non-existent instead of non-existing

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2500%2FOphirBleicher%2Fsetup-code-typo-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2500/OphirBleicher/setup-code-typo-v3
Pull-Request: https://github.com/git/git/pull/2500

Range-diff vs v2:

 1:  3b7539bd5f ! 1:  2158470090 setup: fix incorrect word in code comment
     @@ setup.c: static int looks_like_pathspec(const char *arg)
        * If set to 1, the diagnosis will try to diagnose "name" as an
        * invalid object name (e.g. HEAD:foo). If set to 0, the diagnosis
      - * will only complain about an inexisting file.
     -+ * will only complain about a non-existing file.
     ++ * will only complain about a non-existent file.
        *
        * This function is typically called to check that a "file or rev"
        * argument is unambiguous. In this case, the caller will want


 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index cedc031c54..3aaa1b65b2 100644
--- a/setup.c
+++ b/setup.c
@@ -268,7 +268,7 @@ static int looks_like_pathspec(const char *arg)
  * diagnosis when dying upon finding that "name" is not a pathname.
  * If set to 1, the diagnosis will try to diagnose "name" as an
  * invalid object name (e.g. HEAD:foo). If set to 0, the diagnosis
- * will only complain about an inexisting file.
+ * will only complain about a non-existent file.
  *
  * This function is typically called to check that a "file or rev"
  * argument is unambiguous. In this case, the caller will want

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
