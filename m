Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795588535;
	b=Y7vUfQGbXd1JKPuCdqNmVvXeCB5ReTAWkVNnYc5mOnZYblko0i49tlw89eTXrhR8Co8F
	 TJyRVMrDX06AUNh8A2oeBMkLJsrhpd1/FylkzKd7DRNMOFQpiKveFxP5A5KQCReBfdlN+
	 h9SH9vrIUNs5Go3VEHhlT027e69pQgNsR9D2Ojz3vBks2m4ZfcLYwgfPKxP3YMi28KFvg
	 EW7nOJSMZa8Fa+N0IooGZ9nEDTbTt0PV3dL3GMUI9C0zZmFgMzLP+VYkdADdbopH7/QGh
	 tlyj4sTWlz3A+BxqvjfAbjwQY2h4c3AkJir+FzhxUVOw/tX2U7zqWOmh4tHWi2PPV0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=n4KjlkMMXWspwk7NRasp6cVUfpohTxDpoq0IcxzLtHg=;
	b=syQtU+M7VpKNqJLJX+rYvHXEbHv8JxaN8CPFWaerPU+D4PM+kVoWGAOZlXbRFet9YkXT
	 8Wza2YlVAiJTpqvnIuQtATE8d7YJ48RFx79BSPrCt83MsRe1suHwJUYsKygO3QCc4uF34
	 Mauhho2OA5dIitvmhh8pTfTtrqOYrJbTjtE6zyUGY3HDROrvofzDevfWBUO/PMFXcaCWT
	 RNpe0+8FupwibaxZQ9h/doXRq5eFmGx5qLqcEP17FtK4/+ka8seZXKMx0/cCKK6RuzAUH
	 zyoHJNhah26L49IulA00ynGZldTkLVxJiDGQGzfVtl89vnaGbEIQzvBs/p+LLwwZwyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FmflrE7E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F9606A329
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 06:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B2F9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FmflrE7E
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67db8985419so6702254d50.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:35:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795588534; cv=none;
        d=google.com; s=arc-20260327;
        b=C5Qg6tk/HrMZCQ7ssjML3DZhJJFq7EJmmeh8m1WpH3ARdsucAbqjFYzcbSIFiUx5K4
         K2y+U0crSSCV988Pae3d6Dkq+AfrVb1a2AZ4vNH3XBLLMJd4DSdTH6jFJZV3CAWPn5sm
         GfqRWPAjg78aYA76ks/b1J9I0ek1vz+x7ixaBGOatF20jOiJv4vxBLRP1N40JskI9IPW
         9QKlg0GZcsmtZqgRreljjfCCQ4HqYPw2c5RsHUTerxq/QeQKf122MinPbX02KFx1QV3v
         Qgvc1p1u5D+2XpEoX6TYBe+R+V1uYQXJfabkaLADb4ERjlo3dksPqMHX9On7D7d5ns1q
         uBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n4KjlkMMXWspwk7NRasp6cVUfpohTxDpoq0IcxzLtHg=;
        fh=zEQd+5l/OBjEyzF6GIR9zxz6BTrbCyvCTKJbHzWgHEc=;
        b=NVf0BImeL4tRWjzRvh1xY0f14IyPJLfMdYeh4cBF5TJaZm6sim/m6ix9vhm7xX0/hF
         ZJJUuGLnL/KvTEUN6L+/qzofpsoXy3Y3Hui5cX621kz3cQKF5hRfcsC527wILk4zXk1g
         0haYagRV1YbKh5dg4Q1j8oBri/hBYL2LDTDV9DD3kDnTvH73ao5KyqwMZpOtcjhPCogZ
         P1vLaVCvBiLOlzd8DZ9ysME1dRhRlIy1k/h/2gWTaHzGkBcRFCd/8RDviFJQJH59WEuw
         OG8vyZcZk0w5RFN1EESvEq4eOxobsGK9yA6MtClPPUUp+tSQZ2AO/g8iNY3qHwD2RBjU
         7PRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795588534; x=1796193334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n4KjlkMMXWspwk7NRasp6cVUfpohTxDpoq0IcxzLtHg=;
        b=FmflrE7Ex7/V/v/CSs4xeBG6LT2RyIGPjdF2saqR0dtSyCsoK3CugqE4CbxPOVVkzT
         DQ3SRA0Tqcm4xMraeCycRyCa+EJkahfvBsAlEuBBrkH7AL8LnuS5a8FdUu+oUY3m3EhQ
         jlY+fO3S4jFnQ3pwNoSHakwBCzQGv+LpfBFlpU8itCrytujjDnDu9mKqQ8lljwWW/ssw
         Re7pF07gEb0OzN+0eFcKnIRDtG1E4QHeF07iNreAsWZ5alwdJkNZn96Zq6fsCyQreo0+
         rsCKGaO4Sgcw7kl/idYMeTNgL561JdrBwzodtjAIHYkRtrEljcEqPig9RNrunPS6aGUU
         7Z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795588534; x=1796193334;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4KjlkMMXWspwk7NRasp6cVUfpohTxDpoq0IcxzLtHg=;
        b=OQ8kp8LaQWFKgp3Ux7x0e6ZP7AmJOAnyHQR1WQH34O2gHwdCAkTTlZsfl38BLFiSVw
         Q8Rzp/n9VYfLXbCdTI4dneu/o8zBCYFtcDsK137lwUhoqUuAfpRmbSMGJD66rXrFeacv
         aLIm9BxzSidZOPUy653zkSOqUT3OrH9pEG5lgs2Mw3eBrjFlihHp48pQagOUYAB2+T89
         woC4vcnEHvka2vE83/JuAwGT02Jdh8C+noHSd0fOyrKd6zGJAxhWEvsHitAhe3Afzenl
         cRi+HtRVVBnmsM0MfXcP2g6Yf0qkT9IFdWcSYAnOMkbgfgcX/kPaCrDdiGM3FvRm5AgB
         mqsg==
