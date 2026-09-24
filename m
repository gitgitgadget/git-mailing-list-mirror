Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265DB318BB3
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233280; cv=pass; b=Uw86LrYnwmhaEEP4S996pYY6m9qZjJvpLz3x4PtZFA65O9ZdQwI9af5wfDRnMB1SBCrtv734FbQCmu7Z8zaIBVo9DRjbwzSrLrzO2ht9vTv5R4Dygft0ha7i4Z5svhdfqm2H9dQNajrcwQtX0wqs1iXxJcO2xxp5yst8EVamAmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233280; c=relaxed/simple;
	bh=EmDw8k+JYt5d7J/2AxPvDQrsRloveGoT5/PeSW0tmCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9N4mBUuJFjraOLE/k5GtQFMtIXYV4uVhTv8W/AFnTP7FoDkiCdI6ml4e3hJVH9ViqgtR9HpYAeevMfrGcxHIAeqQoXQozFIVnDvShYEMZn9pQA/x/eOikIglYSm8Ql/2PfXFbFkDGVx2FjFS6kSNBLd9qdSi1sem1TAPw9+KkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iw4ljuky; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iw4ljuky"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396672b2569so219105a91.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 00:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790233266; cv=none;
        d=google.com; s=arc-20260327;
        b=XK9HwjGCXcffX5Df7wgdllMSpAcEZFbyTa/7klMaqrySZsUN6/yPWkPLPaGWCtEpG/
         ie6VXPJ172vypXztLBoDG5SJH20OD8XN7reuI2VPfq9aVenOMUs6db+unCr0BdVqoL5k
         71iPb+LUaOtLxTaair1vTICkNM84QIoyJF5UTk7FRjnwIw0qJe7kReG7DcTtPwWx0YYX
         IodltyEQLs7py6XhyPOauI0XiBnI8HAx+pAg+pFRtrhI+uJtkbVWhsrWdDKsx+rX8eTk
         MJF6+6t935tjEhM6+I2xkTKNGLdtEdtQbL4a4KjqPzIriA48BkgI0Oqm4Blxz/22E/Rw
         0/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QiVhLWSd/KFohiCQ0/S3GYzy/t9rFKjPQU3nZXZLthA=;
        fh=6giU0ohvLT5O0erTy5ehGTdc2LjieaFrvYE3/uUXOOw=;
        b=oWNugqsJrJQtdA0cLBBu9rpvJ8oplczOdumdfaxiAf0HKHOCuP6aTS7aFsdTTz1uZ6
         wxrHVrhGTwCucW1ZwfntvAhAWLT3l8KGqkW/RRyR5HefcOp+tZx3MCWmaz+ek+5vp9Cy
         ra8/1PzTcBDzNJ98UG8xAL+TVAt2MALg3RuxkE1dNumBaHJa7MdsVBnkFLcNmzN3U1Dc
         Lqzz2t7zsrud9kkHhPzCi+Pj7pCck4M0XU3+frADbNREe5mIhyIeVDl6NMRRXq0JZawp
         IcsCL3wPXo/NcAajjzBIM7SgMFpNa3HEViYgV3WJM49oKXQS69fZ7c0lb3sUaaZ1cKTW
         UDPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790233266; x=1790838066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QiVhLWSd/KFohiCQ0/S3GYzy/t9rFKjPQU3nZXZLthA=;
        b=iw4ljukygydgP6/yZStPf1AQwTjC1puvd6uygTJubDmG1tekCkGq85XbIqjxni/rpx
         KPY2KAFaZPsfy6PAVi6BCU+iu0hfh9CPii2FzklSFq2jwm+bNG4br/S1SV4JrXKobkk8
         469Uq9W+2M+5qcFmmRMB+RPG+cZ5/iEkvoMBNY0OoAi6ZX3U/39Lgn7GDXS7b0034oIW
         UAX+W90SHXbZKPZx11np/wrbksktebNq8U7XBUKvRkEBHv/3IKIyc+B8w8csnw3uA+5X
         urMkhTl6dYT9EYwJPrDILigSw6X//y++XkvRp/xBZ/k6JduYJeB6RnvKpJWWcvDVQ8oS
         2vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790233266; x=1790838066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QiVhLWSd/KFohiCQ0/S3GYzy/t9rFKjPQU3nZXZLthA=;
        b=oK3by21AS+NgOQym0ELI8OUjtgz0Y3GSuL4DTMIIaS7NaOhcRrZgndDkVmgEWykqMy
         voA3MveHHEwQM87gs+e09w9rwkD01T5aY4U+qVh6bLZaGFGoeV/awjbZYVwtBqN0yTHJ
         gO7Apc6MqeA/Ss6BXAU4Xxap37nG+Qq4hlw0WMIriDa48M853Abb341uWzjLCo7vNxvy
         iXWKOj/n+rRgXCCgIbOpvHsn0R4H8Qs+qRGb/sWSzjzPXUTddRYn8Q64fbfNtt2T2NNx
         ELAg/YH1I7NJKJGFJjLIH/DvrQG1cq0O8OqSoXRT/RXL3tewSsZiH9DyB6frgZNgE1ky
         PtQQ==
