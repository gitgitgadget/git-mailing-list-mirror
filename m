Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EEB63D
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727010044; cv=none; b=hRvdaKmOjGX1UdrDXZr7n3KLBEAnTnWHmz4rZwL/s3PivIT9qC8pu50WtZEdWjvqjfueFMNe8dQdC8qokpqEI6oT+3RuSL20xlaGmxYdu1Oau43EJwLLLQAUvdoEwVLiA8vOT1YrY7Gvjq9AlggzltXm80VN7LiMoEIcvlMZDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727010044; c=relaxed/simple;
	bh=dRFHtMQFADH5tn+WP7kIpamphhSLmGqYISRF3wyBKF4=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=MNMdXDGIxt02tc5TSeVbP8OCEgQaLjmqfuzig1EwLDvv8OrqZMRaSS8lPTIKxKm0tpiNT+LI2pumnxzE2hfEOjP3vxFPyxF9Fg9V1HXyP81/DopSlR/KbcwlcCheTXry5QtTuQ0W6QhWXrF6xWKwfHVTpYhz12FkDAoqijlP64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9hx30zI; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9hx30zI"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c5b9bf9d8bso818500a12.1
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 06:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727010039; x=1727614839; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1x93I3+VfVprO09RCQLUYPLPacqRGmpIKd+C8nQQeYM=;
        b=W9hx30zIjMNLeIVIX9WWjUI6QPU2lcSGA+UvM67Zw9Di95+i/jhUulqqvGMyiUF8T0
         oqrAgRq7bzU1Q0R6kuLULDG8qLrhbNeHoARItQeWr1bzjPCRbTsPsGBLOjIj3o5j6bRz
         jbRrF8mxi7vpYEoteXSVYqBHFrtnLxDt6dMxXeyv8LCczfswv0/tESPk0PbPkGjtt4ZX
         MqMAVubacvTjBT8JOIf1Vhe6iMVqtRSCdFpJvQAcg7HRoGOY47huXYGR+QDQtMqPPXaE
         de/UDVy13IyE7uN+d0YPgvGcbftZ+OoKZuGWi6GEnwM4ZM/ujdm5DLA5I1NDKg2e/65A
         /GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727010039; x=1727614839;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1x93I3+VfVprO09RCQLUYPLPacqRGmpIKd+C8nQQeYM=;
        b=H9Rjf+gMywH8IoTcVhQOvkXTjuui0u1aTHsfPLXh6ZBms5r1Vn21BWUpwB/XJIi6zh
         dZvojx/oavhivBCoHFlfA3AEdTEChme36bJbvoB2NJDFBRdKPLm6dJddQaTEVxAtbTCO
         5Nj+Nh+/0F3j70LKodrNOuTREUiFX387CdyOhnQY5PdYI8wZNYsDZd9gYcMh+r2X8CgU
         eVUZKs/D9jROaYaYFrtOMdPeat8hGXewbk13zjmxuk6Wmuy1KimyBe2GlbOWdz4TymmY
         ku0bOcAF0o1B144Lfpwic50TBVGuI/u5XxKvJfZTh75e18av2msc/x5MagkXM1Dc7Ay5
         R+iQ==
X-Gm-Message-State: AOJu0YxpgTq8+HXk6nyAW+v3JYRDRvRmbl3Z+VPrfkRox4RPdE66ZFzp
	zlMaVYZdyVyGwMvpK82u+UlFBB8w2XDA7FlW0FyTOU7HC9UQ3oHskT5Zqw==
X-Google-Smtp-Source: AGHT+IFlBkm25of9NR3SaAdNYvH9B83yUUR9ok/NZSrBk27Y8mMk8KKqfPQHe2TGjvd9kFyy9qzSWQ==
X-Received: by 2002:a05:6402:2753:b0:5c5:c1dc:9028 with SMTP id 4fb4d7f45d1cf-5c5c1dc9175mr1316881a12.33.1727010039251;
        Sun, 22 Sep 2024 06:00:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b398csm1083503866b.130.2024.09.22.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 06:00:38 -0700 (PDT)
Message-Id: <pull.1785.git.git.1727010037470.gitgitgadget@gmail.com>
From: "Alexander Ziaee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Sep 2024 13:00:37 +0000
Subject: [PATCH] doc/git-format-patch: link git-apply
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Alexander Ziaee <concussious.github@runbox.com>,
    Alexander Ziaee <ziaee@google.com>

From: Alexander Ziaee <ziaee@google.com>

git formatted patches can be applied with git-apply(1),
so link git-apply(1) in git-format-patch(1) § see also.

Signed-off-by:	Alexander Ziaee <ziaee@google.com>
---
    doc/git-format-patch: link git-apply

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1785%2Fconcussious%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1785/concussious/master-v1
Pull-Request: https://github.com/git/git/pull/1785

 Documentation/git-format-patch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 8708b315930..eeebc805d6c 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -790,7 +790,7 @@ merge commit.
 
 SEE ALSO
 --------
-linkgit:git-am[1], linkgit:git-send-email[1]
+linkgit:git-am[1], linkgit:git-apply[1], linkgit:git-send-email[1]
 
 GIT
 ---

base-commit: 94b60adee30619a05296cf5ed6addb0e6d4e25dc
-- 
gitgitgadget
