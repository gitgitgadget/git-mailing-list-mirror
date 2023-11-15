Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C612FC5E
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWcIOmsi"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B955187
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4079ed65582so53328585e9.1
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058836; x=1700663636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlX1vPNSw+hqdLdu0xZ2UW5XuEXNe6kchLDblMoMQbo=;
        b=HWcIOmsijaI8cPKkq3HC1kIidK4zg9Ela6V8Dsv97/nJq06Y0SoG1n9zbZB4B2NszM
         q57FS4KmpiS3/MjeLOOt+JGBsSGerJVhxFsZN0D/V5U8mUd/hgZ1kqqfyJZ9dB7aF7tz
         QFTMgNPtlCfI4QB9iXDi7TnnRUBRLCwS73C4nsKDB9jDDf78XgHNIZkyfzQkA9F/jWs5
         SKe/oci1xLlxXELhJtJvZTzLJvFVz22QlnJSuPTKIPDNqEtnx/CIX2j+mkTOCbBdteHt
         RBc8NT8d2HtGWPr0pD56+h4xVKI0jx/Trv89tTiaD+jiFilsM+vfipznmC43k5o/7grD
         rQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058836; x=1700663636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlX1vPNSw+hqdLdu0xZ2UW5XuEXNe6kchLDblMoMQbo=;
        b=FvayyGPCncMeoE5e3RL2ZXQTE0iFDGNeX4B6rTx946rzCvbxaxMF2epc7GKYHIqcGb
         46ZKmIjEkhjh2XDlZkvBo8ivoxE8eIt1ImjbGea9+iEpWRLg+wlM5DxZN8p+d5iCxwUD
         dzE42r9tpQOqQMHAIqiSYNdPMSpThZsuYdsAeneh20VRQkk5zs3OfgCT3NnNOpso9FyV
         C+8o4bOlLJoY+vjXoj4SxIH+43tF0X88zxTfCADWwZVB1JnPMXsojGJiuc6M1PRMzA0q
         mLz2n9HHUnuwWawzvXhhwCsxh2dQWr5q9s39Yhk4aXGJ0RVd8B7cgeqlYYi14OVn0jN6
         RC/A==
X-Gm-Message-State: AOJu0YxK13ufDAeO12bByNvPofumXJr7r5ysxx0ysjh704mGRKm+K58R
	dSeR02ORbyujMaNqQA2AmsphQI1TwhI=
X-Google-Smtp-Source: AGHT+IENChSEZFc89sn+HyZxk8pYPT+SOeY10fxq2UMDwSzlj4qOsZHYMjjiYw+mujyG4E3s7SHOfA==
X-Received: by 2002:a05:600c:310e:b0:408:80bb:ae8d with SMTP id g14-20020a05600c310e00b0040880bbae8dmr10636916wmo.32.1700058835732;
        Wed, 15 Nov 2023 06:33:55 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:33:54 -0800 (PST)
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
Subject: [PATCH v7 07/14] replay: add an important FIXME comment about gpg signing
Date: Wed, 15 Nov 2023 15:33:20 +0100
Message-ID: <20231115143327.2441397-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.15.g29556bcc86
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
References: <20231102135151.843758-1-christian.couder@gmail.com>
 <20231115143327.2441397-1-christian.couder@gmail.com>
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
index 8302d35eca..2e1df83027 100644
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
2.43.0.rc1.15.g29556bcc86

