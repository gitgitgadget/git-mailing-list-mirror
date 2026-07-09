Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E939A4D8
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615792; cv=none; b=FOi9LLhdgIijUvGTKh8usz5iNL1hJk5PInwcScGnXSKXXR9Z+dJbxPqkQDPsZrbKwIDfSayV9DaEZhRn7XF/Zu7AxrUpTxpBUPdKY/6ZDi4iyyZSIvmVoerxhH4W2cH/XJr4EJ4wpI5oCJyKT1yEXI1LrQUXF8zMfo1UmZo8bAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615792; c=relaxed/simple;
	bh=99H3vEu7B7CCoUhkBcXWt23ugv48jZcmzFhLMj455X0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Czc9IN/LsEY3EpfawNS2I3ujQIKaS2E7TJVkdMYZ9iHFv/dbbSjwImiauqOcBUQ3tiVk9RR54rmEGYoyBnLPUg2wRkPv0vW9hCW3xs56Wxycswi2VyAddzRwxn+q6LgOphFRxdXD2fnyE7JO5BAyIa2qakCtut7HTf29U6ifOxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nidnm9ne; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nidnm9ne"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so16227855ad.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615790; x=1784220590; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NCP5Brm7M8xe1GVhIS/SapJULXTF5xfvhfmXr55DpTw=;
        b=Nidnm9nehjRi3/iFPa223hqp2HNtcNno4g8/Bnu558Djo/8nxJ3c0V1H1veyOnCbBY
         +holBPssIABen7lqmC7upbH2ovosex9wyzUcyYMqw3qYvAMBLFls11VLN++KwCGBOT3m
         olreQnV3/Ike5UBxyii2ziolpMuZAECELBRFVxntFCHhqsNC82A2s0ErpsoL+taLQ2EL
         mXIODJBIkBn2zgBLlq8RexeB4fJeS9Lo+bbltgyTmTyQ0fvHMnFBYf5IqhScuchbtNyJ
         QI34h1kf82j9TDuEP+0O2Bo8mZILvlCGtPNsFP82Jy6cvl+WKkWCi9l9OmK38Ozd1t8/
         kipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615790; x=1784220590;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NCP5Brm7M8xe1GVhIS/SapJULXTF5xfvhfmXr55DpTw=;
        b=H68JUqpSt7/pVuXNLp/irAAL3uUq6ee0qsAPyE7tKKc0DQIJOAOpDIyCPaUN++5R0m
         RrmnUf6o7krUObwuPGMyYv+rMzX66lICYYd7jfO2wgPk8Eyx6c237G6eDfsSmjbPIMHE
         gdejsL2Qn8FZK9lRjE9399kvtiMsM/sdfrwu8Zdv7Q65X9X/yZgXs/ecomiZD1UauRN+
         aRDmOQGqnviykGZTohk7h0YgR0qWacvFuteIwUUsIm8Q6GY3CgX6d4uD7+lcHq3RST1J
         wlc8j1b91FVCDgl9kwd0U2nUxbGit7eFQswQZS8TBOn/zyw86vVqlV9EESj2448JxsbA
         wZ4g==
X-Gm-Message-State: AOJu0YzCQjsCcP5wrTUrFFQPZgbFKGMY2UqA5wA2jCeF4ELshLeGLz7T
	rW5D+1VjK22o+VWABU+qajv8cdV5DEQVASOzw6MWCCn8qVG/6RYGdYjmZ5cr7Q==
X-Gm-Gg: AfdE7cnWa/sZdyXqcatCFoas/6ZBO+z6yUikH1203WXXM4PUVApKdMgs3MqSWpU55Br
	QcLkZlvuhvv+SbCcKZH0eHKqQguMhgrJikTaggkqRDaQlE3jJGg/CsG9wcXLFVsg0dOtF0X6Y84
	nOyuU7Sme2L0Sllj8cgMkx3YnwDdKrKvi92wP06ADvOtWh4RPc7VNZ2TcHOCKY825cN9dlIzsky
	1eCmkjjuTmrfl75di2r7N1FnK2wEEKg6rLJ8r8QIrZ+g0LEbbW7Fm4+vsvW/bKZutRkE4CC8sdN
	aoMTJ8RZlJX5/1qCCuVIxfz9WQUUNipVNhoHg/ifI/upyMaDbHMN7facXTtlMp45p2eSicZiPKj
	zgkhRERE2CKC8CbVvIxxVEpHVHd2k4A5l7QG0qqlTPRIHcXb6NpSg6xPZsIxUN4P7qmMbuYlkF/
	5XdLzaWJcQpmlrDmQ=
X-Received: by 2002:a05:6a21:a8e:b0:3bf:9e85:b423 with SMTP id adf61e73a8af0-3c0f0bf4341mr30014637.34.1783615789909;
        Thu, 09 Jul 2026 09:49:49 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6596681fsm38361456c88.8.2026.07.09.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:49:49 -0700 (PDT)
Message-Id: <7dca16010249768558efc21f522fba8240aeb2f3.1783615780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:32 +0000
Subject: [PATCH 05/12] pack-objects: widen `mem_usage` and `try_delta()`'s
 out-param to `size_t`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The pair must move together because `find_deltas()` passes `&mem_usage`
to `try_delta()`: widening either alone breaks the type match.

`mem_usage` accumulates per-object byte counts already computed in
`size_t` (`SIZE()` and `sizeof_delta_index()` reach here through
`free_unpacked()`, now `size_t`), and was the last 32-bit-on-Windows
narrowing point in the delta-window memory accounting chain. With this
commit, that chain uses `size_t` consistently except for
`sizeof_delta_index()`'s still-narrow return, whose value is bounded by
`create_delta_index()`'s entries cap.

`window_memory_limit` (config-driven via `git_config_ulong()`) stays
`unsigned long`: it is only compared against `mem_usage` and promotes.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4737a6a32c..63ceeb736f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2804,7 +2804,7 @@ size_t oe_get_size_slow(struct packing_data *pack,
 }
 
 static int try_delta(struct unpacked *trg, struct unpacked *src,
-		     unsigned max_depth, unsigned long *mem_usage)
+		     unsigned max_depth, size_t *mem_usage)
 {
 	struct object_entry *trg_entry = trg->entry;
 	struct object_entry *src_entry = src->entry;
@@ -2991,7 +2991,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 {
 	uint32_t i, idx = 0, count = 0;
 	struct unpacked *array;
-	unsigned long mem_usage = 0;
+	size_t mem_usage = 0;
 
 	CALLOC_ARRAY(array, window);
 
-- 
gitgitgadget

