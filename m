Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5261E520D
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425351; cv=none; b=AcNhBqUPbY/Io60aOEmWkzHIOR/ef6yuY64SU7x5bLa+gx+U9FVW5fQwqwyBs1E5Tmwsrye27px4fCIn0V8ct6fGFWWbMCb1nl2ys701yNasRD2z9eHiGlMf4zbLrdEeruJbAQxCJRaT7YslHmmRxLHKK+W5cH3A7Nf/S5Kw+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425351; c=relaxed/simple;
	bh=ZdPfgywmAwvz94qAw+OIO/nRYY6FxVw5Kpfko4FYVcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me7yZO6fMXQ3e9z+OROWOvDdMp8NsM33Im5055yFH4u5EPKD15fXD7V0Y5WTGJ0httZIwA0D7odoepZs1EGqcwxQpxYNTpaQzD8ufKr8+8PYneBGH4t3TXWNqkfi+TcLHWQP2VgjSZi6yqbIBPrX2TFoA8AqzxUGgDYMV1qtnog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=j6M5i9Ym; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="j6M5i9Ym"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e6c082eac0so1425686d6.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742425349; x=1743030149; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jt79UJwrLp1H861fkAXGtPlvZbjulaV45Qs3Mj0CJPE=;
        b=j6M5i9YmtlmesUp3GywP/iHjD0fcseLOhwPN6Eh9IecFLv/8A4tef3/xcD12Ybm44m
         wCLPNGuhoyrVXWf10NNa5bioXVzKzPcWuP/9iDAkDH1ZVFbyx3BL11KWH1Ancbf3CrAg
         C52finv2QAXhP1Z/9qGi+19PQpHensSg3GWnjsEIJXkv3OM4j4yCKG34ntRTUjh3xFk/
         pKjGuyrIypw2xLANQDiFVPGLyJQallquvsrhzXUdTCd41bWIsCjG40wTZhywP3v5RwOl
         w4atNehi7+twBGzQC2yAJrCEiiR3Ger6UFg3MXkiChYRwGK96HC0DVaJavfkI10k9Ehm
         /nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742425349; x=1743030149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jt79UJwrLp1H861fkAXGtPlvZbjulaV45Qs3Mj0CJPE=;
        b=UbEa8pkNCeG21R62AeN0Zz6rH1gDOi5tvZ2x1Po6guZxAVfHxowA7jCFKbG95vbSCa
         w2214Rx7m+9ImNjfQORz6IJwHHCMUD/ANEJ6KKMFxPqFQncxhKHvl/7JWCBwV+21PxGw
         KNQactZfROFCjuFR4Frf9WLnPBdr8s4iqp8PCHBK7ay+B+DZA94cM9OpuebnG+lawgvE
         o+/Jk1hcRQbWbTOy286/LCs64TV/PLSqPsJGW7fLIHFI20IbfX/rxAG1fhTRnlBoIji4
         98unZdUlUearOU6qjTcNIAIPjPfz9I9SUFD9ZJ1d5uz8UmQ50yR6oeT6z746z0rob6n2
         oO+A==
X-Gm-Message-State: AOJu0YzjM4LJY8HqTPdjLr3la3e3AWgZig8nuyruzL/kqCPW1Zz87KQ4
	5XGxa+OZ/19tYpjn4EKao/cwzr2GdIStv4GE0ivduALjRvkxzxlRmhoL3FMWpzfmHrzWtbBuKE3
	sofQ=
X-Gm-Gg: ASbGnctZ0qGruV3/DBH7uvNQ/UUVHScTllKcNpjk093WSQH9SFfwo3fySP2YFGIeZ+n
	+5Q/bVLu/GM+A0wZTqgcILE/4hgfu7lZKIgclFKjQLPWxunlPV92nmt1WIlxM/8Alx2194f3erD
	m07nMAvrDi9YtU4cNFdNNXkD9kkXd5rZ1bcn6H82WkR5r6wUpGMwksQ7GDF9766S3KBCrLXbjJG
	Tj47whYNUgk0RUu/BX0t8d+5NB8sgSSWgEaSWWv8V/I4NHId3dybVXYn6ARzMDZpd6nIFML7NeX
	fbNdfRqWeiUCY+9XRE7kMyTo2c1xqj7j7Jj5LfQMeF+RJF/hXdgGN26KFqIIVWLzt59JwCJtY9r
	Ju12ts5HqlcluFDTC
