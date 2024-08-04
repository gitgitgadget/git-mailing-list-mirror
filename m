Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88C139CE3
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722801942; cv=none; b=qdxJWIzuX1qL9Auvw1Vo2WU+OMuQUNUcKJQIna3z6YRAHgtqx9ycx9VIabFfljqYIBl9zJKvAT86Mv3RHybToRTtdQyQi2Y4uyg59XNZ3hPz+NybPGb/p++8jgqK+mnzgHzUBqFGFyeug0dWduQWuw4uGKVSa2Ygk4ZcDungbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722801942; c=relaxed/simple;
	bh=HQdZK5UvmCxfOsEiCDxUcwUWs7mEGZh/dtKlIYGp7n0=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=prUvbj5LCF2EI0uKWdk10GF2lTxDufuMEoi64j3zdWCGuCliLDHUpbUtwRjXkJ6tGxYmKRSF4g9pAPqnvwEzQudsxbcojocsz/P855u2BhwHT/TufA9+sol8lSi66cvuWnhi7eMXftcisEwmH1PqAXNesq1i0XBNiADtwtA0SSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyP2w/Zk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyP2w/Zk"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso67603525e9.0
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722801939; x=1723406739; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt2MsMdLXBXAezVk3XKRLNVyBiltDnx+iK3EUqVQL6w=;
        b=XyP2w/ZkQAj1emmqe93Xeg5Y42r5ux3OggdKv5ihPXGERlk2uWwBKTWqq+7z9tpD3q
         sZdqFeCgKyQxar1FMl66Ux5ulKZaajUaMEPshoS/o4x9e/pKMiYePXRIINnx0I/CL2iJ
         05qkdOwcLG85VCnTnWSKMpSVUAyUSFQomNoQ196/niVuByl8MmoZmVV4KU8iPKYkjX2O
         euNM3DtX4op3RacrjvnCLHl79tzbYqno9la/HwnWvrfhGC+dxOgaAOtOAKWnuIi60zha
         Rvp6xD/P73oCfxAJz2gwj7gma/t7xCdk2vTQiyMUUjKl+D89kLppL0Nqm08SK4nOL/Yt
         pWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722801939; x=1723406739;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xt2MsMdLXBXAezVk3XKRLNVyBiltDnx+iK3EUqVQL6w=;
        b=se8ulLafTiVl6GOKYU7pmMq1HelZvNpv1+0Y9Ap2mNt8GkB9SwEnzGHy2trTr/33WH
         JpB8ap4RmEQDgfQZ0VPyDE1arbbKxoZIeyrT8B+GqVz8ktHy1vdq0LOV7Xl96dXcCJFI
         VhDjCjpjrnefuxL4dMjJdfnsOyak+FLTrQ4c4f3N1ineaFv+nswtr1rOY7QImOfIhQob
         ha2XeK9+EDn93VBX/GHwV+xj7ctUkK8h1x6cWsERxvfl3m0ak57AeUar6netUv6NuCBb
         UnB8GvC8xSWzGT9ruYkuSu2rFBbqiyTgRIQz8UYoSlCOa92Wsbdr/0vzjYOoqt1S+HJg
         kTGQ==
X-Gm-Message-State: AOJu0Yx3R+e0L/HtCPEP6RjrAben08vr1qdu+rKHAc3pud/7NTS3F333
	zC0A/r71sUo3V4dMQpgfBRNOUSVNDtrfXiMtDdhuHyG38yJemWQoGvubWg==
X-Google-Smtp-Source: AGHT+IFSg1DWF9B5dwr/bpxglHV3JWfkyHh8LJurscvFK5ZKU9bxXJITgW8z7vw+X0XalFDdfv6qTA==
X-Received: by 2002:a05:600c:4449:b0:426:6618:146a with SMTP id 5b1f17b1804b1-428e6af1afcmr67027255e9.2.1722801938310;
        Sun, 04 Aug 2024 13:05:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e05ffesm112007645e9.18.2024.08.04.13.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 13:05:37 -0700 (PDT)
Message-Id: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Aug 2024 20:05:31 +0000
Subject: [PATCH 0/5] doc: git diff reformatting
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This is the continuation of the editing of the manpages to reflect the new
formatting rules.

Note that this patch makes use of the synopsis paragraph styling and needs
to be applied above ja/doc-synopsis-markup. As the dots can be primarily
interpreted as a grammar sign for repetition, here the dots which are part
of the synopsis are manually forced to verbatim.

Jean-Noël Avila (5):
  doc: git-diff: apply new documentation guidelines
  doc: git-diff: apply format changes to diff-options
  doc: git-diff: apply format changes to diff-format
  doc: git-diff: apply format changes to diff-generate-patch
  doc: git-diff: apply format changes to config part

 Documentation/config/diff.txt         | 160 ++++-----
 Documentation/diff-format.txt         |  38 +--
 Documentation/diff-generate-patch.txt |  48 +--
 Documentation/diff-options.txt        | 451 +++++++++++++-------------
 Documentation/git-diff.txt            | 101 +++---
 5 files changed, 404 insertions(+), 394 deletions(-)


base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1769%2Fjnavila%2Fgit_diff_new-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1769/jnavila/git_diff_new-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1769
-- 
gitgitgadget
