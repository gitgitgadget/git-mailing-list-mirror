Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249671C6B4
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344718; cv=none; b=rnVQ/1k2yBv6F83OwQ5lHWeJ7oLiIlw+l3tUTBWcQr88q064FKIFHWMrMXqFq0hXePOpSSZHwnKOXL3iJWNyt2qe5jrWzUPEDEo5YN0VgGicSn2G7SHAaAP9OdzuFvwPtaYbWu1zXBkpvCWGDwF9klcXIw4AmK6DGqKUlK+3W5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344718; c=relaxed/simple;
	bh=FA/oJGwnfyv/SBllpwsJvBRpNfVMMJPMbw4MUaw31vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjJBC/CVKMyRmB82+HOyeBPacWIqgoiYotFAeV5Jh8P1l2/KoObP5UMvo6ghy/5YCVyNaau1EV0nyS+BWyNb79K2lH25TeG2HptAqpeWqbrghC4p5IgJPzZkBgAYXTl5xuN/t5xNh0fbTGgaswaeFF1oy9obO99sh2l53ZF2IBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=3G4sVYC2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="3G4sVYC2"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c58974ed57so332190885a.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742344716; x=1742949516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+/kYSR0IfMU2TW2TWHwqSKzozlZz9hz1c+rf/X+oLo=;
        b=3G4sVYC2RfpSnLWiaPjIoKcyTxGl472Vyl2MUbm0LDW8Hr3hn5ug3ZquU+WgJ2uysJ
         PhlYgKYCtgYDjWZ4lpI0zGEYPljeBNPiGPouEHPhzcEc1bAytR5HQTmHXC+9xV3kBLfm
         4Uecr9zEG+p/WnR/oZ7QN+mEye81nMv6Y/lH/xjMTQO+5vusLQkSA3X17iekJeep8KOS
         +r87ACwr/1j7zBctw6C4Ajk+ZX1rAwTlMdHoxJkKxmOpoEmVxUP4SysC1kolGrEDk+wy
         joGf2i3C1EH9V5HMAmfMq7bj1BObezJRsilcpl2LjpIjMyzQbNm+CKC1Nu2adAhq77ya
         ZdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742344716; x=1742949516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+/kYSR0IfMU2TW2TWHwqSKzozlZz9hz1c+rf/X+oLo=;
        b=jQURI9TnlboQ7k4mF/8Z1NXZNr4GB9Eu9FKYtOtNOtQTDRdn/UAXNQAURwyTKkigC4
         9MRYKHeGN38Fd775cgQFrkbJyiY2oKpZxsJ2OoWsXNxXTe1ZP6dnKYlQwMTEHVrR27ok
         5Yi+bN2zstiVU3ZViw8Y5ZJZdo6Nsa7bgJrcdc1J+d0BYhHWZK9zCyaQ9u8bGto0hWQv
         sYaotXK/kR3uqm6fCtwUihepoTwaWYI6tYAOVdla/bghP5g4k657IkKke1/IV9qz34gX
         AYpSaxGD2wuRRxx8Pu7T83LTh42XfIRBClqS3yivHnDaFex49mJ3GGz0JJC4F89pZpZY
         fzEg==
X-Gm-Message-State: AOJu0Yy92+9oGWB0PSt80ATLZIT26E8fXiToacoq5X95re3dcOCQtPr2
	Ttfmocr2ytCPanlX2rRP8ky14O3uuaO0ssWCHlhJoD9Kk29sMnppGQqeLOln0aAEgOJkPUgCt7f
	N+cw=
X-Gm-Gg: ASbGncuzoG99Qb+m6cQuCQ6WiFmgm2u9UkJnV8+PHdhlV6GRnZOXs1plj3PZwOVIeEQ
	KM4HIfAS8YkR5qmS0lCdo0KhlT0d0+KdWrPy25eTT+7wx3bs+rMwXZiwnW1DeUXKob4kdCNb3a/
	m7X5+KRH658OkXoiuqXFlG57SoqdzbQXq0NOGzwFOiu1ICLsE/JO5U3phuvNLszkW8LrVIGCdWl
	Q2w3nAceRpTuEoC6tPZ3/gkCe1/Gxp4G/zA4yWZw/l+WMZpzEEwK/jItcCvcGhjsEtN9ae5fzWd
	BAi44nTRFGzl5Pi7BSF+lDcty/weyuYK3VFF3fqaNsP0AwmAKqu4aZT7vkDGaKmu/y2R7q6aZfC
	h0BaafSWMNW0/ed0g
X-Google-Smtp-Source: AGHT+IGoirgkCnAH8Ms2EadlANKguyKA5UNVCpccwR3ikpgDyUBy0rgdBSenzoILXEuWseMpr04mdw==
X-Received: by 2002:a05:620a:44ca:b0:7c5:50ab:de07 with SMTP id af79cd13be357-7c5a839691amr112567185a.21.1742344715951;
        Tue, 18 Mar 2025 17:38:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d701b3sm783195285a.69.2025.03.18.17.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:38:35 -0700 (PDT)
Date: Tue, 18 Mar 2025 20:38:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 11/13] pack-bitmap.c: keep track of each layer's type
 bitmaps
