Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D83B5820
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382602; cv=none; b=YcOLk8JlKmCbwKO38GyNAeOyv/zx1mMfjiFmaqDrOJAec6njTld1gQXfp+tV1cYJlCjlNcdpETBbiDzXNPnR/BYEjSolvmbf0QcE4ba60gpe707r2jcHZj0G/nV9HWNILCTM5bcc+6fMHdyeH86H4qJ3B/r0qXKFWBWpCwgDhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382602; c=relaxed/simple;
	bh=XDTc/xfFtrcwAXKAoFN9SZhA918fsCHfbWKW4V4mHXw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ffmRBHM/9TDUk4zlnfa0qRp3RZ4XqcpxkkF5Wqsel6juNKyu1pQHLbcIUVZawAd0SBHKBTeLDX2KkmvqG2LwEfddrCNQLnjcv4I3paDG4GagE6fIOw/x+mzuq1elFvnwxgN+b9C0GgMKGyE2qf+zNzTC0DoAOBPBypXAmaGmS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f47R7LSG; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f47R7LSG"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c42a23c8eso93845c88.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776382599; x=1776987399; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/kNjrBw+WE/52yfVTiMViJahEcKo0l27ICLQXLMYg0=;
        b=f47R7LSGru7v2px8HDmW8gPphrDOXOQ8jFXgS7xE0aqKAwZiCfJgGaNeOBxu2Z5hWp
         n3hFjuPp7lcWw7X1NckTnZycLEfKjAdmLbhaykvfSa/DtgiEElthk+PmUxlkO9XUMnGI
         kIKAQV3/oh/MrnRtXREANjufm5+3u0+oFS+VoT5vok4TZTTt1+uQ+TYtv5GJycMNpWwk
         sJqe9ZOex0PJ0NukonLX7T6FytXtp6mUO5gOX/tVqWl3P3oOuT63D68JgNBjFaAP7x4k
         tMmGoXZg0/IEcA82DV0a9Au5rK7EEZOXQeDQ9HyRuSpS9ptlT3HJGijr7Xm9OBS712hl
         4lXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776382599; x=1776987399;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/kNjrBw+WE/52yfVTiMViJahEcKo0l27ICLQXLMYg0=;
        b=Teod+8CooGlsEpT1OXcccxic6wxLhaMOcqECbVVZvurP5kQwDz1xJl+QPKvGaQR04P
         hx2xxh1Y+qmsB1dizxyN/3AENJatnqz621rh9XLnZ24FzLY0KCCyEzP43nFx6Fr7xTxP
         kgLDR14q0MK81Lca+JrQ3oh2h1jFN1WzoOICi6g2k3BZy5F8+Lmn4qDOCUUQOn2LMZIa
         Rk0IoMc+mD8q+lqfoskL3s5oY7fvEMNon5K63uEHlp0AqI5epv3ToeSEtI/LTFaFnWPE
         XYCkuwSqpFupyntRA3G3KnKwv4q8soTGTv999/uatZfw2aJovgmy9G6W2e2fUhJIHhZG
         1pdg==
X-Gm-Message-State: AOJu0YwMyrHai5xpJJUtFmzdUyZP0Qk8vpDnSxsHFHVHehku/fgOf/i2
	83ZmjFxKgVuQwYEq7k1jOXRuQuGhkWefiBSEaNl4Yoqxw23Pmdj7rpBYWkpo9Q==
X-Gm-Gg: AeBDietpoEyLS3S1pu8BoEDd8a1w+HxzXAeDB0Ckjbqz5tQ5GtKJyiL/gHvZcHxwEfq
	Uo1rQMOQZTzv1xcpP1CCu7gROLBYzt/CqnAO9GOIPP9zjQV6WryOfFni3RpkDmz94486n1WiIc3
	NPZ+lYnST0KrBwJQc8x2ZaKmNtRwdW4TJeHaFWHdcSBo/fkeoy1BEtGTM400UGuGvXZ1wR0B+Ri
	XAmgZYK0dvJ8o/ijzSSD6UN7woxUKhW6ElKigsPc8kjBp2034uitSUSCstu8rnsJBO9/LbW4i3L
	/PEpNq/JRdBx50kyT5u3PfDrwgfUw3R9xxoyV5Up/3zBdj3X+JtkevGjrvzOtkLGjWGU1+lr7nE
	OyXfqeAK7xzpGp4zxWoXR36d/JuWAQ3OfZuF98xpifsNXWG64RP655qouxR5RMKLe4LrwpcvlMl
	7oss3eNUyw7gdASRRYA6QrAh04Z44ZtEigL5Q=
X-Received: by 2002:a05:7022:60a8:b0:12c:66fd:6595 with SMTP id a92af1059eb24-12c73fbdb0fmr173059c88.34.1776382598562;
        Thu, 16 Apr 2026 16:36:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.51.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e6b6a05sm9035161c88.14.2026.04.16.16.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 16:36:38 -0700 (PDT)
Message-Id: <3af4ab215b2a02cb7e82b417fb562a1f70c67084.1776382591.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
References: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 23:36:29 +0000
Subject: [PATCH 4/6] doc: fix plural agreement in pack.preferBitmapTips
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

hierarchies -> hierarchy

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/pack.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
index fa997c8597..22384c2d2f 100644
--- a/Documentation/config/pack.adoc
+++ b/Documentation/config/pack.adoc
@@ -161,7 +161,7 @@ pack.usePathWalk::
 
 pack.preferBitmapTips::
 	Specifies a ref hierarchy (e.g., "refs/heads/"); can be
-	given multiple times to specify more than one hierarchies.
+	given multiple times to specify more than one hierarchy.
 	When selecting which commits will receive bitmaps, prefer a
 	commit at the tip of a reference that is contained in any of
 	the configured hierarchies.
-- 
gitgitgadget

