Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F7382291
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907412; cv=pass; b=D0AYuX0L9gh3h8OuDTURpbAOysX1ayD9dL11OekgHQLfb4870fyJN3kU3FnuWhzNbA9HCr2cu+Ehj9jeiHfMfSXl0KMtOZSMfVasV3sSS0d1GZ1P/QHiDsh8uQexvW6xtmwnSNMwkPwTBqay519L9KQorxbby0M8R50QAedZTIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907412; c=relaxed/simple;
	bh=SoWN9cC+F0kPCHMqx+J1r+axISwVemowbkgXkEKg0VI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrBuaWBLJfrLBVKslu0y931Ra6wl1vbXp8IE2KKeYObB+LaHAgLWA5MJdkIVbx9hpXB9TWuVFPUiEJ7fN7I3RM++4pdqT5YnbRC8zh+PfFsskWf3WtXCntPuHG6GoMnq8ufdiMCY6LcuzIWIJ4qh/ja3EfgBl4rSI1ZnPkjBiE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTFWY7KZ; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTFWY7KZ"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56ce07a54e8so3678512e0c.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 14:50:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774907410; cv=none;
        d=google.com; s=arc-20240605;
        b=VnJpcvz10zTEopFLzDZJwTy7Vi8nIdPFIWL8+011+2+XxXyN7gRKEzKmy958lFn9wa
         /Rg1TUB6rAsF90qYmK33Q3KMUKc4NGsdmA3hm9Pr7gRnW6y9xYHcMR9xUPSpqS8gXniv
         qS70EVUkcuaZy3tscCR1Ke5gigLEsR1RrPNJFfkVLQtJkxcgw5SizNtYFRO9dThRhYpr
         nwGasG8eNrR+osP2wPJFRGr6jt/qUKtx0CDx3RStIrGg+H86RmCN+ALoU+9ms1/MDeKK
         jBtAUJALQwApn0l17pmWLYziUE47s5mz/24zWGD38IHXXG6KtmWnwwP2qd93ABoJj7Ky
         odRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SoWN9cC+F0kPCHMqx+J1r+axISwVemowbkgXkEKg0VI=;
        fh=d3G+r6gZxawRF62r8cGBQgJa3cP3CQYGHyQc1AgFRyI=;
        b=cVVh8PPnAoJedaD2stN9F97BwcTEpOkl4aEm3d6c2eQDa1ZAKwCd7nz0+nlkOUsfoO
         AOc9q+qro9u9hDFilUZ4uYKdqRDvFIgv8cIcCbuUAf6VKLMWISJHpAOw8Z4Tj4XJ7jmX
         gvAm+H/I6oeANhrlXwmotSjy41eC/S3K0el0fo/f+SNSMh6XYdPCXDl6BRD4x+WMOt0s
         n3hFqfsk6ASdaD8etl8GdKqEsA7KelGbHrNquqf2Hl1hWvSePh8CXSYoD6uStfcouOh4
         aPaw6LByCNBdvoW3TGuRBIBkA3k27VkKr/g2VKsKrVKTXR/E8+mmrnoaHEEnNkXm31PY
         Koyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774907410; x=1775512210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoWN9cC+F0kPCHMqx+J1r+axISwVemowbkgXkEKg0VI=;
        b=sTFWY7KZ7rl+nuDJRAnYt5ov6Dxg3BopqoYqtP77FeKq7yAv77tPqsuQhrQzeqwBe8
         PZm0bxDvpKx2f4dnh+pqr5+pgh/eWltXwgyMsCAE4fyZlgtKKJeCaQvMo1ADEgd//fG7
         t/VbSZ7Ap1bXpNt1EAASHawuuEfmUgg90AgZ8mGZQFxjdWJMfHj3zDQwc4pnjrTHM9BT
         uti/3GzUXittd5iA7qptSLkfRSb52dVK+X85foIKHDJTxWDAMLLkHVHDHjhwfcNFFb8Y
         PqD5HVhItS8Um2RBCrwJe9YGu1rXdkXNmqmxJlCEl+gabcWsWDuT5u3P9oUBZeEo95VL
         QZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907410; x=1775512210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SoWN9cC+F0kPCHMqx+J1r+axISwVemowbkgXkEKg0VI=;
        b=n9Wv9StzvMZwNpEZSDPZUCfZIN5bD+kwpm0qdzEPWvkc+NIA0H/VsO1w9jSlkipXUA
         jKRpiKrdmzXXb/Y6UTSgKNgpBAmWAxEiU7R/QGrKA+m+c2TOxOP154ZICWwRjuWKLWwe
         0vIqpRpuXIZf21cLvPLx3ULjbZW537u3st5jDoV44F9wAjoD/mhUFA0qn7M14Xp0ovdn
         aVH1UUIvF7GTkscuth9fqTGnG6VlP9EYXwtPyTOC0BEK+cqr90lqA+moUj0oYXpNWVVT
         chd7GdvNEW8o6qSQrp0kGxc9WkyYasNKn7q/9XTVVavBWp/GqNEdESTWUL9W1che24Nj
         G1NQ==
