Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4343CED2
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132685; cv=none; b=NdeLuEszhOk8bFyH4V4MiO9PPBmyS/Wv+15pd896B3ACro9SQw2mzsa6tudKlv7HelopFIyOxgxuqj3fdRGKm5+IOKZ4uHA2b4Ww2upJNR9+m03c/sYkUOEe/vESh9MPS0pAbgpP2o95ozUqAHPFihVA6yp33gcqBf5WMm0owOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132685; c=relaxed/simple;
	bh=G5Km2YQamqtrBQw8NB3nB8JG/gol736+w2W4kCv6iEY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QMuVLbxGpUPEaqtVUKJGcPuc4lbtX57HKwVblZgad4FbQOAxIZIUVZnVvb0ydEREWmsnRatT7kjXxLx2sndcAg3fTKPWnedHK2hMEQHKew8jQsQ8IiQBDbMTz/QtoKsWQ3MjEW3LXlNBFOJSeA/93vSxz0Fp3bpD/KMT97XB+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhXsFvUb; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhXsFvUb"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1273349c56bso15297561c88.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 01:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773132683; x=1773737483; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iu3cVHtgcl/Uuybum5tBdmgCOsW3Ilwm5OhfZyr+eQ=;
        b=VhXsFvUbBZMHXpaNWBzmn6wbafG4Hk8us3dQMRRyi4G0ysOmBjA6iA9lFjoRgjapwF
         dxvERYp5lB1dLNGk83lmRY3qhpbhL+2wTn+MNdfW7AnJTpYiZ8yj+RVrlc4jYZBxOJ+T
         mx00PCXdKlLuzc0Rcb8l67sGNPMkWCyoKKOltny0i9Iia10bvVHgJl5H8/TkcoqSL5LS
         tg8lSJ6zqks++d1pdDMtQK+hr/YLJr2acr0oUXtvp63aHWAYudzxaLd17SfGJcMSoB9T
         TB4Gq3hyyP81TOAJ97fQCR4X2ALp04y/M1+PXU2qnYlX7612yPTagyt/A912HTrASqzi
         aY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132683; x=1773737483;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/iu3cVHtgcl/Uuybum5tBdmgCOsW3Ilwm5OhfZyr+eQ=;
        b=pXDpv2yaaFQpkWojhmu7tqfh2wKo95WWVLRGL93WXBpAk1zbbqavVkBVTXzcuQIYwt
         ucP0fpDCXi86y9s6VdjeJAFKMba1u/ZnnIEBBi4dwWv1vQDy8PjxASs8spshevkqp2pJ
         lQBd0ZOMZxq4SJ3LTimxQvh7CSVBptf+c8Gf16WTDaEkO5+xLTyegH//DE3CdqHSK2Vf
         Q0/VrAuzVsatktlFHl8ZtoMckDdF6KRec1xa3SLwAYVDb8zRsVPHQdSDoqbhbNNWJwmZ
         xu/4ePdE+62EfkhPcFOU1lVWXamQliLV1V//HMf+lbuhonBhLm7MKZas2vDqEpQLhXWb
         HlZg==
X-Gm-Message-State: AOJu0YwSdQRqVuFWOa8lTlDSV0GRtr14/y8g8Ox1YYuONHFyMbRd6u5u
	5WcfpHUyoiOWEdGU0ev2hAmDuH0b4FXTY5MF2yzjXH9Vgf5/2uVlrjmzO7B4BA==
X-Gm-Gg: ATEYQzzn1d/zKIu/t5Gr9ebsUkWBFz2zGeDOzWG3CPhqtk+SpCnTjAqA1PXve1rp2Ba
	IBdBUdCSLgRpG8vFJkk7q96kwGuKBt88Dgu21RsVBeq/E6LzVlrVKz81JoecDn6aBiFzHhCfyEl
	2o9ARY0bAA44bu0BEw9SW/gft9qH/sUmEn55gK1ukFk8kWhEwhV+EQRqC9nMtspoRxCSA9I2R0e
	ZIIOaHPXn7cbnL2OaNwSoNbPcfUhj8nHM2ijN7SoKTtH1PmE/mmovfnqmR/OOXccKq0GaJrEQ1f
	xcJizh7mK/RegHBb/KeiGkDEEkqoXql4i6yjddkTefl2PjvRV5EosFhENS/4WIB7UuyX7fQ+9nj
	JDgRo7P8R4g0wypVvQUBbxsxk3b3gHYLxzynTl47XMxCzjJJy5dSMgFhsMgGHkDJbidI/A0olN5
	OT8Q+NDBjb9ZAUSRjA3qSgCWgZIbwx+0IItHQ=
X-Received: by 2002:a05:7022:128b:b0:128:dcbd:e27c with SMTP id a92af1059eb24-128dcbde577mr1718090c88.20.1773132682492;
        Tue, 10 Mar 2026 01:51:22 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.69.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128d8ee3503sm5944006c88.0.2026.03.10.01.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 01:51:22 -0700 (PDT)
Message-Id: <0ed992956e9db5eb6d3172d7a0aebd05f87cdf32.1773132678.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
From: "LorenzoPegorari via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 08:51:14 +0000
Subject: [PATCH 1/5] diff: handle ANSI escape codes in prefix when calculating
 diffstat width
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
Cc: Arsh Srivastava <arshsrivastava00@gmail.com>,
    LorenzoPegorari <lorenzo.pegorari2002@gmail.com>

From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>

The diffstat width is calculated by taking the terminal width and
incorrectly subtracting the `strlen()` of `line_prefix`, instead of the
actual display width of `line_prefix`, which may contain ANSI escape
codes (e.g., ANSI-colored strings in `log --graph --stat`).

Utilize the display width instead, obtained via `utf8_strnwidth()` with
the flag `skip_ansi`.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 501648a5c4..da6e9e7f49 100644
--- a/diff.c
+++ b/diff.c
@@ -2756,7 +2756,9 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	count = i; /* where we can stop scanning in data->files[] */
 
 	/*
-	 * We have width = stat_width or term_columns() columns total.
+	 * We have width = stat_width or term_columns() columns total minus the
+	 * length of line_prefix skipping ANSI escape codes to get the display
+	 * width (e.g., skip ANSI-colored strings in "log --graph --stat").
 	 * We want a maximum of min(max_len, stat_name_width) for the name part.
 	 * We want a maximum of min(max_change, stat_graph_width) for the +- part.
 	 * We also need 1 for " " and 4 + decimal_width(max_change)
@@ -2783,14 +2785,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * separators and this message, this message will "overflow"
 	 * making the line longer than the maximum width.
 	 */
-
-	/*
-	 * NEEDSWORK: line_prefix is often used for "log --graph" output
-	 * and contains ANSI-colored string.  utf8_strnwidth() should be
-	 * used to correctly count the display width instead of strlen().
-	 */
 	if (options->stat_width == -1)
-		width = term_columns() - strlen(line_prefix);
+		width = term_columns() - utf8_strnwidth(line_prefix, strlen(line_prefix), 1);
 	else
 		width = options->stat_width ? options->stat_width : 80;
 	number_width = decimal_width(max_change) > number_width ?
-- 
gitgitgadget

