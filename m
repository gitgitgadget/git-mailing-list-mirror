Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761A036EAA3
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093667; cv=pass; b=LOTlHBm/hjPoY/FhApEnK05/72pHvgCHf4V5wlDkIPZf0Ms8UF/fIkvyZH/ryECL48wjP1i7UkmpY/yEfhSlCRbXT5Xja58enJkM9SXh8Tl268uNS2+vvv9/2bVr+uD3z+568wQ7zWEn+iDzk3pZUoZjDc5PwS8jwVCPrMlO+lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093667; c=relaxed/simple;
	bh=DkbWPpjbcRUVMYVPMWOrXGXaoRc9YsBOxCTeDugglTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssl7OFOg8uajoKm+p+4AryOPkP0lJUrNm4Ta2831JfbYlekAqHzfo6FVqdgB2PxFwiTjJdbHAI88OTX3p1HS2VegNQzARTjzko67wfhYiMOniBG3C31qVbIyCJdZCqgTcojMYPcV2eZnVVfr8QvxNAbfmzX3X/wiO42KMFF3awk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJuSggWY; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJuSggWY"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-359f239ffa6so51723a91.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 15:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773093666; cv=none;
        d=google.com; s=arc-20240605;
        b=liy2S5kBmJgG1buLCi2c30NUK4I3SMxTQxhm2m13pPYptJucBAXkbQm0LVFv3GPW1U
         gGzslf22FqHw4Tg54YibfOCEZgRghG/Gv08ntGu4cs/wh02/L+ftaVFuIVY5pK2oZg8u
         TNwqnilUgdKrZltbhzyohgfcSsv7UQUiJQ4EiPW19EGxhwmQU6Ow+qPo6QwBNMmlEYc8
         L9cbAQKy9I9dJRTm9e4ExZS1s/s5uG3cOoshIgEm3V3NARw0mQtWHzOKvL5aoJppt8K7
         kB6Mt2BdRSsu8tSmw9CU3/fKu1H2oVLazsKBWX2sbIomeST0ftqlRXXuu3uicEBMv2B/
         AEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pP3IhIpBIhuGB7TPPMQB3bt9fFv5o0Zy15TLGsV2MwY=;
        fh=Mjjo8eK8zYEPjIyIFkD0DeKJbMpDbkoLCUNyygV/9T0=;
        b=V5ZRaKaBEihoZjdzMurhgK0gcEM97CuBPlDDzN73cybkLBINi4qcssfy8SM2L8C1r9
         7FgcQX0OncosjqDKE3Ig9/2S9y8HNbEcRtWbnEzq+uH0u2HM8waNLbMM2PWi9QoGC0QO
         h8mSDi/l+33qkfnWeD9rTs3eCSDreou+OetanNPXs5V7hhuTymq2bd2/KwKV5OSabhxX
         ySpXYcV7q3KGjkNN9J7LU0AUFCWXm3tUoFgh2soI2R9/jVrrjJGD5QiJOM/9HGyoc+oj
         uGLMiyg/sUTRYaxeV3+vhpAUpOl/26YAOl3JkOhAzne0icjvoYNuLimtCNIh6k23098S
         Nt/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773093666; x=1773698466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pP3IhIpBIhuGB7TPPMQB3bt9fFv5o0Zy15TLGsV2MwY=;
        b=FJuSggWY5+/njqi55JtdJneUYtv6TVLWQ5JotYkaX89oPLjWo8nWkNervhCqGM5OF0
         sCwix5XAaZ63CXmlUBId2jX1uI+zyszJ+wJiFAX+TYcsvh1+fynVmwngkve7SnkefLx2
         DkT+HkzIByWdvK0xjaIkGTvDcijLmsqGMm/0lSICvDX1gG8ygdxqh/uehSBxkOayMm50
         5vwkP4GXrHQRq7lXrE4joBF62gznw9E0Q2fN0zUJqODSjniaauLTHn7Yvs/oW/dwD8OH
         fhv3of5V9QKWecxnn/iZWOgjvglmcaGE8sHOoQv555mJJpCHKKJ6jxeb1hiIFLB/CK7s
         W5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773093666; x=1773698466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pP3IhIpBIhuGB7TPPMQB3bt9fFv5o0Zy15TLGsV2MwY=;
        b=xHsjDX6oxyWVl+RRetkvZoWtaAc4o7Hbcr7fM46gXX/B/nRSXgQ0SprF/IqRN2qgOx
         GNwy28fe2qJgv66kKKfjyyVBa269Qh4jpWD0TokMGCLi9PGnoDT/6+jTJvohQSvi7l4x
         RyCj0uZsrqdAn+JfBxnSe1gIF5pDRbzm9W27rscT41F4xhqjWfBDMuSmFryvL2ADDEoT
         fjqqn2q7mlYf/O1YDmNs0WpYl0zsSKBboDv54gFdaul2j/DQJ0JOGtclFW3VU0diV4IH
         EdFmprQGvG1eCzyXYisTM4NBET9krnIxMQxpgdfxHryhQUAi4+mPHyoKAhj+VUXOKWb5
         FE6A==
