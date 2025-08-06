Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B80323C4FF
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522132; cv=none; b=NT7CEYegTmsXelW4zYQozvcR0gOUCQBnJ6geXMSTvNArQvjGM3QW9ny6J1MfM1y4wo1y4N54duNiFB1cvQ+VNfxPQ/cjgqb+KuftFSMYSH+RL65KvMVDhdBTOCAxbBp8jdjJgCU5fi8zTv+5BFmT4LsWT9kMMe09Qfv0KfcYAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522132; c=relaxed/simple;
	bh=2M2I8bqcLCdkvM7afRDuA3Y0/2HNVp2IqnKAyCEj6uU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U8mx4YHgE6sxwnGAER6FI/VCvchn3I7RUJHtkt+z5sbBc5mvL9/Vd5a2tAgRzDP872i0kXRC2gjzHVt9tUAYbMVu1/8/cUeJ95nex7PHW/gRQ04YcG+NvOl4S251R7YWCI1C8gNV6r907ImrfSr3S8130SfYlthqugmsR39Fu4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkEptgUK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkEptgUK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso2250255e9.3
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 16:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754522128; x=1755126928; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXEzcbGDPIoKae+viDMCg58Me767pGSwl/C6bQNs5HQ=;
        b=mkEptgUKxg8rMSBJIu8p41XR1bDlIxNU4Jf7bg7mubydmEHzh8LnDCdAtuHqpBN9T8
         L8vTuMIv2WW7gK4X0cbGtuQgMaTupo1FALqie4gBmDbUfg5Ce/uzpBRtHJSxTYYaFf62
         mVU3loxkIWzgYi8xygkVKy3V6t2TdFKNIcDqpSeHN02ruAhgI7yu8ITGqYXEK3gbA9R9
         tNxAUs7da9Ep83Rh0TPQAJKdpVvOFUaUQlaj8h+vdEfMBbFt1SQVCL4GXvMCOfdwyMia
         nJ0sVpE3DbmkQgUvNiu6Bp9PPvOZI67gc59A9qSx9QzQKFmo5fTutcwPGCFh4fLqkoV/
         Iu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754522128; x=1755126928;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXEzcbGDPIoKae+viDMCg58Me767pGSwl/C6bQNs5HQ=;
        b=SOeqBddj7DoKqMSEgRFo8P4ZPb6eFybww+Yf03Ve0hbUEk3HauCSaJepAsJaah7zvE
         YjoYPw95w0dcO22jwKovg/5yavLk3goTvfBkidxiz90OIwinXha8KH2twWqZsl8GgX4G
         MbFcGh7jm4dQ999q/siALKgKpxi+B5sC2DH+Fry7lYtkbiLOD9l73avLI1Xptuw8K3TK
         MxRiUQusCcP3ckfmHwkazWpiJoj62xvbGQv4soLrt0ACrC1pJJzMyKQY9LNCdoVZwe7V
         3f3czDE9ZhdATlw5Cs7Xni2hnFOYcMLoC5cU/Zc3cOUiFM6RqU6kRucJ/FgWy2dVUd3x
         gE9w==
X-Gm-Message-State: AOJu0YyMpmfllZap39cs0YelGg0+PZoelY21DoBZDsbGPA9Za+0Bl+nW
	ZL9gpsH5fUgB6Z9IUAohQ1I0QDH9xUJ6uofGpbtt7i5hHq6NyaV/durOsvFurg==
X-Gm-Gg: ASbGncseNrTtZxLwYUA07BOQ9twhhxshd7aII9pdYeAQ/GGP+BFNlsFl2T4VHySLhD6
	s51zeNsylzw/cpMtaeHRSyky0wGS+ZJcWJ6O5VQMCqBKPxg5T3PJlxexB3pDsnt0ZpglSHDWSzW
	SaOrr0GB9ODBxK2DvVuv1u4cnEpQYt8FVcVa3PQVRWEnLrrUHZbM3squibBp4u9jiU37hP1vwKo
	RmUkIdjK1m3Syp3bjdc7dmUeTmOQiYMiHO/91iWE9yzpB5e9PfV8DDi62UsDYuzbUejGhTMMV/Y
	4Y60CpKgjE+zjmnyE06zIcD9LYsD4Uc9tDmHW7aEit4L1FQbPiLH8657t3NHnrZalz8wqMtVuFi
	Oj9zw6DI0S/8LytoGsc0XNFY=
X-Google-Smtp-Source: AGHT+IHr9P9Ex33mWVkveiQ6KIiyiwpGCIxP2AD8rnwRo0+YzOfBTzimkmiXa45ffcRzhuLJP44fwQ==
X-Received: by 2002:a05:600c:c16e:b0:459:d9a2:e92d with SMTP id 5b1f17b1804b1-459e72a2d97mr44262605e9.5.1754522128571;
        Wed, 06 Aug 2025 16:15:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459ee17535bsm12910035e9.16.2025.08.06.16.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:15:27 -0700 (PDT)
Message-Id: <c4caba16c72636c7b726c6753815f7c5f77ecd1d.1754522123.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
References: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
	<pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Aug 2025 23:15:20 +0000
Subject: [PATCH v3 5/7] merge-ort: clarify the interning of strings in
 opt->priv->path
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Because merge-ort is dealing with potentially all the pathnames in the
repository, it sometimes needs to do an awful lot of string comparisons.
Because of this, struct merge_options_internal's path member was
envisioned from the beginning to contain an interned value for every
path in order to allow us to compare strings via pointer comparison
instead of using strcmp.  See
  * 5b59c3db059d (merge-ort: setup basic internal data structures,
                  2020-12-13)
  * f591c4724615 (merge-ort: copy and adapt merge_3way() from
                  merge-recursive.c, 2021-01-01)
for some of the early comments.

However, the original comment was slightly misleading when it switched
from mentioning paths to only mentioning directories.  Fix that, and
while at it also point to an example in the code which applies the extra
needed care to permit the pointer comparison optimization.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 9b9d82ed10f7..325b19b182ad 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -316,9 +316,14 @@ struct merge_options_internal {
 	 *     (e.g. "drivers/firmware/raspberrypi.c").
 	 *   * store all relevant paths in the repo, both directories and
 	 *     files (e.g. drivers, drivers/firmware would also be included)
-	 *   * these keys serve to intern all the path strings, which allows
-	 *     us to do pointer comparison on directory names instead of
-	 *     strcmp; we just have to be careful to use the interned strings.
+	 *   * these keys serve to intern *all* path strings, which allows us
+	 *     to do pointer comparisons on file & directory names instead of
+	 *     using strcmp; however, for this pointer-comparison optimization
+	 *     to work, any code path that independently computes a path needs
+	 *     to check for it existing in this strmap, and if so, point to
+	 *     the path in this strmap instead of their computed copy.  See
+	 *     the "reuse known pointer" comment in
+	 *     apply_directory_rename_modifications() for an example.
 	 *
 	 * The values of paths:
 	 *   * either a pointer to a merged_info, or a conflict_info struct
-- 
gitgitgadget

