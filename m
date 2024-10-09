Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E313E3EF
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506187; cv=none; b=Tv1TnFFXdfhqlFqAl1Rtl5njzZh0cns28vR9WPIpAhnv0ars2R51S8YiOeknst/UkHUhtpDDMxizVT5MtgwGhgpkiQG4P7f1jXKY5tlHxGeNyUIjJu5MpPBju9S9QKBaFFX8GySiQCeHoNzVXdu/R/Os7UYYq41BcLiBCy04l90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506187; c=relaxed/simple;
	bh=JoB0kN0B3I3K7jmrF14qrYwH6sUvNHQZkDUmJ6qhZjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acAblkVwyJFWCelgsx46TDayquvzv+M6jK57J62RKg1sbVKzEFq7HvVJ3TAEoyA/Rn78EuzxgnKYzRDeMysECldpXJyqgz9IOl6mj1AisqAqh3b3MqtOcH2Bg5Mv37s1035HK3p7osG1BJrlwH65uoFX2nSLGwOljlCuDSjPcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hemr0zQ+; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hemr0zQ+"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso1285715ab.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728506185; x=1729110985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gg1y3FDcQeU+ZYdwjZvh223ZotG2CyZv1SE0X0fSng=;
        b=Hemr0zQ+QvbiPQbOcYgaV8pVUWOWCM1kkeNzL1jjh0qSru7gPBdCXglMfTAFpIWzf2
         KwU/daKKYiAe6K5bSzva04nQPvyORFO0IzMjLzMQADJGPVsOOLdb7I22CzCKB028wSt8
         p2C6d8SgkjNNzjxMSWEeB+3bPtF6jMKiIZIjWQ36Nr+vYJ5f5EaY1Y2AQroo2Sm1yYv5
         A/DCipjHTbptD1I3j4vrP/OSpnsppmCGs3QS6q3PYZn9fP/+wUd14cSBZuz4iI0kgqor
         kflfuAwF0JqfycFkIq+7CBhaHV2vk5u9U35VSMmJFwjflyMjKZghJjBwla88ISseTYLU
         DtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728506185; x=1729110985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gg1y3FDcQeU+ZYdwjZvh223ZotG2CyZv1SE0X0fSng=;
        b=pJsoHMPwvxQPicJrVO3kzyGsVBM3ApbhHpMO1PU18VpCz/OlECkvEyJqmVJ/HRdzNO
         YQVsmH8CMSXykyn3HM11Hw/lwEm4vAlSyB3sm2J3slNg6X4bZWJPNYrnDbQwDvvS55PG
         Ot901wnwT5siw1E7aPNDrLRrwb38gsbbvSvggA62+UxHpL450tR965ycNCa0dsIw4LZr
         BuH6kpo+v3gIs2grM2JDedeLFR8aCCm/cdgb8r09GHilE9EYOwmI3k+b2KqTw3KPVNDN
         JrzXOoyVwe2FyvZcJEZfNTH8seJHDjKp62bdO8G0g9X7Er9jopRpTMJmjuM5gWR1felz
         afGw==
X-Gm-Message-State: AOJu0Yyn3ONoNVzFdJDxm+EFSpubv7RCwldmoaUYvnHkM1NUkRyKg+QC
	LNxBEg523cNhqMtAnBSm4u1TiAoi9TTBp3Ja4nnmrTfswuwYOPr/9YIJEMdSMHVVb6TZJZF6ycV
	w2q5VXP2rXA+6pXosvX/50OaDj8MB9ot5
X-Google-Smtp-Source: AGHT+IFCjV7KSRI5dpYQR80sNG5BoQzGlrxv8PpLduNIsnu4kzLE2ilalL0vA0aHYVQw4cTmJDohGrUfo8ARZ2rE17A=
X-Received: by 2002:a05:6e02:20e3:b0:3a0:b471:9651 with SMTP id
 e9e14a558f8ab-3a397d19c12mr38606935ab.24.1728506184803; Wed, 09 Oct 2024
 13:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJoAoZ=UyfDjAvG0-kC++R7fpR871Gsi4crR=o5F3PvNfB=7Uw@mail.gmail.com>
In-Reply-To: <CAJoAoZ=UyfDjAvG0-kC++R7fpR871Gsi4crR=o5F3PvNfB=7Uw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 9 Oct 2024 13:36:13 -0700
Message-ID: <CABPp-BGWbKe7SQnVf78hTQeGqH9x=7NkcjvVRfrmbW9R9wL8zw@mail.gmail.com>
Subject: Re: Interest in a Git meetup in Bay Area, California?
To: Emily Shaffer <nasamuffin@google.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:09=E2=80=AFAM Emily Shaffer <nasamuffin@google.co=
m> wrote:
>
> After seeing Berlin have a meetup recently[1], I wonder if we have
> enough critical mass for a similar meetup in Silicon Valley. I know of
> my own team and one or two other contributors in the Bay, but since
> there are so many developers here, surely there must be more?

Sounds fun.

> Please respond (directly to me is fine, if you don't want the whole
> world to know your location) with answers to the following, iff you
> are in or near the Bay Area and interested to meet.
>
> * Which part of the Bay is your preference? (San Francisco / East Bay
> / South Bay / Peninsula / other)

South Bay (southeast San Jose would be optimal, but Sunnyvale/Mountain
View/etc. are fine)

> * Which days of the week/time of the day are you most available? (e.g.
> weekdays after 6pm, weekend mornings, only Thursdays coinciding with
> the crescent waning moon)

Tues & Fri tend to be the most free currently; there's a reasonably
good chance I could attend if the event is on one of those days.
Can't do early mornings (getting kids to school...); might be able to
do an evening but they're a bit more likely to conflict than during
the day, but between those are likely fine.

> * If you are interested in helping to organize such a meetup, please
> indicate this.
>
> Hopefully we can get some fun meetup together, or even a recurring one :)
>  - Emily
>
> 1: https://lore.kernel.org/git/ZqoQcuKz_ynYaBNM@tanuki/
