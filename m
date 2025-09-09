Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4A30504D
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445109; cv=none; b=p9o8y9BZEojW1BZhFi/zNmbh2Z+SnmzQ6v3ELNpb38zAFOL03yn+i8gSdFs5LYN31c8m0oPQ3uST/lUtsDjcTvCXkrDmjceUUx70hq4sXxVNJG9np3s6SwjAQIbiRp8Pt1y5iN8fswJYh3p3JM9ImFUAJfRWXV96x5SbfsaRyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445109; c=relaxed/simple;
	bh=l4qoMHEQ4jbE0a2SatttTu4ccG3qdR27KdsAgRnZUK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SM1hX5bj1AK/3l9/4IGDEH1ika1TZ7YErqIcnIX9iMoakHojhMuXwnERcrgEGmejcKMxILE2j9vFojGGzllezKKHs+0QP5Q28bXFT9i4PDBdrRTpCVwggucSR38SCjYyy7guLaLP2pbe09ZvLemLgKKtxnPJvYaLVGPJi8AJk00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URY7n/O8; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URY7n/O8"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74d3389cb5eso2658600a34.2
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757445107; x=1758049907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TEQQ05p9P87UCzOTgFJH/R7TSN8R/U99cjmJBJ8zw4E=;
        b=URY7n/O8kMx6QmN2KHuASgKWpsPSTu8vAIiqaRw1AgRyAA2MEm/VN07lBvPf9E9teS
         o74Nc1GXcmeVMnqFjeqiNrkc1ruHGwiVu5cMwehJwj/yHIPCqX3E9tKEEpw9GbXmbNNg
         9JhjWFaWnYc6QE+KFOjbQAMULCbl0dzzUZJOg3dlmNfpLthVoBWpJGZ2qFTGCz+vdM8H
         yRX/BA8ONT3HctwR/oZV8bO9IqBaV7Tm+YH08ObADB1oaQs/l4+nTox93Fcc/VUrc0Bu
         9+a/W93pt/lsopyp8qp0J+onjgXBQzpy3RXvJkjHaIiLZBxhwNFP2LBWSDamEkNFOwj2
         nz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445107; x=1758049907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEQQ05p9P87UCzOTgFJH/R7TSN8R/U99cjmJBJ8zw4E=;
        b=BMzZHnei/cd/Tx9hP7Q/g2D9i/ALMY4taKcfVy++K5G43bl0s5vuKdgSqc+qw0tTSY
         EoQ6ahKbXTWUSvXp2I0IAmQ5m1z28Ph618DhFkI2+7gD+phhhSi4mUKHgciKRA6TJddR
         EPiRSjxpgMGEb8Xutqhbi+RxZOKwirLJTxegsNUwuyYbbHR+S/8IzkMSIb38WfY5z/BB
         Zyn2gmksDeoad39AzszPgAmW96o1Taj0sq52F4jhBAR70y8tDmYfuBvrKb6g4wi+rqlK
         d9CXaFUoWanbw7VImQww0Uf0auCDy8PnqqN2d8Xfd/6tOBSFwn5QXTmUr7DGLHYJmxOS
         bBog==
X-Gm-Message-State: AOJu0YxYB/Mn2gojOMSYl3aYCOZUgjM0sV63JKoYaRn+ByD4EmGt8zyD
	Qt0pEg3iByO6lUMpXsYdfyWcnQsV1NvPi8uR96dGE4hnwB2jAi4U719OblaHIg==
X-Gm-Gg: ASbGnctGkcrTrThg7QzDc1ZoyH7jKwXCaBV1Tq/C7EJlUDHG2YyWlsC7nqPF4MjqSi4
	GfYdGrhU0nhxOLhqQw+S3sx3RgGfm8kDO36Ms2JmAW3ICCJvAw0n4tPTIfeary1ZLu/PvD6o1Pz
	lrvQmAtGhGRf2CTvYgEQOV9ZzqyesbGEdRwuixhCgh/t4YfQa14FGRejQgRSX3VON1NzKR0HgmX
	OV45uwQJNk1Lcl0EncVHmWCGJTROdvb593u9NoSyxSZh2LwncrWFtvOLiQI0ug8cleZjiTKE0z3
	G0hUA0mjL7itB8v4dGU4EufEfZGiNUUy48q/vHwojKkyuLL3KKX5yAKHhO/MBVgjy7dJITioOoO
	Ti9/F0LLK+spIXWGiSaGcwLjExSgIy3I=
X-Google-Smtp-Source: AGHT+IG6DcE/NEiVCixtKYCyxQuFwUVCySuvN+KkpkXLqTnUI1g0cdpGdH+UaLlE6fmSAFJ+bDjuHg==
X-Received: by 2002:a05:6830:3592:b0:745:5123:c53c with SMTP id 46e09a7af769-74c77d50c82mr5432515a34.32.1757445106649;
        Tue, 09 Sep 2025 12:11:46 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74cc5a69b95sm3062627a34.39.2025.09.09.12.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 12:11:46 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/6] odb: add transaction interfaces to ODB subsystem
Date: Tue,  9 Sep 2025 14:11:28 -0500
Message-ID: <20250909191134.555689-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This series is a followup to [1] and continues iterating on the ODB
transaction interfaces.

The bulk-checkin subsystem provides an interface to manage ODB
transactions. Apart from {begin,end}_odb_transaction(), these functions
are only used by the object-file subsystem to manage aspects of a
transaction implementation specific to the files object source.

In a pluggable object database future where we could have different
types of object database sources, transaction handling will have to be
implemented separately per source. Thus, the primary focus of this
series is to simplify the existing ODB transaction interface and provide
a means to manage transactions via the ODB subsystem in an object source
agnostic manner eventually.

This series is built on top of 4975ec3473b (The seventh batch,
2025-09-08) with jt/de-global-bulk-checkin merged into it at ddc0b56ad77
(bulk-checkin: use repository variable from transaction, 2025-08-22).

Thanks,
-Justin

[1]: <20250820225531.1212935-1-jltobler@gmail.com>

Justin Tobler (6):
  bulk-checkin: remove ODB transaction nesting
  builtin/update-index: end ODB transaction when --verbose is specified
  bulk-checkin: drop flush_odb_transaction()
  object-file: relocate ODB transaction code
  object-file: update naming from bulk-checkin
  odb: add transaction interface

 Makefile                 |   1 -
 builtin/add.c            |   7 +-
 builtin/unpack-objects.c |   5 +-
 builtin/update-index.c   |  30 +--
 bulk-checkin.c           | 403 ---------------------------------------
 bulk-checkin.h           |  61 ------
 cache-tree.c             |  13 +-
 meson.build              |   1 -
 object-file.c            | 400 +++++++++++++++++++++++++++++++++++++-
 object-file.h            |  17 ++
 odb.c                    |  10 +
 odb.h                    |   3 +
 read-cache.c             |  11 +-
 13 files changed, 461 insertions(+), 501 deletions(-)
 delete mode 100644 bulk-checkin.c
 delete mode 100644 bulk-checkin.h

-- 
2.51.0.193.g4975ec3473b

