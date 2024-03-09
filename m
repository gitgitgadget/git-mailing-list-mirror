Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AE336AF9
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709993403; cv=none; b=KL9Zsu31oYSNc0AF+6UHC3qyAJRxZV7YM6ufhwZSn6A+16BeB1HrEIb9lHNKWW+jfdtT6FIaCws+WA2rYNYL5x48GAZBW3Fx8wmMwgDPJNeU/755suG98dSEQm9ZNhmdQ8K3mAudjtERm/SK8fIMBFU6JKMPcbUaXX3vEnNVyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709993403; c=relaxed/simple;
	bh=c1WHnLk2H+xTrhyzn8TFCtI5UgWAq8nBGQwq+ONgRhU=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=B1rq3qKyISnh1+PZPZ4gIUxKCPK28Ly6emmfgQ1RMgS08078aTmJGq53gdGLbhOCbVcdXoxATWy21JQcaooIh02YQxq/bwSUpj9EVho28ZZSEkdUOgTu+uw0y5OHJ/0txEgQhT+Qwj48CyVG8UMJx4DRSkgdibh1HOEIoS6/aGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY90MlxP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY90MlxP"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e742ca96bso1958508f8f.3
        for <git@vger.kernel.org>; Sat, 09 Mar 2024 06:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709993399; x=1710598199; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lsLYc0cYhdqgK5Rgpk3SogpXYPRQHPtOANAuJphJfsY=;
        b=ZY90MlxPdErPpfqjgJrYZ8zF/Bx46b+p1JXatohGYusVXgWowv14sSCKr3R0CdiTC8
         aFWoHWk3fcFTGuE4w3ifBLQQX06C8htr8rcxHv6uUiHUYTRGRtUzh4f0qIHNX+0FwymM
         vvrdvVTiYjSVtopIzyELkBlJ7cd9kXj7Tr4ZmQ+x3JVPcYk+gNezqSciJ2ve/8sOqtj9
         dlzuYT1a/Cbj31camIt/8GYU94VGD0RFM15k569HAB1po0ulSw0e9qIRVyavc8iDWW9l
         VqUoe4JEhGccLgIFeK4b6GwpQMxl7P6M+01XzDyO1RHixnZrEN27xi7OHhmNgZZpW/5V
         5BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709993399; x=1710598199;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsLYc0cYhdqgK5Rgpk3SogpXYPRQHPtOANAuJphJfsY=;
        b=tuzmDpj7cn2orxsD1dFNduGD2TJ+8Lp18cZq0SRVojTtmXWFAI4maoNTeD6AaR3B5S
         H8X8AcXZLsRn97nWkWVZnbLi+9KS9wK48cjtEtaGerhYl8Zc20C19LfLLk617ZGUaIzp
         mziPqSPV5i775ckJKQZnw5O85Mz0nK52RiGeAFfu2fe1uEAvscj1G6QuXFMhAlsz/KFJ
         i343qRUUCrjXNVmYqp6nHTl5wjg0Vci5xxFTAN+rl01l+zGPCTaEof6xTHA6Kq04mwku
         pRwpfGucu2Huf2jciMXCMRbL5yEqoVMhZ/oTl5SuwdAqaUIWtuHUOMTOx6P+rc3YZEjQ
         q0lw==
X-Gm-Message-State: AOJu0Ywdjb6NbcHvdRD/Tcly+L9EQnMhEAUCldG29jkF+5FobjNOt6qM
	eqso8ss2EVRVOmrmRZJ4a8T8eHZoJgnr+obFdP3i3EL6gd+bhgAhy/WkwfcX
X-Google-Smtp-Source: AGHT+IE+2vxVkcc0O6Mm025hP+EXmTh/m9tD6mA+tffLwBZKZgCU+jWLqAz7yT0do8VlsSSD0PSv+Q==
X-Received: by 2002:a5d:5267:0:b0:33e:7650:1297 with SMTP id l7-20020a5d5267000000b0033e76501297mr1219918wrc.6.1709993399024;
        Sat, 09 Mar 2024 06:09:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b004131b0c2bd1sm4549178wmo.16.2024.03.09.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 06:09:58 -0800 (PST)
Message-ID: <pull.1686.git.1709993397.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 09 Mar 2024 14:09:55 +0000
Subject: [PATCH 0/2] The merge-base logic vs missing commit objects (follow-up)
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Dirk Gouders <dirk@gouders.net>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Jeff King reported that Coverity pointed out a problem in the patch series
"The merge-base logic vs missing commit objects" (which made it into the
next branch already): The return value of merge_submodules() is assigned to
an unsigned, single-bit variable, which as a consequence is not able to hold
a negative value indicating a non-recoverable error.

I looked into this issue and am happy to report that there are no other
instances of the same issue in that patch series. The first patch in this
here patch series addresses that issue.

While looking into this issue I also noticed that the merge_submodule()
function did not even return negative values! This was an oversight on my
part (which I attribute with a large amount of self-compassion to my utter
lack of enthusiasm for submodules as a Git feature), and the second patch in
this here patch series addresses that.

This is a follow-up for
https://lore.kernel.org/git/pull.1657.v4.git.1709113457.gitgitgadget@gmail.com/,
based on the js/merge-base-with-missing-commit branch.

Johannes Schindelin (2):
  merge-recursive: prepare for `merge_submodule()` to report errors
  merge-ort/merge-recursive: do report errors in `merge_submodule()`

 merge-ort.c       |  5 +++++
 merge-recursive.c | 21 +++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)


base-commit: caaf1a2942c25c1f1a15818b718c9f641e52beef
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1686%2Fdscho%2Fmerge-base-and-missing-objects-followup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1686/dscho/merge-base-and-missing-objects-followup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1686
-- 
gitgitgadget
