Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186823507B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928341; cv=none; b=UEV6MIaWRnc6GIWuXyNJtm4QDzmRAZTceFUBHjpgtrPUQeGzxHfmdbAvvEl4KZ2Hhoy4zMdvzWzWSQRcIQVNimaGyb1U3EZKGAM/cGxrBrnLOn431MfkTjjabllc2pSb1i+Q20XMX5aRNJ3vV0z89LeMSl8R3YTTRDZDahfuSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928341; c=relaxed/simple;
	bh=w57RVmJ5oX7PCvjD45A5/hOZdJAvjVbXCkBm4Fy71xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYq4nR6obdLTJIpc0PUlh6i9dStv9tjsDSJCltEBlfcWoUycHUvNfJStnnw0r+jW+rG0pWAd1HWGbvkYyAWNSAMbKgZWHuu9/1Giv/14rU/i2X6hceq2qJQRG1vP1sTVX8ZFba+zfN1hW7313V9EC55klKsvJS5jKGCgG/TOqsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY/aldFY; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY/aldFY"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d7e565c877so2580967a34.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 20:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774928339; x=1775533139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7MrtCJUbYLbIrPvXE7XA7kdDahr+DhjcmhjinLwL7Q=;
        b=TY/aldFY3fjEEpY1WXIB9gEG3oC4srm5BjCCUAsV/PDiPu38OvBuSVvHB/Y/YJJujO
         fJbts+Id9sL60jtzzUhA8GtUS2t16hu0Tlo83sB3SmYcnHJI2m8ya+EnxrinkMrNd76D
         P3hm+LpE/rDBoWHr+xPrxYd06TX9dxDNW3F6s0sTL9dujFuwk0Y2BN66fBnY8KeLAnmR
         O/sNBg7YijsoCzzits7jTTAjjH8zPeQ+lKf9xHlhkkd+DQMLXCyRgUyV+QeCXVCiojgB
         Gw04b/miROBF8zcaCw75Wjx5hOG32pgwLMJI4B6bRSGRiGBZXnPWdN7r4uYaP1iXBeXf
         6fKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774928339; x=1775533139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7MrtCJUbYLbIrPvXE7XA7kdDahr+DhjcmhjinLwL7Q=;
        b=Y1ioXFxW42z3BR817nBo+FWABG8d2bC3px6++tvGLBSL9cI5zmWrYXJA0SZ9fed731
         rAQhGgwGBZj0Rv0viMZ4eghPTErn+ImpaCP2eOUB0EnNhr+5oJtc419DsP2R44zgrRJV
         q6/IXom2Gno8KHITbMXmP/hBv5BES+9ntFfEFQogVig6UX/TPZ91xYcCAcP/q0+n0VWq
         1ctoWZ/oaSFf/ZWajdXFhqPZrrTY5GG3tTplyxYe3LZwRsqAqYH4bBS/suNjMX51mDCh
         a6dJQcd1kzMT+qAmMZIfRnsEbHzuaLtAcGNvMk5ERiuHr7NgE2uG8I/Cc8WZyB6wTxn9
         V1GA==
X-Gm-Message-State: AOJu0YwzZVNTUSSPR1/zwLZNEa3JQeXfxrKGMw2PzlB4omyBvt63B4ZV
	jdTanYCxHXi649VSYAxrwVPTSuyoFGTSPoUvhuI2CUFvW9k0WDWNqOeKYzO0Xw==
X-Gm-Gg: ATEYQzxakTPsV7G2pIPF012ijUjqz/uIbYX1mdZdZFjzyZUERi8vL7VfvxGtN+M752X
	txYKvuDcPSnIhzH9c1H1mqCZ7pMN39atEAQ7DVy2wkjcvrHZmjTdxS+S70oR6NjwzDGbc5OcQJc
	TnZakUS4oUNxpFsLdTOlxJUKz9GP9IUanL3dvfI+DJJrqarCIbecMLjIqQQp5kjjgZLGspP8sGE
	cIZLES049IKbTaSp5wooTTc8zpcNgHTqroLisHF8EJ31GDuLlhWm6kEDN6/cUTFiFY8wOQ8DjXr
	LC5ehHcifg5gQb9m9ENocxuABiQ+m6PBkFjMWvSVUGcz5idfXmbnLIWI0A0/02nmCN+R1gw/B3G
	0PjlMaOezl1zBxGAxHVgPQ8w4nfPR8QMGnJUJwzGAewYCnWKV0gUcjL3Rt8cRKmTJIpuxgNdpB+
	N5MRIGhomlUp+US/1c+FyAopMHufVslkM=
X-Received: by 2002:a05:6830:4ac9:b0:7d9:b4dd:c34a with SMTP id 46e09a7af769-7d9fad7013amr9455177a34.7.1774928338940;
        Mon, 30 Mar 2026 20:38:58 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a3b2e37sm7494665a34.10.2026.03.30.20.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:38:58 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/6] odb: add write operation to ODB transaction interface
Date: Mon, 30 Mar 2026 22:38:29 -0500
Message-ID: <20260331033835.2863514-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This series lays the groundwork for introducing write operations to the
ODB transaction interface. The eventual goal is for all object writes
performed within a transaction to go through this interface explicitly,
rather than implicitly relying on the transaction to reconfigure ODB
sources so that writes are redirected to a temporary location.

For now, only `odb_transaction_write_object_stream()` is implemented and
wires up the existing logic for streaming "large" blobs directly into a
packfile as part of the transaction.

Most of the patches are structural refactorings to enable this, but
patch 4 introduces a behavioral change in how packfiles that would
exceed "pack.packSizeLimit" are handled.

Thanks,
-Justin

Justin Tobler (6):
  odb: split `struct odb_transaction` into separate header
  odb/transaction: use pluggable `begin_transaction()`
  object-file: remove flags from transaction packfile writes
  object-file: avoid fd seekback by checking object size upfront
  object-file: generalize packfile writes to use odb_write_stream
  odb/transaction: make `write_object_stream()` pluggable

 Makefile                 |   1 +
 builtin/add.c            |   1 +
 builtin/unpack-objects.c |   1 +
 builtin/update-index.c   |   1 +
 cache-tree.c             |   1 +
 meson.build              |   1 +
 object-file.c            | 249 +++++++++++++++++++++------------------
 odb.c                    |  25 ----
 odb.h                    |  31 -----
 odb/transaction.c        |  35 ++++++
 odb/transaction.h        |  57 +++++++++
 read-cache.c             |   1 +
 12 files changed, 234 insertions(+), 170 deletions(-)
 create mode 100644 odb/transaction.c
 create mode 100644 odb/transaction.h


base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.53.0.381.g628a66ccf6

