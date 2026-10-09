Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE04F4728
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571684; cv=pass; b=g9rAMZo7gSW0fndZbPulBlF6UV98BAQNrX4Fv+xtuP/HX+EpijiBsxyT3kFYbYxtkZCW8VxIfLv2T3W7//wp5rTMDMBuU6JTFtCu8if94yDVJSatShlItF/POZfs0asTi6w+lTYP1tZ0rql0oSRYTyhdB36/nREkaa8cuTofSu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571684; c=relaxed/simple;
	bh=pGhGO9vnQpCIUzy2sfkzdzx/5m8d61CtcfS+rRRHDNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+jvsGVDNO+r6pB+NS+cE0UIi8xs0u5AqcSJ+mU1tRINEFSllO8m7NB+aDXqNPKJlUeHQAoaGPzBBwCZulJCrLN+QjNeynYFa5i+fqdqTngkkg0YhJSluBYEW7zaIQTOGkzSHhtp60+Wt3HF2aFp4vW2PLtX5YcQ54TKtL/rJDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtOcNJpf; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtOcNJpf"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a9bd4db6ccso60229a12.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 11:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791571678; cv=none;
        d=google.com; s=arc-20260327;
        b=bG/Lm5RaW2mbbYvDFwmHUU/0qNExFePNpwgZJD12La/MIc3VYih+3Ggg/xxWCk0CAo
         Xy4tYEOwc1oKzF8rykAeDQrgeMCVi8YDRl2QUPgmRKMnCWLVudXSfTNjCwDbUSY0dzKr
         s7I1zdoxawYJSCNVeA/JPSIDjt0kGxka5wMv8ji4cuDaruBz4y2mMHXlBUSK2DAZBbZ6
         jQ5bMnW69G+tsnmhzg4JIYoNz3bneKPFTxKIEfiJRFbF/IWRxrnc0FmuUpY6PfL/z3V/
         Gf/V8wuFgtFJcvllBK8G2qTuoj2/OqH9TjuUUWJcgAxejSPKaYW/eM93+OnprFNuhVOS
         /spA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9ce5+GDR73oJmQ/gD/r2QrXCvUQOxCt7QXXQM8OmJ3w=;
        fh=SrC7A5QswLg9AbKluWDDi2Rn7wAkpYqrHItEoDLuVKQ=;
        b=Vre6dH21bWhksA+kkMozTMOCKo25y59GXeAzaLARCa0zWlZ6+b9EzgxYgMxCMTcRMd
         Hw06hmTJAri/bemM0v9vtz031f0BGHdG5JJXWlnMUFMPGJ24H81pivRamlRi5CkZI65+
         6Xw1Shcl73IFJbtM1BxeqrTfHl7ArGQnO/VCMOgzuSbEdM3DgyygcJK7p1cjkbwRCmEF
         SyezAis6g3XjhBugFVnUd3KXJM+bZT3tLT81jOVN9aQof16rQA/MDXPDt46PhqpU1/SO
         7mh8vFQF72Ig88A4eGC4DMUGSac19tCIWFZp7ZvFKpqP3wHeqvFgDbpU9baowxi48mN4
         jcFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791571678; x=1792176478; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ce5+GDR73oJmQ/gD/r2QrXCvUQOxCt7QXXQM8OmJ3w=;
        b=FtOcNJpfHIlbN1x+0spD2+N1Fl1i5eOpH7LGW6j2oDHqQYiGIrRJEbfziN0ErCpLMq
         r0c1PMX3S511bTIBcZuSIVttf2/rnXl/mRIfFuNIZv0mW2tAl+fx+rgZGdEL2C3Hq5GD
         i03/wOMDAT0x9JQWaaHenJyHXkwoIezI/+4XAJvZ6MAkAzbFGjfSz7jpozwIFVQGNlGR
         l5fWKl99rC7/VQ4jvOV4hXasYq4tdKFJK1F67Bht5iO8URtWrxYxtdfSJu7qVtfIwMWx
         tJpil8TEdojWyz8qA8RvbeWTsz2XMiAp2xQGV5Iy8jJDD6rgYGwyLKcVw60K2iRM3Wqn
         kpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571678; x=1792176478;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9ce5+GDR73oJmQ/gD/r2QrXCvUQOxCt7QXXQM8OmJ3w=;
        b=f+IALSD96qcLLtW0FpPiRRYiQDlzLXNtmkYiYcK6bHQ5pUBudPlii/ej0TG2uMAECI
         N/dcmZrdhVBEq8GeyzfRLhGWSKvGDreeWnlctIH/z7nAQyQekPOQ4Pqnm0E1GjeOLwXT
         6hP+JYJs+5j8gvlplFcwf8cGMN7ZkpjIC9CpfMHRdqMg07l8AbSbFeLDc5XUmVI/4+lr
         nNDD7e/X9MJHLD+2b9WdMRdv4lqKjrzd3spP67gjegasUavZ/y81O6xGtcxTWhFQvUjw
         T2AGmr7HhVEkqiXBBTbZ0idkoxs3Gs3xn4JhFY4kdO40Vn7kKMMv5twEkYpJNmPihXSe
         2TlA==
