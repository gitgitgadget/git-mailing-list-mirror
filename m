Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564392;
	b=kgaaqaGFPolygPOqqnAo9WhCPd3w5qtb4wRdp0MNmpliXszZdhmp1P7yfGR2h/2XBOD4
	 pTS+DV11thxSNIHtyEghuRtD98UnZn8e1ho6KzKHFVWz/2gIAn7Xd9/Yop1PANE0WCyZs
	 TaDJ+lQ5XKodWDtAeNmDTS4562QsgP5THSfagwm5kyGq0CCaVKza0/+SNsXTyPmpyUfMY
	 jOnVefPXa5GBtAw3bimq1lsE2Z4E+s0bexXbY0ofOXXvQb4/DQ433tpFUsy8Mpq7/4nX7
	 qaa33OTgGZlJ6ij8Fq5OLln+2Z6Dcel56Wf2UH/6pUkgckRxnyj+P1WuLm7xMLmQhww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s5BbDUD/z1fV35YsSAwcthiifX8VrNn8MrkvJprKoUs=;
	b=yoL2/0ffVMg1Ph9SSQhjGEAHdb5LD2LUTjf9P6dPmw9D0VS+DevisuEWQSdDMTatI6gm
	 m5bNbkSH6tq62O12uDaqG6XSl9RUenRa4TqcTe8V2To1yRQn4HPk7xGu9dqKE1VDk3J10
	 vXUbZzw3B24l2VigJyXc/FJJ9xaOfDB8xvOfJBWHKVXnNTOXVjwmTm1jndfFkATBhMcca
	 vaPWto+jokVfpUqncov9ijsYQa4Z4zW/JIOKE1VXqDcqR5Qdf67IhdEJRVx/uaqeFfA0v
	 01Wp+3Uawl+E9dQOAHTyDvyaMVzzZgO6tApgyIWTnNMahdKi4OGB0OKIkvVU0nt6slQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="eF//pBjj";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0832B606A328
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0832B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eF//pBjj
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso174270f8f.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564390; x=1793169190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s5BbDUD/z1fV35YsSAwcthiifX8VrNn8MrkvJprKoUs=;
        b=eF//pBjjzqXgCorWttnYjuTrTvpjoviH20ed9tQKPY1FWIml+QspIUYMKMh/e2UBJ/
         QpC/LEmImSfFYAQjrzvOwHIJ/yBQ5teP+PIac3GcOS/t2GKBmMpT0KtBvvvUj6Wj9ruL
         Q30HmzROp4TKZPjVg8wqGmF4TuRO0EjxcO3KvU70JfI4cME7AUpf1EeRZbTvqM18zUSu
         5ROzFUjVOr+Fg1DJhinIbBPpVmSJqCOxMDsTsNaK5/DaCHSqLXdP3DXWT2dJXteN00Aw
         O9hFjyb5e7cuTPk7/Z2sY6ZYiEzx1wccphwOi/BjUupAxHVeGzJVnbQNO8UzTftSC91T
         YrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564390; x=1793169190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s5BbDUD/z1fV35YsSAwcthiifX8VrNn8MrkvJprKoUs=;
        b=mHk6j5GYbZz+xNI8uDnu5cdUTY/SM55mg/HDJgkl05MCsuTCmFT3a6QEF57OeraMNZ
         5E4AD1QYxx1dExUypISsbMia6MJqBCix7bvieazAahX00N9A6gTxHZe9XorGQjgyruGv
         EeOU1YhI9OwF4yz+ChYT6wjvYPvYtjEVhfW6vuhFsOrZ7tAAi2gCDqvJNqshQskXWc2Y
         btCLroX21XyIf5aJYZHazCikAYLAz1Vknfd+9vzz2EhlZg5PGoJnH5Tu+AMJGPBARTqs
         QYT/9cnoMTntQTlYWmek7tY/aHD5lZbQh702gkOSj3KAZJkXXnEt4YExQOLxTVXOJhe4
         KXIw==
