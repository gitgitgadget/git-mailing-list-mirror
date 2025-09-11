Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB72D0C89
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628555; cv=none; b=ltayW7TuahtKR+nN8a4lqzBX2fs1WRPQztHRzc0zkYsAlI5/9fu360qp7LqbCsDA7J20K/mI5eoTwMhgKSNKG6OYGzJrmQDLB0ElPV/XdAeHXOXPutu+At7rriFxYrLQtEya7xerPItBgaFc/dDkh8L3X3Ih7PUXtzPkBjrJspw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628555; c=relaxed/simple;
	bh=Nr1BM0yQVO9OBYT40JkomHKlyTIXbfgRfVBfHN0cD08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzXPFUKP6Z7hQqfsWIrOeQLU3sFVhGssGrJaf6PJGI4dh4/b4sRenZ9qMYx+0HNT4f1D+C04E5PNA08giq7CMr/hIfBssiU+yoLKjQsx8+4LpdYQ+qw1H2mVyf7zCQAeYqPXzW4dxlg9eiQsZHQq+1ZNUN/LNqvZEyIaLNvj4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=IxAxqs/5; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="IxAxqs/5"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea3c51e4cffso922717276.3
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757628552; x=1758233352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sEWyGYVLHGNMHjO5NOWQZpzZPCR5DzKGa12wDKWsv2w=;
        b=IxAxqs/5/Wf5s4PNTkrrtSppRrkk7VrWz1wL2KD8R/QrzF8TYB2ostAWgLHglVBbiz
         JPgv0JaYkhagILZTonCYC8iKLL2AtBReUUhexm20qTt8TYE3W/0oNUJ7UX7NstWqrmpb
         dNU7rnFLY9Fw5Slr4iAmN1oFrZSVtUNdqDtM9FlCedYieAR2PeoTWgF8rPqtbYWDP6/K
         pGKKMB4ZexhvKkW5cGMDecXDH5gLoB+NgdQfcjtu4GVHLO1JkjXGvPhymmOYaeQ/NM78
         V6eDKFNrgFhZKP2xlc+i2tzG0McRwLzFEy/kYo9a6WVylnxjMyUb0/HbcBfOf9bvWzbG
         1S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757628552; x=1758233352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEWyGYVLHGNMHjO5NOWQZpzZPCR5DzKGa12wDKWsv2w=;
        b=c1psqQql51lO9hd9W0SbYVclVvSsaObPvEGhLozlHGY7LAZun4yU2S3Q3UB1VvBpgK
         qYln66Dkinb8XpGFOxlb4RaQYI55NUHU8Of9xr52fAcwA2UnseD1mQcLbAf0hOaGRwSO
         RPxuhgyiB4VZHgvMSQjuqk4sDUv9T55hQ6DsOG5A03ATSSWeMeM8vxBjSBpzP20n5ewz
         Uq6qAcGOdNKwITtPuMUde6or6TXJix8EPD2N/RP8N7ph7JpbG4AorK/hwRCuD/t/iNi/
         80fuBfDARnPX1t1yZF1OWBZsCyuRLheh0Z2nyEx1blpEhIpAInF9wMKGM0EcSrBEutYd
         TQ/Q==
X-Gm-Message-State: AOJu0YwwEnv3AA8teRunfT8nz5qP8Cs+KQyFXEhGwgiM8SInkkSD/9Fm
	PXrxUx1Jvb39wyghBjSpZfAMddBVnJZQpto48ZKb9Bpj4ayop8Xgf4Ym1oME1MmyHiiI6yyPHu8
	ME+0K
X-Gm-Gg: ASbGncsAbo0s4YgpZItaV4iT2thHfVJDI5G/H3G+DrLvrRB3D8q84wIk12TVoLFqcev
	r/8UiuntJJcBBZcmx7bux7t7f3cHJQpfHOuSRNbbLyH1FjKdhrz/OXxpWSKmZ3tABCpkTmcbrDR
	xE5H7e2Gks4ezl4YXTNnaDPG5WtGToXMNBCF0GlkMqjJwtdm9JitJqlCn3Afzo6FRN8PoIeT5A0
	s206uIWOogQ5P7HZlHXianAkKEPZ965PK2OvXiOf3/Hb6zdL4/AwDaj4JLjDraMuJ0aVI9+1s+x
	GKBnlRa31XUpAMpBlGnZttJHdnnixabcXDho/SICclJ4BxfEvlpy9akoJ/emgkUMKi84KxvKDjX
	UZUgaoURSwMZm1wBInagDF2tczTw5G8of5L60t8NuUcqN4wq5/wr4fNn28rFsblrvR4K4XcLzoV
	7bZ2243Bndf4R7fSh40gNsa/p5XJgohaST8cIW
X-Google-Smtp-Source: AGHT+IGgApSViU2D46w53toZu/91yRenm0u8aA3qemGaEpsl/YwvpbUHe7d4G3ni17ig/NIufhA4TA==
X-Received: by 2002:a05:6902:4187:b0:e9d:6ab4:92ee with SMTP id 3f1490d57ef6-ea3d98e86dbmr707423276.3.1757628552519;
        Thu, 11 Sep 2025 15:09:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-ea3cf267a0esm837244276.32.2025.09.11.15.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 15:09:12 -0700 (PDT)
Date: Thu, 11 Sep 2025 18:09:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] blame: drop explicit check for commit graph
Message-ID: <aMNIhquknyCSquvf@nand.local>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <20250904-b4-pks-commit-graph-via-source-v1-1-d932c2481e1a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-1-d932c2481e1a@pks.im>

On Thu, Sep 04, 2025 at 02:49:55PM +0200, Patrick Steinhardt wrote:
> diff --git a/blame.c b/blame.c
> index f1c0670144..cb0b083423 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -2909,9 +2909,6 @@ void setup_blame_bloom_data(struct blame_scoreboard *sb)
>  	struct blame_bloom_data *bd;
>  	struct bloom_filter_settings *bs;
>
> -	if (!sb->repo->objects->commit_graph)
> -		return;
> -
>  	bs = get_bloom_filter_settings(sb->repo);
>  	if (!bs)
>  		return;

Makes sense; get_bloom_filter_settings() (as you note) will return NULL
if r->objects->commit_graph is NULL, which will cause this function to
terminate early anyway.

Thanks,
Taylor
