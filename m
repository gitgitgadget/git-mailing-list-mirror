Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0A23EAB4
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770663488; cv=pass; b=JYdgbJjf/441GSPcnf6pgi0q2IVLpTD8slQwPdHnpC3C8eoSotuO+D1YKAvLWiKrxSryn1iUOphwMnDvzfYaXSnkVdZvGkbjrNR5n4gMtODM+tCiIvnDVcFsGY8Unt0Zlcme7fBkV1bZXEupKsU/zKfgof+IR4m1Lo2Dznfj9Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770663488; c=relaxed/simple;
	bh=OWHmb8yqQMGIssMI5CvQ52VXfEVcHfIhf5YheJkgHkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxhe2fAZSsY4/lu0f0cK9n0IyTZmYsOwJW2dWiVjdFfczusp7FODMyEPkzbobI3T8o9YJlaPNFdUIW9s20TYRipVilD78njb2675JxVt1TtF0yFjDUddjGRvcr3ysFaRNV9/ddpUT0QIauIYTIRO4Jme1hjX4LUrSxP8oB8bWfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTg/aYsj; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTg/aYsj"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40974bf7781so3365103fac.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 10:58:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770663487; cv=none;
        d=google.com; s=arc-20240605;
        b=c/9mBvWPorP5WSbFuT4WrPUbkY8jQq+Vi5x/FiBAO8ra9PhT7OiCmU3NgdXa/ArkkU
         yXO4rdu8jmeobv/6pY0lOUER01PWiuke8PDD0A17V90mwJ57Ayc7UE8WVhvs0N5cw/od
         IYmbRctx7xgmWdlnuVf86l5HUYLHu8x7/XgiKAbQdb0hxLfIvpIzp6J1DDaDQm2xhDGi
         bXzBWI5dt/RrBguk2ItuY/LYzSG2P6qyXdrc4gGc2kwtj0i/W0b2HfkPo7FNrtg9PsQ+
         TXGHgoJNgR5MAvMGiMiNlj2/ldSCImPuWvZDZ+/HAdziKDRF1V4RRX0SGfN1OXU/Cheb
         M0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=779HImE9RBrG4VkXwJsObpB/U5fwe/4+jTr6HyLczDs=;
        fh=88riSZLIML7SSjRKnFsE1XiTwqZwoOJOrqt+ThAqONo=;
        b=cdy0Y3TnapPJL8siooMTWyMw25IHySDwCI1Cf1dMpechVBadYuGc7bkWCo2essTK4l
         9kptLXM1omjRMbA/OsNKYg19WySqAvA02el38hGn0n4bcIP/hJF/umFp+5UhUpOT3w8Q
         S+f2Lkg/r4DkcjLsH1ZwD4mwzfRnjSQNrK/IEFaflXpvYsAEfCQPkf0GnDyTUmOHaM2h
         hpwzU4DawUoj7F8Yv29iux9sLyRN1AdAxKvcDaO8lE0T+FsY5iZNJeTPRLkBQvwerASm
         b/YuQWC5hqrQ7R7eF87s0cugYy9Ui+zJBDIac+OH2ZK7Me6UyQFNO1XdOXjD0HAXE+hy
         dDKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770663487; x=1771268287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=779HImE9RBrG4VkXwJsObpB/U5fwe/4+jTr6HyLczDs=;
        b=TTg/aYsjBBS68liNzpnjdas8eu1CJg/ZYzpXEi9RYQ2rZbkDUBlBB8MX4/Fmk3x2NE
         KbbwaJvKNni5vkcVkW5O245A0v7bBtiOElDwc6SRZDnkqPbBOaZ80WlR+CrkkH016Edt
         xhQjNuXzOt1YwlHhaJlEziaoYGan6pTSqj5uYKdGrYIJlqsrtvnyXBbSmw1goBoiznbM
         6SbJqUkTZOdTlQ+6U2MThhlnVaKE0mkcofKyA7U4hARXGBp1QtuRkLjkH2mG+aeR4N9O
         VrlXDajSHgmaa2V5ot4j6YWwYwlHKNwBoKrO3iOPVUYekc2VJoXChOh+O3NvB1UIPreW
         uVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770663487; x=1771268287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=779HImE9RBrG4VkXwJsObpB/U5fwe/4+jTr6HyLczDs=;
        b=rvSNjjdLOePpjUcHcdMQQnQA6306Sse9LrUKWfemCVko/N98gJAzYC+pcXU68YrGm3
         4TV9EmGQ1CVBSkTUQSZ0IFx9F+hyLvc7WqSuf4gyMcN9bx3Eq6X8qlGjJojFcT2yaHj3
         ydRNwYKgGDdWtmubWn4IJ9Mw6YsWk2MTa0xzVV8v+JkwJmOauU4Sy8oPPN6yQobDvg7Q
         XBQrX8VtmkbZeEb0LePapQNUQDrn+rvr3NPDztxmV93ls6Uw7Kfaseh5pPJ6nyd9Cfqc
         eXCIoP/kNgepxXdcLIr5vVsg54XZtjUga6vp4zoNvUYnpGZnNIVLbR/kuyudi1/p14tx
         31iw==
