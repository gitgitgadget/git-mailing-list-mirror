Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D642E17C96
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677273; cv=none; b=sonveGNIzUwPzJWyQeG6rJOepBU5bHq1UTRXpjwSXgZVF5FEmEXY96YtWfx6TP+JlSR+0kvgaRD/C+/LpuVzS5DiTf43VRG8i6LcqRihLhN/tdTLd03f8H4zx6roOTAnJlBB4vqgewcm5OaEpB+Gdo3o+QspsLoICsMBYsD2kpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677273; c=relaxed/simple;
	bh=Xq7WRXhxo0C1kRAmZ99K0pnF6HJm4Bw5bwfBCsQ5cn4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TOmSC41aWuO0Gr1pQNfSMInEeSkLu43ggxjrILLVWcRm9fcV1ZlbVuR1Bd18AOnwxeZHnwTGgwoRoO35Kv7H0adEJaoD19UeoHy4UgH/zhm/MC5Ps+GiUtERgar72n0jLD+Ukggx5Jey4fIN7egbW3dSXaRLx/99N+a359wyWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiwbhtUr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiwbhtUr"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512d8fe4fceso664832e87.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 00:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708677270; x=1709282070; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+i8PkXYJCTRN8cYGZeTF3cwl+HgYBrV1XX86X8PXc4=;
        b=QiwbhtUr48WoUmB1os+NaQqi/HKRbO8dpbPrVqbPw1e1xTHJA4aE0nR5EgDrNz4qng
         EAzANV9pOjxjgR1Uwd3LJrflMtcX9RCc8AcVio9pQhEq27x4lnO+UXPHxrVuITUDplZw
         toqEv8c4N/qvxRw5NCYdZEUAy1ltD3eFrQTzPvXQ4sx9q+mRwHBzyTXm3uwqzlp5Wveu
         J/r39NvRalcIUipWrjh1HPkE5phUfnbcE70IiUUkda5Pkh6rJWr6P2zFFKOmdOipx7NB
         ORQLlv5cpiz9IfbnMwM27S/fycPOHPLeGclr7GtepV6I8LRUfIqXMnrWsA5u9UwtmPn6
         AdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708677270; x=1709282070;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+i8PkXYJCTRN8cYGZeTF3cwl+HgYBrV1XX86X8PXc4=;
        b=WBSR21OtuotsXfU/Pcvit+OxYGMVeWr329YqAfyX70kgaRDM3dhLzA2g6Ultq9n9+y
         SBHeO949Cfo0tFxxXr2+l594829taC4/T7UjIHeRx9BHZhc6Us1pSWcKshx/DJTMxhES
         VSl0O8I4Wt5MLHCUhwwFuOv18937s4VCNj4MFE6Ix5uVsX1KsB3cMW71pISekeHRLzjl
         0brJQtFGNsojvEbqxCCikwNeTgM1J1nBZ375SWKEIYTT6k3qG2x68v4x9nkZWqZKhBX4
         HpW26XL1ryS2pKl4aunCQ1Noqfwg5MUAX1qA+s2RxQvPIOukXy0mUyCqZhQf53MX0vQk
         kOqA==
X-Gm-Message-State: AOJu0YwwxzfIOHIc0TMSku4tTSRdcpBL/6KIox341X0a8hB6hkUOGikg
	kQtKYvRpMA3T+75buASYn8BfHHd03W4W5MPL2G9e2kfUNJ2cKXwPNtk+qyjZ
X-Google-Smtp-Source: AGHT+IGnhKAL1ZnaWVCGaDvm8HrxY2HE7n1w3Pa15wWEFO/r4muYX8Z1XPKxW3donfgI7QLH2TN+CA==
X-Received: by 2002:a19:ca4b:0:b0:512:8881:8f6b with SMTP id h11-20020a19ca4b000000b0051288818f6bmr997553lfj.36.1708677269635;
        Fri, 23 Feb 2024 00:34:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi13-20020a05600c3d8d00b004128808db91sm1521065wmb.23.2024.02.23.00.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:34:28 -0800 (PST)
Message-ID: <f01f4eb011b400faeff1c33934775a521dec7a3d.1708677266.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
References: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 08:34:21 +0000
Subject: [PATCH v4 2/6] merge-ort: do check `parse_tree()`'s return value
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
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The previous commit fixed a bug where a missing tree was reported, but
not treated as an error.

This patch addresses the same issue for the remaining two callers of
`parse_tree()`.

This change is not accompanied by a regression test because the code in
question is only reached at the `checkout` stage, i.e. after the merge
has happened (and therefore the tree objects could only be missing if
the disk had gone bad in that short time window, or something similarly
tricky to recreate in the test suite).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index c37fc035f13..79d9e18f63d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4379,9 +4379,11 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.verbose_update = (opt->verbosity > 2);
 	unpack_opts.fn = twoway_merge;
 	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore */
-	parse_tree(prev);
+	if (parse_tree(prev) < 0)
+		return -1;
 	init_tree_desc(&trees[0], prev->buffer, prev->size);
-	parse_tree(next);
+	if (parse_tree(next) < 0)
+		return -1;
 	init_tree_desc(&trees[1], next->buffer, next->size);
 
 	ret = unpack_trees(2, trees, &unpack_opts);
-- 
gitgitgadget

