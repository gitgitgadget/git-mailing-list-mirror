Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DB8626B
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977962; cv=none; b=JXUDBaUK574MzHqkmSAdpObiwHiaERV4oRPJQRNLmfJXho9KLoNokS0Q2VKZonPbBREiFB3bp3BDYk5Den9r/2CB7dyjFZ1ylXhWhWMSU3NmqdWajTGBohPaGhqGDw4mmff3hmijOOI57An18cvfNP8QYfHoiW5lOapzQYeMwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977962; c=relaxed/simple;
	bh=TZFacfxETRF9ZMTJO6qCzMwkA2Lny0XmS2CluN4EAaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMw6/WyK9q256+v44k22uGSLpTThSvl60ac3t3NXkzHVO3W+sG08sQt6ki/7T619O/K7t+Nr7V+RcJCiWHC0I9LEBwRLEAjnK3xJol1WZJh2Qt+ZK5uDPalb5IKLMs8O7L0wiwLPiEONLb+9sQWRpcL2RiRG27NPaA58V9eoLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/bl0+K8; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/bl0+K8"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78a2093cd44so33942685a.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710977959; x=1711582759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkwUw8M2E2ZD4ut4a+KfdfB0yshmnU69j4ptyQi7344=;
        b=N/bl0+K83X2VFP07E6YWOMSG6b1oA0BXg+Co9ke5TrbY0RpKREN5R5ERrAveB8YVkc
         0jg24GxiMiC/iDkzGvp82DZCJ7jkilwCsboplSxcO+HoeefWyp4jd8OI83YAZxAXoxR0
         uryPpTBbaYuTPsuqEvxKvtQGkFFNXfZayGccVXd0cH0I1KCr+2W0D0+cEeeInCYmdwzS
         VaqgEd/wN4EI+qKC6GA7dMtEfpayMaQV8DjUfZPeSKe02nGm46Z0Z7tr4R44+gh0PKy9
         LIJ19h7oReNiFtze5luG9XbPPkdzyt2xOKFwuhgFnn8KAFtImGAj1LpxjakzSmABnlob
         XOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710977959; x=1711582759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkwUw8M2E2ZD4ut4a+KfdfB0yshmnU69j4ptyQi7344=;
        b=pQi6utSBx2BQwIG0sB44B8peoYvIbM8R894FFTKkBpEGklt3nbHeevPm+G+jGmYWPL
         DLOHX3vp8E6FOW4xzAMp4HEqEzdcelmqqK8KGhQIt/s6U0UgKMMSXrWzyx0Rca4ug+Jt
         tjGmhbTknw+kWlHoggMXuvBh4CxqUKeMkVoKdaLhnfayWdhCI91E0Cd/iE4iaKKlAsFP
         irHvqHPy3kXo8tgEy9M6FCgoyaVG8P+paiO4BtNvSXEfmzlduKEc55mRoHpC0LmqksuR
         ryXWkfda3hj8fHi8BhiYqrY6OmlQtiBFsSSGg1HSPcr+ETqZQmBl6V7zcol1aLXcmV0T
         9OYA==
X-Gm-Message-State: AOJu0YxtMmDCzenWh+10YjW3GXEEzj8IKX+IKOy43L7qFptafZ0gFjwt
	F24t1CFh+859jW+obi2srhY7mpomwwgIEXf35PFCfUu/XZaC6bvQEdZYDE8ZFlg=
X-Google-Smtp-Source: AGHT+IHaz7Oea0AKsmH/O0ay+czu1VkAL/sbRqH03iqfVkSP3sfyRepkzbh4F+pJ1uU3nnRARByeKA==
X-Received: by 2002:a05:620a:1204:b0:788:6cd6:9f05 with SMTP id u4-20020a05620a120400b007886cd69f05mr386023qkj.14.1710977959562;
        Wed, 20 Mar 2024 16:39:19 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b0078a0edbaa94sm2400867qkj.91.2024.03.20.16.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 16:39:19 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 6/7] cherry-pick: enforce `--keep-redundant-commits` incompatibility
Date: Wed, 20 Mar 2024 18:37:01 -0500
Message-ID: <20240320233724.214369-7-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `--keep-redundant-commits` was added in  b27cfb0d8d
(git-cherry-pick: Add keep-redundant-commits option, 2012-04-20), it was
not marked as incompatible with the various operations needed to
continue or exit a cherry-pick (`--continue`, `--skip`, `--abort`, and
`--quit`).

Enforce this incompatibility via `verify_opt_compatible` like we do for
the other various options.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 builtin/revert.c             |  1 +
 t/t3505-cherry-pick-empty.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 89821bab95..a1936ef70e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -167,6 +167,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 				"--ff", opts->allow_ff,
 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
 				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
+				"--keep-redundant-commits", opts->keep_redundant_commits,
 				NULL);
 	}
 
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index eba3c38d5a..61f91aaa0a 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -99,4 +99,18 @@ test_expect_success 'cherry-pick a no-op with --keep-redundant' '
 	test_cmp expect actual
 '
 
+test_expect_success '--keep-redundant-commits is incompatible with operations' '
+	test_must_fail git cherry-pick HEAD 2>output &&
+	test_grep "The previous cherry-pick is now empty" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --continue 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --continue" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --skip 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --skip" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --abort 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --abort" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --quit 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --quit" output &&
+	git cherry-pick --abort
+'
+
 test_done
-- 
2.43.2

