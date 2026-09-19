Received: from mail-ej2-f24.google.com (mail-ej2-f24.google.com [74.125.228.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A073033F7
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848768; cv=none; b=pMNqpPIsT5vxEToQp3wslWmtnlAnRwuHeKwWUjO0Lo4xuqHTgtPLFBT/pz3p6+DIRh0XyXzPqpGhYFhOsEQ7IkxrYUJfEGOsi9xqKYa6AHoSmbq6Hu+qlyh1qa2cCC3ug1JWRAvVokOJOqX+qlla/WurYr3ZCQKxN6UTLZp8iis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848768; c=relaxed/simple;
	bh=pQPPgT7nCQN+OBvPlsrUpWjArPfhxAU1Esi+mnHT6Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4GrU0+4a4wKw9XtQqE/VPIveMEhif8/wQsnR2QFPBLBmuW6ezv8xNnz5fM/1BsPn5pR7Vo/j4eJ6XOQVWhPTiooXuaPb5oUCGqaPrvMOXF8HjWxmZ0DMPEx+pt4pX4fk8Xtffng0BneFHDD6gqpKrTav3caUV8RvXqRODM3Tno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aubu6jAt; arc=none smtp.client-ip=74.125.228.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aubu6jAt"
Received: by mail-ej2-f24.google.com with SMTP id a640c23a62f3a-c29d33431c8so250678566b.2
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789848765; x=1790453565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j6JJs3Xbyrt4IwDekBkN20k0hByKaig6IgwCAOpwe4w=;
        b=aubu6jAt7+Y5GTuwg/op8xDNbfKuaC4Go0dEh6RDuTJDq/RE5dcwPKpXAULEKE6X16
         5UQZJTBvigXoLkyjSwiY4vHOunDxf3pVhbU+berDWBPl9afy1K0ol5ZZE+46QjrbObcO
         DvjM830viYApftkR849tCm8cjZe9SZLHKsA6ATC48vRsuCXoCabJEfwMzQb111w93ZeC
         mU1F1UhOYBam7Kgl/Yrfpl0ftH6QlWbXKLsrwXhYWQacn5ohX3CeH7ujYHkpG1q28blq
         cFGKAh0hWQH/DZClWUXs4qrhY0fdrgHLluN95iMzcMpO8cY0h+h9Vy3E8gI58aPqR6+Q
         Utqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789848765; x=1790453565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j6JJs3Xbyrt4IwDekBkN20k0hByKaig6IgwCAOpwe4w=;
        b=K90vNYbikj6k38shjwdsqAOP//HgPhamaSmDzj/u7Y21Mk4Xh/Z7WjynEClhDqu/9u
         DrhowStHWs9TDQprRQl0iYopzkyGNnDecxT3C88t1s/+uDMrc8bmeoLYpyQVZtz0L1A7
         GY36Tl3zA+p8x4MEc6pzzZ43KYejlbjh1nin+n0+AMAy2parNbv3YPSWK9EQG/kpzjd5
         2NigzFogOhbw44t/q//BU/ug9PL2p+sgyHIN03UWbP7JKNmSELzW4IUE10xpQTukCa3l
         GDzlDntKuDAhC541Lg8LpCh7Wo8Tr7d3gccjlITquDQqZcTnZXDHxKPjlKzdoWE0cDzc
         4hIg==
X-Gm-Message-State: AFuF++klcouQGT7HTtg8/Tf1SSBNTP2a3dQrm5e/uYXSyKigPBTGEdC0
	0O39uh7spRC9z2EOedgtqI8j3MomdBbCguEK94aC2cqJ6w2oydZK7zHi9CkTP8M0
X-Gm-Gg: AYBFou1AQU9IZ8RYfcoAxasgsTwJBxZuefukwwosqr/1dpuwJOF8vxmKp0ptS+GAC5U
	7rr0N0ReCmq4b5NEgqzC/AaJFulBncYEAGqxg881Ljubpsv5qFwn+nNhqraD4d/sBa4KJzSFAY2
	/CtUNfjDm14X8u7L9LkJUMHfWhvSYbXU9vSMEEX8Oe7gR+fvQMQNcs4BNCsKm2GBG9+TAS6xSDf
	JVAJw/5HVXmluwcKc1DxuFrXeJeEYdZJW6tuHSuYkSbYbGWZUehMz4pB6tRoUN9KKgrPfpRmcH5
	Ebce/QYtFjor0qg+9EUADAMXPu8JRHBTjjDYVK53Y7CI3HJehdrxYpk/7Wyk6CgvvkwdKlg3vdN
	tiUV28viX6uvu5905fLBAP58NOBd3En83pacKzG8oKZ+pGey8gfyAzlUNQMXXwY+rFPbVjNsfdF
	cfeUsUtHoTj9s/DrY9Pbmj/vNXD4jvQv7iyXiEzxmA3J2CWvOsPE7WMO7F8vIge6B2bo73A5rtU
	q8l543GFtygcoeLWL0ni26eOMncIW3OJSOub4ysi5V7jObp3XcyIMdFaAO1H+e496AD6+4zQJRS
	DhOhNW2SSaT5oHB95K8g6I9/GTj/684OuJb/nJI7OAxdk3nTzw==
X-Received: by 2002:a17:907:7b84:b0:c29:97e6:2838 with SMTP id a640c23a62f3a-c2a15649e9amr508794166b.3.1789848765029;
        Sat, 19 Sep 2026 13:12:45 -0700 (PDT)
Received: from localhost.localdomain ([37.31.48.107])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67d81625sm1723336a12.5.2026.09.19.13.12.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 13:12:44 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Subject: [PATCH 0/3] refs: report old OIDs for batched deletions
Date: Sat, 19 Sep 2026 22:11:55 +0200
Message-Id: <20260919201158.43415-1-maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CACQ=SRHthWOLVXmY6wgknOPgpQ+oB1vV-Q0AL=mK9mXb2Xy9Nw@mail.gmail.com>
References: <CACQ=SRHthWOLVXmY6wgknOPgpQ+oB1vV-Q0AL=mK9mXb2Xy9Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This follows up on the reference-transaction bug report at [1].

The reference-transaction hook reports an all-zero update when `git branch
-d`, `git tag -d`, `git remote prune`, or `git fetch --prune` deletes a
ref. This prevents hook consumers from identifying the object that the ref
pointed to.

For branch and tag deletion, this is a regression caused by 8198907795 (use
delete_refs when deleting tags or branches, 2021-01-21). That change made
large deletions much faster by batching them, but the batch helper did not
accept the old OIDs that both callers had already resolved. The pruning paths
have the same omission.

Teach refs_delete_refs() to accept optional old OIDs, then pass the values
already available to the branch, tag, fetch, and remote callers. This keeps a
single batched transaction and does not add any ref reads.

Deleting 10,000 packed tags took a median of 0.86 seconds before this series
and 0.85 seconds after it across five runs, which is within measurement noise.

The regression tests use packed refs and cover the files and reftable
backends, distinct old OIDs, and regular and atomic fetch pruning. The full
test suite passes with DEVELOPER=1. Additional checks covered SHA-1, SHA-256,
broken and symbolic refs, and refs shadowed between loose and packed storage.

[1] https://lore.kernel.org/git/CACQ=SRGTTdQ+dHXhN6F52dBv5KxZBRfk_Em2fvmEmGJDoB6oTg@mail.gmail.com/

Maciej Ciemborowicz (3):
  refs: allow callers to supply old OIDs for batch deletion
  branch, tag: retain old OIDs in batched deletions
  fetch, remote: retain old OIDs when pruning refs

 bisect.c                         |  2 +-
 builtin/branch.c                 |  7 +++-
 builtin/fetch.c                  | 11 +++--
 builtin/remote.c                 | 33 ++++++++++++---
 builtin/tag.c                    |  7 +++-
 refs.c                           | 26 +++++++-----
 refs.h                           | 12 +++++-
 t/helper/test-ref-store.c        |  2 +-
 t/t1416-ref-transaction-hooks.sh | 70 ++++++++++++++++++++++++++++++++
 9 files changed, 144 insertions(+), 26 deletions(-)


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.39.3 (Apple Git-146)

