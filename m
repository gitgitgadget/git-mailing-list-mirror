Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DEE131E21
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983574; cv=none; b=nhNRFCVV21JRX068umeuN+iS+9l9DKuW69QeoS/iXOP2FpKLtH/DPc46QHcfBJaKvwDTGw9aYG1BqeNlCBD92HvQ1OF4LyiZUX8KlcimEOCnCTG4vUdJI5DYh/aEwA868tq18ir07I4eOCP80fkqvXDgdblkagLSRAvzI/VdBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983574; c=relaxed/simple;
	bh=yUFjxGXoa9Iu5ABIv8e5hSygDvEud2XumKI6i0VwrCo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HCFZ0dCyEWKxT3p+decVOgN6CCcFCji6nalrlBOOsBMv8OCFTjVrNhESrEeSRaiXAdqiwQ311lKCUs2U7R4bSxLUgSpG8aq42Oo7X20j9Ur+U+PJodyc61w9tN08DUmdpDRIe2NcaMI0jwRn7N9kU+GqSFatt2vsbWEGOHq8yMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsCjPl/X; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsCjPl/X"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d26da3e15so1996859f8f.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983571; x=1709588371; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj66rkJA3Q9yHv6pTHD9ZT5In/BWmtsX624blZGveos=;
        b=VsCjPl/XcWQCzm7Ud/Kf0UKmSJn4qH0vBFJg3g/b6hMOnxhp9QsTWhudD5EsjyIrUD
         cB9p0yRt+GX+GWbrrgbkFzbbDcflGSZtUpsQKPNkFDcTqa+aX45zOdkKIoAiS02vTqok
         a7qKnhbRLZNLN3RtENKTs2DqUo3C+yQy06hpD0VqGDJTX1dMMtU+WBv+SQe4E9Uy/6in
         X1gAS/IsTb8CQBm4m9qXXkN6YZ7DhG3MTl/PxGK1aKdbz81si5rGIoe66F9N4lp94hj1
         7YVXZ5kyHo2Ui6f0x583ngKAozkReDfEPjlky3JWY1c1ZGrFy5Jn3NmGp5b1Vh2zIHFk
         I/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983571; x=1709588371;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tj66rkJA3Q9yHv6pTHD9ZT5In/BWmtsX624blZGveos=;
        b=voOGz9nJBSXidxYYw10wnSn/cIN8lN38tKG6kzhsc6xCbrWl636zeXFrtqO79n3j8r
         CQzeBh1rhAywPGCRVs6f1Qc9D1d1ws9/z3Q+anxpLDCvW2+/obcYHijhexqIuCCktqQz
         0Cx9laHqiiuyH2cNROYUv70Z+D3OKO4hCUjWkhs2fFT4UBSvD/JgxjLnWzxDDXD8O6cU
         1JeC3smPdL2rT2xn3bGO9oZ+Vp1FRHqeZSuQ7VFkR/VqFtE8904WI3WCh9qKEFExmE2X
         UEogCoZQMwfL3wIWZsRoNpNYv/GtMDlLol3EB1TBb3426bqSkMlxLrrO3PUz9gD9aVRK
         wiBg==
X-Gm-Message-State: AOJu0YzNPDmRwJwJZ0uepjzcZCa5YLYA9lF9/8OJKK+y1R/9eqXsn1lP
	PCGzpkqvYbmD3Vnqz48xRfiblq552TPtcXa3Jglpk8v1OfTP+e8e+RmOaqTK
X-Google-Smtp-Source: AGHT+IGiEwRoBhnHyqPO92BoPaYH4erKvdOEPZXoqSZSH6myQlDH1nEyGIdv3J5OVskaMkEjSKxVMg==
X-Received: by 2002:a5d:6d82:0:b0:33d:c0c3:fe08 with SMTP id l2-20020a5d6d82000000b0033dc0c3fe08mr7698983wrs.0.1708983571163;
        Mon, 26 Feb 2024 13:39:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bn23-20020a056000061700b0033d1f25b798sm9512878wrb.82.2024.02.26.13.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:30 -0800 (PST)
Message-ID: <9a4b5bf990bcddb2707207b7a523f0b9945d84a0.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:15 +0000
Subject: [PATCH v3 04/14] fsmonitor: clarify handling of directory events in
 callback helper
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Improve documentation of the refresh callback helper function
used for directory FSEvents.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 6fecae9aeb2..29cce32d81c 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -183,24 +183,35 @@ static int query_fsmonitor_hook(struct repository *r,
 	return result;
 }
 
+/*
+ * The daemon can decorate directory events, such as a move or rename,
+ * by adding a trailing slash to the observed name.  Use this to
+ * explicitly invalidate the entire cone under that directory.
+ *
+ * The daemon can only reliably do that if the OS FSEvent contains
+ * sufficient information in the event.
+ *
+ * macOS FSEvents have enough information.
+ *
+ * Other platforms may or may not be able to do it (and it might
+ * depend on the type of event (for example, a daemon could lstat() an
+ * observed pathname after a rename, but not after a delete)).
+ *
+ * If we find an exact match in the index for a path with a trailing
+ * slash, it means that we matched a sparse-index directory in a
+ * cone-mode sparse-checkout (since that's the only time we have
+ * directories in the index).  We should never see this in practice
+ * (because sparse directories should not be present and therefore
+ * not generating FS events).  Either way, we can treat them in the
+ * same way and just invalidate the cache-entry and the untracked
+ * cache (and in this case, the forward cache-entry scan won't find
+ * anything and it doesn't hurt to let it run).
+ */
 static void handle_path_with_trailing_slash(
 	struct index_state *istate, const char *name, int pos)
 {
 	int i;
 
-	/*
-	 * The daemon can decorate directory events, such as
-	 * moves or renames, with a trailing slash if the OS
-	 * FS Event contains sufficient information, such as
-	 * MacOS.
-	 *
-	 * Use this to invalidate the entire cone under that
-	 * directory.
-	 *
-	 * We do not expect an exact match because the index
-	 * does not normally contain directory entries, so we
-	 * start at the insertion point and scan.
-	 */
 	if (pos < 0)
 		pos = -pos - 1;
 
-- 
gitgitgadget

