Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEEA1D90D7
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151401; cv=none; b=uq/21muBS7NoA2QO7qBAd8faoiV54DpKq94ORM/V3/6gZDj7zh5NHvdDxXOx6EhGK+OpX290RvoeCM2J2f1tyEWDMbSuKY+3Fn4pXRmVUS1vNYIBH7M2xsEQj3fh+UThXmnA9fyeMeo0aHmHoBiO+X/AaPKzyVgaLcQo85r6hbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151401; c=relaxed/simple;
	bh=5TeyP+2I7e1QumaevDVX52+qaxCl8MPjc2R+DIooTo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYaalCA0plU8kFPtFPNIDoVQBfad68W6UFMkvT7vCHHCP/wdc+rcLjV95RcDBPY8tzhZR5zLX+SCbjgJVsE6cmnZ5bEfFsUATkBjc95LfpbvQ87kV3B2+BprydWBBmFWi1iUhvKP/YmpVTK2sI+UQke8VAwbsucWLifKvAHAJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Gqlp6yFt; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Gqlp6yFt"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so4639844276.3
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737151398; x=1737756198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZx2rtUEUNJp8BLqSjRVtuWYRqiV1muUjTPFRHkYlH0=;
        b=Gqlp6yFtKy+iPrUJp70GZCSIHXmv/cddx64LhRXeUz4Pn+HkAcTEHGj0WIpl47SvyH
         y37/AhnqiDv4qQNJedFSXYxaYPwremf97iaHtt2jabvkBtaQd4b06dknDKALavFwfQWF
         JEvNvDVh3JGHpBOdVqL8Tbq97QBfglzKF5yA3omE8c+BIJ+ebdpthadSUo2LrfzYi/70
         HQL2edXBeErX90khXOIYLMNqzzs7Wc3OS3ZHM0ETPi5gyXhkQqH9O+vvWYlrDgUeohfM
         rJLSSt/ULg7cVx/dIcN0dDEfHC1wfkQ7nY/2bsfBc33sE/9WUhoyG5kLKuUbwzqTFGbX
         GmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151398; x=1737756198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZx2rtUEUNJp8BLqSjRVtuWYRqiV1muUjTPFRHkYlH0=;
        b=a32pnjbZNIHxSbUHvk2qpKZheJjZXO1aGZr42B0SW6Lf2dKvhowNsIJjWUquDLrTxR
         rYKUjv6zVrUNpnOqbPpYBVvAQ4ZWDyzdKb5/CyS9c3sVslRQG0yK2OzM2D/ubsC8Y9Yk
         28CK4ok48L1N7z+LPvF1KGCkcM2ufgpAkmirqVqxMWk1+ca9n6vB6FrwwCMdmGhfOpU8
         U6aVtjfPhNWIKTelycH4oxmRzVg7yMXDKK38FgU4dGaCKtEVGT+FTpnYndljDy/bXymL
         fXPK7Id0FNtUCNxezyht3LVLR0OmaRQ4Gs82T2RgQkHb0jQIqiGGkvhroJG13KhPNzpG
         rIfQ==
X-Gm-Message-State: AOJu0Yytk/Im/4aBcEoET0h41T86yUvDPnLjcpmQnn2pmoTvGk4p7xh2
	bDRzxG84cvfLgKKN8dAiDN/xcuLdHR09OACr8X6ZpJE/b9uBAeadKex4TEDTvdoq1h3qlqzOjSo
	8C4I=
X-Gm-Gg: ASbGncsJUgFrZG2CZoZ58VJEa9fMKsivnEHajTwuPAz6mmU9S2p1ntnsvh19PteMWFE
	bRUhaULLXcmvVqfJsYlctTezpevc4dOTPe/wuEQl5SQhaF6C6UYCJp+jWprxBTDPsDxJj2w5Tra
	rtXlzUXSM3ITcuYcCaUoeFUcpSmeZ0637YGtvw6aK80J+RnuZlyqGJq2cb3R7vSvXonmyFpq0nj
	8BeQf+cgAnoKFPhMIZlg9wxVTBDBUaXYNYUcg5BB5hpG26FtycuY3vM2HaQEzh6eO9hQuvcx3xd
	k8skFxe7sJJFiR2M+AdSQZoDmd1P
X-Google-Smtp-Source: AGHT+IGXaWt1wiSlwIzouVNDP5ndlQLT8VBXTETzqM+gRCXa3Mq2lFYN69O8Bt/m4/oYOUYCRsAYyw==
X-Received: by 2002:a05:6902:18c5:b0:e39:826b:4c14 with SMTP id 3f1490d57ef6-e57b132671cmr2952932276.32.1737151398212;
        Fri, 17 Jan 2025 14:03:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e57ab47ab22sm579160276.57.2025.01.17.14.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:03:17 -0800 (PST)
Date: Fri, 17 Jan 2025 17:03:16 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 3/8] csum-file.c: extract algop from
 hashfile_checksum_valid()
Message-ID: <d7deb3f338eaa09e39d205d028704b8d5ef47f16.1737151386.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737151386.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737151386.git.me@ttaylorr.com>

Perform a similar transformation as in the previous commit, but focused
instead on hashfile_checksum_valid(). This function does not work with a
hashfile structure itself, and instead validates the raw contents of a
file written using the hashfile API.

We'll want to be prepared for a similar change to this function in the
future, so prepare ourselves for that by extracting 'the_hash_algo' into
its own field for use within this function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index b28cd047e3f..7a71121e340 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -242,14 +242,15 @@ int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
 {
 	unsigned char got[GIT_MAX_RAWSZ];
 	git_hash_ctx ctx;
-	size_t data_len = total_len - the_hash_algo->rawsz;
+	const struct git_hash_algo *algop = the_hash_algo;
+	size_t data_len = total_len - algop->rawsz;
 
-	if (total_len < the_hash_algo->rawsz)
+	if (total_len < algop->rawsz)
 		return 0; /* say "too short"? */
 
-	the_hash_algo->unsafe_init_fn(&ctx);
-	the_hash_algo->unsafe_update_fn(&ctx, data, data_len);
-	the_hash_algo->unsafe_final_fn(got, &ctx);
+	algop->unsafe_init_fn(&ctx);
+	algop->unsafe_update_fn(&ctx, data, data_len);
+	algop->unsafe_final_fn(got, &ctx);
 
-	return hasheq(got, data + data_len, the_repository->hash_algo);
+	return hasheq(got, data + data_len, algop);
 }
-- 
2.48.0.rc2.35.g0c4d006e6e8

