Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58047A66
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983491; cv=none; b=Z4tf2YDLbDnka7EJAXmD6odI0RVR3qBFQE79AqYBt0w9jxd3LE8RSpGsDHZriLtTwt/WpJRleN20+9aEt/mfwOg7IUzHKPxcKzlTHKQIbs4Tcvk/qo3749UWGfrLL/1rtHN5OX+/TiTy1nUkVVrHvavqtZlVmOXndBf7P/vcmtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983491; c=relaxed/simple;
	bh=7/ikTl+ZH0vB6TEXXvIMmYyXp/gtJMrNIV3hsopjYWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eP47ddRDdV1oK7q4FhKry61eXOqz6POOgYMB9KqeVdSW7phur7uxASKqy9XXGk7jayaLeoX3IJWNt9dQc+XNfTICPcJ0Ezq2XqYLOS/fj7x12IixKc6UGALtMSCoZlxnONAV1QyuTRUB81vdFtoTiTe4bz0vFAPPNlMq9QeFSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo3RLTWX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo3RLTWX"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso2551585a12.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718983488; x=1719588288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZihRaLpmer0X+YkzfgYhPpwkAebjPskUEtstPLmZmR0=;
        b=Qo3RLTWXb7erAykUn/Tn5Ygp17BTEfFD37Wf4qYOBAekB9OTJUKtgDB8I3bgwpfmgQ
         ks42AB3jmDb8Xp6v7Se/dTIg5PhxuMRTISS6D4Y5NNRLNi81pVIZ7gfFtLq4aQ3LnV+b
         R3d2RWVsbesARJAgi8hBBqmsGEUrD6jzYABgotMf036+MdbHSluL+mIuwho+JGRfeKSD
         vhgc+d9i0JKnK1YnFOqzG34iEBkFfhm+IjYhfgtdw7fJKu95AZ8eU+whRAUBKAqI7nGP
         H2Z/1TL6mTLcA4l4QRkoeOYjsTD0XMRb/YWU/Slza08MZyw50sOGrr80WcMZ2x7Oa6R2
         Rm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718983488; x=1719588288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZihRaLpmer0X+YkzfgYhPpwkAebjPskUEtstPLmZmR0=;
        b=vP1wwfNCZAdNBWP4nIp4vIvffxY5XN7O+XRPWEvjvZLbmipmAFlQ02+u+OZTzdiXOQ
         reSYSEt1mStNhhqjp6tzUY2lY6hZDMpnrdRfIV4REDyG4dT0DYdVLk6MYAU1z6wB+mBv
         Ex41GxpCzxxU2gx0ajiyNqBqfZSNI/0SJdsdf8L0U4U5KbdqJdOLn6sK9mpeDQTo5+9X
         wjYhDn/v44ABuAafDB6sM1IAh/zw00B4T43Ny5L39fZTX3cxFoC0pzmDFc1XaA4jUn/N
         qRX9XcxvQDkMMeJMT08KaI2rz0uZ8AYEBPnKeYfjcfZ0Ymck/UQF0gdbRqawIn+XM+fW
         W1vQ==
X-Gm-Message-State: AOJu0YzB79gHn4sraRDoobe09K5vs4nMk0r6Ih4JE8a91mOCYXlq5CrW
	EcpG8ZD5T5i0u0icoa69ljwwxLLQgIJ7wP51XzDipH2YBfovqZpuNlnvELherh4HuHaQHrHMTxm
	YN23JggGrajO4OJL+PVY5CZQvoFWEeLdI
X-Google-Smtp-Source: AGHT+IFK97Nhwn8Np93a8r2PX5GqluWMoXAmv5EGKZqF9rk8UToJfH00Zh4QrIU4FjGUtBv0yKW/FLvwj0PDrkSoYQM=
X-Received: by 2002:a17:906:f246:b0:a6f:6d41:9681 with SMTP id
 a640c23a62f3a-a6fab779117mr536850266b.48.1718983487808; Fri, 21 Jun 2024
 08:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621092258.1557258-1-toon@iotcl.com>
