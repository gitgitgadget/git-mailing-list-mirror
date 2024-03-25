Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECDC17EB6C
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350517; cv=none; b=LvFn5X6+ocYRSuTs5Ax0hOsROuPBRqKXuvVd2HPoq3sTgoLqkTRaECT7PcM3FEc4Dos8gn+t3ep+2xmY+Sbl0VRVw/vgLyg1C9Ow7W2RqZpPsDQJp8jqAAEaGQhSotj3pQrUOr1FfjBLeuXF/Z9+zQdpyQDmomlq7vYlb8yBLHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350517; c=relaxed/simple;
	bh=hxAgvJnabppe2xpNuPgEe+GwifC1hnvBCdh9Vk3TXUU=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=hv5/vYJfHGTdwX3dIgv+Czj/7cCrcMd/9K2dANd8HCEldD9etT3ljoC/NEU65RW+tV7UHuZbXaiy+Ydy9N7c/13JWvbU3qx3nqDFfY/5frdu8cRvio//U6LHRS/ic+Z+Jvh6K0Dr6duu8iw/oAqKb3U2mXKoOYwu9sRwIPhdCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H27XXUpV; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H27XXUpV"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a529a1f69aso997930eaf.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711350513; x=1711955313; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CODmWcs+A0O9Z/iggTI/Hwd3YTX9wUguetOHyDefAao=;
        b=H27XXUpV7bwQIDObgRmkd96DHQU8j9tSnGyevmEV4bzvo/attaguHyNB7Fmz/zoNVB
         HocA/hnbF5PhcpzQA/AyHCxxGlp4O5nYJiC2kgde32ICP8ykuaTS5hhmYSiMiI5KSv4m
         d/jKQxiWlPN3YebL8ICe409j65IGsKskFYE5sivK35u8nqwJoKRcMuZdf3GNN1UB7OTK
         Nf56CofjgHBwV9CRnBPJ/HFsu0MN/rj/xTOpZIXmQPuMKtRE3yp03Tqz9j+d/9ri7Hm6
         dHw4tBhi46F1Jm4Pg+NkLfK2uMjYS5ZCv4Ies5rC1leLf/gNXK8IQY851v5VDCOpvrug
         2R6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711350513; x=1711955313;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CODmWcs+A0O9Z/iggTI/Hwd3YTX9wUguetOHyDefAao=;
        b=OejxO9HwgvrL/YmgXkU4hb6gQYeVlQyM7S36pPGy+mhXYeltN6PVQB/zVPlAbg7y8f
         VFeMTgT8KVxZgLLPa2O2KMLz1vi45h8N307OYNjZNy0vKDRlO1jThbkro3RPhmvWqVRw
         JzKn0nWdune0Fz/AOzkVazisf/FPvskuvW4MHu8ovyyHCDoDM/4cHvgCnPzwt9qhG4oP
         R+lheEZfaFCc81UW+UCUlwkQC6Tsp3Nh00osBeQHyw/sjY9dtTVJhoe+i0t7bEwWETig
         M9zEJ3iaNAZldRQ8dJ+8XkyyC4llIaJhq1d4sfMabpQ1JSo763kgfNFoNnzE2OSafotz
         zt4g==
X-Gm-Message-State: AOJu0Yyf+VnAuif2mc7CFJIoBObjzvduSVJTZKm4A/g27gYFcf66nqL6
	8Oah8YGtMAOql4WgFepdlh4H/QCljo315/rALUQaJAgskDRAF8ARBf4KM07u
X-Google-Smtp-Source: AGHT+IHaUHmKYnnH3/kn9d9kNoRbn0SQdRfj+Kpa6ODpUnoyuGVWOcmvMMiIwpHj9IV39BEw8SBKPA==
X-Received: by 2002:a05:6820:2111:b0:5a5:639a:2fa0 with SMTP id cd17-20020a056820211100b005a5639a2fa0mr82416oob.0.1711350513406;
        Mon, 25 Mar 2024 00:08:33 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id cr10-20020a056820250a00b005a0fc5a89dfsm1341426oob.5.2024.03.25.00.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 00:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Jeff King" <peff@peff.net>
