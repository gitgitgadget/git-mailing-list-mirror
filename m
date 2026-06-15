Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC593AE19F
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551552; cv=pass; b=qoH+HkjF9x/FeS75Wev4te4bRUrjqjpWPzIoH1xg/WbWqyawKPCJjycvjR/3kv040JQq21pRqCrxlv8/L2P2ylpH9CJ2en3afi9jhmijWYvrReOALtmQzEDym147l82//K6YlCW5PlVJUa3bDzx7lSoAQ7ZdK04hK0lsHkfYLnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551552; c=relaxed/simple;
	bh=MktWjYQzLNM/6sWjBvwB8y35JVAD9j4qQbnCM4pglpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeDfZUVnwsWmiAUQDTVGVw9pnIOYDYyWgQlCAXb5GqHO5OMvJX+/++vn3a562yW+kBmc6eF4UN1rsSUEIojH0RVGjXoIMt0uX4UbF3nnqH/IPgXPXCMCyTZPOxElio7F/qTlGz26OOgASAol3tn7T2Je/NgYrU01e4E35E1+eSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvtg2Ces; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvtg2Ces"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bef47b1ac01so522425466b.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:25:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781551550; cv=none;
        d=google.com; s=arc-20240605;
        b=HnTr9aXwq0hEXwYix7qmT7Cdf9rhZHRmkyHFW3les6gsY1YBkgIKpHoJipBkGKUSG2
         IT6YkacFgY+ZBst1tAyXiZeMCod8f70thipAdf4qC9kX1lIb90nBGvJ+k6eA14ut0H18
         4vcAFS1vCK68VKX0gIbaQaVqRQB2t7L2HcGun/p5xHPLZBQJzoo30BgFH93srqK+VupL
         KwW5mjww4aFqAkrh35jU2V9n0dfE1i5BpfipYpiLAujc3z8OcSb0KLKZt+vcBGiEokiw
         qw/JXDWl396NpV4IKqsmG+xa7WQolvSuW7jzgALxRhjOiagFEchXZF7nNjYKsiUd88P0
         Lu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EKh6kkfNtTyhS+qZknPzSPB1ZJmvUOMYiE4yX7iQcog=;
        fh=4taht92dzazhQDOjq8CsAaKR4Bsqe7vCuOP5jjEO90Y=;
        b=BA70MV3GT+6tlPkVnv67SxENdJZTDIS4xq+dXA07KNUjMOhLTgqoMM7nMDAtU67d5u
         TaRpk5G6jwT4Yc5AvZqBESGz6xjKeGHx65PtEvzMsS8LZSprPsRGEoPuC0GmikLo/rEX
         76yM/MzCMN2naU3tBgjtG1Yxp/rrmnWZ0XjoguxWTCd2GvCwk3OvKz/7Q46xhJ4gtLO5
         4HsNUlGiL9S7dipkdxdXsQSxReXLAcgH9bIUt4pJXsBVVIPh8LXizVJiHflOKDdOoiTL
         T0ZPPDszCkGV1gKL2U4rv9K8aNCualUKX29xOLQJyIKTzfXJyO6/VyPSqvFM0QuNdGc4
         7IBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781551550; x=1782156350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKh6kkfNtTyhS+qZknPzSPB1ZJmvUOMYiE4yX7iQcog=;
        b=cvtg2CesQg1Nj05JlzzDea27ghuHGfZsaDYG1jVYHI75VBAF73bIEMyhI+mjN0W6b0
         zBivRg7i+2LqvHep4z1YYR7WFtUE+VzJvSBCCx+wdF4VhJhjiAXvZ42cSSxagMOJpcJ/
         PHZmQ9C6NeVWMfFayJ/hYBIeA9zhrnYlvxHB7i8w4kcimILx2kVkbCII6IHCpiPd/REM
         3MYEE7J2oByuoYHrSdF2IpHHhumbZHUvcwu2QESfLar3865RQ8IGNlAuofDLJvTW1VJ4
         moQwRn81QjWY4kIc+8U3ms6nrLpk4bkApUxN1e4yIQ9b0+rbhiLeDPpWlk6SWTJhaYvn
         L1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781551550; x=1782156350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EKh6kkfNtTyhS+qZknPzSPB1ZJmvUOMYiE4yX7iQcog=;
        b=F4F8QRMIBOnlgZw8cPgJ0JYZ+QycAVuFf8pVKWov7VMvi3Xa2LwI+WmB1PnAD49ePZ
         HNYlJRbX3mQePwNgldQfBDYk3/e8EEzaArK/f0f3QLV5ApsZp8lTfsQ9WXnZBnLZCgDZ
         WlfeRUNKFOxxYYV7rurGXxzZOyxxMdoJLI5OY+4T792pVhfqoJWWdEqugGAl//WLTsyn
         j/w1FUIkkTNYGfrvvd65Y1wfgYyN4d4A4q5J95m96JrWwZC2UIs3YLqH5ucj4SMkqsjB
         +ZyZBgbh+5JVHnFLKHeoA1eVfVX7dxvkHbgwxY3AMIBhZHo1a5tfjHO6hUr40nRdwKfY
         wFdw==
