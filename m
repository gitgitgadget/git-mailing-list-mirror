Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED8029AB0E
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313156; cv=none; b=s/lc+2ZFY8lImsDKeWB7i9LZnif7zuRNA9IAPzIgJxBP4OXuHghf3Bpm2C4BFo+eeYjJp4z98Vs+9bqkwgUqRWr11nHMOxGvOCOY+PxgovsndaSLHYMEumtb1F2B35CcJeobWoGLNmsEsUH4rIuYlk+KJz4LfKHFzz8Mi0HRwHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313156; c=relaxed/simple;
	bh=Vf5uSo6mhDc+QPU1K4mx8mxhsdBmIBTW67yHkzjRWB8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YyZ4XCcm+p3SPG0wpCZ4OY7slR4XUHxf4sr29SzkNu+0pfpcnR9s4QeFIP96Op521wE6dQ3n5NM7oVJzmLLMwY5NnjUNliPZxbHbHrk/aWzwRgUBz1vNVLKbtbFWpT5Dp/a/3IeH+267GZMsTrsWXTuRwWdTDWMXbMUh1FlCwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwrBJxtq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwrBJxtq"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a35919fa8bso221029f8f.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313152; x=1747917952; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ+Rp8Vuh1hwAKkXODQMHgTnhQSEeDc4lwJdK7+qpwE=;
        b=DwrBJxtqX/Niu1OpFN9bET/62HC/v/wjKLOVWYzi7XG3VKL7hSa4tfgoYuTQtS+kfw
         z/Id/8mDD95EGR7STat0oJc8/+hE4QoQYWbvxrSUsvjCaGT6g+XandecuphCDL+8NBsK
         nYrywZPnEnJ8oUqosDt0rr98eakKtLnPx6bX4YR46kEfZgkloEckdBjOoA1QfKt/QT5N
         SVi5EMVDpfuN8VZb2BzL0l4qY+XelJ4cUvWvvdpvKTmhdtrKN9B168T09TGFkpOZtKnc
         3pa7jDeQcUpyaXyRc+AGgQCCBEfmqMeg2200wiwK/gBBZy44Dt94UaUJFHEOoxmjwAGi
         I6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313152; x=1747917952;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ+Rp8Vuh1hwAKkXODQMHgTnhQSEeDc4lwJdK7+qpwE=;
        b=aZdQ4Mxm3y2WFPhSaKu45QmhHVB/D0XdMIrzCtvcJGOdHQRLNk5g2KXh8OcL7MpxtE
         O/VcH00TdRKrteEb9R8Arl4tdbEdcWimdp4LvimX1jtUOX8ZuYNQWG7wmUF/NEhXDg4F
         UVU9o6oLCfOMKkGrv4m4PoMpHWUNyshaeT31e0MIxwAPuzWba9utUEWim35ZbWHtKnTg
         kfNI34QawzPS99j2Ic4jwra/i9KeTU6fs9nZqAdqbya9uy7eXVhJQbJ1UgzxnG+lsQbq
         JhylIjYusRZtXwEniPvl8T4C+/nnVUutyVhva3hIWj+Osm1UrI/en/zL3qNgq7f3r4hC
         HJdQ==
X-Gm-Message-State: AOJu0Yw4/Z2L56dsNnTu3wKD6MURsUzuc78iEhM8T8FFWn2vDVSHVEA+
	SFnbb3Js/AnaInOrbkpzCyKxsepjFZNt/5bKku/gFmm8c73RqnrqbrPsMQ==
X-Gm-Gg: ASbGncv3m+DBiPwfvljBMK6qDAP40gwnqmDI0fsvFmjBAl1qMm/t1gv5rADKe3Xy0SS
	QAUFkTOX0LGfl5V/uss28SeuomUC8A2BvJPWPJ7thax7ATvCCvGK4jrJPSDRNFkBmsu0o64lENj
	HXJIwnblcuz+MuYoOAtB4wQggXC549HKjYMsVTfmvStn9QUlXMJT+X7SsXwpX5MM1ofkGiUieBX
	Db8BKqlURetfWD28JH1ZkDkvNJYdMppQ9NSF6m5+gCIzbDcbhJAvE5mh7xpN3w5RtOaUeqcVTdp
	I+zsmedM/bqtydxPac5N6Qnb6q4UnS2G/aPrwl1XWg6QaWTmh006UQKl78IxThI=
X-Google-Smtp-Source: AGHT+IGZLfiBCxs8PEmgb+npB/xdb6LRJXx6h7N0pV6ZCB+L/RdXsIUR/Y1Qf0Z6wFnoWqYkITgJww==
X-Received: by 2002:a05:6000:2913:b0:3a1:f6fd:89da with SMTP id ffacd0b85a97d-3a353751748mr2238940f8f.31.1747313152253;
        Thu, 15 May 2025 05:45:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2d3sm23074494f8f.63.2025.05.15.05.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:51 -0700 (PDT)
Message-Id: <dec21f89ffd06d8b307e7f46191be3824bd99b96.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:36 +0000
Subject: [PATCH 11/14] inherit_tracking(): defensive programming
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

CodeQL points out that `branch_get()` can return NULL values.

Note that the error path in this instance calls `BUG()`, not `die()`,
for two reasons:

1. The code lives in `libgit.a` and calling `die()` from within those
   library functions is a bad practice that needs to be reduced, rather
   than increased.

2. The `inherit_tracking()` function really should only be called with
   the name of an existing branch, therefore a `NULL` return value would
   indeed constitute a bug in Git's code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 branch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/branch.c b/branch.c
index 91297d55ac9f..a10b6119b214 100644
--- a/branch.c
+++ b/branch.c
@@ -224,6 +224,8 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
 
 	branch = branch_get(bare_ref);
+	if (!branch)
+		BUG("could not get branch for '%s", bare_ref);
 	if (!branch->remote_name) {
 		warning(_("asked to inherit tracking from '%s', but no remote is set"),
 			bare_ref);
-- 
gitgitgadget

