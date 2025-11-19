Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2032FA0E
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563709; cv=none; b=V1VeiDCD2T35+Lala9iskfruX+lZkIUXEhLRmbzGEvCg8kRBkIJZv9g0PwtHVtL0Ow2OK/2ibArXaMXEEZWM9XTpW385WaHr75imVfhDMePiavJ1pyT1JniJNCcaPKfa+ZPTLjOZS75iCoE0hcEYNzyMNIaoFQVHVvMZbW42WfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563709; c=relaxed/simple;
	bh=4jKNVhEDeUWQSR8Ev8GpESx+A+Fv9mPucZQEOA/YfbQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=e6dVkFnNioVioC17Bg6iYs2YHDy4v3unJRBtusTilFqI3a4leI0r96naZfYzJFfhWK8JYntoTTUIiB8fxHLzh97XXEnd8ixz91Rtc7GRZBad661YkC9NbmAK5rH2SifyWGyO3zXRyQKLWNBVwsWi/+yciCTuEfG2OE8mL/TbwQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtGFyBZR; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtGFyBZR"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55b302b8369so2601246e0c.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 06:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763563706; x=1764168506; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u942J9n5kAyK3n+6YjDyOjjs/BK5iUfTeIXtwjcC9AI=;
        b=XtGFyBZRcZSyNRUTaeh+ym3C4B7JzVYGUhYryVDy0QHa5r1K2vhng0Y9tB7DTn5wxF
         NGC5hcBbxqCYeFbl9j1mMkrnvie4MkgRZq2KLUKvctztOIRnmyFcvrz9Oah94Si0RSTj
         VZkGxpXmKuVVX+B1O+axnWI8ZFDg5IrhJ9buQ8VBDR37xfBtm20bQkcn33HzTFQ+a0t+
         keoDyaAE2WxPg/h1GDA7TP0Be2mCQkHPEZZAVBCIhYMA+gqmwWT1x4pVwCSyldPWENkF
         ug1p2JcZK6R44xmNReEq0yOXsCeYWKvwSyFnI3UHepnFGMOK4nY5N7rBjs7kOg8QPrSO
         7rdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763563706; x=1764168506;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u942J9n5kAyK3n+6YjDyOjjs/BK5iUfTeIXtwjcC9AI=;
        b=Dx4Ec09vgiOueHKxfLtgvzdgIm3saOBbXrIyw5r8V/Wv/MxurjSYwd7nmlCqi/JgtB
         eunqOmg6aPaAAmC33TqXj6c0Gnio2iJSBv5gfSDzy9wACf9fDY2mRmLAi3+MHUFROpn9
         kjn1E4y8fgwd+caDI8VcHHXp9bX2firF/LJvhobxoNZYPbZjCamrXxF0HNQ4Efh5kEFk
         EUOTM5rTFyfQjDxm2qGc5iiUCjj8RtMWxCTEv1PK0jy3L820GCavTEp1SEzB7eeUxb78
         w7M4Nzk/4AJehIOFqehqq9tsttwV4daCMyUWth1jPfHCfGDndnaUX6FSeJyTfgKLK4pp
         1WJw==
X-Forwarded-Encrypted: i=1; AJvYcCU68xHMvpTaoxMiVFoUOhVrB3Pw5SjpDZ3nl2eVJU2AoH+xhHRg7UCJ1GnQ7EtvyNbBMKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9piMyMeakpQR7/hZp10CQR/PEh4dj1r1hnlPKVs+UJgzi5xg5
	wN/t3ZJxhqzYpfro2cNfNfgnGRRSnT70sqmhTlUqp7z3v1D00PZgeWwWupalXpYQcGGiXL+frzy
	KDCYvSL2lI2plX1vOuX46kDg3e9PBUguZ6w==
X-Gm-Gg: ASbGncuZt3BoJZ5Dlfti8UzEqvWPqlTl7m/uxtgFqcGy0wZZDDEgiu777xjL/rfsGir
	mkENVhPYfXlp7cYImjaW5wVlnI2KtpFafIm6MlI7k960pz43JYl8CKJwyG8CuNBVQ9m1qaxoJB1
	l03qrPmKxFXUiM5BVbhsrrw8jAP6QSbqrcg9jkYQ4/Ih8v2HjgP9P3wv0rEUjjUblGUca0YWg6l
	kXo0tEbo13AXsj0O6rzVw0M6WOhoILIa8zgHxrE60TtOHctrkbT0/cKMZl2KZUlOapcl6dV6vrU
	srUz
