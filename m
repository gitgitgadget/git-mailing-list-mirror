Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF501F946
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718393714; cv=none; b=Ae0NChcl2VPcR7N0KrtBomVhbkgQMvMyOMYfep2dA1Iw2yj8nmEBn2xcoM5Hik2I80ubTSXrdl5SlCKGDMkt4ylRJNWpUYs6g+l1mffsX4jaFFObgMiIsQegkOsI1cNlZpsW+n81T/Bj6F1Xj1lE4KEeFnWPHqwnvq1DArMmhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718393714; c=relaxed/simple;
	bh=9nQMVIaddep1yP78WBbS2YUFf+0fVdQnKKFAsHkwkOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJhMEplqH7yDRwdScxQfC/0XCuxA1aC8svcjbeOCED+/kOjqUKc6nVcpKQChA1wyiWvL5ue243iFZST7IxlUwowcJN70/phzQmBA3giEzM/9tRgZrZpSLRTjVvuQZbl1zyhV4G9szKBZ4Gk88TZUN3ln+92yrSJ3fH2cuPc+JUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=chyz9+L2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="chyz9+L2"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4405743ac19so22140211cf.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718393712; x=1718998512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nQMVIaddep1yP78WBbS2YUFf+0fVdQnKKFAsHkwkOM=;
        b=chyz9+L2v3muOF+D4W6/2aWvkbb9bDJ8HKMu0/uN1hKt1a932sAjhvfE+Lt7SjjLNT
         wGEMpy3lAYy91UqSlLiatEzYg99FOlPEeFLxK737EG3teEwuLDV6sH50iZx9RkOFb/vQ
         GbNtlYcOMHaGQOTERy9dY6AWLyDoc7RiwEhSGpVneAxU3iQRgb90mIqK3JCpOboNPkLp
         6xxjN1q88OwByWk3aNlFTzJORPs6uuD8j2TpqfhE016e+7F2hwrvKUB4Awx1MyO6F6II
         4XhYEgvYAZLJIfbNVFMtXc8UA39qkzgJFkAed4sLSHNMyh3vJh2YG/Uf3OFIZ0pvl9BG
         a6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718393712; x=1718998512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nQMVIaddep1yP78WBbS2YUFf+0fVdQnKKFAsHkwkOM=;
        b=aMql3RPEjQl8jFFZq2+ru5ef9mKkJLdRHI6EiLmi9BZGkleEZMPTD4J0t32QT2wrmN
         BV2L6+gxwOSRn29CctP4TIjwMzdaZQ9031hqXBE/V79VIIXKZ14n9gj4lHBNhz24NsMz
         oVtR+3pqg3mvDFUqJLN+SfRc42cXgRUlk4LahyTn1BxosCcVVY0Wi+bKkBM8QF8b08ys
         9lejwB73ZqMKy5MOdVcf6lN5BPJhfiEGDzEtEYRI5whBh8G5NqS8PGd9qi+ikGCPblwP
         X1kW5hcFr7hZ8UjizpQWeHjNcvrHpbBLPNznk6Wq+5u9DXHaOwqroLPQ8MBohxGiZH3a
         z1qA==
X-Gm-Message-State: AOJu0Yx1XGb5PXAxOgREoumcGfDjqZNewMFH54jC7wIhIPs54VTWDhId
	+vnFLMLQk9s8Ln+ev4eIi/LKgVHvJ2CqNiwHVDHl+aIrE5XYl+i+2EAICszehSs=
X-Google-Smtp-Source: AGHT+IEY4EseMjN4ZXLeK8Pyz6ZWTGbwQuiHcWzFDngeVXFGQj7iYlmHteXCZhOAMWMVVCiDvVGlEg==
X-Received: by 2002:a05:622a:15cd:b0:440:97b5:cb with SMTP id d75a77b69052e-442160b43c5mr62072921cf.32.1718393712098;
        Fri, 14 Jun 2024 12:35:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4421772802fsm11346671cf.58.2024.06.14.12.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 12:35:11 -0700 (PDT)
Date: Fri, 14 Jun 2024 15:35:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] commit-graph/server-info: use tempfile.h in more
 places
Message-ID: <ZmybaokdVIXOX+6D@nand.local>
References: <cover.1717712358.git.me@ttaylorr.com>
 <20240608104821.GF2659849@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240608104821.GF2659849@coredump.intra.peff.net>

On Sat, Jun 08, 2024 at 06:48:21AM -0400, Jeff King wrote:
> On Thu, Jun 06, 2024 at 06:19:21PM -0400, Taylor Blau wrote:
>
> > Looking at the remaining uses of mkstemp(), the remaining class of
> > callers that don't use the tempfile.h API are for creating temporary
> > .idx, .rev files, and similar. My personal feeling is that we should
> > apply similar treatment there, since these files are generated based on
> > .pack data, and thus keeping around temporary copies is unnecessary when
> > they can be regenerated.
>
> And actual loose object and pack files themselves, I think. I think it
> was a deliberate choice long ago to keep those files around, since in
> the worst case they could be used to recover actual repo content (e.g.,
> a failed fetch will leave its tmp_pack_* file around, and you could
> probably extract _some_ objects from it).

Heh, yes. Those were intentionally omitted from this list ;-).

I agree that having the content stick around in failed packfile and
loose object writes is useful as a last-resort recovery mechanism. I
suspect that it is often difficult or impossible to recover the contents
of an object/pack from a broken write, but I think it's better than the
alternative of just throwing it away up front.

> And the philosophy is that we'd leave them sitting around until gc ran
> and found tmp_* in objects/, check their mtimes, and remove them then.
>
> In practice, I don't think I have really seen anybody recover anything
> from a temporary file. You're better off looking at whatever was feeding
> the temporary file (if it was "git add", then look at the filesystem,
> and if it was index-pack, look at the fetch/push source, etc).

Yup.

> So I'd argue that we should just treat object/pack tempfiles like the
> rest, and delete them if they don't make it all the way to the rename
> step. If we really want to support debugging, we could perhaps provide
> a run-time knob to leave them in place (and maybe even have it apply to
> _all_ tempfiles).

I dunno... I don't disagree with what you're saying, but it does seem a
little scary to delete files containing data that we might have been
able to recover.

I think the current series ends at a reasonable stopping point... I'd
honestly have to think more about whether I agree with what you're
saying here or not ;-).

Thanks,
Taylor
