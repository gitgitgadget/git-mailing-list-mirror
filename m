Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A423126D0
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563747; cv=pass; b=kuJjCnvbGIMtHdO9vMRb+HbYqpCF1hzSKvRkT2zowS6ormq0qeKubsAs2TmSw28wU1qXzz4+m1BO961TDXsfz7afq64/0VaujVtD9FgN0UXzGQEPA9utNyjvQ5Wa2W5V2Xog92XpyOKQIu+WA7cn8cmHB11yQIQ9sOUJkgRSFlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563747; c=relaxed/simple;
	bh=hhC7PT8pI0A6oiG9mVuOp7u6taKhh0DIGLXlLmdbZNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJU2hRKHymMHuhHSUx6bABRfA8xLqNSOXVkfcy68gW/zXEefaAKFzcC+BeF2OqpxMA43USL4ohLqMhncD/Vwi4nmzoQY+Qxck4HSAg2iC3EDY0M1Az5oFkZhbK5oTn5jLPc4e3s8lQg6KDFaR2IWQ82QroIl8yTiYWVCO5qyE8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiKUp6/+; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiKUp6/+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae41544dcfso36379445ad.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 10:49:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772563746; cv=none;
        d=google.com; s=arc-20240605;
        b=gxiCocPLjTbgliKftWWA1tckObR2Ag3TbQ+aSMlgrgmUIk0/uuA3ddgXoMisyR/qW/
         V2pJZegwsLakb1zjre2lTBfSE1O8/RSjSGDXdF0wqhJBS1cIoQqCCWmfPPtLTAGPK9uC
         Ymkg1lpSJn3og2azbpfkTfk9ptsLZJvcS5gc2rPR2UV2zFbR0q7u64wlBVWXNmYPLxd9
         5fJNH89VwvCdJOa7uRlWBCR55NYXarbkUIVJs371dIhJCxp4afwH8WxeJ5qiRaD/9U3Y
         1NIkwXkTTQHPieoU+1AJZUrBIOOqA2+weUMpXfn3l5r26acrgKhDtY9aSoBM4E9V44Ml
         Jr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qDKaS7n3cg46WHr8GeYfhWPkwomi7PnS8CwjeEenOsY=;
        fh=EBtsqb36shrOYfagiOAYWoL8v7LN/5cjir3W4KMqq8s=;
        b=UN4Fv4hmGfAtRMrtMf9aq/MvQ53+KanEbTWVW1J1awGSIY2+67Vaqh4s+BG+ouiKLI
         6IWBd9g/HzG3Cfo2jz90ijZhV7TDMX09l12PYpT2HsAzWVeUuWJA4R4+ut5u2jjkb0Hq
         OCVzKnxWNs7E4Fs5Y5GFwSQkt8AnLjRZFeWIFk5W80oquhSdX9lo8hnIWH3CTNwe38QR
         CGwVmeTSeetEsv3My0nIX6GtPwS9QOA21RgLNP0b6eYVCtmigXFfRg3Ix+Zbx1XWR4e2
         qGn76+z90RAaNjMpQbrUasOoXVsyNRHdaUNW9iulqtmM+15ydQiqBnQf8xn8G6obdBt9
         i11w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772563746; x=1773168546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDKaS7n3cg46WHr8GeYfhWPkwomi7PnS8CwjeEenOsY=;
        b=JiKUp6/+xt/CP+W1O+h6VfTtNZTXB9gmWnntEv9lQeyNZRgviXZZc5JKVK19jjMU2o
         7ZfAWt9XeDgazwJsKrZTNWQ7yOqlNlftCdrl6WdV/+ckrojMHAaanpLOT0d+7glhbgD6
         GsPLDeazzFHYrQQid8mWGW6Ph19P/J+GT9+TIY98kXJEy+v6J/l4ye5e9Yw3ro0ZJLxd
         N8lYkHvQhUhqsLTiSGNYyWo5X/4fpQxxYbWDLpE5NMSrQp/QnBUVTn+Jqi4jPo5mmLya
         O7sBjJoozhdvaHXJDDXq17u1boCFWeKM/5779IvbHNnj3m7sibyYXjEkK/NEGLvgHfV3
         RTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563746; x=1773168546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qDKaS7n3cg46WHr8GeYfhWPkwomi7PnS8CwjeEenOsY=;
        b=TNTgmvF8EUTHy1PX2uxp0kpy7zR5RQHaAySdK242uCBdTz4v6huUroZzEohKk6J70j
         NwgjEka8qHATbfGBrPA7/nZ0N7yLw+P8gx4GUYWPboEQ6qtyiXNwq+QBRS4jC4tsVZo3
         zExkur48+w7Zc/InlsRKmBp01J6XSdMMilgn9yZm57QtEklNtYpi4VV1gIQIideQbP36
         N7fY2hJHdm3+yg5HDU9rUcvkLCavQDOyxUqujwJmO5lpsfZMJKdo7kL4iBpDaqdkh5W/
         8NZAhjiwmw/XfJ+JhwYnjqWTNz3ftEnHCaD5Kg2ULBw8T6l2zAftE6Ng6qdPAKE9XAEg
         Gr+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOOGiEIyZ50IxcANEG5jS2vQCNjJuAh9MFKXCPuZF6tBkthnSqRCWJZDDyq4dsmLp+INA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7nHtI642fq/TnEVfwuIgsE+bBIwnr/Npx07nFp0lV13cLW8a
	/ELP2YOy7VJiZXzUdDJZQIBS8evdRsbYPDSOd3K9Fsh4ZmRK+WlfWGbo9ib2MMQ+kMfPREkDMFN
	Be7Esqkr29orcYQvCS7jjHDVAcAB0/Xo=
