Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42263BBFAF
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032269; cv=pass; b=UOojKmFP+B9sSu+Ijspga0MasFoY8POz/pZecjAUwgca+gTBigWONms7TMEAAARvzQMwnTB8R/Vl0YV57Ma+eRB1KksMGN0HFkGLoouBXXI+R7+15qi4OnJL63zS9Ua8gMR8J5EVzNsvZ1pnRmX6lziQcHyC6AqVvcLWlsbSoLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032269; c=relaxed/simple;
	bh=jF1XrkwGGkr/dBqTMIyrh88nCl8JHUMqKyW4g2GRlTg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MP29UkdF+9krFP81dU9SCgsk14MxHgrqHHr9PGZYQzfRyIBMQc2A6ezGF7afnEtD9jLKXPnLIi9eegT/hWVSGaVum4HRtQ/ATfy3K46LKrvlq6UtLl/7SBq44bW8mdZNYztYGK070QcD/58pRCbMq3JPBE6ItzYLZJzp2/Gzvv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYiN2qAf; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYiN2qAf"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-97cad2f51edso2187062241.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 02:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789032257; cv=none;
        d=google.com; s=arc-20260327;
        b=m5EKW9ataMhYMDUBqXjWJ9U4Q41yz+gMwZos5CtZqq7QWDef8x6ypAVbDbfGz/X4uk
         pwKXM64e6pAxJ25ia8aXy5EaZPxEKWSY9Ga8T7dCaThL9qCUcO3EvbEWrz7Q7lfx9qP7
         xPM0oZZsyFhS62XR3h7PJ/6cmJ4hntK3r1mitLFtRkkJHB0yvgTiSrsnUTL6RQPkT5dE
         JNw6alm+SLrdvfT795vLjMq8bgnooltHViIRBUMr1plFBjUvgxMg1XTyIEXsSyZbD2BM
         t+QHF5rs6seredHr92Q4b6IfBPCmcGyhsuskZoXqAAlzaPU0h1eZSaVmOgmxkRs6cnTK
         TDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Dr2v0RS9NB46rKO9J4cSzUxMxJvGfPq9Zh1k7EZW1dQ=;
        fh=45aPd4Co3gtGBDt5ilXrmkHQRGFBkZ7B57t+RyvimK0=;
        b=c0nP0ZyxkRwNJ6qdMVsRKD9SOfClQJ1r8CX8RgwV55KWan4ZDGG/1iNj/a7ab1gOoL
         1HjVGA0Yleyp4ksfl3KdM2xD5uUQ6cv36OtGCEgp+uUeDZAd+eaeeM8ntIk9OXkHXVuZ
         0XjzkFpCTLcWr/ElrrUSVVGjp/rRJOArOeJZ8nkWS87CLLI0V2KM5mgKA5q7enMxYbtN
         F2uhX3Quaz+YoXOXgAcREWUA/yduLZ8b/k0yjaHFdIPNHOsPn3pNq+NUZIFoeVBJGPyg
         MAW/o4BDO+I4rE5KBhat/QtZRxy2aMCCAOR0dUWY1RIkXXVJN+nymxduFYXP6tCK91/l
         E2qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789032257; x=1789637057; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dr2v0RS9NB46rKO9J4cSzUxMxJvGfPq9Zh1k7EZW1dQ=;
        b=JYiN2qAf/Z4+n4hX1n7i0/deLclUWBcInndS6J8FgJyGkCRkDQ/sDXwM+2GCKBlbmO
         y+EkgEV+Maw8IPs6+FsN7l4ydusdeNpg6sKjyOc5DswvTirRIZiLMNT5NrvaLFhpwG3f
         /JwE8KIoOVZX7LkNADQImsOBLWQdlc2kHH5XkmdJyyDSnLWcqMdoAAGwqscvg+hxNeKp
         INqokBk4I4xRnw9xq9t2Hoze0a/W56NNLLCtQrgBlvDp9LkaK+pa55IDE1ldQhZP3QHw
         yjq0VFMMpFC4wBXNH3kqiHsQxPq+8LBYfrJiKTmfMNm7LScxaLA0sXRS2RvUevu+2TSi
         k03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789032257; x=1789637057;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dr2v0RS9NB46rKO9J4cSzUxMxJvGfPq9Zh1k7EZW1dQ=;
        b=VdqjTAu/Q9qCqyW64HxLeg81kVvanJm53cVqLAomthTfp6UAQDi01zDFo1C7hNUXR9
         2abv45dhqD1If4VRl8rDSVVJe6woRbaVKnLt0gXAGeuHzEedR9m0WCn7u2QBmdlPjLpu
         Ja4vOicgXWWN7Yu8ufVPTJvmoou2NVYdfUAIEftTdH0Oe3A0GGNaUd3LQt2WgfIu9yqr
         GFBhsQ1kAkUxv2DBk/xfWYv26q49VOp6Wj3oqLrWiQ0IXZrzbbt1fwwMH8Wbogj/09bn
         mi0H8T2duDsZXcAMhhcx/FGGzdspWfd7eaVR9CxWpuOVzdNWCP97hgyZ72zd039J/d0A
         wCYw==