Message-ID: <Z9oSCmTtyDM6JIi9@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <a29f4ee60d519318d36a8d3c812b4bad039b891e.1741983492.git.me@ttaylorr.com>
 <20250318020113.GA1473033@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318020113.GA1473033@coredump.intra.peff.net>

On Mon, Mar 17, 2025 at 10:01:13PM -0400, Jeff King wrote:
> On Fri, Mar 14, 2025 at 04:18:53PM -0400, Taylor Blau wrote:
>
> > @@ -81,6 +81,24 @@ struct bitmap_index {
> >  	struct ewah_bitmap *blobs;
> >  	struct ewah_bitmap *tags;
> >
> > +	/*
> > +	 * Type index arrays when this bitmap is associated with an
> > +	 * incremental multi-pack index chain.
> > +	 *
> > +	 * If n is the number of unique layers in the MIDX chain, then
> > +	 * commits_all[n-1] is this structs 'commits' field,
> > +	 * commits_all[n-2] is the commits field of this bitmap's
> > +	 * 'base', and so on.
> > +	 *
> > +	 * When either associated either with a non-incremental MIDX, or
> > +	 * a single packfile, these arrays each contain a single
> > +	 * element.
> > +	 */
> > +	struct ewah_bitmap **commits_all;
> > +	struct ewah_bitmap **trees_all;
> > +	struct ewah_bitmap **blobs_all;
> > +	struct ewah_bitmap **tags_all;
>
> OK, so these are valid only for the top-level of the chain? I guess
> there would not be much point in having the lower levels know about
> their incremental versions.

Right; all of the "useful" computation like counting, traversing,
filtering, etc. is all done at the top-most layer in any chain, so these
have no meaning/purpose for lower layers.

> > -static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
> > +static void load_all_type_bitmaps(struct bitmap_index *bitmap_git)
> > +{
> > +	struct bitmap_index *curr = bitmap_git;
> > +	size_t i = bitmap_git->base_nr;
> > +
> > +	ALLOC_ARRAY(bitmap_git->commits_all, bitmap_git->base_nr + 1);
> > +	ALLOC_ARRAY(bitmap_git->trees_all, bitmap_git->base_nr + 1);
> > +	ALLOC_ARRAY(bitmap_git->blobs_all, bitmap_git->base_nr + 1);
> > +	ALLOC_ARRAY(bitmap_git->tags_all, bitmap_git->base_nr + 1);
> > +
> > +	while (curr) {
> > +		bitmap_git->commits_all[i] = curr->commits;
> > +		bitmap_git->trees_all[i] = curr->trees;
> > +		bitmap_git->blobs_all[i] = curr->blobs;
> > +		bitmap_git->tags_all[i] = curr->tags;
> > +
> > +		curr = curr->base;
> > +		if (curr && !i)
> > +			BUG("unexpected number of bitmap layers, expected %"PRIu32,
> > +			    bitmap_git->base_nr + 1);
> > +		i -= 1;
> > +	}
> > +}
>
> It looks like we always allocate these. For the non-incremental case, I
> think you could just do:
>
>   bitmap_git->commits_all = &bitmap_git->commits;
>
> and so forth. But I doubt that micro-optimization really matters, and it
> introduces complications when you have to decide whether to free them or
> not.

The complications aren't actually too bad... I think you just have to
avoid free()-ing them when you have a non-NULL 'base' pointer. I think
it would look something like:

--- 8< ---
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2270a646f6..8a530fa7d8 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -604,6 +604,15 @@ static void load_all_type_bitmaps(struct bitmap_index *bitmap_git)
 	struct bitmap_index *curr = bitmap_git;
 	size_t i = bitmap_git->base_nr;

+	if (!bitmap_git->base) {
+		bitmap_git->commits_all = &bitmap_git->commits;
+		bitmap_git->trees_all = &bitmap_git->trees;
+		bitmap_git->blobs_all = &bitmap_git->blobs;
+		bitmap_git->tags_all = &bitmap_git->tags;
+
+		return;
+	}
+
 	ALLOC_ARRAY(bitmap_git->commits_all, bitmap_git->base_nr + 1);
 	ALLOC_ARRAY(bitmap_git->trees_all, bitmap_git->base_nr + 1);
 	ALLOC_ARRAY(bitmap_git->blobs_all, bitmap_git->base_nr + 1);
@@ -3031,10 +3040,12 @@ void free_bitmap_index(struct bitmap_index *b)
 	ewah_pool_free(b->trees);
 	ewah_pool_free(b->blobs);
 	ewah_pool_free(b->tags);
-	free(b->commits_all);
-	free(b->trees_all);
-	free(b->blobs_all);
-	free(b->tags_all);
+	if (b->base) {
+		free(b->commits_all);
+		free(b->trees_all);
+		free(b->blobs_all);
+		free(b->tags_all);
+	}
 	if (b->bitmaps) {
 		struct stored_bitmap *sb;
 		kh_foreach_value(b->bitmaps, sb, {
--- >8 ---

, but it leaves a bad taste in my mouth tying the NULL-ness of
'bitmap_git->base' to the allocation/freeing of these arrays. Maybe I'm
being paranoid, but it feels like a potential landmine.

> (And if you really cared about micro-optimizing, probably trying to
> prevent the extra pointer-chase in the first place would be a more
> productive path).

Yup.

Thanks,
Taylor