X-Gm-Message-State: AOJu0YwBmkfKLHFPUi+ugkMn8J57/fASNWKuKpii1Em7bx2S4gqF81xe
	eyd3LRJW81K5j3FR7hu80cHeNryFPgPxTt4iCpgXKk3TuTOM74IabyDOhF/LrdAHlFDPe5dIpt5
	Lpofybw1fe//V+d9fRB45WCFRao7p1YU=
X-Gm-Gg: ATEYQzzs5o/9rjd1/S+0HSrc56oj+MQ6n0C+gHOinlzBeZwzgytlmzMJNjR3btskZCx
	9i89aWE0pU5bwBEebIHtpsKW7QZ4E37UtERNu3kyu0iE38Ofj4EWdQ/JlKjLrZqcKM4A/b8dKm+
	3d4SkzQBrkF1ahjEUyFUkywoLmbk2JIKF6cuznx+06Vd9026+YWT2lGe2035gYeazjUVK4YtCR1
	IVSywojJTwmaRe3tHcLwJCetKusgIgrSpTcDPX/Bo8m6BGhc4IQCRyq7SKmNFRJgjWsP6gx1TPZ
	PzgRtRQ=
X-Received: by 2002:a05:6122:3a0b:b0:56b:579c:82e with SMTP id
 71dfb90a1353d-56d4a50bf8bmr6213755e0c.5.1774907410228; Mon, 30 Mar 2026
 14:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aafga8AjpxagiEJt@Adekunles-MacBook-Air.local> <acMT0zqd6SiEz5h9@Adekunles-MacBook-Air.local>
In-Reply-To: <acMT0zqd6SiEz5h9@Adekunles-MacBook-Air.local>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Mon, 30 Mar 2026 22:50:10 +0100
X-Gm-Features: AQROBzDfFEjC3ORd21vgnh17FUR-7omJ8ndz36XK5USLMIJiWMZEsPqihWYSzNc
Message-ID: <CADYq+fbsXVtYZcq2wB2FoyUzDdzZKJYEN2EZk1uOvdihMyJzVA@mail.gmail.com>
Subject: Re: [GSoC] [Proposal v3]: Implement promisor remote fetch ordering
To: Abraham Samuel Adekunle <AbrahamSamuelAdekunle@adekunles-macbook-air.local>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:47=E2=80=AFPM Abraham Samuel Adekunle
<AbrahamSamuelAdekunle@adekunles-macbook-air.local> wrote:
>
> Hello,
> This is the third iteration of my proposal for the project
> "Implement promisor remote fetch ordering" for the 2026 GSoC programme.
>
Hello.

Just bumping this up to know if this version is okay for submission to
the GSoC site.
Thanks

Abraham.
