Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46C219FC
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334787; cv=none; b=X+lNodtLc8fu6G2oeAZViD6tqsBDu6/okz1dFZzIog13uRm+E6HLQ/MebgrTvsUJ16krDtIBz8n46ftCNQnIop2ZWACkJkF6VcHMRkL8D0UcUgzdWFOZjZvOITn5Fw9Di2pi4Gq59TFZq7nesrqsL3wOC6f9u6w5ObEiWLSVP/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334787; c=relaxed/simple;
	bh=/pqznN6wss46C6/bfVIsUpePtcNjrfbwn6umCpmZM6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtpKc6qPH3aTNgAOD7IC2NYWWGLIGN1BTpHzByWiN2AkLgnoe1z8vvGqNb3tq2593aG1RxFsWR5ksUuSe7IWou8PYEBFIl+PG5pqMwZjwilT/gKOkB1djgNQ41gUpYAGkwVt2rpztZ5mKZVaWsodQPJ+qY0sF16Q10mHg9sJB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7bb849ac4cbso14560385a.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 06:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738334784; x=1738939584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1x8hstnMbVVHxE+iapbaX5+KPtbKuK2gHPQeCs3kZA=;
        b=Y/tXJEQNykPKa+p5MDyCR+PrzDkxYA5q7zxVzJdgPsb/rk+2D4E4ThSjQ8gioNTbc0
         1dT+MAnaZHX+9b26BkaQeMrkqo+5qkZ6maWrKKxQf0u9X2/hEs5Ovb+Mjz7I7QFN77Uu
         PAhl+0pctC91ayo5kIjbl3mINTEjpkGI4aU6s+UB6Tr5xy68KTEhmkac6NHSbCvxUwLM
         5vCDgB2fiqXun/wlwzgFMQKonKKPZ2zkaMynGAKj0LbPltwVkroqxH8bpYDHeFtiQZK6
         0sxYPMF0vKafzoAdHqJRgdEWZGwqpJtraD0cyprPRtgyAfmw3qBDdiIbCdzJuutXkefl
         LK4w==
X-Gm-Message-State: AOJu0YyaH4JWC/Mxdzvy8iDsm+ikJpW6+QczbEVwJ82voSUUOMxF1iyD
	2j1rbp0gqpkxppydQM61i4XKAM7/+vBNNWJEP2EC2o/I+AP7u8XLNDojl6AgDbt9iYBeJlXTIod
	Wz3c92U48IwKN9LObmiICa2hy+tGy1w==
X-Gm-Gg: ASbGncuB2+mFpJcOROtBp/HMVWCSqjUQ4Hfde6TT4MEHZPQTVMA04Bm+vti/bFRYNv/
	zjtjj2lvpVbbWMyTWSAPhvJdZAPA8GVStdIfIpD2GDHPDKWVPPHpFImuQHM8X7LVll8VKVqVQFT
	HOxwv1rqoVlmvXrAhQ9Yxpzzp7dwzpHg==
X-Google-Smtp-Source: AGHT+IEEcQOYO57nC6dkb+Wb5USSyoNZlJZM0vo8NeDSH/ti4YA2TWbI/F8YeL7wPoIuc8AaxjYvYbdyvqnTqEcfDy8=
X-Received: by 2002:a05:6214:624:b0:6c3:5dbd:449c with SMTP id
 6a1803df08f44-6e243b925e7mr67441846d6.1.1738334784398; Fri, 31 Jan 2025
 06:46:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
 <20250131-pks-push-atomic-respect-exit-code-v4-4-a8b41f01a676@pks.im>
In-Reply-To: <20250131-pks-push-atomic-respect-exit-code-v4-4-a8b41f01a676@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 31 Jan 2025 09:46:13 -0500
X-Gm-Features: AWEUYZnFQRBBb5HgSZZHVvwXrdo8AC_Msz4i2YVOFELy6rx2WbW2yqwOsXkWaoo
Message-ID: <CAPig+cRu20put-2WM=OfJeMmDe+1_jDKPeThbC9Vsw1EmHAp3w@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] t5548: add new porcelain test cases
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 5:53=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Add two more test cases exercising git-push(1) with `--procelain`, one
> exercising a non-atomic and one exercising an atomic push.
>
> Based-on-patch-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
> @@ -132,6 +132,40 @@ run_git_push_porcelain_output_test() {
> +       # Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
> +       # Refs of workbench: main(A)                  baz(A)  next(A)
> +       # git-push         : main(A)  NULL    (B)     baz(A)  next(A)
> +       test_expect_success ".. git-push --porcelain ($PROTOCOL)" '
> +               test_when_finished "setup_upstream \"$upstream\"" &&
> +               test_must_fail git -C workbench push --porcelain origin \
> +                       main \
> +                       :refs/heads/foo \
> +                       $B:bar \
> +                       baz \
> +                       next >out &&
> +               make_user_friendly_and_stable_output <out >actual &&
> +               format_and_save_expect <<-EOF &&
> +               > To <URL/of/upstream.git>
> +               > =3D     refs/heads/baz:refs/heads/baz   [up to date]
> +               >       <COMMIT-B>:refs/heads/bar       <COMMIT-A>..<COMM=
IT-B>
> +               > -     :refs/heads/foo [deleted]
> +               > *     refs/heads/next:refs/heads/next [new branch]
> +               > !     refs/heads/main:refs/heads/main [rejected] (non-f=
ast-forward)
> +               > Done
> +               EOF

Using '\EOF' rather than bare 'EOF' would be appropriate here and in
the other new heredocs added by this patch.

(Not worth a reroll on its own.)
