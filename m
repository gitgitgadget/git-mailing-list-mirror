Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A866335839C
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476599; cv=pass; b=Z39aujItEPwsbbSfjoGDS4dzoULNwBZXGZVBuE6vDeU5aLhALYhag+xkP7J3osLqBhhiENKbIMwscq+pZoEqTXEDNuvyyWKdJP6j1ShR1F91XLG4FTaLzYgPBHr8IBXUPbV92WQU00dqHWCfCQk+vkJas5/j/3oPe2WIXlu6l+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476599; c=relaxed/simple;
	bh=gZ9Kz3iDnli85CC/rQO/h1bOUXordg5sof1B7iCX7oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDGwD1NkZcpprUYfjkSNh+Rc5QEo5x3gSC6q6vNMpInP0ki4ONevETdvIfMclzO3v3ervl6qsAKcZ7QiN3IGi3bOjm2eEZslCzBCW8Wlj8eXXLgoi3m2jpPkxrkcTAdQJFojnq8kBTLKrzSffcoa7cXpQrE6ewiTj0znh4NTIOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcA6pxzO; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcA6pxzO"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so224867a34.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 16:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788476597; cv=none;
        d=google.com; s=arc-20260327;
        b=iqePIyvgEe6C2spiYHEMXpZadTUYxc6DgPsPha2Gw7ngI80FLf4UEl1vaxHCVynXHQ
         cINpBzXFLE+PhaIb/5AS9p7hTL+fbQwssx1P5N2YXGrgGAtRRm7k0aqX5Jfm+6p0MoCd
         rFfI/LlUfcPbzEuRFlv0aBCEPguyEdIvHgIitdH2Kd50dfvHwqmyOVF+og4FQUUklkx+
         udRzCVyFRY90rCOFt4H0aprHzkjfYFiifuoPjt02btUtc9FskzbUOQ86tKOKGgwO6yBL
         0DBnIdzkkaK6/kucWrKmTcnHcSdelMHRe3NWhqdTbvaf9U7JLMT0pHrMoMWlLBfk972y
         5U9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oSqmBZbsWUKZusowKrlsW6BdEO/jlsKrok/uvpTzKCw=;
        fh=7tcC/rT4asnTF9kaxyy82X0amnDtj1RYL0UsK2El0aA=;
        b=CEfIcnhXIfJicZFOYWoTg2pMldsBqb2235zlopULr632523NXCIjmFYWisX96UK8Mk
         lWmZuyeI3QuYyKoDHesFS7rsdPOBhVw7T4ud4CZZOU/ndIl19tdmO1cBO9yU5P9PtWir
         ET2HZTPUjTR2V5t+61g/ljvy6oxppn9srBUsKVKQMwIzZ8WaXSZgdp8ehE/fldPqSnDW
         26ZSZOWXlvtdZdrHcivbGhTjUko68OfJ+oebBfPgjt6iiRncjJbNsR2DLORhr5kUdO2e
         FuyKHXpPkGJkdUJHpqlDBrJmt1qJvaCERU4u68qr+5rszyo3R8vEKW8zJHG1zn/BVZnq
         y+zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788476597; x=1789081397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oSqmBZbsWUKZusowKrlsW6BdEO/jlsKrok/uvpTzKCw=;
        b=CcA6pxzOOzH+WORSNdGwgLAPGShgrjm0j9oBXDPNaV0CXCOYkq330AnI+o17oQLnCK
         E66/W9PRAdRT/XIEUvyn5LyXkZOJcMA/kARwK0eFttLIN/KHRYeadQJnoYdFH3cnFYiT
         1OZkNjJQeeNljFoSBxhgItAuri6HfH4i3T8iEwMYMkPsc1r9kEBAxCwR1fMQ1ntfMf67
         3SeqOmPynYKcAogSFaWmtR8j4nOq8ftR9Yz5r3ZEANlJeD8LkT9StV9fh0Kx0GKoEfW4
         czfNhGu0quaFL9ITdnnCvU776JUfTxcvDT7hIeBeIyAKkNxodkJDgoXbXIwCVfGwkD1B
         EUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788476597; x=1789081397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oSqmBZbsWUKZusowKrlsW6BdEO/jlsKrok/uvpTzKCw=;
        b=k8gC5Ak+7q3ixFLLSahjyneQhN2I+XDwHVznbCHpI3f/HVnjQ27h2A8stN5bEbDamv
         AdF5xT11cupkX98LmNne/9Xrj9JnQZPKp/Jz65B9araN1OXl06ga6wwRwzB6/PtCXPUq
         MIHJ35/I9zGbC3/UtV9D3dRsfqCNWPqZatbiOSl36cn32RhnaQ9e/STOWShvbzE/vFC1
         1yRqz6pwgdohTbEIC4YMMbpLdyaIMKJAME2fUu+TiJxGkflB2N6K8jd/7m+xOAWh0dgI
         3VoHfYwnyif9aq/uXpdG3xVTgFbXk2UAS4ELj6rweHuGCK7dxc5Z6YZRH4mn88e7AD+u
         72/w==
