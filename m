Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F28BE9
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776749630; cv=none; b=sMdYKgXSwajRpl9JDYfzOkRInQImPfGDRbPAtt7i0ftvVc9hF9yHBxE5VAhL9TkFmux264IY9vmanlZwt7tOgKG8f3jVFplyB399M1TtBOAxXF3IcOrQeWwQMNOHrMlxSgqni2qwZylNiYAomGU9ApBd/sUetmLbKB1k65aVFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776749630; c=relaxed/simple;
	bh=k/18KF2lATikXviArO7lSrdoZgeHuvnEovPchTQO1Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuJhoD0O6g/1pYZqz0s3SwodY34WOo9W/Wl/VNxXI7DhjSaxXBEnYJA3JxdrMp6NGi9dWNhWfIMNojg7p3LxTVa2SHVf7ngiHfCuqLSWuv49kTfPngIl7ZdQH1En3NWbPx+2sjNIKiAADzwD7Upu8tXSgsF9vv1tpf+SaW0sCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxgGYt5a; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxgGYt5a"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so3596945a91.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 22:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776749628; x=1777354428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz9Xt9VhHVFFzjSPrgaWJ9iqFbZcOZc4pizgFUC4Av4=;
        b=HxgGYt5aJse5vM7+F/vA1hfSVSb2I47Rb/LriHeZ79n544Z2b8ZPiKkJ6/0FaSNzG6
         bVBFvvDmKSNnAtg7K5m17sCa7SMrqf2d3yVt96LCAp3WNU9F0IoZZHBMsWdNhHASfbE5
         Yebg9YHCZrjbbYM7HxfAIgKjuxQMiIo8qqLeOldC8ViRuyACmmrUc+f2UxEMsImPeez1
         80QV5GUXYmvCj6oX08b9AdV8RvRLb9Ga2oRWK5jYctcnhHd1+P9WBgfCsJemMd3WejNh
         qLpP2tKCKCMOolYeU2pmistACxyWwdSpshKuNuElW58yW88+a7DrnUSgA9JXR4ypgToF
         4W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776749628; x=1777354428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iz9Xt9VhHVFFzjSPrgaWJ9iqFbZcOZc4pizgFUC4Av4=;
        b=hcpeD0IrLBZkWKCAkZWdbynCQpU12gD/00IS+yJe4mPRV653Sm0aw/U0l+5wQw07jc
         nQ8ZFhX6JLVJ9Er7yUzvJoLN1Pyp2RVsXA/dPS3hkggDK+MKG6F+Bcg7CK1AG71qg41R
         GJgTnt33SRmt/izwlBDU9ifjV8O1P52/Wy8uCSjEk+IpboRcutIz+77jM1W641Aixqa6
         JX49jeMQQqumD6E8OvT6m1M+g46etmisf1PKUgxHFIFjUZUM3DVi2qkWQ++71avaqveV
         nPRYb8O3w7+/LyVC2Zjd1sy2ZWn9XVZ7ihi+5RPXnU7Zn/RdXUb724/wm7XY6JpfyTiY
         1oJw==
X-Gm-Message-State: AOJu0YyyzPk/nvOw71vq3CXPdcNcBokycWtnpo65a3NROLPDtH2NsDfw
	o80MQ6lH9X9zB33fvZK/Or5oGnDnve81umrqWI60wf2KgidoL2ghCBGIpsa8Xw==
X-Gm-Gg: AeBDiesefXpKw45X9xMtrIkbMo/WKSV/7h2RaXvORnhHIK2n/wDT4Qy+yMbi6bxU/7F
	xHQOqxSQAVNxl3nlq1u99vTM1OSLSaHboa0I0O+WrQXd4ArzXnNBn/Gbhn7871pjmy4tnMksxcE
	xrk5Z0C+eboq4QMr0+i2sRj1Aumcg3SBEKo1GTs9HlZpvJgu+x7+LQZRi4X6fiJMOtNaCUkb5+P
	KKoiV2qHci4p3R/ylkPcGpXr7EFXfRq8UPkFm+QYSfRlOfFaBZFFU3fDiUfNA36xxkYJ/AsmWsV
	tC4v+jNqY8hJt4B30M1oMzB58qVbfWO0QxBukFkBp5CXspGA5aNSbw8uNu2Kh1SzJ90uHuHF4me
	IATIiHFZzUDqphAVgIH1YekjfaztpGyDT4NlH+BB+aFq6rZoYn6kxcoa7zqb6XnXDOH3shDMu0h
	Ntz5EjaWY/WONCmW8Z8+DZgG15Aq33FalLEQLdoO6WrhRtjwDdAqxefG/lcxoq/GHL5iwDXgxon
	6zzPsAdSwxiXnFwoB7ayhc2DQDfpl4OrxedXh5ZUozgtu/VhtQx63fFpb3QO2QsflJQ
X-Received: by 2002:a17:90b:1fc4:b0:359:8de8:1229 with SMTP id 98e67ed59e1d1-36140490bf8mr18857025a91.21.1776749628220;
        Mon, 20 Apr 2026 22:33:48 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:c0a5:e9e6:3079:1553:266:991])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fa91d31sm6454484a91.2.2026.04.20.22.33.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Apr 2026 22:33:47 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	abdobngad@gmail.com,
	bence@ferdinandy.com,
	john.a.passaro@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v2 0/3] t7004: cleanup and modernize brittle tests
Date: Tue, 21 Apr 2026 11:03:31 +0530
Message-ID: <20260421053334.5414-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
References: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses brittle testing patterns in t7004-tag.sh. 

In this second version, the first patch has been updated to follow 
Junio's "belt-and-suspenders" suggestion. Instead of simply removing
the tag count check, it now uses 'test_cmp' to verify that the repository
state remains unchanged after failed tag creation attempts. This
maintains verification while removing the reliance on a hardcoded
global tag count.

Subsequent patches continue to modernize the script by removing 
hardcoded global state and replacing subshell patterns that could 
otherwise suppress Git exit codes, ensuring that crashes (like 
segmentation faults) are properly detected.

Thanks to Patrick and Junio for the feedback on v1 regarding
state verification.

---
Changes since v1:
- Updated patch 1 to use 'test_cmp' for state verification 
  instead of just dropping the count check.

Siddharth Shrimali (3):
  t7004: drop hardcoded tag count for state verification
  t7004: dynamically grab expected state in tests
  t7004: avoid subshells to capture git exit codes

 t/t7004-tag.sh | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

-- 
2.51.2

