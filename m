Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709690;
	b=WobHyE+J0iUYC+JmM4V60pOnJ9voq5Nm8oPJDZOp3IqYh4qU7+xDPADw3+C0Yv05vpcL
	 qYYJaOSLDPn4sNt+MaaI3VuPXD92Wt0+1Id9zndSK3zxG7Do2+a+lMdjJvKeXa2rgQWnD
	 6VPYLCHMEQrRTmX+Vr9ARQNaf37L780PJhEKoJaS9J6TqcdX/cmKGZ+oDj3AiVLojJPfN
	 CuyR1arCh84OwmoL1iArsqUtrci6CE3xUJ3yeQNytgJUIFGSrUiuBNUk1r1IUTRv1py+0
	 5ULUvE+vZ+cFYRPOPa/Iw8pk7uI5n2jGEjfWlUM0oH+7voTkPhcOBjxhvtUldz2FBFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=cTOIkxhEwG7sAL9ywHTrj1+NZZTW90Pf5ujz+eQhMPo=;
	b=X0yfFpTxP9JXYxtnQTqCg6KkZ2q5i/zT5i3NWoDYA6AICzVdHFaNk2D6JP7odlnSNI0k
	 xu5WRY0y5orTVZSbRGSo1J2cSexeXbXddkdxKj8dCOmKDkwhQ3eCnE0zTXOaGPYsFuoG3
	 f1JtHv1ljt9qzcG0OlrqzYjw2QkKce9JIRGWV+BX0BfZ9jSSIc3K3UIXXFtMuteby1oMR
	 J/0QjPDFH8oykevNWYET7RHONNbPw0pf3r9ib7tLt0/BxPiLqbE6WDgzKE2sWEpX3OsiX
	 0eZwYwNHgWtn8qAeyRh46S9kEEqoIS6dSQBdH5Ip+IXpljSyL2Wj19SiU+EkLdRm5TA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uGrElGNv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF02606A327
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BF02606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uGrElGNv
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-14fc585291cso3234602c88.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 04:41:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793709690; cv=none;
        d=google.com; s=arc-20260327;
        b=UCWgbTSB84u2bVert92bq6cINKOKD1n6AWSDyy6X0iOvP2tZOoPa7Pp//2PYHaoRyJ
         jcgBFVlxOlEPqzsSx7zRAyulBdqU+OxTC9aiuBaeIMnojdISV8XAYa6trl3iVaoKM/TC
         h2qjC5aw3I2+Q85Xu/MypXfiBRZl8Tt2hF0ryht2iya/5LylNsD7Krw+e0VDsJIKXm5a
         ojXk6Op0wZYU0TCcSVV/ucYNAlVFUeSJ4K9ybf/Gu0pRlj2aQtLbh0TPB/PXX2SvESqg
         qQyVeT48Qsl+NXvEntJql81x/kJj5G2xJu81JOgVlqUhNDf57Z14Lg6gdsmD/1nVGdCW
         UXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTOIkxhEwG7sAL9ywHTrj1+NZZTW90Pf5ujz+eQhMPo=;
        fh=rkAHztmZN93LcLjDXebhO72ditiWDqveITA4irEn0Qg=;
        b=Hw8Z+alohJytKwiJ5Fe3NNXG2ZuOX6TLl6xG0MaMZJV0wdEZK+8MrZGUH9r6kErpPd
         p8nVvS5ZQhSf1Df8QSfAopNFWVUzmeLZXJvGY7XVdfs3tjO6PJ9LHywkpbHFEX71+cFk
         ANtcUDZEmtSnaVszHNl5UNVnZp7LDwt8H4rINBVGN3iXu4PeScxZvSTYPkK0Q+ixwCZ9
         j622SyoSfsgDFROuzw40vIQBow2nWzZ3490aec/0mbznJFHQKDWKKHQnyZ/0sIohLQ2G
         YT6h1kKcvblOUKuFTgPlBOJVjmPPwQBhMN3YzxZKljpyw1Py+hF6m3QEjE5O8OSQBrgC
         ho7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793709690; x=1794314490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cTOIkxhEwG7sAL9ywHTrj1+NZZTW90Pf5ujz+eQhMPo=;
        b=uGrElGNvVn5PAIqvZuYbEXL3G6PiODzVK3JTssy3MMhi0gBBaPURIB5zVEnONptRNr
         EtIXEcGrgU/bDF50GC8v9ukvfK4bVEmF90lZ8Lrrh6wMIzwEdu6SS4iVpImiunP+R6bm
         FpgM7Fb5sgsdbWu7dAaMMQDEcjCQ4Gv7dcvWE02RvDPtrcHcbEx9OnxqqCvpDKKCDuNE
         SXXNdEDiLZTXCJwhiKR6RiKD5vSiWpMtn49swRhrPa50RsrXwLejgIjh2Pt3vUGw6IaB
         PKj3uTXHnjSX930w1sXhuYeixG+JMc+xPpxmcVHe6BfvRErcqW+OWpcOLOQXEDqYSt/T
         Ugeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709690; x=1794314490;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cTOIkxhEwG7sAL9ywHTrj1+NZZTW90Pf5ujz+eQhMPo=;
        b=YBx2fmoMkHD63d9osJsYYpIs8K/mBpUTr2jOxpHY80kkI2qyyi7cIycVESQc7+0n9e
         v6zhYNuwzvuc2kTbig/3cmTsu5Yc3zy1pwSnXgqkO4WefxFoh80EJmx2t0SY/u0j+zrb
         C4asrrlg1aNqBkQ4K7ZQst5BJv7J8mUcSxxOH1+DjC4CPZqQogvnQkOqwLaZudNRq68t
         jI0OZCbs12mN+IHqvFMeZnWPRlAVugR9RpB7aXtJb4WImS33pzyKgRcFQ5HmAjQby87E
         nSWMZAmBYU1eGIDAaj5/YLTWzfhC3MmXD14YCOQQuyNeYmZBhBF0Y7QyuhBX0/tT94x4
         FjoA==
