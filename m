Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793284576;
	b=hhpZd5wZp8KLwB6x8Aceyl+kTSItyCMpjc3wX4jbKTwpFc0Lv7d7aHQ/J/vRUfVZ3OMz
	 dhU0m8EMFUPXDJ9QkjvqhMbcxpTddCNZyNeY8vQTFcBYK+JATVdlZvcXKDUbOExgfGdca
	 F8I9ImAC34obSLjHW5bXB3orKIIW4Yj+aoIHpjQIFcxLQeA9e1bDx4Kgs94nSOxutLzAB
	 ven9AFel8GKGtGG9kpSmjZS5VCIjrLnqYvph+ZN6X6dxwKg66KN3P2d3WgxKDcxUs8ep0
	 JzpSfciz4pb8Wp0LKmb/acTw8xB7IznvwXg4EKVaRjhsLEiiyuXEcat5wjaZ0SLsMfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bc2oFpci+GcL2SZyFtRfBIGpZzKCBlnaFVkY0E4KuRo=;
	b=TfSevypYahS0rrYEydS8y3wDZXF4f6t5BDFnr+0kb7IbGDsYM5aGFEn0k8qvAtu7u8Yx
	 SnWUzDLUN2fzZ5lx5nw3dsjFo8M8fcQ+/pFiCoSPfZTAmjm1ogcH2CZfHSig+4darGZnA
	 Q2/DjpwPSAFCVJT3WmXRafA0qi7KwcoKBh4coK6uuGhy72/m8AgrKk3ZLZw+ByXgkyzrW
	 9PogdrR+Yw8e4YEJd8Lwpxaq4kLzmcTSQGPsGogLUkKU/9oFrTc8zjT09v9tejlI6agt6
	 f214hsDxGy8aLxtCeaV3r+/JdzAA+5okFMoe/fpPLJFvqbhlrEoaFHmB3ccWruYNp7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jW2WsA40;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFFD606A31D
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AFFD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jW2WsA40
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c63449320so22644976d6.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 07:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793284575; cv=none;
        d=google.com; s=arc-20260327;
        b=gyd4KoFvKEyPXjGVx4GPxiHraEyckfT/qeXrioyXRNHjZNqejaI+uFusFsn4MzdO3t
         NmS4jrRuxBaA59aPweoz3bD6roDUeEkW7UX4bAp78xg9xFUFWzXPD01q3836O43tlgu/
         a1GhmPdKiskYKUN/x5Mqbl0Fn7u9lLmysayPwy0ryu1c3aad3iidEOOrPgc9D3DhZGY4
         bA2rJvA8T++Uye0HFK4asdnY8S+5s2j0vLWu9rmsU7Zv3aUc5n2Jglg0AE2FwvHkm/TC
         5cP4yWLoOP0GD7EU3s3PDRJz9ca6/Q9EkkDJH7P1AkhPKXIxK5fkz9vuUa/B6kzEOHN/
         R8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bc2oFpci+GcL2SZyFtRfBIGpZzKCBlnaFVkY0E4KuRo=;
        fh=REU45szy/STF6GEQtmxxdj388hxEW9rLs/wsSyNm254=;
        b=gAa6QofuO0V6UU53JwGx5Be1YEspiIQleGWf48pQdzUa6enua5I11bL9AU3OA0mVm2
         +Eqk8WFaO0qkahWgT+NYdba1gfDR6owIbQZxL6dCBTCGPQmw8lFZ70XZdhePLpTxTPr9
         +dfYZ6QH2/oywekGP//nV+Vsr8l+j/DNb6SiZjCuL7ufWrA0W5L/FBulG1JX1BrDCvxH
         U7nnHjSdOa3057e6ieT0VGo394XVpRBZKMzmborbE2jlUXkmubtGUIw0waKiXqxovS0j
         LbGrq9XBetCaJwNkYQkcV2IoSsSHX7kV/TW3aHmvTxBhGwvyljoOERD+8xDHN0+utO1H
         2jcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284575; x=1793889375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bc2oFpci+GcL2SZyFtRfBIGpZzKCBlnaFVkY0E4KuRo=;
        b=jW2WsA40kychVAN3od13iZQsiRfhfoo0cvHMWX1O3SnErrWZiEB8KzjUWEE/bUnQXk
         0mh2Y18kcrmKaER7+duOT8JzYVy9lMDihmpzVyVPZaMIPUafI1pDOSiZDkWDona19RqF
         noIg8T4DZ8Xq1GR/hDiwfsfFOqbAsifd8KMAWl/1PDVSsSXlOE9kfhEmNndj8rSPUifV
         CIhK0n7H3VXZK72QfZGyhMqYQbp0ofpGPFX9eXtr0svxct8+iIWbhRqsUhz/O5MvtxDf
         c1UReR5ea7qz1JdR4ycWjdAP9KMGYJw+2YLxS13A4LiOhPYuU9Td3foNRvlziN7QI8qL
         iHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284575; x=1793889375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bc2oFpci+GcL2SZyFtRfBIGpZzKCBlnaFVkY0E4KuRo=;
        b=jxVyn6GH90tcWeXDkBoiWPjuEhyZ5un2GtpjKDiCoxqIH0VC5f6h/9TTUj2BHsAR1n
         uydFjq5U8R08InYR0+3YOsySza9ie9mtPSli1WbMoCuJOl16J7SbtF+M49PXWymTd5+0
         cscQUXDYxSioB1TuVrHmcSRDMNVL6py/sCaAwKE5N2e0X/LSO0ye9Dth/rtAvh3bM+9O
         GWyJiESOKuH+yWtUCx+BtI2gQTY985mu9TguBfKKvwp51S3EPwx8TBdFG/+9w9lQIkc2
         IK5q+hqkRUvzctJcSHwrbmcWDYLQYQfa5MhIRQpm9HNy2PuN3zPTWIhZ7InhDJhCIPTO
         YPVg==