X-Gm-Message-State: AOJu0YzkSyQMrLjQvD2Pm896IIIp7Bg03Mh8VFeR41aLcSQKhzFgVqgG
	qsA2qLLJ8MCV6zHRwbv0K02PhiW+Zif4mJ3SPduLSUsSyZkA8xYFlDlbECohtGs/k8NgHoWwFUt
	ywTrWjdDlwiHvIT+inN2QT11iJRc719r+xV0s
X-Gm-Gg: Acq92OH6V53t6hswZwc1OMBZvhHNHSWRYE1Dpq63oES3LHeGrLRheBn8uBkSeU5o4s5
	2oT0Gc0I7XkS2BNwh8AGFfJTnuzT+b5Uoy/VPjYmdJpsBip41N6YG4TVGXkvt3pQHVuM9+rP+f2
	wkfquU54YxlQnB+aiI0fsXvhtyMB1Nl5Fntz4Dp5CDThIp9YLDYwOGsmXZui67N+LmOKfzyMEax
	gMQ+J0UebZT9fx9lUvIGBjEU8JDOdkQrKzcBX3pn3rHE5vz6mbw+p9X3HA6sE+H7jQnqhvxlxn5
	9Y3UxGY=
X-Received: by 2002:a17:906:8445:b0:bed:19af:f89a with SMTP id
 a640c23a62f3a-c043c700c2amr10213366b.7.1781551549531; Mon, 15 Jun 2026
 12:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
In-Reply-To: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 15 Jun 2026 21:25:12 +0200
X-Gm-Features: AVVi8CeFJZlGYpptyPFlBIzM4OeCwFMQgOPfCadAuGUZPtdIXf7ZmvBwNCB-Yd0
Message-ID: <CAHwyqnVG4LjQ-q1-DD56595Ba2OkOzA3LzHLKT+O+c-SViD8Sw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Silence po catalog output under "make -s"
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's this output that currently is not silent:

$ make -s
...
579 translated messages.
558 translated messages.
514 translated messages.
381 translated messages, 4 fuzzy translations, 6 untranslated messages.
520 translated messages.
519 translated messages, 1 untranslated message.
546 translated messages, 1 untranslated message.
474 translated messages, 39 untranslated messages.
520 translated messages.
550 translated messages.
579 translated messages.
576 translated messages.
366 translated messages, 7 fuzzy translations, 17 untranslated messages.
543 translated messages.
Generating catalog po/bg.msg
322 translated messages.
Generating catalog po/ca.msg
307 translated messages.
Generating catalog po/de.msg
307 translated messages.
Generating catalog po/es.msg
184 translated messages, 46 fuzzy translations, 77 untranslated messages.
Generating catalog po/fr.msg
311 translated messages.
Generating catalog po/hu.msg
277 translated messages, 18 fuzzy translations, 12 untranslated messages.
Generating catalog po/it.msg
274 translated messages, 17 fuzzy translations, 16 untranslated messages.
Generating catalog po/ja.msg
311 translated messages.
Generating catalog po/pt_br.msg
279 translated messages, 16 fuzzy translations, 12 untranslated messages.
Generating catalog po/pt_pt.msg
311 translated messages.
Generating catalog po/ru.msg
317 translated messages.
Generating catalog po/sv.msg
323 translated messages.
Generating catalog po/ta.msg
Generating catalog po/vi.msg
327 translated messages.
Generating catalog po/zh_cn.msg
307 translated messages.
    GEN gitk-wish
317 translated messages.




On Sun, Jun 14, 2026 at 7:52=E2=80=AFPM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> The gitk and git-gui catalog rules sent msgfmt --statistics output (and a
> "Generating catalog" line) to stderr, so it survived "make -s". Emit it o=
nly
> when "-s" is absent, keeping a quiet build silent and a verbose build
> unchanged.
>
> Harald Nordgren (2):
>   gitk: silence catalog output under "make -s"
>   git-gui: silence statistics under "make -s"
>
>  git-gui/Makefile  |  3 ++-
>  gitk-git/Makefile | 10 ++++++++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
>
> base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-233=
9%2FHaraldNordgren%2Fsilence-catalog-output-under-make-s-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2339/H=
araldNordgren/silence-catalog-output-under-make-s-v1
> Pull-Request: https://github.com/git/git/pull/2339
> --
> gitgitgadget
