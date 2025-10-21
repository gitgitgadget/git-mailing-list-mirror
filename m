Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D6022156F
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031181; cv=none; b=tVaKaiI5wvG24/QeKhtjcyFZT1LnLGCCgNAq08xRXTAWo3uF1XgexgZwf7h97N6wXrEz1I10gMUgVd+VF9LIIZKGhsPlXMfdwvJ0O2vX8AT7+mUj9Q05462gyYipc1SeGZa49d+bzoh817onOrXhqVNVeuBrJ2fNhUdRTiuoTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031181; c=relaxed/simple;
	bh=pGhecuZYYxX5RHTcl1Eet4DJeH3w6T+C+e6lowWN6R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uE2wqdV6rvYxporOrhqLqWO0cratZYvvWZuMmLForqjqPXAXEM8kxBpQoLry39wHB73IUI+xnL0IfJslOMLJ5aQBZDQ0eGNStd/YEwcxQc4dr9y+zHR1S5yMZUSoB+zCd/12Rfgb+ZCVDBfz2+DD4lItP0yPgOL27ylscWz9IIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzNXY106; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzNXY106"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3b27b50090so951130966b.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761031178; x=1761635978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNCeyxzlzs5X8LUufv50GuUeKlJ5jsI904XjyEGr7Ac=;
        b=ZzNXY1063D2FhmF5XgkGSwg0ka0w3qFFFIls/cBDD2SYemQ9UfgM93vY5Rh1tBLKbP
         lDB/IMD3qnU9FA5MIl/mhc+4oGyc5TgLaQBVZUkCJiGZQjOPUBfMlz/0XzkuqKZQG3V1
         omwpWprDPZecr75sGf43MLoVXnRkDkUlUKbM8xM7SmtgfMFTn912LDwGBN7/k8/pBElz
         CkQHE3PH39gMLqsiZRG8ZQdbyt/7B2X4eLgVbpWDwRpvCG7XNKEopn2a29erGPy1BTcW
         /WSbRtS3xH05f5/+gNSoVsqS4+/f/Sm4OWTGgqsovDb+MySf6rSxdOZSB1+AChzE5c0Q
         ap8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761031178; x=1761635978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNCeyxzlzs5X8LUufv50GuUeKlJ5jsI904XjyEGr7Ac=;
        b=vfDu8NAbzao+GeabHkiTmf1ypS72wQtz01o1xioqujxfmw87chLlIjKrc5DhHD5jIC
         PgvPaNRYKjt+alctDg5AX746kJCyvu0l6+L9FCW9WuW1QMnYmeqQDBjHYpJ+G3xGpGUL
         23ik1yeVgc0fl6ht2gGGYtCCc7jMRh9n7I6QkOSlPhGyDkwDBSngJuTmOF6yfzK2OreU
         YfcV9+EIHuxXJ9wgBQuTZkV0zEMA1lxHeVXYR40tAbvQigcWknMgybU+WGMJl8QiFAqO
         FOT1GKTmP4yI/ZwzqU/QaYh6Gf/HeUGV0hqVIWJSE+3VfIgIfDlzRHrJ3RQoc67jo8iC
         +SJA==
X-Gm-Message-State: AOJu0YzsNYogucyYIJogN2RXDeSWdNFRtUV1sVei51E5nTv4Fi6Yk3Ly
	t6cUWVe5ghBbTZoo4717UddxhJtFKzTp0mDh++w0SPvBCcfn+QSl5R2ul2YbpiqVDZN8RB1n8wu
	eTGLcwf5N9QzEfgTorujHhBNJXx3VHqk=
X-Gm-Gg: ASbGncuSAgrvGNUjH+m7slJ3JqvDiJM+pvtPmDjy03bgR8KsNKf7fqxMvyeaZb4/rFm
	RzR9TTdWIYpamnIhsYlAPez3rC8TspEQePh4+M92t1jDTah8GwBO13AGcZasD6rEiycp8oH9z1f
	XsnKv7QwVByhLuvGj69DTw6m/mlnCIYea9JYjcGDOVg+cdXZ3JYIYWlHzgmBm29MZ+heydZqjbd
	2RWkDjzbbySMWnO5BqCC/zz/pOr5pDzrDj6HuV2bjICnX3nMF34dSD7TkYvHkMAJXjiQlc=
