Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2631805A
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587074; cv=none; b=KcibLYpcACIVJ1BGlf1pT0/oeTbxl1Us6oZn4um7Szb4oVa2CkUn4jE8QvTZasY1kpwW4LI1+U4zW6pX4xR8LOjJ6/jNiMcfFBeEnIBLTq/LOcqZHivdoqCb1cTPbnd3z84wmuTr4KoUYNQ5PG6PPMwKV35h8IHw+ODoYhMvjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587074; c=relaxed/simple;
	bh=M68DY41uJn50Y/pxN3Ifur7FECWLwTCC+2UxzYZbTxU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kjG8dsgR3aYAGxBy0XLjrGoYNNOvB1XOue8DoKO2NfontFFp3aLD+g33kZ2zJG5WbjeoymZoWNxecLIAjLEInVnQ/dT72FgkL+MO9G9zzPDvGKjr7gf4mC6sT3yKwXU/4PkY6oDY+A9Gh7b/d3POr0UTPP0qGmfEzlSx69ez+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=embq3ltF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="embq3ltF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ede096d73so16403275e9.2
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745587071; x=1746191871; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeXbqD2yCT4bVsY6NcMjZDBpfVf+PYS2Cwtx/Ynoagw=;
        b=embq3ltFcJ129iDpw2eAkmiatOCtqNGVXgbfjFdowfvMDM6y0xqXN4Bl9a21QqYB7E
         uOg2107AkxxPL3M0Ggij8HwTbGSNs9OC1FzrP73FgZOpDX9/9GFEqy7XHnggsgRjJfGE
         ZLsKXx9uree3BJkRN4gOx36/Krne06/f5gCJGNqlSMOTipHdyV2WNEKffvluignaoQHn
         NxsEf8xtSKrnoQFaaByAVHkhIFKMnBeGOdfest4gZgwd2NSXPsJpd6il6qa+mobznT0D
         IB2/D9uCRyuJFln1T2bKEXSCoV+mB6PL0MJygxVCC0V3tR9Ia7LE/nfkMzYr1AJhMBfe
         jJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745587071; x=1746191871;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeXbqD2yCT4bVsY6NcMjZDBpfVf+PYS2Cwtx/Ynoagw=;
        b=O7B3CkaU10aIMzU/biQn5T1gl2587xIQDQ2FFpi0SH7M1kde+Lqr9S1dGHbkM3iFX+
         vn/PHqjc+TZd3fJOMHMD4q+ISROpqOpkU0i7nDs5nIbo8bkdYrGgKeZQ2RFLUE7VYNna
         /QSPZkTFbpdfzRaX9Buycs1g1UJd/5XmKtu8n6LcP/7kS2Qp7s2y7EABYDQJmQjiWZsA
         eNbf+NP8pIKB01jRqKhAH82fQORphX+0pvbzoiG+q2Yq6yQ1n9Cf6dlWLKhF78cYVptF
         601Y/tQa7X9NSkoOXbcKsE7YlsabWcTIlIkpYwJY5stUmm93MaYo7354fKjcCHgXVBFw
         fc1g==
X-Gm-Message-State: AOJu0YwPc4PxVEu+2AG3J8lWcmaspPfNNA3WcacmQx7xSGqY/ohyXpmp
	XbR5O61TR6iX7aEB7vzXo0M3WqAW4aqC02Ac3VjFrw4S4GPh8twlWbTxWA==
X-Gm-Gg: ASbGncvIhM/FYI0yY1z/Yo3iXFoVk9BnhNcPBs7mDocQKJvExqylcPA2N6uZ2aDZGlL
	7BN+iJuaw9ufIrefA1Q+6JNLCfcfvYZ3A9SPdDpk+9ouOqtUBx7IhhNZ87qVceg6MdZ6RY4UKsN
	AKvVoJbiAWugASM5jss1f948ogWMQ9Yh726PvJzn4Wyd5b7CA7UfB52ZbXbPYgak3h0iiDpYWoM
	7FW4p6mQzpv48qTfLSpyYJzvha7Eyy1YiWXXzENbYK2A8r8b22dWZeIB19ehQPbrNBEltCEK0Ud
	lwHk807mrEGbD7F8j8nQgWHk5CeBg82irIpUoO3Ke/91TM4cQp0j
X-Google-Smtp-Source: AGHT+IHWlgnudA2gKXfSJRsyxqNbVxw97ddrSPC0xbK4Tjt6OVmQWpeAWsuWFA6lGJP3qCZ97m0rIw==
X-Received: by 2002:a05:6000:144b:b0:390:fb37:1bd with SMTP id ffacd0b85a97d-3a074f1571fmr2158545f8f.46.1745587070979;
        Fri, 25 Apr 2025 06:17:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5e198sm2384048f8f.97.2025.04.25.06.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 06:17:50 -0700 (PDT)
Message-Id: <d9a114915a30281518d6e411ee01aefa670139ad.1745587067.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v4.git.git.1745587067.gitgitgadget@gmail.com>
References: <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
	<pull.1897.v4.git.git.1745587067.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 13:17:47 +0000
Subject: [PATCH v4 2/2] bundle-uri: add test for bundle-uri clones with tags
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
negotiation with the subsequent fetch. ok, now it's right. christ.

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
