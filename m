Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E78250BF6
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371250; cv=none; b=JFSEPJ/idnWTXO8zL8rI9PQFM60CC+gkAWnf4QlHGq4tobdx9Dp1him8lUW35Y3qlkPFkaYUqmbgDzXuJYhwb29OuVmY4v7c/HBO/lCgk/45PvQlT9DswlJyye/2FJQHXWy3q8+H4vff/Q19wOdfK9PndjO0zSwfzSAtqRw9xvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371250; c=relaxed/simple;
	bh=x3uL6OdmoBHRcUt67v3bS3j6ggRMVoNwH/JbOHEjNMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKie6gXXgmsA2p47Djq6fbl2gwGUb1Tn1WeAVEnaUlbvetJveeT+i/RqDZD63ToYTEI2Djf7xUK/7A+kI4+3l5LtyZS54I44a3nYbz5xJiG+6EDGOvVZmq2RBwpgaR4brXq+WHaOulE6ZxZU88YZHrgET0Mt5Tfc1tWDXvHiw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1gvyCSi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1gvyCSi"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2264aefc45dso10167225ad.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742371248; x=1742976048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjI24SGYnVXZJlEp5CthDwOZMHEZshSmzDOwlPJdwqs=;
        b=i1gvyCSi7f44TRROj+FtsZkxY6UC7ZmkBecvHfyQbUzo6y+tHoeRLHYfStPKADG7tV
         JcA+zXk12q8sfpJfLsy3VFyIJduiChhmnKoDB2IsHCCbVCEIaXVWXq+WWmXKJoj1hfar
         ygGP0ANztF2Ch09u+7Z45+5ScvRRgN/JqcKyUgpZ8nKYryRYzHlpNi4ejGvS8HvM7cSE
         pv8XctPJpBbDQUMzg0KTdee0tABGjYQDf5Gpl/olBteE1Lxn5bY/qCBGDYj8Qydx/fOV
         VWZwSQNMSyc25KZmfccUq324rh5qV49+0cox8aKMl4jqXYwaeYNFSzGf4vJtNlHpiG7D
         X86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371248; x=1742976048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjI24SGYnVXZJlEp5CthDwOZMHEZshSmzDOwlPJdwqs=;
        b=oC+m2CPJdHSMo93Svu7gV2kH+BwyCeWdNgu5WYhWd4pR5+47ok4BXJZ/MD46kE/QyX
         3dymwopzUVGzsB97L5HSjP79wBJba2fKP63D9VtmDcqq0EiPzJYGd7a8tTJMW+B3I6q0
         477vx9po4WrPb9sG/3tuHZhKvrAYo01euTPoT5DKFQXxx8zTGHZcBzsm0E4Z10wZ+/Ej
         Mz5myngLjWFwOdog/X8LaoKIRDNdeKH1ch4G4qNa+sDtC2dFwuEymYRBNgwO6NrVdMif
         lTozV6/2jwyoufFx+VPiRSuk4fsGKqQOH+HFp31LysXsLOBJJnmEVMkoaGYS0G4yn5ix
         tz7A==
X-Gm-Message-State: AOJu0YyG0ZUeqtoLehufzd5+4qdh+z5mDdl3ATvJM2BjtdvYhwJQ04h/
	59DMpmDVvTPvAtJVPg7SlKOUcUStCom1fODXxB0q/Gx9zMK12fdTP1gStQ==
X-Gm-Gg: ASbGncvrqOa3AFrUyEAXJ2bsbxMcth1qq8N7gYFtaPymP7dZo66Wid1ovD49G6WtBXe
	OOmj6eTUi5zdZ0NXx4HwaYEPpMIF/Df6auo1j6GUyfc0k+o6aIj6L6qhrHdDXqx6pBPHVx8Q55q
	0l7Xpeti42NTAkRwS4Ts9dCnTaLAWdPsXzz0a2gIDa2F3BJCBjNNHY092qfg0/TqbERrUf8AHrz
	xPjbch52sGOfXaJgCR7/TlBkfo1c9NI+GfrSx+FMuiskqVGIb8lsZXpfAbrJaRDFKuuK7fCJeBD
	YkLa09FPnSasVISbO2BWRkkwYMlBSoIgHfAwzOqX
X-Google-Smtp-Source: AGHT+IFUGyOSJ9Yj//4Q1HHt/+RpftnJA1MFEgG5SLvFzEY+I7ylQj/0JuUnvJIoCVGR6PExloW9hQ==
X-Received: by 2002:a17:902:d2c6:b0:223:5c33:56b4 with SMTP id d9443c01a7336-22649935b27mr20983585ad.20.1742371248146;
        Wed, 19 Mar 2025 01:00:48 -0700 (PDT)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22629cfbcb2sm32866715ad.176.2025.03.19.01.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 01:00:47 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [PATCH v4 3/3] reftable: adapt write_object_record() to propagate block_writer_add() errors
Date: Wed, 19 Mar 2025 13:29:43 +0530
Message-Id: <20250319075943.28904-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319075943.28904-1-meetsoni3017@gmail.com>
References: <20250312121148.1879604-1-meetsoni3017@gmail.com>
 <20250319075943.28904-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    Previously, write_object_record() would flush the current block and
    retry appending the record whenever block_writer_add() returned any
    nonzero error. This forced an assumption that every failure meant the
    block was full, even when errors such as memory allocation or I/O
    failures occurred.

    Update the write_object_record() to inspect the error code returned by
    block_writer_add() and only flush and reinitialize the writer when the
    error is REFTABLE_ENTRY_TOO_BIG_ERROR. For any other error, immediately
    propagate it.

    All call sites now handle various error codes returned by
    block_writer_add().

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 reftable/writer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/reftable/writer.c b/reftable/writer.c
index 94c97b7ac0..3fdfa4d34b 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -620,10 +620,22 @@ static void write_object_record(void *void_arg, void *key)
 	if (arg->err < 0)
 		goto done;
 
+	/*
+	 * Try to add the record to the writer. If this succeeds then we're
+	 * done. Otherwise the block writer may have hit the block size limit
+	 * and needs to be flushed.
+	 */
 	arg->err = block_writer_add(arg->w->block_writer, &rec);
 	if (arg->err == 0)
 		goto done;
 
+	if (arg->err != REFTABLE_ENTRY_TOO_BIG_ERROR)
+		goto done;
+
+	/*
+	 * The current block is full, so we need to flush and reinitialize the
+	 * writer to start writing the next block.
+	 */
 	arg->err = writer_flush_block(arg->w);
 	if (arg->err < 0)
 		goto done;
-- 
2.34.1

