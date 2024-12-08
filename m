Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84C36B
	for <git@vger.kernel.org>; Sun,  8 Dec 2024 00:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733616382; cv=none; b=RkbZfN0qs+KeHM0LpHumrUmYVUDzfUodc9zr9EfI+Gs/hyu6gDZ30d20aj4iFcBnoEaG2Fjyz1/Fyd54ieYpIvMRCeBG4fBqPngYnw4Cp4WBtjo7nqIaUYlRlRtKdHVEtstzJU0AzTE6jPim1Ok8RblieqL74FBLlSxLa4KMu+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733616382; c=relaxed/simple;
	bh=2EdtFMQegJyDN9NII73Ico+LGEUXgEkO0fFpUkSGq4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1fUwzO8Og0hsCj5LggomfraB5XNeNCHet3piKCm/31JdC4ZORR4Nm8xTuf6mA46YhrMAy4HjTqmYpzTg9gX7Q5bGTORmQXPKLfJh51pM1OiuaYrzKF5tjIEFrnQAw1B3hC9/q3xTQy/n/wEJnoQhxgCT5VMXqNrj8ogL2qf94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d87ab61c62so5335996d6.1
        for <git@vger.kernel.org>; Sat, 07 Dec 2024 16:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733616379; x=1734221179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EdtFMQegJyDN9NII73Ico+LGEUXgEkO0fFpUkSGq4o=;
        b=o9o7YCgVXCD0jqHtlyFr80zpk7nVu7TBd2kPjn2B45fFqO+WwaI7LRmEraBNamFJ6n
         w5nkp2kC2JTadkhn2BNIdn/UAsCcVqcs/nmR5fQUwnBXmqzQtBkGdCh/p8Yoo7TCTTvi
         hdzqydRpNyjHDi6V2sGySldG/zZlSPYEV5tJ9WvVQatPLEPzb4zMAZQXfZylVv/a1Rnc
         pkXXYXYdh2YEh+YhSQ0KVbkyn9UPiRA1rQMhvEtEQXAVOHn7uRlM0I6gq5kN9qT1I1Yg
         vvm1B5u6KTBS4tD6k3V9deHYsaagHnYtEJI2ZQYzA3yjMU4ibzXNoh+ZM9ugf8o/3M+I
         LJKQ==
X-Gm-Message-State: AOJu0Yx48+Kre7+feOIsHJIdz4MmE9t9ng9LiNVzS7gwaPF0A3CuI7jD
	SGufbqMPJb371/ZOfoh4xVFaKXuDujmA0ghx/bUonb1u+qJaXRlahrU3rlIwHirP5w1VjOYWgk4
	HqBZ5hnBGCuCx7lx+/WMin1/B2EU=
X-Gm-Gg: ASbGncsyoUNIdOfk4MhNINFRREMTeJx1nkIUjkSHVnhn7kPibMnZzgePhNDqEzkJVqt
	kE6hoy1Mxf07SO4TByxiLWLyMGlrqpA==
X-Google-Smtp-Source: AGHT+IH7laKGs5rf+zvDTeSCh5/8zsrZtB6ojAC71C+9F2+yEWSrNjLBoDoVPq533PC3m/NYnZgqSjddt6K9HMblYKE=
X-Received: by 2002:a05:6214:dab:b0:6d8:858e:e8d9 with SMTP id
 6a1803df08f44-6d8e7147cf8mr48787516d6.6.1733616379191; Sat, 07 Dec 2024
 16:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207135201.2536-1-royeldar0@gmail.com> <20241207135201.2536-2-royeldar0@gmail.com>
In-Reply-To: <20241207135201.2536-2-royeldar0@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 7 Dec 2024 19:06:07 -0500
Message-ID: <CAPig+cS9tJ1YjGyCObmgrruv816szhzA57PJNBLghEiYj1Qs7A@mail.gmail.com>
Subject: Re: [PATCH 1/3] git-submodule.sh: make some variables boolean
To: Roy Eldar <royeldar0@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 8:53=E2=80=AFAM Roy Eldar <royeldar0@gmail.com> wrot=
e:
> When git-submodule.sh parses various options and switchs, it sets some

s/switchs/switches/

> variables to values; in particular, every switch that is passed causes a
> corresponding variable to be set to 1, which then affects the options
> given to git-submodule--helper.
>
> There are some variables are assigned "$1", although there is no reason

s/are assigned/assigned/

> for it; this was actually noticed in 757d092 for the "$cached" variable.
>
> Make some variables boolean, in order to increase consistency throught

s/throught/throughout/

> the script and reduce possible confusion.
>
> Signed-off-by: Roy Eldar <royeldar0@gmail.com>
