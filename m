Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAA4BCAB4
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593325; cv=none; b=pIgiDSq24qgpPGPGcyYKLEEub24bx+GZ/8gInz+PxpHD4ypKpXfMTLs6JGPXBMsYIkJAckIwQPDV2oYGOf5jR87WMsJpZ7sw9W5l7H+lLMxbhK0lNxItUUGFxl+CTLLcHkBmhhED+qMyLkxl88k5JEsemYj9k1jo/Kbck7freDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593325; c=relaxed/simple;
	bh=e33Nrs2uqE7guhufI9qVELNqiW1x2auKq+Ws0cEbdwI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eh5wqoz7jy/WB9wkYG6P96cRH6u87xTqWzHJ0I8Nc2Bk0Pi8Y8b6lJl7K4fw9wBZI18ZtzzgnzTJJ9QAezwFKYQZjJW1eI8kCuF8assS1n1l7PqNYTBoCkysyuMaOOKUYa62cnP7W7wnInJiioaP+bo4GS65KeTPSTIIMiRHjko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3vEQtnD; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3vEQtnD"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137f18f45dbso838719c88.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593322; x=1781198122; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGzHRl44aWca8gWu8aVabdXA/isN9I3H3rS+KiETzow=;
        b=k3vEQtnDesSzoYyju9qjQqTb/uEt4Lj7dqw5S4QME5SLpxrMBb6dpcjQh75Y0bBLJg
         /5r2X+a2gGdPoKpCyJaQ43X0hHJxuQWOJSLhhxjBx0xhE8YMsAiIP9tBi2m/RvnR2qBt
         mg2Al+8Oazl88AJR+kWVfefAa4YQtHMnZXxeAz68HR0n+U4s0Hg2nxQLotrE4+lt+dbx
         cwqtuYOBSbhDyDXGd97Lb8we4tVWCNW7P5TvzC6CD8qOk9ZXtvmChWdietKbjXP5H0wD
         fwaU3F9jzzzzJCHLd22d6ipYUeIhWBvwHkObgknKObSyAu1KaMvxMDeMTq8QwyjGI1cb
         d27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593322; x=1781198122;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGzHRl44aWca8gWu8aVabdXA/isN9I3H3rS+KiETzow=;
        b=L2qx3DOWSM++oZkDNKrrrCbYmkO6Vr+q5q4Tw2CPhKrt0pp1FhZ3xDonqkLX50zZay
         GRdslm61Hd74E02tECXBk6K+qEtx/XAFs5K54FsYf6JnvImciMT4UlhpAl1jVHKsOWr+
         qWNN6BfapdUmUjWWyOuCxJtJUkJWG1RMlfnwcL6GBpAX87hLYsiOYkRDCbU7pxyx7XUn
         Mb7SclJdDhEcHk759dSNS/0cs1T8kB+sDB4fFZXpCTkVi3ZA7LYE/v1jD9UNK92bTx8w
         3SvwmA/Gr1p1axVSTvV6P6EmejYTpYuJIQ2h3zdenGxqfQjXtVuHt4E6afiPHU0BSBSP
         AKDA==
X-Gm-Message-State: AOJu0YzDHohRgKArLQKTS45eM/d2r/d0pf691YACTZRMXCahSSdSotIY
	WmQeAJWU0dPEJfH17w/M0pY1MlEequYCRv2smw+x8LGTlY0f493wM5ol2sWKOA==
X-Gm-Gg: Acq92OEmhqBJiso+9Ivu25wLGPiXA51FNRunCxgnAttufxaErOzp9DFaghvdURAjK1z
	nTei+h5bw/bGBz/UosJ3mJOKZFGn5Mh20Jjpf3X+rYIRhU5gUPswMCvMYTcIS30E7P/2TRlEYqv
	v01KfnF/4ku/Xs4NkAHrrgFno3YyO4pGubeIq65heIESzoDYR1Ph9aH4uhTgQa1YHMJslsXU5BP
	uquMAXDYc5vjmSmLhMJbghDnYazWQ6OhMOuZxd2TZ2EolBpKWEgDoCpJVTpFyZvT/OJNvscuG1j
	Wy9GNANw7uRojEQ2pYF9qnvpEqxHiesRKZlpgc8XyYVib1tSUv/vVzv4wcq8INWJB4t1z9vdqNx
	zGlFkBT6On4Fmf5ZprlnmlxWSEebir1B9HtFsR8GXWwnuQKSMs6LQ457cVrX617cSDTkpob6Mdf
	0ICW+SYtn4fpf3zTObeTB/EfWQ5zlpI3jM3fCyug==
X-Received: by 2002:a05:7022:fb02:b0:12d:ca32:5a7 with SMTP id a92af1059eb24-13806699174mr15862c88.10.1780593321922;
        Thu, 04 Jun 2026 10:15:21 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54caef7sm4361559c88.7.2026.06.04.10.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:15:21 -0700 (PDT)
Message-Id: <f48d570bba87f7604158646873b998725a4a9db9.1780593313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
From: "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 17:15:11 +0000
Subject: [PATCH 5/6] hash-object: add another >4GB/LLP64 test case
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
    Philip Oakley <philipoakley@iee.email>

From: Philip Oakley <philipoakley@iee.email>

To complement the `--stdin` and `--literally` test cases that verify
that we can hash files larger than 4GB on 64-bit platforms using the
LLP64 data model, here is a test case that exercises `hash-object`
_without_ any options.

Just as before, we use the `big` file from the previous test case if it
exists to save on setup time, otherwise generate it.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1007-hash-object.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 59efee3aff..f2722380ee 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -277,4 +277,12 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 	test_cmp expect actual
 '
 
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+		'files over 4GB hash correctly' '
+	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	test_oid large5GB >expect &&
+	git hash-object -- big >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