X-Gm-Message-State: AOJu0Yx6GdkPaySl5+3YRIHJOR+h3pim9tAaMczscWaCQI7ROqgAOD74
	FAeiMLZYYlJHyka6NDLeEsvCmYLxTz/volU9Cu6qfD1MuTccDZQO8prYZdZ56Ln5ZhWzxOWAZRb
	RAEsTi1N5EyPrMFn/Z7seqZ9GZKF0+rHftA==
X-Gm-Gg: ATEYQzzlqMKbQP8rz3eOhXgKZk14dJ9hfhmuv/7sIElWGVCeKcdEqKTeJ95RwKv8yO8
	yQNxjFoDlW4v5M/PcWFWbo9ao8UOiwAS5pX6PjaMmUFPwMCZ4Fn6quPQmlOl2iYh/8iimCI0gvk
	Ib3ji1385ZX+ak1SqYiFKWVfUWjJNSy0NICEvem37fDvYupWy/OJp5zBUx1EGSsuiaDmHB4av85
	th4a+k/g/mi3hSSQKDwBlh9CF5iuSG3dF+RnkF8+nf5I8sl1APYk0kdCLHWaHCgdf3HeWpFgUki
	/SNZZbrYOUOPgbZodJJVlar3cXyMUBpoVlyBexNjf+/4nPMG/2HIcZM4KHrKf+pS0IAjsYfTJUh
	BRwpLaZ1lWByU3J1RVWT8W2cVJiY=
X-Received: by 2002:a17:90b:5310:b0:354:999f:1b22 with SMTP id
 98e67ed59e1d1-359be344d4fmr11643080a91.32.1773093665722; Mon, 09 Mar 2026
 15:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqh5qswo45.fsf@gitster.g> <20260309172719.125419-1-cat@malon.dev>
In-Reply-To: <20260309172719.125419-1-cat@malon.dev>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 9 Mar 2026 18:00:52 -0400
X-Gm-Features: AaiRm53NdHcfHjHK0rN4qvLGd2S9415JlOvLYd2ZRux4AzhfSI8LGhnciCyFFZY
Message-ID: <CALnO6CAJfton4KwywVeRFbynWH9zu4nY4c6uXOnEdddKtZpeqA@mail.gmail.com>
Subject: Re: [PATCH v1] diff: document -U without <n> as using default context
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 1:28=E2=80=AFPM Tian Yuchen <cat@malon.dev> wrote:
>
> The documentation for '-U<n>' implies that the numeric value '<n>' is
> mandatory. However, the command line parser has historically accepted
> '-U' without a number.
>
> Strictly requiring a number for '-U' would break existing tests
> (e.g., in 't4013') and likely disrupt user scripts relying on this
> undocumented behavior.
>
> Since we are retaining this fallback behavior for backward compatibility,
> update the documentation to explicitly state that '<n>' can be omitted
> for the short option '-U'.
>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  Documentation/diff-context-options.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/diff-context-options.adoc b/Documentation/diff=
-context-options.adoc
> index e161260358..655496ec3a 100644
> --- a/Documentation/diff-context-options.adoc
> +++ b/Documentation/diff-context-options.adoc
> @@ -1,4 +1,4 @@
> -`-U<n>`::
> +`-U[<n>]`::
>  `--unified=3D<n>`::
>         Generate diffs with _<n>_ lines of context. Defaults to `diff.con=
text`
>         or 3 if the config option is unset.
> --
> 2.43.0

I was curious about the way we indicate this kind of optionality for
single-letter options, so:

    git grep -e '-[[:alnum:]]\[' Documentation

which finds many hits of this pattern. Cool. Adding -A1, we see that
it is also common to document the long-form like

    --unified[=3D<n>]

which you may want to add to this patch. (I haven't really considered
the rest of it very well, although it does seem worth updating the
syntax to match what some of our tests exercise.)

Which makes me notice: 3 is the default if the config option is unset
_or_ if <n> is not provided. Is there a better wording to indicate
that? Maybe the simplest tweak is to clarify that <n> is the thing
which defaults to=E2=80=A6 (since a first read might leave the reader
wondering "what defaults to diff.context or 3? ah, it's probably n=E2=80=A6=
").
But a glance at other docs makes this pattern seem common while some
do say "if <n> is specified=E2=80=A6", so idk.

BTW I noticed these docs are duplicated between
Documentation/diff-{,context-}options.adoc

--=20
D. Ben Knoble
