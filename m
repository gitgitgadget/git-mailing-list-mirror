Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792593167;
	b=2nLlGr4hmGsNNwdTsoqUdTBNBJ9K+vRWjoa52P9fs/ve52BO56/SSMLQQmlO9DC0bHoT
	 dp/t/V/qZYOLhhsfxuWEX4RAGklA478Ujlf6hVXy8zv7YxTEL1SkGx5Dq14syejVNUo8O
	 VrvkbL4DJFika2ZEcaqZIl6sk+wCJ9Vfgu+mc3jIla/IslaQj8qqzSXnJ/B1oQjNeGOgp
	 uyuLslFr5/oWE9tnBLKTgykAP/J+W1YW7DDQY1SwdrJQzVbooqT+cDbPEErtXfF5LH7hS
	 QXcPNOuAGf1eqRS5t3R9cUj/mHr/Gs0ORrIzH9uyIBLbo9u8gBrBdnj5bFYvMhGIdMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=FVTgtHTrRi6tdoklZ5DEITdo+2m6NZ+IebXrN7tlaMQ=;
	b=ZioNtF1HZSPyMNKw38j3GhF+flTPSiyCGAp7v2RTwhRQWmSkZ1QUspqmXvot70pWcO+8
	 FfJqQatEhgPf7i00BwJVSN6WDeoylW56Vx2RdaaYNUdv19FGd3mWT77GbY6uD6KQ+CBjb
	 9ldEkZAsAhJBOwMqUwETmXnNznei6hLTvm6GGYLs4U/MCY+O7Wndxl8Nb3KEE4T1l88HT
	 iYIgbkFUH62y0efSTln/BoisGW9Fp6jaTllREnPUuC2uuRWFh/rYXYd+08U0+Gm5CHhEw
	 28aKf3yDhjVSNiCVE75YrcsqiaTFAORCmOwmYhljhfnV+w0/WwFcb1ZtP2QTx0jskKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dv+5hpRs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62194606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62194606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dv+5hpRs
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-157fe9d771bso1019115c88.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792593166; cv=none;
        d=google.com; s=arc-20260327;
        b=f6P3LO4nxurLI1Yii2yrU1eSAoY+evBp8F+ip4EXXEP1DAbHldwSUeiNGYFxPqdzms
         h4VA9YFvuwgvElMmhUK42KkijyCtN9aTzCN5PEcxZCQU8LB1RKzcfVcQ4j9pUf0hPXeA
         WXOVBGMpKZQg2LWCwcZhIlcMlyOOJrN+aurKizzGLZFVDXsuEr2TdUJNwxipA7cD+TGC
         tTz2MymRt8slyaN341hWp/aGx8ezhdiSRuqXTpPw5I3Vu3XUIEIqOre11Urfhrzig4X8
         dRBm8p8tdJtjBSkcy1nbeFKGAI96SCE8NWj7NpFw5WthT75T3+VHtNJYpJ4ksFs1305D
         0fOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FVTgtHTrRi6tdoklZ5DEITdo+2m6NZ+IebXrN7tlaMQ=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=JywpUQLOiyRabJ9A06R5snfhd82JKxi+zxkmC9jQiTxVo6blPE7gaBERyIsiGAPcQk
         Be91W4g8NyoZMx+00ml+nRxARnRLeATkHu+wWBzVk8KD4Z2ucLalhj2gZioHeYw9lS4u
         8eaV19S5N6ouq7WVizI8rJuKe8rUSriG6SDaGlq6B2Cg15zLVIugc0m758QC/DanEhLf
         vIP7WessHBCNdJ5MW94tLH0hFC4BoIzRYXWOKnvvFXq+H3epcoovZma40utNPoC23pjf
         L16d7VyIMIhJAz1rfd7rdQD84Vc5S5JE+p1Qkl8trpg/ZzgIfoHf48rRQK+Gdhldxq48
         S7Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792593166; x=1793197966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FVTgtHTrRi6tdoklZ5DEITdo+2m6NZ+IebXrN7tlaMQ=;
        b=Dv+5hpRsyfIjL2cC6xNCAjZKj7aV7bDgP73vQJIcmrqK6xSt1FUD36+xcawtic6CXL
         Oe2Jd3OyVx/g4MZgu0JNk4WGbo0B+h50NFT07uIxKfkjXnOhzA+J3YTTAxw/uAfFPWd9
         xb7By0jVDWFk/0Z496v+R4Vqps7W3Y6cp+qT7MlxT6FCGtqMbRm9L+UufJMk2ErXhu6V
         N1HFXAB4iv5ooWMGiqKzSL3TQI+91vMSesattwmQqALT9X4XOsFtKFMPfTFyESWMAcym
         T681IhzKSIUPrk1MpIgV4fv42s/liUrHIM8G3S4qCFOmtwBmqJfQ/iVSnNbnCXurX9h7
         SFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792593166; x=1793197966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FVTgtHTrRi6tdoklZ5DEITdo+2m6NZ+IebXrN7tlaMQ=;
        b=AvAWS1GxRYqiZiFCRlqXcJkdgoqgtK/KPN/IrM+cGThXTIEXV8FXtAg/HSJJybMb2A
         ST5S3C7FBfmk6Hc4Xh60KuopTb3hql9Yc4HgwkDmCT794vyH/uTESqNZ+zC576+fkS2S
         z01DZiqGIBgWId5Urxwu6MOur31tZaNvS05jHH+5UkR2xU3DsJ3HaHnEs1nQw7GZ8cPy
         itd2/NJSbDgKgSagogDFprujI3CKJSv57nFKuNvkBYzXzSQy7dp7kWpQJKkoaXP3gJ+s
         TWuli4mmjx3RsF/V/L44qkp8OACWyJlULrRQ68edpxhkiUveteH2FLeIA76krH8Arv7Q
         Z+jA==
