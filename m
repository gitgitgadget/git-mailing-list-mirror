Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793674474;
	b=jEeAMABkBRFidCqGHndxorhOhmkUxP8NWb++hes9nqaSt5qntW+4cI+GecwFBqB3eHXP
	 iyhpXNB/vMjhHdBjGdnXW4oxfuHzy9dbkKPifYZdBHw3Ys9yPuO617TCpjM4XmPt068kQ
	 JH+4i/zAOYV1z7WGSuNByHZ+wFuAbMbLVfu8JNH77KZ3ge9m0IsJpLSSr2piSaKKd+EHo
	 C+zkaPVcuD7cshrbh9+vIjDPl15T2hLH8ZSpMTqNOaBIRPVrk08ldWx18/l6OywQ5aCbr
	 gHIuOZ9gGITb7dv/0DcVf1ca4GEujW7yBff9TO6tSH8kkwUoO7HDPZCZZEr+IeT/lCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Xtop4pxLVrYJA+tp7+HwGYaPCIGd4wH4jyO2UR3VJo4=;
	b=1OsNhUfSA5fejrSNC6ajMxtsmU63Wihzculnot8Fh2AukCQIyowkbbu7WM5E35O6LCrC
	 QkogF2OxlpXWhDTOPAVcOgdm59u7g6yKlMvuOisz+aHgi0YHkSFU6EzMVr9UVBcdORMsK
	 scNHg0/d1e6X/BtNiUuu1dS+7o0h6lpbPQfW/sk9ASmQGij36FgBTg2uPRO11wmQuUVyg
	 +L5Wbyn6hAvHNrXPLQ8vSyrlpMOyb6MOzzsLQHXFzpInt134ChenzDzD889I/nZVMjpMK
	 zo/Kal52pYxpmIiL/qJeJAIonswbDsk0TmzG5eXjKW8v8wneK48N8OriGBUufG9k1dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=icHVGxU4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0580606A32F
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 02:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0580606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=icHVGxU4
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-49ddddefadbso1682118fac.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 18:54:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793674473; cv=none;
        d=google.com; s=arc-20260327;
        b=oFl6dx23Kd/UjvnuY5aIfibwT3M1l1xk2xV/U3DH4zq/pX8yAXtx7M8apEYrh1jDys
         7T0QfmIwFD6buDd2XMlCEJr+IEimg/LLpHfZ35i83OavF4PFiQhPQVyjQq0E8O37J/rj
         yhRmRE1ld0AnF2nftEFCzD1fIuwyHkT2Cbc+ZjjEBGTxmyP7RKXAY0y8RVlgMhjj1h/Z
         /5Gn3RA/MvsbXI3KKa73RcMwSq+bj1Ci4dCmYEQhWzSB3CKKkqVSsz+NYN4kAtc/SC1S
         wiECfnEZbPA91/NnBsHSt5YsCPFdwjI6q7wMDJsECvFM3oEs2qTPx2gzsS64MpfiV39h
         nrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xtop4pxLVrYJA+tp7+HwGYaPCIGd4wH4jyO2UR3VJo4=;
        fh=mv5zqN92u4yGkXYcJT4eDsfhsA+TdzFjZ8yY/QsyRCY=;
        b=KVsfwSV3YFkuxAfG087EkxiUt/wUvP66TAFbrY621vSL67BEynD1BeJAOZuTiuc8Vo
         udlGu4uv2PqZvo8rZcqUW6rO3w8yY6700Nykh5YRWiEkSfe7RbdzlxSwqqfczznHa+BA
         wCVxdSwE7qpXFkIl7IKAFoMDkmrx4OqkvlOx6mtwghsEgZWc7wB6+bAfvycV4LQck5jg
         H11b6mkjIbLf6ghWqtDzLv147Z3N2x84/mr2XLVzGtW2DVpoa1cgQ/3Dy0zZVPpFIkq/
         cl5s0yUlWQ9IrFV5Jc3FEM/4qjjkWZgnlXU7o/QVtjOyE6NIeKSjwufoi7E+rxT5R+jg
         D+xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674473; x=1794279273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xtop4pxLVrYJA+tp7+HwGYaPCIGd4wH4jyO2UR3VJo4=;
        b=icHVGxU4cAuqNBsBAXv7ptmxOzdU0DTRJ83AhV4loURwAjR3OthjELeWZ6padAvdAV
         RylUOxicNelGugAQNRflU1WVIR42OAijQfiKtceJd05OgFOGvaYdD8EZabFNZC5tDRYr
         DE/7Dk+RXFJMsaA+hgLEEGSBMjBvnHVM85UnL8FDSwXORpY9htV8ruVkKFBKbtAahTXE
         i3qYHT/OuMpxIgiNqqTEy10JOfSsOYJ/6Q4juh+goJS3xHYkAoDjyqTiyJS6kzB/o1ds
         mt4OsvD6CtIeCuMurEHGwm83nYyjOBUyR5BCixf7wXQ8JqluJTQYV8KhGIpMHuupSmDQ
         st/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674473; x=1794279273;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xtop4pxLVrYJA+tp7+HwGYaPCIGd4wH4jyO2UR3VJo4=;
        b=nmcEbvdcP9fvLlr0qsI0M/9GHGW6AVtDpYeSW7WZYae5E1dVFWOHGAxbqG/h0BbrrZ
         r4h4W3jsNkE3w+Atv/3xN892tY0A6XJUN0bjZ6eHfqCKyFwdydXY8AsO904/bCqM7ZS6
         qGKlGm0syDD7dmnV//8Uvn8SnJPc0rTwVJ3KsbE0VBZL3yKwBHo+kYnT4MzUZ6zj+8Y7
         9kWdSXWeh9rg2vjR20XSCdbeCmctY20CRdMBPtx0Sxva7scSmvym6m1onzFQ8Ew+sE4l
         LV382i111iAdXaDCyTCFDNGeIAtedIUugVrt2VJkVyipdqH/UTxmZiAf31Jqg5amZ5xn
         CqtA==
