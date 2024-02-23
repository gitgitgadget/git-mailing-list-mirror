Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534B3C486
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677276; cv=none; b=ERaqF+WUE1cS5JhJ9juw/U6KizECeX+7xJurNNX63ESHN2dYpDpqNlRrogA1ft0Yr/QvqKWyH2BdnNDhz41pcVpyy1quddtpXo7ZJpCdf0/pA8SKJzzI9i5K2xAUtQhpM2tQkfb29KsvygoUW2YAkr5E+wdDLDFCmGxVquPpB9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677276; c=relaxed/simple;
	bh=YCozWNngAqYBh7zCCfQZBsTj1IMTwlQDNRn1AjIZyko=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NGBszkT9SGH29j8+uwQzYFv591po44UUGPO/2tgrNvqmADlHOti2nK8pptjTNLmzpSywJVFrenQM+cj+gDxbYBmN/+4JIwkTUyOMozAhLKSAr4P9ujUNbku2xnnp5lIpdBGnRpKOyLPU75y2IB23gBeU90HhLO3JApoxfseII6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnu1w1Zh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnu1w1Zh"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4125e435b38so553435e9.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 00:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708677273; x=1709282073; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0HM0YAvmR9I93PgyzmMqXUffXelA78jHKCiUec6Ybg=;
        b=nnu1w1ZhaZ8JMMPR67sWvos+JiO73NPGCp49smQBY7EKd0K2X84fOS4Gnn+xei3hhd
         G/xxE3zR4YRYU1J4bWovGCKumDq7BARsVJJOv7WqJEhfQBMG31fvX5hfW5lO+wU+2GeK
         X20U9ikuDznlCpbVTlvREGA4KvH087VYdVRN+ASSy3ej4T5VNjxsvXZWzqW8j6bbOOyp
         vfBMRtzlKVvyGcLD/pSuhJlEvUADrtySbsx0wsMQ/jQRX1/F+zsXqROyEV7XSDCtcZ4J
         imWBMf/Pu2p594IF1daaTtLDjNOkHaPXoTy73aeINRCCrW8NrQcJXSiLLbtng28F169e
         KPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708677273; x=1709282073;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0HM0YAvmR9I93PgyzmMqXUffXelA78jHKCiUec6Ybg=;
        b=aHkyUdoUMAwp8yWGR2UmTCC/VkZ22o6i5ufxQbhZOjyfoc40wEpaOJJWCISpw70lEI
         2Y1q+Si7ifbMr038eSn7srvtO2OBhuqZLPFvgKH026n65zNUu1P7u1w3vRYjzcqYzsrq
         OixUpWD++RR/IWJT14PIDrM99UT0XFMqXCA/7qWVDdA27wOZES6gwQaNwk+DT6IW5x/f
         fwrLkoAVarckXM+kwtmRZwAgYHRBtH+J1bOogZ9HqX8yUxxRGTllUS3dO2AiEEXk1Lpu
         srvPtiGtKvSqzQ5Va5nznoiquftIJFeCw7LkOQjFDkvcTqIH5mkZWMg/rdBgvoicJtt2
         CRSA==
X-Gm-Message-State: AOJu0YxQcWdKXGalkoJGhjavwnMdL2HEBhwmroviwnTpc0JudmySs08+
	+XZ1LjuG+dYjYJ1EmN3zeJf+enMLPOvkdxTtHybolN8TIye70Y4UXror0SO7
X-Google-Smtp-Source: AGHT+IGLEQlnUeQKt8e9+xhmF6GNUGnexQT3wL0nGcNeOkqOVPMgrHlTXJpA1vFzO5CEsN0koFFD3Q==
X-Received: by 2002:adf:ed90:0:b0:33d:19fc:c4e9 with SMTP id c16-20020adfed90000000b0033d19fcc4e9mr794885wro.50.1708677272776;
        Fri, 23 Feb 2024 00:34:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6-20020adfee06000000b0033ce727e728sm1889796wrn.94.2024.02.23.00.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:34:31 -0800 (PST)
Message-ID: <ee2fcee5a10f5977df95656188ae2cc8052e818b.1708677266.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
References: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 08:34:25 +0000
Subject: [PATCH v4 6/6] fill_tree_descriptor(): mark error message for
 translation
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There is an error message in that function to report a missing tree; In
contrast to three other, similar error messages, it is not marked for
translation yet.

Mark it for translation, and while at it, make the error message
consistent with the others by enclosing the SHA in parentheses.

This requires a change to t6030 which expects the previous format of the
commit message. Theoretically, this could present problems with existing
scripts that use `git bisect` and parse its output (because Git does not
provide other means for callers to discern between error conditions).
However, this is unlikely to matter in practice because the most common
course of action to deal with fatal corruptions is to report the error
message to the user and exit, rather than trying to do something with
the reported SHA of the missing tree.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6030-bisect-porcelain.sh | 2 +-
 tree-walk.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 2a5b7d8379c..58f3d9c675e 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -872,7 +872,7 @@ test_expect_success 'broken branch creation' '
 
 echo "" > expected.ok
 cat > expected.missing-tree.default <<EOF
-fatal: unable to read tree $deleted
+fatal: unable to read tree ($deleted)
 EOF
 
 test_expect_success 'bisect fails if tree is broken on start commit' '
diff --git a/tree-walk.c b/tree-walk.c
index b517792ba23..690fa6569bd 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -100,7 +100,7 @@ void *fill_tree_descriptor(struct repository *r,
 	if (oid) {
 		buf = read_object_with_reference(r, oid, OBJ_TREE, &size, NULL);
 		if (!buf)
-			die("unable to read tree %s", oid_to_hex(oid));
+			die(_("unable to read tree (%s)"), oid_to_hex(oid));
 	}
 	init_tree_desc(desc, buf, size);
 	return buf;
-- 
gitgitgadget
