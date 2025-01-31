Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C233EAC6
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334146; cv=none; b=vCJkcxspPeBXon+8VhaXZSkrUblXOt75bRxkFbfR75zw/B4FhBH6BirYFqDoN1jXEOQ0YA/mtVVtF9BDySSDKV5iPIqPczBRXLcEJu7eErYUJWHSR9HhcygdbyImRWjoIrH57zdPQzML+8eav5lK5NQxXgeyf7zeGRJ8owEp6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334146; c=relaxed/simple;
	bh=qsoOwxzaNHbM+oT+Yyzp9PvArHYapFoa1r0P4n29zCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwCRIwJoMGG3A6IDniJcxWmkXgZgnkKqMnxOtuNiJ4lE3IiAN6JvuL3VHTF88az1IuybM3MAHO536Fd+//mjrYbcnfGnsnHKRf79s8VFfdSO3osfR/houze3gPRwmqZL41uYWCsC52ESr+48umxVlcV0rHHKUiWLaHprPukxI3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e2460c6f05so1942996d6.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 06:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738334143; x=1738938943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnYjZXLl4HBy8baj8a9uVFlGbuNiuD729TCodAs3LGE=;
        b=o2+Igs20wD4B80vw02x6zUWhQFhe7FN14m08+vu49JHkAUveto2sY/KIUotWlANYiA
         ADoQ2PgtBm6EgWGTH4JfKMPUPOlTZo9kFKISeUO8xkQs+7/cts5R69ny5ECLF2NV+CP2
         9hsZKiSDA/mhIprNS3vbiCjLp7+HRPuExu6CxyW+WX3WZ2SAEt9QDsvlVdi3epb4L77b
         rIJigqw4A3sxU/Ph1zZHVc6C1FoZKAEYkvmRx3OBiDm+hAGCh79wmaOiibAnABRiF+Lz
         CbBY3dlxr7lv4ZuXWMpJcs3DmjVlcQRXVDuqpgC8K+s1/1vtMmTDIdr8qDNSJSYLLS23
         bLyg==
X-Gm-Message-State: AOJu0YzIniXDRI4b3J8vVMZnb3IFToZv4o9ngC0NuUuqgpmp9eHUwweD
	N/EWHQ11SW/VcDE1MtBHSNDNp7V7/H8ogrlKU33QK8/BA0r685D1qgveKOwwSRljJwEA9LTcMRp
	fbyTu32+1MJM+0+SryaAtIvxWINQ=
X-Gm-Gg: ASbGncuWXSiOCfoxSliz3PBBH8Ot9J7TYzw2mpcGpkb1swuTLV1cSsO+Q8MWrX1gdi7
	/TN55EBwObcdf/G18rsduwUGJu6PUma+sQHFLxyPJnX07Hb46rYbGQj8aEb4Z/eN3SFWtTN7WAM
	3FxthR8FRO+4NUSjHzEW2iyvAmZjBTJw==
X-Google-Smtp-Source: AGHT+IGo8Z9EplcafZLuOMcTrExKkSi4vkT2DTQH9VlywNskFWXegbXpOFq0oZaRorrdQOumng6CXlcsDAItpnrNdhg=
X-Received: by 2002:ad4:5f8b:0:b0:6d9:2fac:c208 with SMTP id
 6a1803df08f44-6e243c93eaamr61056626d6.6.1738334143034; Fri, 31 Jan 2025
 06:35:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
 <20250131-pks-push-atomic-respect-exit-code-v4-2-a8b41f01a676@pks.im>
In-Reply-To: <20250131-pks-push-atomic-respect-exit-code-v4-2-a8b41f01a676@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 31 Jan 2025 09:35:32 -0500
X-Gm-Features: AWEUYZng1fhE11IltsA2jWeIUG9_spnEN2Rn0G7B9ljytSEv0ktJ-mKLpoQ4LFY
Message-ID: <CAPig+cQLdyuhK4bgf=HDuX8nDdBv8Voqf0-EtQO-8f15sPOVkw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] t5548: refactor to reuse setup_upstream() function
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 5:53=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Refactor the function setup_upstream_and_workbench(), extracting
> create_upstream_template() and setup_upstream() from it. The former is
> used to create the upstream repository template, while the latter is
> used to rebuild the upstream repository and will be reused in subsequent
> commits.
>
> To ensure that setup_upstream() works properly in both local and HTTP
> protocols, the HTTP settings have been moved to the setup_upstream() and
> setup_upstream_and_workbench() functions.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
> @@ -54,29 +54,67 @@ format_and_save_expect () {
>  setup_upstream_and_workbench () {
> +       if test $# -ne 1
> +       then
> +               BUG "location of upstream repository is not provided"
> +       fi &&

It's not clear why &&-chaining is being used here considering that
this function is not called by any tests and is itself not linked into
any &&-chains, hence the use of && is superfluous and misleading.

> +       # Assign the first argument to the variable upstream;
> +       # we will use it in the subsequent test cases.
> +       upstream=3D"$1"

Comment doesn't seem to add any value.

(Neither of these are worth a reroll on their own.)
