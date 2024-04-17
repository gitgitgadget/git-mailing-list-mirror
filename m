Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20290839E3
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342541; cv=none; b=Wcr/l0pkWZUZehUZfwQbMKoIdzOHX2KWc/f+e0IYoH8o/TmpQXKW0Mxh6VB6KewD2douoprIAR/tErbMiLGdsDsPcbyMY+GijJWRrUG11HZxDNGr37FsbsQc8+vhQWk13xHOTxu8SjMKUqzyAMgVD0ZDtBKHBcRMXNWcVJF2NUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342541; c=relaxed/simple;
	bh=KZp7mpEerZw5ibekXMuoQkptE92qSrzLIMHNFRbB1PU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ShK8anzhmFV7R5rvD/G6hQrVg4EkO92CdoVdGHZ04IT+vZEcRAXBYSVOvydxyC+H/BM43YDqlGXOOYDcOxSuWALOv7BNSMErk9Gq6nLhiQGR0Zj6e+BCfouG7Ye64Kd2s/M0O5OoWgHGL8waWS0dVp6BVRz/mteAGWpJuTaWJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icBjfFoX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icBjfFoX"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-418a02562b3so8296595e9.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 01:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713342537; x=1713947337; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8rS97lawqvL6i++/fNr47nsn4H/4c4FCOtqlmxbYrcw=;
        b=icBjfFoX3e5YAG9vhMPU52NyRUuLm0reuigplIaBvzf2tW5BoUbqxeyv9QR9/CW/dI
         HaBFNlIAe6lmsxcjTr0ty15f4PKWX63WpJYpmHCCT7LghZHBT7a+fV0BGJhUl7ZIIkNp
         cEafASr6gWjNDYCtGxChOKRYf/YEkHjLFjjVGDp+Zi6MqxYN7T7D4qhEqKET0pNi1T7O
         1avSdzBei8eLMSi0EeP72Z6xREsiMRVcrdiuZ5Abnsp/lsa50NcWdL4BZgZshQQj5Llm
         Kn2/9ZHXNPZKolDjYKmgcYogA5BI87K3rkFE4uigYcwuZavPp/hjHVXUVLsZ1vFaWOtX
         E4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713342537; x=1713947337;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rS97lawqvL6i++/fNr47nsn4H/4c4FCOtqlmxbYrcw=;
        b=R0Z89+ils/oCDRx8wv/noXDqykERZCtnAN7a9C1BRx6rPYIUgcXH5UwI2r2/iRH0Au
         YErw9kedXycWP9FUo58mdLb2v1G3NJgUe27jn+TwPW0kCaIYiJkMjtanyXMuTVElzjA5
         aWsuOAlxYnI62Cm+JhHOVc3KZ3gJm24L8a0a1NcnT472AjRfGKre4dzMHtN/VHCY9/kY
         9xijDJ+w8sDeEoOD7rfhOxE31hPAiBbvy7pjvOLAvWDDT4kshW7ZMDhr/71BpCax4Drd
         fABy27T7poTtDu4xufwUAe+xKc/UQgxF8Xz36XdspOd3kq5fnwgd/Fv0Xngts6fKSf1k
         4kKg==
X-Gm-Message-State: AOJu0YxE0F/CC8OaaY332Z7j2CK7YJM7NgZ6/WeqvOY8nI9CE00rGxgn
	dgy15SznphNWlEhsRLY69jKI9P2gZeE2EeHbCMcI8fKVBp17dO/C2yG09A==
X-Google-Smtp-Source: AGHT+IELhAdTvWtqb+YA7HjVx+zmIP/GoCKmeGrhlH2bEPHMRB0SMKegCrqQ4JYmiV6osKixpHrnTA==
X-Received: by 2002:adf:e2c8:0:b0:343:6e18:5f09 with SMTP id d8-20020adfe2c8000000b003436e185f09mr10802263wrj.12.1713342537370;
        Wed, 17 Apr 2024 01:28:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id gb32-20020a05600045a000b003462b54bc8asm16878726wrb.109.2024.04.17.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:28:56 -0700 (PDT)
Message-Id: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Apr 2024 08:28:53 +0000
Subject: [PATCH 0/2] Use a "best effort" strategy in scheduled maintenance
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

Over in https://github.com/microsoft/git/issues/623, it was pointed out that
scheduled maintenance will error out when it encounters a missing
repository. The scheduled maintenance should exit with an error, all right,
but what about the remaining repositories for which maintenance was
scheduled, and that may not be missing?

This patch series addresses this by introducing a new for-each-repo option
and then using it in the command that is run via scheduled maintenance.

Johannes Schindelin (2):
  for-each-repo: optionally keep going on an error
  maintenance: running maintenance should not stop on errors

 Documentation/git-for-each-repo.txt |  4 ++++
 builtin/for-each-repo.c             |  8 ++++++--
 builtin/gc.c                        |  7 ++++---
 t/t0068-for-each-repo.sh            | 16 ++++++++++++++++
 t/t7900-maintenance.sh              |  6 +++---
 5 files changed, 33 insertions(+), 8 deletions(-)


base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1719%2Fdscho%2Ffor-each-repo-stop-on-error-2.44-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1719/dscho/for-each-repo-stop-on-error-2.44-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1719
-- 
gitgitgadget
