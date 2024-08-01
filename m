Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3387D16DC03
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510337; cv=none; b=bUmn8x7FK8Vw6NR84apqzoBPKDRXRxNI/i8Ptx7r7/IJr7Ft9gyLtCP/63ml/61IIXb79vw9IwK6k/xZ9XBHsrajtR3ao898NLfzmD5Xph1S7tdfOEMLSbfZki6H+AM5QRufvRmrCUtrgFnfsaG4R/TMtIZMXiiNCEPQSGf5Weo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510337; c=relaxed/simple;
	bh=lJ0cXIohnlHeDOyqRbU1Afyp/eEh9NcQnt1UB/p/M8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2pB0cshopNBdS6psCopfmtcCEC3ZnQMZQJ5pntUgr7UimQuS8pn5XVkqnJnjPfk7mTARA2YlhTBU44n9zQtVVY9x28bmUKqHyyghg766VUiac6oHOUj4A4ORgYoUFsqyYyhWXMO3JRFIEp07MMwEFTVfR75oYlnSwRvaTrfTVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxEATg2W; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxEATg2W"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd69e44596so14885045ad.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 04:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722510335; x=1723115135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5Wp7fD3+IzmQYf4uzeVp+sx/sYc2G2N5WK5mg2pfmo=;
        b=SxEATg2WQVYYfbPe3YtQ5oF7hJQLsnp2GDCbvSEeASildBDDWWONGIpXp/I0BRQdi7
         977L83efLfviMnT/N7vMU1fE0XxlAC8Yr7FqhUfNPkn80vPPz0NASxwo/rPL+YsyhCcM
         1x5oRjIkCoYk2MkRo5w0smt5WIuryNCEBgcIA+wkHl4smpURM6dFrOunpDaePInPGdhA
         gsFxG79KMOlt/TQubVWaO4xszvQ2Ht61ZNvN9uIonVa4TSODcMpJHiyGssUsh2gRvUJt
         1xUdrxbKDQjIOnmddgreiSGvyKEwcQ6wgTqaP7MFbBmcLZlxGvqBzu7U0PptXVmMIRFv
         gsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510335; x=1723115135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5Wp7fD3+IzmQYf4uzeVp+sx/sYc2G2N5WK5mg2pfmo=;
        b=xJxfMss3qIIIsOM2MonNI7WgheOGZwNFEkoSDDo3GNduTbGyYl+0ph+TErMmk92rhH
         kDPDrx8iKCeOWHf0fnnjf+S0rSWGar5u9cQ0kUZl7SxR3IMrsdmbf2kZ0MHsBva4BdNR
         D30PTMRSeNvwo25gRm1fkd3MrSjW9x20VdS1AGDNEuJLgc10Rs0mpKoSixUEBINNlEfJ
         Zg2R/R3dhtU5zBmfFB3nv0+Znquw/7iyWGrp/OI+Tkg38XOqvp/j3QN3nCrG4Sh+ccNF
         KXXmaTd0/i5FZCOFL3JYj8d8PQGb1/LVrxBbkv0hFYFVq8w6+HSs0iHL5li7p0ryigq4
         qNAQ==
X-Gm-Message-State: AOJu0Yxi732EENh1s19F+2LetlGJkbYr9gLMLwI7ge/wZLK9gruJAM+M
	n39XbVhaYG0eS3HpxxUVprmVsMqfc6ne+wHvPfRzF2yhts/SP0iC2cHeQw==
X-Google-Smtp-Source: AGHT+IH/DcIJtpsBrtst814t4S8at3v3W3QglI5zxODQSLNO74SRxvy3wtjmKU6nj0cX6URNYpwEtw==
X-Received: by 2002:a17:902:f544:b0:1fc:4680:820d with SMTP id d9443c01a7336-1ff52434027mr14588695ad.9.1722510335022;
        Thu, 01 Aug 2024 04:05:35 -0700 (PDT)
Received: from Ubuntu.. ([106.194.76.199])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7edd90dsm136663985ad.161.2024.08.01.04.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:05:34 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 5/7] t-reftable-pq: make merged_iter_pqueue_check() callable by reference
Date: Thu,  1 Aug 2024 16:29:46 +0530
Message-ID: <20240801110453.5087-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240801110453.5087-1-chandrapratap3519@gmail.com>
References: <20240725093855.4201-1-chandrapratap3519@gmail.com>
 <20240801110453.5087-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

merged_iter_pqueue_check() checks the validity of a priority queue
represented by a merged_iter_pqueue struct by asserting the
parent-child relation in the struct's heap. Explicity passing a
struct to this function means a copy of the entire struct is created,
which is inefficient.

Make the function accept a pointer to the struct instead. This is
safe to do since the function doesn't modify the struct in any way.
Make the function parameter 'const' to assert immutability.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-pq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index 220e82be19..9230dd9b9e 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -10,11 +10,11 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/pq.h"
 
-static void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 {
-	for (size_t i = 1; i < pq.len; i++) {
+	for (size_t i = 1; i < pq->len; i++) {
 		size_t parent = (i - 1) / 2;
-		check(pq_less(&pq.heap[parent], &pq.heap[i]));
+		check(pq_less(&pq->heap[parent], &pq->heap[i]));
 	}
 }
 
@@ -40,13 +40,13 @@ static void t_pq(void)
 		};
 
 		merged_iter_pqueue_add(&pq, &e);
-		merged_iter_pqueue_check(pq);
+		merged_iter_pqueue_check(&pq);
 		i = (i * 7) % N;
 	} while (i != 1);
 
 	while (!merged_iter_pqueue_is_empty(pq)) {
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
-		merged_iter_pqueue_check(pq);
+		merged_iter_pqueue_check(&pq);
 
 		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
 		if (last)
-- 
2.45.GIT

