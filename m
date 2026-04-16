Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5773A6EF8
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382597; cv=none; b=V8XUxG9hj0QazUJfRRClaWPYljurWHUJ2bRGxOtGX6QFgJN8LiEZv1MrUP7aSEJitQTO3pHXGrDJVQ7R2EYT+8ef6bjvWTWHpyt06NswwUp7L496YBtPBhCw1rjX0x6fI3EMr5naTQEYJDHAZI2aMZG2ZmDKdAIucth4qp9e3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382597; c=relaxed/simple;
	bh=XS0MdE4wraVCPdTxQ8ioTgsOvkmx4mbN7aW30/aqLxU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=cF2lFeLvgIMj3u/nkghXgInoGh+CRokvxF22H3kbRCP82SEtsOzBU4WIPzl0j8yOUJXIxh1arJ3bKsc8e5LdU8Jeutp7EH27bM3itr+7gxmWmeYs8S2tnlay6qc5rXj8pXrM2nakjoQmPVfF8XUj5Mv/KMsPfqFN9Z8GfSO5Wvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ6rmNva; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ6rmNva"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c42a23c8eso93777c88.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776382593; x=1776987393; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I0gLbMMq+SR4rDB15fy+eFrGV5uE08ZnPW2Mpm8sRx0=;
        b=PZ6rmNvasqOcAkJdhMwWNIM/v++A3pUZPsy9KGhmJz+tgjhaxt0Z3CoWgfk1pDkNjM
         m5LaVRerjcDguyLRXazdGbB7GszXna2oCC6K29lBeu78kC4exZ5qtJ90r3CabP4H4byG
         QhvFBVcyhVYm8p40tKsA6SKPHyJespkUVJ+wyCy2gNJg0e7dqWqLSby3jEhPseWstPOc
         ikzAIgZC3UX3cxKEKyLIPAO3psJEQG1y6z7wnMMl1bIP6BnuEFX/xBtaYNIqfTEEPJSR
         pmllvAOfvmjPyg/BuB77Y9IBjUWeIp3NESAP9nZG1iTqymuwdpWZhYy36ZenNmJvTUyu
         D/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776382593; x=1776987393;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0gLbMMq+SR4rDB15fy+eFrGV5uE08ZnPW2Mpm8sRx0=;
        b=SEliQNxMPM12lVZ+22lAY46f1VbNdr4WjhtMmtD/RLdzmXwaFGH1igdbzISuwjXNBM
         +ClsgJdQJTsJLqBrR4bemDO3Ag0FfYegIb4iVA6gmMT1ArvHgDn3p5BOE7JJPK65RG5s
         cPAR4BkOqD0S2EgvdDst9mfOeaCvXlWky48ExcfmfTwAA3Pa+GU0hfR4Tdk6RWK8lInC
         ressPkn2hwoptfygWbSyLwau0H/kwFClQc6+3nYuxGa6UCeod/SR8KXEPgzv/17gqpy+
         0ULuuczCjpcSqwJNElT2I/KIFaaBcH4w3bGRjBFwagjrojG97yPbPJXOrtT/+CgQ2tx4
         gk3Q==
X-Gm-Message-State: AOJu0YwDGJo+c8dVQnuxFwAcWitfKnIUxRk+WtTloRjylQcDYXfMPOLU
	N12FLcCOoNkBVGeqDWgec4PARMDg8tKrDUAb7iqUgheohySogJPvr2CFaEzZjw==
X-Gm-Gg: AeBDiessV0YfCETAoOHC6ySGDh4gaINTFSUaEBY63GgXqefR8S8hcbARF03ll7hhh3g
	2O4sQwI2k3vcBlplPNHN0s0dkMy+iL1vXTDx3E4Bx6JA18Q77Yt8Ls2tpHS+eJP4RU9OJttoWXv
	J9cC+jKKOlzk94seCHrHci/LsfTaS9sK5vTXMAWw8a9QMm77acK8vs+NTKN34X4a6bPDnYbvpdc
	LrYl716NOT2xDEgq6gm9L6PmN35cJ+RipJeLMjoyV7IV53nfdO95PDL9E0TNW8qa1ghv+3RlIVm
	nXzEBV5VZB3/FIWzMayMJMDNDoYxjhVnEyo4owAyt/Q6ICbDLdhUEngZjyZPgdW0tPuJznAsmWb
	uSQkxmib6fuIcVxMS5yiLQTrSJxXuCYbVOlIYUfXHUfNo3DYGaZpNTopLkQHI+byXPAKinJUlN+
	sPeuhwgN2mSbGbaUGuQpgxl0a7iehFT9fYlUM=
X-Received: by 2002:a05:7022:6b8d:b0:128:ca90:3301 with SMTP id a92af1059eb24-12c73f71963mr198629c88.11.1776382592680;
        Thu, 16 Apr 2026 16:36:32 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.51.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e6a8778sm7335806c88.9.2026.04.16.16.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 16:36:32 -0700 (PDT)
Message-Id: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 23:36:25 +0000
Subject: [PATCH 0/6] Documentation fixes for changes made this cycle
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
Cc: Elijah Newren <newren@gmail.com>

This series fixes some simple documentation issues in the release notes,
Coding Guidelines, and regular documentation, all of which address issues
new to this cycle.

Elijah Newren (6):
  RelNotes/2.54.0: fix typos and grammar
  CodingGuidelines: fix subject-verb agreement
  doc: fix self-referential config in sendemail.smtpSSLClientKey
  doc: fix plural agreement in pack.preferBitmapTips
  doc: fix singular/plural mismatch in git-rerere
  doc: fix grammar errors in submodule description

 Documentation/CodingGuidelines      |  2 +-
 Documentation/RelNotes/2.54.0.adoc  | 20 ++++++++++----------
 Documentation/config/pack.adoc      |  2 +-
 Documentation/config/sendemail.adoc |  2 +-
 Documentation/config/submodule.adoc |  2 +-
 Documentation/git-rerere.adoc       |  2 +-
 Documentation/gitmodules.adoc       |  8 ++++----
 7 files changed, 19 insertions(+), 19 deletions(-)


base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2092%2Fnewren%2Ffix%2Fdoc-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2092/newren/fix/doc-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2092
-- 
gitgitgadget
