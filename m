Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829C2222C3
	for <git@vger.kernel.org>; Wed, 14 May 2025 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213440; cv=none; b=RxU6kHj/IevnmQ0eR2Z8IYmDOyntHqsr57F3nv82nKgb6o6HUvEOwuTgaJ/LHDmA7A9s9UXS0Fa04+vQsDy+ZdS8iAGt9oPs9IK2md4HtRX9Vi4khLq7Leia+jF4en07SPdC9np6sxH+rrj0/HaH7xPd7ZlkUa0/okBCNqIqArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213440; c=relaxed/simple;
	bh=9nCtTrZmffBSba/dP/ItEcMHU+SeoM1Eq2yld/cblDA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UYwa/rgjqg/ZXUXp8qlzbbeDIICIbDoR370/KXfYtY6/n3Jo40I5jQANHXhRFVFZvpitR+kH2x/cKw102t5rzGqVGVoPnezPf0R0ylkzUzk5pLf1aS35sp/8ry8xECfZi03X8PUndIXa8MbfDAQUtPOEgba2tDs+3yfl1i40cuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwfpLvar; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwfpLvar"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0b308856fso4858148f8f.2
        for <git@vger.kernel.org>; Wed, 14 May 2025 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747213436; x=1747818236; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88Qexm4Kzt/z1vK8CkhjAqWLo7l6xpmI7ElSlqXT8bg=;
        b=OwfpLvar9/ryn+pdTAVBtu4p0ry6pAWkdeKaefaUfkzRRoUP4OFH9qq/Su2bbaigK3
         815iLugNjiOW+Jn4OAAB9YwwTkYMSflzXDGjyONZeDVccmM86X8Mz8zkoFywVdn7V4MC
         IQp61KEkoCl4FiEgaXhrAHpF1C8D9RF6fY47UuM90joQ2hyVlwfSunavmiHjpQWyRBNI
         N+q6134INJzB1/NcI2UkfjsGM8ZIsoCy4rWXhyqrxxiYHe+zDK2foi94Gt8bHnXv6LDq
         loiTZDuJqcLRVwzPm8qo5ZZcqm6XHjuD9a0wdX6YgyKdf+qK4R2plx6m7EXcLSHSOsU8
         0x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747213436; x=1747818236;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88Qexm4Kzt/z1vK8CkhjAqWLo7l6xpmI7ElSlqXT8bg=;
        b=H41EfYZYlISMkzneZk+4aeFSjgXbdFwh2qVseEac0IqWQlGa0ajQOaDfjPjiIzp3nZ
         sUftir1WMOns+mVzOKDSVFwt5XJjJpAfK/xTejXTQ+ctHnz7d5VUWAmgN1rta/u8g0iX
         kt3L8yZq4O34MHP1lLEh0CvU+98ulm0v8KJbMKF1l7GFLyv4eKs7k/hS3uaMfYEo+BZt
         6HAWn+i4i42tAWQ89UDqNrbRYPgmu4P4nDwhnJg7vKAss7qo9EdVHmimyspiSVAJV6OR
         ihiVtLH8qZVhYbgYE9nqNNPy6WaWL4JV924CxtPpiSBq/Rc8UIw/PEaMWf+7x8W3hkl+
         TRJQ==
X-Gm-Message-State: AOJu0Yx5qwH23uD6ZVyMSxDV7kwmiOqHqF4d0DWT3uXCTZ4eJcEqWt91
	/2PWVRWaj8z0kDU9W6mHqFjMbOk0qYVbW32dQDbg6HttqR+h5L1XoJUiqHaY
X-Gm-Gg: ASbGncuniKc8I3mPHAoTrcmie2f/13s12h3+f7lnlaDEMsau2MUkhRNE8rE7YKfw5ac
	Go0WmZEdmSGh4N9ES2fAtkh1VTJsjc5YKaoMFwgNXPcVfIHmcoCBO35/ZrlF+s6ddMtC49auZVq
	iv13egbXgrh/U74wYipbxcEMt62gFPA5SSMBWclmPJB+sGA8daMuHCpROBFhyJWIqlXa91eL3PG
	VPFYfvRqqr2n3AtZarDz2zpYTDVY8j8GqAj+tvxglrJsLujjuCkbVQDlks1iHue1f/SddYE16Tu
	9r0puZlCdKFiNTyhKVSYwpEmEVFaFx8dj01L1IIvMqbZghog4oohWAkvmA==
X-Google-Smtp-Source: AGHT+IHXfAG/XtyxuIM8cjkCMsiYAedwnTetBPDYY866a8YxGvswSf5+mvt+7Rx3YWowe4ngV5X6xA==
X-Received: by 2002:adf:e890:0:b0:391:139f:61af with SMTP id ffacd0b85a97d-3a3496c371cmr1595234f8f.32.1747213436364;
        Wed, 14 May 2025 02:03:56 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:768c:74a5:aa9f:b39e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5b9sm19084461f8f.91.2025.05.14.02.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 02:03:56 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/3] fetch/receive: use batched reference updates
