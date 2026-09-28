Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1F472071
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586815; cv=pass; b=O9NTZoargxvzpMWM4jlSP0+tJMyHdgSfKkW4tJmvithJwO3k5lYYVER5DWQ3JPW85x4OHO2Xn2oJusXHVyW1V8PttDGgPHjqPnEnkTEFTXeGAIWfCm4yHSu/FxYzQfkXGpSSJJ85bGhqmRV7qL3dGlkKKjkHuh3FNk2XHpFsT6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586815; c=relaxed/simple;
	bh=gQo33xOGTGYgq/KwukcMYAaMVfdZ2lLpRrMJ/TCnhd4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=HS6cquzgyVK9PdjM23I0hyu1WyV+HREfZj649PAF5ld/AIDjmaTIMkdmCX/r3rJplt9Fcm4jEkFjISncPPBWS01FPc7+H8wybH+r5u1auhj0RJ+zEI9KTegHpf/zankf3c1n0ct08exO7/0wMTqwQZf9oRIfFFAqWGmTobnZsgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kh2vF2TO; arc=pass smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh2vF2TO"
Received: by mail-vs2-f38.google.com with SMTP id ada2fe7eead31-7b3acd24099so952164137.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 02:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790586813; cv=none;
        d=google.com; s=arc-20260327;
        b=c1Fc2tXoJ1DXnYQMjMFLDg9TSjlJ8HeDLN3ohe0dLZjXUqEGZIByu7IVizCs5NDRH7
         e5hB+7lRAVAqVBp77VktmTM8kKBQo0xxcEN2wUHVMKuQ/xw3ZEt5b/BijMGVkmWkkob9
         2EmGXxIycG5OtHacmIFJr7YhHKRtZONmGexjqFB5vryCJzhnpvm7kWaXWeHxrrgMbLEw
         dY9HsFb0WLrlVaLm5CfjSmLEUdFOOeJRAKqnDC8oAWjoxqFWio5pVy25pLKEnkCb1gxz
         6Nd+fhAY9FVYX9pku7U8f3YMG6ai5JhphuE2rk4zOV61gcIa2Lpgpsis1K8HUMbirG0H
         vAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=zjZyYCI6jUNEFeRjzYZhFIMiBPHoNF/CscfhxHWeYvA=;
        fh=49w3tF42ZeWXcVf8qyrmOs55NyUMFgMKrhMMa6XBOlE=;
        b=rkEVnuUYKI0538rQVb3iyfNLQU1tw2MbO1d/AfqYlPz5Zz1B1sAyAL6A6t3lSxEVgA
         ZkYAKUUo8bzNWZR1rmrY+TOrv4mBXMSJSD2Wg2/dY+mPfgMQbCcH52L+Gqfw/3yFLSWT
         hfYInrC3H25ql//993iytDzGqel3ediOV/a+Wtt9ycdbbAgGwyxGXdZA6mpmrSIkH0K9
         oENiTsewAuwHw7tn0rEpqWy0BU5mlqnrIQxk34MEL/WeLR7gnjEeFMQYRIgtwHlvlgWy
         7qgNMccNd8O8SUFVMW8uWtY5Pri9LWwk6IjMRHaIhlhWJWZrQCReWTtu1gMYcmpgC41L
         6kJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790586813; x=1791191613; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjZyYCI6jUNEFeRjzYZhFIMiBPHoNF/CscfhxHWeYvA=;
        b=kh2vF2TOnqoEJZ2CERt4cHtFz5dQn6mW3rLKUSOClFdSxGJDpJumD8DZ5vDLVGu737
         8mNaH1hXYF23RDZUyXrP3nMAbFAnSe5bUaZ6WDRBq4b29XgXRMi2Uw87NCYekuzSwJss
         N4slHr2BOtfVOBIC7lEulKp6oJAt6mS9iuKcZ0ARdFq5k1f1ON2r2WXCe5DOd77ApKbO
         Ka7kRpnbNLFhWyilgQd4Nu7Dh8iTsZ7W1fjFAHtb4NJpsRd+wopNgElLhelJ8R59hQGK
         lyH90t72tRDOy6QpbooBNDq/8aR2QcJvPvTyhw+5Er4BgDYXvk8CVsCNe7ZWwF6EhmeF
         LkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790586813; x=1791191613;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjZyYCI6jUNEFeRjzYZhFIMiBPHoNF/CscfhxHWeYvA=;
        b=CToQhxflc3IPUubG78pm+MMUe5XMBOlRzAH5hiC/5DC4tBhtBkNiuTE1H0dGJ87nO+
         n4NziMmhXnh8N4kJsisvmw3gXrUAn3sRxquiKyiEGwHIxMv4MzBB/VioGkcOgq7Xx7V/
         XOYvWUDh3R5Lfx65xQr0Sq72e0rvUG74K2/6H6a5CfEbD4qas/x3bVAV/MCQLjPK+fek
         wf/6lvtEw0vWjucgJaaVhVDSolA/2QeDvWZJU0eU0nBKRKpl5uuXX8KEH7A2yt9XkiE8
         8u6SwsWUJwPjyJXb2B0SHiuTaEinLmUbuCE15gvdPlTsP8n7jo/oKm5xKARGBQAUAEOU
         SL6A==