X-Gm-Message-State: AFuF++kRle4QcBex4mDZUZq/HbNLzipGsyeaK1PTvMaB3WataUXGDmYN
	D525BgrO3pbf4hvIhx2g1EfC4QSfh+9rRSIUiqMkdn+bZf54oBtdzpuRywQlFXT1c8ydm+3sANy
	fBWhBMpJ+HedbtX5T2JcmOmIWG/n9cM0=
X-Gm-Gg: AYBFou37kI3S+5U+ApTfltSlK651iJ7IXaiygx/TdxVlSW59U25vZYYE0YtsmxoP5Ef
	KKE7kyJ2ONrc/6fyFuIKjmAUQy+btzBE5/fIi/MA2v7RdA+zZ8Djmk8erm2NZEOrx7X2lsx7WBi
	PuM0EVL8aLogKYMbqmc/0T8MGnrqzxEXHfXKffNaEawrcN6Lb93evLttaaAzGw5GOaR6/uNTEaD
	y0bG5u+DXU1xB0DYB+GJWnk0iqXPTom144+cIyfIKJiQmfi7LudPMvOuaAgwVOm+RIxAxfmw5yJ
	l+NaeA4yTtLMNL/XaGXbAuMOlDFWEjzSvVNj46LwE2OjBah8Qoo3jGizKHyjt4MMD68KMdDBnRn
	XWyst0d/5LMS+at6aGHv0B5Eny+jJ00uOU6vJZ1zUDbDNwr3SuA==
X-Received: by 2002:a17:90b:3143:b0:3a0:60c0:7f8f with SMTP id
 98e67ed59e1d1-3a098643a13mr2272672a91.0.1790233265779; Thu, 24 Sep 2026
 00:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
In-Reply-To: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
From: M Hickford <mirth.hickford@gmail.com>
Date: Thu, 24 Sep 2026 08:00:00 +0100
X-Gm-Features: AclHuK-E6ujcuu1XBeG0tVn2rM1KoPTY3r-dHG4P6Rd12uc1RschJXrRm0D4m1o
Message-ID: <CAGJzqs=sUA7vGDwadL9h-dcuPAsQvhAjiirZhA5=_fyqH1QXuA@mail.gmail.com>
Subject: Re: [PATCH] credential/libsecret: load secrets explicitly
To: =?UTF-8?Q?Daniel_Mart=C3=AD_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>, 
	=?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Daniel_Mart=C3=AD?= <mvdan@mvdan.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for sharing