X-Forwarded-Encrypted: i=1; AKwUvBzfSKi+r9VxcigKeizVRAfwn2dGDLmU9wLK5hyCaYqgoaY5gnu+Q9Kh/v5IWRN90jRAESw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKg8V6WO9lvJ7Kzzxolfhqmlgk5WcG6PfGvOhjB+o1gHyV538u6
	EEIs/p7SsreJ+F8BGWYMfRqOhvcIHDPO6I1j+Ctj4NqJeY1yDUmKZgLVUoRh1hBq4O43IF0/U8R
	9wPTmZ7Ncs6tIqtpu2hlofnLGnYqbfj5xDODbrJs=
X-Gm-Gg: AYBFou30d4cJZmAmjhJMMSUj6j9m7Ux3PWdpyhain6orpoRkgEa2lQgHPqWsClewzzI
	WLhBP0S24+OkKy9O1hJQZZsDWr1mwxz8Lb5ozmPNjfxtU0MY62ruDhwwOrVYyc0oV2ndWvM9H4A
	ckbbexF5FsuJjlCG/3PfYwnR8B2M8g9Ma9d5zVVr6mdMgq24MEJ64e4ZCKhx+Mqlb1p8CkBBDkb
	HFyg0FAj5Kn+62lIa+erlMr0CdtDR6vSvfRIw+4XW5P9F8EK3gw1DVLMPxu8K265Dnshmix8k+z
	B7ym+kGG+mPria1wPozRHHZ6s193ugpjpGgsBL7/6tlOuzSq+Q68FGczF8/iLWOmakUEChKwen0
	WxBNeaNLkZ+vgv+6+3jOjSSAz8rCPz/2FZkPJ0Cc5e6+s4zKXmNnOR5U28h94Fh8RMkS4ZxHTG+
	nOOFFoYKByAl76yvm2PENIdA==
X-Received: by 2002:a05:6214:8092:b0:91c:8632:6917 with SMTP id
 6a1803df08f44-91c8632718fmr57301146d6.34.1793284575272; Thu, 29 Oct 2026
 07:36:15 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
 <pull.2260.v3.git.1792732388827.gitgitgadget@gmail.com> <auM4FazXNNwLzM3-@pks.im>
In-Reply-To: <auM4FazXNNwLzM3-@pks.im>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Thu, 29 Oct 2026 20:06:05 +0530
X-Gm-Features: AclHuK_mGyrSjjPjRTahp431-WmUboS8VMO2_KIQ3IN7_HgwjO1MnmMRpK2JfBE
Message-ID: <CABh_KWik1x+CjVoTAywGLEeURVWj7u_TmWMsAwnma4g18MMoUg@mail.gmail.com>
Subject: Re: [PATCH v3] [Outreachy PATCH] t0001: avoid pipes in test scripts
To: Patrick Steinhardt <ps@pks.im>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:42=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Oct 23, 2026 at 05:13:08AM +0000, Srujith A Poojary via GitGitGad=
get wrote:
> > From: Srujith Poojary <poojarysrujith@gmail.com>
> >
> > Avoid piping output from git version directly into sed to ensure
> >
> > that any command failure is properly caught by test scripts.
>
> Formatting of your commit message is off a bit with an empty line in
> the middle of the sentence.
>
> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> > index f1d227f271..c8c74f681b 100755
> > --- a/t/t0001-init.sh
> > +++ b/t/t0001-init.sh
> > @@ -678,7 +678,8 @@ test_expect_success 'default ref format' '
> >               sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
> >               git init refformat
> >       ) &&
> > -     git version --build-options | sed -ne "s/^default-ref-storage-for=
mat: //p" >expect &&
> > +     git version --build-options >build-options &&
> > +     sed -ne "s/^default-ref-storage-format: //p" build-options >expec=
t &&
> >       git -C refformat rev-parse --show-ref-storage-format >actual &&
> >       test_cmp expect actual
> >  '
>
> The changes look good to me though. Thanks!
>
> Patrick

Hi Patrick,

Thank you for reviewing! Good catch=E2=80=94I've removed the empty line in =
the
commit message and submitted the updated version.

Best regards,
Srujith
