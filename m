Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429840;
	b=QfHbEg0LTFUqD7KnTGzFc3AUI9nCwHit4LcK0dD+k/JWxADKKgBiS7R5RX7ldwE6N/FS
	 k5Y+fMExFIl1OWLuaw3IqbO79V6bqpBF6NAywYm7N/oEqxFRy+wBDqGvBu7ZCxSqJyTkV
	 8eoQV5r7PLmmT358XRj8Yook6Wv77T+2RnWo/0iEyN5Pnl4d8Rh3AJftXXhcWuK9r4IG5
	 5vJtJoVtxxbiMFLwlTwbSNkf0regUZf8IWvnTKfrbZdfZf6Tl/I0Un9k0vvk+WLr04huG
	 LHszbPy8bSvvuMDGjRdjd8jWY8tHhShkTSb4oafvQWyR/Pn2KQBK4YUG45qaRfSyZ5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=HNwrce7VIP6kGiMHs0lEuVPdj7P79QME4rAtfP+r0W4=;
	b=ep5x+j+ok5roFDxL79bKEZ3Cf2M7pKirdu6Upm+29jyWnOZnYL0aYx9qgA8pIdrminoA
	 U2j8d9efsu2ASKxeYRnw3nhyqds/Zl8ovNLp1XfcrSqjxwgSPK96g4++7gSaGBZv6IXNK
	 jItQxNoJc8c0pRPaRvn6o4cxQytzH0/Ai8E523+yxpdxzLbk9UdtF4oJ1lyFTm/CoODj/
	 7d6ZhuZ0RfAgpBNtDhVvgDeVvsl15VzW9H07IkFSqWg1KX9TRYfJv5tPhFLISj7/FURia
	 spvbiewSaw8JMs4qErg+8nQCysXltbW3scPtkwPGdqHC90rI6SC37s8F3iaaC0nSw9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ES86AWoK;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25286606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 10:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25286606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ES86AWoK
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-55d2dcbb905so6729001cf.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 02:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795429839; x=1796034639; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HNwrce7VIP6kGiMHs0lEuVPdj7P79QME4rAtfP+r0W4=;
        b=ES86AWoKPVUGzMvqOCwTAkxHbJ5meuQjRZwVt9fIOqj823ablRBVvNiBinM+749ObQ
         G6Tl26964+qZvJOD6nDoY10OlzMA17Wntf23dHt82mVma7e59kHneDfceIOaO0b9l+N4
         zTbwKj1hhfw8K2iP10pQmdgJz2eMqzWUYBwSje4LRLzqRzD4Gs6ZlgoYj/UHaOOVk+46
         OBJKQaapytydlGjJ/mslAqVr1GcwGnerO6Xch9q/EY1ZEG0B75p9DVqDur8eCnXQnyRj
         hquZFlP9CfwO+isp4OP8IZHmmtQazT8NlXcSGayNOI9hyHRt3ZUO36daU/yFe9WRV1Tt
         9E/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429839; x=1796034639;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HNwrce7VIP6kGiMHs0lEuVPdj7P79QME4rAtfP+r0W4=;
        b=YaewUr15OsfpadUIG0VXQ/MvB1dF6krLPi6PumHKovkmliAz90Q6hTy35OM53YtBs0
         7YnT/qXqVlgUWArVNDbUCQNBZbpiq5ckA/mlfjZsaQePkHX1oBue3e1yYhtCNtpeFTmA
         aGfzOMV145DXTd02x1cKiQSustLra6NI03wp83zry35lBTB4aNKiNmVlCSSstcwVBdI9
         kkum41AWnrRnGIeGFIKznr2XWMkD5BRU5RjYgLw7ogO1shxe+jRs0HmKCwc+hCCwc4iX
         IkPbO2NK//yJWtuiYrofVrnmv6cJxpCxcB7NXlrl/2dVudPkh1Drr6ngQT0PEG3K6kFe
         i+Cg==
X-Gm-Message-State: APuU4Z8EPWxsYRUeS1o24coh7lsbLr78qeEko+9YHKkBr6OBiW0kOZ03
	LOCytr+zmoYWCO0oLT7V9UYCGsgz2rXU2/2MWK9WmSkrqpTvqIOrCep3eyhh6Keu
X-Gm-Gg: AZFdTZffH8izbWhfF+XU1F5UaskmyL1q6+Ayy+4OTE0K5kRXZQe0vTNzqQkj9qnQwpm
	tLw6MSgC3ZMAW0uyHSMzLvDIQjifN+7BL4O50s7l7R2dhezSjHan90oxmWLO0MsOCI0+6WWqiWH
	btdSKwHqIUpAVb5otl1nuewOjVODHbwtbF94HYCDaqoFQg8lE9tpJkbNAMEpuGV09mwsRkdzSuE
	nf1ccmfpPDfjKwudLjoeJ2ghMmBEiu5ZoGm96mqaTz7fP67U5HELYdvwEiU+UOtbEmqJ2zv+r3e
	r2lphjiQ8dFskUfWZX8THSj6w95ybv3PuC/LP4ofTJjC0V34w6WBbfkAR2HOLbMFN/ymvEkNFQC
	A+zHnXYtOzZxLGw1PXU/QYHd4raXF0mpFz8X7VtN+LvFRqo1gQdoB0iteOUdvtZN/Z82D4oWNEd
	eh5i6y6X7cnw1Y9vg4cY2+tMzFQgOuliTwCv4RaRJp2Z5qHQqrcC56Swf6Js5UbDBZSAOkBKy/M
	5rIVkL82uUOVLHjOat2VXghoVELqi01VLaT8YeEcxHblDk/qDsqiJlr1R/dl6jgg2NDLx8p5cRz
	0/7N5/395Ps7XZu1D15qxjEWtk5Dku8TqyuILUDVqRYDCjulM1Nf
X-Received: by 2002:a05:622a:580f:b0:55d:3682:d238 with SMTP id d75a77b69052e-55d76a1e8e2mr217321861cf.16.1795429838710;
        Mon, 23 Nov 2026 02:30:38 -0800 (PST)
Received: from [127.0.0.1] ([68.154.4.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7c654585sm88291721cf.5.2026.11.23.02.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:30:38 -0800 (PST)
Message-Id: <pull.2504.git.git.1795429837730.gitgitgadget@gmail.com>
From: "Gontu Sujith Reddy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 10:30:37 +0000
Subject: [PATCH] doc: fix extra backtick in git-push
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Gontu Sujith Reddy <gontusujith2009@gmail.com>,
    GontuSujithReddy <gontusujith2009@gmail.com>

From: GontuSujithReddy <gontusujith2009@gmail.com>

Signed-off-by: GontuSujithReddy <gontusujith2009@gmail.com>
---
    doc: fix extra backtick in git-push

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2504%2FGontuSujithReddy%2Fdocs-review-git-push-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2504/GontuSujithReddy/docs-review-git-push-v1
Pull-Request: https://github.com/git/git/pull/2504

 Documentation/git-push.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index e5b1023855..7d30e586a1 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -490,7 +490,7 @@ the remaining remotes in the group.  The overall exit code is non-zero if
 any member push fails.
 
 This means the user is responsible for ensuring that the sequence of
-individual pushes makes sense. If `git push r1`` would fail for a given
+individual pushes makes sense. If `git push r1` would fail for a given
 set of options and arguments, then `git push all-remotes` will fail in
 the same way when it reaches r1. The group push does not do anything
 special to make a failing individual push succeed.

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
