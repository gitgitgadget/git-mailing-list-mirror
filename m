Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED272157E6B
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173145; cv=none; b=QKt6v4KuA3UXX4tFA/Oh5GshH+60JhezxXVlH+Z2UccN1JOd3h2T8s/uTI3wF+TDB1ou3uFqovaArG+IYH9HooOetRuh+1JU34L8gCW0OjTjA4Vrae9647Y+M6t3uSt2+wxNxNSUoadvjxrEdQPWzesoVuRJ+rtalj9nTnKEGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173145; c=relaxed/simple;
	bh=6XyFevlCEo6fS6T8HRbEQCkAEn7GxuBRuW9sOd+hPMo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=qmdlIQCMofZimYnSoTyg7AmtUW5/HfQtS1/+chv/x5GTURcJuxSbTsO6REdkfC112AjdhmJ2aOUrCwkwQ6gBb2FtCrUKxDfayzkdKSFefuTcxhaK1ph7h226gJQcIi0U/G6WuMkCiRQ4rL8iceFMzxAdpr19DbEQanM6hlY0F3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARs1GSEv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARs1GSEv"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394036c0efso15047075e9.2
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743173142; x=1743777942; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J0q69ZjLkS0BIsjR3hwTynbDOU1hRfqQN3aL8S4qtoQ=;
        b=ARs1GSEv2207Ya/TTAic6T8QK8B/d2TGhwhrWhLIKJw7Xshg8Jc1YVRkRrCLSceDbK
         XNzC8uIzT2gBJA3zSylp17UmRk37+1PIvF+4r7/rk5n8hax0rNHzQDC/wS5JyRJUTQyF
         fGvyIfO8CuI1lcKMW5fv/I8fnMT29PrfPPjfilcz23MjJtMJrIOwYwX2mmXCdTIccrOg
         Fb5tz32+QShUzzGyh4uBruXnbyhaIt2P0OYgVA+CONxtPAaiG0tOOLvx9LTKjtVRC9hc
         PuW3rECq0InDrgKo3lCzIhFbZx+k4CySna5VmPb6DhGgoRUXlKnOTQfBIBHeqMLHvAXz
         CeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743173142; x=1743777942;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0q69ZjLkS0BIsjR3hwTynbDOU1hRfqQN3aL8S4qtoQ=;
        b=jQUzHTtvi9/v8JnMfKAYIKBS8E7B23ZRONsCY/1xlV8zzLQ1aj0sgTOgpyN6XMljnh
         6HLhdjr0eFcoOeE3i87LXGuEAiO5rAT9SFE1kyqSsxyZUtUvVVS9KY13Bd8MaxvzwfC0
         Dxg3RohwlF93GkDimscaCvm+Pn2xxxH4+QeKNGT4ljeniwwr1Go27Xj4KQ3kah/s7G18
         TvSWFSIyDOvQ9Gn3VlpbtTUqsXhBAH455tfwnYz9UhRaZu1/4ccSgWvEt84NqFIFZjd1
         +eJPvHHkFSd6RrWViuzarXMEdto5uPVIkax/U6qy/5A2OM5pSJiI2lhsb1CJk952ElLz
         gsEg==
X-Gm-Message-State: AOJu0YwVZCP6jntuhV/q2XKsGNpOZxnVY1rguzk16yTvnA5BdhWNvsky
	ogpFroj0kIVNax9UekhpmLUUtaxlwv4wkuvAoXdOg+7VUG2LpcDzmATQow==
X-Gm-Gg: ASbGncuWRVU1kwIbQkB0vnePzJ0EdK7LUQlg7DJ1tzSItDQLz+xUXh5b375Xcj8jG+F
	KnSFBlnnsV1Yezr1MBHhoCdQUA+b798A4KtrN0JLPUKJK8fNPZOax8Ew7KSQhQYC6117dki/J1t
	/j2PsW0i7/BMUF1qMgtzFWxH2VySHeNGrkyyo2hwV/ta05OVAN7D3j1SfKiErp9wA1wdWMlTCTK
	vuqw2P+rff26uv4BfMWZhIXXFRYjrJ6SqrPdCOdGR4x4TA6qh3T7RLFh71DLcGlKSO2AJ4b5pWo
	EKrqV6kOOLc7C6ql2x+dVz+8gPwV2DqN0dSdWOA+jA8FCA==
X-Google-Smtp-Source: AGHT+IG2SfvIOkDmw2CcyslJMMpjXGT0szBL0Ps0/w4a9f3TlOh+bqGwMjX/Qh+oKJLJoZnossG3xQ==
X-Received: by 2002:a05:600c:3516:b0:43d:ed:acd5 with SMTP id 5b1f17b1804b1-43d84f9afb0mr94085365e9.10.1743173141517;
        Fri, 28 Mar 2025 07:45:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efdff2sm72938045e9.17.2025.03.28.07.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:45:40 -0700 (PDT)
Message-Id: <pull.1895.git.1743173140253.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Mar 2025 14:45:40 +0000
Subject: [PATCH] merge-file doc: set conflict-marker-size attribute
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When committing a conflict resolution for a merge containing
1f010d6bdf7 (doc: use .adoc extension for AsciiDoc files, 2025-01-20)
my pre-commit hook failed because "git diff --check" thought there was
a left over conflict marker in "merge-file.adoc". Fix this by setting
the "conflict-marker-size" attribute as we do for all the other
documentation files that contain example conflict markers.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    merge-file doc: set conflict-marker-size attribute
    
    Grepping around I can't find any other files with conflict markers
    without this attribute set. (If there were I think my pre-commit hook
    would have complained about them as well)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1895%2Fphillipwood%2Fmerge-file-doc-attributes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1895/phillipwood/merge-file-doc-attributes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1895

 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index c6a0b35116f..32583149c2f 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -13,6 +13,7 @@ CODE_OF_CONDUCT.md -whitespace
 /mergetools/* text eol=lf
 /t/oid-info/* text eol=lf
 /Documentation/git-merge.adoc conflict-marker-size=32
+/Documentation/git-merge-file.adoc conflict-marker-size=32
 /Documentation/gitk.adoc conflict-marker-size=32
 /Documentation/user-manual.adoc conflict-marker-size=32
 /t/t????-*.sh conflict-marker-size=32

base-commit: a36e024e989f4d35f35987a60e3af8022cac3420
-- 
gitgitgadget