X-Gm-Message-State: AFuF++lJzcnJkQof27AEs/8j3xBJgpmCnfezV65efobNWZ+A3wFNECFn
	uUiOOi+c8Ig8NvfpU56rADZwjT4dv5iJVbczBRVojV6C6PKv8Y7PcNUb2/dhD8w0YDTIiSSZywH
	cXNDXKhq5R4kPkfO1cVP6/hnfyDgstBB1gQ==
X-Gm-Gg: AYBFou03P3UhIdnYKILRwH3xWl/zA22BavL41+E/X8TKYAN6+L19TFVJej96zi//W2d
	ytUQyZ7pAc+r7r0B+t+5yYFZc/FMwjtG7cxXX+hViXW1CXeKiOQzPu8ZHqc6rfEmVahIQDPGe7T
	+8tywVHi/shADtu3PbMQc5okHPAqlNCeiL8M6oo/OpSvOa754xZ71e/A55rQUgbmP7yfz29npBv
	vne4tDWThAv4UzrCEVua7jxeRSSUIWKylPkg2PS4tTBG7W3XbB/7dagaK1sQ4jeZ/k/ckT5jVii
	2Zb5X3Ky65bmlLIv79BQ5uQQIgcE8qfyz5tSvtG0C4bCgB6gUwPr2yKGoGXaAPEoXAOwdJZVp4z
	VAZ29k0Z+fX+nncR6PB839iSgd3WTwyLGTKX8dkRp9U1RCIJf4DsGnk2hBbN+2Q==
X-Received: by 2002:a05:6820:1c8f:b0:6b3:7e9f:e9a9 with SMTP id
 006d021491bc7-6b6fc5dc02fmr1973144eaf.18.1788476597500; Thu, 03 Sep 2026
 16:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903125531.68044-1-f@lex.la> <CABPp-BGW4XBB6+2X=02ZDcXo2bz3iZ7D-30w_cV_51mD7j7htw@mail.gmail.com>
 <20260903200013.36820-1-f@lex.la>
In-Reply-To: <20260903200013.36820-1-f@lex.la>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Sep 2026 16:03:06 -0700
X-Gm-Features: AcwNN1XplbaXd8_6IuBX1KkCVQBNmIPbnEiEb3xbOThc7Ux4HuY65SEFeXMMq-U
Message-ID: <CABPp-BEyy+bXP42Siy4bGOQCagD8x-dL5O+9WxuzdCS2rwLDrg@mail.gmail.com>
Subject: Re: [PATCH] technical/partial-clone: narrow the one-at-a-time fetch limitation
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 1:00=E2=80=AFPM Aleksei Sviridkin <f@lex.la> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
> > Maybe ask your LLM to make this cover letter more pithy?  It's unfair
> > to request humans to read voluminous and likely irrelevant LLM output
>
> Sorry about the wall of text under the scissors. I do write these through
> a model since English is not my first language and it reads better that
> way, but the length was my own doing. The model did not run off, I piled
> the context in on purpose. Won't do it again, I'll keep the notes short.

I may have come across a bit too abrupt; sorry about that.  The commit
message and actual wording changes all looked good, and I appreciate
you contributing those changes, I just figured the feedback on the
cover letter would let you adjust and make even better contributions
going forward.
