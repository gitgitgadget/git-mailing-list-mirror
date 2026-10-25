Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792956095;
	b=fm5VezYrCi8t3OUyD4NPljoPo8IIaFwe32tDyk6854A7v4MnAJ6edGFzIXz8dHi9wUag
	 hv7T6ETYWiHTOz2dqGtOTKCLu2wTs1DBaQWhtiHNhJbxt8tZ6uUrh9/R3IDrqatvaRyIU
	 KYsTmq0Bb2voOV28pO2gDVqz006ka4uJyApNnx3Qw2nSil2fuBXXO7NkASNqLXiYGjUF+
	 9wYaP9+uVG7y972VFrQwmj8QMeY02MX9JTpDWsMCtnEFYqH4+W16LN/cH/tE45gYb+jRZ
	 8Dp5foHGJUs3AnliWh95awrCBqj+4MxUt0txJMReHj6j1WXkN/jahthUM6pUMICobSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=emZtwO485J7rzoh/dWCT6TiXq/jXS2TcsSGdVcCIt1M=;
	b=xM9EjsiwpGno0jzGP0APxSl31DZm8oj6pmcuUhPeeUskmU6x28dhFPHhs+I5sSpniCel
	 XQUeK3tevfGwliTNecOLJAheKgUhDZlFulCOcmp3JUGa6gJXMoeVb/ca/44WKiFZ7SZBu
	 /dGFGGSWLwnfrGafDU96ZIRAQdLZEabRk20WMosrV1BDTJSovDfLJad3R2D8n5HhIaE8E
	 K5hGFy3pI5D6oC57Y5wOSRzjRHf7NdT5Jkqj+IurG4WsdB91yrjL6N7Aa0k0nck2TnH/d
	 5h/7yFdKH2WoOl5zQQruGeGR1MDvtrHR5Kp2DdMJC2GemT+arxyY+hVZ0gSeOp6uiQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WJ54j39w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B756606A337
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 19:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B756606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WJ54j39w
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91b52ba422cso12582006d6.2
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 12:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792956094; cv=none;
        d=google.com; s=arc-20260327;
        b=juJzOO4VD5VawbAD0A6VmYaUHJXV+Em7b1H96lm0UY/cfHgjOekQ7YaEeJn0/Gqr1I
         tCyAxh7j4RFRIhe+WzujWrgKXOeLV25Jy9/0pC170+v1xsKFqbK0gCexELOjgOGkw5Vt
         uQlU82HcKdoQRD+06ngfLlsU8nTTaYgll02U+KnXbiy8ypaxrSvI1DxtNv4BAAaAgSV+
         SBOOvtrLHE5uf+5WeBASaKKvvTui5FpUA1USkqJuXgN4vS1iEtMFLJYS7pc5aFYvAWJW
         iZH6jfMy7ukuj4C0M3Mmb2D7y0OLma8VZykwX6EncSQSTVcX4U5rMo4roZlwp8HibR/M
         I7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=emZtwO485J7rzoh/dWCT6TiXq/jXS2TcsSGdVcCIt1M=;
        fh=qMHex34x6xqwhuT7nogLIlqEZK6/+kUudzN6D/NKExE=;
        b=NZgs4JXukcQ17lSZ4OPxhDxaH0xXwnVQmwVwnhMP20WPI3fS2AX/llbyap3csF/i/6
         RBfUxrAlvh8jhjwzk0zOLRUvQcP28VWQBzoph/pd2wGcWHMzPH8iO55EfRhke6cjN3RO
         trp/p+Rtp54OKdKpa60taDNOizvMe4kNqTno6BUEwNczO5GJlZYMUdt4/07Q6jkic3tP
         vIwxlxzntoqFf7Zf+hxgXFvhanL9xIBftQc4Gjgtwv6DxaxkPQlJOjJUD4ex+p0uJBrQ
         DfnEfgnyvIJqbzKcP9/biTSTfA6n2FO79dqCAwTGmD4qC0UauRbuXmqO1lICrhrPgJc5
         Ob0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792956094; x=1793560894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=emZtwO485J7rzoh/dWCT6TiXq/jXS2TcsSGdVcCIt1M=;
        b=WJ54j39wKAGoSX+FkIHArk2o0WgdbJJrHPb2xXIOipYsf5LSKuS20id+1mw8zuHc8H
         8FxzRzyVg5xAQySRZ2CXc04hInZghN4xWf2hN+tjnNInc2lIokPSaR9Y7sFL6nnZfY9E
         iAsM54ONxPYI3V+HwbJL4b/+QImk5D55oaRwfr9+a9NNOQx0ptRqtgv28VLK5mopptK5
         ahoW+5r8XHPWNZZu6mqanpTKpM4S9Zd1eo4vXPudCnWwhcjjVLdkR2ST9yOguo8xdxcg
         BEhtFBVD81gLSJdEXPcmS7RycNhPOEIqoKqHu4zOgQwd1m8LudtmPmMrTFdahqzZ+ko9
         RVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792956094; x=1793560894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=emZtwO485J7rzoh/dWCT6TiXq/jXS2TcsSGdVcCIt1M=;
        b=2eDo0KX56DS0GtnukaW8sq0mqucVsOiiAoG5gFjGnnQcPJnyxVC1vP9ON8WW0OubUH
         6LKcd1cLAVZ/RCa61DSGIuVJc/khAVpqYgtdfqTF0qeM4BH1AEnq78B26v4QVS4zV+Nx
         1OvHfw3nTm0Qsw0ix7HdkwIyCbDTVMeu8LGzvA079q4euhlhZ7jn3PrgvKpTZJfUZjco
         JG12Bw7/Y2quCPs1B3UMWk2rbTAOykGsgiyfq/dDclnnxsRsRkHFRzZRCYpzN6CNcFEy
         N/mIXI+ytPpe4k/Q+RLnaZMj03npw4artccBG/iJoTEjFZMRC6l3Mhqm+hIeVKdrGkXd
         5kXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwMh3v7kxQPBassIrvp0vPcHoFT+rMhpxy5OxBKegkwWBB/z+1oQSZJ/hqMQfEmmY6O4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyeVYZfvjyKOjJeZDKVAwiWvqq8QjE3tMRHYAz08THguJolP5F
	AU31FkQLIL+UzBVwMC6T2MRahhMNWBNfUJSG5v8XM8MLBcMEEWWcM4cj7DxhXTVV3ao35qNMhzv
	9QR9Za/OhLO7soYMmfePJENZpRajSi3U=
