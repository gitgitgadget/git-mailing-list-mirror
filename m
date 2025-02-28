Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89851D9A5D
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778650; cv=none; b=nWhTdcKxkuMZtxvstEcuG43rQp4Df22ObLuUs2iV3XWpQ7Ui+hSX0PupIJwUB89n1zeEVF58zr3BeIQmEW5lPygM8KrIU6b9leafrvaQr3XPVqnP1uNhueYWy3923jd4OICML2PBgpdjRCag2/LmTTiW0T+K7r2Q+g4BUzoIbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778650; c=relaxed/simple;
	bh=W4K38PciIoZgzd0qqvYu/91hH87Q50ilHJ7WMwEHi6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0QYOe0uurx3Rp1vTWcQAXnRmZDKK+JKD4pdyapDkw6ZDoyWMKrwTemShVWpASPkgE0Uyph5+czH5MgK3IGnWM4p49lOJAnJ0upibuORj+5cOJwWr6DvbOQzIOsbdO1+qiGkOIVJykmPSjrXFyhZW7G1sW2lJy2VEeLFvkX9Shw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvlLQMFk; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvlLQMFk"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5fc13355a5bso1191549eaf.3
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 13:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740778647; x=1741383447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaSF9TM/cX12hczY7WmoU3wMkop2R4VbxstxYzLfbwo=;
        b=PvlLQMFkRUYw5Fp2qEV02Y4bUojm/MjGMAKi1X+yXsxic4QO42qitwjGHpkaA12aZH
         96N3c1B/X9uT1XZE6ZMBPqvbseZ6eKvemzUBVv2fcoZZ0S9Dqzmp6xiOV/qkDXBkYVXT
         Smty7WbvsrnFLliBtE9XtiMaCkBh132TLp0UNA1JQkYVp+3fTrAJJphEF5hWjtzxT/df
         C/Qz7yDVgNnhz03Gz75kVzvx49fhoqhTSGyc8aHz88/COEWX64gB31ws/+TkF6B48ZHe
         aZycdRjSlZPn8sPlP7fD3ZlbA6gDGMBh52cW0RoioDE5klyGBd87bC0ss8G08P00g1xS
         m8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740778647; x=1741383447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaSF9TM/cX12hczY7WmoU3wMkop2R4VbxstxYzLfbwo=;
        b=PjJspPUimhvx1swj2dU5bbNui1/udrstzKMWqAfjvgDilfcgfChFWbPhO5gNSCSzVc
         d/+H/MYeE9yQ27V3PAUnTb+LXw11O89cf6goIM5q/ftzzhwuBezkiDD9X+bYoctad7XB
         HwRexuv0fcLR9LZ6mwBX5FXoAITAVUR0jlFHUV9fghhFL/wHtEaTcM9ndSybniCsPi+W
         vDBT0s8WRZBQaPXabDLMaGST9o2pX7jYr/QJHPgwGTJienKYO1aTcPl7bPytwElIV6Bj
         +2zRFP7YC2XdrOixLNYDEPdgTZWUo9BW4mYn931OGBl0QfnbxHkUyuMe4zGBhS4gZLiK
         3ovA==
X-Gm-Message-State: AOJu0YxYxwcxce//Gt37npOKMRCeCyXoI31lLowT2O5Mo0gVPKL9KQ+U
	JNwLaQLvYgA36/P3OKHUWck+6cim2MlymVrPrlRu38+fzqlToClu46hJ1WhD
X-Gm-Gg: ASbGncv8ZjjMMyPesdBPBGx7HdeaK87Ha15EgKl5TqAt+SSzFG+ATwM/EXF+MMbQeBL
	LPNCboxaPKCLq42gLPReWaimzrIveW3B5G2gzeZ2HM+uwo044SypbdflsI+gbh4laqS92GxPicF
	IM9Yns3tlFFzUY7h6vxYA+EAYZYF7GxGU25I2eFQ+Q9kCYr5p8V7gW7Ec0qnqvWY0sGHx4aVRKh
	1nmIjC6NxE39XrRJ9FqxRHLOUIlec4oH1SFB+eGXIRXe/ySUlUblNyk7TttTzypRN6Wv94k7VlZ
	JJyZyOFTs8km384TmMRyrns+y2EKbyU6YLOyqKzhhNv8T7ygthud
X-Google-Smtp-Source: AGHT+IFI5OkTphuDdbGemCHjIN1ivktVA7KNo3t+9Bd77Vyq3iPE2j99xaVKb6Lzh3dOS3vJdz8BVw==
X-Received: by 2002:a05:6820:1629:b0:5fd:896:f222 with SMTP id 006d021491bc7-5feb355e110mr2978841eaf.4.1740778647185;
        Fri, 28 Feb 2025 13:37:27 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5feaad46205sm783589eaf.36.2025.02.28.13.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 13:37:26 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 2/4] diff: add option to skip resolving diff statuses
Date: Fri, 28 Feb 2025 15:33:44 -0600
Message-ID: <20250228213346.1335224-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250228213346.1335224-1-jltobler@gmail.com>
References: <20250228002604.3859939-1-jltobler@gmail.com>
 <20250228213346.1335224-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, `diffcore_std()` resolves the statuses for queued diff file
pairs by calling `diff_resolve_rename_copy()`. If status information is
already manually set, invoking `diffcore_std()` may change the status
value.

Introduce the `skip_resolving_statuses` diff option that prevents
`diffcore_std()` from resolving file pair statuses when enabled.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 diff.c | 2 +-
 diff.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index b5a779f997..37cc88c75b 100644
--- a/diff.c
+++ b/diff.c
@@ -7081,7 +7081,7 @@ void diffcore_std(struct diff_options *options)
 		diffcore_order(options->orderfile);
 	if (options->rotate_to)
 		diffcore_rotate(options);
-	if (!options->found_follow)
+	if (!options->found_follow && !options->skip_resolving_statuses)
 		/* See try_to_follow_renames() in tree-diff.c */
 		diff_resolve_rename_copy();
 	diffcore_apply_filter(options);
diff --git a/diff.h b/diff.h
index 63afa17e84..fc791ee2cc 100644
--- a/diff.h
+++ b/diff.h
@@ -353,6 +353,14 @@ struct diff_options {
 	/* to support internal diff recursion by --follow hack*/
 	int found_follow;
 
+	/*
+	 * By default, diffcore_std() resolves the statuses for queued diff file
+	 * pairs by calling diff_resolve_rename_copy(). If status information
+	 * has already been manually set, this option prevents diffcore_std()
+	 * from resetting statuses.
+	 */
+	int skip_resolving_statuses;
+
 	/* Callback which allows tweaking the options in diff_setup_done(). */
 	void (*set_default)(struct diff_options *);
 
-- 
2.49.0.rc0

