Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795690706;
	b=weXeX+aJS6f2y5AjO4Z7r6qdg0xcPmwuD7GMQrZudXI2aiDVVE7muNhDt/R9ZQDYvoOm
	 adUCZWU9W/W/LmYezPjDYm0o9j0WGQRbECRhVR2XO8CgC+BtNAFetfqxEV5lI3VpSmVaR
	 sc+9ld6gnR/8cggg0tO0n6C4Br0nL1/ezDXx3X8p3U2GarFvRFLvGNJPfZoc9e01sW+Bs
	 107PBRO1Ukcj7H+1HMEu8gToDANXuVdN/0m20sPH/TKw+LvYHLI5BzOjb3bSko8wb2DJy
	 6+rST3pY5kMwAu4qwYP0vRnUSQFtDx132IIgcNBmvTecVd0byMof56l19otfIAMxcLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=T5X6epvTO4HZYRf+pUzxf7gUOSzB/Yiq6XLpOskOd+I=;
	b=KfNyv6CDkeBMmTCSOxsU9xzOYXEZ5r77oSmmFsrpQDaJ38S0ZXDRxc6QOX0JQ93s4oTr
	 WtDRWuz40K5vLBErUQcNe9vVaD+8WqwydY1AE+i23ocrZPryDgASI2aXAeih6FVRoSZ/l
	 ZDS0mNs7GHTo5TX6uYf7CSgLZOG5EVVsCipT5BZOxJ+B6r0eDJcbT5F2JPQqtf9S3rplQ
	 PBK/fECkX2o2L+iUVe86pCkmhp3WJDFpjCj4eGc7XQXeo4QKyX/gpvAWzlywOmWAiq5Ri
	 0R+WOiD54K39p3vX03ow5+ysGYI1oS+PWgdxTOakSblP/euBRHg77bTYu3YyPBXiTfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xeoUbDSS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A2606A6B8
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 10:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF1A2606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xeoUbDSS
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b3acec6677so10417148c88.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 02:58:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795690705; cv=none;
        d=google.com; s=arc-20260327;
        b=ZbNJ5vJJxdGupWPBQiQgna9B+WMCpo9SGtg7q+jCOOsnemLqpuhfkqXErTCmWBmqvG
         guJl25pgu0rDOiEf9RhspuIGMPMtWNtceoLcav9rxs8JoQWM/u/e4ws2z8ILIY8zQqGK
         yVZw8viF6/y/2Miom06PMgbHT23+RQ+qiVA9Sd9doWXN4uBb1K+Tu+BLiE4mmw98uP8A
         RsOPK90lQzbCE+6mBU6pvEMRlzBRXMPvsawpimRFboSujUbNXaabSBlxq3u+1DY2n+4m
         0MqKWKDjW3/p/WVYPRSVXMXhs4+cgaNu20Xa6RT3ZwwNyj1AT4uqXRb+buiAx3M8w2nC
         7waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T5X6epvTO4HZYRf+pUzxf7gUOSzB/Yiq6XLpOskOd+I=;
        fh=bhSy1WOsmK7YFf0taxJkRvClW+ND6k4Ao0ureTbENak=;
        b=driIb8Nz9zg1s4NKyOh2TOI+hOAlD0+vmz+PjLPLXybtIpoaoOTvy2BfXFQLXMiAoK
         XpCjMDRvr0EQ34Z9NaTiWTmXxRepXnj69Zgq/b/5snmU8jWzPak1NLh0TWP/uuI/gAtj
         FdALYXHz9cch2BSrMrveFX4oXcqnfvOpe7hrOUiLaSlxHcpRUwGwqSkCXQSB02ThxJYW
         vfu+21QV4RhoSOP9ne8okzW64zHPVf9ObOhraU/ceOpRqUj2cajJSpiiqxsTbgK2qtg5
         htjs2hYN0Bn2F2+oDZPCP4hZUr9DnQjF/GLCQhDF068kMewiUubKh5qPYzdK00yKwLU0
         I64w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795690705; x=1796295505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T5X6epvTO4HZYRf+pUzxf7gUOSzB/Yiq6XLpOskOd+I=;
        b=xeoUbDSSyIFYG9Vk/Xgolbaiu/9CC3dAWWfMCxJD14DzNn/jv1qwLUIdT4m8t8nXTY
         JWgXC/ybrBQtkY5Vo4H8nSPUJMg11OtTcpPz6vLQ6pfTMGg7B1pC8Qkbw5URNVlBtSs6
         7hpfXX89+nduuYoGuQwqhzZ9i4D4U6vABAaoXGvMWfaRj7sZpSEZL7jqLCMxc7Jb9OWM
         muUC/BnwZCfN+BQ5UgUiulY4XLrHYnTWcrPprVgHfaPGN3KZdT7VhZC+wrKlqx1i2FI1
         bkRl4Qwi3yoILalFiadeqoaIzJ6bCSkdakkTnuqFgmv4tbcHVg+oFeUBYX0KUg53NhWX
         QhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795690705; x=1796295505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T5X6epvTO4HZYRf+pUzxf7gUOSzB/Yiq6XLpOskOd+I=;
        b=AWpZrs8I9p4WEoz7jND15MqXrQV/NrUJTJ2McfS4X445XV5SqsVl7k3AT2gjJ/n33e
         +SsLBRRdqdHdbqYtNM2y9a5OPtueJVe4vRUiOv8mcrkuk4CM3HK4jUiQT96qNncZuB9S
         bx7sMsB2iQx4xWI/6VnVteqbOi9Fd+1zC6xNkICNvguGD8ZG71/W3UzTEXQc4bDmzQyu
         VUKd0HFwdp7TcMWlkt3C5exVQUe7+T97QXINgegpYpQYVep+4C5xqt6Hanl4gG975PJL
         /WPtt0LJ6DdoScxnQtl/Gux+lDAdhKHtXZ/7pcNRrteoTEl+0XpO0l3JjjdFzDkuGSqZ
         HkoQ==
