Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EBB3A543A
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673529; cv=none; b=q2THexdmkKbvcKv3ntJWzXbf3HgqrQArsBI08zMOtItU/fkfE+b3I7fQnCESTeOUf1xOyNcZgFco6WccKUz7uPk+G9pPXVHiUgpcDKeL5gYxrwedPMtRDfCpWtkNyPXJBCGc2GqqJrq8GGwkNAqVCgoOVctIM+UCHYl3JXtuFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673529; c=relaxed/simple;
	bh=wxeABPHCAeEsudP6XnGkur+hjBRh5YN4p1p37VAp+IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WU1L7Pk01WgJQGdUeZookSOFNHUxbDsQti4tUFyWPxR77of8txN04mtmZuOhnoryi+Qm7Hkhoyb16FeDAv2nFPqflb1flx6rm9QNaNeDxkGHeO3eUnc4zxOuQVfGWdAgohWx36dzAoaAlUqoNjYntVN5E5WSVIsUSjy8HyTdu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBp/qyr1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBp/qyr1"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15cd3fd760so80634466b.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783673526; x=1784278326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/8SrpSUeo9kljJ/kJXXUpBbFadpm1hsMS3/uAWpDkVs=;
        b=dBp/qyr1e7g0vHGnSxS2ovsEgNBcsaM3eu8nUiCC3YOn5DzrR/VhYs1Dz6UbtfLLLr
         m3LHz70J/7S/46qyCXBBUc89SCKT7QL/Rtwx76dsKygtWGPp/UiLBmO3KnxMCX3ex7w2
         wzufO0LTNSNuVA3MI/L5+S9vX4epbkUGDz5+iO46kz6anKo7cTg9zK7Kkt2oo7VebN3+
         FBdcZjHDRNnTmOxy8GO/9S9vqtrRaTs5TQCQ/esXtRRp2jBJi4/m4SYYJQtHIw59KUw8
         spQ2BpkRiVK5S6cs0I8FI39EyuOlCQpsZhQq67uR4nekXMbjmydQjXsHCZ0al/FR2fqq
         KZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783673526; x=1784278326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/8SrpSUeo9kljJ/kJXXUpBbFadpm1hsMS3/uAWpDkVs=;
        b=HaF3mQ96kgxbg5U/MUIHQjSEmUKfp0S/wxiSOYZTepLIuY3Jeqtp0kwaN2tF0HYGNc
         9npxVHE+0d/te1TZv/TP9bttoPp8nVH2ugC4yK15mQOcKHO231Q/X7EQW22uz/Rhp124
         LuIQp4Jn62lwo1zVODijjPxjfLNZQmK5hu0iMg2+PbKXjDM8HJedRht6AIc8pSGBe01C
         3tKEdQ4JGbwZurnqqzHxekrKqM0+kMLIik1M37mwrWB8KD5Eb8ex9z/9hC/GukkoRRRR
         OzUQ5W4VoDmoljwX13dWGD6GPPjqXEbM6yE0syXxm3Y6yhljYFqP2rP8ITMEhFb2wjFp
         sHxA==
X-Gm-Message-State: AOJu0YwLLakxAlCy/QgKo3gFNrgOf5vwBLTZsvcwptwvH/nxcZiufcrC
	614FLw2jJllFscf0WC8QxEiU7oQ+d7l4fxU84GrcEA8lJq4RFC4xwJ6TMobXKJm0
X-Gm-Gg: AfdE7clCWEjMV++aaGY2V+f+Ux4ingkiwoOROdpvGvbN8XmC+YPuK8THNz6a424RNVy
	9UicB03eB+6WnGKH8JH+USZiIUhxfQDIEq2Oz7/p+Oga0MeMrqusre+Flfr7LYmDIGpTGX0ei3j
	zuP1YOzg2wIcLrzQnaePC7x4GPN3YprRRL54DlTr4qba3/vgS8norBskUjy2kyqeYikc1GLiYpz
	rYdX9fQZKWKVHKQz3GtE40D93kG+MetWF2vVUEAQMWGmwnpI7oCHYkpEQ9G6694eSqPhy01HTSD
	LJ+wWE+r6X/rGueIaavsP4/cUDZykGuX06byRFTOTGeHBRKgTZXlcDBWEZ7zfP2w3pFJvxlxPxw
	DRKyjmcZNGxiChKQdTWPwrKn4sY3XJhNAN3zPHJa6Xvlx3D3kDfw7Vgs7Z9odWsZwdoIdVKIcLP
	+O0FcGEd90AbTHzpk32VKm4HOO0ccTR9LkA32YbrwT+MiP1K5Fw4sdnWPXXXnLV7d8Bs0lN41JD
	A7k7GjIhbMmaQdygpOVQpgMvtP5
X-Received: by 2002:a17:906:c14a:b0:c12:2c2d:b2ba with SMTP id a640c23a62f3a-c15ce004520mr451165866b.22.1783673526165;
        Fri, 10 Jul 2026 01:52:06 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15eb1dbdc9sm199561166b.10.2026.07.10.01.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:52:05 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/3] Introduce a 'fromAccepted' option to GIT_NO_LAZY_FETCH
Date: Fri, 10 Jul 2026 10:51:34 +0200
Message-ID: <20260710085137.4171240-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.125.g395cd2c8ec.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 7b70e9efb1 (upload-pack: disable lazy-fetching by default,
2024-04-16), lazy fetching has been controlled by the
`GIT_NO_LAZY_FETCH` environment variable. This is currently an "all or
nothing" boolean that is set to 'true' by default when calling `git
upload-pack` for security reasons.

Recently the "promisor-remote" capability was added to protocol v2,
allowing servers and clients to agree on the promisor remotes they
can safely use.

This series leverages that capability to implement a pragmatic middle
ground. By setting `GIT_NO_LAZY_FETCH` to 'fromAccepted', lazy
fetching is allowed only when fetching from promisor remotes that are
both advertised by the server and accepted by the client.

Note that using an environment variable for this is probably not the
best from a usability perspective. An `upload-pack.allowLazyFetch`
configuration variable would likely be better.

Unfortunately the `GIT_NO_LAZY_FETCH` environment variable is the way
things currently work. It would be a much bigger and more invasive
change to implement `upload-pack.allowLazyFetch` in a way that is
compatible with `GIT_NO_LAZY_FETCH` which has to stay anyway for
backward compatibility. Therefore, transitioning to a configuration
variable is left for future work.

High level overview of the patches
==================================

Patch 1/3: A refactor which separates the fetching logic from the
error handling and validation logic. This might also slightly increase
performance if there are several promisor remotes.

Patch 2/3: A preparatory commit that transitions `GIT_NO_LAZY_FETCH`
from a strict boolean check into an enum that can support multiple
states.

Patch 3/3: Introduces the 'fromAccepted' option, taking advantage of
the previous preparatory commits.

CI tests
========

They all pass, see:

https://github.com/chriscool/git/actions/runs/29078195030


Christian Couder (3):
  promisor-remote: factor out lazy_fetch_objects()
  promisor-remote: introduce enum allow_lazy_fetch
  promisor-remote: teach 'fromAccepted' to GIT_NO_LAZY_FETCH

 Documentation/git-upload-pack.adoc    |   5 ++
 Documentation/git.adoc                |   6 +-
 promisor-remote.c                     | 110 ++++++++++++++++++--------
 promisor-remote.h                     |  14 ++++
 setup.c                               |   5 +-
 t/t5710-promisor-remote-capability.sh |  49 ++++++++++++
 6 files changed, 154 insertions(+), 35 deletions(-)

-- 
2.55.0.125.g395cd2c8ec.dirty