X-Forwarded-Encrypted: i=1; AKwUvBy3hwM40hvkL6Uo/PVX4eqarB1ET3PSoHBFzNuKvGQxtR+VGBtwJUI1O2zp1/Wt04EeJhY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqp9Es70G/YyZJ9xuTBXbbtd1xMDa1c8MrolHTJFZXVza6cxFs
	hG+Y2iPwaojzT3dvaG3LPq1p5b6lCGI+gTa2V3x6IfTRtWMHoNiNnPfFk4+aS+gJ+e0kCvo+66D
	A8weksqJbBGTv1131hd3wUjTbdpjhgZBaOQ==
X-Gm-Gg: AYBFou15OqWHyo/WcS3hhoJyoJZepDF/cq+HaN0CHgC7qCOr9qNEQUZjZepGUedYqXg
	h/dpsQ3Np7KbhbuoSXbfQxGjFTUDWOBS7bX87xRWyboDhlZ5DNTfHVM2SNLOA6RlvT9t9qYjvLq
	k6S4+d4/1ov80DIb0AdXqRAiMaCoQ8itxBiwbVVV217KlO1dyiww61YlddPqJ/x/YIjimS+Sxvs
	mjF680DLm6E7UFJCLfcxNovCLJPRnok8PAkyvQ/fp0LEzdKsgQcR6c83piZ/kNW2m3u+5RWXwu8
	K/CgbnLRUNI87lYfcfiiqEZgqLAyo1nQ+QTeSEeVFDKtO+Clj7YnfdZJDHAl3zk3sta4Ebu8wvo
	/LutvHEf13MJUEEpnM06b3CFp/P3YHt17MNrQ2dUT22mbwIs9OcEHbRI=
X-Received: by 2002:a05:6102:6a85:b0:7b5:6bb2:538f with SMTP id
 ada2fe7eead31-7b56bc1b855mr782176137.34.1790586813024; Mon, 28 Sep 2026
 02:13:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 05:13:31 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 05:13:31 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-4-11499557cf31@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260924-pks-create-repository-stateless-v1-4-11499557cf31@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 05:13:31 -0400
X-Gm-Features: AclHuK_gEYw5i4xuZaavFvFhQOo_Ma0vL1q-qjNUTxR1sVfOtJIKaTfWIfbARjk
Message-ID: <CAOLa=ZRwgSZuKHKPnXXz2Voc6o6WYZpVEC+dXk_LfeRZc1R+Cw@mail.gmail.com>
Subject: Re: [PATCH 4/7] builtin/init: move handling of "core.sharedRepository"
 into "setup.c"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ee6129065c877a0b"

