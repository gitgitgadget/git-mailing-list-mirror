Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445019AD51
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767196; cv=none; b=Md+W0bDHmIqKjg6+C0gDyth+4N5xSL6ZB3NRaWxTj6KG6qgTYVc8uDlMD7DdQer0ASVwrbZeCAP65/0gHFQADhwDDCeCzEJ02umMvWfiwNyVZ41z4T7JnD0I1rCJQPBIaLMZ7gjUbit5NojuFm/GtjRTwF2chTep9Lfnca/OP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767196; c=relaxed/simple;
	bh=gCl1bW6Soiyhq7iaW8FjxD8DXoKp1eBVIEg7NcM50Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaKx/EsrG0IBdrh2ESMHxTccudpmb8L0ElTUI5xdcGc2vOaT/RdMJN9alXIVM3ncipEgdkCGkrLrmqzIzwdRPJ0gwAnjXYJwxysLuI/k9HzIShUSoBkK4QCfYjNqIKPzfoRjBxjn+bxuG+1xT+AV0KoMSwsB/Auk/VUAra5GO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+iPKl73; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+iPKl73"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eab0bc74cdso22249881fa.3
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 06:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767193; x=1718371993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt/wb1T6tDU4bKkwhv2ajv8Gms0P9089s6p137lo7V0=;
        b=Q+iPKl73vCyU1ap3AcWGycjccnwmGbzQ5k58vrGC+z/MWDk+DVdVhM92Dcwa098met
         95RpNIpFwXprZjiTmqRPCPuyISsfUhCTDAZoN+oTtRtyFz52Ojlm2lGZ9F2wUACo8cld
         nezMCJlYI8XF4mhA8+ix5ZUL2so78xLobdE03IGJA66xSA8x9MGWBWafQtpWlspshjLT
         UVCBe+erYHwY6N24YZki0n06qQjtnV5ZIzWzIyIbS0U408ghLcD2qShR3hmjHMbCqlNX
         EuwS6eG+JMpXTqKPGIwFcLwqPZnKeDc+X/xdBQLk7FvaPWJW0v16JTElRUlEOnjRyW+I
         F34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767193; x=1718371993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt/wb1T6tDU4bKkwhv2ajv8Gms0P9089s6p137lo7V0=;
        b=hAnC+epPD4LPgh13gXdqgCNjGSQnM2wF1pgp/P5neY9vS57SSAhxUeHjgE7uEM2gmO
         R9axWBGVj2zIKv44mkhtOsXgSgqVjGYxmT0NHS/HKceHPDrfFpxSQMvnX63SEeLrFIgI
         opZUvuHHA+z5xypOHLgMfd8AdZd0zwap09SRC7oNLUZQdRJpMgV/K/9ZyHf9tID2Szpe
         f1XrjCNKmgME3I7ZIp6kRDxiTs/FeEj0CcVpT5qJNXYOP10A3NtI+DkKwMCBHHM4ZaRV
         bx9s4b+mdS2DuUSnVw9643wDDqzU7IJxKgD7g1NG1g6Ia4TnLDcTocCXJoB6A3XnnBLd
         9e9w==
X-Gm-Message-State: AOJu0YxaJRyrb5GnlabB633zWXxgHKjtCXjyNIYcBoW1zOSRk2Pb3PNQ
	DVgox2ZCjSp5VZyu/P77F/AwGQwUjDy4MInSYqhqsg28EnQwuz3fvrRVLOop
X-Google-Smtp-Source: AGHT+IG1RSHNbue/xbgs/J/ltqYWgerKdqd98O+WJfPSOdHYyAYLLe9VKc6IjyGPnZPSkNo99+/i3A==
X-Received: by 2002:a2e:8058:0:b0:2ea:e030:ae40 with SMTP id 38308e7fff4ca-2eae030b8e7mr12643031fa.13.1717767192619;
        Fri, 07 Jun 2024 06:33:12 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2340f6sm2764167a12.90.2024.06.07.06.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:33:12 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 6/7] reftable: pick either 'oid' or 'target' for new updates
Date: Fri,  7 Jun 2024 15:33:03 +0200
Message-ID: <20240607133304.2333280-7-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240607133304.2333280-1-knayak@gitlab.com>
References: <20240605102958.716432-1-knayak@gitlab.com>
 <20240607133304.2333280-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

When creating a reference transaction update, we can provide the old/new
oid/target for the update. We have checks in place to ensure that for
each old/new, either oid or target is set and not both.

In the reftable backend, when dealing with updates without the
`REF_NO_DEREF` flag, we don't selectively propagate data as needed.
Since there are no active users of the path, this is not caught. As we
want to introduce the 'symref-update' command in the upcoming commit,
which would use this flow, correct it.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index c66ab9ecd8..1c46fc87f8 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -895,8 +895,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 */
 				new_update = ref_transaction_add_update(
 					transaction, referent.buf, new_flags,
-					&u->new_oid, &u->old_oid, u->new_target,
-					u->old_target, u->msg);
+					u->new_target ? NULL : &u->new_oid,
+					u->old_target ? NULL : &u->old_oid,
+					u->new_target, u->old_target, u->msg);
 
 				new_update->parent_update = u;
 
-- 
2.43.GIT

