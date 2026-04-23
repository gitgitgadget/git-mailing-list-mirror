Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3E2F83A2
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960583; cv=none; b=uvPO9PGcYsXEfIsybqGNxesXvJIb+dtzbqfunRgdxB5FfRr/FF8bZ9BMsowIrt2sx7WqbofXaon6PCuPil1j8n38EbqeexyHsMYUe9IkCRqgWgwypvIrMTGXi5YPILzXSqB5MlQSn7st96GDCy/8bP6CF5ZXH1TIXph+02DVqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960583; c=relaxed/simple;
	bh=onCS+epUfNn413Lq3KJP0TZhA+RyO6swDTIPyY8qgVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXv2KLn1fyI3gGFzh3Lhrx+vSVyFUzAf9m6AbS7CgQpKILVlx7Av1rLe5GhU2zVVRRt9Dy7t4kXofU8IA8qzer8Wq7YTfc6XrRoj7Oo9vEOyZpB+7cdp+nrCdP5QLK3VnUVpFk/3Hq4gDNEnhbO0cFGNfXOVULcHcOnVrlNpYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jutXA2Cy; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jutXA2Cy"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-797ab169454so86601207b3.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776960581; x=1777565381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZiziDnCGD4A3lVmmyrJzqHyPu89OkPgHzXH0k4gPoc=;
        b=jutXA2CyI+H795vivkH0ErYY2396lamY5jQZ597Vrmdc/A4xdsfSSFO4zApSFvCoBv
         oF3UzKyJH0SzjOwIfXATxllw2kyBKKysRTSbDCrn0EOVOVmXrU2Q3+E3d/04SOSigMpX
         8omPUpKADWYcwSq5G3o3LIcfg6K3YcKw0YzVAeMs4X+3XeM1R0unGLcAfkgVphXiAPVo
         7SHdskWVsnyJ+7q3PWaTANWq6M9eITc4VNDjJlCv+4vFSorcxYSiZhPg4BaDCV9nza0z
         iisCKxNGkJvwIugOc7xPwX5yNbjYz6XCAx765LXHg6ZkngEsoM+plsGKiQCGUOYtsAk+
         GRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960581; x=1777565381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KZiziDnCGD4A3lVmmyrJzqHyPu89OkPgHzXH0k4gPoc=;
        b=TK0D8F8x7QOtnw0l37aawoTmqSzb2VbYNkxxxHe89AcTTT4k4+P66RM6XT5nTTNxp9
         yJAmB/RbBYHEWzP1ZnoC1HTsZukjoL9mihEpTtqf8ftsLpwKjAQT0L5NezPsA5Bgr3hZ
         987a5KFaLF9XzzBJ0PHT9PGJG5j/KUX/S7+9RvmvArxEgxDcSaVk0otYv3+TYOFP0hz9
         d9CHMZrEGEBBO77Owd5Ko3kA58yZMMLK8RfqZq2bybo5lMbtuefqD37T9Kqh14Qzf3n1
         VlxdrbHRLd9wyW45qIUHrHxhBUuJXevzWspJvXFlPr/tTBuvPPXBeo9sTBJvMc0BgUqg
         ts4g==
X-Gm-Message-State: AOJu0YwALXpEj9K+6E5oIwamWs3bAPpkcbmB/3l2jR2z1LjOTcd5sUWs
	kly98gc3cswtojhyVuUQWoLxunMCKi1kQCe1HIXu+sf01HGb/Tmv1xziqcr//qUX
X-Gm-Gg: AeBDiesGTbXk8iZA1y+DXpxiY+2tvRIifqihwcnD9nFLj2ilFFSQGcYatHJK8Vfs0M1
	rBa/GnQyf/y7n0Oek0T/t+no8K8DtQZsXfjAfBR1DJVn19jaHeQADvIDDZ1FLT0Qv/q2QTfHAKx
	Lt/PDW69Jyr9iyQvqwJh89QvQh6ByVs7gPDES6rcEIREJhsxuBa+lUPyTfZWVEYEi/c1jJ//yUg
	25BWJhvd0InTqddQ1C+iNM69rCKDgcl1h2u7I2jRmXJqADKHXmLQMIHXDch1HNXZjBdEcr8i15d
	mFwp0gSy/pIto9aTs3l98GNo088H1ts035PEDZ1BDzn41NIZPLIe7a0AKBZAbxDD7q1debvQFEo
	QWDmMGNxWrFJupUEnsCAd92gztRsxmFVqc70QUt3vEu8RvilewTQlh4V4ggWLdN9LvtxrfJzoDh
	EyjFCiB+AiGSelxBR9ooggAqC4ywjKZfqsP9423qQXMJaFZxVX1GJsCrH72SnGuiSScxZH5Omco
	tY+vNgq
X-Received: by 2002:a05:690c:6d81:b0:79f:b903:88c4 with SMTP id 00721157ae682-7bad58a2e4emr263264687b3.46.1776960581160;
        Thu, 23 Apr 2026 09:09:41 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7baeeaa2cb5sm51083997b3.21.2026.04.23.09.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:09:40 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v3 5/8] CI: bump actions/checkout from 4 to 5 for rust-analysis job
Date: Thu, 23 Apr 2026 17:08:29 +0100
Message-ID: <20260423160832.114816-6-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260423160832.114816-1-belkid98@gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423160832.114816-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

GitHub Actions started complaining about use of Node.js 20 and I was
wondering why only one job uses actions/checkout@v4, while everybody
else already uses actions/checkout@v5.

It turns out that it is caused by a semantic mismerge between
e75cd059 (ci: check formatting of our Rust code, 2025-10-15) that
added a new use of actions/checkout@v4 that happened very close to
another change 63541ed9 (build(deps): bump actions/checkout from 4
to 5, 2025-10-16) that updated all uses of actions/checkout@v4 to
use vactions/checkout@v5.

Update the leftover and the last use of actions/checkout@v4 to use
actions/checkout@v5 to help ourselves to move away from Node.js 20.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index f2e93f5461..8ed268fc09 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -480,7 +480,7 @@ jobs:
       group: rust-analysis-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
-    - uses: actions/checkout@v4
+    - uses: actions/checkout@v5
     - run: ci/install-dependencies.sh
     - run: ci/run-rust-checks.sh
   sparse:
-- 
2.53.0.155.g9f36b15afa