X-Google-Smtp-Source: AGHT+IFrzJ2lU/agkOKAgyxWGflFfrzHNtqk4CXR3yrjnFca81UT0BlSi/QJdpZRDQ8RJhiWvbAyRw==
X-Received: by 2002:ad4:5747:0:b0:6e8:86d3:be73 with SMTP id 6a1803df08f44-6eb3538c672mr16895366d6.37.1742425348890;
        Wed, 19 Mar 2025 16:02:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb7f4a9csm85146511cf.58.2025.03.19.16.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 16:02:28 -0700 (PDT)
Date: Wed, 19 Mar 2025 19:02:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 12/13] pack-bitmap.c: use `ewah_or_iterator` for type
 bitmap iterators
Message-ID: <Z9tNA/2cZI5ssHnr@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <a1cf65bedc94ab6e318ff81a6d48eb30b6fc7868.1741983492.git.me@ttaylorr.com>
 <20250318020526.GB1473033@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318020526.GB1473033@coredump.intra.peff.net>

On Mon, Mar 17, 2025 at 10:05:26PM -0400, Jeff King wrote:
> On Fri, Mar 14, 2025 at 04:18:56PM -0400, Taylor Blau wrote:
>
> > -static void init_type_iterator(struct ewah_iterator *it,
> > +static void init_type_iterator(struct ewah_or_iterator *it,
> >  			       struct bitmap_index *bitmap_git,
> >  			       enum object_type type)
> >  {
> >  	switch (type) {
> >  	case OBJ_COMMIT:
> > -		ewah_iterator_init(it, bitmap_git->commits);
> > +		ewah_or_iterator_init(it, bitmap_git->commits_all,
> > +				      bitmap_git->base_nr + 1);
>
> This certainly makes sense. It looks like we now use the or_iterator
> unconditionally, even for non-layered queries. It's probably a little
> slower in practice, just because it's an extra layer of indirection. But
> I don't know if trying to micro-optimize here is worth it. In general
> I'd say no, but sometimes there are surprising tight loops with bitmaps.
>
> I dunno. I guess it would be easy enough to do a simple before/after
> benchmark on a single packfile with this series. I wouldn't expect it to
> find anything, but might not hurt to double check.

Should be OK. We're adding one extra allocation, and one extra
function call on each _next() iteration. So I think we should be OK
here, and indeed...

    $ git for-each-ref --format='%(objectname)' refs/heads refs/tags >in
    $ hyperfine -L v ,.compile 'git{v} pack-objects --stdout --delta-base-offset --use-bitmap-index --revs <in >/dev/null'
    Benchmark 1: git pack-objects --stdout --delta-base-offset --use-bitmap-index --revs <in >/dev/null
      Time (mean ± σ):      1.715 s ±  0.026 s    [User: 4.353 s, System: 0.206 s]
      Range (min … max):    1.692 s …  1.785 s    10 runs

    Benchmark 2: git.compile pack-objects --stdout --delta-base-offset --use-bitmap-index --revs <in >/dev/null
      Time (mean ± σ):      1.712 s ±  0.021 s    [User: 4.401 s, System: 0.223 s]
      Range (min … max):    1.676 s …  1.749 s    10 runs

    Summary
      git.compile pack-objects --stdout --delta-base-offset --use-bitmap-index --revs <in >/dev/null ran
        1.00 ± 0.02 times faster than git pack-objects --stdout --delta-base-offset --use-bitmap-index --revs <in >/dev/null

Looks like we're about the same. 'git' here is the latest release, and
'git.compile' is this commit compiled with -O2 for an apples-to-apples
comparison.

In this benchmark it looks like this build is maybe ~1ms faster than the
stock build, but we're well within the noise range here, so I don't
think there's any statistical significance to the results.

Thanks,
Taylor
