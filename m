Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783150;
	b=lgALUMeVX5q4v1Euq41UAtLVRlgD6IzXj87pzwJJGukutKpamxyaW4YKT2h6LSin+cHw
	 fExmOZWtRaMlL2jMihe6sZpt/CqYM2EFsl4ASI527i+4RgnLtdpIJVikYokQYzbKVWWdh
	 hNnukifC9/pWEIZnfvAyr9lwEIxSir0dDohtULgCV95BjODhI6z4P20bQp4/qFLe/QRey
	 wZasVb88VdOjYKlySNs3PSRNk3ZpXxWYu4UygpWObHjMRq3z3yUV6UlKZelfsykgwXxk9
	 no/MUgLs8IvNeIJkPeePIlKvlMu006zLq0nLYgprAVciWfhAert/H5MuhsijL24Em6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9fJgyYinLO3SDV33CY1k3dkHQVbLQb4nH08/5fnPGQ4=;
	b=LVD9rDGXuNRz4mjx9FoKZ87pQU4/oqsyZtKrpEJS7c4MzmmQN30noA5Lkee4s9vPGSRF
	 4l6XGFf1DKuY6Dr/PMKKzOTd/KjM/pC/0IGQpoAwhWBGDn15eTiUnJdxIFQbPnN9GUGVG
	 LDgegIeUjZSsR76OSj6YNx8hWAAaH1mSTDIGIBpFT8DJwG5spCvO4RF/e0lSXgXpldWtm
	 2wqv0gmRWXFb1SnNtlMBsPQ9W8hP7SRu4RyAekTpQfbZJ9LWJgL/hbjhdWHGh+7QXqIp2
	 3vpvKIZqeRT/tz9Wzr3MhGVJeEZy8saq+QYCMv4tu1XURsUXflLv4Lsr3RfQPTCrJvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xYfoU7MK;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E853606A33D
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 09:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E853606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xYfoU7MK
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a215e64962so4167395e9.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 01:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793783148; x=1794387948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9fJgyYinLO3SDV33CY1k3dkHQVbLQb4nH08/5fnPGQ4=;
        b=xYfoU7MKl+D6+oylo2Fo1JTRGV42iscn2AvWTkFQ/EeDJCOsIhGZudtOULrluti03V
         Ff+pWneB4Lwswwg7OkZ4Aa8TIxy1oCW94rMq6g2tOVCDILBsguEFTtc5WrovHf/hIe/H
         SaNTu7NKXNXD+/0fdu7FmFRQtsePg8Ine2h+Xy8DzXISP7wt7PTFFmro+oNlhf6zvzQL
         iWsKVBwiyXOTcy6iYcKtKcR4htigFO4fEYcS5PckIsXbGse3OnytmopmaRfsG/PXNOTD
         wIQxZocbzDltIAbadNXeoCoJMK2S6MQBjRUyzMTRdTuLHAX8dbJoR7ffylEaZ30GN/6G
         Qw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783148; x=1794387948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9fJgyYinLO3SDV33CY1k3dkHQVbLQb4nH08/5fnPGQ4=;
        b=UP4nFTY9jb85635JyVZmShF6tXrIkXOk3ui2QQVv8FIYCwL5pjwS91Zxrry5eVjZdR
         FeJSQiSVUaJtoZl5M0c6N1esKDNZ9a3/NNWhWDMgy72Ex5AGcxHpNSEvgY5lQ64HpzMu
         zcOwBKX3VUCpX1ZGr3LfU2Fu0c8f4C0YDTbW3pr0WUaE01yt4BarLNrTn09DWOvrNo0l
         C4CEHUEjwpqNvKHviXNzZntsKY+k2C5dRfJaeHUpm/7iqu5MLgSrJCbjfHa+84/CRPSJ
         uKS22y/I9DSn2fthANQkWgemKicRp4S+Ux49vkxw4gdfORAqG3o+GCyG55GbrgfokrjB
         08dA==
X-Gm-Message-State: APuU4Z9nnAc/uAZ+T9nM7G3ramTNHjvYyJelO2+XWYc+Pak6n1F5vGHX
	MOwDapTUqWSzZOW1bcnlErHIQJzP+YJuXvvVAQkS/K4cdL4Kdwdk6+jaaLZ7tn6SgKk=
