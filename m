Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09917205AAC
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983533; cv=none; b=GAEznQDJ33RZnmXT7fQSg3TzcekLEwTdnP5bA1sjrTjEl+tmwd2P1B0ek366sju2sovplgwjMfBoK9b5rERbqQuinEdTmIZ5rxW2dSaGINzMwdZdcUieA4smf2f4iJG6eH/hIGRTVd8g/RPzx48Nw1E+palpZNBkipjEmKiMRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983533; c=relaxed/simple;
	bh=DpEef1SFAUj38hnMk2L6f3CdLpeF+pREdzrvrmnS0H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQEPXsTTDJQ55E4wnrpmtB9aBwVi+CzAc2/i+3reSkVp7gObJUiw/zp8Koh4ytt57qT3oxNF0p38fegH7QsW5FmrzCq7AUJeVG60EOxiFMTaT3btaIFailxqzjOKK83mBv9a7i6oqP55qA6uSyWtO4JpAhHd4qQUzCUq3j1w50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PD6djAyR; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PD6djAyR"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47692b9d059so32906341cf.3
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983531; x=1742588331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOZPC0WvQ/l8NPBTO2JSUl2Uyr8+A2TaVt3ZAh4ccL8=;
        b=PD6djAyROwGDvpUEg0IEwUffY1jaIitbdJVSkGqdKbkawLQ3MWhmYsR8taZN/BqcMW
         7DotW6oX4Tw6vIC/2SYWcEz4Z+bBCFVwzL3eoGeDb5lYrDxWD9fEkmIJH+/zgHj8+7Kp
         YvLiWzY6tvirtAaUOL8G71CH4hN4EjVxjJw876Ukh78/AZ2ug0549Ph4WrvkHQmHSNdo
         iUnd+3LIIb4ojqOJpKuOvtUpxhT+HT3njpePQ0jM2WBFht+XEVjTg2tK2HvXC5oLv6EO
         H5CKcFd0Kl/4xaCMQr8tesjCI94uOWHMwdPXrvJ4xSG2zuevZ67261DvN3LTcuWI95PY
         nwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983531; x=1742588331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOZPC0WvQ/l8NPBTO2JSUl2Uyr8+A2TaVt3ZAh4ccL8=;
        b=GrokQG66SysZO4UzBYOZ02dqXkXtr/MdRb9oOZ8ZjN3k+fPVKm9raIzTi4c+cYDkF7
         sEfhzpZu2nDZ8ZTruJRooPJWqk3mM1TLd/Q5jVcHiXAh6PMnUPCJmwYdlNn3SQq2qYOb
         tE8Km3kFeHEsPZSXu87WVMG8Xgg9KAeS0K5VXyzYzlLhQtcMMp5D3RmMbpX5sjcC17nd
         lg4PyoIYJGk/ciIjKM+mbm9pOoaPqCOMt+ysR2m2aenyv0HyFNWIwum+Z5yauruOd7UY
         0X48oDm+63/61/rU7429N29rx4CoSgeyclRlPBZ7DE1PxMZoz3vIINolwmGdboIwYA/K
         WXBQ==
X-Gm-Message-State: AOJu0YyGhHBZjdUSQr78lNp+DmzbeVDnUCsISZrHSqEsbLWFjHaEERiY
	XWhfeQcMFCLI7tIp0cg+bP1EX0VCchcWhZk1L/igeQxDGVXcdXXeUaspZp1WOquiawPrQUi4HMQ
	YJeg=
X-Gm-Gg: ASbGncuJIl2olfK+/lPpDEVU0E/jyQruzbCoF4acJMu/daMx9XPHVw0MJwVLmDhSSyP
	1QPb24ifDnpicy2dIdrHGI7Ox6XL3OSVcL5x1P9R/7c8q42lrD7WmCVlychm7pvnVIWZGaR0N7p
	y8r3Ye9A3RQuKGz2Q9I18/ZtxEbDqCTS9kj4lx4Qdoe9QNC7zmMGu7Gc5QcUAr11PCxbueMC5h/
	j9XCjagKHUCek3hei1m+HZ6W5HS3ayHPOodAZ1coxfW1qSC7nQ3Dh5Z7iiFksP9f8ZPp00NcfVw
	eHdn5D/mZtaErR3BTld3X+80cUu5WIpgh1DbqT5rb7bHmzc99wdLMAIBxELpr2dD0RTpmlr6Aaq
	URID7P+D5005u7z+5WpDFj4NCuso=
X-Google-Smtp-Source: AGHT+IFkFk/XITloGIoVg6+Rp5tptkCKLNHbSnxTx1cV0ReHI4X8uP/szD+3NsJT4NOSgFiEKQTMBQ==
X-Received: by 2002:a05:6214:5084:b0:6e4:42c2:dd91 with SMTP id 6a1803df08f44-6eaeaabadbcmr67564486d6.37.1741983528886;
        Fri, 14 Mar 2025 13:18:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade34be7dsm27577136d6.104.2025.03.14.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:48 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 09/13] pack-bitmap.c: apply pseudo-merge commits with
 incremental MIDXs
Message-ID: <11c4b7b9491c9b34a441b941902a6c29fde912dc.1741983492.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741983492.git.me@ttaylorr.com>

Prepare for using pseudo-merges with incremental MIDX bitmaps by
attempting to apply pseudo-merges from each layer when encountering a
given commit during a walk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8442f8e55f..00acf5ec73 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1082,10 +1082,15 @@ static unsigned apply_pseudo_merges_for_commit_1(struct bitmap_index *bitmap_git
 						 struct commit *commit,
 						 uint32_t commit_pos)
 {
-	int ret;
+	struct bitmap_index *curr = bitmap_git;
+	int ret = 0;
 
-	ret = apply_pseudo_merges_for_commit(&bitmap_git->pseudo_merges,
-					     result, commit, commit_pos);
+	while (curr) {
+		ret += apply_pseudo_merges_for_commit(&curr->pseudo_merges,
+						      result, commit,
+						      commit_pos);
+		curr = curr->base;
+	}
 
 	if (ret)
 		pseudo_merges_satisfied_nr += ret;
-- 
2.49.0.13.gd0d564685b

