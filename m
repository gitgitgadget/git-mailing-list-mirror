Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2521A257C
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614116; cv=none; b=qntdt4/uQaGW6AtUg3CKw+FNPu/XzQF7suQi7Rp+5JGhf3T+izOnMSNITwN1DkMtP5gK0ty7Bm2cf+aWNpO8JMZHdXchYcVckDCommvTCIAplz01ql2nJa5vbwgPU52zy5l8AtyUe8h/ht3RnIluvyfbqa/Bx7c0TOY74RlHck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614116; c=relaxed/simple;
	bh=6leJJBWNsUy1B2n3lEF8OQFWKbeLNoFklmKZlsO+ABo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU6EXj3upR7idpKiF9SDEtiBDldd9om4VDRHSOIl+I+KHcQ0uVW+/3HLl/HgwMZBexLfaucYP341+3nIJkURuI298PQrrL0zsRjFVpukHUbCKo3OFAErAM1gJDLHKv+7N/pJGjPhFemElSlGoqciCiZVKf3sLJ6ZMxeKFmLu248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LNBqZXar; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LNBqZXar"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e2e2d013f2dso819721276.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729614114; x=1730218914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/RwVDRDDj9lS6u5OjfTY2F9US6olARz5uTJMnNoFufM=;
        b=LNBqZXara+vzzvWuup1XX8+Vq5T+JlqKFn3r+NQhkq+pkNddJCuOdQe/CL14Z/zJek
         5UEcjUWfbzlwN1hsF+P/YqC6b449NPRWm01S4iRu2LjHE6k5XpPa38IRyxLSaYDx7ywJ
         03QKOh0Ed34Kp6CD5dEmq2bwQ0Ei15ZYdUL+ME6zxen9yIagAD60blQGHT+C5d5zC6DD
         sOno8aGE0W765m4MiCEkNVWhgi4K2u0MkdKZbisRc1UkJxV1JirWnnb4lNCjBZufVRzi
         PbXjGXMll2HwkXthEBQaRF/YanrBo8Kpj3I42tWgbtwQnu5wJGp5hbEtpzsVtiM0/CjY
         kQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614114; x=1730218914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RwVDRDDj9lS6u5OjfTY2F9US6olARz5uTJMnNoFufM=;
        b=s2piKGbYXXD8NNES8HXUpnQ3lQrgbstEIp8uZFoK73QOpS6LtFqCOO0HfVUuHstBUa
         mgWCbLABj9FdFtraUt7nGMCU9uHc8CWcCinHD0+L2xighieoxi06LDq8subQSmIq2olb
         CkkWCLToDQGu/m0UF+t4rMSjUR+BnlLQsXnivA92i0HqYAY1fS61FgMw2PHxx9abnBob
         7rFLbBtVSeqL8LjpAv+zVhEMsBQnldlm0W2VhEFEaOgOgPomQBeCbzQEN8r56bPPTjBo
         CFHOhpCoHytvu3oUF/kGyJcBkJ9VP/R/fNbwfoFAvhJU8ooNdTyOhwA0dLtjhpZ6sw5d
         2LCA==
X-Gm-Message-State: AOJu0YwQzLpC0Bz6cygHHtWBWcHZQA8YlS1cHDm3x2Opu0Yl1d+yh0a0
	eG2q+TvHsxcviVrRpA4900TQSRJO7KbRWGhXpfKW6r3MGJVyg/VegPO0qIjB0f0=
X-Google-Smtp-Source: AGHT+IG4qKoxzTvcWNcPeNFdQS4kQrJiEhP1C4AZkjIm9iTaZFnEpEL08bhCNqhEtAtBELrPIVGj9A==
X-Received: by 2002:a05:6902:2848:b0:e22:5db2:a950 with SMTP id 3f1490d57ef6-e2bb169062fmr12663354276.39.1729614113769;
        Tue, 22 Oct 2024 09:21:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcaebbb9sm1175300276.47.2024.10.22.09.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:21:53 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:21:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v3 1/3] daemon: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <ZxfRIIcd2H4S3i3+@nand.local>
References: <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
 <e292b82d6a1d46990477a043901fa9c56bc00023.1729574624.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e292b82d6a1d46990477a043901fa9c56bc00023.1729574624.git.gitgitgadget@gmail.com>

On Tue, Oct 22, 2024 at 05:23:41AM +0000, Usman Akinyemi via GitGitGadget wrote:
> diff --git a/daemon.c b/daemon.c
> index cb946e3c95f..09a31d2344d 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1308,17 +1308,20 @@ int cmd_main(int argc, const char **argv)
>  			continue;
>  		}
>  		if (skip_prefix(arg, "--timeout=", &v)) {
> -			timeout = atoi(v);
> +			if (strtoul_ui(v, 10, &timeout))
> +				die("invalid timeout '%s', expecting a non-negative integer", v);

The conversion you made to both (a) use warning() and (b) mark the
string for translation in the second patch were good, but I would have
expected to see them here as well.

Perhaps leaving this one as a die() makes sense, because we are taking
direct input from the user, so invoking 'git daemon' with bogus options
should result in us dying. But these strings should be marked as
translate-able regardless.

Thanks,
Taylor
