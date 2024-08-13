Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE9A55898
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579084; cv=none; b=B8Q5Zd8ZjwzcdQROHbfLN39ZtLsUcOKgIiRCrMxnLFg3nmXlbxriCt2SvHPIDa0kCmDWIRk6ysWq3AKqK4FY0wKWXqlEcpPi9uyTJ+I+skfuUj/NQ9jmhVG3yMVH2HzxnVfRDtiRwq3e3jZCN9gvkgA2x3uQYTJyFD1LG9QzYRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579084; c=relaxed/simple;
	bh=DPOFZBZqK7ntuxB3MrqPWlo5oy5XBtBT5nHJDJBvpGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dG+oKzIlQG/l+5/yJAi+FHULOrCiN05mgj2jc+hLlu8weU3Pbh7ZEqMaPYY7MrkyspOUlZUQ5RKFFrqxMLzkVUcyOf5ZyTmRJP5EYY8f8SDeeHqG3xzdE6NBVGXcmVwuMUcfgCZkVnlVjAGJfISsJRrTgHtUvqMw29sLGi+Qzt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b7b23793c1so34660506d6.0
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 12:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723579081; x=1724183881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsRxhGQFBQcKm5NKWhCZaodCprps4/+pQzWedQ8pdVY=;
        b=sgS0+COjaOaeZaP0vI/JHzxQ8RchGlo3mvtpMigfr0ig4erQytNyc0qu5D5oa+X19Q
         dt1QSRUKf+cbEbzO5W6XAQAZzPRJNnNnTI9Xpjmhw+El8pgJw1QWgoFIUQssl9BBSMsM
         iUGmQyGqaEOLS0e81kNOcKAjeQIYA4nUNPkFu+lMC3/9i9JHcYkTKCrSBJfnROBB6xlI
         26ViXhbYTUcZRqL4/UQ7wPNrphh2AE7bL5ZNF0yEBAQunhBOPTk2/xC5+jwfwCpb3N7I
         6IrOYWrI8sye4scdLsIBhr69eoQP8Rw5V9T2Zrvw+doalIH8dxjsrBDS0fzHhIsjivco
         7uzA==
X-Gm-Message-State: AOJu0YxpguruNt2SVpx1MrdYT5F1POVXZNdswYg3Rx0TfXilc3JRa7mt
	DZbUTE7Khi04mhLpbtwJpBkPEGcM9XebWO4aNv3zCu6rzTKI/w93cbWhIFl6o5waS0395/ne03n
	1vzhRCdAKbGQjUzM7dsNAI3FvIoE=
X-Google-Smtp-Source: AGHT+IHdW8SKFD3IAI4hsrFv7FUlXGgkkpPQvNRSyRufSLZjO3VNxZzmkbdG8yFisbaPhxkHA+wBHDlyd8xCJG5Zxk4=
X-Received: by 2002:a0c:f409:0:b0:6b5:e099:4d69 with SMTP id
 6a1803df08f44-6bf5d1c4915mr4810596d6.26.1723579081386; Tue, 13 Aug 2024
 12:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808163302.17521-1-abdobngad@gmail.com>
In-Reply-To: <20240808163302.17521-1-abdobngad@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 13 Aug 2024 15:57:50 -0400
Message-ID: <CAPig+cSLzNyik6x2FQo6T4fAtTAsH07=y3g=MTXcSTvR7S2Vqg@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] [Newcomer] t7004: modernize the style
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 12:34=E2=80=AFPM AbdAlRahman Gad <abdobngad@gmail.co=
m> wrote:
> - Remove whitespace after the redirect operators.
>
> - Move number of expect files prepared outside of
>   test_expect_success to be inside the tests that use it.
> [...]
> There are still tests that could lose exit status to pipe. This needs
> to be modernized too, I will fix them in another patch series.

Thanks. This sort of information -- explaining the aim of the series
and explaining what will be done later -- is appreciated by reviewers.

There are a few additional pieces of information you can include in
the cover letter to make life even simpler for reviewers:

* provide a link to the previous version of the series

* explain what differs in this version as compared with the previous versio=
n

* include a range-diff showing the actual changes between this version
and the previous version (see `git format-patch --range-diff=3D`

There are many good examples on the mailing which illustrate the above
points; here is one such instance:
https://lore.kernel.org/git/20240726081522.28015-1-ericsunshine@charter.net=
/
