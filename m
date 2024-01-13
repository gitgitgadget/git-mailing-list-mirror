Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78C168A2
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHRNcAhS"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-598dfed6535so338858eaf.0
        for <git@vger.kernel.org>; Sat, 13 Jan 2024 14:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705184767; x=1705789567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxhs3pbUq+cVdvwHIhS2nzG5GXRuqeIayjOHmaDcvtw=;
        b=ZHRNcAhSo6vkbLc+ZnLga8CwxrCKvps4VdDO4/zcI7y+gUCUmK8zhrT2cwQM5krUeE
         +g2oPLSISIRLUGV5GpOY+JZ7FfQ2NV1ENLocTZuV7Xh269K8KOJiuxws1VStvQwSt5rC
         ToKHXsKMzTAnXGGXGPnHa2NcVCEqqCOUqth8TYyqtMAkEFMmYNaf01l0+0jXiWMwesrn
         HyO46HOUjy4+4bjbjB64nZ7vxvn69ivq4JsdcklzBu/2mrjTr7vuddNzOCexeCS3nc81
         8irlLiMN7PT5LY3qaof+B2VwcttZZWhvOMY/Z8meeT7wPQ5i6yaEekajWUa11k4n4R3B
         VF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705184767; x=1705789567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxhs3pbUq+cVdvwHIhS2nzG5GXRuqeIayjOHmaDcvtw=;
        b=otrgOSSIutDmsg1Q5Rmp3OuGWx8pXxWzNjZLz1fATw8qbf9ZaVDQKRKUJxbcLN9gcO
         TiYMb1wQlGEPdqGXYwO3FDVtcGlhAR2Tx7aqYwm7Ax/bdzao1ljNfJUi/cCz2+uf1zMM
         CEDaaqUg1GWaaM8qfQFFeHidu6bD/28rlnYX7z25D4D1UuhbsraeuHlDAD5PCRv9F5+e
         Xk1h3Lf4e9JizXE26VjaiOP+joI2D5SzY5yXgH0sI6wXHASmVKS0KCkwQ3Yd+++Qmemf
         ZF+zgmq9iBAEmqejwSbsKkYXgD8zw3bPrOt5ASfNJBOn7lDti5HazOmWRTxdb1sNv02D
         iczQ==
X-Gm-Message-State: AOJu0YzkLW3HtLOrrYpKx6W2UOUNT77d+lKpbfP3h4nqQOkfLn38Rht8
	h0uRtiVae/udcdKR6yR3f1X5MOWP9LnCKvuKU2E=
X-Google-Smtp-Source: AGHT+IEZMr7kSRiFTiqoSz3KLWjIpwYxvKDMI3SJWCWHaJvLbIi/pPqEHLrhFDItu87/Kwh6IVZ6z59sZBQr/ChhU24=
X-Received: by 2002:a05:6808:1709:b0:3bd:4df7:db85 with SMTP id
 bc9-20020a056808170900b003bd4df7db85mr4064313oib.69.1705184767307; Sat, 13
 Jan 2024 14:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
 <pull.1634.v2.git.1705004670.gitgitgadget@gmail.com> <f953a668c6a7e0a57adcee77ceee2d578970065e.1705004670.git.gitgitgadget@gmail.com>
 <20240112070356.GE618729@coredump.intra.peff.net> <xmqqo7dqbfin.fsf@gitster.g>
In-Reply-To: <xmqqo7dqbfin.fsf@gitster.g>
From: Justin Tobler <jltobler@gmail.com>
Date: Sat, 13 Jan 2024 16:25:56 -0600
Message-ID: <CAGAWz+6yKzFz5bQc6OHbd+=xGsjzgEb7nkpDkht+Y-OGYVyYuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] t5541: remove lockfile creation
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Great! Thanks everyone for the help!
-Justin

On Fri, Jan 12, 2024 at 11:58=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > On Thu, Jan 11, 2024 at 08:24:30PM +0000, Justin Tobler via GitGitGadge=
t wrote:
> >
> >> -    # the new branch should not have been created upstream
> >> -    test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
> >> -
> >> -    # upstream should still reflect atomic2, the last thing we pushed
> >> -    # successfully
> >> -    git rev-parse atomic2 >expected &&
> >> -    # ...to other.
> >> -    git -C "$d" rev-parse refs/heads/other >actual &&
> >> -    test_cmp expected actual &&
> >> -
> >> -    # the new branch should not have been created upstream
> >> +    # The atomic and other branches should be created upstream.
> >>      test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
> >> +    test_must_fail git -C "$d" show-ref --verify refs/heads/other &&
> >
> > This last comment should say "should not be created", I think?
> >
> > Other than that, both patches look good to me.
>
> Thanks.  Will queue with the following and "Acked-by: peff".
>
> diff --git c/t/t5541-http-push-smart.sh w/t/t5541-http-push-smart.sh
> index 9a8bed6c32..71428f3d5c 100755
> --- c/t/t5541-http-push-smart.sh
> +++ w/t/t5541-http-push-smart.sh
> @@ -242,7 +242,7 @@ test_expect_success 'push --atomic fails on server-si=
de errors' '
>         # --atomic should cause entire push to be rejected
>         test_must_fail git push --atomic "$up" atomic other 2>output  &&
>
> -       # The atomic and other branches should be created upstream.
> +       # The atomic and other branches should not be created upstream.
>         test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
>         test_must_fail git -C "$d" show-ref --verify refs/heads/other &&
>
>