X-Gm-Message-State: AFq9FYIveYF23E7gQCsNuEM28HJgiU5th8cFcf/7gMLMrhVFgQzg8bnV
	p5FJHQXtFz/7H3JZZHc/qpiYmiv3T7hc2IRPIq0Kvze7COMH7Un9O98zdv1+gta/GmQScwcPjm5
	1jVBPTruteCFr1Dpjao8OTvFJhYx613g=
X-Gm-Gg: AYBFou1uIXd9eZplYWdLDaOlJWQ8O1utFFswKVVp9HgBXfstE9hWopLtVTf43PNENR3
	TXGmW3ZEbOFb4ErZua8KL8zXqTRDKEVO36J6CtuTlFRkRVMPwbwRXFfxj6bLsyC8pvbIf2urojc
	hJcJq6nNtbdMsONsBYSwdI0nIPMX0kGR+IsZGVMz/l7YjswjD0PGLtkSwSNgo1tRhmg7tUHS+Y0
	6vIZc7NENayzH3IognScUeZOsgoqQacNN3ERT6V208JEM9ZTHqB0MgNpM/g+H9wmCozxo3O0ZAj
	oHe4uMHbPica3iiyZVb1IUqnwzZx0W09TxGymjB7FUDeDil5V3UrjFerrDIrEN8XUzbhLFf33Ki
	66UnAgAhn9fga11JJ5ZM6Xm3QKgsMzpZUjqhCLP+SSZJuKPbRIa2BEyppV5Jt5ntT3FjzBo5k92
	z18tfxCfAYXUN1UcfQo6lWOHMdD29zAHuN8fUBe8lrfhWkSARRm5mRph4g
X-Received: by 2002:a05:6870:2886:b0:4a2:4c6c:c9bc with SMTP id
 586e51a60fabf-4a90765f8b5mr8282455fac.19.1793674472796; Mon, 02 Nov 2026
 18:54:32 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-9-jayatheerthkulkarni2005@gmail.com> <aukYVs2nVla0yuSV@denethor>
In-Reply-To: <aukYVs2nVla0yuSV@denethor>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 3 Nov 2026 08:24:21 +0530
X-Gm-Features: AclHuK9zPD3veAyKzm1_zyqv_ddvlDBzoYXFcvReG0R3DAMCZ5CL9_E3GIsgQWc
Message-ID: <CA+rGoLd7=sx61dWcC6RFD-Q-88KNd9YgEES-jLDqiTmKMMLf9g@mail.gmail.com>
Subject: Re: [GSoC Patch v7 8/8] repo: add path.cdup
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 4:50=E2=80=AFAM Justin Tobler <jltobler@gmail.com> w=
rote:
>
> On 26/09/27 05:14PM, K Jayatheerth wrote:
> [snip]
> > +static int get_path_cdup(struct repository *repo, struct strbuf *buf)
> > +{
> > +     const char *pfx =3D repo->prefix;
> > +
> > +     if (!is_inside_work_tree(repo)) {
> > +             const char *worktree =3D repo_get_work_tree(repo);
> > +
> > +             if (worktree) {
> > +                     strbuf_addstr(buf, worktree);
> > +             }
>
> nit: The curly braces on a single line if statement are not needed.
>
> Also, should we just return early if we are not inside a worktree?
>

We should just return early. You are right.
I will do that.

> > +     }
> > +
> > +     while (pfx) {
> > +             pfx =3D strchr(pfx, '/');
> > +             if (pfx) {
> > +                     pfx++;
> > +                     strbuf_addstr(buf, "../");
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> [snip]
> > +test_expect_success 'path.cdup cwd outside the working tree' '
> > +     test_when_finished "rm -rf repo" &&
> > +     mkdir -p repo/tmp/x &&
> > +     cd repo &&
>
> This cd isn't in a subshell, so it changes the working directory for
> every following test, which I don't think was intended.
>

Oh whoops, that wasn't intended.
Yeah this clearly just cds into non test env altering common files.

Will fix it.

> > +     git init test &&
> > +     (
> > +             echo path.cdup=3D$(pwd)/tmp/x >./test/expect &&
> > +             cd test &&
> > +             GIT_WORK_TREE=3D../tmp/x &&
> > +             export GIT_WORK_TREE &&
> > +             GIT_DIR=3D$(pwd)/.git &&
> > +             export GIT_DIR &&
> > +             git repo info path.cdup >actual &&
> > +             test_cmp expect actual
> > +     )
>
> -Justin

Thank you for the review!

- K Jayatheerth
