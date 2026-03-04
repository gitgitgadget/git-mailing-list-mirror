Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381E27E049
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652556; cv=pass; b=bGvMysjM+Y45Ktkw/vcpn5Muj/28Ik4NGSe17ysM6N2MJfA6bSDcERQtoDdjnpouTwokmn5Cy+7s4xgQ8wHX0KrIcgqk444rBu9pZ0V6/fuI5pnAiU0WMloOcZbUQRiBN8pj7kfO3nGNPgXScCI0o4Oxsru4riVyiXlcyr4X9vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652556; c=relaxed/simple;
	bh=6CEQ7wSJzi07WC8FBR9/MYPMUHK6kX3tXjrIVJFk1YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onyhM9QL6xvt6qbJgd5eF9TEXolb0RCFLjPBkZWwtCvLByMqFRaT+J6OJ6PyijAN33e6KQvncpoY+b08ccXnPsvLq6odmxTV7+GIjWUWo9sD9SYvswK1qFraahcb+ZhSAGWJcVmbD18pxsIUwSsDaZT95BbWbcOmJlL/vODCljY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSbQAPDq; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSbQAPDq"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1177616066b.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 11:29:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772652554; cv=none;
        d=google.com; s=arc-20240605;
        b=iYmEhdLRco8Cij5SMWU63yycka1mQ9EcyybcvCvjcDVgE08FNHhzzjzp3G1Btp33t2
         lvWdK3JZhmHnIF7B3Kw9/99TKfLZmboFzL2dHnbvmkbFeDGdyYSJ8SNk9KL38BRLWqks
         ecBpU9qIBS7RbqbdJ5M2mjTljwlyYkYjPdTZYts4YTy5o/h7oMu6vN/lqFomaXf68rxp
         oE7A7Cuyt8rMgEPl4gEB9Hz0LdIFHatICdnLngze7lubEA07aMl/joVVh1rx4M6WvSzn
         +U6Pbwsl32p0/8XvpPdWmV3VA+2ftrssJudl1lq97in1FH6mJYoebPqp+gAgbEUv280G
         9I0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6CEQ7wSJzi07WC8FBR9/MYPMUHK6kX3tXjrIVJFk1YU=;
        fh=MFckpOvGf70LMa5wdnoSzL9m5xVfgowxEM1cWxDZbJA=;
        b=QgU8+8eNgrn5EQGJmVQU0/qy+mLZr6cp0jMO+uBZVw+1WctS+09+TFe8RaSwtAagSM
         RFlGe90BSbqofRI8/16TCosd9haJ5ZXjII94yISRGUpWQmwOjQw14O82HKMKjjousPwe
         +N25pTXjLnZCXfTCxY5jiidcqbus6ZHW0W5kK2SfHgmu4V5RIkKZmULCxsskOLf+dpV/
         L/IEYO2pECeoeK5QmtQE1Sgp/IEGw2t1pVVR+4WosPzvhNcW6NlffVc3oVBK5A5Gjx/T
         fGhEgtFsAB/Y7KW2UhUEkLJSEpFidecUsu4z/NyBAjjSrtj57UDhAVexECFeGTPbCqVP
         WQ8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772652554; x=1773257354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6CEQ7wSJzi07WC8FBR9/MYPMUHK6kX3tXjrIVJFk1YU=;
        b=hSbQAPDqTr3d5hyUE38Ea6gbRmQRHbCEZ/otlcxBsNL7ljlKFxxHK4kaOcs1VenkWf
         wFCailhatHXGqzJXhNP8jUJJ4B2nLazFdIa5ZT08t0l3IlPG6rnZjUrkEqDGy2CQKoZM
         jlE6wkhlP2meCU/PKNmi2zRNtuPdtxAl/EPeZDrA0q2s+8oMmeiCn7VwoXnaeviZ7yWz
         MRmshCc6xdbE92xou4hZoleLblkUcDVxYg9+ivzq7BO3kymG2z0W4JCG+ftI5pHCGKm/
         +q08YoxODCXjI98OyRzDlqTnBOGKRHmKqyAikIFnJ0y62DRKIZEg7NHw7TqLT07Au+J6
         +rBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652554; x=1773257354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CEQ7wSJzi07WC8FBR9/MYPMUHK6kX3tXjrIVJFk1YU=;
        b=Ogt8fNMyLISkb8ONLwTn+HDFlFTQEx3xG07JPi/668jy17weI+ycJfZt+bhPz7Q5Zq
         csO/8mb1CIAi5YkKbR1sQK+OtvGqHVV7n34g5dzu1l/O/8yzaZ2u+gjIVkyVq1YOd6Yb
         fA9108l9l2fH5rctpbbVr6Xcp3KByb17iSFhyZEmYBc4pYagKLsYso+I0lLcylVxc54B
         8CIthLiTsXlgSYAjH5AURE5G308Q6wQer5bhA0PW56XIcs7Mzl6MOJmdDy+zocevPm0F
         UF4qYw6Nt27qgHDtDB3gtBNsXOqhW+O+rQu7OHoYl7LzlT9KWZOZCFFBxAFmnas+RdaJ
         /JaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXhS3hMGPwsvE9Rp7I4RBtHRSw+/kCWfnEi+2XLcXcXpQuJUcWXTEmZlCnvM9Xz0Uimow=@vger.kernel.org
