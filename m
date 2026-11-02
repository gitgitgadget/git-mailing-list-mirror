Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793630972;
	b=1I+tKOB2MpCz6f2D9htQqcYIwMSHI/pfcmMYyhNoflbDYpv8N8RixIpgI70FSj9Lbd6f
	 ng1ObsV2QJK6SR/HKsWBQErD4+f4H4CfdzZQWoVN+iXBX3XRKTCcJsRrhsd5+SOanvtt0
	 pM4pPqO5T73c0IkxJzmdU5619w7FJBs0UEGKPwjrs46aK/S4aQKbp2D9u8RNqwFfJ8nHw
	 gRjzyh0Cn3tpEv8+XqvhHEdGE5prMtx9seaXjugXDLtIR9JkuQILkev0/4zpxMT+meHq/
	 6/TrUg/BJMNf9u/OlEDRis6yAGQdhOl5BxVXf6HmmJVNmfGlEWvYiXXeUp3TVCryfXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=qg1zkVw7yj6gzHEKFh6KYx7+PHxcT+InJYEeHeGUJwM=;
	b=f/XasA+VWqpMbNAGlcwdfeZbJTM8Py776pxiM/FlV75LLGwepPpahgkjglpWTC2qLppT
	 a1dUtj3F4h/fZWNawY3n5ZBDKNcRI5PKvCmxWZyrNpJqQcnRhrNp/r2F7zRuCILdmHMnS
	 qc3SPKFr4ZXo5uID8ukJ6A6+WeE3kVw3UyYFM6Ol50JTYYEj1RrDasTmSOAmiuiiHZgtc
	 C/9FKFADH9fko0lFSf9xuxSg5l0DB/+SC7sb5xqba5ktcQvCsdguzKz3t+KkFqg2OwkDk
	 57MJ9YOXCnLvi9QQIBTsDH6nJuLUrpb8BO4CtAawbLYVekgth4KrMhSFA0J/PZPa6Lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lbtjYdC5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4EE606A92B
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A4EE606A92B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lbtjYdC5
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b486e1d02eso4052896a12.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 06:49:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793630971; cv=none;
        d=google.com; s=arc-20260327;
        b=ZXN9vPfxZwgmyqCyEDdowl6XGHMXIMIIX7uREsqF5FyxNntcP0gl/fofYbGU0X8QOe
         09P8vtPtei+vs7/sMULEl+6/aBo1B71BMTkEx+cq/5qIvNe0/WsNmHuOeeHntHojvVxV
         7hEm0xQRTq59tYmA13YrVd8fnzftycI9PRrE8Hddt2YBJFjrJO+ho1wMWfuqxmF/N1Y0
         3fjTCS51Fin5nL6Ca7r1KsuGfImICrxZuVi+nc3z/lqd00wmDW1Rii6mIHTpxR3aQaMi
         7qwIhgRXiwWjgV73905v96eIEQI+Ll6OHhig+p9MMVBVGn+RsSjMlUl7F9v5fSPj++qL
         fF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qg1zkVw7yj6gzHEKFh6KYx7+PHxcT+InJYEeHeGUJwM=;
        fh=kkc5bQlhRKFKSyQao7IvFAOqxS3Rw5E4PrnId05CnZ8=;
        b=SZR63jv5G/dm1SjLtoGUuwxSvUa7/qjHMS8noWbvA5nlDDpdb576QJhzeaCj5pgBcs
         Io7cQWhQ8mvisOv1A+WYN7B4GVsgHqHGpLW817U9oa6Ekd4iHPU0uDoAm8of9jAFSjhk
         ta1P7XPVY3fptVqoBcf4pLd2F6TmuUYfby6cGaITkgMz+9nrl9kqNm7jndaho931s4MU
         fgsn0UzeH2hCtnGzFrT6MGzqIC9lRci//ci/fBaGwNMwUOa5Rr1uESylMa0KJn5KURDR
         R9WP6/NGsV7wUs7qLQBe224fqsamP4lzCRagLpLsGk7Amt+Bd2vUKGbjAcHTkm3XNThl
         +KZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630971; x=1794235771; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qg1zkVw7yj6gzHEKFh6KYx7+PHxcT+InJYEeHeGUJwM=;
        b=lbtjYdC5G3KTe2uzNi/m82NPrOrqnuNNsP/vpDAeo4MjxL3cYwbSJ191mvrXUmnkPS
         NbRBSGVs59zCw+oT8zLOyVAoEFlAbj5AAjOK3Eovi3+sQZOuPs+IYHmKVvYjYKzii0qJ
         8bsVQMsOJEoVFOP5Y+z0zrtfQFFPBrpN5T9FSBJIChWPKN5lIz6935my1mGoul9/+PdD
         dFuj8TUSsczA8BRKpH4wS9RRw3FhDcslkMeXvUUsKhf1iu5g7qvigc9m1pEcv3bAVz+w
         prxkj+e6XOtOCcL7RIuB7tMY4iU6sBKPjdyR2ZIz0Z4fZTQZADDajCoSjHbdBxYpUw4+
         Kusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630971; x=1794235771;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qg1zkVw7yj6gzHEKFh6KYx7+PHxcT+InJYEeHeGUJwM=;
        b=wsGLy/1/pJpkDUGdZXLVbIks2eSp9/nIyNA35QQVil36XR48FGDrC2QEzhG/AzLGf+
         ePxkVZEC1WlBBpQ1zRzGI9qUCL8ENbTBYpsFj0YRujmgBpjbiu54CnD9AvLOYrBWrXYw
         1NhGnm5elFfUtcxF3slcHMC5Mm3qLneqX2f+eEz3OVxzeO18iE0gXPxOokKWS7eNFOF+
         Bmv8/Tv/p+elioh3/YvQE46ajlf7AFYwAgpgNrmxr008dRkLGIHjywqo0/3B7iYKEjjM
         s9ZAzIxSpwrepY+Fp9gdN1ygWeYejlB4Bsa/qreGl+I1P72qxcHzyTxOOW8/2ii+whZB
         iUnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrsNj/5DNpoUmzZdU+ndttvdqRzajbe+3MNYQqDz1G9fVvmdSy+QwsbyJLP1DoZFRQJkg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SnupoDdAVKJuxKg4bRf71VnzQHW7bgK0V3aC5Z2UJrbzTZ0C6
	rl4Aj3EyFkTYpe1RIgCaw1lQVJQDx9lwM7ekfChWdIxQobw/IoaYk36ebEPm6XsLRnFgh+XOdDq
	VUE6UoG9iqchv7JEcoiFZhfINVfCFS+U=