X-Forwarded-Encrypted: i=1; AKwUvBw1PXCg5vW7Dn4JkCiUNb6Zzvh5nxMLQX4/egruwWx9rJ2KqE+JMc63c/jsgkdeQcZwPic=@vger.kernel.org
X-Gm-Message-State: AFuF++n+rDzbOU8eUFLwK0nUdCpVm8Ip0wezssLMvAdfGn++N/vCdCRt
	yvuGQBM8vMOz+jVrNIcdygal0H24WCu0h0cAbRf2HxOUTqaM/FbNf26C8xXG2rf98flz+EjS8DJ
	nAgQ2ao9l/pUysiVRw7dV/dy1jAnrkLmEAA==
X-Gm-Gg: AYBFou0j8R4qDJ6Yi7kS5wsTVgL544eQH4xXqnqmnol4QRrxQJlwxPqce+d/Afzeo0p
	oLHZWOmXz6yEu1f2lU+Nth3TmIiOcN+Hhtb98+XyKWA0Lqcdp04WyB+3NqP5DOqQewNBZZrTZBC
	v8qx7ZzrGW2nLR01P0l53Al6a7vYmYSf2yrKZyRvc+0FUHWTt4yY7q3QItzSLDDPklydD0ARPm5
	ZW1peulgtxerU4GQAxcJ/CtQa/Z9vPmeNdhbYTMOAq6lY1aABlF92UoD+nngIRZtB5gvt8vhyS0
	vUb+54ewgKmHofugQLCz4awjpZ5Rrkgk+kjfEajjMF57rxlJbWyj3MChmBLWNwzV2wkJ1DtJ+7i
	dyGmLhIQgDx0GHkIrfeynAIQFXCiESvTNsEmhwbAg1qPJ
X-Received: by 2002:a05:6102:6b01:b0:785:3211:f5e4 with SMTP id
 ada2fe7eead31-78a4a6c8a04mr18720867137.4.1789032256749; Thu, 10 Sep 2026
 02:24:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 02:24:14 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 02:24:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-1-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
 <20260909-pks-odb-write-alternates-at-creation-time-v4-1-d8a78ffc32e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 02:24:14 -0700
