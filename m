Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794129524;
	b=KEB6qaprwxWnz0OcyvcHsJEUnc5fFad0zLm7Vf8rHK69O0EgGcfTX59dgBAFaWviFBDZ
	 uGNxAzmLJP6ed5CeFxPTRnGDiUqCCz3Xy2G2vKjwDsLIK6MPZ3z5Zbp6QGBcpd3cV6ny6
	 EiO25NQxPFyWDITvKQn9cflCQYsvO7hGlel9JsddASj/G6DTnJ+dlksLC5QaHcmlatID0
	 /8eBFEhmNeXef7eEYi7iv8oyCvOSbihBPyGgRuusSpgwsp03wbZU9HohdduRJ4j0EV272
	 Gr9otyzW70Y+P03he4HuV9U1xR/uTLmrwW+fQSfjPANTAaHz7zTvRwl21LkXMpQ9uAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794129524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=PX/byLURa8yTxumJKVJ4IJz6ss1SjI6tOn2YvO94r/w=;
	b=GlTiJvGTP/JWFbM2qLY5p//u8Dtqo/lgQqUrkMopYBVKc1hEjrv1SjF4FL3q9QM2Kjav
	 0LU/tooM21G+JynMDdVZ3BS4RvxAziawbBrv/qWmv1CdK3MKqTwzThNPC6K3BkYHW9cQs
	 amtqxhl4EK3WuiEV0FdW/RJn0UrbgZqvmCpblokhsG2W4/7I6vtKzpczt9VtDA0i1B6KD
	 8/90iS3RIBZfvLXUXoTrruItE0PmSrNTKKZsrngFNRAPmeYHcfBwK+d3oUfSTc9cKfyju
	 Q9d9yY29gjaAFe2Isi2RM0MNxMrDZUlapvzpQCe2T20YWiqmzB3Iq/rRE1jZ/wX9LxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=QNjefJTK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCCF606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 09:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BCCF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=QNjefJTK
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c445c95d553so340166b.1
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 01:18:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794129521; cv=none;
        d=google.com; s=arc-20260327;
        b=K+KachWQrrk05I0msdIDph6BML0AEp9/MmkVsRgLFxjj8O176JfhJh2fsZoe3KcKzI
         loVpR6IUwH+yl3HRy8jrCPmszzHwXEaOXet5tJlc3v6/4mk9uylMuxCVldjQ4FmAPNJV
         BVwDfpEK8pS3Jplrnqvu4pQMkXdwhUaUmjCQUwQsrfsenLlepYk1FiE64xMkbHJEV9kT
         GyIN2w8ize0tpFNMX58pg/7vHgw7M0NahtirxNms51iEzodVVlZ6nQT1gydpnyi9JiS6
         GsZUjUiukseLAJ1efD3NDreb37jY2MEfAoDrW7GLiQmsK8YKPblSv5StXuvd4ANDaWzX
         fcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PX/byLURa8yTxumJKVJ4IJz6ss1SjI6tOn2YvO94r/w=;
        fh=DW3IoLlvKSOht9jggmfAEO3U6bMQW0zBZpEvgtyBNlo=;
        b=sVjPqk2KUsrp704oZIqT0EyNP/TkcSRi99U+Yulyd97x/u04F/SmfYOX7AH9eYznMr
         b2zsHKmuTy9HrmLEESDToqxDZVnC7hOmJRCkvbSPvhono0jy5QDEA57hIiINFs5SbfiE
         P3pm6qTqHk+smQZ2GNL+Qh8bj8nl/M4RTnB7BUZ2F2Lnf0dK6abx0bxeQA4Sv8HunYc7
         9ki2ZJT4XnVKIikseCunXR6eMJ1pLi7FUnNYnc3KfLKKNcT9KYIMjI6isuMxkZNMww2i
         l2gSoNQYHJzB4AjqWNfwIf4sjbAe/XHFUwwUKYW97Ghjl/HuyJ4XUIp2n/s08nLiVGVC
         N7NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794129521; x=1794734321; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PX/byLURa8yTxumJKVJ4IJz6ss1SjI6tOn2YvO94r/w=;
        b=QNjefJTK1C05Efs3YYBIIft02aNAzi2+J4QRcUz/0ASyCyiF+A/HATFyM5/5UGeSP4
         M/9gBxRf+DkjVveFm95rdkH6oJpgeTgkr8Y4/QvuyVDWgL5knhfeSWue6alOg4F0SD4S
         QPkTjgOqfqXCY8OTDhZ/c+6dn4UbV9EEJ/7U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794129521; x=1794734321;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PX/byLURa8yTxumJKVJ4IJz6ss1SjI6tOn2YvO94r/w=;
        b=kzXhV+XIhlv5iv8iq7hvpzHz87TEDUW9sdAaXzwzbwHHp4R1D1vMg0GC3amIi+vBNq
         0uaugAJJ9k+OfuO7X8l8dimKog2GtAUgCQW0h+cPZFMHhtKtp8c878oGU+SMg8C8BGuK
         Rs/bskm6Oesu4R2SCaOsTu0HW7DMBUXHCG6aJEcZfgWyxJkGfyaLlV/xCZTzaJQdnlm8
         6Jk8WwY5/BLeMUunNJn2fKqGaU4BE9gP+Z7uQMfg2zvLBdT+m4vzRM67I4nsZsZLCqek
         U1wjqbbCF2n/9U/KQtlvh5cv35wfcl0yMoXKF6J/T7KPLgR79ltG3F0M1mcP4OXHGzDe
         cNzA==
