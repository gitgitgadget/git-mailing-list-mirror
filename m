Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0031F9BD
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731778; cv=pass; b=pyk5hsjgQNqiUTBVT5KRw/YLj5J6chf0ayMhBnc6B2NB1uwPtZk3veHPi3F/e+BzwM/l8BYBSU/i8lNkhBIclp3n/xb4m0Y6YhqWMCPD0FUy+vPZrWQcpNKIxs60HfR753lKlMjBxz/wve7d2cVgredLQPIkuHPF1BVacFbDXLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731778; c=relaxed/simple;
	bh=EeQ5MOisv1i5e51Tnw2iiFDOc6O42IruQRAtKlQRCzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WguZ8aI4LyvmuzP8hM4EzPmN/fmvv233+Si50IleMAr8VkKVSjHuJzxyySKd/deqKoRSJY5IQTbI6xZtvWFP7bRKfRwvxUEhrmFd0VeqLu2lO2j2fIXg6VmntTEp31gK9S78Tjk3hnw6DpjY/zxGkWzfgJakFxvvfKfEUmhUDIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huW8WSIx; arc=pass smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huW8WSIx"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc79a5bdf9fso771414a12.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790731777; cv=none;
        d=google.com; s=arc-20260327;
        b=doPE6UbVxwKiCqFu4SYCkSIaxtjKKSt/kyMvthNqhdHz1JcyVhrLEEtq3K0kkOmeTS
         JY7RP7t/wE57s0CtXUy72Lq1ie026zqulIg9lnZz0+Yxs3NjxkhJleZAf/N+SN0Rf/E+
         DV98Y7/wulLV1NA8I55eEh0ogZIRTn8JuOtjohxuulkZwJi3W5epO4KeH9xA0StIBzSR
         WksM+GlLQXn+EQcC9bA2pvbYzAxUd8w5d4yDAzMxeFYsMoCx0yUhk/MRnexPBQCfJJDu
         uIpfG6CFBts7Zi4nkhKWQpMec/LCe2BC8sIPBLx94Ui9Vwho0QqTn29jFR8FgzCNvu3Q
         7/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zUmKI6wfbHWFzbzIzGCVebcKfGCbHxhbEg9RJDwxaX0=;
        fh=Zn+2AI9sn2W4IvE0yL1Dj4drIrPZant+skHlz2szlPQ=;
        b=JD74vW2KGml8/+twsh/zG6o4fxsc7aiFLdBLstx0lPofejMvcjNoxm3Iu3G1gaVzjg
         1Xtn4/t9lTbmgd882uN7Sjph/3158nxkAxNVveleZdCNuntF2Juw7pc/Rio1KOjgeCXQ
         VpxJteyh6ZU9st7i5iT9OMzcMHO1z/HCBbMI4nkwjtqbNzVCUxC4nf1RkOFggOD1BXzf
         JyyJszvPMhWqms2bx4Wd+mMw1QoAjIEge6hpc7hFJCS9m25DB296dqAAlmS2Vr8H5eVc
         yCz7gGY5/fD3075TTS38H7XEBqzXBL+mM4R9la5H1cJvZyDDqT091VetQlr7SiJSvjAP
         BKtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790731777; x=1791336577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zUmKI6wfbHWFzbzIzGCVebcKfGCbHxhbEg9RJDwxaX0=;
        b=huW8WSIxTkD8HOZdhRrOUjgM5tqDlT3kGOR5lx/tD4aiiUAThHQYr+WF2CjmSPOp+4
         GG3HAnadUrq9qeHFMVRAXiPS9ya7VZIeglRk5Z4j1WtijQ8vfJtTQadvIxZ5lVyBXEip
         /0HYtOYbjCvvd3qzxEXQh0QCinkVO+s29+S2U/WnS5zYrZn1o2jZlNPeXJo74s46hnEv
         htr0ttp2UUb00cdioVT80I/9luObCZCOEgyGo7WAfKt9EH7n8Zo5aCe5Y5KQEYMLNiEA
         aMyQmlpTr/EAtruSWIHU9ZjDaefArn0IZpCTQGfaSodnUbJnMbv7DuPjg3xAHJcQER20
         UHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790731777; x=1791336577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zUmKI6wfbHWFzbzIzGCVebcKfGCbHxhbEg9RJDwxaX0=;
        b=XNUlJQcmOYYpX8bRLrf1GDWShOUX7ul0P+2O0JEXZIR448adw9DquanAKmr7m0Hx3D
         KXxlZUfJ7a3kHeDnhTxN68FEspRUJ9HQab58PSVzeiwnl30MJRJbkhDpWeH6dONVATxz
         xBHP/zoH0IaNdzn6RXSzJhGWVHCp0kzNE7TdofCXdh4hsz19sqwnhLrA0lGoNeF8i3hx
         3/2Tn3MztnogXjCTJAKvZGKVex+wR47fTbNQHSZYF8CPeNa5XAI+gFs5rdJfETA3M5+i
         SH5UGNrXD+GliQxs/p7GFOeYjSyWMxpSvOL4KeBIS1SBoInKEOwvCjD1VjanqQM2Pd0x
         GjFg==