X-Gm-Gg: AYBFou3WxagSVh2gnY/QwWRoDNOGEXfh0D9i4kOTS5OC93RmZxKMeKvKVOjE+k5bPXc
	bO2QIgD/+YYPUMrCuBC8RMW7P67tsmzfUMTnDeJAVy1O3wsgCTsn8cjxemVBt+D5z63K8B9aLhT
	4j2NDo11qASG03rgnuR2UG2bHQZoGh9YAnVDgVD9OBFAk2l8vKIWYiOiPbaZC8V8agHxfaHlrXP
	vof5K09Ac+UQ8kcApCA0mghfPCvBrcoeDl0yEsNuROF+PCL1BomMG5GMiM5lSSmoibSpwSNF4co
	mPZXf0R4OJVJFllzjl/HLVKYDcReNMzBeeFJ5FTjlQ0NReCkaw0HtP4HxxI5WfOBl4/8sdV8gbK
	BYUMjXHL/vhi2sfPQ51ZoH3wBblClACSE2aOD1OcPOFes2ozpMtLhvNG8TZqBE0tZUu+tdtgL+u
	M5xYmJupIykzFoa/utTzn37C6Bc4frsC8GJB02h86u5Gil2iUWoEtE3BBUyt+tFqtSPq6w5y5yd
	N1NLis5RaWJo/97nOiL2l6YINfpMuuZF0YuNJ+c+j72i9GTbzBCuRr1I9fPXqBnpEcPR6/JM6BA
	5qf3ifHOvRwvQcvjJgS5hcfpVWfooHTlhCeOUn4EA3wNUakHw0xDFbqIJOi4qRG7WxlP43lm57T
	/hj+EyqmcX44Lwp8C9M+/bAO1oh/qcrI4dl5d8X5DSlo9RsGCXQLBYNELZHS9iZUJWDsb/7bVMF
	RhcumJRLBV/JF6XAJU8Fp7tCI54tMm
X-Received: by 2002:a05:600c:628d:b0:4a1:f7f4:7ced with SMTP id 5b1f17b1804b1-4ac185bd243mr356788215e9.17.1793783148444;
        Wed, 04 Nov 2026 01:05:48 -0800 (PST)
Received: from localhost.localdomain ([104.28.219.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9fafe08sm201732925e9.3.2026.11.04.01.05.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 01:05:47 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v4 1/2] remote: add repo_for_each_remote()
Date: Wed,  4 Nov 2026 10:05:33 +0100
Message-ID: <20261104090534.21838-2-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104090534.21838-1-okhuomonajayi54@gmail.com>
References: <20261023211533.73433-1-okhuomonajayi54@gmail.com>
 <20261104090534.21838-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

for_each_remote() always reads the remotes of the_repository.

Add repo_for_each_remote(), which takes a repository, and turn
for_each_remote() into a wrapper that passes the_repository.
Callers that are given a repository, such as
unique_tracking_name() in the next patch, can then use the
remotes of that repository.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 remote.c | 18 +++++++++++-------
 remote.h |  2 ++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index 71170f36a9..f070ad5a01 100644
--- a/remote.c
+++ b/remote.c
@@ -869,14 +869,13 @@ int remote_is_configured(struct remote *remote, int in_repo)
 	return !!remote->origin;
 }
 
-int for_each_remote(each_remote_fn fn, void *priv)
+int repo_for_each_remote(struct repository *repo,
+			 each_remote_fn fn, void *priv)
 {
-	int i, result = 0;
-	read_config(the_repository, 0);
-	for (i = 0; i < the_repository->remote_state->remotes_nr && !result;
-	     i++) {
-		struct remote *remote =
-			the_repository->remote_state->remotes[i];
+	int result = 0;
+	read_config(repo, 0);
+	for (int i = 0; i < repo->remote_state->remotes_nr && !result; i++) {
+		struct remote *remote = repo->remote_state->remotes[i];
 		if (!remote)
 			continue;
 		result = fn(remote, priv);
@@ -884,6 +883,11 @@ int for_each_remote(each_remote_fn fn, void *priv)
 	return result;
 }
 
+int for_each_remote(each_remote_fn fn, void *priv)
+{
+	return repo_for_each_remote(the_repository, fn, priv);
+}
+
 static void handle_duplicate(struct ref *ref1, struct ref *ref2)
 {
 	if (strcmp(ref1->name, ref2->name)) {
diff --git a/remote.h b/remote.h
index cca02033b9..2a0bf416d9 100644
--- a/remote.h
+++ b/remote.h
@@ -140,6 +140,8 @@ int remote_is_configured(struct remote *remote, int in_repo);
 typedef int each_remote_fn(struct remote *remote, void *priv);
 
 /* iterate through struct remotes */
+int repo_for_each_remote(struct repository *repo,
+			 each_remote_fn fn, void *priv);
 int for_each_remote(each_remote_fn fn, void *priv);
 
 int remote_has_url(struct remote *remote, const char *url);
-- 
2.56.0