X-Forwarded-Encrypted: i=1; AL+hErHU2Q2qdua3TrbAfhtchn2CW69ovM8bRuvUjKGfuPI1ueXqxQkwtRt2OuW8DeWkFToAuu4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7sCSNxeW2Oxgw4FvDZr3D48/KKS0MF1zSiLmaDh/IP9nsFsMF
	liTZbWGRZ2u15aYdtwsHuXzxCn3UTHpbwaqtMNeRSzEagvGtZEt8N7OXKbvRTJiAWLv1kASTZG4
	Y3Kap0Vrb37xL+Njoj66pIt4Glom6xqCaE/Z42KFRVQ==
X-Gm-Gg: AYBFou3zbfchescIMRG2yqR++FgEnCVrTwntp9qQpnuBvTOSqMIl0y45IY8UbTd2KBL
	Hl5p6rDNJy4WCWAnMCAq3t+Vgo/p6NMqpg0ZbEWsQNnhY5G5JWLNzQSFjJ+fZsxYsVadVqqd0Nz
	9ufun4bO0eS3hSKAtoJwt0uPLlMCPKrh4ZEJg1LgvB0BNfnyhXOoGvmPSOeYZ19ebcT9VtfIcr7
	OztLbrrODpyB/nD0OCJ2P91KFohC2+wCKrCGK3IL67ty33VSdKGV7e5qfddaTL6/HyKzJfQci/f
	7snd7zexVa5C6nKUCsDLHOtDT2+gso47clISQNnfvwYTarlyWsMpwlRQKB0NYuEpE8AmAgWh6kz
	cpWalHa6T+GlsA2iPruBrMyO0A33VHXKLGohDbg==
X-Received: by 2002:a17:907:944b:b0:c35:d50a:1352 with SMTP id
 a640c23a62f3a-c4d6d48e199mr72130066b.11.1794129521507; Sun, 08 Nov 2026
 01:18:41 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
 <50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org>
In-Reply-To: <50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 8 Nov 2026 10:18:27 +0100
X-Gm-Features: AclHuK9FcX6BqTbeQISSFaXjNeKJ6FfhC9LulXAok5vmw4rUPJ_zgOws8xCU0c4
Message-ID: <CAL71e4NFyAShDZPW9JRB7Bpg3aLY5mY4wdn5m_ZYoLQjHZw_jA@mail.gmail.com>
Subject: Re: [PATCH 2/3] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Nov 2026 at 09:54, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 07.11.26 um 15:59 schrieb Kristofer Karlsson via GitGitGadget:
> > Several tests create fixture data consisting of a single repeated
> > character with "test-tool genzeros <count> | tr '\000' <char>".  This
> > works well on platforms where tr(1) is implemented efficiently.
> >
> > The implementation of tr(1) on macOS supports multi-byte characters,
> > and processes its input one character at a time through
> > getwchar() and putwchar(), even in the C locale.  For small inputs
> > that does not matter, but t4205 generates more than 2GB of data this
> > way, which makes that test much slower on macOS than on Linux: on the
> > macOS CI runners, tr(1) alone spends 95 to 123 seconds of CPU time on
> > it, compared to about 6 seconds on Linux.
> >
> > Fix this by adding "test-tool genbytes <byte> [<count>]", which writes
> > the requested byte directly, and turn "genzeros" into a thin
> > wrapper around the same code.
>
> All cases that do not need a particular character can use
>
>         printf %0.500d 0
>
> Though, on my Linux box,
>
>         printf %0.2147483649d 0
>
> produces nothing, but
>
>         printf 000000000%0.2147483640d 0
>
> has 2147483649 bytes of output.
>
> If this isn't insanely slow on macOS, use this pattern instead of a
> highly engineered helper program? ;-)
>
> -- Hannes
>

Nice trick, and it would work for t4205, which does not care about
the byte value.  I tried it for the 2147483649 bytes there on Linux:

  printf           time   peak memory
  dash             6.5s   2.1GB
  bash             6.0s   3MB
  coreutils        3.7s   2.1GB

It is definitely fast enough (on the variants I tested).
The annoying thing (but not a real blocker) is the extra memory
usage required and I am not sure I fully trust that all
implementations will behave the same for absurdly large padding.

(Particularly for paddings larger than 2^31, as you noted too.)

It feels a bit like a hack, and tweaking the existing test-tool
feels like a more sane option that is easier to reason about.

A gotcha here is that the printf hack only works for producing
"0", so for the cases we truly need NUL characters it does not
help us, and I think that is also a point in favor of
simply generalizing test-tool genzeros instead.

Thanks,
Kristofer
