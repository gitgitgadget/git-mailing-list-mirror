Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82362336EF8
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180820; cv=none; b=MYVkMKI/LfgLNbBfACt4CDDBKMYDyFL6KrSgsMohAXoegYV7sOnyBimas8iVjMmIjNxHKnJRccD9N5MLMN+1vMsofFkP6lIRdWmATOfnp2bPD1d/Wp+Ir7AQs8ZTvVcn4apeAg47sld87UzYODweOHDcuSVgr+sQiPel1G90D18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180820; c=relaxed/simple;
	bh=O6+jGfobTivruWVGsgEGHEBUSIt+OrD8Y3JxlGbvwdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPNrbT7etzy09daW75CbzKqNvO0VcG+j01tjjZ8OqzzUEXS1Pj5mcDLzuSGOR9vA5QabhaSZ0CCW0R9bnAUX0gAt89Z0dxC5htJC4mccaKCzltVebfvvbOLb7WZGzpVWVYam2O0O3Qh6M5GCa+pvBW1zzRk1H1JTh8P7eBE5+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeAGqAaD; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeAGqAaD"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d74a59262fso2625757a34.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773180818; x=1773785618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wR7rD/zgate4yKShfnnQ5iik+J1XQyIP6CXjqhDsPYM=;
        b=MeAGqAaDcD8rhM2XBKQm9pgwEPf1gceu9MtIXanL3JtvX8JLRvUPCrJhs1avzsPr5P
         5obPuwKQ0WkVm5rdb27u42uKd0sIEXAz2g+S/UGvC+Pr6xnD7/E1W8bdfEpQI7Ic1NuT
         LHD903R/M8Lhodf0DLzZV7asUe+VLA7iNylS+HU0TgMOFZuIWFjxyc47V0HkSC30PI1b
         VFmpQX9SxKQE8h74Wld02nQU+dnqMhI5TcrtAoOoHh3S1/dnOyzB61htQMBveqzhUnf4
         7r+nymJ72FFejWRHbyh+rvmiOKRtF8lUy9Ft6h0ptq0dhsfpx4Kbc4uNKkSDDOljHAHc
         8EIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773180818; x=1773785618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wR7rD/zgate4yKShfnnQ5iik+J1XQyIP6CXjqhDsPYM=;
        b=iP17sy+jdUY53hB/Qg9vcHcqW342A07a05BuuPYZmaCOB0XySdVSc8XMWMp31pGKge
         7M7BMteVD6B13lIqQ7e69im1m7GE08Y+mSOhzS+4pW9rs++KLsL7J4EAXdWkLoWNBlJ6
         wSQZ+hkmYjCq+ofJo2A2PwTfb7VhJz1ZNbOiUWl2vWe7k9n3ac3HWzs7DmzW/VP2f0w7
         7yjMMqjrGoSVRtQ/309REXT2n3tkaqTiFBS+WhDHeBZNhjjntt8sOPrCsvX+gUtdxi/G
         4D3btqnJTCX0caFZmVb8hc6S18pQwCHYAvLpJPR0O/02m/HsanNcC3FroOQve3ukSswb
         UOBg==
X-Gm-Message-State: AOJu0Yw179YxOFB79BJzYZ26YzPf+7wGczfZysb5FrWKhg2rwLrFu8Q6
	PsFNOer8Li+d9y9zCnYUBrHxZ14T7/4jQrBkcfJ89efELBXFZwNNBFaA
X-Gm-Gg: ATEYQzxbapeMycRS7uq7K5zye+8nWYP9NBk2dNkYMcnwFvn5LLXCScYBwPbWEbyfxCG
	QPhRMkzkjJLAiaBzZCjZaejLuOFerY884JqTjUME1vRgaXbjjSOEJ1Wu6+HqAsl50j9BPkKPiBH
	KBOW0Gwkw7RfiFdWzhNta7p2c/BY1YxMpyUkADvfkafaN1PXs2B3oZ7JzwH+49wOWpCbm4uMBwz
	OR7h4pD2zScuEKLseEY3mO4Vypn5GDJe4sWxHipgpPnoqw8zliEiRrV+6RmjXYJLnN7RfTHhDq+
	OLKq4NGJQJ4hh611F9rU5f31iralhsfxL8As0HhEVZMqeUsnkUxzCrLn0hC3S5tgLEyKk1qT4al
	GFPqiwnLhcZ1Aqwg/JmHES8dtRl2831KxVpIiUzVQhaw70vkvuGRx5Eo3GGZTnF0aXBOrrKCXUt
	9YZUU+cHFHB7IHyr+6
X-Received: by 2002:a05:6830:2589:b0:7d7:5d69:819d with SMTP id 46e09a7af769-7d76a81cd60mr373627a34.34.1773180818248;
        Tue, 10 Mar 2026 15:13:38 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aec4c8bsm268967a34.25.2026.03.10.15.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 15:13:37 -0700 (PDT)
Date: Tue, 10 Mar 2026 17:13:34 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, 
	christian.couder@gmail.com, ps@pks.im
Subject: Re: [PATCH v3 0/3] fast-import: add mode to re-sign invalid commit
 signatures
Message-ID: <abCTTaYCQIub_xjW@denethor>
References: <20260306205359.1723254-1-jltobler@gmail.com>
 <20260310201116.1130160-1-jltobler@gmail.com>
 <xmqqv7f3s93l.fsf@gitster.g>
 <abCFKEHxu7OZr9bm@denethor>
 <xmqqqzprs7o3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzprs7o3.fsf@gitster.g>

On 26/03/10 02:20PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > From my perspective, "re-sign" implies that the signature was previously
> > signed, but we are now going to sign it again. Indeed, the resulting
> > commit signing is functionally the same as if the object never had a
> > previous signature though. Also, "if-invalid" already implies that the
> > object is signed, but its signature is invalid. So it could be argued
> > that "re-sign" is already redundant.
> 
> Yup.  if-invalid part indeed was why I thought "re-" was redundant.
> 
> Also, if a project is redoing its history with such a bulk
> operation, I wonder if it _still_ makes sense to tie this re-signing
> to the --signed-{tags,commits} option.  Adding signature to commits
> that were not signed is not covered well with the
> "--signed-commits=<mode>" option.

Ya, the --signed-{tags,commits} option is really only intended to
specify how already signed objects should be handled. Adding a mode to
sign unsigned objects likely wouldn't fit well. I do think this
"re-signing" mode still makes sense though since it is limited to
the subset of objects that were previously signed and the signature
invalid.

> A project may have required that all commits and tags to be signed,
> in which case "--signed-*=sign-if-invalid" would create a new
> history with everything freshly signed, but if the original history
> has signed and unsigned commits, and if they want to sign all the
> objects while rewriting their history, they may find it more handy
> if we let them do --signed-commits=strip-if-invalid --sign-commits
> i.e., drop the invalid ones and make sure all commits are signed.

This certainly seems like a reasonable use case, but if we want to
support leaving previously unsigned objects unsigned too,
`--signed-commits=strip-if-invalid --signed-commits` wouldn't be
granular enough. My thinking is that users may want such targeted object
re-signing when bulk rewriting history via tools such as
git-filter-repo. I do think that it could make sense to still add a
separate `--signed-commits` option in the future though that targets the
remaining unsigned objects.

Thanks,
-Justin
