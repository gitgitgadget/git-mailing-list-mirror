Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A713155A34
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732142328; cv=none; b=uOwy4JfNhxkSF9Kjtjlb0k5Cs/UA+HF++eKGWH1DhQ8Drxi6N7oEpmbE6lKgS+0xxYmuFDpXE3oVN9j9BOcvg8g33/iQhT31SInDufSJoZvAZuhLqfI9ySsLSv3oVZQfP/VqYnmMJ8yH/xfr5CSMuJ8A1CnEOruJUbBC4GaxlRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732142328; c=relaxed/simple;
	bh=CY7adMgi3e7N+22z2FZ0r6uUrnqchR1Ik+W6M68kAvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijz1bMXuhXghlAxZYeXkHZ7Nk4lcN16iu9ISuQvHKZa8muYEb+Mc7UJaLhr9Eb4sLl4EcE7GvCGV6HnNMfM7i06RhSwX8H0/dbgFY7u5k3D+WQbnd/QSsKSxONDqr4wvuCa097vCywxfOL+BJM77HokVz9d/c0E9UkDr5tzPj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HfK0QN3B; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HfK0QN3B"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ea0b25695dso1780767b3.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 14:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732142326; x=1732747126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eyNdhaYLXHs2UmG/w1N50OwijEELhupIhiO/a+pbMSk=;
        b=HfK0QN3BU3nJLO4+aNimta6LbYTNCtP0gWL7yQNKJ/T8fVMTDCYIeutUdWd9H6tBCG
         t8+JJJElo7E54XfbBOVjGIphO68MgZ8XetoYMT3StaWvN4YEQocMmNdNc1LlCM/IDanp
         wHfU305WtddwxeTO8dWAyNrZoYwRdgjkQFidD5+qJu5iWbP0R74eXKq7OGmBu45qShoq
         0DjSQ86RKGE63krHeTgdkl0Ni8ul9ZBKH14cZwzyns/Yv9Epa5E2439sqgPLO9AwSPhe
         Ypxc1AyPVF2I6QxgRm8FWRS0ar2H8uCRErV22F7DPAqmtANz/0ZKAmf0TNi7O+nUJtNk
         0dGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732142326; x=1732747126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyNdhaYLXHs2UmG/w1N50OwijEELhupIhiO/a+pbMSk=;
        b=nfwQYqSKvVrna4QxLstZSmOXI8sA9nUE72X248CpKqNq3sIHLcEKb8pzSdlluEiFV+
         gwcjfIklVnciVqT3Ij+HruQrAUhdUPJ9u433RJE/Fky5pHGdrG1OFrHZlTFYSmIc7Xxz
         pFB/oZ+d77HE/50Y2kf7jIXv/8dSUwqJLwQz1er31JCJvEqASen5N8yUY4xxxRNezOWD
         auEXOz5xmmTiWwc3RsTG6tIWg++y1AzZ05Yvy8jFq4K6/maNnb9ZMVcxT4jnsDb85W30
         J413DX/mtEfszpLHU9uwgDUBEB0wKSpRpnr9yMjj2yplbd4SgadENoO1RJr6cAeLXY6P
         P1yg==
X-Gm-Message-State: AOJu0Yz3obzbdbq2CfzONg731GR81vL0OjrkKf35g4fEX3xCX89i4nyk
	VBJFFOj1iDLDI6+LWVYCMGjjVggxCUMFiSpAtc49HMcfkuZja1QOB7/bPFylxg/gtxCOJYq4deU
	w
X-Gm-Gg: ASbGncvKy3bVzuN0Ly8ZWrf1DRnxPoMXcqSxKaeE0U8OWiNboXHkXZ/aWvq4S9VzWbM
	jwqcOHGP+8/7DAUrxn0yn2ebwx8/4OZRkzfHY51SgaQkheCQpHKFkH5UL7eZilMWCRcWI5xYmmS
	naKtI4hKqgDEcI5kwRrqQK7wvcqT7dW3N5WAOwdB3O9nGNRpfFRUWOiroxnf67egCv2vr9VQtLD
	Mao/8yKIvolnqKXC5spcdipjpmZiS+M0y9Jo7o2Wdb+VzVP2OhMlBMsaWMMHGQOUFMYFwAgwioO
	oPPfJEkhn0IG5zQvdAwjRA==
X-Google-Smtp-Source: AGHT+IH24XcV33gmkRAZxHvisVxd9TERjAk40d6uxc41imUj91tcQApX6j07AWRf59wCLLg9kswPTw==
X-Received: by 2002:a05:690c:46c4:b0:6ee:8451:d902 with SMTP id 00721157ae682-6eebd0f28d7mr47736717b3.4.1732142326114;
        Wed, 20 Nov 2024 14:38:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7129b472sm24394237b3.33.2024.11.20.14.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 14:38:45 -0800 (PST)
Date: Wed, 20 Nov 2024 17:38:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v7 6/9] packfile: pass down repository to
 `for_each_packed_object`
Message-ID: <Zz5k9HsezqHEWTEm@nand.local>
References: <cover.1731323350.git.karthik.188@gmail.com>
 <1b26e45a9b4952da03ad0e2fbc0fa22bc1f5b447.1731323350.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b26e45a9b4952da03ad0e2fbc0fa22bc1f5b447.1731323350.git.karthik.188@gmail.com>

On Mon, Nov 11, 2024 at 12:14:06PM +0100, Karthik Nayak wrote:
> diff --git a/packfile.c b/packfile.c
> index e7dd270217..5e8019b1fe 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2200,15 +2200,15 @@ int for_each_object_in_pack(struct packed_git *p,
>  	return r;
>  }
>
> -int for_each_packed_object(each_packed_object_fn cb, void *data,
> -			   enum for_each_object_flags flags)
> +int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
> +			   void *data, enum for_each_object_flags flags)
>  {
>  	struct packed_git *p;
>  	int r = 0;
>  	int pack_errors = 0;
>
> -	prepare_packed_git(the_repository);
> -	for (p = get_all_packs(the_repository); p; p = p->next) {
> +	prepare_packed_git(repo);
> +	for (p = get_all_packs(repo); p; p = p->next) {
>  		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
>  			continue;
>  		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&

Not the fault of your series, but this prepare_packed_git() call is
unnecessary, since it is the first thing that get_all_packs() does when
it executes.

I suspect that this call comes from way back in 660c889e46 (sha1_file:
add for_each iterators for loose and packed objects, 2014-10-15). It
could have been removed in 454ea2e4d7 (treewide: use get_all_packs,
2018-08-20), but I think that patch was a straightforward conversion
that did not inspect each individual change.

Anyway, nothing to do immediately here, but just something I saw when
reviewing and figured was worth writing down somewhere.

Thanks,
Taylor
