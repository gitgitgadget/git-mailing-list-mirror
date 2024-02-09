Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997D4D58C
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494477; cv=none; b=TJLZXWM2/qK0RoXmECSVHayfoqiQvVuHvaRsZC0lVo4xdFr7dZIA4d3vYlLqQJJoveKfyS4IbJnJ/drlmuHuNraJYZs6HTMwjNZkmG5eP+2jTjmsXOsg/cYrdo3MsYpmA1DAZvcUOC7aJxBTNdAf/aQI1pch+RbUdccThQrnERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494477; c=relaxed/simple;
	bh=DgNBX9LRpObqzPb1CCnFW/A2caPEllc07U46xHpoNgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ht+X5MCFxwQf/ukcQvyjNI2GcjxA0DjfLXCx5vc4NPRJC1+t0QJDYsGIDrB8eweVwiDaZQFmipSbJDdrwjrKX5lt5n53jV1zOTtMi0JXyiO64qGumK/qSjh0t4Z0FzSgzo3xldDDzIRkIvF0rHB3IP1kobgODiQ8cGwfgysHKcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2QqTkxe; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2QqTkxe"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4280f3ec702so3902711cf.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707494475; x=1708099275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy1OJdI5TxuwDRFduk8xTdSb0CC0pEkDDis/5q0/r/w=;
        b=C2QqTkxeveF+2ym2xaO4B/0bM+cgunT9NlAPZg4InRGAK6G6oq6ntWCLC45wpnNbAY
         58XlFLMnoDlYE03lyMGngsM0md/mTxsw2P6lvgsv+7SeqeCEzCMSalZEMwDAYR4svnIl
         XJyeM1saTxv6U2DYQVDNCHe6Q//B9Fuo+X4fOR8GKSaQGqvhBQtsFSJHhuKQfPmASnmW
         7AIQP8CbQFNN+COkhwtX77EqARSEpyVzXKVrSnCt7eWr+phjCmRua04cR60qr+fHl12H
         TbsRNqQ5donRJwOHBVh1xVgf1aJvmwhS5v+AV57mrIlitAniJaZWYR0lzvQ4QRpOnMQL
         MRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707494475; x=1708099275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sy1OJdI5TxuwDRFduk8xTdSb0CC0pEkDDis/5q0/r/w=;
        b=HwoHOsW0lGn6JSOUz63DtrB/+ViGnMtMwymjnJxd55vPygJK7r4oTSJPJvFdYb3gwJ
         dAcB4Rx0b5YEDRYlkigRwxg1iSP3Af8q5mSdVsmwXoM3qie1/BdLpLhCd1VRWj20smz4
         6w/V7InBCldwi/DsflrpFG1LgXNq0uRJo1ZvVQpLTOF5a6ZpmTZ7BLRFPNpG8R7InMcX
         FMaL0gwD+y2zfPOw7YLrb0mrgt7UUzsf32Bs67jM6HeRsOUnkm5Cfc5Lz96HAnr0eG1O
         Nqnx/g9ElSRslFb2Wba6Sl54iko8wxMyVxfz6dPKV4Kb5kh/eBSn7UyC+NUrKPwWtjaV
         qoAA==
X-Gm-Message-State: AOJu0YyBj7OoO5QrGu5EiFPAGT1brdmPnfTot+WsvXU685ugg0SWFEfr
	0qGW8rS1yEhDUvodEgrkjcFdfwLIUA74JdBPNImzMq/QmtawMUASZrx3qr4N
X-Google-Smtp-Source: AGHT+IEAPJmf19AQw7/Q4NvV87liNdnp60nuk/+0V0SwSLCVEP5337LdpL2YPY7SZhlrQOyonMXMsA==
X-Received: by 2002:a05:622a:1894:b0:42c:27e4:23f7 with SMTP id v20-20020a05622a189400b0042c27e423f7mr2367536qtc.4.1707494474593;
        Fri, 09 Feb 2024 08:01:14 -0800 (PST)
Received: from [192.168.1.240] (ool-4570b665.dyn.optonline.net. [69.112.182.101])
        by smtp.gmail.com with ESMTPSA id x20-20020ac87314000000b0042c5d1fba38sm424886qto.15.2024.02.09.08.01.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:01:14 -0800 (PST)
From: John Cai <johncai86@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] reftable/reader: add comments to `table_iter_next()`
Date: Fri, 09 Feb 2024 11:01:13 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <5335108F-4A21-4429-9BDF-3923D96884C0@gmail.com>
In-Reply-To: <2f1f1dd95e1cc360bde3547bd18e227a9c326e13.1706782841.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
 <2f1f1dd95e1cc360bde3547bd18e227a9c326e13.1706782841.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Patrick,

On 1 Feb 2024, at 5:25, Patrick Steinhardt wrote:

> While working on the optimizations in the preceding patches I stumbled
> upon `table_iter_next()` multiple times. It is quite easy to miss the
> fact that we don't call `table_iter_next_in_block()` twice, but that th=
e
> second call is in fact `table_iter_next_block()`.
>
> Add comments to explain what exactly is going on here to make things
> more obvious. While at it, touch up the code to conform to our code
> style better.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/reader.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/reftable/reader.c b/reftable/reader.c
> index 64dc366fb1..add7d57f0b 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -357,24 +357,32 @@ static int table_iter_next(struct table_iter *ti,=
 struct reftable_record *rec)
>
>  	while (1) {
>  		struct table_iter next =3D TABLE_ITER_INIT;
> -		int err =3D 0;
> -		if (ti->is_finished) {
> +		int err;
> +
> +		if (ti->is_finished)
>  			return 1;
> -		}
>
> +		/*
> +		 * Check whether the current block still has more records. If
> +		 * so, return it. If the iterator returns positive then the
> +		 * current block has been exhausted.
> +		 */
>  		err =3D table_iter_next_in_block(ti, rec);
> -		if (err <=3D 0) {
> +		if (err <=3D 0)
>  			return err;
> -		}
>
> +		/*
> +		 * Otherwise, we need to continue to the next block in the
> +		 * table and retry. If there are no more blocks then the
> +		 * iterator is drained.
> +		 */
>  		err =3D table_iter_next_block(&next, ti);
> -		if (err !=3D 0) {
> -			ti->is_finished =3D 1;
> -		}
>  		table_iter_block_done(ti);
> -		if (err !=3D 0) {
> +		if (err) {

what's the reason for moving the if statement that handles err down after=

table_iter_block_done?

> +			ti->is_finished =3D 1;
>  			return err;
>  		}
> +
>  		table_iter_copy_from(ti, &next);
>  		block_iter_close(&next.bi);
>  	}
> -- =

> 2.43.GIT

Thanks
John