X-Gm-Message-State: AFq9FYIpu9Yiyvn1cPgctRaS+ZIjDWzR3SvqePwFXixlexFkNIb4Y5bd
	cPAFMWWRKeV97ZATrU+SLG5em207ZHF/9IZ0pSsJ7cF3tjPTz11ZnmVMgdFhTA==
X-Gm-Gg: AYBFou3tZuOXEwFgl/JfypZ8l5p/Er5bSmLOFjxmyxx3RD6ocwk5BT3Wj1dWbcMHAjz
	cTp2tQUeGfvjPmYCyctjxM9A4LB7cLm1QCTrxQJgRhvC65EHj3sawYkRNQySU5quUAZtlIQUTKg
	qwjuXT/87a0IUKr6D9hMpL6iTnjF2+ozAg6P4gPBbgdiAPY/9Nl7C+UaqnoouNDHi3rxnkaRz0b
	5casZKCt4s55n3eZ+PSABzcIhNkAxNmMSifOTHCP8Z/mJ5kHeCgHDBbIjVc/htZvtr6mhy/aBN6
	GSTiJKS77kM1qUEOUxoPZk0hD77V+WMf7jgVKBDBC3dGirbHoqIF48fCrcHKZjCAB6W5jhsOg5H
	2SEkL9QaD+fymQl1lGWLnk47vljykh4ETXFGzsx0GBwSrmgmktm5hN6FEcf/7SBrFLK1NnbToqN
	iO0YvzKIwdyDhufVFfuamafMqI4EPLNu1vM7qGCyrBTTFoORN9NIlnweHnCPTauFgZK1SO4l1y1
	5fKLMx0G+O82S2eTx4IZYZ6zO6RVi4MYcAN4ApTDB92D0RyaV3dklUgxGKQkdKlU+CBNG1G5Zak
	uv8eTdiVv5AxMlmUPoj3FPZEvQtWnVxHxDpCS/tkp/lyN62IMgqeNp9+fAoELTTkgwTHLONMpPx
	68rVdRXHxYUH826UIoe9KukN8yb7kR1JKrODS5AH9RpsYI7XESIVEnFycmqJqRMfjmA==
X-Received: by 2002:a05:6000:1608:b0:487:a15:b4cc with SMTP id ffacd0b85a97d-48e264b1611mr1338570f8f.23.1792564390325;
        Tue, 20 Oct 2026 23:33:10 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm3130790f8f.14.2026.10.20.23.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:33:09 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 05/13] object-file-convert: implement mapping in terms of object DB
Date: Wed, 21 Oct 2026 08:32:37 +0200
Message-ID: <20261021063245.2917625-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261021063245.2917625-1-christian.couder@gmail.com>
References: <20261021063245.2917625-1-christian.couder@gmail.com>
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

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Now that we have odb_map_oid, let's implement repo_oid_to_algop in terms
of it.  We still need the latter because it does some cleanup that needs
to happen so that our object database backend need not deal with these
issues.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object-file-convert.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index 63ee18630b..90a75a6c21 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -7,6 +7,7 @@
 #include "repository.h"
 #include "hash.h"
 #include "object.h"
+#include "odb.h"
 #include "loose.h"
 #include "commit.h"
 #include "gpg-interface.h"
@@ -35,18 +36,7 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *srcoid,
 			oidcpy(dest, src);
 		return 0;
 	}
-	if (repo_loose_object_map_oid(repo, src, to, dest)) {
-		/*
-		 * We may have loaded the object map at repo initialization but
-		 * another process (perhaps upstream of a pipe from us) may have
-		 * written a new object into the map.  If the object is missing,
-		 * let's reload the map to see if the object has appeared.
-		 */
-		repo_read_loose_object_map(repo);
-		if (repo_loose_object_map_oid(repo, src, to, dest))
-			return -1;
-	}
-	return 0;
+	return odb_map_oid(repo->objects, src, to, dest, 0);
 }
 
 static int decode_tree_entry_raw(struct object_id *oid, const char **path,
-- 
2.56.0.215.g47fdf2208c