X-Gm-Message-State: APuU4Z8+QMFE2Wj+MjJFvQu1IzdUO+OIpi74CpZuWIzTqbmUzHtMWL3x
	WvYco0lf+3IeYDKKpB7KrKVw+Xjb/KvKRjjye7DEZJt1F4AjgPOBq3I2fB748MPSqa6D6RNxe6I
	Z2O3ryfOHfTLliAB5efIQY7XNc5ZwkEo=
X-Gm-Gg: AYBFou1B0pJA4/9FbLtET/uJVYWiERBdaOEo1HjZmuKFnhnptE/YgT3rekBJ4pGU5PW
	Ugzt+htq1SqbGsVXBAwG5G+JfHIvq9mo0XAz2vFoZXfPpKQAUVYtNmbz2uuyE0LQrziPl/8jF4x
	k6iBQcWw5B7hTlWKgl41ZfPafUPYD2YP8RkidsEmBSE0GMQeZ1YxHDirrQHrjYmr6S20ktfbDeY
	n63Xb7jOoLsFlz5dChSsOxiVDoRemtCDMFSBszu7xQi53IA12zyjK4FzIOFbsfvgVfMVeI/MDE4
	DnXuI5jmXTAA+8Z//AlvFlWVZH0BsN21tGu2yBSNQBl2xItaXvz3OWnMgb6clAqokf0VDLACRmK
	9My2WL7hNTxX0jVSpAy32Ow0RmLL/NJihWRp2q3u94FvK+Wy8C12w4+fBdVXMNu+bbQ+xBTQl3j
	DsjDfVM38IaoxOA0WJ4SegT/YiacZqwgp2azGGE/461py0y1aAKVQF1RmXa/5+4A5BC7lIanryO
	FoDN1P5nc1Ntune2xuTneKb
X-Received: by 2002:a05:701b:240f:b0:199:e38c:29a0 with SMTP id
 a92af1059eb24-1ac5de53bd3mr18522345c88.31.1793709689572; Tue, 03 Nov 2026
 04:41:29 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022105641.68963-1-okhuomonajayi54@gmail.com>
 <20261023211533.73433-1-okhuomonajayi54@gmail.com> <20261023211533.73433-2-okhuomonajayi54@gmail.com>
In-Reply-To: <20261023211533.73433-2-okhuomonajayi54@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 3 Nov 2026 13:41:18 +0100
X-Gm-Features: AclHuK8r9t6N_f3VBd_WsGAGmdz7bNYvstw3fcbDBuMU9RDcu1HD4GYhSfGGwhU
Message-ID: <CAP8UFD2_msUwNf1Opvt95jFWBoPi5H8jNCpQcH0ohYh26F4fLg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 1/2] remote: add repo_for_each_remote()
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 11:15=E2=80=AFPM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:

> -int for_each_remote(each_remote_fn fn, void *priv)
> +int repo_for_each_remote(struct repository *repo,
> +                        each_remote_fn fn, void *priv)
>  {
>         int i, result =3D 0;
> -       read_config(the_repository, 0);
> -       for (i =3D 0; i < the_repository->remote_state->remotes_nr && !re=
sult;
> +       read_config(repo, 0);
> +       for (i =3D 0; i < repo->remote_state->remotes_nr && !result;
>              i++) {
>                 struct remote *remote =3D
> -                       the_repository->remote_state->remotes[i];
> +                       repo->remote_state->remotes[i];

It looks like moving from `the_repository` to `repo` could be a good
opportunity to unwrap some lines. For example something like:

        int result =3D 0;
        read_config(repo, 0);
        for (int i =3D 0; i < repo->remote_state->remotes_nr && !result; i+=
+) {
                struct remote *remote =3D repo->remote_state->remotes[i];

keeps lines under our 80 characters limit and is a bit nicer to read.

Thanks.

>                 if (!remote)
>                         continue;
>                 result =3D fn(remote, priv);