X-Google-Smtp-Source: AGHT+IEoqYtKYihKuLbmED6LVaPdt6GpTLhWZn0jIxVUTSDsPgdGtJoAr+L2WUqI2ceMTKyIuHt+OcILbDBhubQXCNk=
X-Received: by 2002:a17:906:fd87:b0:b2b:63a9:223b with SMTP id
 a640c23a62f3a-b6474b365eamr2079474866b.31.1761031177586; Tue, 21 Oct 2025
 00:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760997183.git.belkid98@gmail.com>
In-Reply-To: <cover.1760997183.git.belkid98@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 21 Oct 2025 09:19:25 +0200
X-Gm-Features: AS18NWDB5L071DmW9kOeoRtIXl3hNwMvqh1A6kewFcycGbFMn90gsfbOG-6RvyE
Message-ID: <CAP8UFD3sxU=r-zVmM7xL84qEsDL6cFUceAV4np6uLxFTVOnWXQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH v4 0/2] do not use strbuf_split*()
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:56=E2=80=AFAM Olamide Caleb Bello <belkid98@gmai=
l.com> wrote:
>
> The patch series by Junio Hamano with link below,
> https://public-inbox.org/git/20250731225433.4028872-1-gitster@poddbox.com=
/,
> notices that the array of strbufs that calls to strbuf_split*() provides
> are merely used to store the strings gotten from the split and no edit ar=
e
> done on these resulting strings making the strbuf_split*() unideal
> for this usecase, with the string_list_split*() being a more suitable
> option in those cases.

Now that the string_list_split*() functions are not used in your
series anymore, I think you can remove "with the string_list_split*()
being a more suitable option in those cases".

> Commit 2efe707054 (wt-status: avoid strbuf_split*(), 2025-07-31) for exam=
ple,
> in the series, notes that abbrev_oid_in_line() takes one line of rebase
> todo list and splits tokens out of this line using strbuf_split_max().
> However, no simultanous edits that take advantage of the strbuf API take
> place but the tokens are merely used as pieces of strings.

I am not sure taking this commit as an example is really useful now
that the string_list_split*() functions are not used in your series
anymore. Maybe you can find a more relevant example commit in Junio's
series?

[...]

> Olamide Caleb Bello (2):
>   gpg-interface: do not use misdesigned strbuf_split*()
>   gpg-interface: do not use misdesigned strbuf_split*() [Part 2]

I don't think having "[Part 2]" is a good idea if there is no "[Part
1]". And maybe using "part 1/2" and "part 2/2" is even better if you
want to go this way (so that would be for example "gpg-interface: do
not use misdesigned strbuf_split*(), part 1/2"). Otherwise, I think
it's Ok if both commits have exactly the same subject.

Also please start to use the `--in-reply-to=3D<...>` option of `git
send-email` so that your patch series are all in the same thread on
the mailing list archive. For example right now if you look at
https://lore.kernel.org/git/cover.1760997183.git.belkid98@gmail.com/#r,
you will see:

Thread overview: 5+ messages / expand[flat|nested]  mbox.gz  Atom feed  top
2025-10-20 22:55 Olamide Caleb Bello [this message]
2025-10-20 22:55 ` [Outreachy PATCH v4 1/2] gpg-interface: do not use
misdesigned strbuf_split*() Olamide Caleb Bello
2025-10-21  6:46   ` Christian Couder
2025-10-21  6:51     ` Christian Couder
2025-10-20 22:55 ` [Outreachy PATCH v4 2/2] gpg-interface: do not use
misdesigned strbuf_split*() [Part 2] Olamide Caleb Bello

So we don't see the previous patches and messages related to v1, v2 and v3.

If the tutorials and documentation are not clear enough, and you can't
make it work, then please ask for help and say what you tried so that
we can help you with this.

Thanks.
