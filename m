Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A41538F65F
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679994; cv=none; b=eVq5kY3mQLQUBrBZBngGqXP2KBzpkkll4INzP5Add/B018/2xRK9L9LJtrALovmweMilENPDSlmyQe8loFu3BoewiQG8RzXOlBk43gozyNtd97W3nDIzwInnRrvPre+OD/nekoix0oQTDAV4qnqph7rZD/KJmP18LmCtvwUfWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679994; c=relaxed/simple;
	bh=Y0cyDhxL8l2KKDiWsH76aKyoj7SjddV5KFro/r4n4M4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=peVDcxTn3JaPHKUxGOKOibewyBqSoc1q3Nbr9N6JL37jIU7D7ioPZmZ5gQlpTHe2EbmZlxcanH5h5nE1OTJVUpZWw7CTGerONRrbvnq/iAwWmTUsJmZYpd7+S7tLKY8mrrVqrOqAqf/wlyQb2GroIrWXxaG1zPyDkrfVHAkSatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtyPH1OY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtyPH1OY"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82c68339cf0so123727b3a.0
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 13:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679992; x=1776284792; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UDCBhlfZ3eeL1P4DW60HXe9wjOfRV5M4bIn1PRfvis=;
        b=QtyPH1OY5f/f/BBcZSszoIEBQPowy15alkULjvsOOgCJq7TnrQwKbkjDOfYKIbt6ye
         3jRAvRC1VkGq3f7gZByHb8u/N0Jdg+TnVfDHi4B0BSd6MfcvuMk1v45Uo91yS+uzADWS
         zEa9ctFLt7neGMRdKhVZasj62GDgEb43AsBd33z/NxGOuDfjQv6kQE+e+mZDYtp1V8ej
         wPIeTJcHr0FgS7hHlFSVss4jXOhQIM6AxQkTfdF8DgAeSxDLdYc87TutYVFBMbQcQ4v5
         ikDRKXZmDMW6kuNJ/pcgBJcm31h37CWUcjgkSe26rLm3v1f7ZdAxFxivEC81oVa/CwV1
         2R0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679992; x=1776284792;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5UDCBhlfZ3eeL1P4DW60HXe9wjOfRV5M4bIn1PRfvis=;
        b=kKOdGlsPLGEnCPvitisMF+Y/pUW/Se2dI8gf2ml4QOxtkk9TJA6zJmdotP52z5C5Jt
         B49hPL7ZRlN4PEGTuJJ0oQQunDm0Zoyh77FIPJ6lckYWGDU0DPLxc4OmE5BlV2KP1/V8
         LJw3yYj51A927wFZxefueQgzCzwwl5+U+BjF46u5C7tq4rMxOcKVG8Ms3IB+/stYyQ1y
         RAlZJ1QlRycoU6ru9sWYAwQ9Vkn633Y8uOhHUQmwMGge63jz4s+jUx65iKaPZtWbS+K+
         nlO2fBnlidztOEcupjOQS4Q5yrwTM7bMX3bwLK9fRRiOt48Le3lbBkEbP2PtIDfqNuLN
         toLA==
X-Gm-Message-State: AOJu0YzoK/VBuXJj8iSKaMVw8LyIe1lMsYNzrifOxkW+Gz2WB4QWvdhs
	cwdZDilyFj9iAMbDHA5oKIY6n8Sn+IOBmUHq0YqU5Re7J8uGsHq4QrJtIb8d8w==
X-Gm-Gg: AeBDiev1codIZvpj6fiW+Kug/tpuK0InN+ey4DT2GKxGz2DxJ82TH3kPiuO2zsg3/L6
	Hfatv7g17OVf8srM36RKvDE6r7XNj2Tbw26EPBDLG3KLzWUEm6+HIRSdVMBxVo7uUMZv3IxdIhW
	7ff9aYd7v37d93CSYBYOElGhkqOa3nqAD7lHU0QE5WNU1wOqZWLXQpiN+TxGYRRIPHzpyFOB4Te
	LGQu5PZhnba7MKKuEkaB+K6mAj3FamFy8Ceqm/MffWbEHHJetgMydoKrrCFa49gCQNxKKcrEQ+s
	3NGMj+PkWBZa57Q10SKu5cFa4Pl8VlHFm03EQcfTreQYI/9PmjeuuniAMfdZoYYAmm5ZsocV92D
	/0BYOYvm3ZhA83l0aVNkeLwGGaWg6qC/mPczs2ZAjf7Id18uhUMH2ZJSboERq4NIAtOqJiYY5xb
	OD8NRm7p7Np7+67fT/8xOTGmEtlqg4
X-Received: by 2002:a05:7022:4381:b0:12c:8eb:80b9 with SMTP id a92af1059eb24-12c28bfed17mr427302c88.6.1775679992409;
        Wed, 08 Apr 2026 13:26:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20b2b1sm23302566eec.18.2026.04.08.13.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:26:31 -0700 (PDT)
Message-Id: <b31924a94966686883079feff5dcbff071bc57e1.1775679988.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
References: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 20:26:23 +0000
Subject: [PATCH v5 1/6] xdiff/xdl_cleanup_records: delete local recs pointer
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Simplify the first 2 for loops by directly indexing the xdfile.recs.
recs is unused in the last 2 for loops, remove it. Best viewed with
--color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index cd4fc405eb..d6e1901d2d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -269,7 +269,6 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
 	long i, nm, mlim;
-	xrecord_t *recs;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
@@ -293,16 +292,18 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 */
 	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
+	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
+		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
+		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
 	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
+	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
+		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
+		rcrec = cf->rcrecs[mph2];
 		nm = rcrec ? rcrec->len1 : 0;
 		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
@@ -312,8 +313,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * false, or become true.
 	 */
 	xdf1->nreff = 0;
-	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
-	     i <= xdf1->dend; i++, recs++) {
+	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->reference_index[xdf1->nreff++] = i;
@@ -324,8 +324,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	}
 
 	xdf2->nreff = 0;
-	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
-	     i <= xdf2->dend; i++, recs++) {
+	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->reference_index[xdf2->nreff++] = i;
-- 
gitgitgadget

