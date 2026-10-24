Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792867045;
	b=LTnzKnVlPGxXuCl5xhbNQYpak6fTzlBTZFSLeqIJljhl1cBdTZbollxMvXeIhYmG/F4v
	 doQNrRT/5/NOBkANBrcBJhr3PFH2H+M4chLzjYh0sUWbtK19KMh0p/OjUeNCxw9/Jn+X/
	 tJ/TFjByrndHdsLZBD61mR6Oi6IQ79yoLaaDzlnG7zhJIAIN6rIYOrbqfh29ROFR1hPHF
	 zH+Rnnz1SaNpTkABPr4MXfVS8uRLqpGzzPKPz0Me9ca85CJxF4lyLksLCu7VLmeGFpMqV
	 Wh36t+1JSlJPwyjYE5vvRy894Cmb6xRp4kWd10bjdT1rCqGofWa0UyIc7ar8qthjRPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792867045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=X41OHEGU3nCWF7/2AqkosxT4JJp3uvr/t1r149jdGYw=;
	b=GvsyJTqCrSMF7/dfpoGoyOESpUPmxJ8qWOAdz9NPNyG1BFzzalvuTaehrP+ajhvwWfFw
	 8i2day2mSYndNDfQ36+e+xJvazo4r4G614+qKisWZVpOM9ndT93YGDglGMGrPbpgbeCVM
	 /SSsCG8yF/wutH3XVwuEpplgMzwTOUfL6F2TmMvFvLBG1P78XjKqYfQ0kggYVUg+MEB5a
	 NyCqNj0vJyudEIcxaG9s/WCz7P7bhU67mJBrAkiEIqe1ACr3k1aeESpoXgtWe9bXaSd7h
	 T4tTMVcEPKV9DMkatY2VHCLPxJ257Zprr4owQd5rnF+cgSdb9mj28pDh2nMJ4/kV1Qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FIav7nO3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E18606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 18:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5E18606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FIav7nO3
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0d63f60bcso12996557b3.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 11:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792867044; cv=none;
        d=google.com; s=arc-20260327;
        b=SD94+IzM0mCtfh1Es6VVmkX0FHNj3abXjBxHr6YDWVNBrOAEvIosGau1puNrMI/2iw
         OyuldNvBoaHaeoIGbWtpWGjPRg1Or+S+skxwdkg7JSp3ojyTog2RwtoxczprpIdiIREF
         zhtSJ727xaD1iX0gg8JRooX+/iMejnYyePu4n+dxA691QjywB0lbhATgfNHi28hoeaEk
         F+c4Wmz4lz96OR5opyJocG7Zzw/Ryodn0ZiME468pDkYs/xg+ccLgg6oF4Mg3w3ym1Lp
         6tfuhziQo5xINJQccYza5jobMxbSpOz0Q5ETB2EEQwImErtZDBYTx2sdQc4eSzjscRjb
         KXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X41OHEGU3nCWF7/2AqkosxT4JJp3uvr/t1r149jdGYw=;
        fh=O8MtMTVCeveTBFaajeZlEnC8R1E2MSMVISXrSrhjTvY=;
        b=qpRsY8KrJDneuRJHZmnQFfe6+7mt+aQQjQvxNnJlVdb2GBnP/YxSe5RVksv1VctdnD
         1tzB2DViabOVqIzGTEWqnB80CqzqOnxDvyaFmnicaiKLtge1wKKhQSGArKXdbuMlOG4n
         khRxhpIGna0qFnbbH6kctIu8q/UxchZ6ZNbWilfZsr7cF0bAA2vuGfjukoYIZnkcZVAm
         KT4MKiI5DVCDLyBBwlV0Yx+6QIoGrWQKKbUj75eDi4KFVHvgbsJ725gQQnUEtgQmoVEY
         Pz1mMV9TKT1jwBTCfuWXumB8KludajfcW3G70GV3QCrby4zBawr+ZlaUMoectBBUT0G3
         tXJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792867044; x=1793471844; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X41OHEGU3nCWF7/2AqkosxT4JJp3uvr/t1r149jdGYw=;
        b=FIav7nO3BpIBsGq6PhWXv6Mxy8LGSDDESXg5D6UBEgCN2/vgfj1rn+XR0XL24HUSpt
         8bCDYGCZF0OaBSfc0SeHjPEpUNy/f4kDG4Rz//ENBrSXAcJjd8RLakz7zOJMdzMURivU
         V9gLeD3zhw7hQzNOBRYEXm4mheTqk8j0vXIwmaOsevcGThNxL7l/UMqbEl6KDrJKetGj
         5qnnQsHIHZFWITY3Iu6EP+zvx62ct+FulhneYUgXwxB3IMnUdH+/d99UTIRnM//nQRZD
         A+ZSLlqP78/spjTBx0lXmQllP53PUf8hyAGKChAiLFUCwk/cTVh6qeARwRprVSRFfajD
         ZR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792867044; x=1793471844;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X41OHEGU3nCWF7/2AqkosxT4JJp3uvr/t1r149jdGYw=;
        b=Z5qsjy1i7WvjVVpK+M8SER6LR3EiiLjFR444McAfLXKJ4O8KKzmAmLpkxMn1bdY/So
         GB2bUayAZCc4m9a4bZr7lWoYR7VS3ZF2LlNb6W/gTyomH8CDC45W2UmbUf+0yFRMzIko
         q4ghxe1+vm0390eks8HhLm5cnGY1LHdv31s6ryA6/mLRdz+NSiiTuuSe8SHPbHfjC5nN
         //VUF7P4vhYXGdyPqVhqK8b7txJ79EIV+DpsR/jEisDKrDC/mda0TYSPA+49HNt5DHyJ
         3S/BWpTKplnbMscNnwUb4UmcMojpjy6E/z7KIHlpcPPwRLYTQ3TAHCUX+QslgznPCgSb
         GJ4A==
