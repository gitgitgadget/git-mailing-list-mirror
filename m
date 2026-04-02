Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE43B774F
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140416; cv=none; b=QcwSzQe07UXt7Wg2LVPrr46PhXIG563o6fS1YNqF9PqntZOpiyInrA24zAz3XR+AjRxIjdSZcTZB1esAyKbOqdB8LDqI6vFJONvyFpaTbpuLJwQBwvMkC5GHhg2fDrXDEBalY9qqkUzIAeUarX7urqq+wXgIUzY4X/2fIPdo7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140416; c=relaxed/simple;
	bh=z9QR+dxHKisY6SoYg+tNmPyx07WiRTNffuy+zHueBwI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eW65TLBsRLhKhEFQwJP2JxT543sQ0XScBTa1wpbLLcQbWsQHNPoQucrGkDHUOtBLW6h1oS3fIyjvd1Irq7S3MlPNCYHsK9t3/Pgg+3vbf7G5itFCVkoSHx/0Fb4vcSLBsIZB0H/XE4A7RHg4r7tA1qJct4LrwgADR9HIJSlUn7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu7s6XCX; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu7s6XCX"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d1b746f522so110652585a.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140413; x=1775745213; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHajVuVeIAYlSYoJnP2waQUXlSsDs20NLhykM2WZ9PA=;
        b=Cu7s6XCXWY2hqp7FI0Wc9x6O4l9j8jVmBwL+6qg66d/xoBIV9+Jx0lYdwchbX6m2fH
         qnSLbowiAaosRJAGq7KetJOTEBFvom6CBC3sbLkj+FTPZcSmO9X1MLOPV1nDVqX6ACF/
         av+iZsGNlxaY789s0rMTkb74BdIFS5xNziDbFzRkvY6YZrGoh3iboZJvtEMekHzgtekd
         zbprMSeLnCY2w0QIiARoOerCJKgPSbVgoNFipoMhzj/sLL+6EWX16p2hFjwhzwzhQls4
         znPzi8/qz8VekQOBOv6rlnC4dZxMg01XQcaCJ9ehrnjhJfAup/7IBnH2OW6ckVQgHEnG
         OiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140413; x=1775745213;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHajVuVeIAYlSYoJnP2waQUXlSsDs20NLhykM2WZ9PA=;
        b=bqC75ANq7kKoxa5swHoi3NQU9Vmsz1WTNXsfKso1mzZ55rUjGBZgYkowQ1vewuwDAu
         C+r3U3ZCO2c1ccyyU00m0mfKpNvNJqmWBhw+AkBjctqH/cFOcoWaqu1+RgD6P1T+RFVf
         VWa0Of7ZpMkzJo4V9r6gxfevGRITADy4iksNWSPjL89cEIp+i4pN3zJZ/wGEyh/Nka46
         lauu5tFESrRb1J+zWMkOV8qXuolqPorUi3MviDzRwoiU3LZUPWGNft24iLiITSFUtF/f
         jYS6gZjuJEChcDn11eVdJK0t2yM9CWBdsMBzPLGRATJJTFIBJqfUctxcEnI/lFUxU0q+
         hTpw==
X-Gm-Message-State: AOJu0YzFLbDx463gy8L9HR9pOEUxSvPoZ283YdkVDaYMp1c80iyNCC2J
	nv7yMqqaLPWN+DsI0gtgkBg5ZcCcX2SE6CcII3XCFq+DeedPQR6pcNB+bpSTjQ==
X-Gm-Gg: ATEYQzyo9AqIpk6k+LQh45No2HyvPkbfhCQxOmBbGTHbXK4fYLPMnTxAVt5W9wtH3vM
	3eZHKJjU/hgONcMmAQzHM4SexKQpfkSh+YUtU+kPHwhbBfkUGjfj98viY3s9jir+MneRl0TdZba
	n4ywh6R6K2fRYwNbh6B2wqlvASC21YzEOA2zsD+NAsuCdpiA32aq66nruzqnKlQEjomVn52OrOh
	v3JxY0urzdCQPZmwQ+YRrUBhlVHO8e66apLkkaRhPoUpNk+ygm/JMmL2qMMWxheSFzBMF6oHmCk
	qzMi2Q+3pLQFZkqLjy9unJSnC3x9zcwg9PgPk5QKU4KHqULgp/B416CwDnZhxwpioE04UAJXTHu
	ywpwhxRwt6tS+Kcdr0SiekaIi+B/8HM2qVUyE+Am1ty0zIi9HtWENIU+hGOP88Xgwb/gqr0+NRa
	8G3WC127/BH58sr9N3MaHcz5L66YM=
X-Received: by 2002:a05:620a:1a0e:b0:8cf:dceb:8261 with SMTP id af79cd13be357-8d1b5c588cfmr1119520985a.65.1775140413026;
        Thu, 02 Apr 2026 07:33:33 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5933333d0sm27624566d6.1.2026.04.02.07.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:32 -0700 (PDT)
Message-Id: <a084c39273ec9e613fe1c6c982700292f5ddb705.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:12 +0000
Subject: [PATCH 06/17] t1900: avoid using `-C <dir>` for a bare repository
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

To prepare for `safe.bareRepository` defaulting to `explicit` (see
8d1a7448206e), add an optional 6th parameter `repo_flag` (defaulting
to `-C`) to the `test_repo_info` helper, and use it in the caller that
wants to operate on a bare repository.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1900-repo-info.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 39bb77dda0..6280da1efb 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -20,6 +20,7 @@ test_repo_info () {
 	repo_name=$3
 	key=$4
 	expected_value=$5
+	repo_flag=${6:--C}
 
 	test_expect_success "setup: $label" '
 		eval "$init_command $repo_name"
@@ -27,13 +28,13 @@ test_repo_info () {
 
 	test_expect_success "lines: $label" '
 		echo "$key=$expected_value" > expect &&
-		git -C "$repo_name" repo info "$key" >actual &&
+		git $repo_flag "$repo_name" repo info "$key" >actual &&
 		test_cmp expect actual
 	'
 
 	test_expect_success "nul: $label" '
 		printf "%s\n%s\0" "$key" "$expected_value" >expect &&
-		git -C "$repo_name" repo info --format=nul "$key" >actual &&
+		git $repo_flag "$repo_name" repo info --format=nul "$key" >actual &&
 		test_cmp_bin expect actual
 	'
 }
@@ -48,7 +49,7 @@ test_repo_info 'bare repository = false is retrieved correctly' \
 	'git init' 'nonbare' 'layout.bare' 'false'
 
 test_repo_info 'bare repository = true is retrieved correctly' \
-	'git init --bare' 'bare' 'layout.bare' 'true'
+	'git init --bare' 'bare' 'layout.bare' 'true' '--git-dir'
 
 test_repo_info 'shallow repository = false is retrieved correctly' \
 	'git init' 'nonshallow' 'layout.shallow' 'false'
-- 
gitgitgadget

