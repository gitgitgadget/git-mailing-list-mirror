Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A1153BFC
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824588; cv=none; b=gEca6WJXIU7Im3vSKEPZW8bDQP4k/I1iUttaojnquBsJ6ho7WZJr7eRxi99j+rAanl2NbJQA6JQlNdxNuyPByeQGMdEARBbYui/0afURemFSBG5pTxC3KIQbMOS2QhauOXOhZthdF0EK6PqMVEhu4Dm/SiryhdqGTzzHq8XhYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824588; c=relaxed/simple;
	bh=94o9OWkETYmIK76od1j+vkNt+NJF0VtgAnF6oiHUH/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSANREdA3IuR/kfVyf24iti/hQTHHfhqjKsHlGor0sKKXHqJY+K7lq5RKCe9P1rYIc5j938HYGLPKMdvfGJLWwFcHrxw4mcNFbvVAdM/Ayp8q8j6nkmqGTrhNT1e/x666yY+0AAjDALMqJibjGgy7GVNP4/5RcHrPlu/qEBS9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6bf7850d61eso8415426d6.0
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 22:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824584; x=1725429384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxklvTjGzOwOVCkPvi6gQGwEi++jnLzz8gubkle2AeA=;
        b=s1TT2DlC8jE++bSGeYTC9r469y9oc4FLH6xnvGcrVnumJY4gOnNugudSiT9j2iM1CJ
         AqtzZiXRGlsLc+OGzX58Qa8u1z/1eahj1OjEEStigGF/uX5y6olv4AByyEeAhFP7h7ko
         JWSrXH2cgzqjMJLAbokodLJyEOJlQCgDCq66iZHDdaVHIbI8lbBP4h9EpRS5xgiEQKVY
         ViVs9xfo/UtS10xBK+VfKOo0MuMbgF61ny4zPlgdjnUUT7YQ1OReu78HneqtvVPJyj5e
         8UiYfmybQkIkekWgUqraRnCkXgt58064slKq62rdcK9NGGJH14xV4q1Jrcb8lXGIIzAl
         tmjA==
X-Gm-Message-State: AOJu0Yyy3BOr3R+SqtCgj/nJyryIdP+dA6YNPuS4CttqHr4c1JQ8m+io
	4B+wLgcK0g3Yca4h8e5la54hyj9bQnYKbwWcG1wr5CFE65dwMlva/daT1aKA+vjtPeyJO0Ss2FY
	q2eOnZe2r9/Ie18b3TgXrGA93cc+C7VUmzAo=
X-Google-Smtp-Source: AGHT+IHCFdiRbIDvFeiF3Jsx0tyMGhj4oxAnHqVQwzat7sD53u6qppTpX3FRx0GLQCGX7jmEcec8C3d8okvdKyVX6wo=
X-Received: by 2002:a05:6214:3004:b0:6bf:6ef5:4160 with SMTP id
 6a1803df08f44-6c16daecee3mr112351816d6.0.1724824584547; Tue, 27 Aug 2024
 22:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828035722.GA3998881@coredump.intra.peff.net> <20240828040049.GF3999193@coredump.intra.peff.net>
In-Reply-To: <20240828040049.GF3999193@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 28 Aug 2024 01:56:13 -0400
Message-ID: <CAPig+cQLr+vAzkt8UJNVCeE8osGEcEfFunG36oqxa0k8JamJzQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] config.mak.dev: enable -Wunused-parameter by default
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:01=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> Having now removed or annotated all of the unused function parameters in
> our code base, I found that each instance falls into one of three
> categories:
>
>   1. ignoring the parameter is a bug (e.g., a function takes a ptr/len
>      pair, but ignores the length). Detecting these helps us find the
>      bugs.
>
>   2. the parameter is unnecessary (and usually left over from a
>      refactoring or earlier iteration of a patches series). Removing
>      these cleans up the code.
>
>   3. the function has to conform to a specific interface (because it's
>      used via a function pointer, or matches something on the other side
>      of an #ifdef). These ones are annoying, but annotating them with
>      UNUSED is not too bad (especially if the compiler tells you about
>      the problem promptly).
> [...]
> And since the code base is now at a spot where we compile cleanly with
> -Wunused-parameter, turning it on will make it the responsibility of
> individual patch writers going forward.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/config.mak.dev b/config.mak.dev
> @@ -54,7 +54,6 @@ ifeq ($(filter extra-all,$(DEVOPTS)),)
>  DEVELOPER_CFLAGS +=3D -Wno-sign-compare
> -DEVELOPER_CFLAGS +=3D -Wno-unused-parameter

What is the expectation regarding newcomers to the project or even
people who have not been following this topic and its cousins?
Documentation/CodingGuidelines recommends enabling DEVELOPER mode,
which is good, but this change means that such people may now be hit
with a compiler complaint which they don't necessarily know how to
deal with in the legitimate case #3 (described above). Should
CodingGuidelines be updated to mention "UNUSED" and the circumstances
under which it should be used?
