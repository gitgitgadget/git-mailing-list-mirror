Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD4736C
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730074222; cv=none; b=ExCUfNifjz9bMOpCH+YwaEzMYCnhDBAO8ZO8ffKv+pOWcQ/+E+o5yEOyWFjrYKdNtBrjiZ176xMa8WTi8vdq3yLd4jblx6eitIrwRWT1jSCuUx9Oe6PGX76pJgSn7E0HDO8k8EsKYaByh909wZap2xeFMr+6KQ5bUeudrsp62yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730074222; c=relaxed/simple;
	bh=N+l24RqB4nOcOvzrGXhsbj0aoL+c4UY1DdotTrXmy/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX/PRYXeqhUobsP8Ze+3gYAt1LxgN6/O7ouWmrO1A4Fo4Ds+AxLmceqJkUsXhJlrNclPjJ3w9OYSOhJdmarWAfznz+fCAv05WkjNez1u7DPN9uhx3ii8xzOxpjixpY4NKbSJDXqqfiaLp5EN7ywQvfqy1GktB12fpFMs4Fco5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=x+P8feGx; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="x+P8feGx"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e3cdbc25a0so39677797b3.2
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730074219; x=1730679019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTYJJ7DNjic1wyynL/1P48zrusVWGfhvwQFTGTf1knQ=;
        b=x+P8feGxAqMabWmO7vmd6Fdv+1oJpYV0KQXwnFRLaB85DAl+Bl/pFM1pUsB/om2KTo
         5J3dnXDMKMH7eQKD2ZuMmkUjVoM9VpYWIBRJcnciDvzTPEkZMmP1CXdIXeJsbBz4TlSr
         hLIPC/uUjwth6Q0u/QQPQZO4vGvMBHCDUqdjRSXfqNqqKCEvsuFUxXovu8wpe7mgyPfI
         zCzV57865b3iLIcgfEARSGFqHU37nSLS8YRdjuh9rcTWZFp0IpD2+ih6PttyWijwYIGE
         8X1ZGawCLdcgNUeiIvqc5VKWyPbkQ8MuSg1Svd+qw6TfsKLkRGyfcAK1Wu+252Ige7JZ
         EGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730074219; x=1730679019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTYJJ7DNjic1wyynL/1P48zrusVWGfhvwQFTGTf1knQ=;
        b=oXO0Q+OwEBs3Uo6lS3qXwAfRoSXZpTOgdG0cbuFd7rDh3/eoASLvhPw+ILArBZLDg5
         C0PM6RLCMcGzz5RdVGuYRM1wvlH/GGdgu+gPMyOkW8DNRlcP9cdURnmFPFCdnGMRECKs
         AzOSnUdzekm1jG1CL5ZLBGE6ISpclkuJrvANqp638zaDDeB4MujqQLTLbbhikrgi+ahd
         /tYEVSZ4mG857Yc/fEwIbW1mW3kfsS8Y6qd6LNlw2y6NXnWOfdfe0tJuxJA1DdGf702L
         Uzcsv+MRRdbDvDdlN6vLZxg1F25tZ63frfeSFZfEjU2zJjNphb0nvZBRMHYjFjp1zzzp
         nJxw==
X-Forwarded-Encrypted: i=1; AJvYcCUster24mg8Mhsuxz/F0uuI61sUmoMx0JpgM7bvb5EptjbqOwz+9EAbl2j4i3FHYZq0MTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDlTK5gxUIaZTAR0IMKUrO4zW2cl1u5JZ/kpNLHTOQr8Wrtym
	TlNJFLIEKeKO86RCtbTNtYixftWGCl834xHXXDhV/8n6Dw4/77AXmy+JyD2N0EQ=
X-Google-Smtp-Source: AGHT+IEINOSKXPP6z1ZXJ2wbrVLRW7BAFWnLnlRTLaOIwNSZA4TBPKZRS17bLbM6kkCEZUqUf1zH3g==
X-Received: by 2002:a05:690c:6885:b0:6dd:c6e1:7570 with SMTP id 00721157ae682-6e9d8ab97e1mr60704707b3.34.1730074219254;
        Sun, 27 Oct 2024 17:10:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c18381sm11961937b3.58.2024.10.27.17.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 17:10:18 -0700 (PDT)
Date: Sun, 27 Oct 2024 20:10:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, sandals@crustytoothpaste.net,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3] show-index: fix uninitialized hash function
Message-ID: <Zx7WaEn6nvtjhs/B@nand.local>
References: <xmqqzfqi4oc6.fsf_-_@gitster.g>
 <20241026120950.72727-1-abhijeet.nkt@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241026120950.72727-1-abhijeet.nkt@gmail.com>

On Sat, Oct 26, 2024 at 05:39:50PM +0530, Abhijeet Sonar wrote:
> As stated in the docs, show-index should use SHA1 as the default hash algorithm
> when run outsize of a repository.  However, 'the_hash_algo' is currently left
> uninitialized if we are not in a repository and no explicit hash function is
> specified, causing a crash.  Fix it by falling back to SHA1 when it is found
> uninitialized. Also add test that verifies this behaviour.

This commit description is good, and would benefit further from a
bisection showing where the regression began. I don't think that it is a
prerequisite for us moving this patch forward, though.

> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
> ---
>  builtin/show-index.c   | 3 +++
>  t/t5300-pack-object.sh | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/builtin/show-index.c b/builtin/show-index.c
> index f164c01bbe..978ae70470 100644
> --- a/builtin/show-index.c
> +++ b/builtin/show-index.c
> @@ -38,6 +38,9 @@ int cmd_show_index(int argc,
>  		repo_set_hash_algo(the_repository, hash_algo);
>  	}
>
> +	if (!the_hash_algo)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +
>  	hashsz = the_hash_algo->rawsz;
>
>  	if (fread(top_index, 2 * 4, 1, stdin) != 1)
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 3b9dae331a..51fed26cc4 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -523,6 +523,10 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
>  	test_path_is_file foo.idx
>  '
>
> +test_expect_success SHA1 'show-index works OK outside a repository' '
> +	nongit git show-index <foo.idx
> +'
> +
>  test_expect_success !PTHREADS,!FAIL_PREREQS \
>  	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
>  	test_must_fail git index-pack --threads=2 2>err &&
> --
> 2.47.0.107.g34b6ce9b30

These all look reasonable and as-expected to me. Patrick (CC'd) has been
reviewing similar changes elsewhere, so I'd like him to chime in as well
on whether or not this looks good to go.

Thanks,
Taylor