In-Reply-To: <20240621092258.1557258-1-toon@iotcl.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 21 Jun 2024 17:24:35 +0200
Message-ID: <CAP8UFD3jGVaO2JdKE0H22mf4E8YBxrEwuGqJuyeRGBVh==23NQ@mail.gmail.com>
Subject: Re: [PATCH] bundle-uri.c: Fix double increment in depth
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 11:23=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
>
> A bundle URI can serve a gitformat-bundle(5) or a bundle list. This
> plain text file is in the Git config format containing other bundle
> URIs. To avoid these bundle lists to nest too deep, we've set a limit
> with `max_bundle_uri_depth`.

Yeah, max_bundle_uri_depth seems to be hardcoded to 4.

> Although, when walk through the tree of

s/walk/walking/

> bundles, the current depth is incremented in download_bundle_list() and
> then calls download_bundle_to_file(), which also increments the depth.

s/and then calls/which then calls/

> Remove the increment in download_bundle_to_file().

The increment is removed by replacing:

    fetch_bundle_uri_internal( ..., ctx->depth + 1, ...)

with:

    fetch_bundle_uri_internal( ..., ctx->depth, ...)

in download_bundle_to_file(). Ok.

It looks like there is another similar call to that function like this:

fetch_bundle_uri_internal( ... , ctx.depth + 1, ... )

in fetch_bundles_by_token() though.

There ctx.depth is initialized to 0 before the call, so it looks like
it could work, but fetch_bundle_uri_internal() can call
fetch_bundle_list_in_config_format() which can call
download_bundle_list() which, as we saw above, still increases the
depth by 1.

So even if download_bundle_list() then calls download_bundle_to_file()
without increasing the depth, I am not sure it works well in all
cases. At least I think a bit more explanations might be needed.

> +test_expect_success 'clone bundle list (file, above max depth)' '
> +       cat >bundle-list-1 <<-EOF &&
> +       [bundle]
> +               version =3D 1
> +               mode =3D any
> +
> +       [bundle "bundle-list-2"]
> +               uri =3D file://$(pwd)/bundle-list-2
> +       EOF
> +
> +       cat >bundle-list-2 <<-EOF &&
> +       [bundle]
> +               version =3D 1
> +               mode =3D any
> +
> +       [bundle "bundle-list-3"]
> +               uri =3D file://$(pwd)/bundle-list-3
> +       EOF
> +
> +       cat >bundle-list-3 <<-EOF &&
> +       [bundle]
> +               version =3D 1
> +               mode =3D any
> +
> +       [bundle "bundle-list-4"]
> +               uri =3D file://$(pwd)/bundle-list-4
> +       EOF
> +
> +       cat >bundle-list-4 <<-EOF &&
> +       [bundle]
> +               version =3D 1
> +               mode =3D any
> +
> +       [bundle "bundle-0"]
> +               uri =3D file://$(pwd)/clone-from/bundle-0.bundle

Is there a reason why it's not more like:

       [bundle "bundle-list-5"]
               uri =3D file://$(pwd)/bundle-list-5

?

> +       EOF

It looks like the above is the setup part of the following tests, so
it could perhaps be moved into a separate `test_expect_success 'setup
deep clone bundle list'` test.

> +       git clone --bundle-uri=3D"file://$(pwd)/bundle-list-1" \
> +               clone-from clone-too-deep 2>err &&
> +       ! grep "fatal" err &&
> +       grep "warning: exceeded bundle URI recursion limit" err &&
> +
> +       git -C clone-from for-each-ref --format=3D"%(objectname)" >oids &=
&
> +       git -C clone-too-deep cat-file --batch-check <oids &&
> +
> +       git -C clone-too-deep for-each-ref --format=3D"%(refname)" >refs =
&&
> +       ! grep "refs/bundles/" refs
> +'
> +
> +test_expect_success 'clone bundle list (file, below max depth)' '
> +       git clone --bundle-uri=3D"file://$(pwd)/bundle-list-2" \
> +               clone-from clone-max-depth 2>err &&
> +       ! grep "fatal" err &&
> +       ! grep "warning: exceeded bundle URI recursion limit" err &&
> +
> +       git -C clone-from for-each-ref --format=3D"%(objectname)" >oids &=
&
> +       git -C clone-max-depth cat-file --batch-check <oids &&
> +
> +       git -C clone-max-depth for-each-ref --format=3D"%(refname)" >refs=
 &&
> +       ! grep "refs/bundles/" refs
> +'

Thanks!
