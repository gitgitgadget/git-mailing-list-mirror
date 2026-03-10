Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB2A43637D
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132682; cv=none; b=hjXETGLav88PpRg94Wc7wvQ6MikQu9dFRLo1xzsEJHoyUHisUX9Yxx/oU2StwR5m+qryHOIvsBluD0fti5ka4eav2dJtaTCRY4vvxFJdZpTPKRiy2zxFVIiPMvp5jmypvPl4sf+bQhv4frRW0L3iYMyj/BijO7KrhhwiYUvDn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132682; c=relaxed/simple;
	bh=Ch0ReRhRyI3FPV1f0pOZOWihGD7an/hdbOsnWQraZs8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=eD16imXdGI22ZfQ4ihOc84J8bZdDwCDcowEWoXqm9FlRkqASTvEeRynNoapKs2z4Mq7+CmzEn0oD2P6labr7u0q6in2A05k+RCaYZulkmm4QjdC0ZVmY2DlvDHJWlX6S/42o6NXDdEi6pzWfaX2quHTyfOSKMmhkEgtxJbTcuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edcDJ2yt; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edcDJ2yt"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-128cba36eceso1366540c88.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773132680; x=1773737480; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X1ADmBUXm2+sxIEYKgaKUoaHjQLYNVW4LoVgF8nBDoo=;
        b=edcDJ2yt53mTC9QmuTiLLDL4IeT+EKGrWrw09l1F7Ue7Gxt2/iOymONp3HsPgKvl8j
         YznJn6YrCKbWxTalDYBrsSaXuyKw96JcF8YSMTxl0NIPmBkrYcbOoxbfb4SNTbTiV19i
         WVvSKYuVPp/6fJyN5YkxWnz/NVY18sNPMFZKkXkIks/g4b6oKj1o0FOBSX1NixMtIpg/
         ZSPS2I29+wwxGTYQ/1vLAm3jT/AggfGEuRcybSUFHm0h5Ih+qLzjgf9Z9tqzylSCoJPZ
         9d+/p79U29uChSSSvClzyO4u4USuBsVK6qYmyQ1qaJkN31pP+v5yu5gA4xnnYWywZgyg
         oArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132680; x=1773737480;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1ADmBUXm2+sxIEYKgaKUoaHjQLYNVW4LoVgF8nBDoo=;
        b=sUV5EIWpsdJ1+b11HdVW7fqI+zptvuFrfahL4NA5cxBU6zfw1vpvNi1skGcGnR2eTQ
         2ODRh1pGYhTxKozrwLwcFafj0ttmY/IQo57Gd49sjBhOV52uoXio8p42fxQpS3JT3viI
         dDFHOQcnW+CsAoU+QcfcoyBbtON23v4UI/KTo7kac4PWasIibXPb3rIY4rKw5HGHq2Zv
         Ic6NpVRCfp4Tu+gzF0DTIluwYdvFK+wp1j3DEpZ683tpiwOpwdH7mlHOdlsJ32Vdwefo
         FWoCxpEFomvdsMkogHFElF6dqHz8CTOM2nT3rl2fMIpKY7x/yPsC/D9LtG0mnHmqX6cp
         X/Vg==
X-Gm-Message-State: AOJu0YxhogkQC3Zoy6+MPp0erdy9rtV+f4+8IBwRK5aB70fOWJYIPniq
	FScPfvgMkEITsxEsgVarCxHNnluGymSGp6QwfdavNFr4PLXwxPdCGtkzqBPmPA==
X-Gm-Gg: ATEYQzyoJGOGrUAhq3wGv7Enev7LJDcPoN8mDRB7TeZWC2l4QpZMzcIol5gnWgFgTzQ
	aXWE99yjgpzuLCreEWB9A4qgnyv6VJMvlI8iBlN9NRxRdRaJC6ZQFMjM3RDhywKeCjcIuSVuEIj
	ocaHoD5AcowcuiJv2TmI33BsMNylT7OC6Wx5n6GSdPi3mBg6B6kcD1Gq2pkAmBk/ZY+gyGu5Cti
	dSlQ8kORLSHU/wMhGggysV2zS500U32eiwg2A93X/Uf8e1J5ybVQ5xcffw6cWwgzIgm+koaCeIz
	sosHwueeTTKHDEj8oo2QPm16fTxVQ4Xtkg9vWay7Vck+yqez0PEL71BhmucLhPg5SnwGRT/3WN4
	n31rUfvJpe7AKx7Hzi/gAPMSXxi08RlqmFze22L0AWsiwMAlch8xn7a6hpSN5GDaRpKVDmm+qv4
	xW7hytTBCJr3wrEyNjzJaeWECOzFmxi9mBWqQ=
X-Received: by 2002:a05:7022:602:b0:128:cc63:82f0 with SMTP id a92af1059eb24-128cc6383a0mr4423437c88.25.1773132680058;
        Tue, 10 Mar 2026 01:51:20 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.69.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128db3d79fbsm5095898c88.4.2026.03.10.01.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 01:51:19 -0700 (PDT)
Message-Id: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 08:51:13 +0000
Subject: [PATCH 0/5] Advice on checkout dirty files
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
Cc: Arsh Srivastava <arshsrivastava00@gmail.com>

This is my submission for microproject [GSOC]

This patch adds a new advice type ADVICE_STASH_BEFORE_CHECKOUT to help users
when they attempt to switch branches with local modifications that would be
overwritten by the operation.

The new advice follows the same patterns established by existing advice
functions such as advise_on_updating_sparse_paths(). When triggered, it
lists the affected files and suggests using git stash push/pop to save and
restore local changes.

The advice can be silenced with:

git config set advice.stashBeforeCheckout false

Changes:

> advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value advice.c: add
> "stashBeforeCheckout" to advice_setting[] and implement
> advise_on_checkout_dirty_files() function
> Documentation/config/advice.adoc: document the new advice key

Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com

Arsh Srivastava (1):
  advice: add stashBeforeCheckout advice for dirty branch switches

Junio C Hamano (1):
  The 13th batch

K Jayatheerth (1):
  repo: remove unnecessary variable shadow

LorenzoPegorari (2):
  diff: handle ANSI escape codes in prefix when calculating diffstat
    width
  t4052: test for diffstat width when prefix contains ANSI escape codes

 Documentation/RelNotes/2.54.0.adoc | 14 +++++++++++++
 Documentation/config/advice.adoc   |  5 +++++
 advice.c                           | 27 +++++++++++++++++++++++++
 advice.h                           |  2 ++
 builtin/repo.c                     |  1 -
 diff.c                             | 12 ++++-------
 t/t4052-stat-output.sh             | 32 ++++++++++++++++++++++++++++++
 7 files changed, 84 insertions(+), 9 deletions(-)


base-commit: 3fe08b8fd1f7731edabeab8138547ec88d6407de
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2233%2FArsh123344423%2Fadvice_on_checkout_dirty_files-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2233/Arsh123344423/advice_on_checkout_dirty_files-v1
Pull-Request: https://github.com/git/git/pull/2233
-- 
gitgitgadget
