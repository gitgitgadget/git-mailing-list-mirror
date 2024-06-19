Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910305588E
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766030; cv=none; b=LYCE1L2RP6kr6vLpysKHpak3xeLkfxoBvYDgU5f9fnsOOruNlarQ6b5+wzvRh8t3pQ7ELbb+kLxubMnbVFVDJHRmnezvwjoj6XoVV6vz310q0NdwyGfFkrFHG9+J+Sn+xDZQRX/LT/Tzy9MOwUY3KlGg+jDQ4KaxT13pvgXwNOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766030; c=relaxed/simple;
	bh=p7Gvro1XqzmZgn9Bjfch/A148Q74+QR1RPehkXZCtxw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LGA/9fF1PtptKl3SUJEW/FDKFKeh4xoVZHoBmv3teorhrI8yWWWoJKNYB1+7nROUeJURMV/ZmmjkqdDofABpIzdYpglsQjfMYIVQ4ovIxbp9zQdkHVFCygDWcbkjNj7L9EwGz0GMmS4W/xwhSvSPYx5nW2knoRw5S7ejg0ow7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bp0IA/iw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp0IA/iw"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35dc1d8867eso4843744f8f.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 20:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766026; x=1719370826; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5F4rVzGsIYAg6aARuElb2+3B4u4GLFXVeckrXtpT2k=;
        b=bp0IA/iw+09BSjKqbfIcqxHbo7boxoorEdTaBNQozLHByZXp/z2yblfZykHA8UlrxC
         My/9cdIcbz7RQXmcnjjNxM1NoKd8YzdnivzTIOA1pCrGyOJw22Rn7iqC+F4ijAmWdfwp
         MVh+VkVsUZnp+c8gZ06NFSUIKwPQGo9Wqgck+Fd00GTG9VtrQDus9yRyjHPGZDKdmYlX
         uxPUQY6HNrwvCS6BeyBNUKs56/zCR+pnA3tc3zL/yYK/jLyRhBVxlC7qZa8lX6e5UdWT
         Ua8q58nrH2xgM1YfeU+dSAGjx8rFnfgB+krUn8pmGLQQDHh1OI733FyRESpiYoQnJvGW
         +wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766026; x=1719370826;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5F4rVzGsIYAg6aARuElb2+3B4u4GLFXVeckrXtpT2k=;
        b=J/RUuKSDJx7Y6nhXkXfwTeorlGuC4XXoJJEPBD0Vi636AMfYn9KPLW2fAwcm+3fbUC
         gexNse3J+Dea1u7VvIt2/Ap8LUsaEbx2Pv7FPaH/rXlqXNQAWhillzonh+XuXFfNLWQW
         5+MBG5SfG+cQageuiSPe+20+MCAeFZRSlDn3dHOxN5LVItMc0zpprF9Fu44RF/fun64B
         B65kar0aUgx8LWJ9GMgcUqpT6MUfu//a6xnVe6v5408OFzVrW6De2/T0W8Gb4qwbyj0u
         RvTNdNceDMab9xk8ktyWysAy4Jwo7VCJhuSuKT6mprwxGDL9LuWigIsUzAUHh2+Iff1E
         sf6g==
X-Gm-Message-State: AOJu0YzNe1eu/7LTEYMyFgEWzfpwkn3EWHMwV3YRTDME632r/bKRSOtw
	6o4KqUTDpX0lPtCdB8IGZz79ouUBoSwVxban+v59kRdPtihaCfR0Pf4xQA==
X-Google-Smtp-Source: AGHT+IGPoKb8jRS39vYewgeKJiHIicI/uHbPwbgRzyQT2t8LjymtMOZgPLJCl0fkNz278/FsTEI6Sg==
X-Received: by 2002:a5d:51ce:0:b0:362:f853:603c with SMTP id ffacd0b85a97d-36317c77507mr821350f8f.32.1718766026627;
        Tue, 18 Jun 2024 20:00:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad216sm15760063f8f.57.2024.06.18.20.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:00:25 -0700 (PDT)
Message-Id: <2813a15b48b70ead7e3fd062d1b49baee665fc9d.1718766019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
	<pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 03:00:16 +0000
Subject: [PATCH v2 4/7] merge-ort: clearer propagation of failure-to-function
 from merge_submodule
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The 'clean' member variable is somewhat of a tri-state (1 = clean, 0 =
conflicted, -1 = failure-to-determine), but we often like to think of
it as binary (ignoring the possibility of a negative value) and use
constructs like '!clean' to reflect this.  However, these constructs
can make codepaths more difficult to understand, unless we handle the
negative case early and return pre-emptively; do that in
handle_content_merge() to make the code a bit easier to read.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index be0f5bc3838..d187c966c6a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2193,6 +2193,8 @@ static int handle_content_merge(struct merge_options *opt,
 		clean = merge_submodule(opt, pathnames[0],
 					two_way ? null_oid() : &o->oid,
 					&a->oid, &b->oid, &result->oid);
+		if (clean < 0)
+			return -1;
 		if (opt->priv->call_depth && two_way && !clean) {
 			result->mode = o->mode;
 			oidcpy(&result->oid, &o->oid);
-- 
gitgitgadget

