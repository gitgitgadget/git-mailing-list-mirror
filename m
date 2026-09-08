Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6F5908BC
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886522; cv=pass; b=qT8afJa+n33o4cztSQyAAP7fJ3lX0mEb6MG6QjLP+OQ5RejPce7F2SS+UTw4xAXFI1VYrrIVSIi6uGOkIxiO7yt9yOzULofmnmHMHwCmk5rBdSLM6PR3zEkZ4PZa7kd19suhZ1Bo0WR7tF7ONR2gs+ETH2G5VOi0SPNBBBQ4MLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886522; c=relaxed/simple;
	bh=8t8VoCvl0ABogedWvH5FOthQw4mbuDfkgRQhuqtg/Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cO1gXi2hZOHLQnpXhngbSLmrzdaYQD3JESii9X6SftohjlZIen0MSp+bIs+eDluO8Ixjp+WXMa5WG4uwGbJR5M42/Ag/QqvRIBtvqtnKNJn2CLErVdwnVBTtXrRRLnzhCkC0rPTuj6KEUeYMX0HO3gQPmKbTCV93vGgbi8wkztQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q78/isZw; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q78/isZw"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so3936367a91.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 09:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788886519; cv=none;
        d=google.com; s=arc-20260327;
        b=Ew/fJga6sYLNoLLyDCUmoLmWeR1j2WaHt7FccrJj4NRZ9u7URcQ4L7kgJl5LvUMFbw
         EHlP5YYXUPH6LAd6WxUTW5pRefzVCNqfx2SpSidfPrq2JE7shwiBdlHfzkhTmgev67/A
         fFTcXAq/T5s3elLArLrRwPs+D4WYDuRGgqAMm8AO4Hp38ZBTMr1ZQVyLQlMMo5q/dyRI
         TXX1MhTRWqqh582fFsC+R1+q3n/Y9W0DLDkEnSMlGO8VJmawpihMMQF0YPH9ssszMVpa
         maORubTpRfx3XcH/dS9pNZ4WyA07jFIDAibqKrfwqHFDhs4UhrZHXS1euOyjJrlwWMYt
         7IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bx6KwS8LsjyaqHb/T8DoDhL0wmEBtb3zDgH5hNRZ1j8=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=mEYgpxxRAIxfFj6XPEwEmkGAf8NVvDL5ACAURkGdc0TScT8yvm32yINJDV9NB25x1v
         dnFRaxHdHjRH67DkJPXsuehemhj6jAswRbVpvqx/vPI2asAbbCSyid2kMuW+C6NwA/rZ
         f9KbVZTyFb+b8GpLa99IWRd6FyaCBna3/sDjgd2uvJ5vcN+T4hpe9fJvpuLGw6dz3492
         h1QzqvtUAa/WLggswYPeqO+Tz7I0fZB2L7Zn3O8COYhJbwyJSVan9TKbHLvTbPhwsoEc
         LXxe5AbH/p0nuk5Oy/N3z2nFfjQW85KYI9a8RwsSlDFuSDBy6ytB7dkxdVIma8w7Fcl0
         IAhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886519; x=1789491319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bx6KwS8LsjyaqHb/T8DoDhL0wmEBtb3zDgH5hNRZ1j8=;
        b=Q78/isZwavNv7YgklUOICjtukLyNxiKgdkE32/g1nMqWDk0kcLBZYaQdb0EsA6RVxM
         M4mqeMQMaB+EZ3oHD73gvuOvDXFutbXOgV7do6EJKT22MMNsRx+kLWCphZTU0iojkJWG
         7OXVmP1JKNVlFw/73JAEEC56hOJF4FNG1bU7wm9NiHH9X46DOm364VDeIO9AVknt+JO7
         Q83Ruksj73eLd2VPGQPGuc7USTGCCN9be+MLIsFoa1mfE5tgwtkrMWaH4bdlZ8QRBBGS
         RXsG7Xvx/q4VlmWQfofieXKgtuIi2xfVvwCOCkfNmN0Bd/z8mmVjO5UZawjt/2q7Xokx
         TGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886519; x=1789491319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bx6KwS8LsjyaqHb/T8DoDhL0wmEBtb3zDgH5hNRZ1j8=;
        b=tA8SKA6U1+Z2s6oWqyPeAUd+t0yXI18n4oq3Zw/TuVoUudTFNeWOdcN45TRv04nZWl
         1z9v3M0GoZEWR85teyU0VQal9FSIOKPLdiAYZzUmyR9JF+g0Y84dfM06jIVjMWLJhEBE
         k9pewdFlATMgzQs7kdxup+EPZ5Lmb3TC3mSODEfTaa9fcV/xyc4b1FSX9aErJaoN8jwc
         aa9MDQy5qSXjJHXpWPooq1KsDmS2WZD0sckbEfYCtgAP1wyDn3SqHdjNzgOfhDKqlG21
         3Rux2tYzC8hfSa5VT+d2gU99Dexss8a+3dY+nDYlKOYy1k20pic8Tan1MTRFiKjiJeY6
         zGWg==
