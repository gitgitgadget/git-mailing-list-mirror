Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnFx8tmy"
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4CCD67
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:13 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c8769edd9fso23708941fa.0
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824271; x=1701429071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIMR9n8WB+umJgli/mZV9bKVyOPlbUX2cG72GsmpZ3E=;
        b=XnFx8tmypXnkcS4BYFlJ8aaHrN6E1GoSAdpfhxOV/N/dOPrH9g4K3qLwROc411VnGF
         68dezxbJHduMcI8xGlwv9Tj+HGcG60/DAuxax/YJFX8Jwvl/VuQW4nJLaNtrOC1cAceT
         vK4ZAR6H44PMUn0zvqkgRTegT9Wa/oOFZmoaYw6TrwIZ9F7cR32L/UiJYMO+HbeKMuYv
         z/xwDAa++XNv4IChIrYz4s3N4TenqvakGESzlfRTH7ZGGpyoIYOcxiVT/fW9vi9U7BBR
         QOxoyfR3gyFUqczbWOy1veLF9QlRbtvMcZw5rrDuBg5EY49JnkNhor38o8bIGMAHTx6r
         S3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824271; x=1701429071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIMR9n8WB+umJgli/mZV9bKVyOPlbUX2cG72GsmpZ3E=;
        b=MsLhOnzsIlecZsKlD0RSQhoDQdrp690a9wJzVhS15CF4xke913SrcHpN6cOb/WJELu
         hXKci8ulEYhmGFfMLstfjFdURtAMJRQbiqKxlf2TWBsZ1Z0iYCE5DpZpAyt3+MOKlkDS
         ogDFUT0MH3SKD3yJ5QTQMgLZ3wnd64pKbO9MkDITo6fhpfAOOwRC+tMamkFNBlg4qvFU
         vfydHVXaMdkW69Oka/1G3kZwX/i583qi32plsLOxULTOKYziuGyA5Tzv09IP3HfOpqCO
         d4WLa9DLSjod1zcKKUA9S8ky/+0xpRqaVHpSSslALniBTDlZcVopNIbe/N9jZxJiLVa1
         qRag==
X-Gm-Message-State: AOJu0YzoWyFajfWQa2bsQzy+LM84PMmlGKH45GXFSBPRKZdpu5iNL3Ed
	vq+Hj7XhCeXXGm9ZZzUBKwNSeK1YBnc=
X-Google-Smtp-Source: AGHT+IGV2n3RRGFKLff7FNY9/3a+WlAOWiicyh2fuHUQ15/VMrAmEIL7MKsZYHwfk7qCiCVyECT8uw==
X-Received: by 2002:a2e:7c09:0:b0:2c8:323b:9207 with SMTP id x9-20020a2e7c09000000b002c8323b9207mr1617606ljc.11.1700824271374;
        Fri, 24 Nov 2023 03:11:11 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:c06d:3245:2b4d:9ec5])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm5390295wmo.39.2023.11.24.03.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:11:10 -0800 (PST)
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
Subject: [PATCH v8 07/14] replay: add an important FIXME comment about gpg signing
Date: Fri, 24 Nov 2023 12:10:36 +0100
Message-ID: <20231124111044.3426007-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.14.g93e034faee
In-Reply-To: <20231124111044.3426007-1-christian.couder@gmail.com>
References: <20231115143327.2441397-1-christian.couder@gmail.com>
 <20231124111044.3426007-1-christian.couder@gmail.com>
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
index 2f664218be..384bb4ddd3 100644
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
2.43.0.14.g93e034faee

