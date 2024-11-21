Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB712FB1B
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224926; cv=none; b=uhlt4TuYRRFqOLM6tHWPsYGYr/3CIXWdo/6lHWfoV2cm+8+fibFP3YLxlE1LXC0SDwEzCx9pxi8c5q3lZkVqrp0ON19l/Ip9Nw/ZOarzOwoN1a2cuHkNUGRxcZpohsXUoqCx7Sr6xpHuS4oJlyCLg89fK54KiU1TXY/AVcYvFBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224926; c=relaxed/simple;
	bh=Kynl/FMUvsuTB7mwKoVf0oEod5lmBzW75KXEz8L/auQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBeMdg4Me1JH1FLS48VqrJuDajofISMgAzVDwHBvuQA861LonalW/Ybe8CsLedPHixK+6Za/DaL8gkns8pcuenFMGYHFaWen+lyiWRwuxJvKLsaLSfpTWoQ+uoytdzgMdp9UkOdIt96La011L4qd0G8HpGytlIEQ1UFJvx4PTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZNa+aX52; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZNa+aX52"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e387afcb162so1476228276.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 13:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732224923; x=1732829723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nkFOOSND3kp+ssf/+0kEf16pn07qXc9JNJoKLU28zUw=;
        b=ZNa+aX52EPeb8VG2yS5yCJCnHWlxgN42CPNYG/3+Y3/+VlMtaBmrmQnEkYx7Lxxnu3
         3B7Q+goLaI3N1AlPfozjF988KUQbMSLiHUo3sIWEf5ZT+2Bhcrm6n4trrFCOEOyehIlm
         QCDGSZELoir3gmIz2k+lnXkbA42GHYpDGBxQSncfvVzFpE0yAMlDV/bHXmYtfK0r4O0S
         eXdd73sNu2imnK2eSF1tboRT3hCn+EZLha21uFO9j6PTyzN4z/nq4F4zeZYLNDRwUMkx
         mBcTHyy4pZFElr2N6/ANsXZW1VgfEGVQ5dDEDHXOjNVY4IDtjMroWtQZtfW6NmpBV3ZP
         v8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732224923; x=1732829723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkFOOSND3kp+ssf/+0kEf16pn07qXc9JNJoKLU28zUw=;
        b=jZ7Uhr4oo61Eqzku6p0gU8J+1fKtSEQJr2Awwpgk637IPL4QgTZlb/Gy4SME5/DJgl
         MMBzIFHShFRteXjtHGTGYhvHqOvGDlndWF+EpTi27W9pIM9ZwqRG24gohqVBhYqHsV1p
         HCK/n5JGI891BVImS8kVmJuOlZsWZkqrsQf+q+sWjegf9DzpTLZPfFPitPCLUphdnjGS
         LMRn/oEskhkSGRE8WdDQslRVDL8PPlq+Nk5FRz3ePP295MxeYWtTMtdXlh4AS3EN7Ff5
         zX3hjWbwFZk5WbCr9w2CLJ9KEQ4Yu+T++tdH/pOew73QNR0ul6hnKbxFaz6kmT6DGCCe
         8R2Q==
X-Gm-Message-State: AOJu0YylaKOJj3aV524w1wG//nxaXWbp72swem6jmJM2XDEXaZKiLjnh
	cS6j9VkvVh2RGOXolDsnGi9vRsOEr0pjPkUvsijgTW0kwQoF3XFVU32qLLCpUklKJvMU87sbrFr
	+
X-Gm-Gg: ASbGncv2EOJSTAvI6NzAWyM0IBmOpVA3pXM1u/c9zIEcHZ+ZxLP5K5NwjYjQXEhB0FT
	pKIwMXVn3exPSsIFH88XP3PTYz6HOKU9AFxOfx6w40erXP7etsAizx0yp2GFncCn8/tRdykm8vj
	AsYHnEDKvmB/2XBihE0a14i3lL4xlw0m8GN3NjmmNAZm+D3NJ1z1kVhBIshmcwlncw6lsfd3/Ro
	CP01c37n7GV1gZiAVmHBplRq5yRd1phe2JV18PkNytepr0rm8tsBwVxwVGPTqMBsniz/vtiJBgf
	fReejhBEIcwjvUoorIEhYQ==
X-Google-Smtp-Source: AGHT+IF9EVjxImHTiJPMh1HtVquhw3luFaeyJi/56XSanpgQUAunXdGKAIpsPM5lVwZ8mWJue0ynaQ==
X-Received: by 2002:a05:6902:708:b0:e2b:df40:2588 with SMTP id 3f1490d57ef6-e38f8b228ecmr657280276.21.1732224923001;
        Thu, 21 Nov 2024 13:35:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f634bc38sm169135276.55.2024.11.21.13.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 13:35:22 -0800 (PST)
Date: Thu, 21 Nov 2024 16:35:19 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/7] pack-objects: add --full-name-hash option
Message-ID: <Zz+nk4w+y63vCupK@nand.local>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <812257e197cfe30bd0d3c68ea6ec0d062631185f.1730775907.git.gitgitgadget@gmail.com>
 <Zz+TKS2O/ij6GZ1f@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zz+TKS2O/ij6GZ1f@nand.local>

On Thu, Nov 21, 2024 at 03:08:09PM -0500, Taylor Blau wrote:
> The remaining parts of this change look good to me.

Oops, one thing I forgot (which reading Peff's message in [1] reminded
me of) is that I think we need to disable full-name hashing when we're
reusing existing packfiles as is the case with try_partial_reuse().

There we're always looking at classic name hash values, so mixing the
two would be a mistake. I think that amounts to:

--- 8< ---
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 762949e4c8..7e370bcfc9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4070,6 +4070,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	if (!(bitmap_git = prepare_bitmap_walk(revs, 0)))
 		return -1;

+	use_full_name_hash = 0;
+
 	if (pack_options_allow_reuse())
 		reuse_partial_packfile_from_bitmap(bitmap_git,
 						   &reuse_packfiles,
--- >8 ---

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20241104172533.GA2985568@coredump.intra.peff.net/
