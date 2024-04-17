Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC7B653
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336506; cv=none; b=OI3jlhiaF7v99JzOv+y32DKzJeRX4TLKLPIYKgwFF+bg96Z2NIoLoMLVyYNcCWfjyzfVT/iNK03A3lYAZ376+yZEYftTSN4mRCLDpBbbhxH/PARQwoqNq0F0M3E/daJ4OB6Wb0zoQ5Ud3/rKzVxBx+mpd5sUwU+/GQ/Rdd/7krE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336506; c=relaxed/simple;
	bh=LK2cwv6RWR3uFjL1KOViEqQn9ZDCv31h/ZbHvceTdp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Khw6q6Wbb2iBrPn6nt88YXeIYYUQ4jP4U0ZSVA8VFH13bstefcbWPyi7sGpIY0qmlFvqrWlbccI1eqyI24WPd3UByD3nFMet1hYHoIALwxnYPpnuNtMXs5Eco9JKsdsbL33pyJ8JAnyAu6GEJHCOrybcqqZuAP2ebKnI/oi9ZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b40061bbeso27775556d6.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713336503; x=1713941303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQv7WTUabfG2cDE1WZGV4vXC9CfD4E6yoDSweU2DuRk=;
        b=TVkFWkRkgVLkulWs5j533PlVfjl/fkDfRee97Y6sgPogsqn07w73x2ZiqZfU2q1WB5
         9QVM/mZB+BD+Y9mGhLTo9QajjIB00+mHFKRMqnejdkgFI7h1YF2J9VCYqgRKILfIQ8nb
         lu6VzLXeR9kCE6ukmubO4H9NXeR99gEzPwpUIh05/R1lzr1dVjpYZ4Y75ef+qsdN9Pbv
         xRFnNPncAx/vJpECJYo193/dm7D1wNrRoo9H2Vxc6sXKFLaF5jvcKItcRck5ngguiKwc
         +Ktp6AbPeChfkJsLX9Lu16qV8J8f+jz9ChwB2ykK/nV7R586+sb74A4mSHIF68nVp8Mu
         Gn0Q==
X-Gm-Message-State: AOJu0YyEyBZJNLlz8W/dnCTMU5/DRylLtKjpTp2RbEA7ZiJ5l75nz5Vw
	AcvdVq2kPboMOaFqMtSRQB1K3A6ZeTiNtHzkW2MZ1QrVCYaxPqJgYcE2OmdEQet5tJdFXdMNE6S
	PVGjFo72kNVpZ+iS9hOFyhz7rkfY=
X-Google-Smtp-Source: AGHT+IH3qqcEti1wE2JAEHFR9E439NUThzFmxS1tz8cFbsbThqbMsuxXWPlZj47fuo3aBCEyuFlvpT3+aAMX0ZYPjiI=
X-Received: by 2002:a05:6214:170a:b0:6a0:423d:88ab with SMTP id
 db10-20020a056214170a00b006a0423d88abmr2059549qvb.8.1713336503477; Tue, 16
 Apr 2024 23:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713324598.git.dsimic@manjaro.org> <42865d6c6694b9e6b745c328d717ed244dc25a1a.1713324598.git.dsimic@manjaro.org>
In-Reply-To: <42865d6c6694b9e6b745c328d717ed244dc25a1a.1713324598.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Apr 2024 02:48:12 -0400
Message-ID: <CAPig+cRBjosyadQHO03fcCz7YBc=T04ytHkpt9UU87tLaiSOgw@mail.gmail.com>
Subject: Re: [PATCH 4/4] t4014: add tests to cover --resend option and its exclusivity
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:33=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
> Add a few new tests to the t4014 that cover the --resend command-line opt=
ion
> for "git format-patch", which include the tests for its exclusivity with =
the
> already existing -k and --rfc command-line options.

I'd recommend squashing this patch into [3/4] which introduces the
--resend option since it's easier to review the tests when the code
which is being tested is still fresh in one's mind. (For the same
reason, reviewers like to see documentation added in the same patch
which changes the code since it's easier to verify that the
documentation matches the implementation while it's fresh in the
mind.)

> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> @@ -1401,6 +1401,43 @@ test_expect_success '--rfc and -k cannot be used t=
ogether' '
> +test_expect_success '--resend' '
> +       cat >expect <<-\EOF &&
> +       Subject: [PATCH RESEND 1/1] header with . in it
> +       EOF

In all of the new tests, since it's just a single line body, it could
just as easily be created with `echo`:

    echo "Subject: [PATCH RESEND 1/1] header with . in it" >expect &&

On the other hand, if you're following precedent in this script, then
using a here-doc may be just fine.

At any rate it's somewhat subjective and not worth a reroll.

> +       git format-patch -n -1 --stdout --resend >patch &&
> +       grep "^Subject:" patch >actual &&
> +       test_cmp expect actual
> +'