In-Reply-To: <20240325061452.GA242093@coredump.intra.peff.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] pretty: find pretty formats case-insensitively
Message-ID: <17bff03951f07360.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Mon, 25 Mar 2024 07:08:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Peff

Thanks for the review.

On Mon, Mar 25, 2024 at 1:14=E2=80=AFAM Jeff King <peff@peff.net> wrote:

> The mention of "recursive" in the function we call made me what wonder
> if we'd need more normalization. And I think we do. Try this
> modification to your test:
>=20
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 321e305979..be549b1d4b 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -61,8 +61,9 @@ test_expect_success 'alias user-defined format' '
> =20
>  test_expect_success 'alias user-defined format is matched case-insensitiv=
ely' '
>  	git log --pretty=3D"format:%h" >expected &&
> -	git config pretty.testalias "format:%h" &&
> -	git log --pretty=3DtestAlias >actual &&
> +	git config pretty.testone "format:%h" &&
> +	git config pretty.testtwo testOne &&
> +	git log --pretty=3DtestTwo >actual &&
>  	test_cmp expected actual
>  '
> =20
>=20
> which fails because looking up "testOne" in the recursion won't work. So
> I think we'd want to simply match case-insensitively inside the
> function, like:
>=20
> diff --git a/pretty.c b/pretty.c
> index 50825c9d25..10f71ee004 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -147,7 +147,7 @@ static struct cmt_fmt_map *find_commit_format_recursiv=
e(const char *sought,
>  	for (i =3D 0; i < commit_formats_len; i++) {
>  		size_t match_len;
> =20
> -		if (!starts_with(commit_formats[i].name, sought))
> +		if (!istarts_with(commit_formats[i].name, sought))
>  			continue;
> =20
>  		match_len =3D strlen(commit_formats[i].name);
>=20
> And then you would not even need to normalize it in
> find_commit_format().

Good catch -- you're absolutely right, and simply switching to
`istarts_with` is a more elegant solution than my initial patch. I'll
switch to this approach in a v2 re-roll.

>> +test_expect_success 'alias user-defined format is matched case-insensiti=
vely' '
>> +	git log --pretty=3D"format:%h" >expected &&
>> +	git config pretty.testalias "format:%h" &&
>> +	git log --pretty=3DtestAlias >actual &&
>> +	test_cmp expected actual
>> +'
>=20
> Modern style would be to use "test_config" here (or just "git -c"), but
> I see the surrounding tests are too old to do so. So I'd be OK with
> matching them (but cleaning up all of the surrounding ones would be
> nice, too).

Thanks for the tip. Updating the existing tests in this file to use
`test_config` looks to be fairly trivial, so I will start v2 with a
patch that does that as well. I'm opting for `test_config` over `git -c`
for no real reason other than they seem roughly equivalent, but
`test_config` still ends up calling `git config` which seems slightly
more realistic to how pretty formats would be defined normally.

> PS The matching rules in find_commit_format_recursive() seem weird
>    to me. We do a prefix match, and then return the entry whose name is
>    the shortest? And break ties based on which came first? So:
>=20
>      git -c pretty.abcd=3Dformat:one \
>          -c pretty.abc=3Dformat:two \
>          -c pretty.abd=3Dformat:three \
> 	 log -1 --format=3Dab
>=20
>    quietly chooses "two". I guess the "shortest wins" is meant to allow
>    "foo" to be chosen over "foobar" if you specify the whole name. But
>    the fact that we don't flag an ambiguity between "abc" and "abd"
>    seems strange.
>=20
>    That is all orthogonal to your patch, of course, but just a
>    head-scratcher I noticed while looking at the code.

I agree that this behavior is somewhat odd. I'm not sure what we would
want to do about it at this point -- any change would technically be
breaking, I assume. Regardless, not something I'd scope into this patch,
but good observation.

--=20
Thank you,
Brian Lyles