X-Gm-Message-State: APuU4Z/LI/GV25MgiQBhh45wVJqbPSnWt0Yb9dDi91zofsE2nt7Qj32j
	RMH6W8s0nB0wuF5gv2nfDizOAgTt2vD5TpP5F8plc9xCCCi6bR6WfCz6cX6IotbRv/k3bg1Bn4S
	KTQ5WJYpXfzr2Lc1ZiT+zuO2oAAJVY5k=
X-Gm-Gg: AZFdTZePigyIu3lWWfU0YLkD9hnLB7kGL0Cb5NHzZghwgykSWXG+rMXRBoRTsIBhSFo
	eldqiYSiqQCkNT19U2r0ndwDfUqV/KqffHNlQTvf6Nxwe31qb/oX3yPOUVVEfQgh3AuQ2TUfTIr
	jlv2fu1fnN0G0C1kHOIAXau/jYmNo7dfQ2WrOyxw9eRc2pC/sCChjpxVJ4ZePfHehfokOdkuOIE
	jJQ7x4Lcia+40kwFhFg+4TCFIi0EFqUwR8QtKWW86PB3J/2uwlYiF4ZyryHKZfK/asGGz04wwNT
	5WalFOFQDgR9kZkh3uVsQypHL7967Wa5STr+OhnHp3CWabJxNwgjAPmM8u929Sy8jadZgFhLgfQ
	gYSeLRytdQB/6yalq6jhpwDE4895ol2JUI7FtnuOBB2gYwkwWajBGtVKVGA7nmhS8bfQZR+8IZZ
	LbS3gied01uPBkESj7u9cW3cb9mbPcsXfO9UOOfSVqChSr9rZQ7CMNODME75VUtiNGqyJrDb2tJ
	liCc6tpykNGYf3FGF+agwV9
X-Received: by 2002:a05:701a:cc88:10b0:151:6e80:ba7e with SMTP id
 a92af1059eb24-1b5567dcec1mr19167600c88.4.1795690704938; Thu, 26 Nov 2026
 02:58:24 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2314.git.1794607911.gitgitgadget@gmail.com> <pull.2314.v2.git.1795571091.gitgitgadget@gmail.com>
In-Reply-To: <pull.2314.v2.git.1795571091.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 26 Nov 2026 11:58:12 +0100
X-Gm-Features: Aa3M54qS3F5xwJ2mOpx_YBWELNUfabgn61l7GoAdDPzgUZuu34tyi60iRAITtXc
Message-ID: <CAP8UFD1Yn5wDpZDeuNrzprFoACBgCn2o=eFOakyUjntQkEqxSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] repack: write filtered-out objects as loose objects
To: Adithya Chakilam via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Martin Fick <mfick@nvidia.com>, 
	Adithya Chakilam <achakilam@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 2:44=E2=80=AFAM Adithya Chakilam via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Some key-value object stores manage and retrieve Git objects individually=
.
> The existing --filter-to option writes filtered-out objects into packs, s=
o
> using it with such stores requires unpacking the resulting packs before
> importing the objects.

One could say that it's the existing `--filter=3D<filter-spec>` option
that writes filtered-out objects into a separate pack, as it does so
even if `--filter-to=3D<dir>` isn't set. This means that
`--filter-to=3D<dir>` merely decides where the separate pack will be
written. When it is not set, `--filter=3D<filter-spec>` writes the
separate pack to the usual "<gitdir>/objects/pack/" directory.

> This series adds --filter-to-loose=3Ddir to git repack, allowing filtered=
-out
> objects to be written directly as loose objects into another object
> directory.

What if someone wants to write the filtered-out objects as loose
objects into the repository's own "<gitdir>/objects/" directory? (Also
it looks like in patch 2, passing the repository's own
"<gitdir>/objects/" directory to `--filter-to-loose` might currently
cause data loss when combined with `-d`.)

It might be more coherent with how `--filter=3D<filter-spec>` and
`--drop-filtered` work to separate *how* filtered-out objects are
handled from *where* they are written. For example, with an option
like `--unpack-filtered` (or `--loosen-filtered`) alongside
`--filter=3D<filter-spec>` defaulting to "<gitdir>/objects/".

One issue with reusing `--filter-to` for the external destination is
that, despite the documentation calling it `--filter-to=3D<dir>`, it
currently takes a pack path prefix (e.g. ".../objects/pack/pack")
rather than an object directory. So its meaning might differ between
pack mode and loose mode. Still this seems worth thinking through
before going for `--filter-to-loose=3D<dir>`.

(Note that when I implemented `--filter-to=3D<dir>`, `--expire-to=3D<dir>`
was already passing a pack path prefix, so I thought it might be
actually OK or could be clarified later, though I failed to mention
it. Now I plan to send a patch to fix the docs for both
`--filter-to=3D<dir>` and `--expire-to=3D<dir>`, or at least to discuss
this separately.)

Thanks.
