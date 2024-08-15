Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629A4AEEA
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743076; cv=none; b=n7VGJGP0XgbMguAtzuEe41qAQH05T9FgaqgVgu5Vh85ZNW19kPdMtHu3qQBkareZh2rw4lX0dfAtj1k25FuMgMU2lDEEsah7HBviGleN4oDq76EtLNBVkUkWc73NpPLi0cdtW0ssQQwoKzM3VLewD1QQ3YBXDt16Ouuc3+j8vVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743076; c=relaxed/simple;
	bh=cGB+kZ1Lv5bxlSgmP9X68KGd8Nd6D1/JFoOo4+Ar5Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0NVes178e+cbQQ74vXrZvY+T5rN/JY8P877Q3pwmyqOZ6eajmiTkax19aImeFkjlfsPt50r9+/h7Kf8uNhsY64zRsJG5vOEf+UgXkdCLR5heIQNt5NchZq1SrYEZ+1LLhPbTcaTmq/BBzF8TVts5k482T8UVr+9IKRYyzwtF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=B/db3fQa; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="B/db3fQa"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6aef423f80aso11742907b3.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723743073; x=1724347873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vf187ru7pWdoDefzHhSdkxX6HKrnt2ZpTFICpPJNfEE=;
        b=B/db3fQatNgnuWvMe/bcBK94oFH0jwkGclxQ596yc8IsdlEsz5KsurRqOOx5tFV6yN
         szWUhGHaWsx7Lxa2noIIxPLan3SZmQA4AhQ++POWiXOy9J6+jfb36NeUtelKnHq+aAZr
         FUYeNu0RKq7ZfSE0PB71/QjzJxzNsmVFtEbGFfhDlOxLbEi/11glkrV0T4CAtHoLCX7N
         2XX7NXIEbJ+zMg/NDsnTRIhiiINuNsp1Wt+Xi+8015gjTAp6kErn0XNedVbsCoO2Udsz
         6/3a9m3uC/cwZ/t2fOP46QR9ETctyfGE0SrJuv/PoHq1YeoU1MM1inkA1snjN18rJMhk
         Uknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743073; x=1724347873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vf187ru7pWdoDefzHhSdkxX6HKrnt2ZpTFICpPJNfEE=;
        b=cEPw4Y65suz0OEk8WInjPmJmNUL1VH37+l62Wzt6WWk7cD5y+8O5D/EHi4rBpAzW6E
         ZJlTSxSWyf9Foc0nwpFzNh/uEkcXsTeIFmhD3fVlysoXeRW5hj5Mohe5mUgMeFCiQBcY
         PF0KDXv+kHOUx6bHFCrotUYbKRmZTRlNJJ5DNMPcI1YYRpa5hCMOU/U0O0H7lT9juc53
         0jA+JNgx4f3KKDtWnfuvTMUlpTbhvhaGilFNkH13ztoEI0SZT6ES/PHHE/sZZ+fbn6gB
         qcmf50bKNHVl56EIoDkVAIagRPMsKwmUGo14P8A5oSKpvFzBW3p/BhWak5gVkGDbeVEm
         /aqw==
X-Gm-Message-State: AOJu0YxmZI9LN2+5CJ56yjzr2XEGnoktgyw6bEPm5dWgxpYET+eap+XF
	cz6AUQqJdi7JPfPliIY27Sy+eqd8Oobz9mCt4814iZK+lPhw4KiFm2BseM5ZabeQSV3vM82kh98
	z
X-Google-Smtp-Source: AGHT+IESDkDGKgkkX/2qSKsmQiQ54pUD1TxvaJQr3SEGk5iiXDqzNl6iC6+30ELFXPU4FTAqDmnS0g==
X-Received: by 2002:a05:690c:d88:b0:61b:1f0e:10 with SMTP id 00721157ae682-6b1b73a7db9mr4087147b3.4.1723743073265;
        Thu, 15 Aug 2024 10:31:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af99506d83sm3247587b3.9.2024.08.15.10.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:31:12 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:31:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/8] pack-bitmap-write.c: select pseudo-merges even for small
 bitmaps
Message-ID: <0fea7803d86ca17451af408e1bf93c32690edc44.1723743050.git.me@ttaylorr.com>
References: <cover.1723743050.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723743050.git.me@ttaylorr.com>

Ordinarily, the pack-bitmap machinery will select some subset of
reachable commits to receive bitmaps. But when there are fewer than 100
commits indexed in the first place, they will all receive bitmaps as a
special case.

When this happens, pseudo-merges are not generated, making it impossible
to test pseudo-merge corner cases with fewer than 100 commits.

Select pseudo-merges even for bitmaps with fewer than 100 commits to
make such testing easier. In practice, this should not make a difference
to non-testing bitmaps, as they are unlikely to be used when a
repository has so few commits to begin with.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 346fb29513..923f793cec 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -694,6 +694,10 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
 			bitmap_writer_push_commit(writer, indexed_commits[i], 0);
+
+		select_pseudo_merges(writer, indexed_commits,
+				     indexed_commits_nr);
+
 		return;
 	}
 
-- 
2.46.0.54.gc9a64b1d2a

