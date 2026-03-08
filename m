Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2364318EF6
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772943196; cv=pass; b=ESEw8SX9HCeBIM933Zmlqv9nvOXybvOjGGtdofNioccGvGh+U0SY4/wPw5wubeiVIV26k/zWhkjfW/mcxcxZD9xZ/h1wln9qeIZMKpbdki5h29Qk4volv9jM2FhBl4b1W2Jt37ubjlsrMJImfONiQ8QRwrPLTVUsCRMH4WpPooc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772943196; c=relaxed/simple;
	bh=LDP/ukFA5FnvHw1oYVh9Gy+FBdTSzs4ML2m8dl7KIjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opQFnEz4zN7NdTq4fCzK2+wI5vnRF4MdVzD81EVS25ssgjFeluIXQp/JoeVWJkD01OBpd7hCL19Kc9vA8QodvBoCTfoODXhQL3gMf0KYJWSeRj/twok4PAtdK9kC7SjB1tykPUATl++BX0aI+PYCj2pCmuiOYe2H1Wekd1SHl3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2be054479baso523285eec.2
        for <git@vger.kernel.org>; Sat, 07 Mar 2026 20:13:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772943195; cv=none;
        d=google.com; s=arc-20240605;
        b=ZAlKL4hO353tdD3pw1vXMIHW42bJG9ymu73CrPHKZHEDVnrP/6gAjkR44rASnjDsM4
         v1dHk4K5jEt846DqSA38Gs3ribKhfTtQG3pVJIrw7p90c6KYEXXFqpW5mOYmHYw6sMOY
         I0LNEbT4RZAWeF78O5Fgsu7F6khi3sVknaij4YRW7KqDxvbbu6vYL+hc8+asjyFxYoAV
         Vqye1MoKZszhwuEGpY2lKLvq+9m/Dzw8a80zlo8LsnD8o6ULmbFWScb8qzjkOKbEJn47
         vy/IvoUzSTtW9HrQQNsooGdDOslQovWI4EzZl+CegxHu5RF9xYDlcXnMa8jvGTdgU3sP
         wspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=FXVoT7NFuUoDsR7e76po/gG7IduZdwesht1VqFwYKME=;
        fh=GDTtk06GWx+BcnnbItsaTxolHfAv1a87i96qChTRwYk=;
        b=AmQBWV7+SgLqTA/9rDA17rw/MLnNqDpVCkpI5XEYeB6QI0jMQehXoiyvJC/tPjuIww
         2DD6EuF37b/4eXLO6YV1gd1KLxrlfRW6Ifgenu8UZsfGsvzjd1+7b1f7IrGB2wIbaEiy
         My48ezhuoybCpul/+njAoII6+UbFJPC4S0KzXXj+MmIUPezTvpX0Lhli/uWwdKE5v3cr
         /700HeeK56KKq8NFSIACxd0w3O0+nGr966AASgqR7GmPcmZZgS/WoWsdbcfjcCnaKIWJ
         GL0gC51LV/GEgVBnshlDcAagGsiUV68e5H9VKi2olSiiXWpZNZFsl6ZMqXPvKVInLC4M
         VLaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772943195; x=1773547995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FXVoT7NFuUoDsR7e76po/gG7IduZdwesht1VqFwYKME=;
        b=ZeTlM8pc3Rmw1S1q4ztkW02fLwsCZCY5tYrmkPgBATdP/RqbsWxc3XYlcRyTSCEEOs
         e2VLJYDCH1vnNMkZyyUDVkbx5SwkCZpFczm36Bux7YMq5Huz7xgQIXYWI5ghtQICTTa0
         nuWQOqD/cH/QL2PeX0VES+q8592z8YN0bFimu5THV1UfL9xSvC1mOEfrbdjbpJKd8+Hh
         A4+fMF29uI4dB3A5xupDJt/C9OJKAmyJ9IFZZKC1hBPO0ZW5Mf8IH0UbGnyMH1kKmO8f
         Cm/wKaWRdAvvSLe8j+4tgr6Vk7kuzPmmbOGn6uX4Yan7tZ59fLOOMvIdpp/H3NAQvyy+
         kP5w==