X-Google-Smtp-Source: AGHT+IGFTdDZZm79e+H9ROGg/cShPjK4OXTpuVSPGymrAp+TNNsWOeLhXg4RE4kJviBUs0gsep3xZVjh4KKv0pElaI8=
X-Received: by 2002:a05:6102:a51:b0:5dd:b0e6:c4cb with SMTP id
 ada2fe7eead31-5dfc54ac883mr7269285137.9.1763563706281; Wed, 19 Nov 2025
 06:48:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 14:48:24 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 14:48:24 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-11-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im> <20251119-b4-pks-odb-read-stream-v1-11-adacf03c2ccf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Nov 2025 14:48:24 +0000
X-Gm-Features: AWmQ_bkDNU_FzDYf4JXAAJjrCvKTRcCUTbnF-ZYTC-UoGzGOTCnNbSVKVf-4mww
Message-ID: <CAOLa=ZQDqGLh3hrV6T32mdrb1Z-nrVh-zkgjgfoHJrmrTRSWFQ@mail.gmail.com>
Subject: Re: [PATCH 11/18] packfile: introduce function to read object info
 from a store
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000409f210643f3aca8"

--000000000000409f210643f3aca8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Extract the logic to read object info for a packed object from
> `do_oid_object_into_extended()` into a standalone function that operates
> on the packfile store. This function will be used in a subsequent
> commit.
>
> Note that this change allows us to make `find_pack_entry()` an internal
> implementation detail. As a consequence though we have to move around
> `packfile_store_freshen_object()` so that it is defined after that
> function.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c      | 29 ++++---------------------
>  packfile.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++---------------
>  packfile.h | 12 ++++++++++-
>  3 files changed, 69 insertions(+), 43 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index 3ec21ef24e..f4cbee4b04 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -666,8 +666,6 @@ static int do_oid_object_info_extended(struct object_database *odb,
>  {
>  	static struct object_info blank_oi = OBJECT_INFO_INIT;
>  	const struct cached_object *co;
> -	struct pack_entry e;
> -	int rtype;
>  	const struct object_id *real = oid;
>  	int already_retried = 0;
>
> @@ -702,8 +700,8 @@ static int do_oid_object_info_extended(struct object_database *odb,
>  	while (1) {
>  		struct odb_source *source;
>
> -		if (find_pack_entry(odb->repo, real, &e))
> -			break;
> +		if (!packfile_store_read_object_info(odb->packfiles, real, oi, flags))
> +			return 0;
>

Earlier we would try to find the pack entry and if we did, we would
break this `while` loop and fill in the object information. Now that is
part of the `packfile_store_read_object_info()` function. So we simply
have to loop until it returns a success.

Speaking of which, the loop simply exists to capture:
1. Trying to read objects from a submodule, so we add the submodule
sources and try everything again
2. If its a promisor remote, we try to fetch and try everything again.

[snip]

The rest looks good.

--000000000000409f210643f3aca8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8027a5fd9541d97e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rZDJMQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWk5REFDUno5a2NNNmRJank1eHp5SEVqOGNPVGNMMQpobDlET1R2R2RI
MzNhR2VtNWZmR0E2NnhnVjVnUklYMUN3K3NkVU9uVDJsVEV1MkpwMnRSbHpQOEhmVzhRK3NSCk5X
dEQ3b05lOXJpZ0kzNFI3cUM4ZjczajV5OWlqM2tSV01Yc2ZyV1kxRy9QRkNjVmp0c25JZ3JteEZS
c1RmR04KNnNEbStPR3hsaWVqM0tVMjhoemE1cW5GeXU5cUdWa1FGM3Rzb21PdWpZWUJSZlZNQVd3
V0lLTVRSWW04TjNWTgpwQlhiU1VCS1dkVEFid0NaRVdLT2MzWVJESlJMbXJvZVJob0c1a3E4Z0RM
WHRkOTJwOE11NzJqSDYwTjRMd2djCkZEVzR1cDM1RXNUU2F6S00rMU03cThDcVk3dTlPdUdFNXY2
ZE1yY1FEVjFKTnZ6NkQ1MDFFcWlCQ2VOV0Z2b3AKWUZNUlJjU1Rwd1lIR1Q5ajJHNDNNY2w0WEFZ
emhLdGtKelBNN3Z4U241Zi9BVjVwaEFvaTBJSHpyUE9TbDA5Ngp1Sld5R0JVRlJsbzJrK2dxTkZz
VFlFcEY5N0diM3BjeW1ubmNib2JxSC9IRDN3Q1pON1pzdnkrU1RJTGhEUXNICkRXTXNDZ3h4M2c3
Zk9XUmVKYkJsaVZ0QXdNaC82MzB1K0N6eEt6WT0KPUZIQkQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000409f210643f3aca8--
