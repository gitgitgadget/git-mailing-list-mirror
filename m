Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE94435F5ED
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102407; cv=pass; b=gXl8Xmtb7sz+ypL17+/eq9a35OuaZhQu82S0JzR0kGNqwgip6zf3dlt2AtObSvsrpea/LnkNyC9Tb4gNcqF8JNaOlh4cvSn4PjFLrfAZw+AcaOKPaOs6UDv4M6mOZNlxD43OUx8StAUOjqBDLiv04ESAl7ZIf8p+qdshQ/0AarE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102407; c=relaxed/simple;
	bh=VrsVgelmarIWruCHCEfCh8bJAa93Qq0ja4h45u4HqeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGwLPHzHZng7ziuzl0wadYEXUhM5MufAnJFmbVAZpM4g5lsYgTdA5IOwW8X6HKZAYcNl7NaB6pW0NEpmfVGiqWcpaNywt2ycakaifKrtuOhmSZ8NXmw6PbqiQyOQEg4p21UdiaamE+Z3eHOK6/BR/ckOv/OUfM1wqMLDfai6FSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=KnnW+nxq; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="KnnW+nxq"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81ed2a06b9eso33953707b3.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 04:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786102404; cv=none;
        d=google.com; s=arc-20260327;
        b=Drd/IsCd2s4w42vh0oeJHVMIJxrlS8+Vs+5Sg7PVpkO3YrOQTgEHX9+01joApa8Q3R
         qulRxqhQgnGapkHElrh+dQZGcLvpl7BS65xTItD/p5Elx3q/dciJ8yjUHsIGbR+XX0ah
         Dq/SCHJOsSPPT41QDDzCj660lJaf4+mPpnNc09swTto5yjGJMFjlxzKbne1drmhQFRyo
         Q5nSqOgbgs4VLWoaY6wrrkPY02z3PBmbu7PJqmldBZaodSTIAVtde9jr9xt76ZYH+mzP
         GE06Jgzc6/6Dvq/mcDPASdagIR4OeG+8iSFzxiQ3lfSR2gJcn6AeKX+A7uAJO0DDLOfq
         Td2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VrsVgelmarIWruCHCEfCh8bJAa93Qq0ja4h45u4HqeU=;
        fh=e68/hF5m8mJcOq78Jc58jLoxAGCyl2TEonFF8NqM0uk=;
        b=W2AsKIWiUVb0lBVnr6EupaCdMknWpb6nqlKUDyzejKkB3pJR6dxYWr8/1PLGBGBWQk
         qTQQtvmsiC7quVr9scq5e3+ZazL9BHuJM6kx8YIoZx3o/kt9wJ/ZyUMTeCGa+3MqmbU2
         TBDugph2s49y3bbcxlRlaLL7Z6QrK4AyTNrqlV2PX8Hk8L+NHy+urzf/t0jRHVe/EFMN
         5V+FH8FBThiYcgCIEJ3CtmWFqW5E6syIrpWWZTCe5HdoXZkEI58zfnOgntXhVKZ8Ersq
         dWX8v1Onyc4iF/38ymNs77RXZfIBTAV8RdpBOPi6pBrx1DgfXVr8hvnV6mXnLdpVBQAV
         xSUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1786102404; x=1786707204; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrsVgelmarIWruCHCEfCh8bJAa93Qq0ja4h45u4HqeU=;
        b=KnnW+nxq//mv2FaBszo843aFhVrYfYX0Fmo21pP2OEavsGbegyJWRCuERVNdpS2EBH
         K4V5QM3hW78xPGhzfGHxD7teRkhmG7XK3XSqjtD8wiiwDW2U9dRaJnVCIdFy3oNG6p4Q
         BF23oqGTTfxAp6thO9bqaA+4ZE3xGiuLdWYIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786102404; x=1786707204;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VrsVgelmarIWruCHCEfCh8bJAa93Qq0ja4h45u4HqeU=;
        b=hlR9YB0ZRRBJELB2S9U922jUnYeHc+CZi2cKeq8vIjR1ck9+F7s01S66G2xuHj3Bvv
         Or7x/PoA/VHm8FwQod7OV3rkpJubZDQGFT7YdYfrVhI/GtaO0XGlz4yzzPUDdRDJqGkc
         XGgYpcHVasJf9dil12nUxRzURyPiEUuydfDNGvkfoaIz2fK0fvaa2L+yr6rU8I2M/rG2
         vJ/5fx9lEjgHSFrvcUr6LjGYuIAh5faI4jnI6UtBZFPd0ncpSAoowqdin5urSvGlRqiD
         YWQqC85fMessgBsa7lq9EQ9J+NgUtgKSj+rsthQRwZsVpe6EGRmLsG+pC4Rv1ZXXlcNk
         IIBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7uwkeAJJa/cPFtpVPyBF6tL0M8Wxm8VuI53hE+RL0fYUhs6uVveCYRAO0G4COYk8JKyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2L16c0E592/x1/qXeeyTdT+6HqoqEixyK6u6v+m8j8ewcvtJF
	g0+CmXSpNDNoiCGxd6VkCNyw6FOjKldBKNHoSEjmP/PmrfPQnWY8G+CqJtYN3F9ublP0/x5MMin
	MlADJOiZbtjcqqq8ESj+5W7l+NWyp/VQCtQjCY1KxbsQKduSL2WA6NI3T1Q==
