Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093749652
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617195; cv=none; b=O5O5uHJR/PspOBXz0S4s8Vas9/NFp/PXZuf34N8uAtb6BS05HrNOh4mhyjqIvDk3XPRFvT8uTd3sSCVpDgF22SMuJmJ5ie6Rf0Xh72/QCVsmrIaIAvcJg9C32FP/2cRPBi2cKyWZV2aDzPJx1NjnsOM5sCY70fv19VvZ2IpDoSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617195; c=relaxed/simple;
	bh=FBY2KQVt2OGGRBLEPjWXfRpzVUL25wTqXVmCPSLJi1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOVsl2Zc2XFWL2zsUoZijNBg1LI4mrF1B55rP5bjaDVsJis6khJMNfefk018pXjcQciLzfwia5O/JxSRze2+PsFBXyFX5DUs/rvmbf4DTwmyGa7x0OzgT/zGkaM/HUxgJadVoqTdg3zAZoM1Lrs4eB6BXRr3XMXGHtmsZaANKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=adLNzt6D; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="adLNzt6D"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2972abc807so5407713276.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729617193; x=1730221993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EESaS3XXqvB8l05VVbdyXBeSpU6++3J1UjHqReI0Ors=;
        b=adLNzt6DhcBtJpjryetJKya+pu3QW2QzhwvQoKnPvFBVV2OWeuoIRvqF/ElvUk2gDr
         PSm6XRlbqKUytFHsNyzgeQpiWkmigJthSaYUO0Wni1GinhlA8HkiIj6FkM4LEbnNocSG
         9B+dnJwSCVPEGlG7ozHajIRV8BbkEi7THFvVMxdmWyGyiSA20zFZzvMCNywZCKUYEJmh
         R8ETQ3wQPgVcmYksv587VA1z6WKIXDAWpSKxlLBN5iwYIAyT+1L2x9rZdw/QepWDqoGZ
         gfSq6uHRc7SuWt6pKv037z9ouplvyTUWZCuTpiJIEkeiK+JLoowTlCtPqzBa/jLWcSvg
         6waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617193; x=1730221993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EESaS3XXqvB8l05VVbdyXBeSpU6++3J1UjHqReI0Ors=;
        b=VcEl0Z+KCvveKHMGebJD4uK2odAEDrCfPzFFNA8U4BxKRpS0SxFInYuaE/14svihPJ
         w2RDR+L6jQA20tKOYHDFO/Bp/A05KSkm1sAq4hmc7JOjD0B6oxaKdzD0bRQLHbeziMUe
         qKS/RRj70o4Yu+ITAIoxF9JzvEzkmtks35k75Qfxuy+MAGRqb8oiaBbJKE1jPR225iXq
         556PHiF+mcarkGSapkmY658HeHzd0IQpGoDucflPi9II6oyPmASYHaUPmTkGqurES6aH
         kubOc4nEs/vX76k+PfKGxSr1WtDxvGrZyEAuPtsBFiAag/RxloeeskUgIaYAThEVg+Rc
         fMMA==
X-Gm-Message-State: AOJu0YzmHnUcgdKnyTEwRnoM6rTXW0k/+7a9z19RWr/NnNMTtAEcc4zR
	CbpEN6GCCiXqOB8nuqifqclB6jCdfkC4WWz+hr8k8F+ycVuvFh62PGUj8les3qs=
X-Google-Smtp-Source: AGHT+IE7lBDj0CbZYDQqvi6O92Ab7fqPnjnfKBDewbGqYIJx/FV4XGE/binPGaaI76GRIhYehf39lw==
X-Received: by 2002:a05:690c:9a82:b0:6e3:10e7:b418 with SMTP id 00721157ae682-6e5bfeb26damr130015877b3.46.1729617192666;
        Tue, 22 Oct 2024 10:13:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d1431asm11462037b3.119.2024.10.22.10.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:13:12 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:13:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: consolidate extensions in git-config documentation
Message-ID: <ZxfdJs5+YbpHgpdv@nand.local>
References: <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me>

On Tue, Oct 22, 2024 at 12:08:49AM +0000, Caleb White wrote:
> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
> index f0a784447db09856639ec43b443681f13c17c966..5dc569d1c9c77c15e32441493289f9c9dd5e7f0b 100644
> --- a/Documentation/config/extensions.txt
> +++ b/Documentation/config/extensions.txt
> @@ -1,17 +1,13 @@
> -extensions.objectFormat::
> -	Specify the hash algorithm to use.  The acceptable values are `sha1` and
> -	`sha256`.  If not specified, `sha1` is assumed.  It is an error to specify
> -	this key unless `core.repositoryFormatVersion` is 1.
> +extensions.*::
> +	Unless otherwise stated, is an error to specify an extension if
> +	`core.repositoryFormatVersion` is not `1`. See
> +	linkgit:gitrepository-layout[5].
>  +
> -Note that this setting should only be set by linkgit:git-init[1] or
> -linkgit:git-clone[1].  Trying to change it after initialization will not
> -work and will produce hard-to-diagnose issues.
> -
> -extensions.compatObjectFormat::
> -
> +--
> +compatObjectFormat::

Should this be `extensions.compatObjectFormat` instead of
`compatObjectFormat`? I think the latter will produce awkward headings
when these all get merged into git-config(1).

Otherwise, looking good. Thanks for working on this!

Thanks,
Taylor
