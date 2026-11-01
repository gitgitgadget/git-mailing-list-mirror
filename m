Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530940;
	b=oJVql6bqB170WdxCryCuR1FMoki/vyfTjn5aO3uX3wyrcpME5hhzdgUPnWcfd0ksnBKP
	 +BZA1rraO4XAp2Atlsjh7HDIb6kpvsIN1qsBtXT00CYRjy1T16wcU4phmsOccV4zwyiFk
	 1TNnkAV7O9iuGRJ5zEhGrNeozdXCJx/+lK5lyoNKtPU6eaHpKdqghsQkuQyxpWonSJNh7
	 RwbkKvPaOJ7O57zwCgB2jCeld8rgrEZw5UErBzIzj03z5MSe0/Ev6A32zaUgjXBN7xRV6
	 Jh3eJtwwa9OaCoZYo33zJZRkql7Mtf8pjxyXSfWHwxqsaWSaFjuu7hE+DefgUowhy+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=k5SPawtAs0q6/ggFePqMfLegTZixtW+6tZQEDP5+O5E=;
	b=DLjblOZKxToxu9t9xBT2igLNsTmNXRWlGTWZ7T757tgg8ZSsceu/t2HCC3ELLWGAeBbp
	 CwJ0+fiwj/EAF9IsIWqH3vECty0JoHK7gjGygaeIMiReFGxB/APeiPkm3yzNewwXIo7qY
	 XsEQCQ3r1yo4hwwgv4pcRQRKMt7A1CY+gwF5hgqRVf3QPR1RdIsd0C7FRe4D8pnkofoEc
	 Fttq88efb0sDIl+bUN876DjdRP641gJa+gP5zrDjX4cTfHWNquv4YUQ4cWQm5LOybjyCr
	 vaef4VsMVG/ASXoRo+h+W5jTl0WgpNX6pVF4tgrBfZ/Hz6kvX6ZtXh1vG20lZBpnunQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lGe73Bb7;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426B4606A332
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 11:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 426B4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lGe73Bb7
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso18480386d6.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 03:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793530939; x=1794135739; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k5SPawtAs0q6/ggFePqMfLegTZixtW+6tZQEDP5+O5E=;
        b=lGe73Bb7hR0OBjX4oqQYIHShinqu8y4zEGeCbiBXgQ+Q5R6wdCsEl3f+4iIq5zK0cv
         aIpp8c6TWsnD8ghqREOrkC2F6i8Ax/2p4+kovctUjfyhllHIntvikSWYY3VsOcGud2YN
         qJFLuiSahRZgyB7wny78wPLd75GBsDoEDd1e9rBE0bdydglzokiDIeiBd658UWkRCRH4
         GwdHOQvYabo6GTLhpOt44QHS2i3xheEAGPu7L1NJHJcupZr5MGTqteCi7GGVuuSJi30C
         bktC8iGf6tCDcqrtj89nJzlPJeS9zAaQvxo8LjpRi6AvhbcllANMBkC2GPFMxO6+J6uu
         4x0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793530939; x=1794135739;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k5SPawtAs0q6/ggFePqMfLegTZixtW+6tZQEDP5+O5E=;
        b=q/KEcrblrZPrit9Zzvm64AXMs99buSt105iwD1q0BNWCY7DgFygL3YUNGqSXu/BvR0
         OHKDONLGOtP473sXbwRawEF/CHbjrUNH+yNbUhOOIYw9VryA2ZEcJRzVEIG65s2T3XZv
         eShSsdz/w1Dv/MZ4ChC1HI7jI7+4nlfGwpBG6FGfD+RNxZOWQHwlUZKaCpEuFqiuF53A
         ikMl8af1e8aJDPmGwxNHjFLkFxYkYRGWXkIztN8aXF5Q9Yo+wJhZQioLgaJIcIU+56tX
         YlnVNTL6fOlDYnlaPiOMOJKCSAPDz/laWUXCEqTcE7XnadYMS1GnQqVtGgnmkRS84wkk
         VtXg==
X-Gm-Message-State: AFq9FYJkmFN4DIzwEvLQ+VKGvvreriV5e3kxK+ZY/Yv+OEeBT1Gp8aaK
	vThONw0LwJorWD6lv5ceLccMx4cEp5wzAJ52IqQpbS1FS+l+oOxrHgkHfqzsNaFw
X-Gm-Gg: AYBFou3ThG0MHpfNgq7sNwHwhwMYNk0YeZ3ibYKhLpXys3cIFYsfRfQqj3DDhDrNoaD
	ye+jNEwm4kqAq1oOCOAm50biDTwsKpXdUGslucOS/mCaylAafXfAkpMiu/NOZDA1e+d/mAluYNj
	WlunlOuK23jsjxdjsvKSmGIaFRxHBX9cLh1QIrJelqNJnB/h+lK6J9HdfZ8QPjVhucmgwxkBj4W
	PiTGSLNVB5j1wm9SMRSyzBOGQSwUqUfIHsYMhIBsA08UQ+MVGw8XoxhCnozhuIBgmnTe6joirOm
	6g1FzC1QLJyCPbFHzrG17rrYTvTeq1IpO9fe2g5Av9woa7q3oddREEpWIWMwwEL6aha0DRt/NbM
	C7e/7qp1kVQNrRLKkWo13OAA30b8ugDGap/HTNt2k/wqjXDL9qSHkZsL7N59XV+1JBkPy81gOxl
	bz/vLUj21201W/SS46TfpnM0w/D3fpGLm5/6a/CEymg7v3TWxg74F79jBmwvXe/U+UQVE51HKmp
	aeI9mTBB9uNeYHdyosswd3rLABezOZ/Z/1lqTI6mimIRlwFYuKq5nvVj2SfO97PdbT0qEChcmjy
	9axs+/bDXKHzpkoH+f8Ud4VJZSHMig==
X-Received: by 2002:a05:620a:a410:10b0:944:ee18:4c08 with SMTP id af79cd13be357-944ee184d13mr372543685a.20.1793530939091;
        Sun, 01 Nov 2026 03:02:19 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944258470cdsm579574685a.16.2026.11.01.03.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 03:02:18 -0800 (PST)
Message-Id: <0c9bfa3b840e4fa49f481f67e3e96bae1b911418.1793530936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2478.git.git.1793530936.gitgitgadget@gmail.com>
References: <pull.2478.git.git.1793530936.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 11:02:14 +0000
Subject: [PATCH 1/3] ci: use apt-get in the linux32 job
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The linux32 job prints

    WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

twice, once for "apt update" and once for "apt install". apt is meant
for interactive use. Call apt-get instead, like ci/install-dependencies.sh
already does.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index d488fd10db..b564927e2c 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -449,7 +449,7 @@ jobs:
     steps:
     - name: prepare libc6 for actions
       if: matrix.vector.jobname == 'linux32'
-      run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++6
+      run: apt-get -q update && apt-get -q -y install libc6-amd64 lib64stdc++6
     - name: install git in container
       run: |
         if command -v git
-- 
gitgitgadget

