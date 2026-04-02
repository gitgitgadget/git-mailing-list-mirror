Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD4F3264F5
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140412; cv=none; b=CTPyQNpNsVs4AgyI/5hv7+DT+tQGkHlQCb7n1EOOUVnxzhRKaYxIvAKW1SSH7aEmJs/0OybCdV/p8SjHMmSs5muDpFsgnkCYbJtVtKTWtvm+Nw9tJiP4Uhc6OMYlNsu28vbCAfQHUspc7Skp5TLPKkK7GG3+dKiAVvSLmfEBNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140412; c=relaxed/simple;
	bh=2j8mcnSXMQi4KX4rP+JWp9PsLvyd57VyobipgDASfkE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=brQm+QHPR/ATejSEvWm2D1eamhmXyx46ZJHCJ08cEE/n55J3VhB5e1ybBRQ+lFjupZQcjuHwzRt664XFzY8kkPAnOBz5JRK62Mo7bVd9a+DXhprCW1N0XqQSzDfRCfDodCR31Ty2OGcIzXOSsZTsz2Lrxq/EwI6bW4/CQVaEujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKEMfSJJ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKEMfSJJ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50baf2df711so9326721cf.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140410; x=1775745210; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXuJanUDNBqYJGeXEY7Lhz8kXeLpNSOe9kdYkBqgAEI=;
        b=QKEMfSJJhREEPUSx49vWieCgNMy1W2lOlVRc821PiwoYruout41gzKhSGWCoh+1AOB
         OB13i0+vAMJRRi7dwoW+UrdoZ/SHNAba1mGymX9zJyr0eB2o3JgLij218GMLnu9GjfO/
         eWCQwNUW29z+eDxG8XyDgZ4d3PEa49cajvPxEsu2R9utG/hXqlDv7vdc0yJFsDqBmeMo
         wsRk6s8FCMnjmjcokZFp0IZ1PDALRdYIPAEWPJnq1M9Z9r+c5fGC781U/0D3DzwY/6ZM
         AszlX3mhhVGqiuAyP/Z2+XoAr+dsoo6X9wj7FEMPjG4jc5rZyl2DDwnJR3QhMcTwFjM5
         WZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140410; x=1775745210;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WXuJanUDNBqYJGeXEY7Lhz8kXeLpNSOe9kdYkBqgAEI=;
        b=EV+utH2Whr4VklNYp44q/XKZWwYykx7Cv7crWt+7TMmat3qptVDyZ2ji0IK+IUcYew
         VWVG6S07g51PMVjwiiigdnhhceYbrl6+rKJ5n8lQqRUXSJ7oRzbbBvGQecJoBeTxKCsh
         duC2+SKIMt+ScrUcEffDzh4fhcJOmTR/Rl3upIFP+OpjapEChB1AhAXTm401nS74GN6h
         V8OeZ24TT29eBzapzpVG/PNa4DhNS6YcA+DSYXeGUhO4DCUF1635Zwgepsccu5W1g6kB
         x1FhTUmEWjIXhTpjvoliJ/HT/UyEg5VPYd80v8S0PN3G+93UMSL0BSmHMpNMvGak0V2O
         9Jtg==
X-Gm-Message-State: AOJu0Yy2hzktNLNlCusKOdqR8epFjZyt+uI6NVFxypNC7cS/RbtWVH5M
	WW28fIXnvt2QK6zdz4avZYajQeZe93JyrrHIVdYnIrzcGNc5t8GVO9d88kVdbQ==
X-Gm-Gg: ATEYQzw0Cvt4aZiCOaizjT/p5/GND1YSRGxKpD5AthHXNE97S19L81VMw0SI6BFtoIy
	bevK6XshNbr5W8wwPNMsKWZga18wI0dMj2N6VU2WCE4b+gsnC40Xxw4bXonTZ4gyqVAsbL0V+i0
	2iaY1eY9PFkuYaSfvkRrdozPJSxwz7FmQah1LnpbknLhcOXW0+AUD7xk8FX8CtrsYIoPdNzxtWJ
	sCI0Za+FhcnuNsv3Iz/Rlp2thg04ooJyQiqZR+FpQaaJnCAc7cW9wH1gcg4oPWUtr1YHqcZfQ3i
	kLH+1KohdbD6FkBvPODekDqYrUPqRsuznA+ScBhHbkLrfKofN8m9U2o2Vr4LqbybHm/KS2THOzA
	Sdd9b3EM9aNiv0vVeHkKg8i7hVPvHpc6xaAs56S84hq1Q5D2aSSf04nwC+WrgWwlYYCyirKPQb1
	2h7HNPL5Yff4N5NV7mo65/kjMJMnA=
X-Received: by 2002:a05:622a:9d7:20b0:509:1dc8:e9e6 with SMTP id d75a77b69052e-50d4ba33ffemr40960101cf.29.1775140409718;
        Thu, 02 Apr 2026 07:33:29 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b1d331bsm27281191cf.8.2026.04.02.07.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:29 -0700 (PDT)
Message-Id: <5b6bb1863227cf95700fab4934ec2e1dac9570aa.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:10 +0000
Subject: [PATCH 04/17] t0056: allow implicit bare repo discovery for `-C`
 work-tree tests
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

The `git -C c/a.git --work-tree=../a` invocations in t0056-git-C.sh
enter what is technically the `.git` directory of a repository to
test `-C` combined with `--work-tree`. In doing so, the code relies on
implicit discovery of bare repositories, which 8d1a7448206e (setup.c:
create `safe.bareRepository`, 2022-07-14) prepared to be prevented by
default.

These tests verify the interaction between those flags, so changing them
to use `--git-dir` would defeat their purpose. So let's just temporarily
force-enable implicit discovery of bare repositories, no matter what
`safe.bareRepository` defaults to.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0056-git-C.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
index 2630e756da..6b7122add5 100755
--- a/t/t0056-git-C.sh
+++ b/t/t0056-git-C.sh
@@ -57,11 +57,13 @@ test_expect_success 'Order should not matter: "--git-dir=a.git -C c" is equivale
 test_expect_success 'Effect on --work-tree option: "-C c/a.git --work-tree=../a"  is equivalent to "--work-tree=c/a --git-dir=c/a.git"' '
 	rm c/a/a.txt &&
 	git --git-dir=c/a.git --work-tree=c/a status >expected &&
+	test_config_global safe.bareRepository all &&
 	git -C c/a.git --work-tree=../a status >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'Order should not matter: "--work-tree=../a -C c/a.git" is equivalent to "-C c/a.git --work-tree=../a"' '
+	test_config_global safe.bareRepository all &&
 	git -C c/a.git --work-tree=../a status >expected &&
 	git --work-tree=../a -C c/a.git status >actual &&
 	test_cmp expected actual
-- 
gitgitgadget