X-Gm-Message-State: APuU4Z9Lv4TtRPW4pVYDQvRX4oqSYWPqA/rmQNE7WWgkSWqpBI0lUnIl
	cXTArmaRQVF8LPgbZAczS5da9TUb0zdceLwjHsp7nlPwqj0Q+0fXlEYLWk+pULpp3Jo5kltESTB
	VUT/a/7m8f9mh0QLGzHDcoBFrIJh0wok=
X-Gm-Gg: AZFdTZcRs8loQMx1SMAWFojOB9s4WeszMhGXuBiSFDBKSmDhzH36teas1KbHSQo1rWY
	4QkcmYbt3eg+df1trU3rlSPwxOigV/eQdpm18n6bUXRJepg8cX8hpzb6qSIpK7kjFSqUsBRM7mn
	nX7bhi6hEjw3vSjsiboE7mKsdhsliJmZAfiVXHmVMkieMC2cUXb99Q51UzXz+/k1mDSRE0vi8qG
	50IIfRPdiZ+ilWeq/dQy0+PZSQHzzVZLYTZnqNTmJPCluG2bcah/w6w5+h+ccWTiZ4gYqRzSq1S
	43rG9QrPyrD/OZwV4aIJCzz3LvMfAp+8Ho32/3lBe2N5DlcVrX4ZveKuSjkztd7d4pufpMahlwe
	Pvp9o6Dovv9z7dXHzkL/4OpMbp1VhckykpjmaPkVDnk3J+f3eFFZra2CbNkX9M5mf/YRMR68LTo
	iNBmDV1IiKLmsYkehYdleOdSTkSwNNHbLizzMlsHcaK1PGr/NL5iDH57La2Qro23jOhYkhg4Bn2
	zJktcZ7dcED1XwsjvwAgFbysqsBPOBPYWxE8wP1K5BeK+8YVaEMtXz8T6TOBA==
X-Received: by 2002:a53:ea88:0:b0:67c:ffe:aa06 with SMTP id
 956f58d0204a3-67df446dfa2mr5909139d50.55.1795588534136; Tue, 24 Nov 2026
 22:35:34 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261124172146.18330-1-okhuomonajayi54@gmail.com> <xmqqld6hg1b9.fsf@gitster.g>
In-Reply-To: <xmqqld6hg1b9.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 25 Nov 2026 07:35:23 +0100
X-Gm-Features: Aa3M54rdWOBEl_bkBVe_Q1Gc0pIyZI_o8jokIiMriu8-1FgFRAhG6tiJH9f9_pw
Message-ID: <CAFpMFfAwJC8sH3Rx4Qmmr3XTM8sLmwJm6Lsx9mmtEZLLap_5Rw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] notes: start passing the repository through notes.[ch]
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 11:50 PM Junio C Hamano <gitster@pobox.com> wrote:
> It seems taht notes-cache.c also still uses the_repository in
> notes_cache_match_validity(), notes_cache_write(), notes_cache_get(),
> and notes_cache_put(), even though notes_cache_init() now passes its
> repository parameter to notes_tree_init().

Those four do still read the_repository there, even though
notes_cache_init() now has the repository to hand down. I kept them out
to hold this series to notes.[c,h], but they are the natural next step,
so I will list them in the cover letter under what is left rather than
pull them in here. The copy_note() NULL handling I will sort out in 3/5.

Okhuomon

On Wed, Nov 25, 2026 at 2:14=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > This is a preparatory series. It makes the code in notes.[c,h] and its
> > direct callers work on the repository stored in struct notes_tree inste=
ad
> > of the_repository. It deliberately does not convert the whole notes
> > subsystem yet; it does the bulk of the work in notes.[c,h] and leaves t=
he
> > rest for future series.
>
> Framing this as a preparatory series and splitting out the remaining
> work makes the scope very clear.
>
> > What is left for future series:
> >  - notes.c: the display-notes code keeps its state in globals, and log,
> >    format-patch, diff-tree and format-rev are given a repository but do
> >    not pass it on. format_note() still falls back to the global
> >    default_notes_tree, and expand_loose_notes_ref() only takes a strbuf=
.
> >    The hash-size helpers are also still on the global.
> >  - notes-utils.[c,h]: still use the_repository. And the hash-size helpe=
rs
> >    still on the global are reached from here, through create_notes_comm=
it()
> >    -> write_notes_tree(), so converting notes-utils is tied to converti=
ng
> >    those helpers too.
> >  - notes-merge.[c,h]: still work on the global repository.
>
> It seems taht notes-cache.c also still uses the_repository in
> notes_cache_match_validity(), notes_cache_write(), notes_cache_get(),
> and notes_cache_put(), even though notes_cache_init() now passes its
> repository parameter to notes_tree_init().
>
> Apart from the NULL check needed in copy_note() on patch 3, the series
> looks in good shape.
>
