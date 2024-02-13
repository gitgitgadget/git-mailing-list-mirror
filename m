Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570305F54E
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845121; cv=none; b=XzS2M19AkT02DEZpw7sYAMAp3PsLhvX9bmAmDLIh1KO1SUMGRMoBjDMCgFQaqI6RraBnIVOip7w5Se4L/ZkmTS2ExPkGT5MsRbZYDv0gghb/BV3wrdQlLxZde3JTY+Aa1fncW/q8stUk9UMx6RFwhibiJ31LSfcANtNyrTXo8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845121; c=relaxed/simple;
	bh=PP4bsqy6ndS9ddSnsvxwSgvNY8Yto/q1j17O7m3qoVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNZvoGtvPmpz9afoXKVfAfhNaGafAMMcP1tpqagiFXE5M29OloeytoaRRiIKAyUjreWhqLlpPHm/+IwaCzUOwf1S98jF71OX8Gg/ORSzNx48zWK4obJHnMNBIgVAIH4AL+jB8W6/95nq5aNUPJCqQ8LiOetvyzobJiiW8HWtwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Htg5x94k; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Htg5x94k"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2a17f3217aso596745466b.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707845118; x=1708449918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PP4bsqy6ndS9ddSnsvxwSgvNY8Yto/q1j17O7m3qoVY=;
        b=Htg5x94kQJ1n/6G5awLm/aF/sL1jntjYpeby1bf89QRINjlC+x8L/QAavCYtjFQNhG
         i22NpkaGGoH+i9xzUU4uxfoH21DqQqcu53saSlZ4K0cEvqBDsYkA7B40e1qTrZ9G0XSj
         gldZCTBe/lsDZI/TlXEQND+Qz4MXIEViYwcvDpJjw6ZAtE5y/slf7o3ikSg6uwKkI998
         brk8pgLLDmo+HKS8qsZzUcIlVcPEwmMHToqW0RS+Jxfgigu2FrDntALTXceFS/pKkL/g
         3vYUCjuon/w1Y/t9btGdEPZOZwW/ZZxcDW6Xc+knglheY27CvWtZ/58+D4/halZqt9ta
         Iq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845118; x=1708449918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PP4bsqy6ndS9ddSnsvxwSgvNY8Yto/q1j17O7m3qoVY=;
        b=s77YtfH7KSJ5ESDOJHttLcZ2hGmR6E0OQyx5W9RxWqQNRrqZLN8Ce/6vVewEzgdQjw
         GY7ldX6NqeT/T25qejGPOxPTGyx0Rnobz1jB1eilHitlyhj4hzzE2/psnCxps1Mm4xtg
         HwRM+KKf3wmihKpFiGE24R37LH3Ogk84rFlyW34WQpV9j8lSbqnJUC5BdPa9djuH3R1G
         Pvn1ijLtawGJ6+Uu3YYxqCAfJBXkuhorvRZVa/wxTp9ZQmq5IXzYo+lWOxq7UpIB2VQy
         /wRMk2z5M7oMm8H8OcSRjFpiaA9GA1dd8SNNC3ojJ2/5SX8WDh5LKHKJhIjfp52S4dbY
         Regw==
X-Forwarded-Encrypted: i=1; AJvYcCUZn5QZRUODioiO9+VFJv6+P5W76trJeBUp3lPbwJgt//gbdcA/X6SScuR8F0dvzrr7aD9QUl2Q/kcjqm0hHM11GsQl
X-Gm-Message-State: AOJu0YzyvaTtlFUTWf/et37WF1a6NnzJmXLOLhkKpfyHnNfhOh7WF7jH
	wWqrfhg8ihWdhxD1BzV3+NimPXOpIbcCmpVrRnHDKmMFAeabVgt4s+BuWq5aH7N29ORP1MEbv1z
	gWEuu5TDbQvoiFxrN9QS91tblRGX89ohp
X-Google-Smtp-Source: AGHT+IHSUQ5S1mkXhavKrhzyNB3p4P0qjIPs+vk/SM72mxHGm7qC5kKvbtI1iFJ8eh237CXv2JEfuGVddZFmaLqiDd8=
X-Received: by 2002:a17:906:370e:b0:a38:215c:89b with SMTP id
 d14-20020a170906370e00b00a38215c089bmr7647538ejc.73.1707845118258; Tue, 13
 Feb 2024 09:25:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <ba1f387747b08a7270f7387beddd75dc4a8eddfe.1707196348.git.gitgitgadget@gmail.com>
 <CAP8UFD3u+QDx2LqpO2ZpeHQszwjMAsQ90qqbE7Om=t1vPRQ==w@mail.gmail.com> <owlyr0hgb7qg.fsf@fine.c.googlers.com>
In-Reply-To: <owlyr0hgb7qg.fsf@fine.c.googlers.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 18:25:06 +0100
Message-ID: <CAP8UFD0nmK4ZigW9LcWOr_POEX5LX7m+T=Jq9rK34YL5C6xatw@mail.gmail.com>
Subject: Re: [PATCH v4 15/28] format_trailer_info(): avoid double-printing the separator
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 6:21=E2=80=AFPM Linus Arver <linusa@google.com> wro=
te:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:

> > Also I wonder why it was not possible to modify format_trailer_info()
> > like it is done in this patch before using it to replace
> > format_trailers().
>
> The artificial organization apparent in this patch was deliberate, in
> order to make it painfully obvious exactly what was being replaced and
> how. See https://lore.kernel.org/git/xmqqjzno13ev.fsf@gitster.g/

As for the previous patch, I would have thought that it would be
better not to break the tests.
