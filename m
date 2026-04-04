Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1C339878
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332202; cv=none; b=r213O+y/3CBqhi69bS2+HB91QD9p+49rnbd3jLqpuY3Ia2Ml/KbBZCDfrLaE2a1XZSowuhxhk4yNtYmJV6AAEE+o52z2jgFGu2irEMw4t/FeEM3DIVDI9RQWCnEhplPfCKZvgaVrPMvSFEdVIBy7imFD/FQOTsoOWin1yAfezSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332202; c=relaxed/simple;
	bh=XG5Z8BKHOb1AuADzfLEaXraUEzPLeg9mKDLElANYm/w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Oqf0PF4A7++RhFDGtNx+G7nvPvqCJt6bPEI7l4IldlHocqMoG15Eaa7QwWcEUWf26+bhePC+sQcVhEMYbRKLRtfzk7RyPTcjSfJoKO52gDGZUec3WUxWr97yihFoOnF+Qqvx8/teiw2/uo/w+N5KF4CHEpVM+/UjglvslHBR+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8yxCi/k; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8yxCi/k"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a15ebb3abbso43763086d6.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332199; x=1775936999; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zsay0vdYZ078i+Fl2k2574Y2xiOimamD5CyBm2fi7+Y=;
        b=X8yxCi/kyp0E3pao9MsYkTBzyRngB7TEZSAYWRGGuqEkqMNlkM7DPQelyKc4MLsroy
         LyGDNKuWSwXoRAtICOLYjaUbC2MUwtVz3OzF09pRGlU215KzwwTqYEyu0wNaQUOanXF7
         DpgMzzNsdX6FYXtWZIGbu5H7iLTXGZmNq2SsDJb3hnVpUlFgC6vsUljSmjFEMEyDIdzQ
         TmbM9E9MpkSA4YwSUsb8UFNEf6cjVH3qtkWRFn8kyjVcvfz0Ggm5Eg26Kegoi8bnAZFi
         KwvNa61Uiifr/a6+zl1GDs6LZEyHTmfcPi2DhW5gNzQOXEazep5Mtg2pjYvq7Jpr3Ksb
         aA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332199; x=1775936999;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zsay0vdYZ078i+Fl2k2574Y2xiOimamD5CyBm2fi7+Y=;
        b=V25LrYPHGcEZ+HqNj6vS7a2cJrD8HE/3c+A5Decuzr/GmMxqJO+s/Xvj8GspG5fFy+
         MBepb5JbqvVfSHsmx3NKrHbQ7rV07S06GcDulGdbtg0mFbAfRPhlBp/fdbjeQ6DnAOxs
         R7+PmgIYhawoSWYpO0yy1de1je+almU8/vPiVS11Cow+vd6naVi5i3Xw1IEeznnF1nDB
         xRokUR+Xk6z5XGUwhEZndYt59oJGCRiQ1WHdlY+MBpwCNbnxgSuKsrvrWiQh6bZLGzE5
         Xkmt54ZWkzuScGNFYWLRRqKvN5DX5WrfFFB1Jq2sjxnyhm+KOaKmH1xSpaVdgSmCCZhp
         FIdg==
X-Gm-Message-State: AOJu0YxXs9zvLJ/wBFhF5CT5VDNtUm8K0IrFwNE69G7j0D15oJvixmaL
	pFUpnmA2RYevB04K2O5hYjm+yD0Mlav9xehrqfJtFSL+NOxUHq5qjxRv09ISIg==
X-Gm-Gg: AeBDieuohZ/cgN4timJwEhKZilYyCPhzXLEL5yt7d9hcLz/YR8eBmC6StE+OdB5xXqv
	7DGsrb4jxjwcIq3nHMqM6wcjfR2YZPTdwTBtKKl/8gFO6di+zt9lNG/6UMH3quVeDETqB8+ufdu
	hmYj5er4f6wrZqSlDOhpkneotc/Qc/BATJRuCAk3YZQnwDwR6+BD2Y/KFhvMofqPdBzlXaLSA5e
	cdSMDcN74ZDz1zbBVZttfHq42yWnfLGasPuJz2vKTyZLM3FK9GG6nli3ZjDShPG4VAfHbUT1CzL
	RhauBmTmPcZJCH4V6kIIV+2BI2ml/PqjGW96x48ix+21iOcvLbhvRgxo+OqLt1Bzzk3kEQfK7EU
	jBdje0Hisw85TmxA8XBcS3b1H+mKznvOgWaGVVD1h0WIAhEmw2bY5zWUFSditSRw0vlPW2Siina
	G8xEszDCCUYx3fVQA917jmZlZuCQg=
X-Received: by 2002:a05:6214:5016:b0:89c:3f38:a992 with SMTP id 6a1803df08f44-8a703265cefmr124434456d6.22.1775332199270;
        Sat, 04 Apr 2026 12:49:59 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5933333dcsm75764596d6.5.2026.04.04.12.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:49:58 -0700 (PDT)
Message-Id: <a1cdbd58f0af27be689230b7d8009d93bc34abca.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:41 +0000
Subject: [PATCH v2 01/17] t0001: allow implicit bare repo discovery for
 aliased-command test
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

8d1a7448206e (setup.c: create `safe.bareRepository`, 2022-07-14)
introduced a setting to restrict implicit bare repository discovery,
mitigating a social-engineering attack where an embedded bare repo's
hooks get executed unknowingly. To allow for that default to change at
some stage in the future, the tests need to be prepared.

This commit adjusts a test accordingly that runs `git aliasedinit`
from inside a bare repo to verify that aliased commands work there.
The test is about alias resolution, not bare repo discovery, so add
`test_config_global safe.bareRepository all` to opt in explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e4d32bb4d2..6bd0a15dac 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -77,6 +77,7 @@ test_expect_success 'plain nested through aliased command' '
 '
 
 test_expect_success 'plain nested in bare through aliased command' '
+	test_config_global safe.bareRepository all &&
 	(
 		git init --bare bare-ancestor-aliased.git &&
 		cd bare-ancestor-aliased.git &&
-- 
gitgitgadget