X-Gm-Message-State: AOJu0YwPOEVk3c3p8bBtGHayqGoqKEtdW41O2xxpqwZU43AU1ns0Ma2X
	0jrhgG3nJe403gxoDAQPZ+n/+KdSUNEhdMx8L1iJXX94zd2oviAsWub0offgFaDVXqduFcD1D5X
	vZhK4mzqkdw5OhDpaApRFPmbfvGrZh/w=
X-Gm-Gg: ATEYQzzdAyapVfwzeJ3TI37Vk+PxkoGWu0kiSgd9wS/DbiJBIG0shvnBSjUyFgKO+Ru
	I39w6QyduBxxVNQqhQxlvl4hTmeieAQusE/z+C6Vj/eYKWG9KhNCNYfH9vJJgsEOai4qzLaQGAK
	YjyZS8E1vHku3ZmV0m74PVis2JYphHTpMHaW0yDbPfA7cG75Nrkd198S00q/vWWzfNpAzuynEWP
	lUhBsKkrEGsp5L+0UJ8zriSTIm66pZ3FeYDObuqH8JTqfVLdnJaPDZwUr7dWFhVND6OvtJm8xLY
	YA9t3uWWuCuIx+p2sO+X43idq+ajneNz68kLQGb6hCCs1cVhP4Ay
X-Received: by 2002:a05:7300:dc93:b0:2be:681:91b2 with SMTP id
 5a478bee46e88-2be4e04a8f7mr1589056eec.6.1772943194738; Sat, 07 Mar 2026
 20:13:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305225128.54283-1-francescopaparatto@gmail.com> <20260307103631.89829-1-francescopaparatto@gmail.com>
In-Reply-To: <20260307103631.89829-1-francescopaparatto@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 7 Mar 2026 23:13:00 -0500
X-Gm-Features: AaiRm50kst9zTunWAQzWCgawS-kpzRE15eRrfB2u-RENVdFZTWPwHnvbUEGyU6Q
Message-ID: <CAPig+cTmRGBjV=yG4PvyyvFOgTZ0zK4GtkiO1xGSm1+OeM4ScQ@mail.gmail.com>
Subject: Re: [PATCH v4] t3310: avoid hiding failures from rev-parse in command substitutions
To: Francesco Paparatto <francescopaparatto@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 5:36=E2=80=AFAM Francesco Paparatto
<francescopaparatto@gmail.com> wrote:
> Running `git` commands inside command substitutions like
>
>     test "$(git rev-parse A)" =3D "$(git rev-parse B)"
>
> can hide failures from the `git` invocations and provide little
> diagnostic information when `test` fails.
>
> Use `test_cmp` when comparing against a stored expected value so
> mismatches show both expected and actual output. Use `test_cmp_rev`
> when comparing two revisions. These helpers produce clearer failure
> output, making it easier to understand what went wrong.
>
> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Francesco Paparatto <francescopaparatto@gmail.com>
> ---
> @@ -569,13 +578,15 @@ EOF
> -       test_grep -q "$(git rev-parse refs/notes/m)" output &&
> -       test_grep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
> +       oid=3D$(git rev-parse refs/notes/m) &&
> +       test_grep -q "$oid" output &&
> +       oid=3D$(git rev-parse NOTES_MERGE_PARTIAL^1) &&
> +       test_grep -q "$oid" output &&
> @@ -606,8 +617,8 @@ test_expect_success 'switch cwd before committing not=
es merge' '
> -               echo "foo" > $(git rev-parse HEAD) &&
> -               echo "bar" >> $(git rev-parse HEAD) &&
> +               oid=3D$(git rev-parse HEAD) &&
> +               test_write_lines foo bar >"$oid" &&

Thank you, this version (v4) looks good; it addresses all my review
comments. For what it's worth:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
