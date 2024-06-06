Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6C224D6
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712714; cv=none; b=S3yTBpzRXHlpBKoORhEdFZXAWKXBz6ScKlPuXi7VI5bErhtgz1ea/wsSsYMm2f4XIDawo8/WuZ+FJhwQHlT7ItsmyXIXWnBLRmP7TqjYqpkxwrUxXypK+TDc/e0LcQWiKn8Snil4HjvRFOZ4Nfwx8IgEmHGd78vPRj0d2MDgJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712714; c=relaxed/simple;
	bh=0fhAWtUEcex/dX3yofbLKguSQBeZDqhJTNFXGdpAZfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MteOUp+MS4EHdywhA+N6uEncqtvhRVVARyuevRJAwPipROfAyaSpnB5Xnm+xkGVrCeXoxOwpHxDOcHJ/jNxhsvb1oNylxNkirOdryY/R89YTzte1+pLWDX+RPhavih1V6hCyKMSkSaayh59urvg21EC5VhO4qMVAmXrZ8Qqepc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=w27MsWY6; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="w27MsWY6"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ae1b32752fso8287606d6.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717712711; x=1718317511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7dZbMa99JmDn3HerWskW/wTApEtXajoFrjNZuhVnYn4=;
        b=w27MsWY6pT2N65/+lYC+UVirwB+LxMxvXwyn4BiTymlwu7m/rdaeI3FXJBSyIT3Pf3
         TGcClRpAAl++m+oyJzmPEdO4zbD40XozNIcNu+Ga5GIlfus5BwOHAcNRlohZI6p5B2Gx
         BfOvGcBvtJmoDIRbcdfXTANEA8XlzijXaJOhUdGuIP7ScYI0xzo/yw6LMN8yzrJW80CE
         wxZWlEg5EkdX/72Zg4wldBqqKTMlJRvAbvpaFFtFZxfsMjof3Eyvgh49dty+w++RUZpr
         wQuVhACSHueiHL5aId/eUqeqZoqFT3nkX0j/mJILQXqKOZPPDiM9zo1enfvl7joLErA2
         8n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717712711; x=1718317511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dZbMa99JmDn3HerWskW/wTApEtXajoFrjNZuhVnYn4=;
        b=eg6oyFWmsjah3k8YlobvkQe6VIXHFE3JL4KSdPTJ2kPwwn+jvO76fEES1bx0HxNI0R
         MBdpfrJoU7n5AscYl/vbj8WtLOCgdxZwwTudGlRFv3Qt9W8HbLyJsOz0mZ8C53MvNk3M
         tuLMfHsWQhyFcCG5cxRGI2CJGquN9IjK2aaVkn1Vb9YcMOloiRDdgUxcEsNoEFMDWW0y
         l2oazkhBSGInYdY+Ip5NtIw/UF9Mnvczdmj5CdHFGZBSz7vrlNFF0owHKLST7rWNn9hy
         KggzJDZhFTVrD1V6hZo7QbeSjEh3KekqIMsq+6IQ6k/QqdS/SAiiHB0lgx5yZs7oAPhX
         eHrA==
X-Gm-Message-State: AOJu0Yye9IGugakZGFR9os08Kg14+jMLFh6jcEjjtC36l5yb5vk8kDBn
	XDrdtUWylZwwwaRr0g0KtcqePTFSamx4OhZcmPCtcMIRSl9X5s7sWnZttY5B8wo=
X-Google-Smtp-Source: AGHT+IFnan7zMIoicGwfABFh4qqQZhn6pOlFTbV6qXlv/99lvWvqFJwCuZWa+bfTt+6jvj11mcRwwg==
X-Received: by 2002:a05:6214:5904:b0:6af:2941:77cc with SMTP id 6a1803df08f44-6b059e13059mr10242366d6.52.1717712711186;
        Thu, 06 Jun 2024 15:25:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038b3bf7esm7428631cf.70.2024.06.06.15.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 15:25:10 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:25:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] pack-bitmap.c: ensure pseudo-merge offset reads are
 bounded
Message-ID: <ZmI3RYSsx6VRHdc9@nand.local>
References: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>
 <0a16399d14afd527f4db63f2a4a3b0a3cbf112f1.1717699237.git.me@ttaylorr.com>
 <xmqqfrtpluws.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrtpluws.fsf@gitster.g>

On Thu, Jun 06, 2024 at 12:42:59PM -0700, Junio C Hamano wrote:
> Can table_size at this point be smaller than 24, which will allow
> (table_size - 24) to be a huge number that st_mult() will
> comfortably fit?

It could be smaller than 24, but I think we're at the point of
diminishing returns here. The table_size field is read from the .bitmap
file itself, and we do some light bounds checking here:

    table_size = get_be64(index_end - 8);
    if (table_size > index_end - index->map - header_size)
        return error(_(...));

We could add another check to ensure that table_size is at least 24, but
I'm less concerned here for a couple of reasons:

  - Since we're reading off of the index_end, we know that all of our
    reads are within the .bitmap itself, so we're not reading outside of
    the memory-mapped region.

  - Checking that index->pseudo_merges.nr is a reasonable size also
    bounds reads, but more importantly IMHO prevents a large heap
    allocation via the CALLOC_ARRAY() below.

So I think we could check the table_size value, but I'm not sure we'd
gain very much by doing so.

Thanks,
Taylor