X-Gm-Gg: ATEYQzxFxh/mXNV4mVgTfzv6QSUiTBhCgTC0p27jkoTYsUyhNJOI4+HoftIetcIs09L
	0oKIiNNR3j+F4+bA1fWTYSYiynA4ExBWsVeHE6Mdl2B76UfRylk3d6aocB7ipN+5w207SXdwygn
	DaGcSU/6po3hnhOrljjsqCz9OEK1BycgAzVtayhCWXbpnnLfwG962ttBn54nE0bKF4XLwYPSTKM
	pzq54Ab1/z0A96jf/qwO1lUUyY9Q8oj/3tYNDvf4CbhmqcIxZpCckIlehY5C484OVR4XK2D8Upy
	Ay6JBerMOH5lsOHYFswdki2NUnfMBF6CRia0TM8HkkVU9MsHXsjQHPyzweArE7WhKwN1bFdQ1cC
	NWLRiNoIQcxpGrWFb/Hdy8r2Y9mI=
X-Received: by 2002:a17:903:2b07:b0:2ae:4a4f:74df with SMTP id
 d9443c01a7336-2ae4a4f7da6mr103115445ad.50.1772563746014; Tue, 03 Mar 2026
 10:49:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2220.v2.git.git.1772557925670.gitgitgadget@gmail.com>
 <pull.2220.v3.git.git.1772559813151.gitgitgadget@gmail.com> <xmqqh5qwdaeh.fsf@gitster.g>
In-Reply-To: <xmqqh5qwdaeh.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 3 Mar 2026 13:48:54 -0500
X-Gm-Features: AaiRm51NiQ1gyARfeAZKd47bMhoIdQgd36A0E1qJy05nj5n1_wsNhH5vJxSvmRU
Message-ID: <CALnO6CASi3eyf_Zn1RS_Atjm6hj6Vnq0nNNyV8JJFCAK7hz0rg@mail.gmail.com>
Subject: Re: [PATCH v3] doc: add information regarding external commands
To: Junio C Hamano <gitster@pobox.com>
Cc: Omri Sarig via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Omri Sarig <omri.sarig13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 1:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Speaking of "alias", I have always felt that it was suboptimal to
> make users refer to "git help config" to find out about it.  I
> wonder if "git help git" should be the first place users would look
> for a help about them?
>
> We have "GIT COMMANDS" section in "git help git" that says "We
> divide GIt into porcelain and plumbing" and then have two
> subsections there that list commands that belong to these two
> categories.  Perhaps leaving some breadcrumbs to redirect them would
> be a good start, something like this?
>
>  Documentation/git.adoc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git c/Documentation/git.adoc w/Documentation/git.adoc
> index ce099e78b8..fb5b477eda 100644
> --- c/Documentation/git.adoc
> +++ w/Documentation/git.adoc
> @@ -235,7 +235,10 @@ GIT COMMANDS
>  ------------
>
>  We divide Git into high level ("porcelain") commands and low level
> -("plumbing") commands.
> +("plumbing") commands.  For defining command aliases, see
> +linkgit:gitconfig[1] and look for descriptions of `alias.*`.
> +For installing custom "git" subcommands, see the description for
> +the 'PATH' environment variable in this manual.
>
>  High-level commands (porcelain)
>  -------------------------------

I very much like that, thanks.

--=20
D. Ben Knoble