X-Gm-Gg: AYBFou3xNsSbFxXrylQb/aSgyJm/WKykal4ZUa+SAjvfDA4Ok+VL+WMpjHjrd1QCQIx
	2EmRJs/YRhCzdwmC84VlwyDrecfxRdyseZVsxVHQkSKSts6h7lE6aIQe5aoIlCIRv5zynEmcRJ/
	RQR6N2zOYyf7/F0zzej5zZyYpHC5xb+JSMjzYT90QUy9P40gLXfUoF8am5qoy1tmfHWO/AcNIIe
	CESxK574xJwcKpeQlS2AimIecwHuB3pBJ5rIr5Kpu7yUmQlhm4iGuDgyom9SRVHXZgWdbkxwIQu
	AvtPhfQPkYYq4Fzmw2t64yDOCrYmC7Djo0E5d0WrFJlyxgBtVnjuh9WRh9o2NyZve1iHDBnxZ+a
	9tSxAHG7lm1O9rFwo2mtXJw/Pq5arQU19E3x2tA==
X-Received: by 2002:aa7:da56:0:b0:6b4:746a:1dcf with SMTP id
 4fb4d7f45d1cf-6b4d65a997fmr5817720a12.43.1793630970920; Mon, 02 Nov 2026
 06:49:30 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
 <xmqqtslzlhbm.fsf@gitster.g> <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
 <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com> <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
 <auiBFhXI_xiBTPbg@pks.im> <CAHwyqnWXb6AOgK-tXzrZ5-=WYitv9iXv7N1R2JrvPJAXeCYoqg@mail.gmail.com>
 <auiexXLTwEIBF-HG@pks.im>
In-Reply-To: <auiexXLTwEIBF-HG@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 2 Nov 2026 15:48:53 +0100
X-Gm-Features: AclHuK9WvNipls6lrSfyCaCnbsrrCqTBX-BBvg9f4YTyb26y0NuRvUhQVfbSFsM
Message-ID: <CAHwyqnXtejhuPNgRgSuf-TwGcWW4AN6grp4qNkfCZCGxdYx3YQ@mail.gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow clone
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>, 
	git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, GGG <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > > Granted, at times we err too much on the side of polishing the last tiny
> > > nits. But quite often that's also us trying to train newcomers to write
> > > proper commit histories in the first place.
> >
> > Yes, this is a bigger issue than I think we understand.
> >
> > The Pareto principle (80/20) generally holds for things like this, and
> > maybe the last X% of code improvement is not worth the (100-X)% time
> > investment? For sure it's not linearly distributed.
>
> I guess that part of the problem is also that a shallow review that
> focusses on stylistic issues is way easier to do compared to one that
> does a deep dive into the underlying principles. It's simply a time
> tradeoff that reviewers need to do.

It's a vicious dopamine cycle.

I would probably like to see a soft rule / principle in place of no
nitpicking until the idea has been settled. Nitpicking wastes precious
reviewer time, and will often generate a new version, which ends up
biting the reviewer again, and so on.


Harald