X-Gm-Message-State: AOJu0Yydy+eMc53kQkRB9VK0iEfI4kiIUFr2uOYqEecskR2O+F/kwUQd
	58ZCk/kcdChnR8ldy9KCpTIK1W0EMgOolPe8Vf0mf74HncZQjEAo0Qww2T+s5JEU5Pg5WtVa5Cw
	Q4mrABR8XNzcJvvLh0/8fCRhbwVWvH0kV2w==
X-Gm-Gg: AZuq6aLo4zmiD5vWeTqW7K8Qf64oGEuH4E3KJcZ3Ovz/sZ3P6P6AO0KIAh1zxZIfnZU
	1vxr1RpteQTdtj9oABbbt/1YNG3ApKAOquv91vRKo+g+VOJ9mI8xQBDhedd0YqheL5/C8MzcJ0r
	pSfpSuyetK/lO4seklveqILURqMHHNcExRhsM4SEBNhAij208g+vOD/aiJim7jdIE5RnoSqvaOf
	aLDHtq4YhjlAqs37FV0xP8SRhDNxcuzw9jDbVdwmYzqJd8WrKLD9O0/Ma2dCAUDtL4ALq0mn4uj
	i+h7pv5os2nLf/1aXYPsg7RQaBSC
X-Received: by 2002:a05:6820:6ae1:b0:66a:bd71:f05f with SMTP id
 006d021491bc7-672b211e847mr170809eaf.40.1770663487427; Mon, 09 Feb 2026
 10:58:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
In-Reply-To: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 9 Feb 2026 10:57:56 -0800
X-Gm-Features: AZwV_QjSyLFhMjh7jtHpv9RN1akYq-6S5JNgm4GePpKYmBo_IRhO6BuqPSwQKjk
Message-ID: <CABPp-BFuwvqiCTCCpoyT6em9_1-qrgPWHWhrufQ3UuZ+Kfkb6A@mail.gmail.com>
Subject: Re: [PATCH] xdiff-interface: stop using the_repository
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 5:47=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>
...
> diff --git a/merge-ort.c b/merge-ort.c
> index e80e4f735a..a4103d56ed 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2136,9 +2136,9 @@ static int merge_3way(struct merge_options *opt,
>                 name2 =3D mkpathdup("%s:%s", opt->branch2,  pathnames[2])=
;
>         }
>
> -       read_mmblob(&orig, o);
> -       read_mmblob(&src1, a);
> -       read_mmblob(&src2, b);
> +       read_mmblob(&orig, the_repository->objects, o);
> +       read_mmblob(&src1, the_repository->objects, a);
> +       read_mmblob(&src2, the_repository->objects, b);
>
>         merge_status =3D ll_merge(result_buf, path, &orig, base,
>                                 &src1, name1, &src2, name2,

A minor point, but could we use opt->repo instead of the_repository in
merge-ort?

I've cleaned out all the_repository references before, except one in
prefetch_for_content_merges(), and would prefer folks not add more.
However, that one in prefetch_for_content_merges() and the use of
DEFAULT_ABBREV prevent us from removing USE_THE_REPOSITORY, so it's
understandable that folks keep adding them back -- in fact, others
have added a few others to this file already since I cleaned them out.
So, if you want to go ahead with this and then I submit a later patch
that cleans them all up, that's fine too.