X-Gm-Message-State: AFq9FYJkjK694iEwDt8PJf9/Oz7pocwIS4Gs3agR3ixryF/GUUpl8r7W
	Qz33uJVMxpKW0gwkP/2jDk78vsmAU9wNGEggaPeDlaLo1LvYukS6IcjzazWOMmnRf3SDbwMP62M
	MdYq+Jz2lh0jrHDrsAdksMuRtteVCvvNZtyj9
X-Gm-Gg: AYBFou0hp0vMps3UKzJGF2YXxjYrA+z0IFjqEy5LEl2d1krct083xf6QhNHSsv5mg4J
	Zv4tYe/Iwuaz91ba0Otr+kqR4q/GTanayOPTej0m4dvhKMFx9ZkbxVHPwfphjId3srNRkYIOKqO
	hfmnvF3L0aXxlP0Fs8k233u6wBO7mTaY0fm4Z3iU7klmZEoYW7lHZkZQbVXHf59X39Mh7GxXzOQ
	iy6uJ1R+rEVC+UzDIBQCVrYEsy7o8eImRvE2OWHAnerlNwMn5qhMZnUZrUFgF+AxgyUX3pIuo0O
	mx6Af9jUyvGtGge/TCkxBVYdIfmvexfQmkDU3tC9GrDommoWn1M4FUx9AKK5sitjrnjJ1BdWBWl
	pTpwV1uxSiyz/eYpZ4kj22tHCr442IRgrDiLR3k2qEjEGh7JFjtrsX45qOdsDgBK+0DAeLqhSxs
	sSiTpmWOUcuxjvxZFVvCayR8H3PcxPqwCjZ2ahyY4RQkQdGhKztO3IB1I61s208tosPQ8lNuAlO
	H/OQT8DWFrmuh1yDJaQ9S6L
X-Received: by 2002:a05:7022:2507:b0:151:ece6:b16b with SMTP id
 a92af1059eb24-190a4c1fa2emr3920852c88.7.1792593166128; Wed, 21 Oct 2026
 07:32:46 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
 <20261020-pks-odb-files-reload-alternates-v1-2-d9e156323836@pks.im>