X-Gm-Message-State: AFq9FYKnWvpt3gn+GIUj9NTHvOpvqCFAJejuj1sbrtYLarb9U+piMrms
	5WjTyyPygETuMCkGaPZ0UlvwbDD1HDlPdL0wpAivW4VpOXru0JVm5g00ejpVGv2SVMmV4PJ+Zsx
	NYWgLNUjyLdvPCXRtGpK9m2rmC3lhhkc=
X-Gm-Gg: AYBFou0a9qqx0nkWaxnWeDfAfLW0VEVwSLXE55qR61e5WRGJ7/QzHc8vv393lrAmLHF
	9JYxTUQVd83phUZeK/Hr/GPpfnntlknKpD7E+tVFqcq7huk+mubnDVMD6Z/NixErFTP+oKJjVH2
	Tz1seEZdIQlXFWQdRSH5WGLt1NwJk+TDjzcdwIwSKat6YdS4II1Wy5IdgGjcgHlQSWg9zD519XX
	HHibo2AnwPhz6LJmCIF5B53mg1PrirVmrjkGWNxHi/K4o49N/fojPzu1jJvawZ1kCEfb95jgMgW
	JZj9ymt00zIIDZJsKWZYqmdPFtpWZvNIV33xyaEGEa9X0QH2AHRFpYKA5FmnvbAo605bWTL1Jwm
	6eYHSQYZRPO2DwXzNu/T9uJPV3YFXPOpm/wx98Dj2lN5bJvVenzCHdAJ1p0MzRC1FONOcSCEUWG
	QXe/xPAyZX
X-Received: by 2002:a17:90a:d443:b0:3a0:e0a5:dbb7 with SMTP id
 98e67ed59e1d1-3a4bfe94978mr615093a91.35.1790731776604; Tue, 29 Sep 2026
 18:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790684309.git.ben.knoble@gmail.com>
 <e21b832a6e1d99416a220bb5ca1f008777ef4e7d.1790684309.git.ben.knoble@gmail.com>
 <xmqq4if7g6u1.fsf@gitster.g>
In-Reply-To: <xmqq4if7g6u1.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 29 Sep 2026 21:29:25 -0400
X-Gm-Features: AclHuK-3Cki_4b3rTnp1hR0czTjgTvOWYRjbkN1fvHU_VQU64ZvYNs-X1rLlPZo
Message-ID: <CALnO6CDDAomqb+MqRw10Kj048gL5+k+3k_4kVxbjTB1YrK3fXg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] builtin/stash: merge index in-core
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, Victoria Dye <vdye@github.com>, 
	Adam Johnson <me@adamj.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 4:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > +                     merge_incore_nonrecursive(&o, merge_base, head, m=
erge,
> > +                                               &result);
>
> In a hard error from merge_incore_nonrecursive(), result->clean is
> set to -1, which means that ...
>
> > +                     if (!result.clean) {
>
> ... "result.clean is false" is not true here, so we will ...
>
> > +                             merge_finalize(&o, &result);
> >                               return error(_("conflicts in index. "
> >                                              "Try without --index."));
> > +                     } else {
>
> ... come here to access result.tree member, no?
>
> > +                             oidcpy(&index_tree, &result.tree->object.=
oid);
> > +                             merge_finalize(&o, &result);
> > +                     }
>
> IOW, shouldn't it be more like three-way check,

Yep. Missed that when looking at the result struct. Will fix.

>
>                         if (result.clean < 0) {
>                                 merge_finalize(&o, &result);
>                                 return error(_("index merge failed."));
>                         } else if (!result.clean) {
>                                 merge_finalize(&o, &result);
>                                 return error(_("conflict in index merge."=
));
>                         } else {
>                                 ... happy path ...
>                         }
>
> or something like that?


--=20
D. Ben Knoble
