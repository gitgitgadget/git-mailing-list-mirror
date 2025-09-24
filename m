Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B941FECB0
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721704; cv=none; b=L++sTA96eM/7tH8cdQ/sMKpwBwNEISr2WFxnVHN2toWrLfuPLUyB8oTomNZ3FLoSfZyfv6SB3mrhEEojtSbUTLJ09kyCbjd2dG1B2Z3OMdDzEiMKGpOFBR0hNUkI/vQArgXlsKC5GZSm5DfCBxYRUwngLlTjOLfmDDq+YNn+JFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721704; c=relaxed/simple;
	bh=BYGy2SB5kPH3PSEg2B4v+NQt5rFIleAF3fxF7EbhhBM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VVvAjuVwMccd41Dd13R76MkY/pgpi4WCVrDZDNEwyirg3q2Hv+aKjYWVhFLWYwHsoFWGkeM3BqePm5pP/ccbn7rrowG54p03tcU1oUZcthmRbJC66m3ecrrRC3N2TZo2L6WjYZCQqzQJqmjUmHZa2XKGQ58OYTFXPTUwsgB04Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXqKUzOW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXqKUzOW"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3eebc513678so4812423f8f.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758721701; x=1759326501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wlx75n39fphLra3Yj3R+3dLQ+eSHXfGnPEtFl+8HyY=;
        b=kXqKUzOWTmWWgYZdCZslwsU+NPsXe7lndCcaOb0RFFvqXqc9Fm5osFrjL2nwloXno+
         5VSI7ZBx3l4v+W/9U57y7x07YCgKMAHddW+FfS2ejl08Ot29K1bpp1CLwbQ4sWs9wBd2
         HSCUI2tYzsc/TE7aEYB7mFQs4be7oKFCgyZ6JmK5Rijq9UEzIyEvG1N4zeBktxZ2wyyF
         5UHXnVxKcYafVLPh1b7NeD3x7Vh0YFgzXS070Y4TAVN5kYHRcYi3qzDMOvLdiFuaZZjS
         9utn65Q4TtXwIyIvNLroN7opiVomhKfqn/bS9hunbo/ctEVCi1CU30DnYf+RZHhv1QDq
         Vytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758721701; x=1759326501;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wlx75n39fphLra3Yj3R+3dLQ+eSHXfGnPEtFl+8HyY=;
        b=QrqDSksfUxVw96IoIvKUWiCA8pynVBgyzazIlDd5fmyQRsfe0MhablJEBzm2H4QPva
         6Cp81Y0JmuTpOiSYhiYCZue67RtWe/+ENN/n3zL6drcs1WphJ0GLVIovpQtP4Onv5yi1
         sECvyZGqQE8VlrLrlNwfm6PLibPjRZkSyklfUdJ0EQEjFSSxfXkJvT2Wu44Ow9AbdrWj
         kJtlKvLk0rXGnpJrINw/U9Uao7hbVol4OXR2MA1Fl1EreJ0dSMyXClmf2Nk6RGFT1OlZ
         ndm4JREMXuk4TTtDflK0r373YB3gPNOhqq33ODh3Imcfg8hRrOStjDOCG/6AINJyTWH7
         o86A==
X-Gm-Message-State: AOJu0YwK7uVapf/2ulQvuWBD5kwXxPdncqOQS9czOsYuzDZLLPxGkFs6
	pHMgYLcaGCilCODCBIZpNyzkV6m0dn7f+UHqJy7nRDR6tc708oSrL6VC
X-Gm-Gg: ASbGncvymfeqg3+nH61eEJ5qFGmQrSPyKenMVmYrvkrr/Gnxp7CkI/JOkLdbTLEacxv
	kL3rQIywPo7jFUYajhVX7VZ1hnG9aTIBXDNQwa6QE0BpQwLx2qEmJIl8vfH6j0/yUZtTCBz7wgG
	Zfmid8xP3ezvQ+2z11zu/aBqHY/nc8u9HSKrZYceWA2tqV7nwRM5LBQgzGD3vxQROvGMfjZVUmX
	HElZgsPqgQ0URX2W7xdXM3FbgxWOAJpwanajyczNUavto/ZFfi+ONw/w+WqJ2ZFk9pCG8GIbazF
	ofwCDVKwtbaXDCatTzmcmwWH32RDUk7gz1mB7AHNx1xKxV/elxtuJ6tCVoPGvx4smkMYDqKi2FU
	murX59qrdBh3O5LA5maKftgGhfMpLcqQyQCIBqvFPhwhfNjKtsYmU2VTyy6fTXA6Gv6RPiGz+fK
	A=
X-Google-Smtp-Source: AGHT+IH6ly5d04IrBHx8cPxW+A7OSFAJbZbHhHwjA0W7qZ1X0quirkDr7VV2JDSUBAKfTtIXuLKezQ==
X-Received: by 2002:a05:6000:144f:b0:3eb:c276:a361 with SMTP id ffacd0b85a97d-40e4d9c8fedmr8774f8f.54.1758721700426;
        Wed, 24 Sep 2025 06:48:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1ce0f87csm38744875e9.0.2025.09.24.06.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 06:48:19 -0700 (PDT)
Message-ID: <467907a8-06a1-4107-863c-4d0dff0dc9f9@gmail.com>
Date: Wed, 24 Sep 2025 14:48:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
 Mathias Rav <m@git.strova.dk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
 <xmqqldm4onma.fsf@gitster.g> <0a14a93e-7da2-43e1-9d71-c58a69c7a4af@kdbg.org>
Content-Language: en-US
In-Reply-To: <0a14a93e-7da2-43e1-9d71-c58a69c7a4af@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 24/09/2025 09:47, Johannes Sixt wrote:
> 
> The common situation where the proposed change is handy isn't where a
> previous commit is fixed up.
> 
> Sometimes, a previous commit is a fixup for a later one, for example, a
> change slipped into in earlier commit that should go into a later commit
> and has been split off into its own commit. Many times it would be
> sufficient to reorder the commits and be done. However, sometimes (and
> not even infrequently), reordering the commits introduces conflicts that
> do not happen if the order remains. Here, we want the proposed feature.

Thanks for explaining that. I had not realized from the commit message 
that an important aspect was keeping the commits in order to avoid 
conflicts.

> Since your argument hinges on the word and meaning of "fixup" (which I
> can buy somewhat), we could extend "squash" with an option that
> specifies which commit supplies the date and authorship metadata.

Or possibly a different option to "fixup" like "--use-author"

Thanks

Phillip

