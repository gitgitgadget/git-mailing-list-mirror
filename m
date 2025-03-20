Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8F19CC33
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429690; cv=none; b=rIujczY4EgAVrvnDWgaO1D3uzhWB/m9WAcBen6iDjHet1Qy5WHdX6U9PicFF3Sv9QiH9OM0RKkTuSyI8aY/97hy3s1fp0030OL1CwfJWulYZcdNI2h/h6XBfe1B/sOlNmbBNaRSc9Jef0YhvE2OM8XpM9KdTt8vjx9cQAnQTP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429690; c=relaxed/simple;
	bh=4sBSa6rAiACIZej9KZObVSNdkwyDgJDnjZ6gTKGkIL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu1YbDQ5nWUaJUu6RvY+RTpDu8e2F+NrkO8+YLGCe27I1vekGeG0b2Cf5t0lQHwEV9RSDFZ0/j0X71zJpJE3tjhSwQeL2Qfy6uKyyrFTM7qNvpqve0naZ3JZAZjIHAek1iAzzn2KdHU4NSCC66wfkT6cHhBGboB9ESd2qVBvanI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ieLa9BBl; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ieLa9BBl"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0a159ded2so46088185a.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 17:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742429677; x=1743034477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2LUTA/23tAls82oVQQ18s24+066fZNy17fY1+LaHTE=;
        b=ieLa9BBlpBTLl4e2FXfXSqUygziPidkHCulXQdnN3e3L7yYOc0pEGDZHo/zbusCTYt
         xZgePsjF+jycIrR07v4pfVffn94OUnQ3qotpz7AL7dVJv1F5zq1tdh42J6ELlCCNvdOt
         ZkTrRDE1cgvZDV6509+w8NlkR7JiwTO1s3thijxtKIzcQ2Ik05PieiNWNM9DeuqevyMu
         dIU8J1Qj/WSeC5h6iNownuunZkRdSRG+e60QF3iVFDb+LUfSaREtltJ3SjbK6NLfRZFw
         t2isHUzM/zxAqgmOavoSWbZUxUk/VRO5pte/d5Vxl2k8halm7VJX2tD4Rc4ycXdQeSai
         591w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742429677; x=1743034477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2LUTA/23tAls82oVQQ18s24+066fZNy17fY1+LaHTE=;
        b=IbTqjQAuHTCpLyfR2qJPsIP4FGgnCBz5Fa1G5gYm1k9+ikh2r4Yr+U3/jGWZB4DBFs
         IEjzin2vf1bNGMKEjsYWu+uxLJJH2/eTyx4e+JkTUlyNRWONQQkf/sAZwmhqnN/IQn/Q
         e1i/Uy03cqFzRuIMufoy3ggVeJp2VyEuXtBPMJFVNel29PCLgeWyRgltODaYZ4+w1AEz
         7TlsX2qcuNkjUVQ7F58Sn45i1KezNFJ4T9FZMSHwJEaFaFt/AWQwYvqcyryk3+CjeyeJ
         qygpqgARBzOnTe8OWaEF8Knb/hEZqjWGvw/k+J2ZGlXZUVfdYVyfuOkHlG5zQ9+LQ7Bf
         194g==
X-Gm-Message-State: AOJu0Yx+wkundcDJjn+ozlzn+aGMRXx13aQ+/XxcZPq8SlWwH5KOqDX+
	puQEeC2czSRppwbCNhqNuAis/20NIKx4JpcDLDN+wLWQ+TjC10rYsvCyC7XFNuU=
X-Gm-Gg: ASbGncvmm+wi/a5uW+RK4Z307wLOJyXV+Ulipz2GL8UGvvNHc9zFj79Fh2QviNcKn4Z
	mbG3eWMGt3BNYgtpFCRMXDv4Y0beTXx8OrpuCSSKKUqjR/rRjbTo/zJxXlOwAofYLKrsACnRfzR
	MELjCLFiehLcChAbpaZFiO+1TtrCMXWy86CWdVZ5wZV1em7844PKoToDUCnDYCX+sCdI1kNsGCF
	0T030juCjQTkNs0n/drwLGcGq4/1oVNtVn8BfjWhizfMrAf/HciyqIJ5eKYHuT/J6jCqax7C6aF
	1+scsK3IA8PLHqx1yjxuFXwhQ2L/UykltTrqvbQPRS1baMfg81qrd02ozYE8sCt89Pzqusrffff
	6Qc6ErEMG1DDhpe4N
X-Google-Smtp-Source: AGHT+IGfFRH4LTduRbY4U5DpJVv9HxxMAeyPTcmykR5ZDE3I8m7KYat5JuZiWu8dblxYHVrSV7UArw==
X-Received: by 2002:a05:620a:371a:b0:7c5:64a5:d16c with SMTP id af79cd13be357-7c5b0cfe180mr210686485a.42.1742429676918;
        Wed, 19 Mar 2025 17:14:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d701b3sm917591085a.69.2025.03.19.17.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:14:36 -0700 (PDT)
Date: Wed, 19 Mar 2025 20:14:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 13/13] midx: implement writing incremental MIDX bitmaps
Message-ID: <Z9td64AzrXcRZmzq@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <d0d564685bc66df71b4c3ed1093452e58e0f54fd.1741983492.git.me@ttaylorr.com>
 <20250318021605.GC1473033@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318021605.GC1473033@coredump.intra.peff.net>

On Mon, Mar 17, 2025 at 10:16:05PM -0400, Jeff King wrote:
> On Fri, Mar 14, 2025 at 04:19:00PM -0400, Taylor Blau wrote:
>
> > +write_midx_layer () {
> > +	n=1
> > +	if test -f $midx_chain
> > +	then
> > +		n="$(($(wc -l <$midx_chain) + 1))"
> > +	fi
> > +
> > +	for i in 1 2
> > +	do
> > +		test_commit $n.$i &&
> > +		git repack -d || return 1
> > +	done &&
> > +	git multi-pack-index write --bitmap --incremental
> > +}
> > +
> > +test_expect_success 'write initial MIDX layer' '
> > +	git repack -ad &&
> > +	write_midx_layer
> > +'
> > +
> > +test_expect_success 'read bitmap from first MIDX layer' '
> > +	git rev-list --test-bitmap 1.2
> > +'
> > +
> > +test_expect_success 'write another MIDX layer' '
> > +	write_midx_layer
> > +'
> > +
> > +test_expect_success 'midx verify with multiple layers' '
> > +	git multi-pack-index verify
> > +'
>
> Perhaps a silly suggestion, but do you want to confirm in one of these
> tests that there are in fact multiple layers of bitmaps? (I expect it to
> be true, but just trying to cover all bases in the test).

I don't think it's a silly suggestion. As you note, we do implicitly
check it further down, but doing something like the following

    test_path_is_dir "$midx_chain" &&
    test_line_count = 2 "$midx_chain" &&

explicitly before calling 'git multi-pack-index verify' would be nice to
have.

Thanks,
Taylor
