Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC86E111AD
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178602; cv=none; b=qkZXJ4/IekujBgCSKfIk5LZ0gghX49u0/LOOAlroi+64nWgRD3E5FkoQR0+E+H8zC8Ds+BF+6SxAvhEpAxVwPOsgnos6vlBPTHP+Ucjd2mHEUxjN7XwjS/KQFqFUxRcrmHW4oChif/WnLWaSu1nj5xlswMzkDo74y+lebNE841M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178602; c=relaxed/simple;
	bh=VRHVzZquw4Blzv3OCKBdxZHBgQJmX+u1qSkN+D/uhX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dePpyDzXZD4L23b2fWl7KXBNJQVE2bcyADPCKYYzzV0sa2MhjII5MVa6oBgw8VQdMv504/ECLdelL7hT3qUbOjTPeR7xK0zx/JbwoWWwNAO33jZpEPBxbU5JL1+LLki8LlYMZQ+RTbrUhvcqlNbx6dOg1L6H4TpLl/DG4yJc62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Vj0m9bNa; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Vj0m9bNa"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e29218d34f8so823971276.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729178600; x=1729783400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3TLgJzMrQAdkVC3zEjS3yz3AHaCJFihSJ0e8wHHqNjA=;
        b=Vj0m9bNaBi687RiEpgreF4RVyee5WEK8Iphgy/LXao1vqUOO48fsUUQ41WFFGm/ALF
         RQu2mcHznhVQT7jFFxK8xBsD9r2/nNDl00cYprb3Yk1JcnmSboiIIr+/TyAx/EFogGbU
         E6eP3oiMwPyAUmF/lPTUMY3P/4PQPXbeNcgF9J/Qdln283ZpzvQ/DN1z1f8eoDkMaKFG
         ApRzC39WHhfszxjyg26Gia7hi5dZ9QF78HdoFNFNOy67QC80/ZfrQMzkI4VYfxy/Kphs
         dAsN/jSBMlvpSF8gyHycBGqRgON6xcjHcVyWhqn43FtRIP5PBih3zkk8rp9IOI7UDsYP
         oU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729178600; x=1729783400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TLgJzMrQAdkVC3zEjS3yz3AHaCJFihSJ0e8wHHqNjA=;
        b=cBLli4J5TBEHNIEAPXu+G3fk03n5FDwZ2KlE3JTKkzk1JT4+0x6fQNHPw8oh1kKtr8
         5k93dWRXyD+n29YubdBQpHZ7GB30Jj+yXkVuc96ec+ixLIrXDE2ekxK4BoQJ2bhs/kXr
         L3jhDLP38AtYNaCBoc1tSdWPMGGwx8RbgighF36hVxIIlZQ73p2UyRPKDPs+nBSqZCyl
         YERu0IvJZLWBBPkYyIpMzgsHiD4irJsTJB5cwPnxZxiuSVS1Pbn2qJS5I5MMKj1Ycgmu
         ZpzJpZweHnjTUPjH5zjWDvI5BkapykmRu/P8byBTd3Mgf9164xhM4uNFFxZWCJGYZcYA
         mciw==
X-Forwarded-Encrypted: i=1; AJvYcCXoCOkHlhSUM/g5CqSSDtp+O5MaHwqIoAaelnpVC/kcHH+5TThwn6/cjCyjMaXurQhup2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ClQIBkj1iDCNtdXlNk4g4UzMnAAP51YRtBgv5Lrm9D/7Z6sB
	sIWLmCZvUGbdS1oA1xxhifM4fvZF3iIgIGCRhlJ0km/Lf3KGs2g8CPKR5e/RRBvUf84FE5n1OwP
	R
X-Google-Smtp-Source: AGHT+IF/VxdTdaSwnR56nALFpy2SvOw6YxQRla+pSJ0/+xCXWbNG38UegXRv7uikIXM+I2jhLUVukw==
X-Received: by 2002:a05:6902:a03:b0:e29:3e9b:51db with SMTP id 3f1490d57ef6-e2b9cfb1e96mr2971110276.20.1729178599741;
        Thu, 17 Oct 2024 08:23:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296d050905sm969917276.45.2024.10.17.08.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 08:23:18 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:23:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	David Turner <dturner@twosigma.com>,
	Piotr Szlazak <piotr.szlazak@gmail.com>
Subject: Re: [PATCH] upload-pack: fix how ALLOW_ANY_SHA1 flag is disabled
Message-ID: <ZxEr4+sb4DfmtrKv@nand.local>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
 <ZxAttC1dQUllR76m@nand.local>
 <20241017023735.GB1858436@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017023735.GB1858436@coredump.intra.peff.net>

On Wed, Oct 16, 2024 at 10:37:35PM -0400, Jeff King wrote:
> > I think it would probably make more sense to write this as:
> >
> >     data->allow_uor &= ~(ALLOW_ANY_SHA1 ^ (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
>
> I think we have to treat them as a complete unit, as we don't know which
> bits were set by independent config lines and which were OR-ed in by
> ALLOW_ANY.
>
> So this case:
>
> > Stepping back a moment, I suppose this is handling the case where a user
> > writes:
> >
> >     [uploadpack]
> >         allowTipSHA1InWant = true
> >         allowReachableSHA1InWant = true
> >         allowAnySHA1InWant = false
> >
> > and is surprised when the final "uploadPack.allowAnySHA1InWant" unsets
> > the previous two options.

Yeah, I think that you and I are in agreement here.

> is the one that Piotr is thinking about. But what about:
>
>   [uploadpack]
>   allowAnySHA1InWant = true
>   allowAnySHA1InWant = false
>
> Right now that pair is a noop, which is what I'd expect. But after the
> proposed patch, it quietly enables ALLOW_TIP_SHA1 and
> ALLOW_REACHABLE_SHA1.

That's an even clearer example of a new gotcha that would occur with
this proposed patch, IMHO. I don't think in general that successive

    $ git config core.foo true
    $ git config core.foo false

should have any user-visible effect, as the latter should nullify the
former.

> So I think the code has to stay the same, but we perhaps should document
> that "allow any" has the user-visible side effect of enabling/disabling
> the other two.

That would be a useful direction, I think. Double checking
git-config(1), there is in deed no mention of allowAnySHA1InWant
implying the other two options, which seems like a gap that would be
good to address.

Piotr: what do you think?

Thanks,
Taylor
