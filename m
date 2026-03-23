Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7236EAAE
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253149; cv=none; b=NA/i2Nek/ICJJBvlCv9sdfaAXn8UmE6iLhL1BAbxrVXw2Sb/jtXhFNrHa2hJykgfqaKkWl5EtW1iUZr8ozReYUjC2bjnufq7AHQyusm8fsfbOCe9XspGy7NsewI6vYIfY5d/VHdPq4R0BmL42Oe9vQdxEjzTagNKl6LE7EbkYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253149; c=relaxed/simple;
	bh=QghBcUh6xpsJxf8kmrsiT6roP2zAMXiB0rxVYvHtUQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbbfHjhbYkR9YNxcDBmCw5ljYJJmNhBHNbF5iQ1u2Fxf3dey8ierkH5bdCR9E/w4Uj8HZpswwl1qH7S5lXI81swM6L3Y1iGa/PWfrqLRlahaJ2hjMNR6hk+A2FExNP1ZeQgMGik/CZdOdpKJWa0RhOmtC2JRl5Q5saEZXFVpg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNW3W9Zp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNW3W9Zp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4870206f73bso13664545e9.3
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253145; x=1774857945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0OH84UrsISagO3LohWjBkCJtfqG18WD+AkEebAW2Bk=;
        b=mNW3W9ZpupfqSfQ1sUqEeEpK+OcY4pMdkIW8l24qScJtlgzi/B/v/rRgGpfr7B1Du6
         +sEKHDW0DHCOOoVBBZiOkZ+NX+vS1VTzZYgtnKFgnuNMlog1kpao9oM1n0oUupIDA374
         Yp8/FSc+kx+Hq4ctDtJUjD0/+I+x31qVUTHZOFtcYoYPLZxwwaaA5Aq3/PBA5ofscj08
         0Tvk1MlqVDLxNfz5zbHbXU/XyvKmtEMplACVapm9orJzYgNRzTL09e6KCfo8Wz3HJdr+
         3wqWQCtapxf2OJYchMpBPDyzzvNO3RoTv2DdCd1qShVY29OX9sRM3R8BiwlZRHs+U5ba
         x6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253145; x=1774857945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o0OH84UrsISagO3LohWjBkCJtfqG18WD+AkEebAW2Bk=;
        b=Z07T6Nf1fFQ1kSa+FiNBY+LAPC6qocMcSQBTr1w90MqMDmY+49Ga/PXlgDP6X1mHhh
         bJ/MK/DGkj0agdx7a6RjUHzoTgSYPCAi5xPZAtmNLkh7a967ynfea0DM2wTrtni+uPiw
         WBYmeRII8EPK9wtiIJWiWNsEt82/foyG4KlkkQH6v1XbNqbF2lEl2zfrzG+BB8O/ULa0
         Uq16smMbAAZM+B1DGqAHK0Ir165W4JIEhWZrP00lvUaIjJ5kOOVPGAWR6yYe5OFuunC5
         UcLnIoZnFopOd4Pz0HOEnjPdHj2EQGVhSM5/qZ5zRVwmxFG7M+GFxlgBbEIPU5FHitk9
         Rdtg==
X-Gm-Message-State: AOJu0Yz/9QXP6psi5zilh7UX6Tl8tqZdxdkTP9424FEI/j9UHwNRyavC
	8SFWXaBfAyRAaAA9sEGmiR+YfVJ/1FP18PyH7smqn1lx50eMp6eUupQk9XD4vg==
X-Gm-Gg: ATEYQzxlkYUZMnZ+OSnx3/K20y7yTTUs2R18DyyIfxlseq6vM47tsxdGOYkCp4p4Zi0
	ADeCI62XFv1vbskU+nV4JgKjjU2qDo6xZGo6l3I49qaY1cBBxhGlQ5IU6OKrwILiCuMkGUhuqIa
	SqwV4WufYbGhMHszBSXRdBqvoAJFYel9n7EQAdd9j3XI/UvDcYc4dYyk25hSlWhLa+qvbpw2MTH
	NMzskVcn2eJkl2S84Fg5xKLHt0BDEwVm2K0oIUl0Zb0fQuzMQ1MQMHDAZCZbwipCfr5CR2hOHpQ
	43UYz+WnTgw2jwLnq4sEA/8FqoqMq2/ig037epGSQnzYoq3iedWIZ16RAohzA1uyRPS0U5XJ0T7
	q8xvmIEImsUF9AX3+jA3QK95Tfyi5veFqEjbE6X+YawTJHYnts1+h73ThsqzP9ke5Ctgnnf2Cvp
	+43gtO+qZzFn/fvEDa2EzncyVJvsXGcKuq00+/x1w0TSfW/s93o5xETBgighfd5rBBBu1pf7oPq
	sxGXOVOqxpoPc1ryMCAKphZWRjBeNSNQ8dibHKi7x9CKhflOg==
X-Received: by 2002:a05:600c:348c:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-486fee1af1cmr135131305e9.25.1774253144790;
        Mon, 23 Mar 2026 01:05:44 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:44 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/16] promisor-remote: clarify that a remote is ignored
Date: Mon, 23 Mar 2026 09:05:07 +0100
Message-ID: <20260323080520.887550-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In should_accept_remote() when a remote is ignored, we might tell users
why it is ignored in a warning, but we don't tell them that the remote
is actually ignored.

Let's clarify that, so users have a better idea of what's actually
happening.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 3f8aeee787..f5c4d41155 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -660,15 +660,16 @@ static int should_accept_remote(enum accept_promisor accept,
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
 
 	if (!remote_url || !*remote_url) {
-		warning(_("no or empty URL advertised for remote '%s'"), remote_name);
+		warning(_("no or empty URL advertised for remote '%s', "
+			  "ignoring this remote"), remote_name);
 		return 0;
 	}
 
 	if (!strcmp(p->url, remote_url))
 		return all_fields_match(advertised, config_info, 0);
 
-	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
-		remote_name, p->url, remote_url);
+	warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
+		  "ignoring this remote"), remote_name, p->url, remote_url);
 
 	return 0;
 }
-- 
2.53.0.625.g20f70b52bb

