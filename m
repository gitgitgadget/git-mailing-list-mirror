Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194258;
	b=2DbbjlKnMQ77NbSeUem/JTFfK78gwtHbN5Ib3mWN2siUMnNet4BirxS8a4wguLJl38IO
	 LgJhxpxHKYVUcgBvl3BBver1LOwG51D02nUV+Vnh8I5KGYPz3oE9bHPoxWktyRHRoS08/
	 lMs+152CRlqPV5ti/bcGIlt0ITmnXOzY+3nQVcPUaBoLjm6sxrgBehY1YBEYF1x3l8q4Y
	 GDxAQmAbp4FYyPFiRz/O7JNzgpGEzKqBSfIQLh130yT48z2o8hYTwdqPvNidrrGcyy4te
	 ENVvZrdp006esjWgqYHG40UD3eFvh4bune16/0ibiC1nsLmDWfHyUgVyNKrX80SAoAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=mkkvTYQP9gKUbXSVTYDpfhqyBE/sm/jgDaN1NuzaTEg=;
	b=tL0lakgkJpF8NXwjcB5CmQDQ0wK1et+0VhllqPHgKwBT0yIqdLXBtNDTAVc8iXRAZIK1
	 DXo6mXnloJpNtuBrMDJq69PXODwjL6FchElEhXVSgb725C9LnrFYshRg0ZCSuEKN3Srpv
	 DtW52Yj2iWI45Ipl7azX51ZJMz7YAZaj9LKkc4K6H7COghMmQu+FNJamHuV3nNr72nHUt
	 IMAmyeMtZtTiSZD5TefCFwOF/qlxKCscvw04aK+OulN2s5mnr4IEntygnzMi7QkFP/oKU
	 4e7Tr5Nu1xfWxiJ0SdRjOwfHWMTJ+jMzgSHUDzWgoJr1huOhaBwMvU4c87L3T5roJMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bwPCI1s4;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030EA606A331
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 030EA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bwPCI1s4
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4d21051042so211857766b.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 09:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795194256; x=1795799056; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mkkvTYQP9gKUbXSVTYDpfhqyBE/sm/jgDaN1NuzaTEg=;
        b=bwPCI1s4Re4vnWTTNeYWZqyPYQNeEy8rpIUI0u34wZZBUPdPEyKgcY18nfp57UCROB
         WBxAFPHO6ftYoJ6gkk2kQm2q6OAqyoP77+Fg42hDl5hNuDEFQM58KiM+IwvYqn+w1LF+
         7NYK4xilhisf62Pk1JEhfDF5pOLBJkN6M2UBJ1LjyR3ceyr4j/dRd3riTMnWPfVtRL1F
         RmGuLnHLlpYuT6Fq7ev/a5RYf4RyacAUAR0kWWfg4wFhjJNQcQF3AHCk3PRP9mNF/p3R
         SKPl3jx/rERfJB/mbrZZ3kgZWHZRbPE4QaT/w92QAU8GieOsLjggECOka4dzz9RUGAig
         n+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795194256; x=1795799056;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mkkvTYQP9gKUbXSVTYDpfhqyBE/sm/jgDaN1NuzaTEg=;
        b=qRql1iqkhHfsGOjt0uBQeEDK3yCtSuvEfw+Th+xEHBMO6nGLEpukgbiO0704CEeCbo
         Ju3XC5zHIGez/bfh2YtaDfUT4RdCFEhICYTAHaBWj2N+0ijxuHk661rzTAyrUhorytKI
         pn+2AbtzVBmSAYksQmhXhbVJe7OKThprTc0LOuwT/aR6B9wpGZtex2Nb4Mc7xzT3D7ES
         K6Ny9Dgd6Q6ABvM0opAaduMLXadayYILQvvE0F3ltJrRWFyz8VYh8GzFq1kSvEs75Lh4
         iohFcHk/PEDeKgTJrNGrkqo61MKb8muSGBj1tlSYBo8ChPUsJmecJXVxFzJZ4Z8npq50
         Kffg==
X-Gm-Message-State: APuU4Z94xRHxIa2YAkHb9gfBpEJIUyBwekD9/6AZre2pv4ECf/+N/3/6
	nW/seg94z68JFEJz0Q+W/XLhCUbM4JCN+mfOs3ZGcd6tYS87SZFHtjF2dvXtzSbO
X-Gm-Gg: AZFdTZfjVe1OAL/tgY5muBuzTAa8mGlOT+EfVRPuuVGkyUOUy6YywCETmIY4eaxFPro
	qdcgJpqt6wcGCYHEezkCfaU3H3w3Ifbkiz9Q85WRvGMW3a6irbnoxSq1BqBHkdbn3D+1NPx+Y6k
	14NI465JkGmlQ+6QOsd7tvT3zBJfsi9IyP19QIuEBwzh/NGyuzUnoPIh4uSCxaEB4C1w7hErY//
	HjvcNPz8sUPH+FOh3kv6gxCyDje0Nq4P4pDsZS2B/q4plq+f+dNJNZbDZaX7SQ+3uu/Fjhqe4ir
	rvcegnBJBdXLkixMz8PYT3j7PMsB1yFpOHC1wlBu4ZLTCoVKlt4TJxYnPPEyxUKbT58BMdIZ1Mr
	iGy/NPYT2s2Q1RAoTaRIyK0uk3oLbLjqKF/hZKuzCUDsMiooCy4iMpozXT5AiOZ8ukS6XEx0ywa
	wzF4Eyl4I0B1tgoR7LNyppf2BiIaMRCg1auPjE8hfqsBIltdeW24LA0MaPNCfU9nS6IxCdag3Il
	IWFrtgi+zLokHZtB2E+MMc31ByOMKhqGvh14vcY2xUsT1hwQ/bOmTPGOgydfP1VzOLDdH2tBQ+b
	rhFTjKC5+PUMpEIZ9bbnQ0ngsS/n1sj0rpF73441GYaDiur8f3xxQ8o=
X-Received: by 2002:a17:906:7d91:b0:c49:a539:aa45 with SMTP id a640c23a62f3a-c513aad1ab4mr328744266b.42.1795194256344;
        Fri, 20 Nov 2026 09:04:16 -0800 (PST)
Received: from [127.0.0.1] ([40.116.95.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad01b0bsm118775766b.10.2026.11.20.09.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:04:16 -0800 (PST)
Message-Id: <pull.2495.git.git.1795194253192.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 17:04:13 +0000
Subject: [PATCH] doc: update README file name in my first contribution
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

The translation notice in MyFirstContribution.adoc referenced
po/README, but the actual file name is po/README.md.
Changed it to po/README.md.

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    doc: update README file name in my first contribution
    
    The translation notice in MyFirstContribution.adoc referenced po/README,
    but the actual file name is po/README.md. Changed it to po/README.md.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2495%2FOphirBleicher%2Fpatch-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2495/OphirBleicher/patch-2-v1
Pull-Request: https://github.com/git/git/pull/2495

 Documentation/MyFirstContribution.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index c58253fd54..29dc402e5a 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -186,7 +186,7 @@ decent starting point as we can now add build rules and register the command.
 
 NOTE: Your throwaway text, as well as much of the text you will be adding over
 the course of this tutorial, is user-facing. That means it needs to be
-localizable. Take a look at `po/README` under "Marking strings for translation".
+localizable. Take a look at `po/README.md` under "Marking strings for translation".
 Throughout the tutorial, we will mark strings for translation as necessary; you
 should also do so when writing your user-facing commands in the future.
 

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
