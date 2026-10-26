Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033428;
	b=qRXb6mwOMwe2uMlC5+sVlZqaRuHQ4AfpOjyWEfATRPDegNz0MswJvhk1ph84QVdGFyXK
	 eiV8jcguJHIvBzvuBk/pAw1fa0Vl2tAUBYMGJ0hM/xc/mDRPdITNJH6SH9AuUvrzpgKbW
	 IMfTPa5H5ovbYctoHZ47j4l5KXUFEA1qpUhjHqJLWXNGFlCjVzOMDJz08yFamax/H9pls
	 BYqwYUND5efa9K3VWPCoSLXKnVTyR/xXMX6CKK9NYF7LW/JiiqWFOMiVb+jeZUVJaUdvm
	 l8dvLnXe4eKBl+G7ZJLx1lLTlmBj3ZKsQSbc3p9VE/5/H7e/w5xgoWKfCC44LQLmusg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qm6yaG6t0hoD8ADbx7fj48sL09NDQ/wNfeFeoDt3Sv4=;
	b=RkxcZbWtAdEcuz5X0AxvT23kOQkiCAG0Aqen1XMipX+nk6qG5OVqBF5+7I00z+l/K7U5
	 sn+c/NKjvYqnFeZrF9r/yFfpKfzSaMdxH2NvRp/OaTi8nL40KWF0BubaZtVNnsNg5zMVp
	 ZYj+eVe4E2ZiIcfUxcPiJ3F3ccJrF1JqoI6X/su/fKZDAGFPpQdbjzN2qekgF2ZDOmQpF
	 rhW07u1aK2xBVUDIrlno7x3JKYFm3BvG+HT0NnnrKNEL50IZdQJENNvqUhM5nmaTVin3Y
	 phJ2EgB5Vd4Q2fMNoRxfoWC+ug3xp/P3gOppgDbtIglFbQjAdE4q2NWMJcCAfK4U/Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AoSXYgbW;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362BB606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 362BB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AoSXYgbW
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so5580417c88.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793033427; x=1793638227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qm6yaG6t0hoD8ADbx7fj48sL09NDQ/wNfeFeoDt3Sv4=;
        b=AoSXYgbWzvv+BOZnC8/NFFkVrqkeEE39lyujKOBkRw6JFLKwmYvIAzPjJ2jEPJeC/4
         ePBviM4CEjeE+9mHJ3OeGKA4Mz+fI1NdH8+92x1DT1V8OfubyEl/FXEPEYtcFtz1Fq2b
         2nS7tFp3Bz2u1q6t/e73LNL69VY9S8n0iDZrxmMhMKGkvM1BSco4aKGxNVp8YadTsMEq
         WXbmu+X9e3egGnpWdUj3PF1KXsZJu/kkltX9zNXGzmbWFsfx0U5PYrviDlEp0kUYiwXa
         PRkQpmdLShrmudvEBu6HlowY3//J9STgTLBMWRgg4kOxqzTGyANgq65kp7Vq40TQKB1X
         1PzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033427; x=1793638227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qm6yaG6t0hoD8ADbx7fj48sL09NDQ/wNfeFeoDt3Sv4=;
        b=P0OlXyrljzzgXkQgCgSRcDCj2ta2q8Ma9fHCUKzwFzb7v3fPLZmgHAouq29tJNNSUV
         vUH4xlTmd8W0u2tUmEeHSnRcMx/3flsV+RaxG8H7oAdOp3UEyTNLJfG4IasKAK0rnUEm
         xq+V/cGb8SkPm29bPq8aqK/O0wDZrzIGiOrFIb0OjeJWndE9GFpAEi80CR7w71K6B4TL
         IizSW8oH7doXgVUVknV4fVfrE8cHUrRBVqA18SHWrVmql163mpxuDlTFcHYUCLFvsHAW
         LA2/KEJugXQHRGRdLkyTZ/lY+ED7X5XzVanAH1yRqx+QC94oHFecbAmP9RTY/69IdaA+
         SsAA==
X-Gm-Message-State: AFq9FYL4VPpu2p4qbUCL2GTIK/5qiGZV1iJol6QmHTgK8ma48YJz3HZ3
	S6TS54VAt7QDxHIDW3rE9A+6c32dwIIqvWmH3BAx5tw/nFhVDiDvbVuPxqYuQg==
X-Gm-Gg: AYBFou1vU4JarEp86sfEiq9ITLQFUQyd3VICEGGHTJJmLY5E6tvs2ypeVFDU07AfFfe
	S2ugs0T5Rpis0Ro+PEWKHXqn+Jw5/2EmTAkm3wjKcXFFO0MZowKGhreNvXG/wcNPETukmeSQ2ee
	PHsNBIuxjSRzZJrBnbGb3kEnDD43aTK/51rzIcaLm+Eun8F2k9MHaRQ5VFtjdzi8LPMAgGhRXVH
	7IUcZ5KJUr2hoWGn3nZM+n+P0PUxPwHWMVgm8LTVJHcJNvOSfuhGfgx7CVKvTaGixM2z2AjWZbS
	/fpfvF/PQP8O5fPr3zCN+NdszUlZrzAcqaPqPHiYlPHMYdxLISH08ahsUEoVOb2fk2R808CysVd
	tYw8qnSlyOBuYBqcxYsZ5u7iDu/sYc/YKduEW/dSEWM4qtUtgnPXt1qxlC6iSsuAOWmtzwya/fx
	R3NU3lE81Ftt5YVqw1xBMCvGicxdszzeEo8F1ebnZl8PyQQQhBoEJCx6EwbCdixBdw6LwriUL/a
	YfBhc+QG/I6Y3tHvx+ydiWkD91FMySqn7pWFVA63W0by6x2W9iDnHawqO0zwSGbirQrkwGomjRy
	D3XIYJNntkvwcHlF64aD
X-Received: by 2002:a05:7023:b83:b0:14f:8e70:fad0 with SMTP id a92af1059eb24-19935905e61mr12397599c88.33.1793033426892;
        Mon, 26 Oct 2026 09:50:26 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:38f8:42f0:adee:4c17:ffb5:2796])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm30454266c88.6.2026.10.26.09.50.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 09:50:26 -0700 (PDT)
From: Tilak Kumar <raaztilak07@gmail.com>
To: git@vger.kernel.org
Cc: Tilak Kumar <raaztilak07@gmail.com>
Subject: [GSoC PATCH] t7104: use test_path_is_file instead of test -f
Date: Mon, 26 Oct 2026 22:15:36 +0530
Message-ID: <20261026164536.50520-1-raaztilak07@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the helper so that a missing file is reported
with a clear message instead of a silent failure.

Signed-off-by: Tilak Kumar <raaztilak07@gmail.com>
---
 t/t7104-reset-hard.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index c23d6e3f52..acf145e69b 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -29,7 +29,7 @@ test_expect_success 'reset --hard should restore unmerged ones' '
 
 	git reset --hard &&
 	git ls-files --error-unmatch before/1 before/2 hello later/3 &&
-	test -f hello
+	test_path_is_file hello
 
 '
 
-- 
2.55.0

