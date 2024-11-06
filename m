Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A614F9D9
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926091; cv=none; b=pp7g7c8cU2G0PH+0HUxGwv5Y1g/MSX4A2W/Pq4pSSOCqcpiEb/wD7E4/lpgo463T2nl7vt6JEB4z1mS3eCOozPvuUuPYbC8XZouWyuI3Wr8yoFk4G4gHce5j6bxnY0sHh/jv8sieY7nABbHWVLqmTExtFUj/DYwwlKjW0kk9PKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926091; c=relaxed/simple;
	bh=4jDb0W+2SjMB6u3WzqsIGgP9PT76hFxNOTyOBwBFlmA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=touj/WXprmBTBy9KjnlMqUfDPozEpNKRxUcveM4RNQr+IM76Q5Ek83Zf20PPXIE+BFdYq+zF0c7NgQIDTQ9JemIBwZXkWhFFtIM7XmZPLOtR6nXeK8KKw0578+1MELp/4R/SpTznLxOeXhgU5BoIyuXWbrDeEfPR2+VoAiEIaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJVsaP/i; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJVsaP/i"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so2378845e9.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 12:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730926088; x=1731530888; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MOJFAA9TwuDGMvfWbW8ZKALc6xQouBTYEXlynXiJX4=;
        b=cJVsaP/ilIGYptLvWWH7d0GFOYLcWBM+5IynKse9gN95rqALxrBTnFA6AX+W9QYiZd
         E6KM9HEbOcyPf6B9f8mlhf9cRFBay8sEE+a6fxSKj3fWU4gjH4398p7xlO2zElVrm4ts
         WBBSAk514Iy4kwZ4iugq8ymrzAKQ8rXyarrfB8EZVXgruDg7f4NpT8eCfTWx4i8P5wdr
         2pgB0CMgnItXY/6HRs0R9adAj5gyBAXM9TZoyV+MVdmIEN4afwpS2i+qamP6V21vnJzm
         GhDrpWQI8lD6e/NoLDgiH+8ncsHlUcHu1u9nBxvkzPhiV8EYAE7FYV1iPHJ+XJYDOpeO
         gR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730926088; x=1731530888;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MOJFAA9TwuDGMvfWbW8ZKALc6xQouBTYEXlynXiJX4=;
        b=T9cUmXuEHc14+WpMRA04Eu0BavU+5DbKwANM4e1KmOQQ5Px5Le9G5VRrNQRH8sbXOE
         cWY7kcgUXIJgVSux9dybE9dx/FGp5s3n8vzobSF0GzS0kgYXkMoSBRzr9kIonlXDKEXd
         Uv4DtwgGRGLIvpK12sXB53a2R1uX8TMOB/2emM8ZP7AXfgFRsV+VTfqmKrsqocHHVSGY
         jv+ZgmMKaUR7ogvIQhbHUhab6Llu73AvhBsY54ccVjwQhJA1bWj/3DXFYGZ0rBax+A4N
         TIaT0hR9tFc+i5/w4pZz2potgTkkZULBjUnU59LOyALw+eJQbk0B2WZJmtoLGFvPrsNL
         G4DA==
X-Gm-Message-State: AOJu0YwgfyYW3YdaizcJunsGjCNxzcorKZa92SikBzseMlEmYNHhVwXQ
	q3HAI6oRhymTRofKzlKtYIuTRizVqQU8uUgb8WtKMrt1JnflNmImpzHuiA==
X-Google-Smtp-Source: AGHT+IEHjgCatWWXrQttZFZtFdj/pNcLlVjk9sG/a+gR0FnK0y77+S0cEEn9x2RmUipGz2bv/fHxjA==
X-Received: by 2002:a05:600c:3ca8:b0:431:52b7:a499 with SMTP id 5b1f17b1804b1-4327b7019ddmr202704125e9.20.1730926088011;
        Wed, 06 Nov 2024 12:48:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4d1fsm20008396f8f.38.2024.11.06.12.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 12:48:06 -0800 (PST)
Message-Id: <749ba7f52086f2b444a9e073c431d7d4f4c7204e.1730926082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
References: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Nov 2024 20:48:02 +0000
Subject: [PATCH 3/3] repository: BUG when is_bare_cfg is not initialized
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <jcai@gitlab.com>

From: John Cai <jcai@gitlab.com>

The is_bare_cfg member of the repository struct should be properly
initiated when setting up a repository. BUG when repo_is_bare() sees
that the flag has not been set.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 repository.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/repository.c b/repository.c
index 96608058b61..cd1d59ea1b9 100644
--- a/repository.c
+++ b/repository.c
@@ -464,5 +464,7 @@ int repo_hold_locked_index(struct repository *repo,
 int repo_is_bare(struct repository *repo)
 {
 	/* if core.bare is not 'false', let's see if there is a work tree */
+	if (repo->is_bare_cfg < 0 )
+		BUG("is_bare_cfg unspecified");
 	return repo->is_bare_cfg && !repo_get_work_tree(repo);
 }
-- 
gitgitgadget
