Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942B17C7A5
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726592765; cv=none; b=dr2kih6tQikLlTOWB3NB53MXLZL17KzfQZeal4l6V4ukL4lHy5yvnipxxuEhNV4OKZaqud14tYKzazCYihh3Icml2mH0/9AnQn46oz2sqCnALo/SWOfF4npaLoq5ZpKxDxs6Yz/bNoC8E8d0vm0X0U2pAo2jBtjtUMHnePXBMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726592765; c=relaxed/simple;
	bh=U6mAsqc9aHAXTfpVkN1wMpBam/h9QYp7BxUY4DtKkZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6qzlevY3tDmntQBB7ZDlPgkCCXZw2UgpkHCW3jSLprkqb0lwossbXeZrZTIspC6ay/kEZlSk70DYirvjexJHNGLx00JMMX4nB89uJIkI/MKjaGtqZeVYoLMIgz0ZFY2HwgnkXcthZ1zjnTbyGXxwxEhfsr17TjyqRN4mq/YTXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c353a69bb7so6135966d6.0
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726592761; x=1727197561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gtJLn0RZi/u+oHFi/7g+mBqnki8kyEqmPU0A3yY6kU=;
        b=jFvyAED2IF6A4ZxlcSxtibSjWsv8JFu8LnngWAkX/05/PmLF71vOD3nQN9QxAZWRtw
         7THOcCu7qZbwU9GLN/eaoLCS027IvT0+xEqC0Vlx24oEhCmWtZpwNGXG9A3hR1nF3R/e
         ytpk1HuWpcC6yThhoXC0buZhkjF+cQQUGRrqb4lpNmpVt7QxAnSb3y2N/lx7HjnYNrQF
         4k9PmU0neHPjGWcMocOcczKwX/eKKT/LLSDPrnwK4tSiAMwI4VLaEsLV0r+eurlraTfS
         zKLWEf5WU30vZ/0eDMi18+YEgojJD9dDSbI1PkyyKQg4kcwJBgwgpfUHXu/aLovGw9Q2
         PN0Q==
X-Gm-Message-State: AOJu0Ywvon8jQVz9mBn88AnyffupBYrP0yLXDMAsvkmCmRzJCD3HK7F+
	Em6w8IrwKdVasRNBlIRqKTi3vscZaCzjVFcGX7dZm2NUiEsA7fbEDbx/ih8xJfyYDQmzE1shkNd
	gjMVdCt5eSDntGDvbqzyguvBcqhsEiST9
X-Google-Smtp-Source: AGHT+IH53pID7cwg7MsluMdr7cMsoIwAbRhkn4avKp8vXJoU62Savn22wSFgL/S32uYnpRcg12h3LGl6k4UwhbKr6MM=
X-Received: by 2002:a05:6214:1cc9:b0:6c5:3338:2503 with SMTP id
 6a1803df08f44-6c57357edc6mr136765156d6.11.1726592761409; Tue, 17 Sep 2024
 10:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726556195.git.ps@pks.im> <1f13bc0e3259ea9b76f1417303a8ef063f3a7cbe.1726556195.git.ps@pks.im>
In-Reply-To: <1f13bc0e3259ea9b76f1417303a8ef063f3a7cbe.1726556195.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 17 Sep 2024 13:05:50 -0400
Message-ID: <CAPig+cQ472dzChHKgrL_DNRe4KMNHNVxR1Qh3n6M=OgtBkG1+w@mail.gmail.com>
Subject: Re: [PATCH 1/3] cache-tree: refactor verification to return error codes
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 3:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> The function `cache_tree_verify()` will `BUG()` whenever it finds that
> the cache-tree extension of the index is corrupt. The function is thus
> inherently untestable because the resulting call to `abort()` will be
> detected by our testing framework and labelled an error. And rightfully
> so: it shouldn't ever be possible to hit bugs, as they should indicate a
> programming error rather than corruption of on-disk state.
>
> Refactor the function to instead return error codes. This also ensures
> that the function can be used e.g. by git-fsck(1) without the whole
> process dying.

Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/cache-tree.c b/cache-tree.c
> @@ -890,18 +892,23 @@ static int verify_one(struct repository *r,
>         struct strbuf tree_buf =3D STRBUF_INIT;
>         for (i =3D 0; i < it->subtree_nr; i++) {
>                 strbuf_addf(path, "%s/", it->down[i]->name);
> -               if (verify_one(r, istate, it->down[i]->cache_tree, path))
> -                       return 1;
> +               ret =3D verify_one(r, istate, it->down[i]->cache_tree, pa=
th);
> +               if (ret)
> +                       goto out;

Assuming I am understanding correctly that the original code was
leaking the strbuf by returning early, I was surprised that the commit
message didn't mention that the patch is also fixing the leak.
(Probably not worth a reroll, though.)