X-Gm-Features: AcwNN1Ub-GI9cnU9vllik6ofYwXYiXwfRcqbK7Xgv9W7HxTlcDmQc863ylkSmoE
Message-ID: <CAOLa=ZQy1G9ZH0abH1uJZ0t1H5B7b3ym_s_gUAs03FiAend9Lw@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] setup: split up concerns of `init_db()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000027e6f6065b1d88dd"

--00000000000027e6f6065b1d88dd
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `init_db()` is responsible for creating the on-disk
> directory structure required for a Git repository. It is used by both
> git-init(1) and git-clone(1), and because their expected behaviour is
> different we support a couple of flags:
>
>   - The `QUIET` flag controls whether the command is quiet or not. For
>     git-init(1) this is user-controllable, whereas for git-clone(1)
>     we're always quiet.
>
>   - The `EXIST_OK` flag controls whether a preexisting repository is
>     okay or not. For git-init(1) it is, for git-clone(1) it's not.
>
>   - The `SKIP_REFDB` flag controls whether the reference database should
>     already be created or not. For git-init(1) we do, but for
>     git-clone(1) we don't because it does not yet know about the default
>     branch and about the remote object hash.
>
> Furthermore, we're about to add another divergence in behaviour, where
> we have to also skip creation of the object database in git-clone(1).
> This is becoming quite cumbersome though.
>
> Instead of introducing another flag, start to split up concerns of the
> function so that we never create the reference or object database. This
> becomes the responsibility of the caller, which is thus free to defer
> their creation to a later point in time. This lets us get rid of most of
> the divergent behaviour:
>
>   - We don't need the `SKIP_REFDB` and a potential `SKIP_ODB` flags
>     anymore.
>
>   - We don't need the `QUIET` flag anymore, as nothing prints output
>     except for the final status message that tells the user that the
>     repository has been (re)initialized. But as this message is specific
>     to git-init(1), we can easily move it there.
>
> The only piece of information we still have to convey is whether or not
> reinitialization of a preexisting repository is okay. This is handled by
> a new `reinit_ok` pointer that, if non-`NULL`, indicates that it is okay
> to reinitialize the repository. Furthermore, the pointer will be written
> to to indicate whether the repository was reinitialized or not, which we
> need in git-init(1) to print the correct initialization message.
>
> With these refactorings, `init_db()` is named quite misleadingly though,
> as we don't create any of the reference or object databases anymore.
> Rename it to `create_repository()`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c   |  9 +++++----
>  builtin/init-db.c | 32 ++++++++++++++++++++++++--------
>  setup.c           | 54 +++++++++++++++++-------------------------------------
>  setup.h           | 45 +++++++++++++++++++++++++++++++++------------
>  4 files changed, 79 insertions(+), 61 deletions(-)
>

[snip]

> @@ -2877,8 +2877,10 @@ int init_db(struct repository *repo,
>
>  	safe_create_dir(repo, git_dir, 0);
>
> -	reinit = create_default_files(repo, template_dir, original_git_dir,
> -				      &repo_fmt, init_shared_repository);
> +	if (!reinit_ok)
> +		reinit_ok = &reinit_ignored;
> +	*reinit_ok = create_default_files(repo, template_dir, original_git_dir,
> +					  &repo_fmt, init_shared_repository);
>
>  	if (repo_settings_get_shared_repository(repo)) {
>  		char buf[10];
> @@ -2901,29 +2903,7 @@ int init_db(struct repository *repo,
>  		repo_config_set(repo, "receive.denyNonFastforwards", "true");
>  	}
>
> -	if (!(flags & INIT_DB_SKIP_REFDB))
> -		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
> -	create_object_database(repo);
> -
> -	startup_info->have_repository = 1;
> -
> -	if (!(flags & INIT_DB_QUIET)) {
> -		int len = strlen(git_dir);
> -
> -		if (reinit)
> -			printf(repo_settings_get_shared_repository(repo)
> -			       ? _("Reinitialized existing shared Git repository in %s%s\n")
> -			       : _("Reinitialized existing Git repository in %s%s\n"),
> -			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
> -		else
> -			printf(repo_settings_get_shared_repository(repo)
> -			       ? _("Initialized empty shared Git repository in %s%s\n")
> -			       : _("Initialized empty Git repository in %s%s\n"),
> -			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
> -	}
> -

I was wondering if the order of initialization changes with the move,
but it stays the same. So all the changes look good.

[snip]

--00000000000027e6f6065b1d88dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2f8b1e0304dd8ced_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xaWR6MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWUwQy9rQnhZOVhGQTJkMVdEN043eEtXZW5ZMkx0Mgo3c29ySUg0RW5t
WnBVV3dJWU9zM2NaM2lEclpsajl6RFRTbDkyRkYwRURKcE1tYjVjUWdPa3Q2bUdzd3dETTVlCmdC
NmoyMExJaW0vbldaeW14S2kzVnUvQWRMNC95WVdqQlBsTEtITm5kRVllTkd4UzEzV05IS1B0aE8v
VG01RlkKQm9Ha0hOU3duNXV6cTNSUXdjMGpDaDFLSXdtSy92WWE0NU9sL0NibGVGNUlmVEdMWUxl
ekVNa3BpQUV2ZnpBLwpka3owLzlwdUpMVzY1YU55TVZBdFBLTTFkV3YvOTJRalhvV0ZEV3daM01x
RXdyZUoveGFmbGpJVHBtNVpsZDBMCmNSM29hWHFUZDBicG1ISkh1NU9KeTIreStTS2M0N3VTSjMr
ZlZPZUEybE1YNlVOM0F6VWwvb0xuNkpGOERvUnQKSnlnUXQ3QVI0NGovS282bm40TWFEUzVLVWc5
SXBXNmc3Y2RjYWR1VG9SeTBWdXRiNk1CdUttZmQxUzNsbDhJVwo0b2lnR3d0d0FCbCs4QzFiaXgy
UHFMWEhJTnk3NGxKRWtMWWlnVDk1L1AzSTQzRzdicU84Zm8wdk9Na1h3c0tkClRkMDlqZUtlUUZy
ZVdzWml2M2hTbHdnSlFhSUVUM0xJc09oSnRhdz0KPW42OWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000027e6f6065b1d88dd--