X-Gm-Gg: AYBFou0VtmvA0yWQ2ZRaz5hTk4o3bshcMeOU8g5U8CT1+DkbfLLQyHh4F7Xi9w1QeKF
	a3+zezRVeSWSNUP8bibq8RucOqIjvL7jHJjMnwdoaPdjLLWepIMT+EiD3nVIEoetxNtQ9eDAo+s
	bO9HpnKnu8lTMmFTkZRm4OVnrc+gE+gY4Cq1/z+qsGftANVkqIrcyF2PO0U3KIbgCfDsr1ATWQ9
	ZzBCoV8ajqEwrMSgOkdfjjW7h4EY49CWjmSBzeliGqRTAoa9wNa0sNzxZks5TdXrYdegI/aI4pt
	k+331Kb/OWDFpnktZLt7SqE6JZnbXZM6j/x0SLxvgGLDAB/H9XZ03g1fQ0OiNCaj3oOHGxF8mSc
	2hqPD6tPoSyXL7bLdy3ZrXPX4ND6s7pXmz/R3nr7kn4fvo1uyDMKr1hkG/NRSGYJxYixfHYOGDe
	cx0BEvr8fnpMi8J4oC07Rr9+jHJG13g3WeffAlCd7gOXjzTG9qokWFjq/P
X-Received: by 2002:a05:6214:2404:b0:91b:ec1d:173b with SMTP id
 6a1803df08f44-91c48ef96bdmr75465386d6.43.1792956093963; Sun, 25 Oct 2026
 12:21:33 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
 <pull.2276.v3.git.1792813697888.gitgitgadget@gmail.com> <xmqqfqxv13d6.fsf@gitster.g>
 <CABh_KWhDcPM6rJROmVd7_oGZ7i3tmX5da-DZX=KJmvSyCxNH_A@mail.gmail.com> <xmqqmrs1y7kj.fsf@gitster.g>
In-Reply-To: <xmqqmrs1y7kj.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Mon, 26 Oct 2026 00:51:22 +0530
X-Gm-Features: AclHuK_KIJaoXYaHmBZEcVfcA2nyP001G2coXV3VvYRR5-bkCHJ_vXhYXGFuGls
Message-ID: <CABh_KWhE1eWYt60TvcN_7sAe6ORut2YH7a5Zmu2zLobv=VSefg@mail.gmail.com>
Subject: Re: [PATCH v3] diff-delta: use safe integer arithmetic
To: Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 11:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Srujith Poojary <poojarysrujith@gmail.com> writes:
>
> > Thank you for the detailed correction.
> >
> > I have expanded the commit message to include the step-by-step
> > breakdown for both the unpacked and packed index allocations,
> > detailing the caps on hsize (2^26) and entries (2^28) alongside struct
> > padding on 32-bit systems. I also corrected the phrasing regarding
> > (hsize + 1) being passed as an argument to st_add3().
>
> It seems that the text of v4 did not "detail" anything like that;
> you just parroted the conclusion, the final numbers I gave you,
> without giving any hint for the readers to validate the math.  The
> readers who are interested in validating are forced to figure out
> how many bytes your calculation assumes each struct type involved
> consume---and if they find that your conclusion is wrong, they have
> no clue where in your computation things went wrong.
>
Hi Junio,

Thank you for pointing that out. You are completely right=E2=80=94I should
have explicitly detailed the struct sizes and exact code bounds
instead of quoting summary numbers.

I have updated the commit message in v5 to explicitly state:
- The byte sizes of each struct on 32-bit platforms (12/16 bytes for
unpacked_index_entry, 4 bytes for hash pointers).
- The exact origin of the bounds from code: entries capped by
(0xffffffu / RABIN_WINDOW =3D 1,048,575) and hsize capped at 1,048,576.
- Why st_mult/st_add/st_add3 are used to guard against size_t wrap-around.

Best regards,
Srujith