X-Gm-Message-State: AOJu0YylZwVXcAcMGZ1aqA7fl0U1IE8e8mn6PaHWeuT8K9G9vlhf8bwb
	Z0pfmwT59ggM+u0nc4EewjT1QhN/sB1YK8+E/z5EpjQD9xjMi6EfWqqaJwKDpdbq48JSR5AtrIl
	QGCQmRQnuDURskg25F7uLYeYbCClkZe8=
X-Gm-Gg: ATEYQzwMnwH+QKwbDqqR/8g2GyanOJgr7HGRhwwu+FP3c84vLfHVt3TRe4CNU4WDHFr
	WRhdagTrWztRt04Cl0iQZaGYQr9+vIQSc0MwC1z0BPCYz4aR29x2avROKFSf8qaRUAsdxucWQ2j
	iFt1d9SdPBKwF+0lXt20NedNxQt7Cb0G/rypWKqUu8K9lAHwf4qvHiKEcs+JGHItpE0LK9osaZK
	+2F2fy5aE1vEiKwzcv2Y/aYrQTH6mRarZ2U3J9roXXIxVL6v8u7Dx44gr+J22XsE7aXxeDjnxCj
	1Ma2FS3YUGI4egyqDY2cUaWCB8QiFafeDWk0X4h8Ap9trA==
X-Received: by 2002:a17:907:3f87:b0:b93:81e7:8457 with SMTP id
 a640c23a62f3a-b93f11eb601mr211917666b.1.1772652553636; Wed, 04 Mar 2026
 11:29:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227234213.17633-1-kuforiji98@gmail.com> <20260302200018.75731-1-kuforiji98@gmail.com>
 <20260302200018.75731-4-kuforiji98@gmail.com> <xmqq7brtyids.fsf@gitster.g>
 <aafX6qva_badx_RM@pks.im> <xmqqjyvra9xg.fsf@gitster.g>
In-Reply-To: <xmqqjyvra9xg.fsf@gitster.g>
From: Seyi Kuforiji <kuforiji98@gmail.com>
Date: Wed, 4 Mar 2026 20:29:01 +0100
X-Gm-Features: AaiRm50baHT1XOBuuSC8oQY9XIl659B6l6h5-ejPewtFp9a2K9Ak4u8yCTjgDS0
Message-ID: <CAGedMte09S1FE2nX5SnamzqZyMGfme-kL0skZ+e+st-b2HbQMA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] list-objects-filter: use oidmap_clear_with_free()
 for cleanup
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 16:31, Junio C Hamano <gitster@pobox.com> wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > Agreed. But I think with the current status quo I'd rather drop this
> > patch though as it may otherwise make the reader scratch their head why
> > we do the exercise in the first place.
>
> I do not think too strongly either way myself, but you may be right.
>
> Unless we are dropping the "we optionally let you free the shell"
> traditional interface, it is of questionable value to use the new
> interface.
>
> Thanks.
>

Hello

Thank you so much for the reviews.

I'll send a new version dropping the [PATCH 3/5].

Thanks,
Seyi
