Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421A4252CB
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948670; cv=none; b=UsUFkPm2VljOcUnFqCLhABgjcpQ/CdtxzHGiF/Spk0YnvSfY0ff4HL0pe9pkhFzfiN8TSxR6gwUPAA58VbfWN/AoDI2d6V0b4+1nnV4JTO0THwcbw4b5KXX3NXGOQFgWBo0pHVbc2BZFR5GB+bIEVQlz5uyQTd/3XweQgvZWDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948670; c=relaxed/simple;
	bh=ISmLznC1hmSnYSrgE/qit0Xq7gS04smBWazc31M/azs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQPDLHqZdY0d7d/8Q5NaId5COcQwvFi35IaO0glG9O0M8jqk0bpB6mbJMQhYmXtAw+6KbU+enwgdYcEJ837PsYpqZy7RojNUTPU2hz7V9kepNh3JVqxq52IHWrdjU3uhWD8oCGmRdKl+othIuYo+6Nd1wwXBFz/e55mLDH07+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jioyhSXc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jioyhSXc"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so25701045e9.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948667; x=1784553467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vk4ThHcvMNIevxMAVPT/7ER5v92+OHcS8Mfrl7SxeuI=;
        b=jioyhSXcJSGa2MhMCcB0uCZ/clbbr9t8T/1fa2lcgbW3m99+FhE6UaEojgmPYVP39P
         lQ2B4Vzp9YhinHfrparXGe9aIQW4kJ0QQfsKqDiwo9VhWLoILRDpGJXShYVXUBKP9pUo
         aff+a1n8DHJp3t3doW4i/woUpwDY4Fc0e1PZIviDoAFsWn658Gab5iUcMB58vihIrqPA
         YUHpDj7q/6h0DzKZkoolJ5Hziurilbc6U/HeiW2ct0sjOdZXto+O1biBI+DZ6H3FOR8r
         xaKqPnaQ9kVVFmDWFcWJ0kGTY/dNdgo17w3Zxre+p63CjQkUIi9sI00u045S0SYf2wHL
         eXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948667; x=1784553467;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vk4ThHcvMNIevxMAVPT/7ER5v92+OHcS8Mfrl7SxeuI=;
        b=CC6YNde7H09Xukjsgvnxef0nqWtMkhjf04Tr+q2qiVY7pUSxpA9gve8JxH/sWD51Pm
         GeMhRhrhqscu0Z+iuDUXYN0FxOS9L4T0CznjN+JhDVo3DycVIJ1gMuuHYw53Ayh8uVAs
         xUJDVAOW3aQd6x1fdvoSVvF3P/5ni5FrfP2u8oL4Ajvn8eve3mT9dM+boX3Zol8hnh0C
         1iyDDSrZjJNzpw63pHfgw6lMI2YiH07If5/U84uWy6jijaCqPB7wpLo+niFqSQ615k3x
         /ifcnc8sCi45rIQuXf8P0TNC01eQY51OwKVHyUytTCQg1ZcVVpztBeU0/9Z2LF6yYC7p
         /WOA==
X-Gm-Message-State: AOJu0YxUYOY3fXki+9qXcIqiDbMpyIo80xP5ueV8IbLH9VVCh+5igddX
	6OHqyxicfcmT5Cv2prkubqBNNQsdOF4vMYBje1loP3LMy+iXOMFzHvR54VFBBA==
X-Gm-Gg: AfdE7clXk4/2uxOTLoB4VKQnS2vdQB2YtMxrkg3mauHWR7mtgMk6ktXgj/uCCZdiWeS
	ZztESSLehIIf4cUVc8vz8lu/Nbnqm5A/a9PF01KS9kCL9conGViKQdpeeAMbhYX1DRa/qipX9QG
	GBF81j++W8H1gQm/0n0wsdAXp7a/QekP+whVHzet+s17+H4NWie06BZXHtyo5th5jg5qL3UQjgk
	zyrutceklJ4RViEOfp9EqqbWHziXRL3azXbvqYAgi3iN9IFOrQOM82hnGLH/vSWfQjgc+VqbzUW
	HtdhJqH5+2OLcgCyD8KRiOxUKqMQbMn9W951qaBHUqw3ee/vRjuSLquc7IFGVte7IJnTUXmmKgZ
	gPepmFM/MizCCZfM7u987vqCt/SRmmgOlh+fCRho6tM3X5tpzSdS0e17IGITR+J1tgfDepQcUGE
	nKZFJNgARyZi1PbxT7
X-Received: by 2002:a05:600d:8496:10b0:492:5bb6:6d4b with SMTP id 5b1f17b1804b1-493f8833b6bmr66740345e9.34.1783948667208;
        Mon, 13 Jul 2026 06:17:47 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm251653145e9.13.2026.07.13.06.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:17:46 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 05/10] sequencer: remove unnecessary "or" in pick_one_commit()
Date: Mon, 13 Jul 2026 14:17:22 +0100
Message-ID: <26eef6c09586ff2fec42614079189350e137751f.1783948637.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1783948637.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1783948637.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If error_with_patch(..., res, ...) succeeds then it returns "res", if
it fails then it returns -1. This means that or-ing the return value
with "res" is pointless as the result is the same as the return value.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c97b996bebc..d0d2cc228c8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5007,9 +5007,8 @@ static int pick_one_commit(struct repository *r,
 		      oideq(&opts->squash_onto, &oid))))
 			to_amend = 1;
 
-		return res | error_with_patch(r, item->commit,
-					      arg, item->arg_len, opts,
-					      res, to_amend);
+		return error_with_patch(r, item->commit, arg, item->arg_len,
+					opts, res, to_amend);
 	}
 	return res;
 }
-- 
2.54.0.200.gfd8d68259e3

