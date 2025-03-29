Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ED017A2E8
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743249821; cv=none; b=DkoJwLZxzWz0ZgyD9MzuIelNGM7jkpMJehBQdKxbb+I7wG/AWNpP7XjWQW1R5XxXSljPGlM/7EbKwcE28GCInhTG1Ja4Pmvt+wpYe49U82hR920uJA4OqAc6h0IBOkCbJWU9gle0xi2aK5OeIZhmJuSLUHrAUYHqpKR42Kpz1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743249821; c=relaxed/simple;
	bh=tjQC3G48Fvsxrz/NxzgjMnjUCEdZm7hjqUUJ786PQHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7+eBxftDUPdHYYNbjHdgV1J55pzsPEzZchHCujE5uKmqhBbTPXz7WGSBGRKPVgeP2vUGwFtmpNYY9WENyeyY9jGxjwwsEsysNmINF7HIalmDbxT/SS0cId3gzPhrwW0X4tvJ+ozFXmwDG6jMBTK777tNNawCfR/IlVve9ES8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdS5hxEc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdS5hxEc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224191d92e4so60061415ad.3
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743249817; x=1743854617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCsrW1RQYfq+IYCN7f/a1CcvK3QMWKfk+L+allyfybw=;
        b=NdS5hxEcRUZ0e2mRcBV3+FPBRYJk2IZCjQVeiTkDPYlisQypIQ0oJKMf0SIMO5n5Xa
         oTTE2VPfmZnpV8iziGPFT9IAhk6zDZAUaa9pFLQerBLy6gH1+M9a3TmdqxS9HZDOatvo
         iajo73d+hENocHC7FHUM2UJbRIYGzCx4+94aL7XhWLNqByyLPBzqSBeVl3HaRPUCRD+I
         eJuXTUxSLJpTUNk6Lwz/WUwH3I/fICG/BQ4zNlSUcnWA5m29IPvqIu6TwlGWNIq6BqBx
         Baon8QhSLJQi3dOd9qAh6vauhalN4WDwPOKIMwV2m1TT2vgSWW5KPN2roZwqVU3ybcU0
         Tibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743249817; x=1743854617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCsrW1RQYfq+IYCN7f/a1CcvK3QMWKfk+L+allyfybw=;
        b=Z2UDcpnJmL4xO+cifaJVGRjOiLH2JNSYXG2lDjMjoWv6e8n+LIfmXAwnrGm8MzLNIH
         7gTYIexqyfVJvygmpZAuYDjP8v+bfAhK3MATXfsns7uVcEJy+g0GYhYNOF7qoiCzMJYE
         ziCxLrbZ3WS3hG7POFQcyczKAexPnsWB4hvf4ZSDpR8TkRUeBQfRPMX0S1YbTbOh9hEd
         pvqcihWFlRkYE6E7vsxhPHbqR34ptbv/7sTWk6OnL0KkxuxervtGZ2AO4zE9ptI8iRgL
         SEmCfPxEydfOAd9RT5MwkKmpkAHBR9R2W5r+8sEGtKF7G1llFTs6qBZuV9x7JE7OTS2t
         XQHA==
X-Gm-Message-State: AOJu0Yx+2xLoPNX4iLnyHQ3dJa1i9qVecOz1TjhmWiMhcqESnenLu1uZ
	K3yP1VkX7zooTJUSkMehlvmotPbG6Jw9hXAzckaYFoHQi3lyn3bPdtTKJw==
X-Gm-Gg: ASbGncthMIynH/nznPe4p+2z9EyyiMogYwoqiQFUVLKPT34tUTstxIzgRZTi5zpyuGV
	KXZBYAshJnLg9MKkHTeY8FiPXlaTthw8CueebeBZMOk3UPN9sr1tAZQNhEIBB5yTwwcqatKUfc1
	QzYMhgqsOM6hHnFZpVZlHY92Do5Q9ySmBhTV+Ko5W/3bacqKSm9/6NTA0eLxTSZMqKdhr3ZZ1ef
	BmvctOQBA73EUm3A7VqmVK55cBFbp10QeEXXZXehe0CNJe79pu/3ReAk2YAVLKWLX1BcLi0BUKI
	02JCSC8P/XbwETijczoPWdQ804wJa46HncDZ27arNAvAeDzRgN8m9oigPC63OMmgGWHJHw==
X-Google-Smtp-Source: AGHT+IGgnjyimjIQXyYxztD62draeV+eQNZdJl0/1mbGVDQQNgfuZNxfv6GXEMvPG8jHHJLbuU7K/Q==
X-Received: by 2002:a05:6a00:1251:b0:736:34a2:8a20 with SMTP id d2e1a72fcca58-739804356e6mr4004959b3a.21.1743249816968;
        Sat, 29 Mar 2025 05:03:36 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e290f8sm3560745b3a.59.2025.03.29.05.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 05:03:36 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	philip@example.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/1] builtin/update-server-info: remove unnecessary if statement
Date: Sat, 29 Mar 2025 17:29:25 +0530
Message-ID: <20250329120327.105925-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250329120327.105925-1-usmanakinyemi202@gmail.com>
References: <20250329120327.105925-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we already teach the `repo_config()` to allow `repo`
to be NULL, no need to check if `repo` is NULL before calling
`repo_config()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/update-server-info.c | 4 ++--
 t/t1517-outside-repo.sh      | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index d7467290a8..ba702d30ef 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -20,8 +20,8 @@ int cmd_update_server_info(int argc,
 		OPT_END()
 	};
 
-	if (repo)
-		repo_config(repo, git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, options,
 			     update_server_info_usage, 0);
 	if (argc > 0)
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index dbd8cd6906..6824581317 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -107,4 +107,11 @@ test_expect_success LIBCURL 'remote-http outside repository' '
 	test_grep "^error: remote-curl" actual
 '
 
+test_expect_success 'update-server-info does not crash with -h' '
+	test_expect_code 129 git update-server-info -h >usage &&
+	test_grep "[Uu]sage: git update-server-info " usage &&
+	test_expect_code 129 nongit git update-server-info -h >usage &&
+	test_grep "[Uu]sage: git update-server-info " usage
+'
+
 test_done
-- 
2.49.0

