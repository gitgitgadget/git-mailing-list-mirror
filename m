Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE692BDC33
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399147; cv=none; b=L3KZdlk/SliPp9dxCw//G6UiCdRLYBCDPoH7/Fn4TyPiXOnbK2XuJ70eG7/Y4F+USuHm+meJlUSZGdq2VHFneJ1SG685byGt3K457U9ACe8SRzUFIkHQHD+vZqJUpkBMFo/hQ4gwyh8sauTpxSCe7ck68Zk1eiU2eVUfF5tvQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399147; c=relaxed/simple;
	bh=tZBPjKYrMdU0JV/CVaWxe1Qgm5EXB3X4qgEWylsI6lI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=BbV76UXgKJRm9QcXehnfxo6BPkXBP6O7VdZgN2Hg3SFibb2XgWJIw2a3uezP+hhg4mSCnWMQLtMDXa5DAf3mIuUdYJJ/RphqNS+qR1MccDrLe04FR0rYsUoFsIhGo3L1QCassbU4x5xw3PZ5147NLjxqEzLIsOHdThfQBbRV7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeHE4pll; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeHE4pll"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78677ff31c2so4490877b3.2
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 19:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762399145; x=1763003945; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVFsZSPawOWEFlrhqF5nssSoQxp9PCt7AtT1pQqQtK4=;
        b=HeHE4pllC0Pebikl95PU3E8BCRT14wqYNweGxzFSnbs4ixcxkjbVPH/HNlj5WDBRr2
         xtSk8qOWfQiuCbixYhQqRpzbExp3Z83o7MhI0xj+XKVF9Zzl5yiSEFdS37QKY9eNHy78
         MWg1EWurqxdgsTAj8sAjWImXYH9rw5rYVbp5pS3sn7gbsGju32/gZfB+WJsKkYi+oySU
         X8Ug+9egiSDamyGJ+938GAlYkU73vdUVfoAf5g8LyiUbUgQF9F/opjsepYYTHPsUgN2J
         +tBfDDmu8OMuOPN1055/nO5Lf8R9E+4gks/7fAys4xDqINLQroMexDh/zwtEgleRQeaR
         eV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762399145; x=1763003945;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVFsZSPawOWEFlrhqF5nssSoQxp9PCt7AtT1pQqQtK4=;
        b=mnqIDXAy+XKoiPXirOyXmz5RUdnk8dJqFD/un1JiiHVgxFJsOoly47LMH8J7TaJJSc
         IZg2jeQBajC42yHx+IZ/oHr7w+7JDszVtoU2ff+2ENa85EBbM65BUVZXgvKo/yv8TzK2
         UWppjgA/wNuE75CzNa/KsBvfAdN+xIzNPynrLIFYzudVTTVwjDuoGGtim6+HPNcIwR43
         v2j5tcowOB/VwIm52tVAyWHoaRUb77X5Wi9yKkJ2vPGORId4qCsUrBUsJlWBFC5HlI8K
         ZgLFXniKUUif7xxWda9v1pc0cuddaHzrsdEZTg7uiD3KA6Z6SwUxfuy/ZjQaLokLFFs+
         gjRg==
X-Gm-Message-State: AOJu0Yy1rTzUQXhIa2NlaJjd0txpPKAo2HTRyg9Vp4Lh4VaqJSQGstQ9
	vjUsBpr1MJhxtnmrpN8+QIuPFIbWEmF00C6TeW9hlFNo6nb5K/wgQM43dMk+ZRDl
X-Gm-Gg: ASbGncsVdKVA5DuEAl/3O/KXE4u+Ijv1Xaj41bXZS6jrEe6Y4q9BL8mF73N9cSDlpWA
	zxnez7MFjyXWDTFY8bUMiN0cYMf01vHj+IDAO9S90raJUgyI+Kqwc5X/NgI1h18Xqk7BJejv1qR
	vtZmk3vJsExxZ9nFh62HzXXt51eMnt5RJgzfCGjZ1lIy3qnDpSCAR4w533lxc5v/h/2CSa3wYMj
	ZiSEnLfiGrmUrvvVyPOo/0HTSRCWKuKOc0GkAeuKEjitNbQ3g52f6vTXEwfdxd/ToKzrcEEZCWt
	/EAuWw/zldx3piB5av25Y/wFuwBVbQS10xpNecKnfFLyRSbuciUOk0zjTNWXjW3npVI1C9aoTUy
	YXS/mLBBvjqeumKdxiNcc2p4MrqhZyOu15b3b3bU58HbS0uAvBwKhaqkHNlQcmtXn30uOk3yrtY
	E4JLS1QUAReP7MbM3q9iiluYXLBp9tONM/2pX9Nqjy2ZOami04q8zPuDrX9nobyCB6NjqK
X-Google-Smtp-Source: AGHT+IHtitGVI4RmpnCm7CU7XPfiOlDg85eqKOnnVXf0aOvGAJqRB0jui800SVGGaq6/gDJdF/l1ww==
X-Received: by 2002:a05:690e:1517:b0:63f:b5d8:9da9 with SMTP id 956f58d0204a3-63fd34b5dc8mr4477951d50.12.1762399144731;
        Wed, 05 Nov 2025 19:19:04 -0800 (PST)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b14169c6sm4544197b3.22.2025.11.05.19.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 19:19:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Going one step further from git blame --reverse ?
Date: Wed, 5 Nov 2025 22:18:53 -0500
Message-Id: <7954BB69-7F5F-48EA-A6A0-907963E28C74@gmail.com>
References: <5bfd5a1d-5d4c-4bc6-9ad3-bdbdf11b031e@hogyros.de>
Cc: git <git@vger.kernel.org>
In-Reply-To: <5bfd5a1d-5d4c-4bc6-9ad3-bdbdf11b031e@hogyros.de>
To: Simon Richter <Simon.Richter@hogyros.de>
X-Mailer: iPhone Mail (21F90)


> Le 5 nov. 2025 =C3=A0 21:30, Simon Richter <Simon.Richter@hogyros.de> a =C3=
=A9crit :
>=20
> =EF=BB=BFHi,
>=20
> Once again I've found myself in the annoying position to find out why a pa=
rticular line that was present in an older version was removed (i.e. I neede=
d to find the first commit it is not present in).
>=20
> git blame --reverse brings me close, but not quite there, and quite often i=
t will point at a commit where several branches diverged.
>=20
> Is there a way to make it go one step further and report the commit whose m=
essage is most likely to explain things?
>=20
>   Simon

This is a situation in which I usually reach for the pickaxe. Say you know c=
ommit deadbeef had the line 'hello world' in file co.de; then the following s=
hould find where it disappeared, assuming the line is unique enough:

    git log -S 'hello world' deadbeef.. co.de

Omit the commit range if not sure. For deleted lines, the pickaxe should fir=
st fine the deletion of interest. It helps to feed as much of the line as po=
ssible, but partial contents are still useful (and I often use function or v=
ariable names to see uses over time).=