In-Reply-To: <20261020-pks-odb-files-reload-alternates-v1-2-d9e156323836@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 21 Oct 2026 16:32:34 +0200
X-Gm-Features: AclHuK-il5Y2O4RlC_w2D75UpHTnNO0RcFc5_oZwM0L4fYfn_zEgg97gQujh7TQ
Message-ID: <CAP8UFD0woTHVqy0cXtWJCL9Pt_jqWXT3m0bN=LufOQ_zJaKeAA@mail.gmail.com>
Subject: Re: [PATCH 2/4] odb/source-files: reload alternates on retry
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 11:01=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:

> diff --git a/odb/source-files.c b/odb/source-files.c
> index d31da6e5d9..86f3fd1136 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -425,6 +425,7 @@ static enum odb_read_status odb_source_files_read_obj=
ect_info(struct odb_source
>                                                               struct strb=
uf *errmsg)
>  {
>         struct odb_source_files *files =3D odb_source_files_downcast(sour=
ce);
> +       struct odb_files_dir **tail =3D NULL;
>         enum odb_read_status status =3D ODB_READ_NOT_FOUND;
>         enum odb_read_status ret;
>         bool retry =3D false;
> @@ -448,10 +449,11 @@ static enum odb_read_status odb_source_files_read_o=
bject_info(struct odb_source
>                         status =3D ret;
>         }
>
> -       for (struct odb_files_dir *dir =3D files->dirs; dir; dir =3D dir-=
>next) {
> -               if (retry)
> -                       break;
> -
> +       /*
> +        * When we have reprepared alternates then we only re-scan direct=
ories
> +        * that were newly added.
> +        */
> +       for (struct odb_files_dir *dir =3D tail ? *tail : files->dirs; di=
r; dir =3D dir->next) {
>                 ret =3D odb_source_read_object_info(&dir->loose->base, oi=
d, oi, flags,
>                                                   status =3D=3D ODB_READ_=
NOT_FOUND ? errmsg : NULL);
>                 if (!ret)
> @@ -461,6 +463,8 @@ static enum odb_read_status odb_source_files_read_obj=
ect_info(struct odb_source
>         }
>
>         if (!retry && !(flags & OBJECT_INFO_QUICK)) {
> +               tail =3D files->dirs_tail;
> +               prepare_alternates(files, NULL);

This calls `read_alternates(files->dirs->abspath, ...)`, but when we
use a temporary primary directory, `files->dirs` is that temporary
primary directory. The prepare_alternates() call will then quietly
find nothing new because temporary primary directories have no
alternates.

Before 5946a564cd (odb/source: make `read_object_info()` function
pluggable, 2026-03-05), when there was a temporary primary directory,
reloading the alternates also found nothing new for the same reason
(no alternates).

So we could think that there is no behavior change, but in the
meantime there was bdee7b3013 (builtin/receive-pack: stage incoming
objects via ODB transactions, 2026-07-10) which made the quarantine
the temporary primary directory in receive-pack. Before that commit,
receive-pack only passed its quarantine to child processes through
environment variables, so its own lookups reloaded the repository's
real alternates.

I wonder if it would be better to always reload the repository's real
alternates, instead of `files->dirs`'s alternates. This way, objects
that moved to an alternate would still be found, not only during a
receive-pack like before 5946a564cd, but whenever a temporary primary
directory is used.

It looks like with your 4/4 patch this improvement would add no extra cost.

Then `files->dirs` should also likely be replaced by the repository's
own object directory in the following places inside
odb_files_dir_is_usable():

- in the hashmap_entry_init() call that seeds the duplicate map, and
- in strbuf_realpath() when we are supposed to compare against the
resolved path of the primary.

These are not reachable today when a temporary primary directory is
installed, as no alternates are read then. But they would become
reachable if we reload the repository's real alternates, instead of
`files->dirs`'s alternates.

>                 retry =3D true;
>                 goto retry;
>         }
