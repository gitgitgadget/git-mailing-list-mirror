Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380129B777
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770911792; cv=none; b=gAbBX3pmwnZbtBkueDCs+QHKms/X4wApxqdrhmdV7QwhFitVj9WzG+ePEfxI01PatRsJZtZkIlm7xR5Yrf8NwcdeboK9zr/bqetjZxOiVaZC/LX+fok8lpn3szsOQKOvRixKu2Z+ssVPAT+A9ncGAlckVl9Oy0BrdYzepVJr/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770911792; c=relaxed/simple;
	bh=Zk+Dt/WlQ0CTbShTvGN3ySXxXSZmi1wLC8bs8YyZz6Q=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=djA0mwTEW46s7JG+khKdqUQStlA8Osd8Rb+JqplQZ8TqfXp8TsnvWkkOH/UMZoJm3PaEMsixajo/FX6KrQpTAM1vkgixtv/iAZm6edl3PaT8VxezhXQ1IUhu72HgK+V0SHhLNHT8k+WJhtfTK8S0xS3mMlpJG+BIsaHgM6pGwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey8d1xpI; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey8d1xpI"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-796d68083cdso23472917b3.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770911790; x=1771516590; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vkeycH1CLDXlZoDQQ6aMpFyumVf2ttyCUpN4kq6KYw=;
        b=Ey8d1xpI5EMb4R9y2n7F6OxeJntq7g3GmZDML2J3v88kmb0drUTS0iFll8vYm0cHgO
         0x9R9GoHaLAT53TgfEdKnqiF1bkYAm9ChHXU/+KsBZM1vI3vV6UGc38C+cGEoKkCJ3Ye
         Two+CQ8zCX6uEwvQDpYrT/ap0anpdvzFy52uMATnEhuMvhQ2lFaudvAKyKTxfoGzSIcn
         FB8nWO5FbIPyjg4BD2Ef4eXV6/UZGy4UEzC/ez8Witb90CvFeKnMZp6OSj2ReBmrIdaO
         ZYU7EzUWof9busPRpfXqZ5qd2MbkFpCKtLz4XgRohYI1DipWkznb4xQokgc6KHiYbD8R
         TCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770911790; x=1771516590;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3vkeycH1CLDXlZoDQQ6aMpFyumVf2ttyCUpN4kq6KYw=;
        b=M+uzH4bgUdyt572bpaDcpCqpeylL59W7IXZFweXD+JtPLBpjtbIjEIk7mA4h8FYaW8
         Z+xbhDzYlyr0OKIEYK+i1S32KedBe7k0aU01WV3f6CMLmZpViv8TUXvw4LJf3XHpiTtC
         8Afx7tY3kdfl0yc0g2SgNH4bbdiJHfVf+nDAaz+OseW3vIm7eE/Pxh/DQXu8lJwbUpiv
         Ovd3JOXxukhjE0xfS1Tp4jsznqJJNBzG0smMxD4IgLFjJSmbfGQSNXfOSbaQLwJENRAj
         dkVwFPH1X8LT6fch2F5JchEd696JxRdfWGm6DGFiOSY335quqJo55AC46Y5Tm4ZEOnNg
         1KaQ==
X-Gm-Message-State: AOJu0YypqfQ65zdnwgeanK50cfq12LUXYspZ+3X7h1muZvGdY5X5ik14
	yoqu73vvolIcoGjqFAI/BIZkmj5sBvhpvHF0L+gqL5NOA9E0Zty3fOtk
X-Gm-Gg: AZuq6aJ3BUYsGWlRft56Ik28E0u6CSdsiJRwzpmh2W1nIuh2hQ8VwkCD8hC/6R4yVFS
	u0vrqdKMtaruu506ij1aJZxczSmECAEMdOGEI9z7YEvLx9kUf2q0jco8fuLWPIYuQHfnGkKYhh9
	pmrkNtb8lgBfjG5q2Kv14vlu607DJIm88L+cGVdZMdnOEYI2hLxR6QJ7ezQDn+LW6fJafSGPP1S
	fGuwQYAwAnC3bk0lx32Yxwb5TQehbKxE21IsvB1DLi5PqqgTjixdoTfzw1tldH3/osVBbdpHADq
	gOCYj3G4uuS2mhbS2EvldBjJ7gvn92qHHNAnYGrS4BTAT7u4ypOTrOQOIBH1fGv9gzyHZJreXYO
	qXPsvWtuROAzHR4Wxv29cqeecvi78p9yJwoAss4GtZmM7aZFa3OWp2xbJ+C+CItDkvdKtSDCEsI
	ZBUh25d5WbI0Nc6zQTNX/CWojn8RJIu187/Rzcst+x+zMIuXRoLa9Jg4xKktTiQcyC/jy0SLNUf
	Sz5VtVABEuQFd7aK0OFDMYjPaKl0b+zytgAD71VtwCSV2Ij3w==