X-Gm-Gg: AR+sD10RnhfV3+/6wopFdykRZZ5eRi6siu683MjZ3hmKYnhf72kWQUT+QOAXA7nORVR
	ahHhIvOx5e7dAfNEUsSMNpR15yTCI8ToORU5Qr02bpWPynN0mTprSCAKzgQj6dfsb9lLJXsLI7P
	8XDfAYG+SnD9i4qw18ZY04GRo8KgjUwEYqme3cmMEGzADRVSsZEKb+7YFP+sLMiKQRoEnvRtXMo
	CJBbVTta1B7WfhMsQN4Z0xm3n+irD3mintD1Fy4FRIy9HOnue+dX0ldFFQqCzXTZbyMxrP6bFdG
	qXaV67+HnFJ2QcRt48hkvTuWNChhPwJrOI1BSYdzvgg=
X-Received: by 2002:a05:690c:6d8c:b0:80b:a6a3:937c with SMTP id
 00721157ae682-8225ba2bad2mr47758807b3.20.1786102404506; Fri, 07 Aug 2026
 04:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <f857577e0cedc11f8db614b4ab2bf9217652a312.1786013982.git.gitgitgadget@gmail.com>
 <CABPp-BEV=u82AV=bXoHN9N+iNOrBjAig=1FY0sxiQNusrNGUbg@mail.gmail.com>
In-Reply-To: <CABPp-BEV=u82AV=bXoHN9N+iNOrBjAig=1FY0sxiQNusrNGUbg@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 7 Aug 2026 13:33:13 +0200
X-Gm-Features: AUfX_mw5sLDqrgY3Dm-rlNhUB65xzUAEQMG-4Vc5Ae5RmQ9wU8zkpaTZm3X3bNA
Message-ID: <CAL71e4OZwDzZaE4kfZTcBy8wtdeX2Y8H8XM9x12qH8TaUkVUnw@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] t6600: add test cases for side-exhaustion edge cases
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 05:01, Elijah Newren <newren@gmail.com> wrote:
>
> As the author of these tests, and as my Signed-off-by attests, I can
> confirm with the full weight of my authority that these tests are
> good.
>
> However, I would be remiss not to note the perfidious destruction of
> my two spaces after each period, cruelly collapsed down to a mere one.
> Have you no decency, sir?
>
> (Kidding, of course -- I mostly point it out so the next reviewer can
> appreciate just how little else changed from the original.)

Oops! The irony here is that I tried to be very careful to not
corrupt your changes and thus the attribution. I was already
somewhat hesitant to even modify the patch to split out the tests
from the code changes.

I added my own helper script to check and correct patch series
and I had snuck in a double-space remover for personal preference
but I think I will actually get rid of that since there is a slight
preference (but not enforced) for double-space in this community.

And since I need to reroll _anyway_, I might as well repair this. :)

Thanks,
Kristofer
