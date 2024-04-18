Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972317AD6A
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465665; cv=none; b=Qkeeq8/LRmWgtZJJXPLanYG2OIXA8AVFOC6ygflQHd/WSdMKlcH4H1mKZwzxTusD2qRNqXTEhTUvt9gdCh61fXw229eF6MbKO0xgd8GI60nr9EkmsaIeR5qwkpFqtSPbryGx+ev2Fbrim0/Xsq9gPCQGRPZ/xDrJM0AbEkpz7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465665; c=relaxed/simple;
	bh=KmYl7+UI/nO5L3tk9CfRF6t1vwLjsqnrYNB/owRSvOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKJ/bVmNyoSisRdKtM1Sd51fGKse18BLcoMBvAOykSH5z1GvYQ6+aqIz8g9m52GH740IzhnLfG8sBq3O3W4gi5/IfaIVtU6Zwv/eAc5RGARebHcaM9BQKe8osEINksrZbDuib3+Z7XvZtZ2m5XUWA8ZbIPVuhzFgf/NKWiQ82U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMoXRMYh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMoXRMYh"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-417e327773cso13633715e9.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713465661; x=1714070461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv4407WDfigOf9gw1BvYNNViNbgPAVN4FN92zW5jSo4=;
        b=bMoXRMYhh7/NvktvzkZIN6W0UzXtmtqwqnyYBBhJP5hIiI81Ckyn59rnQfspE3QwAO
         TyWewVysbbuUf/78db9yWj6QfCHLJlhqmS+eKP5Go9+e4m9N+jmigtHYamW3qhyMFF40
         u/lQUnGVBy5RGKVLs8bmTVBwB/HI1pD6kYir8/idctCmuv/LyjbwBNrlNc9vk0CpoDFc
         IuYnjaIovk4mnJUyq3HXaPve8FkrePcK90555I2nE062H3eZzITSOic4cZJ37r4P1jhV
         ZkkRdOaLEjtgBl53Dq0ZoOTXjZ+8Hcxfs0FgTALT0vCCCIA6iZnpV0dF7Di8HfAyT/An
         sLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465661; x=1714070461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jv4407WDfigOf9gw1BvYNNViNbgPAVN4FN92zW5jSo4=;
        b=r7KNksU2D0fJrSegOPKWh1pW5yuYSwNd2Gz98OevoFKZihmju+bEj/SMW1z8HSavHx
         uxr8dgQrXhgJJ7/8elBl0sfn+p/1KjI9QxJmm5itFQc651/xt911tZtaiuNqJtwSEiU3
         UUtDXhlTaC4CiQDKp2vainYP9+m5PPj3IKaiVEWIEdlf2clFj3mNei6qkW6pByEeD1SC
         h4BlOpwKxzd4np+PIbvNq7VONaUqtuYaAfybE8nUCp/OzneJNFqYPtVAesclK4HavJwk
         dW7Bv2zrUtyfZwUorSKpNvl3Mn7yFdfgSE1Vry/AmvEnFQ1iGTDLexGXOuyxNmcwDxCw
         yi5w==
X-Gm-Message-State: AOJu0YzWUYf0PNYtCtytAB2GVymvuHvJ+exc83E18KEBmRvAf6DGJVc7
	F3BZs9OP0lde1P9S/WmAv8JAMINokPzspRVsofcBCcoz9+4kmPma94N21Q==
X-Google-Smtp-Source: AGHT+IFTo3azw34Xl3yICwXz5WXEUpmzNg2UmHojDuBIcXWA6THTD3HPFdLdRo0tcIwasqnbCuggWw==
X-Received: by 2002:a05:600c:444e:b0:417:f537:42a8 with SMTP id v14-20020a05600c444e00b00417f53742a8mr2289787wmn.20.1713465661290;
        Thu, 18 Apr 2024 11:41:01 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00417f700eaeasm3653670wmo.22.2024.04.18.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:41:00 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/4] upload-pack: support a missing-action 
Date: Thu, 18 Apr 2024 20:40:39 +0200
Message-ID: <20240418184043.2900955-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.44.0.655.g111bceeb19
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`git pack-objects` already supports a `--missing=<missing-action>`
option, so that it can avoid erroring out if some objects aren't
available.

It is interesting to have `git upload-pack` support a similar way to
avoid sending some objects in case they aren't available on the
server.

For example, in case both the server and the client are using a
separate promisor remote that contain some objects, it can be better
if the server doesn't try to send such objects back to the client, but
instead let the client get those objects separately from the promisor
remote. (The client needs to have the separate promisor remote
configured, for that to work.)

Another example could be a server where some objects have been
corrupted or deleted. It could still be useful for clients who could
get those objects from another source, like perhaps a different
client, to be able to fetch or clone from the server.

As `git rev-list` also supports a `--missing=<missing-action>` option,
the first 3 patches in this series are about refactoring related code
from both `git rev-list` and `git pack-objects` into new
"missing.{c,h}" files. Patch 4/4 then adds a new
`uploadpack.missingAction` configuration variable.

Christian Couder (4):
  rev-list: refactor --missing=<missing-action>
  missing: support rejecting --missing=print
  pack-objects: use the missing action API
  upload-pack: allow configuring a missing-action

 Documentation/config/uploadpack.txt |   9 ++
 Makefile                            |   1 +
 builtin/pack-objects.c              |  46 +++++-----
 builtin/rev-list.c                  |  41 ++-------
 missing.c                           |  42 ++++++++++
 missing.h                           |  20 +++++
 t/t5706-upload-pack-missing.sh      | 125 ++++++++++++++++++++++++++++
 upload-pack.c                       |  19 +++++
 8 files changed, 244 insertions(+), 59 deletions(-)
 create mode 100644 missing.c
 create mode 100644 missing.h
 create mode 100755 t/t5706-upload-pack-missing.sh

-- 
2.44.0.655.g111bceeb19