X-Received: by 2002:a05:690c:86:b0:795:905:c047 with SMTP id 00721157ae682-7976bdbced2mr24689117b3.3.1770911790314;
        Thu, 12 Feb 2026 07:56:30 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:58eb:e736:5178:28e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c254daasm47750937b3.44.2026.02.12.07.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 07:56:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] meson: regenerate config-list.h when Documentation changes
Date: Thu, 12 Feb 2026 10:56:19 -0500
Message-Id: <F7A2C039-32D1-4F1E-BFF7-2030FFEB06A6@gmail.com>
References: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Evan Martin <evan.martin@gmail.com>
In-Reply-To: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
X-Mailer: iPhone Mail (21F90)

Apologies, this has a rather obvious bug:

>=20
> Le 11 f=C3=A9vr. 2026 =C3=A0 18:51, D. Ben Knoble <ben.knoble+github@gmail=
.com> a =C3=A9crit :
>=20
> =EF=BB=BFThe Meson-based build doesn't know when to rebuild config-list.h,=
 so the
> header is sometimes stale.
>=20
> For example, an old build directory might have config-list.h from before
> 4173df5187 (submodule: introduce extensions.submodulePathConfig,
> 2026-01-12), which added submodule.<name>.gitdir to the list. Without
> it, t9902-completion.sh fails. Regenerating the config-list.h artifact
> from sources fixes the artifact and the test.
>=20
> Teach the meson build to depend on the Documentation files that
> generate-configlist.sh reads by having it an additional output as a list
> of dependency files, since Meson does not have (or want) builtin support
> for globbing like Make.
>=20
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>=20
> Notes (benknoble/commits):
>    Changes from v2 (<c9ae171eed6bd5b0fa6671b10a5ad0da024f36d0.1770649805.g=
it.ben.knoble+github@gmail.com>):
>=20
>    =E2=80=A2 Pick up (and tweak) Patrick's depfile proposal
>    =E2=80=A2 Include the script itself as a dependency
>    =E2=80=A2 Escape output paths (spaces, octothorpes, and backslashes) fo=
r Ninja
>=20
>    I'm not 100% sure I've actually done the escaping correctly, though,
>    since Ninja's source says that a space preceded by 2N backslashes
>    represents 2N backslashes at the end of a filename, and
>=20
>        =CE=BB printf '%s\n' 'foo\' | sed 's/[# \\]/\\&/g' | xxd
>        00000000: 666f 6f5c 5c0a                           foo\\.
>=20
>    So would they interpret that as the filename 'foo\\' instead of 'foo\' ?=

>    (Or, no because the 2N slashes aren't followed by a SP, but a NL?)
>=20
> generate-configlist.sh | 10 +++++++++-
> meson.build            |  4 +++-
> 2 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index 75c39ade20..091efd4564 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -2,10 +2,11 @@
>=20
> SOURCE_DIR=3D"$1"
> OUTPUT=3D"$2"
> +DEPFILE=3D"$3"
>=20
> if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
> then
> -    echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
> +    echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT> [<DEPFILE>]"
>    exit 1
> fi
>=20
> @@ -36,3 +37,10 @@ print_config_list () {
>    echo
>    print_config_list
> } >"$OUTPUT"
> +
> +if test -n "$DEPFILE"
> +then
> +    printf "$OUTPUT: %s\n" "$0" "$SOURCE_DIR"/Documentation/*config.adoc \=

> +        "$SOURCE_DIR"/Documentation/config/*.adoc |
> +        sed 's/[# \\]/\\&/g' >"$DEPFILE"

This also escapes the space after the OUTPUT: prefix. Will try to find a dif=
ferent way.=20=
