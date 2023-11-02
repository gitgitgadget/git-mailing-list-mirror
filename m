Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3151BDEC
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhX6PzP7"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA796D7
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:52:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4079ed65582so7646775e9.1
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 06:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933141; x=1699537941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH6Y1SXE+G17M1Qk6cRDu+/qIpCKkZ+HMzX2XuyA2b8=;
        b=IhX6PzP7SWayDT204saC4SNg7j0jwh6NR0MGm0pGT0f+i5sX/2QjEJR5zv78xFA9ph
         rKFosvy/b11UucT/AdZiPj1M9iC0QBi6XJuFFSIvCijvJn2Ch1xoVbbHf+4WF0NpcmFg
         zZYSpbs3ph+JSUEYxMa5SJiDXjiSsZfrBzHQ11MSnNyVsWPw0MOShzs/+eh189GcSm4H
         kgBGbpNNwcUkw5/gyg9KMob1qVPLBGuUcBIxv4NoB2zKEcqEPDDzS6h6LZKMpmLXsEQ8
         RS8lgDhAWq41Rn7lQo29UUaLlIoexlPBjiwPgvRqZUfqOGh/tGnTpRzdgW+5wCF7u3KD
         0c7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933141; x=1699537941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YH6Y1SXE+G17M1Qk6cRDu+/qIpCKkZ+HMzX2XuyA2b8=;
        b=rvglkYmHhifXQ27dfWz/3XIIsJxl/4UZNGENS2GOQ7NJaTyeC8R/mFf6db/8rP5EJM
         ows/TIKBedwDEf2XTiOno1q9BCiEhSYgv229sXhKTsmAsd4quKY5k0+yNu5mwfl+KH5W
         NygEcvyyKl6m+v35Xmi09fD8OJhFHrpC0yicvvcHKuLmSfZWMR0w+UwhZo8Ky/tGh6+e
         lDQ4q37YodyftiUuydFkKVLNea6N4ljYL8WU8izRHrC7Cnx2Go9pgb01qvwLyvq5NCPB
         Pjwuy+ZzLX4WqQrib9kbn0jky79wTEsZbVS/GDf7aRGPwJaohsyeDb+09CYPmiSQKDfa
         oaiw==
X-Gm-Message-State: AOJu0Yxh9rS/UGdBWWhZubMR46oTRXzIKsX2xq4yLqF04CZkmUVN3U/i
	AjIvBNFO6aXg2V6LYLszkwzYAQon8ww=
X-Google-Smtp-Source: AGHT+IHBvVKX3EF4McqJPyG/G/6KxmnDNE101t0AcgNAjUVLQv4EBqiIMtCO1rTNZ8GzECAAw7sToA==
X-Received: by 2002:a05:600c:1f89:b0:409:404e:5b8c with SMTP id je9-20020a05600c1f8900b00409404e5b8cmr10793338wmb.17.1698933141192;
        Thu, 02 Nov 2023 06:52:21 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:116d:4e46:313c:1f52:4963:91b6])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b0030647449730sm2514996wrs.74.2023.11.02.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:52:20 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 07/14] replay: add an important FIXME comment about gpg signing
Date: Thu,  2 Nov 2023 14:51:44 +0100
Message-ID: <20231102135151.843758-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.496.g529a7fda40
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

We want to be able to handle signed commits in some way in the future,
but we are not ready to do it now. So for the time being let's just add
a FIXME comment to remind us about it.

These are different ways we could handle them:

  - in case of a cli user and if there was an interactive mode, we could
    perhaps ask if the user wants to sign again
  - we could add an option to just fail if there are signed commits

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index a0d27ab249..544a546674 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -62,7 +62,7 @@ static struct commit *create_commit(struct tree *tree,
 	struct object *obj;
 	struct commit_list *parents = NULL;
 	char *author;
-	char *sign_commit = NULL;
+	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
-- 
2.42.0.496.g529a7fda40

