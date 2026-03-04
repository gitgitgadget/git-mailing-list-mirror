Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5343845A3
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 22:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662931; cv=pass; b=PRut320t3obyVTuFzBvrOZO89GaOd9o+z5glkpPLQDG5snasd3bqV6mJ2jne1amrzYMiqaNIcRA5/omzta0HeMH7IfIftlwgnIOQ8njKqMjWsj9ZMMLLeDjw/Uoj/FXs4KkNt2+v6+YfqPXgOtepbRLBYOUxHdillQ0h5daxOlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662931; c=relaxed/simple;
	bh=JotfHUJh46vDLc6zh6C3t9G8hXb0vWHtAyRd98buvkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFzlESXndfIZaL6NNIsYQlcKJ/Bze8nrOfnv3uLZ8npxsgi9hihuFP7yCM5l1wPyHGUBO3HrWq7BTK1QmJuWQzt3zmyrYuVvXDIDuk/fZL5BAPXMZ3YvPceVpCjTefcADphWzJkDp6NKzQlwPnbTAt7AED5fB2rlnCaZn+XgVzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2be0629f76eso210318eec.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 14:22:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772662928; cv=none;
        d=google.com; s=arc-20240605;
        b=QzYDuZoIxJgI9R+TIsUFSD3wTvLGyOu/+0beMmqNT5Pqn4FCkIHDH2JDC9DdG8JlpC
         clF/x6PSOq9hGsWzstRmcQewNL88lmRYiKt5IJIx2Ser9Q/jkOpGmKxUijx6FFjhW4+6
         Tba5wkx5jAUGXPHTIG73qZOxCMDpIsCPp37H+RBcuPfp05pydboZqURXYSA+tiXsTsVH
         Nw34yLLQMW28fFmtk5kta9q3jMHS11VSF+AWvzkhrZdi83hCd610g2rspSYmo8srz4dY
         wQIEZD261fsLXIYbd0eNaiq/xqsBlIy90BxgDxmZB2o9UEsZ3vOz6TbJlTlthB1dKCr7
         8Zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=vmB6fOfopA7i1HKd0d1jIIPbajyVG3MiptVvYubB8dE=;
        fh=Ztm/fZIVVYTzKYjvntEj9uci1eICp2ux/8l9vTu7Srk=;
        b=fbFrCMTCIHq7MbXi3KocO5Ti4E0jr8Nz+oMNzxN4b4ukkHjBzmq2t+iIdZHK77o6sq
         TiorBaUeR4E9InQIhqISyN5eg9m6M/FKb70jjoCPYIrhEHnNiT5/d9RO/XJ5fuEgnq5I
         XsgmYxQ36HAPwN06MNXDm4ioLJVHpJPEfjD6Sv01dTcWlkH5IQCRaKVEfz7C5UyFpFct
         pKl1NyMQTFi0Srymh/FqKDchZU8KGEhhOphKJWfp00+uhpMe3wA89NshunbhdtJMMP0P
         B7gyElkTRE6rLOy3PW25xgjylLMlHoTIuM44fgo4slpelEhHtcdbOCw0tbBb0w+gJ7Go
         xqOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772662928; x=1773267728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vmB6fOfopA7i1HKd0d1jIIPbajyVG3MiptVvYubB8dE=;
        b=IkrWWpH2nd8gz3mUN10njN5i9gmMWeqdAyPCq6xAVHPdOkYIcvcK5A5CzUoernWUdS
         SpUXAD4GQwrGBO3OHsGBpD0ejoDG5WVmEdC2jC7tOeeac7YoHsgfNs4CitZ1JtKofye5
         sTvn4jj3kb9qbse9BeBf018CMwCmvA3JZyZPv6dQ/YGfMq0P/ytgjMzeogICqGL6mr5n
         oRKNFto4zrjbTtZbmxADmOF7X+3AklWr7+tp28HYfm/dcHfWRU7fpv7A7bfJCayfG3Vr
         6YQa6pffRSaURcWUTCco9Yx5fpBQkDL0QHoccl/DUjN99wQGXj2NYaYivpm9AHN6wjcb
         WrFQ==
X-Gm-Message-State: AOJu0Yw+YqpfoL0ikDM4uAft1F83K9jIy8w6RyNfIM6ty3hDcJ/zk5yY
	6vupMvKDGmczcbBG6puoMmhiVVpfUwHhIO5eDF2W1NTMqYHALPv5vx6Uw5NQgG2JqAN0LNSuqqO
	8MnbLvZse+NASeyVofl4mMzFBhg+BP+0=
