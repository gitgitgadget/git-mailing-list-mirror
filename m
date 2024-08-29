Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A746B192B7C
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957839; cv=none; b=RaSR0oxYA+kwaljicjIJPrej8MJm/jlrOL2f+HUyxDJ30jqOrv+TDvl2J8pwbkm+6g91qqe0919D2/AvezrpCTtBtIh6SdiFV5r6RtSpYHA66EXN+C1dBhqH9qLPXXm/dxT6hjYnfMxLFUmWd1sLr5G7M78dy20yMlwUtKf245c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957839; c=relaxed/simple;
	bh=/lIJv1MNLjYTSILWegLXkHzPbO4jEA1qxp1+2YirShU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XREGY+XCuW/uX4cIheYqPQHW9sDUJzIWP5Yd3eBW0jbOCY8rZHJ10ybcg5rga9J/dfn1Z8S0BH00btmepfG+N6syYaSTlHzGWtdA/gdRBxd91j8BLAg8EU4kscvi+ub7SM6+dcSDrB6XnOPOICjg9uScUeDn1Hn75EJyh8z3Y5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LKl1seWL; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LKl1seWL"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45685a3b1d8so6613431cf.1
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1724957836; x=1725562636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/lIJv1MNLjYTSILWegLXkHzPbO4jEA1qxp1+2YirShU=;
        b=LKl1seWLOhY6bykgxUtQLFnpxrhHF+5gaFf9+WjCDvg/Ioq5kW16S8DKrF4hG4CGVM
         uN/aHZSKK6Ra5PlYV0OoEYIyNdn4bPqyQe6v62OODFGEQ6z3tV9m0UQQ4D75LZqCzOfw
         BXXtfLaAu1xPQ6cWe3QrgVTzkBq8xKgp3o0LtW9xRMs2Wy/Uy6ArlZRBLysq6R77DRaT
         ztzsTZLwGBJsW1j4GWGN1yFUVIqOxWn1CpsMbwTOBZbTTbKaPXIIaQizuYmFXall2Lzb
         +5NXxIqJuy2lijsWzDUSg1wCY174oHP2cdmm6hiGs6tTN9xnkLWE9qfbSNeVzYpGF8wE
         +TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724957836; x=1725562636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lIJv1MNLjYTSILWegLXkHzPbO4jEA1qxp1+2YirShU=;
        b=tp5rXK58NbZhcZGPvJ/ODEcJsFTcaUw3cBdNTbdm1LEX9UohcbU3q61a25qt4sZUEp
         B8WHBEAVm2Jm0LuidWsHMiXsEIHsy0UAGrMg4YWcz0pA0EB9PPiTG6YGJEqkQAxiNT+O
         YzXYnjnCIET9z7QZwVbbSY+ICMVFuMXqMb/l4+kwHzffjTsxIWGuinFSOyhe1mmNc1bw
         vjt0fjt5hiLdyQYDvYxXUf6L/YC0pyrSvodtTQFP7B/K2fHL6SN0fxMWKD7P4QzPhAIi
         UozsVjIbog3415Gei8bnAHqYa2VJt0W5jydguZAnA+xC24rLofh2d3WooHvmtsIxo60U
         c+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkoLxyCmyPUCoIxe1/uD/fvnyhDHk/lNaUy3CXLCXyh05R5m4zIxmGQQfCnpY5/wbRA3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKaaExNE2wL8GO+XKwXIAYoD4s0sQaHxma+63k+hRo/tu1sfdf
	fbZ9QBkPOwPLEaVBy+LwuryEk0P7xCkKX6qsDp6Y4eTEjP9E5E/StTz2ZqH02QM=
X-Google-Smtp-Source: AGHT+IFViBjBF76vv5sBl0d59Zvitkotlo8s+4dq430pH5jiDFsMRzkC7L/Yk1bd9+rrCALdcDqVOA==
X-Received: by 2002:a05:622a:544e:b0:447:ecd9:9f77 with SMTP id d75a77b69052e-456801d9cbdmr67466111cf.5.1724957836429;
        Thu, 29 Aug 2024 11:57:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682d66defsm7360331cf.59.2024.08.29.11.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 11:57:15 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:57:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] fixup! midx: implement writing incremental MIDX bitmaps
Message-ID: <ZtDEhNRfXth63SJs@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
 <afefb4555750661ffd2c573a33d92f8fcb9f435a.1723760847.git.me@ttaylorr.com>
 <xmqqseuozg53.fsf_-_@gitster.g>
 <20240828183356.GA4043247@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828183356.GA4043247@coredump.intra.peff.net>

On Wed, Aug 28, 2024 at 02:33:56PM -0400, Jeff King wrote:
> Is that right, though? It looks like the caller might pass in a
> tempfile name like .../pack/multi-pack-index.d/tmp_midx_XXXXXX,
> if we're in incremental mode. But we'll write directly to
> "multi-pack-index-$hash.bitmap" in the same directory. I'm not sure to
> what degree it matters, since that's the name we want in the long run.
> But would we possibly overwrite an active-in-use file rather than doing
> the atomic rename-into-place if we happened to generate the same midx?
>
> It feels like we should still respect the name the caller is using for
> tempfiles, and then rename it into the correct spot at the end.

In either case, we're going to write to a temporary file initialized by
the pack-bitmap machinery and then rename() it into place at the end of
bitmap_writer_finish().

On the caller side, in the non-incremental mode, we'll pass
$GIT_DIR/objects/pack/multi-pack-index-$hash.bitmap as the location,
write its contents into a temporary file, and then rename() it there.

But in the incremental mode this series introduces, I think it would be
a bug to pass a tmp_midx_XXXXXX file path there, since nobody would move
it from tmp_midx_XXXXX-$HASH.bitmap into its final location.

So I think what's written here with the fixup! patch is right (and
should be squashed into 13/13 in the next round), but let me know if I'm
missing something.

Thanks,
Taylor
