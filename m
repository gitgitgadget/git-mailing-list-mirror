Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2802621B19D
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607971; cv=none; b=LH3Acwdt4lKT6tWmnGeQtR7AzNxyMmlTsqxgW1OwM2jPxbw7DfYbP9/wBfCs6KlaX2J8OrWlpWP996yrgqlxH9aiHcl/QcP5VHCOQgjp5+HFsuI9BB8ptHrI1FFqAKhdjrSvm+ddYIAPlfnsxZWZJ5P8P4XMUzHjyh50u/TLShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607971; c=relaxed/simple;
	bh=rKspNOZGOF6mzjS6qp/ub6nCoTopmkghzR6IP3p6I4I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bKyKJEueRiPszGtZEdxIhnApnyOxwRRZ/QLaqBm+/FzsdtZ+RHZXZ6wS5wTYOsJWDo1k1qmGEtQovIy6/eJwpURTImeRZ22oLpf1hUbiW7yyP2Hlz2sh7TmHTlPVO57ml9XX9xS+ukvnakCvNwDDgZwm5+XzbWEK7V9IWkpTstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQW+surx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQW+surx"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1efc4577so1501904f8f.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745607968; x=1746212768; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w9gi8XtIeR1ASKoTPMrWsnh8ZDiItl92o1ibqPDMog=;
        b=EQW+surxNPx15OMwGCDhnaXdHCiAGAytIV1Z0wWyXbDXFpXQDosIIdCeW3O0ctlyVC
         iGBRNTkKLck2eRlkifc75W1w6kpB2aAd+NGjtHq7DXTnkU0jwP4XDW8ydB3+4rl2YGXW
         4lztV5wC3cB4uvWpEzqpkdWIJ8iNvokHwqgrqZ7FawtQld+TJeyOOjKM5a95aQlnWFsj
         xlavV+DQ6/lhAse7kvnQPIC116MuJDKrRt8mpOuloTX419Sai2KMBkTixMPsC+9najeA
         SSyltTdjgAekm5jnHNtvoZqaoMXbHS8b638SLvfyym7lpvTuFxQDCKA+JWUQVr67lVhz
         LdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745607968; x=1746212768;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3w9gi8XtIeR1ASKoTPMrWsnh8ZDiItl92o1ibqPDMog=;
        b=jGYjI4QbcFkJAZsMydZgahhQjbJFp8HsdmIcGb0zngN+7FSnz5k8cJxpifR6PuJzDd
         k6lhnrGcF5jx9fZbLzShtC0GLMd2bEJfh3WRcroe5/o3vim2aZA78gMI5KKZb9RtTfcS
         axHfZKfWA1/Akl3pzpVs9rv8CApXV24sKYX4ZGlORD5UDE9Dff7nAabS6ph5T+i7qwP/
         5/GrgYdWpnjrH4RyyMjbjwCpN7SN71OSGkBqcFFV4hVqcbqScXw0DmC8/3Y+EAmiiM48
         ciqz+yLxVGZzFrVQ9ULt2hHpGgXV6TJQUmj63qL9IiYR8dfDTe46jsZU07g1km20eNzS
         8A/w==
X-Gm-Message-State: AOJu0Ywl27tKU6W+Q42m2O19pziaptgI1ItGqS8yOWRgWBVtmBMr0GO/
	pJtHF4V77weTcdgA2A07G7wXq73LCMvSEeDI7br+etR/d2p919n74ctSqg==
X-Gm-Gg: ASbGnctS5+AQomjGWi8aYNYFYPIk7FMwJmob4RSZQIgy7aic/6YrWL7MafEAUA6qycn
	Np+/PZqj1Y/MFcgsIPhD/a9kC7ZYTzZo8H7JHnaCyi1J7d/OYMEfKSSuJkSEz3TD0iIh1S36GsT
	mvdSkT7PsAjCbDK3BmIdqWgBD0t87g7VMIDiSm7a/r3C5d0a/7r78wInH0Whnyw1EzQs/k2uaBd
	Mo55w/intAeu6TisyCZOmy9M+urzexJ28sN//Bo3nzXo4F2Co3pC5BburvXaPIR2QGygrUv3JVl
	pmA8ur2fIfOGJYEgNX+KAXE3hgj8idbODbF8O5Gtxg==
X-Google-Smtp-Source: AGHT+IFVuMsi3rS5AsbPbi17HQ8gukdABvQPUbLpylNlgiHQxfCRB/tLXoHb200vmqvydpWLPTMfZQ==
X-Received: by 2002:a5d:59a7:0:b0:39f:efb:c2f6 with SMTP id ffacd0b85a97d-3a074e3e6a8mr3463339f8f.33.1745607967933;
        Fri, 25 Apr 2025 12:06:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2ad112sm65107145e9.24.2025.04.25.12.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:06:07 -0700 (PDT)
Message-Id: <ec5d629f32befd4243e3a6a112cb818f211f147c.1745607965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v5.git.git.1745607965.gitgitgadget@gmail.com>
References: <pull.1897.v4.git.git.1745587067.gitgitgadget@gmail.com>
	<pull.1897.v5.git.git.1745607965.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 19:06:05 +0000
Subject: [PATCH v5 2/2] bundle-uri: add test for bundle-uri clones with tags
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
