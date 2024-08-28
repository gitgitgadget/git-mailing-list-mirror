Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA41A7AFD
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874847; cv=none; b=QkKrbtxSxBeN3lRGY894X33KTAPs8Z2zvHoo4R89rtFXSAUhjf2lPVqBlxplQ6Tuoxrt618tWWktLloTxcDoWM7pHfB4ZCtCTcaSF78rRiBYd0reGcFg3IJYyuP8MU8d/PLvP4vR+M4ltj/yvRuiKAkOaS4MNzzK0vY3ggMsGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874847; c=relaxed/simple;
	bh=QWBdhMZMTshjUi7BYcgExf7yTZO0XwiQf7/08DMwEyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWw5lhfcUW21Pc04A6JawbKAE5aAfkEk/Ar1usMFxCcxHRPQRCVU0Rb4d8Rcph5gfh3xNPMA5RcluB7pm0wGPyMA572c0ApsEKFqhevvpjvOYnmjv3veUlrWqoB3wlTi2gqx+xkEO/lOcxsklmcqdAemLMdNkop4Csl+p79OVWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-493bc0adb20so386060137.3
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 12:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724874844; x=1725479644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWb0W3CK1iC6wAKi526dZ8nR3aJBvlNpwCi1g5TXSHQ=;
        b=UpcOqT3x1g01hFQAThbyVUjx8vGV4c+ftLhoNvdou3+YiBy0DP9YXyDMqRpUQl+4Ub
         ewTuT10mOBC8obFt1IkgAXwS9cLwxKCDJPHgYG4RBnTLgqA6TgI+yp9e1918YE/sfXKc
         PoLalTT9DM576xNXeH21j7n0AsgVfH3p83ALFA7sX1uePGwRHeXPpY6NEajD6htdRtj7
         bMBqg42lIAglB/C1bzu9zHDwiWz3/pPUBxrg0ET7D1wGf0vPHXZJ+yYXxbD5Npl9/7Vc
         Ak9wrorz4TScaLdmDJstIDF/iNfDNZ5Ubg7nRHfiuvjPwgqhvsZprhqGs+62DL5kHalJ
         aqVQ==
X-Gm-Message-State: AOJu0YyB2XY+XvrrAMmmwsFOLuUuf8TOImhifsyJkWcQ5A0PD7JCfCQu
	S0AO04nbWlTuRmHjUE22uJxmXoAxiXOwFiJyXU0Hr5TI8opAyVeUcnuK48Wvdxw0VFinIhMkpl9
	3ZuL+WzzLfP/gGElWYZbW8x0ENwQ=
X-Google-Smtp-Source: AGHT+IEXMvj1YUiIFQfoAVLThr27bukMjyGgkmx/i6oanuPzan5Y2Bp+Aj/iUdF3+eYYw9uNFfKQRe/Now1zAnJlF8E=
X-Received: by 2002:a05:6102:508c:b0:493:31f9:d14e with SMTP id
 ada2fe7eead31-49a5ae55d5emr594031137.2.1724874843968; Wed, 28 Aug 2024
 12:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828035722.GA3998881@coredump.intra.peff.net>
 <20240828040049.GF3999193@coredump.intra.peff.net> <CAPig+cQLr+vAzkt8UJNVCeE8osGEcEfFunG36oqxa0k8JamJzQ@mail.gmail.com>
 <20240828144814.GB4020916@coredump.intra.peff.net>
In-Reply-To: <20240828144814.GB4020916@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 28 Aug 2024 15:53:53 -0400
Message-ID: <CAPig+cSBPxtv50KknJVbucAa9RGxQxP66XHpjCjECWdSGPRHjw@mail.gmail.com>
Subject: Re: [PATCH 7/6] CodingGuidelines: mention -Wunused-parameter and UNUSED
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:48=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Wed, Aug 28, 2024 at 01:56:13AM -0400, Eric Sunshine wrote:
> > What is the expectation regarding newcomers to the project or even
> > people who have not been following this topic and its cousins?
> > Documentation/CodingGuidelines recommends enabling DEVELOPER mode,
> > which is good, but this change means that such people may now be hit
> > with a compiler complaint which they don't necessarily know how to
> > deal with in the legitimate case #3 (described above). Should
> > CodingGuidelines be updated to mention "UNUSED" and the circumstances
> > under which it should be used?
>
> Yeah, I agree some guidance is in order. How about this on top? I didn't
> go into the decision tree of when you should remove the parameter versus
> using it versus annotating it. I think in general that the first two are
> pretty obvious when they are appropriate, and we just need to focus on
> the annotating option.
>
> -- >8 --
> Subject: [PATCH] CodingGuidelines: mention -Wunused-parameter and UNUSED
>
> Now that -Wunused-parameter is on by default for DEVELOPER=3D1 builds,
> people may trigger it, blocking their build. When it's a mistake for the
> parameter to exist, the path forward is obvious: remove it. But
> sometimes you need to suppress the warning, and the "UNUSED" mechanism
> for that is specific to our project, so people may not know about it.
>
> Let's put some advice in CodingGuidelines, including an example warning
> message. That should help people who grep for the warning text after
> seeing it from the compiler.

Makes sense.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> @@ -258,6 +258,13 @@ For C programs:
> + - When using DEVELOPER=3D1 mode, you may see warnings from the compiler
> +   like "error: unused parameter 'foo' [-Werror=3Dunused-parameter]",
> +   which indicates that a function ignores its argument. If the unused
> +   parameter can't be removed (e.g., because the function is used as a
> +   callback and has to match a certain interface), you can annotate the
> +   individual parameters with the UNUSED keyword, like "int foo UNUSED".

Perfect. This fully addresses the question expressed by my review
comment. Thank you.
