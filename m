Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041477;
	b=oTsNHy0y3kLqDS+jm1odgsBWLtPX/jC6tulMU1B89pCtL7rz6zB+k7uWhLJ4soommZIJ
	 ju2KM+zXd77WUDJXb+Xid2+SYHN5yFmR4m0z8sg8OSLWxzxyBDTxb1+Ekc1rEvJBkcti2
	 rjc7prK/Oo32V9zWMOKpVJckizwzxF6ljERe/1Jw7bwMd0RHigOub+EjppUwyJ/BKNWSL
	 X7xBD3C8Gd51sOIQnOUwWHTcSaJh2uwExTICB5m3tq48AhXYR1+OloVmzgQ9W63h66cEv
	 hMpInF0rgM1swwiPkHV0eoCb7fuofxc9S1NsID4yrFkKBdqzY0FQriso34ywrCdlLUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vJtnPA0ktwlXolNKVa82Yg08eibDBlRQRi9mv3IBt3I=;
	b=Ylcr45ZKamq+QdBG6xr4I0pzctINGj8Q81nZbbPWV8JDB485jrWppPAWrtCDRHHwjvam
	 CQ1FvckYgzgzxsGnAXzVaOaMGrU0Dylkki5NOZhkl5rmoDIObPetEukxRH0ceHpaZ+r0K
	 f77wfZmDPzFdcCAi2UJ06Y3ed1wX3l2hW5Qo++BHf0/D5mpZxenzZQT/9epqILWJvRPAl
	 J7D0g2Cg/CbVdT/YuHxzvnLJ6V+bDDUWhY6WLooQe+W+0CIF7hph2OcKv5uiS3x9oU9/H
	 5VAtsSMALz254xRfcfCy/1GqWbEuFHaVuj0ZjfpTk8VqC9NO5JmBzTUKThKgGDoIYQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mKZO3QSx;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FCD606A322
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 19:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29FCD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mKZO3QSx
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso26689475e9.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793041475; x=1793646275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vJtnPA0ktwlXolNKVa82Yg08eibDBlRQRi9mv3IBt3I=;
        b=mKZO3QSxQeQDlSowV5w3Dc9Q9IsT7jrQr0sVTpTe6qiR2Pv8LzsGCog/d+f9gar3BW
         wp/b2bYVp94968qD1SUS3SegRLQWDUe1raGkIOMgz+hd+zyQq/auCGCSDnB+6wqVrLjT
         o0AFtkd822B2nB1B1GC9/ZA2jkNsn30wIf2SM8LVlrvXG8eXY8SBBrn9h5Vku5Lt0vkN
         6ilyre7ORx2gNBCEt33+nJ1R52RBbmhFauy61g4RZgN2nHf+9yw9lbaKENUh3PE5lphJ
         aZCa3VaSNNA7u5RnC5EbHaOx7oxYhIeoKgn1DLarpP1xnaYmu+O3GIhel+KD2pXicpjI
         wbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793041475; x=1793646275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vJtnPA0ktwlXolNKVa82Yg08eibDBlRQRi9mv3IBt3I=;
        b=y7S5RQtpzw2nSeU1ulRMFeEAmIpa/2aZc3QMuOkfj3BwfPP/nqPb2PwRp9Dqe44qG2
         6aSfTJr3J4LU6El72GKyPrTm2vkWvAxVl5dbMAmKmbEIj3oULPuoc1J+A3Sy9iu0mhQW
         qds09Ze0ZlKWxqmcqd9Ahsc+t2rW6HEAfbTVCw8vSyzmezTr27TpF+7XI+81AW+IKTfa
         taLXbZP53o8MQGmHOwXALQ/2s4bf5Wh2+M7Jm5XQ9r+/IfQAh05mG5q2+RKIh2f5r12N
         QkVl5cNkcN7bpagVxWOYXQ5kU5TVdqiSteCjSB/rQo+c0iTiYird6NgmZUcPfaVb8llw
         answ==
X-Forwarded-Encrypted: i=1; AKwUvBwluqK7uDl7/QDAXHdfvwhNoQ7qCm0OvzNeKzLJH/1H3tk/8CDvBuXeWDC7zr70HM/P/2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjvfCBmBy3bUVmFSX5I4nUFG913iL0KYlNYhqhe+257xTESGFK
	+GLP7RfGbQvMm113bMRHtGjKbl0LOchgKj+MK+d78vxw36ISjtPewD6l
X-Gm-Gg: AYBFou1Ld9HGB19Vsow+CcddPDXKa/kqKfVskZ/3M9uWxoB1kTrIs2J+3HIpihXwj9t
	lVS6m4Pa9XfaTzDWKdGfGthzvYfanJLIBq5PzADv2cnQLRiqmopGTzPfMFEisuOg2DWnScbNia0
	+AMa5uZ68jbQD/IMiD1kZhvohb5V/9nf2FjBJ5VaJQ3D9jzN6ySmR5gg3ap0kzrw8HKZwMNnGjr
	7bHu0fCzV4ZRRvTGpxcnQih4HqC6sQOe5vGjyTValUNgdet1jrIaFjq9vt4JcKqwlS24rcb72jS
	4i02EnOocbeno7LYUNi7P6wwLtvS7rr6/UrAS34NYoICnood3Em8eHkqX/+8FJpbjQM5hGrwUUt
	O+CUGeQsuOX9GI2J6hvjOtqhkfsEnAO71DfYA0I0plpRoJkI5I+szS5CDxtT8rUev5af7Y18nAx
	IR3syW5YfO8tuvmj7cKsqriv4rpt1Kj+wFpJDvSGyBQ/i7s0lN+jZXiPjXyRGBAS0PKyA0oQkAC
	qUAiHS8D44Ee9FlEmZA3PdEgd4a9hjOohYQerP96+RXqvDj6fdtLFLneJTUCCW0bcztFfAFXBBt
	aBoc
X-Received: by 2002:a05:600c:6095:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4a35ac8bf3amr127014335e9.11.1793041475422;
        Mon, 26 Oct 2026 12:04:35 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a046fefsm271518255e9.5.2026.10.26.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:04:34 -0700 (PDT)
From: kerylefondji7@gmail.com
To: gitster@pobox.com
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	git@vger.kernel.org,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v7 1/1] archive-zip: refactor 'path too long' error message to use Q_()
Date: Mon, 26 Oct 2026 20:04:22 +0100
Message-ID: <20261026190423.1925-2-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026190423.1925-1-kerylefondji7@gmail.com>
References: <xmqotsm8qsdl.fsf@gitster.g>
 <20261026190423.1925-1-kerylefondji7@gmail.com>
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

From: Keryle Fondji <kerylefondji7@gmail.com>

Replace _() with Q_() in the 'path too long' error message. Although
pathlen is always greater than 0xffff when this error is hit, Q_() is
required to support correct translation for languages that require
different plural forms depending on the count.

Signed-off-by: Keryle Fondji <kerylefondji7@gmail.com>
---
 archive-zip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 6f73ca6d58..160efd878f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -328,8 +328,10 @@ static int write_zip_entry(struct archiver_args *args,
 	}
 
 	if (pathlen > 0xffff) {
-		return error(_("path too long (%d chars, SHA1: %s): %s"),
-				(int)pathlen, oid_to_hex(oid), path);
+		return error(Q_("path too long (%d char, SHA1: %s): %s",
+				"path too long (%d chars, SHA1: %s): %s",
+				pathlen),
+			     (int)pathlen, oid_to_hex(oid), path);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-- 
2.53.0

