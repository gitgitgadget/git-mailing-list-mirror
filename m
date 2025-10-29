Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452CE31D746
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776403; cv=none; b=L/nYUeXPtSpFDXpX6n72s8VddNKmpLGi/x2izMWW0334RgKYS6CzZyC4nhP7EysWsPgqpW4LrhPLdoBQBAJscDvcfZpRvXpn2J05u+x805EMHlKWvAyVHBMuqIzeS9FZtIVQjV4s+eW/krKaGozw/eL9ZGmZz/MVI40ezq6c2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776403; c=relaxed/simple;
	bh=/z5QSk/edYlu1HrKu/34Lj7WyuwqNMjlE6O9Old5pAg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MbHTBWj6sWfAL+/t1GKkNRPyTOJMDSHRz2LH9gRqgpoMaxdZ87meTYCbWU9Cgl7xDYh1NQD1/Mc0ceUhn5DmjuWZuY24MVIIQd6d08HdGgruIeT/i/Ma/r3qTEdKdbt7YYkNew5SOzjJ3+ZNHN9NSSWfrRISHLRXxlkNbfopPg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Acz/MvTI; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acz/MvTI"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-43300e49693so2830715ab.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776401; x=1762381201; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDU8l8GL5AOFFcugR4zJQMUo1JrsPhGjefENa82rzfY=;
        b=Acz/MvTIPk1AwDsqvrU4u1eNQGH9WLhSSKLPNjOJD9WeHqEzVZWViJCM8cuHCO+iOb
         tEcfEbpkNKA8QhXl/pkQ+nJ4M7wsm5Wu0+RP8nbs/fjaSfiz8vWG56/q/Pntmlpehgju
         BdazGGdL1GB94O9X/ag7mvOhGbOZiiGNXHVzqex0PivJNHBAOLPB/7N7TwiPO+1FPQ5D
         SYZIJeYetCnIIjknkChz0mhvqVI8bOiR19bbmq+Zm9RfqVwxqbrHSN4YFcySto6GXqxt
         KSrNoe+OTUbNqglW3U97CEcg2fQSQSLaxNqMvIzmlPEIC5h1jbzGkqEjRiAZegg9ayMT
         kmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776401; x=1762381201;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDU8l8GL5AOFFcugR4zJQMUo1JrsPhGjefENa82rzfY=;
        b=VuR91mlBID/2KHqigUJPajE0CDjtyz+plT2wn6GatnYY07bQRJW7WJg8F20Q8U+7gI
         OBuuUtnq56+k7HOXY3XLW5Hil8LwSQyGdsZbRNuRCGpqYOzCXdEYD+/wmTGjez577GdP
         dV+z95tETGer3jjzjAqDgJ8aNZ8By8fX2yauq6egIL1dmZotyGV5PpwlamMaG4hj9onL
         OyUgLnXoLfvL43hqFvPgA2qYww6h60KZdai1CsFxfjfYIrnHqfFUl7YEhrrlI9K8IOFc
         9YnSgFiDJji8PVWxkisG4dzuMWOs/ClTHInbkkEXNHT6BMs/wDuWboOOV1wRKRcToB7x
         Dn8A==
X-Gm-Message-State: AOJu0Yz4/0d3efnmkP8PMqY5etd3WmcuazPOpPTgygcmTLSk4Lb+7IYs
	tsN3LYVLEPwP2JDNLgMeBOQbeKS5xD6z1Cl0LZ4k52Ox7DHa06lvVaemiwHWdw==
X-Gm-Gg: ASbGncs0yiiaHd4e24hADsR0yN0qRzMuO3OV+80OasawpICyMpy0oQTkzEMhZy9ofTO
	kX/wK+BJmef63Xml7e4tVXDytVbH14mEpOfVz/Vck0GJ6RPH48cVBAM46MtckDPmsRY5BpH7Ebl
	1pkOWwZSqhexLABabqhmPY9aYkK3P59eAhQX0KNKsg8fO6QEr8rw3cVS5P8OMEuzxshEWEk4eJV
	1qDOwMYp6KgB/LnHyzrZx5ixLXysHmOWcNpS+/3jui9Mt/B6V9UMAX+Tv3XyMx9M8amlk7SZrUa
	fXENTqD2bEapxLjZpahAcqoSFkrPul0tKmTTyFA5SUDLW4dqBhGmk5lTG6/6iRh+Wylu6kOkUA4
	y/48KCJUoUrgwIZYY/U+ZUnf5oSWUTc/wMqPoOvohRNW5FdGw2++5qrJNO3CcUz6mLF9Jw+dJXX
	Z4Cg==
X-Google-Smtp-Source: AGHT+IFZTAv3xfSSduEwkoIWKdgaUZ2bEwxJ8WkKDIGvs2wMnWqFNMp3eEa2DYaB1pN0dZXmiq0Phg==
X-Received: by 2002:a05:6e02:17c9:b0:42f:8d40:6c4b with SMTP id e9e14a558f8ab-432f8faca17mr57726805ab.11.1761776401079;
        Wed, 29 Oct 2025 15:20:01 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea73dc12csm5995927173.6.2025.10.29.15.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:20:00 -0700 (PDT)
Message-Id: <e2a6a23cc473108f5a79aed88eb2b4df6661c612.1761776388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Oct 2025 22:19:46 +0000
Subject: [PATCH v2 08/10] xdiff: make xdfile_t.nreff a size_t instead of long
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

size_t is used because nreff describes the number of elements in memory
for rindex.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 14 +++++++-------
 xdiff/xtypes.h   |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 4ee9fb60cd..c690bafeb1 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -264,7 +264,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm, nreff, mlim;
+	long i, nm, mlim;
 	xrecord_t *recs;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
@@ -307,29 +307,29 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * Use temporary arrays to decide if changed[i] should remain
 	 * false, or become true.
 	 */
-	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
+	xdf1->nreff = 0;
+	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->rindex[nreff++] = i;
+			xdf1->rindex[xdf1->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf1->changed[i] = true;
 			/* i.e. discard */
 	}
-	xdf1->nreff = nreff;
 
-	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
+	xdf2->nreff = 0;
+	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
 	     i <= xdf2->dend; i++, recs++) {
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->rindex[nreff++] = i;
+			xdf2->rindex[xdf2->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf2->changed[i] = true;
 			/* i.e. discard */
 	}
-	xdf2->nreff = nreff;
 
 cleanup:
 	xdl_free(action1);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 17cafd8b6e..df4c5cab1a 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -50,7 +50,7 @@ typedef struct s_xdfile {
 	size_t nrec;
 	bool *changed;
 	long *rindex;
-	long nreff;
+	size_t nreff;
 	ptrdiff_t dstart, dend;
 } xdfile_t;
 
-- 
gitgitgadget