X-Gm-Message-State: AFuF++kJ5AHVOqgXJuaqG7kFkoHEMh3APko7imlDlIH6o9iv8D4JI6aI
	F2FjvSJ7rxRZevkmVlKWX5/Mw5HkUSWJH974B3onMyNnGx1+SVtgNlOVzhpfTeOt8MjjVjsZWZg
	ubgFlt3Y6HKw+LgiH1arZ/4RfBJPanaCZD5Mw
X-Gm-Gg: AYBFou1lD+81+31aHAnMUbunSUicAKQ5vYUVIYjGpMma6V9fXCYvHZR1xntiEpPSZRP
	ziTtZdw6IYV+5SCeknMfkFJ2ueAr90GdmT6pMtCGaur14wSMlW029EMVxRDBHWMf216YyKVxWq+
	X5lbBE/qp7gHdcxhNZE0Cs/Ba2lviuV7t9jSvo/na0/orn7xeL9X8ONEX+Y4l1pXpbIkCP7D9aI
	eaeV2ZSUwtdqnInPCIkMyCzpV4Z5Fysdya4cr6zeTmKv/fiV+U70zS5pQA4Bqb93TyUvyIaCejN
	091Nu4+n1RbrNu0+fLEnDCINB34UQ7yXeZiV59HCxDOE/BkESFuO+yiltuYzNhrVo/si2ySWzZJ
	+MUrqgxY0af5L2ZhUDEWCC+nk1M0QvvqsrqeTxh+w/BOh1UHb98RL8uk9OMIH/DNQ9bpTra1jVk
	6PCMXvOCdnrJ0NaON5xGJh1Jx575RN
X-Received: by 2002:a17:90b:4984:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-39b26104798mr41233708a91.6.1788886519399; Tue, 08 Sep 2026
 09:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807135511.1818458-1-christian.couder@gmail.com>
 <20260813154748.2378747-4-christian.couder@gmail.com> <xmqqy0e8mv0k.fsf@gitster.g>
In-Reply-To: <xmqqy0e8mv0k.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 8 Sep 2026 18:55:07 +0200
X-Gm-Features: AcwNN1WcQ5CvrzR3GqEKvv5qpGEBxOpm-0ZzT7VhyBK_o6X_RJzJhA6fX_-CDmY
Message-ID: <CAP8UFD1T_+EKRu7BcdNn_ga=vPz27xZb+yeVWVCnKrnU3zFRpQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] setup: add 'allow_dot' arg to path_allowlist_apply()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 8:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> If this is just "I want to add an extra caller that has specific
> need and do not care about others in the future", this may be OK but
> as a public function, this is a bit disappointing API design.

I thought that flags might be enough at least for some time, but I
agree that it could soon make the code difficult to reason about,
which is not a good thing for this kind of code.

> I expected, as a generally useful function, you would instead add a
> callback function to allow replacing the use of is_absoute_path()
> plus the warning there, i.e.
>
> void path_allowlist_apply(const char *key, const char *value,
>                           const char *target_path, bool *matches,
>                           bool (*allow_path)(const char *path))
> {
>         ...
>
>         if (!allow_path(allowed))
>                 goto end;
>
> Also to avoid limiting this to configuration callback, I might
> recommend to have it be more like this:
>
> void path_allowlist_apply(const char *allowed, const char *target_path,
>                           bool *matches,
>                           bool (*allow_path)(const char *path, void *cbda=
ta),
>                           void *allow_path_cbdata)
>
> where the original safe-directory thing may call
> git_config_pathname() to compute allowed before calling this helper,
> and pass the address of something like:
>
>         struct { const char *key, *value } cbdata =3D {
>                 .key =3D key, .value =3D value;
>         };
>
> as the cbdata, and pass something like this
>
>         static bool allow_safe_dir(const char *path, void *cbdata_)
>         {
>                 struct { const char *key, *value } *cbdata =3D _cbdata;
>                 if (is_absoute_path(path) || !strcmp(path, ".")
>                         return true; /* ok */
>
>                 warning(_("%s '%s' not absolute"), cbdata->key, path);
>                 return false;
>         }
>
> as the allow_path callback function.  IOW warning, or insisting on
> it being absolute, etc., does not have to be carved in stone.

I have tried to implement it like you suggest in the v3 I just sent.

Thanks.
