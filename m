Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC821ADB9
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609286; cv=none; b=SqImJmIk3L5kwLIFPn6acn6u3+UyFRmSIkQOzIMYuOjsw8bM9Jw0Z1+lxQLdQWDfHlZOOvjkyaIq7KSn+o3AB8xG5xz4pbv14sZ9YZqm2jtGuGUv6YyQ07mXT6xYL2xwB0vaaOaQxoE3NM0D3Eo9N9TDNYHNUP5oaIpn6vpkXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609286; c=relaxed/simple;
	bh=rKspNOZGOF6mzjS6qp/ub6nCoTopmkghzR6IP3p6I4I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tITfoV6BNpUgDX9h4f/pazao6bzD4fnZbQl/hZglKCY0c0zrgkW/zjuRaZEK4LstRlYxELCNHdEATYRANZElsRE3oztAfCJ1xgk7tiFMLGE3uZ4FpS2l1K8lj8wxrr0bfsyXP+BdNhuyB3UWB86FPeuSjgTduxwrkTJ8yTFdJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHNK+7nE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHNK+7nE"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso17995845e9.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745609282; x=1746214082; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w9gi8XtIeR1ASKoTPMrWsnh8ZDiItl92o1ibqPDMog=;
        b=eHNK+7nEM67CGqSRaTYjsolTECzNDEpt9eh1YIkJHgcnqVgdxgfMaL5NCAASGeoIzu
         wFkQOm1XfsnVt3XY2ZJuD4CVyKhVt9GuJqjivX00UoPOhiDfhOQCTuRGmqdG99Yxzoh5
         hyrChwYmgFcw7JaFPpIjWxcHi7gPk/aR4P4cRETWC5SSsisJFIkcQqlEUJ/p3Vl0UUxw
         lQZlb8xaGVG+TxhficDap7Rtfw+1SXuRsM5708Z8Sijk/HyPeEF8wVaJGpy76DWgLx88
         i+HjrNwkbCZB7EmWq4baxlCMtMBM9sbfRKbkCERXlQLFEM70d30f4Jq4PIJa1WShrgi+
         Htxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745609282; x=1746214082;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3w9gi8XtIeR1ASKoTPMrWsnh8ZDiItl92o1ibqPDMog=;
        b=qYvF2Xj3/Gj3qorRf36oeSUps6ZbHNVpR9TsjwEsQnqhbTxU7Re416k6MoNJS46Jx7
         N7Dp7VBnlKTezlRxJD/+kznsqo5fHxSq5WsT0KnSYKH1KbfamVvPE2IeGLcH+CjR2nTW
         nrWBWs3f2led4QMhHNYacFHb93UYDQT/x0q797xUVxlOSveEQ2YAVlVWJSGHWIKQup0n
         KTXCpnI7ZiwL5cLeYD9lIsjSoW9REgBLBuVrVRGZhiPpLhWQ5qW1ug71hf0R6wsoPfn8
         PR0jB2hz4KgM5e0GFcyxCKjEMptj7eQA2Onv44yKHjZ0uG233ME5cXa2cwPJBQuSPu/I
         Kvmg==
X-Gm-Message-State: AOJu0Yw808z6XaC54jExx8Cfb1yVnUgVUgM5WoDdgAE62m7gcjFIgHyv
	9+l6Cu37VNfVbJ4n/35+n+HntVJCTZpGBK4AG5Qh488YSCpbsw5nUJVNFw==
X-Gm-Gg: ASbGncuSXiBDPJ21j66ctzt9brkAcDDAjv7JZC+KJ+4lu/WT8B6BZcWecDxndFrI4mj
	z9CExHT81JcNGXxR+1lMMEjFjADE89fhIsaHjw1UBuFCjVKIfP4A00LmskfAzG1IP/xZHJWFDGL
	1upl9AHWmu0F4iqlCaakCZhL8v6GAeew/Ttz8Et3TUjGFtU3eRW9Lt1njsGu4goyPJwrnfWUtjH
	htZXsvqJTPS0DE+AzXPgaD5KLDCNbe2ilA1X3QAiVP/sK/W2IhTJ8RckugTzMF6w30v+WZypzfi
	Z38y5IcsIeij4VEPS5q/ckDEURuUpaVoj3myselL5A==
X-Google-Smtp-Source: AGHT+IEJ2g+hrcRAkHQcuu62+8hLElelBIGvFQzHQ75GgLLvG0EN8iO2UrFdbBV2d0KOfYxhjz8pOQ==
X-Received: by 2002:a05:600c:3b83:b0:43d:ed:acd5 with SMTP id 5b1f17b1804b1-440a65def49mr40187195e9.10.1745609281903;
        Fri, 25 Apr 2025 12:28:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a53108f2sm33659465e9.19.2025.04.25.12.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:28:01 -0700 (PDT)
Message-Id: <825d2b01eaec9d75bdd0b3210816f0a9951a2503.1745609278.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v6.git.git.1745609278.gitgitgadget@gmail.com>
References: <pull.1897.v5.git.git.1745607965.gitgitgadget@gmail.com>
	<pull.1897.v6.git.git.1745609278.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 19:27:58 +0000
Subject: [PATCH v6 2/2] bundle-uri: add test for bundle-uri clones with tags
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Toon Claes <toon@iotcl.com>,
    Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

The change to the bundle-uri unbundling refspec now includes tags, so this
adds a very, very simple test to make sure that tags in a bundle are
properly added to the cloned repository and will be included in ref
negotiation with the subsequent fetch.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 t/t5558-clone-bundle-uri.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 33a7009e9a2..9b211a626bd 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -107,6 +107,36 @@ test_expect_success 'clone with file:// bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create bundle with tags' '
+	git init clone-from-tags &&
+	(
+		cd clone-from-tags &&
+		git checkout -b base &&
+		git checkout -b topic &&
+
+		test_commit A &&
+		git tag tag-A &&
+		git checkout -b base &&
+		git branch -d topic &&
+		test_commit B &&
+
+		git bundle create ALL.bundle --all &&
+		git bundle verify ALL.bundle
+	)
+'
+
+test_expect_success 'clone with tags bundle' '
+	git clone --bundle-uri="clone-from-tags/ALL.bundle" \
+		clone-from-tags clone-tags-path &&
+
+	git -C clone-from-tags for-each-ref --format="%(refname:lstrip=1)" \
+		>expect &&
+	git -C clone-tags-path for-each-ref --format="%(refname:lstrip=2)" \
+		refs/bundles >actual &&
+
+	test_cmp expect actual
+'
+
 # To get interesting tests for bundle lists, we need to construct a
 # somewhat-interesting commit history.
 #
-- 
gitgitgadget
