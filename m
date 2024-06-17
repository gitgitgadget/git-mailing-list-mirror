Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892918FDC5
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615051; cv=none; b=IanXCOHfW99gtrsxbn2CR+cP3NnYsNj2nvzLmwpkIuMo4TWiCSEJz4kAHbHEA/jSqm4R8CZWyD1lyC2hahl5wZCPtcTAhDV0nz5sMQtJMUgu2ttT/WxhPzIGEJj21LmpaAqGZKv5qxWLWB/K3xwj0LsUW651ZVc4pvvJxeoexPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615051; c=relaxed/simple;
	bh=K5rbLs6cGrThptE8BhG2sCNWNz3zJ4xLV7jUe3tyR9g=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=tVifwfD0G7CzTmGdXOfrZ9jPThrRlbkLCjQYVOda0J4M9scZIk8PxBzMHtofGIqPspSyNm3PG99E92FPurQnUFA67iwKvMvrPaLt2JSt2u3LWsKkPqooYHCmCVj9lebrQd3b8/joyMlIH2+hUt8IVUp9sXjcvR+BKpmFhd1K36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0cTEK7i; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0cTEK7i"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f236a563cso3340907f8f.2
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718615047; x=1719219847; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1xqtmjl5BszI1X4kayGQFBjajU9+c/i8xx4T0n0VKKU=;
        b=B0cTEK7iBu0/nmKldr34TKjkJYJ3MKfdZSVFLcweZOVKYFCUDjx30aWyry2OLcNvH5
         4p/ZzPMrNxI4uZfaYTpJooGg98l+mmK+FbrmMClL9jbcACtVhieafZWPwikZQFyUfqU+
         nVKKyjszHMrm+P2tvoqIRGMUvSiDDM9I2V2UxpXv4ArbdThHF8tI4fmlH7Vd6SVpYU/F
         t6UmBCebYp3Op+xHdn1wUWxmgyNaFWTAFMgM7DBjb0B/DcSMDot80DudITQvm19+396r
         UziPESruJN6l5PB1ByVV8uk6au6w6z6QT+cU4aFdgJJV/Wmn6jZfTC8YNKEpgdYk0Wro
         7DoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615047; x=1719219847;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xqtmjl5BszI1X4kayGQFBjajU9+c/i8xx4T0n0VKKU=;
        b=uofworZqSoAQYrAmyWlctiQWNuDplg7AUA0DFrc96Q0yHQXJBk+BVzv4UsYpokze7U
         2GpgGDtVn7gjcQjdMXCyVAL/07cg+qgpYfMYBo0iRwWY+a4LJQSoLLG8+1PlctgxI1cH
         dy9oEfdxPNQKStH1nd2BEfRpD/Z2R6KWW5wlaJl7uXF72ej3AUHVHVtME+PpGvOxH6Ek
         iOt5D2bSnw7J4ro9Odqq7g1su7F211lMTn3FaNWgunpapeUriKibfshHUxhdWlKkzv5S
         83ITIPCf/QtBBhSDkKZ896nVjuA2tPWmfARqaN9117RTjbweySIsCz+aS/E7xqZQNWud
         nkgg==
X-Gm-Message-State: AOJu0Yx9ZOXF3jjuH0juf9HsRQJJC0Sjge1Z4WYI5yccYluxg7Q1pBkL
	aTXrL4cKfcRC5cd5YPq/NExYWy2z0/MMI4nS1MwryQK5LqqlxZqG3vzGLA==
X-Google-Smtp-Source: AGHT+IFz82uBXO2kdajh15dDkIR1WAV4JM8OjdlE2ikOEZv+DVvy23TkXnz8i7MIyF++ps9xvycGXw==
X-Received: by 2002:adf:e256:0:b0:360:81c3:689c with SMTP id ffacd0b85a97d-36081c36a40mr6913234f8f.7.1718615029554;
        Mon, 17 Jun 2024 02:03:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36074e0e5adsm11532274f8f.0.2024.06.17.02.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:03:49 -0700 (PDT)
Message-Id: <pull.1751.git.1718615028.gitgitgadget@gmail.com>
From: "Miguel =?UTF-8?Q?=C3=81ngel?= Pastor Olivar via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Jun 2024 09:03:46 +0000
Subject: [PATCH 0/2] Symlink resolutions: limits and return modes
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
Cc: Miguel =?UTF-8?Q?=C3=81ngel?= Pastor Olivar <miguelinlas3@gmail.com>

It can be useful to limit the number of symlink resolutions performed while
looking for a tree entry. The goal is to provide the ability to resolve up
to a particular depth, instead of reaching the end of the link chain.

In addition, I would like to extend the symlink resolution process and
provide the ability to return the object found at the designated depth
instead of returning an error.

The current code already provides a limit to the maximum number of
resolutions that can be performed, and something similar to this is returned
to the caller:

loop SP <size> LF
<object> LF


With these patches, we are looking to return the actual information of the
object where the resolution stopped. Something similar to:

<oid> blob <size>\nndata\n


Miguel Ángel Pastor Olivar (2):
  cat-file: configurable number of symlink resolutions
  cat-file: configurable "best effort mode" for symlink resolution

 Documentation/config/core.txt | 19 +++++++++++++++
 config.c                      | 18 ++++++++++++++
 environment.c                 |  3 +++
 environment.h                 |  8 ++++++
 t/t1006-cat-file.sh           | 46 +++++++++++++++++++++++++++++++++++
 tree-walk.c                   | 18 +++++++++++++-
 6 files changed, 111 insertions(+), 1 deletion(-)


base-commit: d63586cb314731c851f28e14fc8012988467e2da
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1751%2Fmigue%2Fmigue%2Ffollow-symlinks-max-depth-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1751/migue/migue/follow-symlinks-max-depth-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1751
-- 
gitgitgadget
