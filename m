Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B03527FB0E
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424777; cv=none; b=qD4HMWL2/lhX2DtStepXgs+ejoxDayP5C9q6qDyzrkPbDliX7mDTv2j0kcboN5KnBlIADT7McnZIWa4BVfg5KwjTfurRNO9F45m7CznHlzDYZWdv8iPYRD3Pu1PB+s9KzXiYs4CiYyY221mhVYWLUYMCGUiMantE6ij5G8EBMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424777; c=relaxed/simple;
	bh=jz449PmmX46aaTyXmaAs+tMGvME6yTE8gfbuqBuRzsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SetsaGlwLV8/wsTgHogdwuRYjkv3TRBG2RKal7skgqR6Zjs9NqPvTP6kR1wQ0dOKCK377pCvNOJe+bqkjGAjTQBSgIcSRdcgbSSKYYv4dVffJRwDkFnuDqicGYxUmcXPr0coD95Rs84/nyyvz+UHYC0wzvcuQF2F6zDUtJzlEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=AzsTEbV8; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=cZRxEpG4; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="AzsTEbV8";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="cZRxEpG4"
DKIM-Signature: a=rsa-sha256; b=AzsTEbV881/MbOGsXxOqTBJeCzHmBJzXat6cYtZo5zhDcLES1lXNfH0bHYKtMt1cSJ1pT1Jeo42C84evXc9jBjHFVGjGJbiEwlkNxw+FmUlC7UO8FyZai+3W7io72HNJy12EQdDKNNwz05o09wboCIQEF8k6hv+ROw4ktNWJ1UjbdDbsUYVPWs3zolZYaV7Jh6V1vRzaUUI9rfBeXqzHxJhdXb7w2u34r7b5/RAIisJAGP1QsJ5+qF/2myRPArzMspCLwPl/pxsxp8lwkcGN5FoSnKs4iCV3NiCwI6ZRkuU6vyMj6RqurlWojQD+LNa5ZqaMDAIJ18935DInddmoTA==; s=purelymail2; d=malon.dev; v=1; bh=jz449PmmX46aaTyXmaAs+tMGvME6yTE8gfbuqBuRzsA=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=cZRxEpG4cLzZdzXyATPbWjTGDQBkVmR/nOX5GROVpU8HcVpsQWCWAGDHbYwrSyNAHvf8IsyHL0mx55LzW3wei2dPU3VQMNelW2BbQ64LehNoNn0c8ocw3mItlzRwC7pEWTSbK2+J2j0QqRBHAj3TD1U945oij7sBBD0XX6XTjHjO/mGnHrRdPvwCWD/AANRGBYpOjSlmjuAfFyTdBd9+MBN05XLyphKD5Z3FTFShekeXWydjY+jC27OscKJsqSW7gQEMiNru3EdsToeh1japwGzywT68cG7SvOjD/AogqXf4nICNxEBok7RyppMkIEI5hDyIxd3BzPo4v9pdLXcYQw==; s=purelymail2; d=purelymail.com; v=1; bh=jz449PmmX46aaTyXmaAs+tMGvME6yTE8gfbuqBuRzsA=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 27237524;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 13 Mar 2026 17:59:32 +0000 (UTC)
Message-ID: <9afe48e3-8348-4e2c-8e5f-bbdc3b2951f8@malon.dev>
Date: Sat, 14 Mar 2026 01:59:28 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH GSOC] diff: use conventional comparison order
Content-Language: en-US
To: aum2357 <ahambrahmasmi2357@gmail.com>, git@vger.kernel.org
References: <20260313140440.564201-1-ahambrahmasmi2357@gmail.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260313140440.564201-1-ahambrahmasmi2357@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi aum2357,

On 3/13/26 22:04, aum2357 wrote:
> diff: use conventional comparison order
>=20
> Replace `0 <=3D addremove_explicit` with `addremove_explicit >=3D 0`
> to follow the common coding style where variables appear on the
> left side of comparisons.
> ---
>   builtin/add.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/builtin/add.c b/builtin/add.c
> index 0ee21692c2..ad0d6047af 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -432,7 +432,7 @@ int cmd_add(int argc,
>   =09argc--;
>   =09argv++;
>  =20
> -=09if (0 <=3D addremove_explicit)
> +=09if ( addremove_explicit >=3D 0 )
>   =09=09addremove =3D addremove_explicit;
>   =09else if (take_worktree_changes && ADDREMOVE_DEFAULT)
>   =09=09addremove =3D 0; /* "-u" was given but not "-A" */

I guess this syntax is probably intended to prevent the compiler from=20
not reporting an error when someone accidentally types '=3D'. But since=20
the code is already written and runs fine, isn't it a bit unnecessary to=20
change it?

You can try a command like

> git grep -E =E2=80=98\(.*<=3D.*\)=E2=80=99

to see what happens. The codebase actually includes both, right?



By the way, as far as I know, no country allows numbers to be part of a=20
name. In other word, I don't think 'aum2357' is your real name ;)
If you've browsed the mailing list, you'll notice that everyone submits=20
patches using their real names. Please adjust yours accordingly.

Regards,

Yuchen
