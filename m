Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA1145348
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202142; cv=none; b=DU+I4E1kOvgPvuUxZyvYyejRAceu2n7efL39a20X+vQ21griuQzW/DTOaPKV9U0LKUQyW8R3E3UYL6Dbn5SHNmqHlfYZqULIGfVJJqULT/tvE/bYE2Mnr7q8MOlbnHKWg+0UyblJDY1Ctw5uxbmQctME054/OcSawkxJphnLOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202142; c=relaxed/simple;
	bh=Tw7U3ZuI5wYLZ5RuybDj/dXoD016Z76GOk9hTG0NGgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=BQ8VZ/7WD19cCiDjnuh26A3/PmjMc07w9bV55KXQEhY0XZyof8UNEUqgQjwnailLQSLByiGa4nHevnEn+gdZWWJouCzNvlR4r5EMudIwZQ2doIFny0BZvNg4P1oQHKrNQ5nlaEf9cT6cx9JBlEEfZaPkbwM6HomkxnockDR5FEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8eacc4194so15115526d6.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 14:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202137; x=1736806937;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+qfornjAVxFSk7rov63PJwjK3Y6K00q/IrrDvJWNyM=;
        b=F8hkSg/PwdZxD82PoW7ZCSVIo7NadZlXw31Rjh2ZXi7CKbbkVsBmcyPVeyDpdrNxSs
         J1vv7XCcJq5tqNOIUVARy2T4S/kk9KjaZrLXvHgFcwrduGbC/ofpQPd82ZyHuUwCzu2u
         Zpy8kd63ryHgvTepvAnUJZ4AnTXoomeqpk6SflquVrEjzUiOV0VuTX7xyWm26m804EBK
         Rmaxt5h2epm4Tykavw8I52B+35nMkCYczgYxPWiWcLkwuk9D4bwRjn8qmAG+jih8P09d
         I720LRVzXKm9v/0fhgMYBqCrb5zQ21qFZDKIUxk+DWHeKQqf4fExBDpiTgCt4ClqSy9u
         w4Og==
X-Gm-Message-State: AOJu0YzdWdt7T8rBMw00FufBaeZDquD5lt1I0u7sGFA9u/pJmJSK/ceG
	BaW/+7WfUXrX18ZEI+qFBoGf0ywcaFbT5MlMIUgF9kfLw1sIuLWTgwlEis0g+TayvZQlOTdh9nX
	Z0l0cO7hVdPCrQ4peOpeyMezqpkxWoFOM
X-Gm-Gg: ASbGncshXXtuyg+xSYW36fvesAm1NXAJbg2x2dyqSTR/1u/LI6c/XjE1SnkXzHCoLPd
	LWe7OiSCwvWYcfYr81eO4C1oefBvbqOZLJnPSltWtGEQ7Zskn5KfI8DwvkZmZiARKHGUP/CU=
X-Received: by 2002:a05:6214:3008:b0:6d8:a5b7:6581 with SMTP id
 6a1803df08f44-6dd2331b533mt340362266d6.3.1736202137622; Mon, 06 Jan 2025
 14:22:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106190855.3098-1-soekkle@freenet.de> <20250106190855.3098-3-soekkle@freenet.de>
In-Reply-To: <20250106190855.3098-3-soekkle@freenet.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 6 Jan 2025 17:22:06 -0500
Message-ID: <CAPig+cR0GgZQ+XCyAh=xHRfjfsAdTzC2uyML1vnoM_fXv1Bxew@mail.gmail.com>
Subject: Re: [PATCHv2 2/4] date.c: Fix type missmatch warings from msvc
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com, 
	ps@pks.im, =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 2:14=E2=80=AFPM S=C3=B6ren Krecker <soekkle@freenet.=
de> wrote:
> Fix compiler warings from msvc in date.c for value truncation from 64
> bit to 32 bit integers.

s/warings/warnings/

> Also switch from int to size_t for all variables with result of strlen()
> which cannot become negative.
>
> Signed-off-by: S=C3=B6ren Krecker <soekkle@freenet.de>
> ---
> diff --git a/date.c b/date.c
> @@ -1270,7 +1270,7 @@ static const char *approxidate_alpha(const char *da=
te, struct tm *tm, struct tm
>         tl =3D typelen;
>         while (tl->type) {
> -               int len =3D strlen(tl->type);
> +               size_t len =3D strlen(tl->type);
>                 if (match_string(date, tl->type) >=3D len-1) {

This change looks scary and potentially wrong considering that the
expression in the `if` statement subtracts 1 from `len`. If `len`
happens to be zero, then `len-1` will wrap around to a very large
number, thus potentially changing the meaning of the `if` condition.

Now, admittedly, I haven't delved into this code or thought about it
much, so I may be entirely wrong about this; perhaps it is impossible
for `len` to ever be zero in this context or perhaps the meaning of
the `if` condition doesn't change even if it wraps around. But if
that's the case, you should use the commit message to explain to
readers that you have audited the code and verified that `len` will
never be zero or that the condition remains safe despite wraparound.
Also, even if you verify that this change is perfectly safe, because
it _appears_ to be a potentially behavior breaking change, you should
isolate it in its own commit, separate from the other changes, to let
reviewers know that it deserves special scrutiny.
