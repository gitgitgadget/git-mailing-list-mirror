Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86763B0AF4
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347396; cv=none; b=o5wVSPpXRZrIFs5sZ9h2m5tPBz/PLmoQJRm4rI/UNPQ4EiL6hX+pIglbSCEYc8P42HY+wRQhxs1osal5JfMT3an6KvX7PxEBO/9mjo7u+y5+T843vx04soka4VvHHogR4hiX4tNd5SPbVS2fSFe988gq72wYiX8HfcNTcKzDAkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347396; c=relaxed/simple;
	bh=/WvDvHhd9Wl1fC4Fp6c5gTD1pqN1dQrRpzl4xSqPY4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj9PHm9o42ss7+z7Ivt4cW5fn3nkR9pCQr2o5g9JIhUKXLny6CU0llBTFvQpc/eP8LC18rSrF6eqj7Lq/d60o8hUpK4BV6QjRFL2QzT63MAQNcxhJsKaC5tHLQmPZB37TcVcp8JAtEAxRNKWFBfGagsUVUw/Ca6qlrg5o+yTKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArcbkCKd; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArcbkCKd"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d75e74f5adso1557633a34.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773347394; x=1773952194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6tjrqibmByGGmoyrmnl/fZ2Ed1WBhL0GORCVD5CcSJs=;
        b=ArcbkCKd/VrGft6aIU4zhq3ivA2708rfzcplH7EOBH8uW+piFGHOlkSKJRP4QiligD
         ymCmDEsTU7uitez1YCBU2Er69tqCDhWc20dpCsSCjAShymoGKmG2x3SVCvvn9/CKFSQm
         l4MZ1/8g+bPbwVR+G3obtAjdMQx2FyPESO1d9CGhJ0sTAcxCDWbn4+I4vVdzKcqxWgRY
         4lRXVJTvswlkMTYZION/ky0NgDyowQNi5Oc02RCN0DaG4Vkqi4nNg9hGEhrFmbxY0m6L
         nepMhqE54ByVwrRqJzVSUrvOpkuieSSu418aCtLbNVcJOosFp6hDhRjQpa5i7d4ircqE
         AQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773347394; x=1773952194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tjrqibmByGGmoyrmnl/fZ2Ed1WBhL0GORCVD5CcSJs=;
        b=mKwOyJErQS+5MbJGcx1zCBBdSY5bzOs0kAZ16WFPNeefVEt8YySqNAmt6At8fH7QfF
         E6Q7NwuicsmQQyQfezReCSUUChSJUqQdqK7ZVEVaUsjZz1dPdvSl+PpiMfhIB7jhaqM5
         zs8jnPBiM2Kj7zXyT70hPkr47GOk9RVyH+3Fpfbz6090LwazrpFR/tkJ94qUMPvcEGkR
         KrMmcxra3JWjsu1ofITOMSXiPqKq/no2Kd75zEJs4F0RIbwIxomCFWsRk+hJB6NU2lty
         0qorw2dqnbnBG5n/9zR9KZuQCwYO3lOjWBS7dWgaLE2OOp84r2i3d285CPoRJfvepDQy
         FH1g==
X-Gm-Message-State: AOJu0YyQJwS/ip2mxaq+SgYwns5MIs3cfElAnib9fhb9BNoy87CBEIxD
	vsGYT+OmO08eM7Wb6mIhSZ8HXWzfdWnELngozGYJnVajrf+h5S4ulRHp
X-Gm-Gg: ATEYQzz/3DWRYJWQx/DyORHnTAWsq2TE2S4SxYepkWo0gC3/TZDPcIVyCdSDfVQw5J+
	4EaMqe+m00/oLWxPnQBoZfHod1RBuTEeifiiSNWFgj3JcS3ai+lg8SRfHbSlGfG4q+jhgeo8NKN
	GGnhHLrTyfbFHNNJQDVjTT3JE+UmqdIkbURvByc3+/f8r/wb+Ma/aWorxrN95Z9xq/yxvPZo4k/
	D8w9YpiuuP225XNBIbcZaC51SF/j4M9B+XMg18BCeuFDHdBCMeVYdI22MgAlZvX3yo00u21gCqG
	OEvTfKJZjmMnVbe86Dn7//ktUbe1F1Or/jHGVwLKNrp5r9/3gvqQUisdVF6X9cwmpvmvXt4Cqj7
	wS3geJxpi9C2+dPmjBUp1JHAn+3iwif0AYqIucHAIKZbNIYO9y6qelA0G2OiB3RUlWOnl6UY+AS
	n4/KDy+hrVUEe7rD3B
X-Received: by 2002:a05:6870:c081:b0:3c1:68a1:6b10 with SMTP id 586e51a60fabf-417b906a337mr500730fac.6.1773347393782;
        Thu, 12 Mar 2026 13:29:53 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm6399918fac.16.2026.03.12.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:29:53 -0700 (PDT)
Date: Thu, 12 Mar 2026 15:29:52 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, 
	christian.couder@gmail.com, ps@pks.im
Subject: Re: [PATCH v5 3/3] fast-import: add mode to sign commits with
 invalid signatures
Message-ID: <abMhBABG4OpRsjsh@denethor>
References: <20260311173147.2336432-1-jltobler@gmail.com>
 <20260312192228.481134-1-jltobler@gmail.com>
 <20260312192228.481134-4-jltobler@gmail.com>
 <xmqqqzpodcl4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzpodcl4.fsf@gitster.g>

On 26/03/12 01:20PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > +	case SIGN_SIGN_IF_INVALID:
> > +		if (subject_len > 100)
> > +			warning(_("signing commit with invalid signature for '%.100s...'\n"
> > +				  "  allegedly by %s"), subject, signer);
> > +		else if (subject_len > 0)
> > +			warning(_("signing commit with invalid signature for '%.*s'\n"
> > +				  "  allegedly by %s"), subject_len, subject, signer);
> > +		else
> > +			warning(_("signing commit with invalid signature\n"
> > +				  "  allegedly by %s"), signer);
> 
> A very minor point, but my reading hiccuped around these messages,
> sounding as if we are adding an invalid signature to the commit.
> 
> Perhaps "replacing an invalid signature for commit" or "re-signing
> commit that has an invalid signature" or along that lines would
> reduce the chance of confusion?

Ya, maybe "replacing invalid signature for commit ..." would be better.
I know Patrick is suggesting we consider getting rid of these warning
messages altogether in a followup series. For now though, I'll update it
in the next version.

Thanks,
-Justin
