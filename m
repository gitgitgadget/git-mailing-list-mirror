Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A271B0120
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958101; cv=none; b=G1q5B02QcyISek56tAaVDDpU4SbQCHnnr8T4Zza8pTYlTfHHzkQ8sDaomyNHbSj5s5A3FhV/deaQeBjxHHHJCqENQmJQhce7SD7LUwg4dR55h0tPwyKp8Vyd4zJOFBTPemlTOOfr4GXYKGNwcareuc77uQ4wNudWfHDQ8T1dyVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958101; c=relaxed/simple;
	bh=/2sdQxcfd9cHfk21qCyZ3Bi6It3gqZhIqWjZ33o9Vhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0M+pQTI8lqh1T2Qq7PQ8M/fQSgVGkjRBom/JxKPij1aFtvFc4xX2rhACbNitn+B1fiD3HgvoiEkWzNvWH5EIgwMCxgRr5+4hBndcpFwLYsca+iOgVPULj61cQS6WggEW/auh3KmH+cR9mIC1+t9jcPH7oxfeLdcHMzLeX/mn40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VSe13Er0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VSe13Er0"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a8053dc6e3so58452785a.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1724958098; x=1725562898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2sdQxcfd9cHfk21qCyZ3Bi6It3gqZhIqWjZ33o9Vhk=;
        b=VSe13Er0ONpy9KTJDoF4gc9pLsQ1LIKQO/ymQ6UOsqJ1DsPcKUQjJ1i2JNq4lk+o3P
         jYLB8DtVDdm0Kumn/RRkV/OHzu5oEXF0ckvEspU/nbbyzGAyjyzktQnHz5XM9MyXAiDQ
         5Gyp07aR/n2450LIPpwKkEM/SYREqX1lL6Qwd9yGQfOa3EQEhowaLJWSFNdf/9LW10Xq
         jkJL6B7JWLm+euBaBI8Buo7GNAYVAZH6FgHWYorAZszn2OqExSc5IHt7QzFB2g36Sl/+
         UYWXea/fQBK/X67TDf32vqUNEwopL6pV6FXDwSX+pzwB6p0hrfbwOWmnOC8LqRi849Wt
         ldCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724958098; x=1725562898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2sdQxcfd9cHfk21qCyZ3Bi6It3gqZhIqWjZ33o9Vhk=;
        b=W1Ft+yNTTb+fiKWyKYGLsTGUaD7vex5EKhbjvczMNUilfb7/6WlrtxiP2pYkouKn/v
         GTPn7gXiZXKflVV7HT6L8is5E2ilmiZM+AFCgFbyeUn3Go+ptfR7MDSJLyEeu4KdipWu
         Jh3cyrbrpPBRAZUtzLQxiTOWPLVqVysB+MVB0osrASiVQE/3ia5kYbsfpPyffiSqb0r1
         5SPKpcHUlwNEnoLjmOXZx465lK+4HbbQOk1ihZ4Dj46sHMFZoJy6k0wahik3lJCLuo2U
         a5R2Rkzo3Y9n8ogEFajzV6ryCQmtrogkAswlHDtdnhqrab2PsoW0apUoYt44rp4J7TAG
         lSNQ==
X-Gm-Message-State: AOJu0YzzgJNwogpvd9+I/z2DkXh0dRpBWUyTgiZj2I6V1YEkxSY8uFnG
	Vx47MrbVT7zy0mie47V/DeY11fexRmnJGS/uLwl2DQ3jMD9nVgT4bF7Cdpzk6gACz7cIfcKZO8c
	1
X-Google-Smtp-Source: AGHT+IGdEkYZCij499w86EpmkNjIIAxLLvAnWqTgJt2X282601JzLYOyHXkbMJaTuIszPKtM4rox3g==
X-Received: by 2002:a05:620a:1a1e:b0:79e:fed9:7943 with SMTP id af79cd13be357-7a804282ca3mr455685685a.61.1724958098364;
        Thu, 29 Aug 2024 12:01:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c2aeb0sm77016585a.44.2024.08.29.12.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:01:37 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:01:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] pack-bitmap-write.c: select pseudo-merges even for
 small bitmaps
Message-ID: <ZtDFkO4gFz7hC0Iw@nand.local>
References: <cover.1723743050.git.me@ttaylorr.com>
 <0fea7803d86ca17451af408e1bf93c32690edc44.1723743050.git.me@ttaylorr.com>
 <20240817103401.GB551779@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817103401.GB551779@coredump.intra.peff.net>

On Sat, Aug 17, 2024 at 06:34:01AM -0400, Jeff King wrote:
> On Thu, Aug 15, 2024 at 01:31:12PM -0400, Taylor Blau wrote:
>
> > Ordinarily, the pack-bitmap machinery will select some subset of
> > reachable commits to receive bitmaps. But when there are fewer than 100
> > commits indexed in the first place, they will all receive bitmaps as a
> > special case.
> >
> > When this happens, pseudo-merges are not generated, making it impossible
> > to test pseudo-merge corner cases with fewer than 100 commits.
> >
> > Select pseudo-merges even for bitmaps with fewer than 100 commits to
> > make such testing easier. In practice, this should not make a difference
> > to non-testing bitmaps, as they are unlikely to be used when a
> > repository has so few commits to begin with.
>
> I think you could argue that if there are fewer than 100 commits in the
> history that pseudo-merge bitmaps are overkill, so it does not matter
> much either way. But I think being consistent with our behavior (i.e.,
> generating them if asked) is important for testing and debugging.

Oh, I think that argument is very fair and makes a lot of sense. The
point of this patch wasn't that having pseudo-merge bitmaps for
repositories that small (and which already have complete bitmap
coverage!) is helpful for performance.

Rather, it was to make it easier to test the pseudo-merge code path in
small repositories without having to waste CPU cycles to generate 98
extra commits when 2 would do, etc.

Thanks,
Taylor
