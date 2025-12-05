Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0851F2E7F03
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946961; cv=none; b=FuQ6xBPuM3l1HWqrA8tDA6tBQG+ZD3o5ZcNZv2SRAO8YZApNtR/Dto5EUU5+G1msnzPgke7F+fqUI/btq+4fTI7rpYM5XaUU/xG1YNmWmd+ownsegbNISHhrE93mKXw7WN0VAfQy/zDp+fIOwr3oU4k8jn57nPYsSiiK5uFqXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946961; c=relaxed/simple;
	bh=4ikaidTQUswM7Vl1vRvk9Z7Tn6vFM8tIAzH/uuuXmn8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VMLzyI0aA6xcvgq/8nYNHmtw+1yVQOtfiFKEYfNztNj/RcvVl9reUDYzTILI0brQI2+RhGvBtbo98gpNoEF1fqDqPjGcG1xER4KNjQcN1DTOWnQP/KZ26Fl1AZL4KcU5DifWjmE2QzWyu/59q2zzVryQ3op54wyB8+916bwWrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV0+yj2l; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV0+yj2l"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eda26a04bfso22429581cf.2
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 07:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764946954; x=1765551754; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhYLIqJQiI29ooMc1E4iqbRn8GunyFNz3LunG6Shb0c=;
        b=WV0+yj2lrp8l0k1JGEk7IIcT61LesTnbc/g2ztNgZbQosvvGX0QFEu73xWsTdwMQgZ
         NvDojCzHqeXVvrIr+3SEhN5NrrWi3z8XkVBhiBNLIEp7U45BKRIvmgWZ/7Z2n6irq5oZ
         pDD9X71UV2xDM0vs+hVu7sFrLfnTCT6+piKiXVCO5vN3IQ1cfqwT2WL+3BNmpsh5GjWZ
         CnunajWMr/lMFb3tewNBBQuO4U4LUrdQH8OirdBfHlpyE8Jeui7xWU+bMNKinMNIU9w1
         eiESw3u+DagZYoSHUMzTZEEeJQkjL9aP3lN72JJztAjyDY1eTOdmyYOrH9fu75T4Q5g+
         AYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764946954; x=1765551754;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhYLIqJQiI29ooMc1E4iqbRn8GunyFNz3LunG6Shb0c=;
        b=AmzJ+/fVLbH/XvRtVVrtUBOZMBgO9vT+IJIo/7spOlcm5cYsDrVesAaiPArqZdZT2T
         FlLTymrDGZ3NInqd7G5rg8BR1L5+J4xn5TuUfVdT0yqy+/G1USaRI5+Yp2YV3rtKI2/h
         KqiKYQ7ylqUWop/z0pSCzpGSGTzzFf2CYkROUyjMWPVSOBQvCCSNa2jxzJRoegkvuQt9
         SyzQhsAbMc5PoP6z+Xqi4dyxy5dYSG478mrYeQHK2Cb+K+R8TkhTuv2lnRCylKvZm5Bo
         yxYzR9GUD/TvnGgSxF5gf+dqNXVZXTvHC550aDMSWRXndYMOQo9rMkMXdpcLQ9bpI1UA
         8Jnw==
X-Gm-Message-State: AOJu0Yw3hCrD/zUKvg02+35zlu5nEkcwwX94fleJzrUt67HKFJf3SuLM
	hdRo3y6PICkNCUY5FsKzbOCyFEBAoeWX1IVIfSjRftZU9mKHZO3Lg4yuPJJdxg==
X-Gm-Gg: ASbGncuTvTKllcIbBLQjr1F9h7GNwwgG5TG7gESFLOVEI+AWYYwM/TMVkJPl83ris/B
	3w7zOsSPhRedQWYqeba7ObhvowQrFzZO9TUP6x3Zy+ciJFjuiRENnegfroAGBctQPNWopt92a01
	/aQ6pSo9EEebhZlKgUlNg7bfk+UiqDM7wgUQChdM1LrWEfYnycXBJKpCfic2VRM+673DDpcNI8B
	UR5b3z5PvbGbXpQT9XHeT5skozgRtlBiXwVCJcDp2Vr3s2CGpeevCQVI5+6rhGWXtLAvFXyYKHq
	A2L7LLFW/5jZ/aPvdS+Wtnd6Nh/pDy1wCL3+tKJ3X65RynubjyMiIEbuPjYYdaTZTcA38akRZxD
	5DQ4PhdCAFpm/20X58RFb2/X/xyU6r8tYAJdcJ8Cs43OdLQG4EtvMYAxVp5zfS8JnJm2kC44mOY
	jci4fDn0HxP+G6
X-Google-Smtp-Source: AGHT+IGlng2o42uJTq+cmUgKZOmjUI9AKCI2Hor9dxvdwLGhduftH0lPMqHUsLdsbAx/eV9qdsYPfA==
X-Received: by 2002:a05:622a:303:b0:4ee:43e1:e591 with SMTP id d75a77b69052e-4f0176563bfmr145787151cf.58.1764946953265;
        Fri, 05 Dec 2025 07:02:33 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f027d0261dsm28234141cf.19.2025.12.05.07.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:02:32 -0800 (PST)
Message-Id: <3db0599d9151c8c112ee7efe25825fa048769a62.1764946945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Dec 2025 15:02:20 +0000
Subject: [PATCH v2 05/10] t0301: another fix for Windows compatibility
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just like 0fdcfa2f9f5 (t0301: fixes for windows compatibility,
2021-09-14) explained, we should not call `mkdir -m<mode>` in the test
suite because that would fail on Windows (because Windows has a much
more powerful permission system that cannot be mapped into the simpler
user/group/other read/write/execute model).

There was one forgotten instance of this which was hidden by a `SYMLINK`
prerequisite. Currently, this prevents this test case from being
executed on Windows, but with the upcoming support for symbolic links,
it would become a problem.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0301-credential-cache.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index dc30289f75..6f7cfd9e33 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -123,7 +123,8 @@ test_expect_success SYMLINKS 'use user socket if user directory is a symlink to
 		rmdir \"\$HOME/dir/\" &&
 		rm \"\$HOME/.git-credential-cache\"
 	" &&
-	mkdir -p -m 700 "$HOME/dir/" &&
+	mkdir -p "$HOME/dir/" &&
+	chmod 700 "$HOME/dir/" &&
 	ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
 	check approve cache <<-\EOF &&
 	protocol=https
-- 
gitgitgadget

