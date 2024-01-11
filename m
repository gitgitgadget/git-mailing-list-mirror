Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EFE50264
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Luq/BhFf"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so664106266b.2
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 09:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704993959; x=1705598759; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+0+rTX5UL9yv2DslU3jMdunmnHJzkcCZOHf/M+N0HHY=;
        b=Luq/BhFfJmqQJGa7DD6UGqA3243ElnfrT5zkwuMEB5CAu/rfu5P0mOKtgVBblLP9Qe
         g3AvD63C0dJTSaBSeoEcKVM2i7JcNBUjdRzwmaSDt/uwa88afMfUEvasEkMgLoWpFIFF
         vWzGkUwITdwfHdFZ38h2v1gHmCMUrt2RyFws4+7NmWmMMVPoutUMV15CtGtPJEfIIbCn
         WSaQ/HjBCcK2Z03PqWliVGZHmJ9gfADJifTAfxQEWbSb1rpg97t5RoYc12j7oix+lcZ4
         jlQanKiOwCwLqbxXaMv3FcdcBa7YuBGVV8e36hTWSWqLsXvKGElxWbG/lQUDjh7HU8fx
         IBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704993959; x=1705598759;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0+rTX5UL9yv2DslU3jMdunmnHJzkcCZOHf/M+N0HHY=;
        b=fuwfRoHppTkuB6Qmp8k1/OsJdXK03kwxcfzP1WPt2iCQa9kCaDUFZ9e1NYHe3ggchO
         xVkVzqLKWEIIV1niX913B6nF4bqp4F3f0etLMT5+PPxZjQpzGIjiUx+2P19sgCN0xvOe
         Cb5eqlfcarAuiHDHbjrSeIrYsfgkLb1pzdZCwnccICDD7Fczcz5jEqmvNgqr62rx8G3c
         dz9bfcLAOEJU0AqA+m+/9LSBoTWY4ZXgjvV6ULpALh1JutL7YK2JyiP/NyJ/krsaRzLy
         Yw7I/RSG72eO5GjkLQWftR9pGPvMtlW7jEjgwDrFtUdn/GDkotJbmstncxbG0k5uKJ4w
         zCtQ==
X-Gm-Message-State: AOJu0YwUtBoYfuxwSneGVSgt8TdUVCwT97+QaMcMdlzBe1lrIicWcAyx
	wJL+akSNxA1aokO5a41+/xiag55kiT+JWoF8p6+5YitWLW8=
X-Google-Smtp-Source: AGHT+IGoXwWzNPETDZNhy0ErcZ5X5alvDyzYRps/lXl6N2/MHPyAcVIGNu9nd0XRjIpXRaMGowdIk96bX7b9bMbsvYI=
X-Received: by 2002:a17:906:1159:b0:a27:fcd0:13fc with SMTP id
 i25-20020a170906115900b00a27fcd013fcmr412eja.168.1704993958857; Thu, 11 Jan
 2024 09:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chaitanya Tata <chaitanya.tk17@gmail.com>
Date: Thu, 11 Jan 2024 22:55:47 +0530
Message-ID: <CADA7-FOE_81ze8hdaRGLPbipihnvFcEYfp9uwnPxPVxDepG4nA@mail.gmail.com>
Subject: Add support for `git rebase -no-edit`
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a feature request to add `--no-edit` option to `git rebase`
like we do for `git commit`.
The workflow I typically follow is:

* `git commit -a --fixup=XXX`
* `git rebase  -i HEAD~15 --autosquash`

But it requires closing the editor without any changes. I can
workaround this using the `GIT_EDITOR` option, see [1]. But it would
be good to have this built-in.

Thoughts?

[1] - https://stackoverflow.com/a/45783848

Cheers,
Chaitanya.