X-Gm-Message-State: AFq9FYImTADrNyY9+v252lxAgbo1eIbnrwCCGzkBSi16bqYYwJdmcNBR
	gmMIT3JyQQykdi7oKXWJapXnbcN6oV2SM+CkMZJN2ITER3p8XWz1ieoPdJJ9IkGsPb30w0AHD6g
	ZxT9CRqtY9ZeWvowZTntJQigQQLGE57w=
X-Gm-Gg: AYBFou2qcZH3qlFhYXc55h5YYe84I4/wurgPd9N/t7puGtZQ8YcItun7Fxq16av9byU
	5uIbbg4CaRp/ZzNwIOHXPSLUb332k6XrUYTVShD+xstKvUchJHH7yIK9uXvehNlyE4u3+FTxJz6
	A5HxgdE59gqOCeQVm96iIcjxDoKfBNWYHNh7foaiWO/Lu33mhOUh+n/J391rxJjm74leuCVBoFW
	h5mIl6YrYukY8jSIyAdjjzYWW3aeKeuF5oZvqdcZbOghXXd3sgsdavrMDFssvUdItUFo8lgldv1
	Jib2+xr/RIOanRQd3nrIQebLV1RwwTrP2P5wyYgM44UJbWc7X9KqT88=
X-Received: by 2002:a05:6402:1d49:b0:6ac:bd48:b82d with SMTP id
 4fb4d7f45d1cf-6b17c4e9747mr2316266a12.41.1791571678139; Fri, 09 Oct 2026
 11:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009134004.188952-1-gitter.spiros@gmail.com>
In-Reply-To: <20261009134004.188952-1-gitter.spiros@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 9 Oct 2026 20:47:21 +0200
X-Gm-Features: AclHuK90Kv3biRaTFlvZQBa2ry4t2CoUhePgcKsQOBq5BioFTdilBbzTk34QZ1I
Message-ID: <CAHwyqnUgWurC5Q9FjWv11YgMkw0i-j=h=Tvg2oi+bphbDTw9kg@mail.gmail.com>
Subject: Re: [RFC PATCH] status: reword message for a missing upstream branch
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Clone an empty repository, make a commit and run "git status":
>
>     $ git init --bare empty.git
>     $ git clone empty.git work && cd work
>     $ git commit --allow-empty -m initial
>     $ git status
>     On branch master
>     Your branch is based on 'origin/master', but the upstream is gone.
>       (use "git branch --unset-upstream" to fixup)
>
> The upstream is not gone, it was never there: the remote is empty,
> so origin/master has not been created yet.

The idea makes sense to me!


Harald
