Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569384266BE
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500505; cv=none; b=d36zJt+XfPtcGAj9cwOcQvx1N+RewmLDpRXVtOtMWIAisVjqGPeb33ZdK7vZLADs8a0BX7L0sMuf0OCRubgkfcf1F7aV6TAOZlQLwjTMI9Q9nKjrSDpfCJT53bei4l27P1M8K7MFAsIl8g05dzWFgahwQh0OYcevbM88kynnBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500505; c=relaxed/simple;
	bh=Rw/Ri3R97LkIRzrDAVPmn3QJYG+gg2vCVHIXqSq4Oa8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A3lvFSOSKP/BPXOujw3Wh3qzYkmlmHgcVhxF/iTRM466neUq9UnhKYPuAV34BW9dWcP0wGC5CmjsoYdavATUyQ2RBddJlI+K7SFIROS/Bc5xYcQKTmYA59r1shqo4n7y9lGR53lzrSKLcOV8zwRwAAQEkY3s8FZ/7gW1JDEVj/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7nw9q52; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7nw9q52"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a48deebe95so2782626d6.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777500503; x=1778105303; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6kVTrC9WdIcOMKTEN7d5+/ObHsI/nfN4NCne9GDd1Q=;
        b=h7nw9q52Sjelr3KKUo6UQOzHCzONPrD08A+PEXZnpjVjY5gKWh8Swdk3BtMNXmjyd+
         SfCK11qfJg48yciOpbxqXujNjoAlT66eiOYmOFym5pXro9IxdyF7V7hnpXX/EuRlVB9I
         lC1wJemunOM79gzkr4keekz4L7LUMs/DvBmfFWwxlmFAWKuaj4rXS7PgDbB8ZuW44WRQ
         6N5zIeYvu5XYujzc7Eh5ByYt3+tcoyk/tLBF0N/tdsCG89JN0SVerK2oIbdCdR/n7QAK
         Q9m93CsG+hiDCQLtl4Cr/epqUZCD5ie9uABOmaT276xHlOMZtAvSH7vRqA9lyBYsmtKp
         lTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777500503; x=1778105303;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O6kVTrC9WdIcOMKTEN7d5+/ObHsI/nfN4NCne9GDd1Q=;
        b=BbE24aewmf1ruGxGOp3zX60BTRbfSFVnRkomeW01GTKQypgMC9Z/x6NJhOsCT6f0iT
         NoNiinu7WWTD2+HGqNhCc2qTGLFumEg3okYSREOELllYi1dhKCiT9IshL5y5bLK3r9/J
         HCPLVG2tMBOTdoNBZ2DIK13W7sRL0HKWeGRnk/6fl5IbXFFOrDMfsqA8KGP52PgRJ9E2
         AY2HY4fK3h9DhCLJctHToWYixpuhCJ0Mndw7wjHIjRmoq3ZCfT9expfj0VCGV4zMRBvb
         CXYUSOpPVh0cCnr2XppZdO0894Jd+/uhkZWRkJ0ORZxDcz4ZXCQs5gpf/5KaS9xAZCJj
         9qAA==
X-Gm-Message-State: AOJu0YwD5ADWI103/4vatwQ+wXChIUdaM3Yl4LZTMNxWWk2LwiLh255r
	BM/QENjIhhQm2qbXasbSWWO8MGxv977eCsRFKHubdIzNOhMxcEWYv9bfTfkqdw==
X-Gm-Gg: AeBDieuSW3sMBriinsVjJYNHo1GDY44VyPB9Sfhi9/A5t9CMBipYhKq2+8p3Q4BffII
	bJRVObjQ18B4rzVy+UNr6jelUxNUdPOMyrAFYxXedEY3EmEbjTs109O+c0VXlGNFFbokhy+flaF
	OhGd/cIkDu6V5eywlUR/8lf4yXDWn3kuf5TnX8OZU+LcFYU0OeAGS1JCXBrSMntjilyzLuOyXvD
	pcoQJ42UBnAfp4dkfLu8g2eDETN51TA/hh56Kl39AbuwItn34ds2kNf9sCS3d9JdqT4etXOkT25
	iH/8DKu1A61NF6idmBIDH/u+JfjBWbTrZfUdojQaMCIUKkLsveMoWjc0jSVMThFPcGU7LfTdutn
	iO+/jcCKYhIr/h5gsfXXBc0z77uDZUN18gIHMpkc9WQWDLVPIUUJVOhJLE2fbSgjAuNyxDEiMMp
	6xOAspvPG91XdXjHIzJDON1Bac+TSl3sQ8PEIJwKd9EWLjaVYwww==
X-Received: by 2002:a05:6214:dc5:b0:89f:4a69:44b9 with SMTP id 6a1803df08f44-8b3feef2d6fmr4729936d6.40.1777500502708;
        Wed, 29 Apr 2026 15:08:22 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.100.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ff482682sm840326d6.48.2026.04.29.15.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:08:22 -0700 (PDT)
Message-Id: <45ad2ae62de99de598088fd041559ff3a23ef82c.1777500495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
References: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
	<pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Apr 2026 22:08:14 +0000
Subject: [PATCH v6 5/6] xdiff/xdl_cleanup_records: make setting action easier
 to follow
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

Rewrite nested ternaries with a clear if/else ladder for
action1/action2 to improve readability while preserving
behavior.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 7141dbc058..ddd0577676 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -302,7 +302,12 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
-		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
+		if (nm == 0)
+			action1[i] = DISCARD;
+		else if (nm < mlim1)
+			action1[i] = KEEP;
+		else /* nm >= mlim1 */
+			action1[i] = INVESTIGATE;
 	}
 
 	if (need_min) {
@@ -317,7 +322,12 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph2];
 		nm = rcrec ? rcrec->len1 : 0;
-		action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
+		if (nm == 0)
+			action2[i] = DISCARD;
+		else if (nm < mlim2)
+			action2[i] = KEEP;
+		else /* nm >= mlim2 */
+			action2[i] = INVESTIGATE;
 	}
 
 	/*
-- 
gitgitgadget