On Tue, 4 Aug 2026 at 23:40, Daniel Mart=C3=AD via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: =3D?UTF-8?q?Daniel=3D20Mart=3DC3=3DAD?=3D <mvdan@mvdan.cc>
>
> secret_service_search_sync() can return an item whose secret is not
> loaded, despite SECRET_SEARCH_LOAD_SECRETS being set: the search
> silently discards secret-loading failures, and the GNOME keyring
> daemon silently omits from its GetSecrets reply any item that is
> locked or that was deleted after the search matched it, e.g. by a
> concurrent "credential erase" from another git process.
>
> secret_item_get_secret() then returns NULL, which we pass unchecked
> to secret_value_get_text() and secret_value_unref(), producing
>
>     secret_value_get_text: assertion 'value' failed
>     secret_value_unref: assertion 'value !=3D NULL' failed
>
> and losing the password even when the secret is still retrievable.
>
> Drop SECRET_SEARCH_LOAD_SECRETS and instead load the secret of the
> one item we use with secret_item_load_secret_sync(), which does
> report errors. A secret the search would have silently dropped is
> now retrieved normally, and a genuinely inaccessible item produces
> a useful message instead of assertion spew, with git falling back
> to prompting either way. Merely guarding against NULL would avoid
> the assertions, but would forfeit a secret that is still available.
> The cost is unchanged: the search no longer batch-fetches the
> secrets of all matching items, and the explicit load fetches the
> one we use.
>
> Signed-off-by: Daniel Mart=C3=AD <mvdan@mvdan.cc>

Thanks for explaining the motivation.

Is this an upstream bug in libsecret?

The libsecret docs for SECRET_SEARCH_LOAD_SECRETS  are unfortunately
truncated https://gnome.pages.gitlab.gnome.org/libsecret/method.Service.sea=
rch_sync.html

> If SECRET_SEARCH_LOAD_SECRETS is set in flags, then the items=E2=80=99 se=
cret values will be loaded for any unlocked items. Loaded item secret value=
s are available via secret_item_get_secret(). If the load of a secret value=
s fail, then the [mystery consequence]


> ---
>     credential/libsecret: load secrets explicitly
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-237=
2%2Fmvdan%2Flibsecret-null-secret-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2372/m=
vdan/libsecret-null-secret-v1
> Pull-Request: https://github.com/git/git/pull/2372
>
>  .../libsecret/git-credential-libsecret.c           | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/co=
ntrib/credential/libsecret/git-credential-libsecret.c
> index 941b2afd5e..6bbdf2bd45 100644
> --- a/contrib/credential/libsecret/git-credential-libsecret.c
> +++ b/contrib/credential/libsecret/git-credential-libsecret.c
> @@ -126,7 +126,7 @@ static int keyring_get(struct credential *c)
>         items =3D secret_service_search_sync(service,
>                                            &schema,
>                                            attributes,
> -                                          SECRET_SEARCH_LOAD_SECRETS | S=
ECRET_SEARCH_UNLOCK,
> +                                          SECRET_SEARCH_UNLOCK,
>                                            NULL,
>                                            &error);
>         g_hash_table_unref(attributes);
> @@ -143,6 +143,18 @@ static int keyring_get(struct credential *c)
>                 gchar **parts;
>
>                 item =3D items->data;
> +
> +               /*
> +                * Load the secret explicitly rather than via
> +                * SECRET_SEARCH_LOAD_SECRETS, which silently discards lo=
ad
> +                * failures and returns items whose secret is NULL.
> +                */
> +               if (!secret_item_load_secret_sync(item, NULL, &error)) {
> +                       g_critical("could not load secret: %s", error->me=
ssage);
> +                       g_error_free(error);
> +                       g_list_free_full(items, g_object_unref);
> +                       return EXIT_FAILURE;
> +               }
>                 secret =3D secret_item_get_secret(item);
>                 attributes =3D secret_item_get_attributes(item);
>
>
> base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
> --
> gitgitgadget
