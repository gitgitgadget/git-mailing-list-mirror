Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530941;
	b=XgjONDYJgEIHcJxab47wl5zdOM15CwTmdqYoYKXjcRH8hn/kdxDkOLboT/gScBYyDJCQ
	 F+gfO1z/6t1It+KAhneiWXtreTVWQHtL2XaBHG1HkXP2eDo8LmpMJnqEGDcxC7Ik81KRE
	 KxEPAe8EGJQH4u8Ag2G8JkxtGBsXMxu51W3pifBsnW079QsIIgrYUs4tYK25mPM/cxOFf
	 PiFCYohrr4pnIjiztAImUzHvUgRYwx1+XildYdNJYJzUPS9Ty2D38eWMsf+UNyx/WntPv
	 /9ZcDH7CCoQYHPG7Y6EtEgTlj0trX8j6mWAhlL0/vU7cBg9CaNZF0ZGMbhr50GBgDKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=vkPV6YSxtkYsoOzrdGHIvGfbh62bvhqTezdgydKu0gg=;
	b=2bkz2FjJTyTv1EHk0/tg+AybhmcdV4aiiBPpDv3kyClUb2NFEVGWmn6k75xD20xY1Ubt
	 cx8j2i8gAryLfT1Y9eaA7AmpG5ldpr5dL1W6YVusv0Npqli7vx8ocfRIyO3TJbp9EFDKA
	 4VBSVnaSghcQgiFJbd3e+8tQCaSnGM81GL3nNIf63NxjCqWg0TdwG+qsSpls8B5Hb8T06
	 Xm7QjdUFGyu8FV29fhaMBxlJGrjdHGGvCO9rkfgCOIjxNRTo1JPTMMZnbV0O3z1Y2lH7K
	 mRv+saoGF2Egyk4VbdKPi+owBcIE+wJn8zGmvgZ7NSYoxq5bgtqrkEPBHuQEI5iSltg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OqjOH2E+;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14A606A329
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 11:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D14A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OqjOH2E+
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53639b8903bso30158021cf.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793530940; x=1794135740; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vkPV6YSxtkYsoOzrdGHIvGfbh62bvhqTezdgydKu0gg=;
        b=OqjOH2E+hLo2bnZYJYE+6z/sjLgcIL/KI55GW5tajdm8bTti0137c/i0O+gJBFCe/m
         7wQK9vgMhtNLLbjEbBHx0mgGqnhP5s7j/M+X01gj/y9BVZNH9MFx6i3iUeexaxupLjUl
         6eQ7BaG0VhjWBx6jCIePnMuHd25Iv31VlFm1kgDwbMSxfSSKtAkdQo6jeGvy3d7fJuY2
         BVZHMpVIoqOCHGCf0RQu10z32aKNYL8wzRxsJOv4GNVTq61bYHFknFG09TOS/Tn8+KCX
         UCiWLyZTCO+oTk/WAU48f/x1FubxFGEE+Ikvp6ihHLM/GFimCXQE5LfeSEMDm48Dt+jk
         xwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793530940; x=1794135740;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vkPV6YSxtkYsoOzrdGHIvGfbh62bvhqTezdgydKu0gg=;
        b=pn4TZxlnQr/sLOT2zvScUg8iI8bisGoFkJJ9nWtw5BzD3Ba3wX4iu+angXunC/lHcD
         MSdnpD0t3gKVgzkMFZsW5iFuiv+wWTnkt4wmTE+YA54r5b9LTzFwJsC7uqJILsFQ7urM
         4Ygz8VEmuIAFIook98jbTRR3ytlWCr07gSScP18/YQaT/7q6h0IpedreqAvRgamfq/fy
         nnGmPg5Cda/HjBo9/EN3MERjZWZuqrw0l+YR6SyE3edg5MXIr4uZXo/ggVjgmHSWegl+
         jWoAiyAe6vf9zl/0D/tQXLelTeTrabnEs97Je2hvmjpDKm+XYflq1ZkomZn0KFAQEfl5
         qGJQ==
X-Gm-Message-State: AFq9FYKqGdpwF1fQq9V1y8d4X5NYVMGt7lgmRk5ZGTHvIhhvTTjlncvH
	b5y6YYxbfrG3lnlSfZKGfCw65J1s8Yrug80HE0f7gdSQmkzsYvAT657YG87zho0K
X-Gm-Gg: AYBFou3F177+sY8vFEO5y3DIZ0bMVy/Coya+7/Jy2nUlY8ou5FaX2PC+dRhuo08e90t
	qspuPuO1Cknlt7C8Fo69F8cQCLyJBcfgPtAQGrQYYUBUsw4ZhZuFbRxfWoeCzytAylaXdoCuwDg
	qz+jcm/Ei+cIuyn2iior5SNC8oybEJpAcmxkPj9PwT94hRO4369npREHvF7N6UZC3lCdHDtJ27L
	NVrWryISj7pETap5GWef7wNPpzxUmQrlsKlKop+5eAnJRYcGB9eq+85vCQIuTZu8yYO+kCQ2sgV
	5t0O7tKVvgebI2c65jlPt4uwT8u9DAX7vZjPbmIRZ9QXhkm8V8hSzeyuiXhxNm0YhEJCGoVkhjD
	t7Q134zQ6PFZ784utncN/wZVjYVBgEcpq4/Ivucqu7eggNCn2U1fMAklZfqAhA3xUiF3HYLr5rQ
	xQllEtc9cKkhOmwFkZIXSSPTAd0MqISrl436pIEpvtlSexcqlayIjPzKm8S8xkt7uFidLlTRSGd
	qifUW4xaItETsfE1jQCeqFpIT/2k+hjGWO2UnexX1RWap/s08yv8SzQQbRiLRow34yKAk2O8Tcm
	ULScI3Lzjl4jJ6UMrsgdhr/bgRgvLQ==
X-Received: by 2002:a05:622b:29c:10b0:547:9b43:b1b1 with SMTP id d75a77b69052e-5479b43bf2emr3638951cf.12.1793530939994;
        Sun, 01 Nov 2026 03:02:19 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca804eee2sm63840866d6.27.2026.11.01.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 03:02:19 -0800 (PST)
Message-Id: <15e79c5cfcd9eb59b79daa1aee7a54f433d8509b.1793530936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2478.git.git.1793530936.gitgitgadget@gmail.com>
References: <pull.2478.git.git.1793530936.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 11:02:15 +0000
Subject: [PATCH 2/3] install-dependencies: work around a permission problem
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

When replacing `dirname`, elevation is required, otherwise the command
will fail with:

  + ln -sfT /usr/bin/gnudirname /usr/bin/dirname
  ln: failed to create symbolic link '/usr/bin/dirname': Already exists

as observed in
https://github.com/git-for-windows/git/actions/runs/40223871341/job/121274294974?pr=6473#step:3:909

Based-on-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4b1733ad15..ed2d09a0a9 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -80,7 +80,7 @@ ubuntu-*|i386/debian-*|debian-*)
 	# See <https://github.com/uutils/coreutils/issues/10508>.
 	if test -x /usr/bin/gnudirname
 	then
-		ln -sfT /usr/bin/gnudirname /usr/bin/dirname
+		sudo ln -sfT /usr/bin/gnudirname /usr/bin/dirname
 	fi
 
 	case "$distro" in
-- 
gitgitgadget

