Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD321CB304
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543729; cv=none; b=qwFXoXB6d3GNAH6TQrpB9WYPn52FHjMcBxK8K9CJN/uxxmCr2UtdPOu5aehWX95If/ZOD+bCoLI7xbz+HhTW8pvzjJOdxigUp0YORhO+XTrs6bfMfv/GIAsSrZux7KKkrefEdjUaIiswsYXiYKctP9I65MjK409trOfx8fIqFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543729; c=relaxed/simple;
	bh=VngoWU0kb9UW73KWG5HneKfAusoj9ierkcpWNiiSMBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We4Qrupy1s2RgYzjrsAKIds+wzUcyrlyR26DgICyw8EjVZOfBleoQTgl7dNIBiYwf6iFMBj2/03E2GiLUt7fF8RZufIUERYhoqNE9XQ2o699b0+Pxefnl3jWZHLM8sN+9D4vsi1csytnVIiGH1UDnz6adzt4q7e5w2+pJfZOMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eMIKyaEO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eMIKyaEO"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e5a5a59094so46669127b3.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729543727; x=1730148527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3bu/Gi0hRdBxTxMo+cGUtUSSKfcJsr3N8iZ/Jo3hjw=;
        b=eMIKyaEOdUA8oBkkFPnfDZCXOZskyGIYV6jMyWChP4VIimQaOC3kAWw1xaBQEA40oh
         iN6hYr52Sewk2esZTfslRyh0n9qCDiLf4CFOq5xfhhS/DHc6DBkQhueA40hdAK3MV9ee
         mGYm0TRSFbZrMpl5Che5vEM8iRRQ1LmVBFbEplo4nmrixP1h9BURl/SO4Za/03P5h+4W
         HNjI6g/hSag5L6jN5gGR1/p5YbFXkyynNIAjf+eDZRU23adJmgyJnA8Brgwnu858IfiN
         HDztI9UfruvjDTFwpbaNASOsVOdeqjeM7IhyY18huFbXMwPNlY/IBSr0mGVBnjr/+VzY
         KQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543727; x=1730148527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3bu/Gi0hRdBxTxMo+cGUtUSSKfcJsr3N8iZ/Jo3hjw=;
        b=VtVIYaWcNuMt6Vgf76zswuD+WQ/izhW4NJQSLT0yZtlNjH5SyMsHZ6iQbxq9Y8eENn
         OSKJ1fuGbmde02YRpSg0N25liN29ZExW+ibAj8bmopHxd/JwFdT/fjjUuANbS8y6G2YR
         5BYqcxcm96TlC8shvBotQ0zSx5R+0XnL4bfY69ZqwJ8bg8M5x66sbeRHFc9KIOvxS5JQ
         GPykNK1HpBB8aBaPbKVAODu60RBDq50V8G3STgMEm+Noo7+x5LT21tHramWgI2Yqf3N7
         x4+3D4SJhi1oOAnUcYfsmm2hyU6MWO/TUG7EuZR2JUUq/hNreJYrZkt1U5QU449vojoA
         6ciw==
X-Gm-Message-State: AOJu0Yy7M1YBxpBph5r+FbXczfXS7f0X2t0qCQ/FVZr1TUU4uIThjS+H
	v/xyEDTurbcsiM5+7CHDxLvfwPG2R04VZJJBj6JiGRs71nE1a/nBEh7uy6fbqvnJhfNUDFdC4fC
	g
X-Google-Smtp-Source: AGHT+IFXWPNQ2qeMu60cQMvDsehFLMhluK8NRGtLhSfnaeJh9ouqsZzgMfoagLTm7Q0KiDCfJo4KnA==
X-Received: by 2002:a05:690c:6706:b0:6e2:446f:422c with SMTP id 00721157ae682-6e5bf9ff55cmr126277427b3.21.1729543727040;
        Mon, 21 Oct 2024 13:48:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f51easm8055057b3.25.2024.10.21.13.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:48:46 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:48:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2024, #09; Fri, 18)
Message-ID: <Zxa+LH3qgbzwVsfE@nand.local>
References: <ZxLI06smvMuf/cT2@nand.local>
 <ZxZHmIJXLBvzoe3D@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxZHmIJXLBvzoe3D@pks.im>

On Mon, Oct 21, 2024 at 02:22:48PM +0200, Patrick Steinhardt wrote:
> On Fri, Oct 18, 2024 at 04:45:07PM -0400, Taylor Blau wrote:
> > * ps/ref-filter-sort (2024-10-17) 1 commit
> >  - ref-filter: format iteratively with lexicographic refname sorting
> >
> >  Teaches the ref-filter machinery to recognize and avoid cases where
> >  sorting would be redundant.
> >
> >  Will merge to 'next'?
> >  source: <e0daa6a2eac97c2b18a53399b7c124fc8d3d238d.1729141657.git.ps@pks.im>
>
> I think v3 should be ready to go.

Agreed, thanks!

> [snip]
> > * ps/cmake-clar (2024-10-15) 3 commits
> >  - cmake: set up proper dependencies for generated clar headers
> >  - cmake: fix compilation of clar-based unit tests
> >  - Makefile: extract script to generate clar declarations
> >
> >  Buildfix for unit tests when using CMake.
> >
> >  source: <cover.1728985514.git.ps@pks.im>
>
> This one can be dropped, as I've merged it into ps/upgrade-clar in v2
> now.

Good to know, I've dropped it and will push out new 'seen' and 'jch'
branches before the end of the day (I hope).

> > * ps/platform-compat-fixes (2024-10-16) 10 commits
> >  - http: fix build error on FreeBSD
> >  - builtin/credential-cache: fix missing parameter for stub function
> >  - t7300: work around platform-specific behaviour with long paths on MinGW
> >  - t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
> >  - t3404: work around platform-specific behaviour on macOS 10.15
> >  - t1401: make invocation of tar(1) work with Win32-provided one
> >  - t/lib-gpg: fix setup of GNUPGHOME in MinGW
> >  - t/lib-gitweb: test against the build version of gitweb
> >  - t/test-lib: wire up NO_ICONV prerequisite
> >  - t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
> >
> >  Various platform compatibility fixes split out of the larger effort
> >  to use Meson as the primary build tool.
> >
> >  Will merge to 'next'?
> >  source: <cover.1729060405.git.ps@pks.im>
> >
> > * ps/reftable-strbuf (2024-10-17) 10 commits
> >  - reftable: handle trivial `reftable_buf` errors
> >  - reftable/stack: adapt `stack_filename()` to handle allocation failures
> >  - reftable/record: adapt `reftable_record_key()` to handle allocation failures
> >  - reftable/stack: adapt `format_name()` to handle allocation failures
> >  - t/unit-tests: check for `reftable_buf` allocation errors
> >  - reftable/blocksource: adapt interface name
> >  - reftable: convert from `strbuf` to `reftable_buf`
> >  - reftable/basics: provide new `reftable_buf` interface
> >  - reftable: stop using `strbuf_addf()`
> >  - reftable: stop using `strbuf_addbuf()`
> >
> >  Implements a new reftable-specific strbuf replacement to reduce
> >  reftable's dependency on Git-specific data structures.
> >
> >  Will merge to 'next'?
> >  source: <cover.1729140565.git.ps@pks.im>
>
> These two are ready to go from my point of view, as well.

Great. I had your ps/reftable-strbuf topic already queued for 'next' on
my end, but wasn't sure the state of ps/platform-compat-fixes as the
thread had gotten quiet. I'll merge that one down as well.

Thanks,
Taylor
