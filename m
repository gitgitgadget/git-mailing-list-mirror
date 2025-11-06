Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762E21CC58
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426544; cv=none; b=DoTAUomcXZisJJ09s4j3jCFwjmJqLPjI7i/j5wpNr75/Lvh5gpayVKvAPELsxE+by8P0y8OKk201N3tLn8eaWSEVRlvqp1xyyRx75Wkuhm+DbAjhEV1hNvXrHMqfsQxJkadiadOZt6ijyuzWKDWexY1aokEFTWxri01DXks1ao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426544; c=relaxed/simple;
	bh=k/dJayh10Ihm+JmcpwPRHOI2HWH6QpHiQ1SooVfx8fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNUoHNJmIzz5lpCRM9sr+H50NoYsL2Y+mDAosFyV5jPjDVZGfplsffyd30XGwPgnBEbUCvT+EFd0zxhY5m6UpXzpe21hopi4PEC1XwLx73xv5MKlvYbzTfq6i0hRLbJi86fifZTI6br808yQz3HrIVz9fgVgYW22skyD7A3wLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAXT37VR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAXT37VR"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so133605466b.3
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 02:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762426541; x=1763031341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :reply-to:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5KAOdimHGS9QIcOb0yM0+pJi12d2QA1FdZIjogypBgU=;
        b=DAXT37VRVcS09oX5qZNEMQ5PpSyp4UYP7ekxarXpN8sQwc8sG0MJ+A3ngqzayvevQ2
         184DKz0/l38xpW4LpN04VN8FlkuFc6vrz5iALDbM9er0tHzpoUHOkpVLi4qwfdw3Ltpx
         Wp6K3AZgE3aFFgn4zGhpkSka0VDfoP59nBWZfSI0DgKOM87P2SYniYtGHA83gvr1QhIC
         /AP9Y+7t1DXksbRkORjcxUbgZH383+6M8fIWDxAHw3ss1L49c0PL4lC/O+YyXEwr7/zj
         Q4Ll5EIyvGOpkpQ8ZI1uKVW6XLSn7kPBwL+zZHbgww3+c4ytZu0v66cR8iWHV565UE8i
         rgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426541; x=1763031341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :reply-to:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KAOdimHGS9QIcOb0yM0+pJi12d2QA1FdZIjogypBgU=;
        b=NgBo8js71yI/W1Qx32XitygxfvfWCmVpBHHPuth+hBRr4Lwg8GnD6B4+DH3Bw6HoJ4
         U2Kq2LbWNAlZ30C4RoW9O1g2TnOW8UFQJDRroRsKTAvejiEHOVhztoysGlKsxSwsgtUS
         bcZ5BiOxrzF7Vdw5cc6Y1L/Q9OlTc79eZ/qz7NTEUMsK7ulgqVGXFgkigw7Riv304F4X
         SWwp56ROJ1oxQHhPXvJo+OWmYLqZ9V2+Ozlp5Pc0D9ptNhaRNEeuHlZOyD+52BoZBgHN
         E2ES/kcBCM490ozFXP8pPXA4gKLhWhTBlrvYz1LwRdZTSdHRrVkpqvM314zv183lOA53
         VjDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO2xYUkWU4eg6bwRY9+E9r3HxWhnWm+H0ZHWvitdP/Uu7j5oe5pSQuoAOklUeYGVz6yDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjihZEVVZKIAqndPvs6aJu7Sxl4hmHdkxzO0JdoPkkH037LQYS
	NgmWYuJtAGKdQ2GH0nXGcpnjO0cTECICscIIOB70Sm7pEQmAsHd+vb+4
X-Gm-Gg: ASbGncuJyCY6nlI2Rt1xYf2F/I09YP4o2zeU3CR0vWyqdgKKcDYOTsS3i7ATNlXa8Kh
	GIyIM6kkLSgO2qOkN2NcPPN0+S9C0qzAJO3ChCxQ723p0I0CCOWT/1chM6UYn/e9fi9fu6MPRxs
	Gjoh15FvDjaUYetsl04DdC1ajH5Zb2kjrtq2EebqhrBxOMqbNHDdEL5cvXPg4Z5et6QXAvP8Vq8
	KwST4Cy8yaj3USLuR/ls6z018PT264N2eXRH7k/bVIDYXTl9fdiAUHC8Va9phSUwuj0fizZNX4M
	xA34+zNsmQetwk9ohNLRZS1T4W2IN38h8+LcCcD1f1/yexs5mo5Bt923+PVAEwCgVjLatbsaW6N
	0IuxPLqQ6VgnCd+/Th4IIrUbYuW4ySr5I4AWsUBiATSM4UiIWnm4qS8PLh2vDFyilHSjWACbf2b
	BcbxGFvf1K5OV2z/30iuvBqlD+Pl6am6jLchosNAysC+19e69aPfC76eLcXSyk1Ud89w==
X-Google-Smtp-Source: AGHT+IEQ5tFzBi77pjkqjDU7hllUCVSQca4mo4IWCq9ukXWRf3JLf6b/1rL5DNrX/4/I7xq3diP5oA==
X-Received: by 2002:a17:906:1f4d:b0:b72:7c52:8e9c with SMTP id a640c23a62f3a-b727c5291efmr367341966b.65.1762426541285;
        Thu, 06 Nov 2025 02:55:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:7b5:6701:5a25:209b:be41:f23f? ([2a0a:ef40:7b5:6701:5a25:209b:be41:f23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896837fesm182333666b.62.2025.11.06.02.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:55:40 -0800 (PST)
Message-ID: <3f7bbb5e-0d67-4ef2-82fb-e0b00683c178@gmail.com>
Date: Thu, 6 Nov 2025 10:55:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 03/10] xdiff: make xrecord_t.ptr a uint8_t instead of
 char
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
 <46bc1b3e25885fbd324a6428ee7ac3b5d272c4ce.1761776388.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <46bc1b3e25885fbd324a6428ee7ac3b5d272c4ce.1761776388.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2025 22:19, Ezekiel Newren via GitGitGadget wrote:
> @@ -156,8 +156,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
>   				goto abort;
>   			crec = &xdf->recs[xdf->nrec++];
> -			crec->ptr = prev;
> -			crec->size = (long) (cur - prev);
> +			crec->ptr = (uint8_t const *)prev;
> +			crec->size =(long) ( cur - prev);

The changes to crec->size here look unintentional

Thanks

Phillip