X-Gm-Gg: ATEYQzyXEZ+WgCHoWDsbS/LyAbqmpwUfMW17LDnNKk2IespBL7gdJI4NL5UxaKp55iX
	rmfTbne0+C1kBHhppikv7OdyGP0CPMX/gJyIq6jOtHhYZtGaTnk9fzNW/UQB/slqIvfFFk6d8eh
	wf/f69dlKFvrEG/PoJpBtIuic7rl0hBAnVpsbaXn13esjRk5hXY/zEvh54j3qFU0VkfO7bNNrR1
	IiGmmKRh4dCoF/TC3HmfHonM94ngWfDYdGOW8YRDQdSY2YLbX+S7cZ3udQtw7yvpyXnfYZtibhT
	o7CXqYVsuL5daheOLyMwN1scCNMw/7cYo/q4+ePiOA==
X-Received: by 2002:a05:7300:72d1:b0:2bd:a3fa:9bdc with SMTP id
 5a478bee46e88-2be311dbe2fmr715290eec.5.1772662928518; Wed, 04 Mar 2026
 14:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304121955.73794-1-francescopaparatto@gmail.com>
In-Reply-To: <20260304121955.73794-1-francescopaparatto@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 4 Mar 2026 17:21:56 -0500
X-Gm-Features: AaiRm53slNlxDs2Hg0LRAyWjyR7W4pZNZTwvOaWQUQA9WZnYHQTV0KBtMIN0TIQ
Message-ID: <CAPig+cTHyB2sbBOELPb2=B5sU69OzSPU0JVn0p=2qMp=0=8vEg@mail.gmail.com>
Subject: Re: [PATCH] t3310: avoid hiding failures from rev-parse in command substitutions
To: Francesco Paparatto <francescopaparatto@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 7:20=E2=80=AFAM Francesco Paparatto
<francescopaparatto@gmail.com> wrote:
> Running `git` commands inside command substitutions like
>
>     test "$(git rev-parse A)" =3D "$(git rev-parse B)"
>
> can hide failures from the `git` invocations. Extract the
> `rev-parse` calls into variables so failures are not ignored.

Okay, surfacing failures of `git` invocations is a laudable goal. However..=
.

> Signed-off-by: Francesco Paparatto <francescopaparatto@gmail.com>
> ---
> diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-=
manual-resolve.sh
> @@ -227,7 +227,8 @@ test_expect_success 'merge z into m (=3D=3D y) with d=
efault ("manual") resolver =3D> C
> -       test "$(git rev-parse refs/notes/m)" =3D "$(cat pre_merge_y)"
> +       m=3D$(git rev-parse refs/notes/m) &&
> +       test "$m" =3D "$(cat pre_merge_y)"
>  '

...a failure exposed by `test` is not very developer-friendly since it
doesn't give any indication about what went wrong. Since the pre-merge
value of "y" (and also "z" in subsequent tests) is already in a file,
we can make the failure mode much more helpful by using `test_cmp
<expect> <actual>` which will show both the expected and actual values
when they don't match. Thus, the above transformation would be better
stated along these lines:

    git rev-parse refs/notes/m >actual &&
    test_cmp pre_merge_y actual

The same comment applies to other changes in this patch.

> @@ -569,13 +580,17 @@ EOF
>         # Refs are unchanged
> -       test "$(git rev-parse refs/notes/m)" =3D "$(git rev-parse refs/no=
tes/w)" &&
> -       test "$(git rev-parse refs/notes/y)" =3D "$(git rev-parse NOTES_M=
ERGE_PARTIAL^1)" &&
> -       test "$(git rev-parse refs/notes/m)" !=3D "$(git rev-parse NOTES_=
MERGE_PARTIAL^1)" &&
> +       m=3D$(git rev-parse refs/notes/m) &&
> +       w=3D$(git rev-parse refs/notes/w) &&
> +       y=3D$(git rev-parse refs/notes/y) &&
> +       p1=3D$(git rev-parse NOTES_MERGE_PARTIAL^1) &&
> +       test "$m" =3D "$w" &&
> +       test "$y" =3D "$p1" &&
> +       test "$m" !=3D "$p1" &&

In this case we can do even better by taking advantage of
`test_cmp_rev`, which would allow you to express the above more simply
along these lines:

    test_cmp_rev refs/notes/m rev-parse refs/notes/w &&
    test_cmp_rev refs/notes/y NOTES_MERGE_PARTIAL^1 &&
    test_cmp_rev ! refs/notes/m NOTES_MERGE_PARTIAL^1 &&

Note the "!" for negation in the third line.

The same comment applies to other changes in this patch.
