Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20727FD59
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053080; cv=none; b=LE0c8s+/sGC4CZSfztBOVJFDqmgAsFpimQyYwMfTcn3ghwbV7vCsucGyrvCTvmmfHuZ+cnMf2z8mRa3tRpR5wwD9CaejpyosSoJ8jkzD2Xz2bxcVmiJni71H3Buhv+veH/pxretUGnMANdwN9o7aVOdImM6KQydNZA/P1tIXemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053080; c=relaxed/simple;
	bh=YeSoSJfgQ2rrxhXu6NVxY6EjtxGyEVy2HWi3lh5kDh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7QMFPM/EGeefK1k+KlWTbPVst45OkRlCLs5RHSnNsmFmpBkmmGNTbgMzJTRSW4GZ74UkRaqS9v0IP+AwvWiKhzx4A/B/q6+LuIWp4gdOTC/FkXWwo16YDZScLEPvmHBqh/bdwFnyRu2G/kfXxt1LGxsaHwu/2QQXim3HrBh14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ndOi4l4e; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ndOi4l4e"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-640f2c9ccbdso2744691d50.1
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053078; x=1765657878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RKSBoOd94LkheRoLvqZr7VtPGIo8oSzYJj9XVCYThw=;
        b=ndOi4l4euMG51sGLOtWlO0JOQZJrZE3A38aLhEH5CtIco7dWIVX6U1FDrlCprckQ4m
         QIGHnFRES5I5Sjhh5RAmY2g83Ll30fN34jqMIgYyWocvUOmkb8JbZ+sVYVXBcmePXJaU
         AN9oLKYb/1vuN1Phl7dOMV/qRBzVzACwngoDQ06JIXPNp3C6BEdRMAkh8D6Dy78C/dWM
         ZXgl0VOBpXcpqNssbv7aoktBO35BmPXe+9ksQKIYcvvIA/ruOlmbRpG5ay3fMIb4mpDn
         Jj6v8U1PcuyTiDf38h086ivJfzfNCDw5FzSOY4GPmzOMEcFPz6XG2DnpWHR4ATUj/hwu
         FgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053078; x=1765657878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RKSBoOd94LkheRoLvqZr7VtPGIo8oSzYJj9XVCYThw=;
        b=VePNAGBwiM8/usG+Ffvjr2HTkApEXCki/GZpmFKGrQYUuuyc0sohrhmJVnQhAx8J7x
         Pw6EtDWsK45Y1s9vR6uaxi1XujN/kdNmC2abNfftfre02i2/7askBFrzjOmuYBGveh9l
         Ouj9/FFGWdeQqsDgKw+dQZ2Be13M3rpBAY7wAkh+D3BzjuTzESLL9m3TkB0ilmSPaYDY
         t4dKX+vwr6ZAOCdv97QZF6BBwP6MKAwVjThaXbTaJABbn4u5T65vPp60fYyxbpwQfPYE
         ZOXUsS2khkQJ1ymicgf0+RbSUHt7goe31vS4JMRt1Pn3GK40CsKazFjKTON/xThCdIQa
         uZcA==
X-Gm-Message-State: AOJu0YxU+CIfum9/TGnEo2+Ohtc9Q/ebLqo1jn4X97gXt7qEkeWQ+xNz
	WPUeMGQUkSI5IfXnFW09tFfCVx3WY206D0SkGTEXF1ORaq9DRmvylrbs2YUt6NipK/TEgYXkvwZ
	5JfQRLAM=
X-Gm-Gg: ASbGncsww5XVxEV+2UDB5DWgBkjdHMvjLyR5RgEbEwsvtU4YLH7v542v92OT0buktyB
	Ege0UAJPZjplJ7m42l4W7dI8kTcUcNWFhDJE14JNTa6akYjgYcmF3hTXO/ximwVqDxILQ2p8n13
	2H5rcetlg3WpNIqyHc0xrZiZ+LH4zOicZ5xZF1x6T6kuLQNEndoVcNnqmhLMQ7FJmfBhH/MgTRv
	7fDf7plARk+7VewRam+3D+GuKdRMr6sQcQNWCE/4Q4iIdwOC6skZyOD+p2LyuHo/Of667EZdCpb
	B4M6fOUzqKUTnWW91GWC+Dkp8Q5SUpohNTLpQS3anqLl6Bnk649P8tJdR2jb7qFrjcK4dZHWl27
	7W6SZ7HgqrIiX3UvvkbdXM0++WwTCP/8TN2ZkUAEB7negp6GGyWd7fJ7V8qRY8hZp1qvF5wjVAN
	I8HBdVi+KiLyon/9SM168jmjT7MTa6Cw3tFqOrQstXQg2QWw8xYEjLSaAY1kKgCypqT2EPEMgOm
	TP9vQPre1frmEuBpQ==
X-Google-Smtp-Source: AGHT+IE4Y/Jus/8JDm+CSFypTPc7Yo1LRS7EKS8U/As/8NX8pWihxmtIFiMRrK06Jb1xxfxk2o067Q==
X-Received: by 2002:a05:690e:249b:b0:641:f5bc:68d6 with SMTP id 956f58d0204a3-6444e7dcabfmr1992529d50.83.1765053077665;
        Sat, 06 Dec 2025 12:31:17 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6443f5bca83sm3319179d50.25.2025.12.06.12.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:17 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:16 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 06/17] t/t5319-multi-pack-index.sh: fix copy-and-paste error
 in t5319.39
Message-ID: <7bd2604561a1470e5e4ef902aa2ba3130baa821f.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

Commit d4bf1d88b90 (multi-pack-index: verify missing pack, 2018-09-13)
adds a new test to the MIDX test script to test how we handle missing
packs.

While the commit itself describes the test as "verify missing pack[s]",
the test itself is actually called "verify packnames out of order",
despite that not being what it tests.

Likely this was a copy-and-paste of the test immediately above it of the
same name. Correct this by renaming the test to match the commit
message.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5319-multi-pack-index.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 93f319a4b29..ca020091dda 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -455,7 +455,7 @@ test_expect_success 'verify packnames out of order' '
 		"pack names out of order"
 '
 
-test_expect_success 'verify packnames out of order' '
+test_expect_success 'verify missing pack' '
 	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "a" $objdir \
 		"failed to load pack"
 '
-- 
2.52.0.171.gd6a4e6b6955

