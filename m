Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A174D590
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm4u2XKF"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33694bf8835so3781635f8f.3
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 10:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704912752; x=1705517552; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/DAsjkrOGdxZDpa6I//Fyv9T/SkQDL1/nU1q9K3z90=;
        b=hm4u2XKFwXHmHhrySYoC1S8+m4+6J/3GT9ocCyqckBy3kOGdTt0qmOoZQsXV7oeyrN
         SSvLMFOfdK0d+lpAe3W8bMRF7qL83HQHFivbQft+zKghzkMc+enzAqkmE52E7SRuRCYk
         hWqSlbPeR8FrbybOJS9fxuZO7ozDri7uBEzfiyeHBPyMNmK/kKzRidHNqhF7NRI9s0cK
         yRrQw3UUgEIP1V1RqS8K5A4QKuLE20vfTosLypptfl3fdD+xcfuXHeJ0K3Z/pEZ9cph4
         hRbkwnfTM4hHZ/6fU37TRoqjNwwBbyLNkSZ5ny4EdYph4ftPURQu1EFCFyHavmygZRQm
         exaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912752; x=1705517552;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/DAsjkrOGdxZDpa6I//Fyv9T/SkQDL1/nU1q9K3z90=;
        b=PyGK4Co5Uvp+Er7MKo86GVqz5XXlI3pdi+kRDWSc8CDcq/8YxGlNc9VwJ+fmvR2W5G
         Vw3+XAgpdZ6oShzAEgDTiJT1Szzj/28GI+CkCDPJvSr8pMisvDnnEXpmP9bFNo2p48fz
         5H8QV+fEaxwFyXGCRZHpF+QG7cPwLeny2bQ9i7tKJKWO90vGOSGl8LT/YAH3EbjMfEwp
         zBVyGFDJSHFwM64NM7m5EWcm9x4KsA0YyZbjBj1IqgIUn8+cHsIHhU0jdZa4gczB4ZS4
         GGuCuAucjcMEzx+fTMtEzkSpUpXaeFIJWr+zqXe8Pped9gELtsTmV/E10essDUarFvwI
         lCzQ==
X-Gm-Message-State: AOJu0YzjMsyXYXxtUwUJedpbz+M6R6oi2HL9LDmkoTgtfBiCxNlc7cF5
	1fXY8sgZ/ydmhstUPuODljfduS+9hHs=
X-Google-Smtp-Source: AGHT+IGfV72tvMw5cnpnAs3FHY5lW1pqU47j9NSjU2fX7PLVrRIyKuxJjxM9tQ/WIJh9GKygfVZSuQ==
X-Received: by 2002:a5d:63c8:0:b0:336:c434:5c1c with SMTP id c8-20020a5d63c8000000b00336c4345c1cmr631474wrw.34.1704912752189;
        Wed, 10 Jan 2024 10:52:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6-20020adff446000000b003377ba25e48sm2447862wrp.66.2024.01.10.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:52:32 -0800 (PST)
Message-ID: <11fd5091d61b54d8862ab2e316bbd25fff63ce0f.1704912750.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 18:52:30 +0000
Subject: [PATCH 2/2] t5541: generalize reference locking
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

From: Justin Tobler <jltobler@gmail.com>

Some tests set up reference locks by directly creating the lockfile.
While this works for the files reference backend, reftable reference
locks operate differently and are incompatible with this approach.
Generalize reference locking by preparing a reference transaction.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 t/t5541-http-push-smart.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index df758e187df..5b94c0b066f 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -232,8 +232,29 @@ test_expect_success 'push --atomic fails on server-side errors' '
 	test_config -C "$d" http.receivepack true &&
 	up="$HTTPD_URL"/smart/atomic-branches.git &&
 
-	# break ref updates for other on the remote site
-	mkdir "$d/refs/heads/other.lock" &&
+	mkfifo in out &&
+	(git -C "$d" update-ref --stdin <in >out &) &&
+
+	exec 9>in &&
+	exec 8<out &&
+	test_when_finished "exec 9>&-" &&
+	test_when_finished "exec 8<&-" &&
+
+	echo "start" >&9 &&
+	echo "start: ok" >expected &&
+	read line <&8 &&
+	echo "$line" >actual &&
+	test_cmp expected actual &&
+
+	echo "update refs/heads/other refs/heads/other" >&9 &&
+
+	# Prepare reference transaction on `other` reference to lock it and thus
+	# break updates on the remote.
+	echo "prepare" >&9 &&
+	echo "prepare: ok" >expected &&
+	read line <&8 &&
+	echo "$line" >actual &&
+	test_cmp expected actual &&
 
 	# add the new commit to other
 	git branch -f other collateral &&
-- 
gitgitgadget