X-Forwarded-Encrypted: i=1; AKwUvBx95mdQ5uX0/rf2Ld7nNq3yO3896ssOxBC5VUzXRmEzfJoEj545zYEnNgA7pr/gcVyvtdc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvjllm16ehMrC/tKWF80O40bn2Bm/YBv7fcVsWtQj5zs6fjbLt
	7YL+UJ/BxwD6I5jWnWAXN+3YXO/N+KJXQzT4DBWzUF8J4rCeVX/wJFWu/FzjnT1UuvZSOoyKDrT
	Ho4v5GMZyS4swfnq/b1xQQvVWcOyBSA==
X-Gm-Gg: AYBFou3Vx1SuUUkfv1ZOF4e61UEgPhhBWxoay9DOm/1QG8tDzoUNXCtCSvrRAusTvWW
	h2crQjhYeSJlaI2XM+7VOx+hH8ekXCtG64KjGN9WG1SrfNibaw/hL6E8vWfNePyoqPPuzVMFbzv
	wrlKu/9aPd8qywsWV/4JeskWvPkx/uExsSbBpky+iG4lBKqha4ZE5ipLW4AIJuV9ZmyrNF1XUZT
	FjbITvkVfNdqMfnUiR2Auf1eavSVE/1usmMDMu1AKK3krcEsm+CYjeBnCmWN/8zKndddLU86Jlg
	kCjWxRlh5IdXHON7+yYfWNrPGyiniSLPXXs1DpQEXMIdv7X6PnLq0B6q6S8QjJ4CuI2MwJtE0CX
	KHgmZJ25AgJNawKQt5WUK0wqI0//ArO/w
X-Received: by 2002:a05:690e:4842:b0:679:ba28:1263 with SMTP id
 956f58d0204a3-67a45488627mr1728569d50.88.1792867043858; Sat, 24 Oct 2026
 11:37:23 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CACWAS-X4BqnMa8iJKTakF5E=zYkkyr=qsQ-=c3bxoAJ+Kpcfiw@mail.gmail.com>
 <CAHwyqnXEC7cFijGWATqfA+fBcn09UoNPBDA17GYEY4P8mS0fWA@mail.gmail.com> <bd00b525-6e05-4c17-91ef-3d9c80ff2784@gmail.com>
In-Reply-To: <bd00b525-6e05-4c17-91ef-3d9c80ff2784@gmail.com>
From: Fien Dora <fiendora5@gmail.com>
Date: Sat, 24 Oct 2026 19:37:12 +0100
X-Gm-Features: AclHuK_atlSg5K8kuNwJ_hCVT98URuTAPuMFW41xQ3X9aJQEgdB_00FenXr5j0A
Message-ID: <CACWAS-U6OUMcmhLK_aRTc8jt1DXk6eNAs9xz1xmmHDM8L_73Uw@mail.gmail.com>
Subject: Re: [Outreachy] Question about check-ref-format test coverage
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

> It sounds like a useful project to me, it is small and self contained
> and improves our codebase.

>> Our commands allow "--no-xyz" to override "--xyz" which is useful
>> when
>> an alias includes "--xyz" and you want to use the alias without that
>> option. The second command above exits 1 because "foo" is a one-level
>> ref and we've passed "--no-allow-onelevel" which overrides the earlier
>> "--allow-onelevel"

Thank you for the feedback and for clarifying how the options override
each other.

I'll work on adding the tests and share the patch for review.
