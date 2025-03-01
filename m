Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468AF9CB
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788802; cv=none; b=XRCGZkS2oPQWmFceoeqEQqSoZI/wwYs1nkG2U8OImUYRzvaugDEQ6QCXs9f2s+OBVT+apv0FAIDrpeJKCLMVQtw5UT/6xFXUes/2QH11YxBQCPAQVr9O37KZ2p91GiRLk9WFsZsXdHq07En+rwEME6lInD+3tvDroxpgVHzuu4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788802; c=relaxed/simple;
	bh=sUNjqOJD7X9sLxyTBe8QUvMkc8ReJykjgoJaQ300/V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpIJ5l90T6ZG0CPu82XKVRUyECsWlCwF4fz4qIUooM0G5YpiLZRX2YFnMtR2Pt/HiG+APGJhRbtKHV0pVhNK3crqDDMI6haVOcwUg6k6dT7ExCfvSPoLRWlBODT/grRiqOmPNWWp9Ps7f9HcI/1JHc7wVMGAMy5U9cwnoRG6Sbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JRWEvPA6; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JRWEvPA6"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fcf90d09c6so23380727b3.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 16:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740788799; x=1741393599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjwzzf9Bs4gQHUU4fBk6Xxsag9GkRS6XzDwPZmujesE=;
        b=JRWEvPA63KxTo2i6jo+euY+vKJkoDMbLASdCriZlywA/vJpA+KX962TGbBt9mjJG4N
         b78epS5IY+4YZc6Ga8FS4D7wQIRd2qfO5mG75SR2DLbvlO4NY+hogNWB2nnsw0t/vO0P
         JWZGca8BlM9pEyITiQjC6id64h3bQw+6Z3v/wj2pX+GHwE5GNYx8ncu3+MgRB2OdtulQ
         e5a2ewyB8MmAsG4q5ARBi5QfQe3+e7h3qUIGjqauR96YEfp6qZna2Az4d3WqeuSZKfdM
         kISgJUrQMHI8q4wU96B9w9BvB/44Mwe6PD1VMyxOQ+neggk+4AFJTxqx+/BB4wEw833L
         DQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788799; x=1741393599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjwzzf9Bs4gQHUU4fBk6Xxsag9GkRS6XzDwPZmujesE=;
        b=GcoZAPIQNet1F+yzHcUb4jQJhYJGAezoi49X9P23L5TVTb8L3dl6KjmNjZe75ezOC+
         uTdiO92nm6My43X6BJ80ZSOvqpIdcgPJBTWxGYiLtQcGzLk27NKi6s0aKvZK16TjSYMj
         8tmLpY1QmPfC0LwLaPY/rly3sQ0eTp3qYh+OUKqYjzWcU2GZ/ragSF8yiyAj2YapI60n
         UhkTTBsZSkSw0cJiDPHg1FdvihbjygB8dMOb5u4OcU6lGdMjiJGzTJKo6LulH2J7XHrp
         LHu35rYVTXO5irFRlbavjlZu6kMGG8MxliQwGUJh5cd1I5p2lQJ9Y+DlSR+0wGUDV3Is
         4SFA==
X-Gm-Message-State: AOJu0YzboSfDRbgRG+c35JWuayHBEjA9HsP8CIi0kDXK45io+vzToboD
	yfMkbE/0Pzm8oZswlFBIq//LIe+iYeAlnGEua+8ARcpE5xv2uYGyGz4N5v3B6VQ=
X-Gm-Gg: ASbGncvUIVujHkLKSnTuNb4qYi6r9GW1mTD6J3t271f2o3LswmbGZzZJky1lccFb0a8
	SisYSZI+mC/aXd90j8iHDG91jJD1NS2h74Wt8FUAb+bh+bU6P4+PEjfiJFwEnc4DYHFQ5q7YLRF
	JulhvLCb3+m10DYMVXJQQWUl1ll9eVMJLa4cZJ2AWe51vFWiCIpfvlI9lltFGVlQSKhkFQChF1N
	7beYH8/T604veHWSX1Zo/C77iZvmCMt4BRA92PLoXJu9Gly3eFj+MRsdCTUtGctifyu1GJsfaPX
	ckwNgmUVlClhic+ebk4gZwvKSUyyCZoIpxhn9kuG572jwuG2J7FCGfw/k/RjMN+VqpLYq6kCY4G
	dA9vwg7iaGVXx6mXb
X-Google-Smtp-Source: AGHT+IFgv5htIxSDG2dLqd+QhL59C5rOb0eNiG+R3uyqOoCSpThrn5ys0F+K5iYQEipkyRtam6OFiA==
X-Received: by 2002:a05:690c:7305:b0:6f9:47ad:f5f1 with SMTP id 00721157ae682-6fd4a3623d6mr65655107b3.17.1740788799595;
        Fri, 28 Feb 2025 16:26:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca4889bsm9622917b3.49.2025.02.28.16.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:26:39 -0800 (PST)
Date: Fri, 28 Feb 2025 19:26:38 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/13] pack-bitmap.c: keep track of each layer's type
 bitmaps
Message-ID: <Z8JUPlXSZ7tEKWET@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <9ab8fb472f48f42f7e0eebc6f0f986c6c74970e9.1732054032.git.me@ttaylorr.com>
 <Z8GJfjhGAbXnA1LW@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8GJfjhGAbXnA1LW@pks.im>

On Fri, Feb 28, 2025 at 11:01:34AM +0100, Patrick Steinhardt wrote:
> On Tue, Nov 19, 2024 at 05:07:50PM -0500, Taylor Blau wrote:
> > @@ -586,7 +604,29 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
> >  	return load_pack_revindex(r, bitmap_git->pack);
> >  }
> >
> > -static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
> > +static void load_all_type_bitmaps(struct bitmap_index *bitmap_git)
> > +{
> > +	struct bitmap_index *curr = bitmap_git;
> > +	size_t i = bitmap_git->base_nr - 1;
> > +
> > +	ALLOC_ARRAY(bitmap_git->commits_all, bitmap_git->base_nr);
> > +	ALLOC_ARRAY(bitmap_git->trees_all, bitmap_git->base_nr);
> > +	ALLOC_ARRAY(bitmap_git->blobs_all, bitmap_git->base_nr);
> > +	ALLOC_ARRAY(bitmap_git->tags_all, bitmap_git->base_nr);
> > +
> > +	while (curr) {
> > +		bitmap_git->commits_all[i] = curr->commits;
> > +		bitmap_git->trees_all[i] = curr->trees;
> > +		bitmap_git->blobs_all[i] = curr->blobs;
> > +		bitmap_git->tags_all[i] = curr->tags;
> > +
> > +		curr = curr->base;
> > +		i -= 1;
>
> Do we want to `BUG()` in case `i == 0` before this statement?

Good idea, but I think we only want to do this when curr is non-NULL
after assigning it to curr->base, so something like:

--- 8< ---
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 48da3f3b5b..7cea838f58 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -616,6 +616,9 @@ static void load_all_type_bitmaps(struct bitmap_index *bitmap_git)
 		bitmap_git->tags_all[i] = curr->tags;

 		curr = curr->base;
+		if (curr && !i)
+			BUG("unexpected number of bitmap layers, expected %lu",
+			    bitmap_git->base_nr);
 		i -= 1;
 	}
 }
--- >8 ---

(though note that this is on top of an adjustment I made earlier to make
base_nr 0-indexed as it always should have been, though I don't think it
is relevant to the portion of the change shown here).

Thanks,
Taylor