Date: Wed, 14 May 2025 11:03:46 +0200
Message-Id: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJcJGgC/x3NTQqDMBBA4atI1h3IT1XsVYqLaZzoQIkhM5aCe
 PeGLt/me6cRqkxiHt1pKn1YeM8t3K0zccO8EvDS2njre3v3AXrr4CgLKsHKCok0buBAdziEoGB
 VxjdoxSwYtWkCY3oNQwhTonEyDS6VEn//0+d8XT+HXFqWhAAAAA==
X-Change-ID: 20250423-501-update-git-fetch-1-to-use-partial-transactions-7fb66339fe79
To: git@vger.kernel.org
Cc: toon@iotcl.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2719; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=9nCtTrZmffBSba/dP/ItEcMHU+SeoM1Eq2yld/cblDA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgkXHp9ngCUSRyloxfXXq9sx6/+xlLWs+7l2
 awlRmgRIw7maokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoJFx6AAoJED7VnySO
 Rox/QZQL/3hqbbO/p08zY64XZJj0KQYAJXK2pKBGWfESv7qk8+vs5lP5x9oQq952LEVGrBswISy
 LPNk6cruhn/15hhAsC4U9kZX4yp8mBWBB0ErakgXwTPoPCKdK3vTAqiSi6dw5KYPARsyPdYI9HX
 6QsIo6jofh+iSCcU9o3EidbZj+snMPAf08iTh3pObiC8YBmHWWIPAE7A7nf1PN6AjAvaObjBtQx
 hHKj5qkA9Iq2JaUQt6ZTX4dmpLJ/G0TBylIgwn58LPSotZHBpdAEGeWDBJBea3erjH+9API2qqR
 JyzN9lLy6094/RHGgQmrXjzZ7GC1NQLIkdzRI2C4b6ZxOr4HqzKsCCgTfMD21KwCUp5jDogczbv
 izNMNaI0yEWVgAGE51Ffil0RVs1DAPe9BM4yFX8lpX6gUUtLLMGbqctojqt+6odZBE+x5NzRNGZ
 mBxrPI7SOpjQLGZMxyXB4p73s7O4VrMX5wIYBivdWUNCru9IzEFh/uHmrlXy2nzN0YbBdSABsI5
 q4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The git-fetch(1) and git-receive-pack(1) commands update references as
part of the flow. Each reference update is treated as a single entity
and a transaction is created for each update.

This can be really slow, specifically in reference backends where there
are optimizations which ensure a single transaction with 'N' reference
update perform much faster than 'N' individual transactions. Also having
'N' individual transactions has buildup and teardown costs. These costs
add up in repositories with a large number of references.

Also specifically in the reftable backend, 'N' individual transactions
would also trigger auto-compaction for every transaction.

The reasoning for using individual transactions is because we want to
allow partial updates of references in these commands. Using a single
transaction would be an all-or-nothing scenario.

Recently we introduced an in-between solution called batched reference
updates in 23fc8e4f61 (refs: implement batch reference update support,
2025-04-08). This allows us to batch a set of reference updates, where
individual updates can pass/fail without affecting the batch.

This patch series, modifies both 'git-fetch(1)' and
'git-receive-pack(1)' to use this mechanism. With this, we see a
significant performance boost:

+---------------------+---------------+------------------+
|                     | files backend | reftable backend |
+---------------------+---------------+------------------+
| git-fetch(1)        | 1.25x         | 22x              |
| git-receive-pack(1) | 1.21x         | 18x              |
+---------------------+---------------+------------------+

The first and third patch handle the changes for 'git-fetch(1)' and
'git-receive-pack(1)' respectively. The second patch fixes a small
memory leak I encountered while working on this series.

This is based on top of master: 7a1d2bd0a5 (Merge branch 'master' of
https://github.com/j6t/gitk, 2025-05-09). There were no conflicts 
observed with next or seen.

---
 builtin/fetch.c                  | 119 +++++++++++++++++++++------------------
 builtin/receive-pack.c           |  88 +++++++++++++++++++++++------
 send-pack.c                      |   7 +++
 t/t1416-ref-transaction-hooks.sh |   2 -
 t/t5408-send-pack-stdin.sh       |  14 ++++-
 5 files changed, 155 insertions(+), 75 deletions(-)

Karthik Nayak (3):
      fetch: use batched reference updates
      send-pack: fix memory leak around duplicate refs
      receive-pack: use batched reference updates



base-commit: 7a1d2bd0a596f42a8a7a68d55577967bb454fec0
change-id: 20250423-501-update-git-fetch-1-to-use-partial-transactions-7fb66339fe79

Thanks
- Karthik