--000000000000ee6129065c877a0b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When initializing a new repository via git-init(1) we know to honor
> "core.sharedRepository" and adjust permissions of newly created files
> accordingly. The way we propagate that setting is quite awkward though,
> as we have to set it on the repository that we pass into
> `create_repository()` and pass it as a parameter. This is because there
> are two different scopes in play here:
>
>   - We need to apply it to the repository so that creating the
>     repository's directory uses the correct permissions.
>
>   - We need to reapply it to the repository after we have created
>     default files so that we know to override any configuration that we
>     have read from the new repository's configuration.
>
> The effect of this though is that the repository works as an in-out
> parameter, which is quite awkward.
>
> Refactor the code so that the caller only needs to pass the value.
> Starting with this change, the passed-in repository can essentially be
> completely blank as it doesn't carry any state anymore that we'd care
> about in `create_repository()`.
>
> Note that this change in theory also impacts the other caller of
> `create_repository()` that exists in git-clone(1). But that caller
> already passes `-1` as a value for this parameter, and neither does that
> caller modify the repository it passes. So there shouldn't be any change
> in behaviour here.
>

So this works, becaus we already pass in the `init_shared_repository`
value to `create_repository()`. Which is currently used while creating
the default files, now we also extend it to set the adequate permissions
on the repository too.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/init-db.c | 3 ---
>  setup.c           | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index e45268f1ff..34215bbf18 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -171,9 +171,6 @@ int cmd_init_db(int argc,
>  			die(_("unknown ref storage format '%s'"), ref_format);
>  	}
>
> -	if (init_shared_repository != -1)
> -		repo_settings_set_shared_repository(the_repository, init_shared_repository);
> -
>  	/*
>  	 * GIT_WORK_TREE makes sense only in conjunction with GIT_DIR
>  	 * without --bare.  Catch the error early.
> diff --git a/setup.c b/setup.c
> index f335111d1e..0d0a4abbe6 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2896,6 +2896,9 @@ void create_repository(struct repository *repo,
>  	 */
>  	repo_config(repo, git_default_core_config, NULL);
>
> +	if (init_shared_repository != -1)
> +		repo_settings_set_shared_repository(repo, init_shared_repository);
> +
>  	safe_create_dir(repo, git_dir, 0);
>
>  	if (!reinit_ok)
>
> --
> 2.56.0.rc2.329.gd58861e689.dirty

With that context, this patch makes sense.

--000000000000ee6129065c877a0b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5d95d7428be78f2d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xNkw3b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0NTQy85Q29vK3VUdForN2FoQzVOdFUwMWFTRGlyYwo4NzlpbmJVdEZJ
ZnlrT3BPcW00UFdNWU8rV1o0VDR0cmZmR3hobUZHKzlyeWVRU2V2QlRzR1dwRnNPZGp6cEU5CjNS
dWpnWm1yVEVnR2JuRTNORk9QNnZmM3VKa3JqK1kvcTIzVGJjcFNwZzlZOXBidGtPY2lwd3Y2SHdw
ZG5NMGIKcWlQb090S2liVjR3VUxLYUIxanJNZEZyTEJpME5VMkpvNVpwU1IwV0dBbjdDdHhua0FG
bnZZM0ZhZVZBSFpNSApVUmJTN3UreEszZ2ZESzlWdnRISm9sYnJmM3NadmNNM3FQaFErZG9tQ1NV
OCt6ZzNqZklCc0dzQWZSdE05VTdyCmNwZXVjbml2SnpUTE94b01xTHhSbXQ5eGVhZW9FSjMxcVVZ
OHQxY2JJRjFZM2JyOTFtV3IraEJHRnF6QkphUlgKVHU2QW9VNUhmTDFrbUtBSmozL093bTBqK2xi
UWgzbDZXL3M0SEIwRVNmYWo2SnUyZjlIZnlOQklkMDAzMUtuNwowM0IwNjhyaFBxaUdDenlqZ2VN
aDNVZVlmVjFma3IrcjNvc3l6MXBueGtkTldkUlR2U2JYOXVwbld2UWdNNEJzCm1HajNVendCSjdh
aEpyZTc1Z3I2RjloMXVVT3ZhVnJGaTFmZXcxST0KPStTUmIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ee6129065c877a0b--
