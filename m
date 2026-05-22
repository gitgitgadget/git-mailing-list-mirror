Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E166E3D3309
	for <git@vger.kernel.org>; Fri, 22 May 2026 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447103; cv=pass; b=EnD0ol2cc3qRIgF7wNehAxr+n10jCEuITl0nXVf+2bXEFoWiGw52OwDb+va0dA4WeyIx6ADzzAOyikvPB3Qhb6lKFsyPaoG4G5xKwuT0qJdgLEXRIFizMbg1tNzfWM+TWYvsYhd6PYWK0V4GJLhmrpjaFTFa9WNuVDqr4flrOCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447103; c=relaxed/simple;
	bh=UJquJNvflbu6ucFKUxUZPIdXR35RGW9DAC2d7MrDd+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsfbQ8QKfn3E15KzoE6tGmUvo90xdB1Mk9lOwHNGGiTOWpoQK/YIEdvdbO/ryWI5JxOsjKK5KoGS36jIM7EhD9LuyxuSDU7gRbKM3D6Y5x9gk3WQW1QvvV4FgCZ9YQ4QWhjin2C8FXIiwYvHP5IWMoHw6isczzOh58mhE6+B0Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMvuTVFE; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMvuTVFE"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd11a3729e8so1127380466b.0
        for <git@vger.kernel.org>; Fri, 22 May 2026 03:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779447100; cv=none;
        d=google.com; s=arc-20240605;
        b=fCBKeITqciA6rDugTEjUOeopcwgPa5Kruz4e3dWPiiyOkZLZAWYUSTEOqEASjzX59X
         VzM3baJHBgkiRmsyWqxUgwxVvhOppl6d4m9cXhSMrRb0vPbEqG+Vvv3USGde6dKPFUyh
         y+WI7RT1xAHSWnk+P5sastQ/sxW60rHQ/TwOKk1vr2V5xEWPVcPUFBt9IZzzJtM96LFM
         VKP2cx507YCi0bgQzuJ0ALUrdv5PsjT2mu6HZAC5LrHOjvoQ4/LGn5dcMmfxlqP0QjT5
         EdJEzUNajKvK8HeBeYCMgo1lVmT0fkG7/fCP7g3Iy2ULzkqT+nMy/gCp5UEmN97LNa0N
         XHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UJquJNvflbu6ucFKUxUZPIdXR35RGW9DAC2d7MrDd+8=;
        fh=9M+nktag9+0fYhU/4lAF0LF7vM7i6WvymUVaXn7UOoU=;
        b=ER7FuckOyxE8fU5cVg1fY163IXmWmjqbpi11cuys+Doj7/gQpi/gYvLAEIeKREDaLw
         xVJ9Md2pTAad5ar5JKHTJMAIQABau4MRII5fANjAd8K5Ef45781uTX7tnUfWaSwVeK1T
         CQGViuCtbZ0ibOM1wTMrBcfMZoj/9C9HI5Uw5uzPbMRrJb4dkC/HZcHwO3BS/j/3zGMg
         6bdrBjKrgzm7tJEimKWaSgPr3Xx8uAtmA55V8eml6YV9xXCfETXe0o6OlhV7lzUMusbW
         wJ7f4CBotrVF0HHuaQ485Q/vnTRPepw78IXgLz3/c7llKGN+VFHeUbOt/c/k628el2l0
         dqVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779447100; x=1780051900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UJquJNvflbu6ucFKUxUZPIdXR35RGW9DAC2d7MrDd+8=;
        b=IMvuTVFEbZIC1mDB/0aaDehlW1L4hLvyXNQ4cvntN1PRrqPYKg0O/W3Lx7qiQGa5wS
         2scZsceQU4b7rsokvskV60qwyCytAY9FHehbMeDyqSiYEeV08bZiaL8FH5WILgbo5ehA
         hkC1/ih1Ghvotjj9W8OWH3jnv06bXi7X8KGI2Qk2PK7IJygnOSlxRpvXKgfqH+Jk+6dC
         rSelieIzlkQqttD44WsrhwKwMYwtIkAL79GPMw2Bm1X41rLrBFUeP2knaf6BwzrfvXB4
         4GRosF3bmbaA1oS0XN31pwPNjtWAWlkPFHnD/UQVnlDYABhv7G30nuIX/zrh4UMRY1zq
         JTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779447100; x=1780051900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJquJNvflbu6ucFKUxUZPIdXR35RGW9DAC2d7MrDd+8=;
        b=RcbIn7+MUC7clZA1KW6CbF99v3GZKMIcRRFEB6ZF1S253DQCgevOW3SInH53TcQl5V
         KZK6RgP95g2bsRvgPvaI4/OEByt7KJ9+ObqXtBrLZg67dUwY68zRSU2a0EtDAt6kNXXh
         5SDY69iGLm8HRxh+dnMQQhrHXU54Zn7n7Ct5lpJBcDXAXTTM5nvAz0Nv88aP0iG1mmXw
         qAAn6zDI+MnJKDh2csBUnShRIfD+fKcMiCrBDdOevQ9LpTHFSL+c0qtYatqdeU/WzBQT
         0cQ1RCVGn3Ghg7yRbGuEzW5z7xf1CfwvB4rWYf1B7snf0zSWXS8y0MhBaFqMTvIkUlyr
         +FuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YjUZzp693m8Xocarxzcne12mSzH0QryAhol7QUQLP54a4bxpLQoM1Br0+CvnJv/OdMlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyin4M/QTEWPbhfIOjITnhEqrsWThMpMJBFXCU18vM0R5tGUVSK
	LolXNHL7aWW9JKmcK01zLTIOjPcdtJHC5h2dzETsIC/becoqsdZuYxBvqJqELqaE8byCzAk5wUa
	9q9JdeoK7d3KMDYP3uGymooAYUiI/qVM=
X-Gm-Gg: Acq92OF4zIDio6cxzFNJCQp6hUTFucjG/T8s4C39I67Vl2WAmnoSLF3Cj4LSduxW4+d
	W6M9bVf8Kq0pblzHmDxA0VzLu4UF3mHBjnYFtTlsM7q5cVGofoY+HSReV1yqpW1SJ8VLYtlOeq5
	If9S5BQQy2I2Ffs3ySh9nUgNvHPi0aJYDHounDArAwF+Rt8cca4wTed2DArOq/HLprQOQsPJg6X
	xeuDbIQAOnvZivT/49rXlbL6YebpEMjz6pm8kyjhDKZC9tlpgMEuciquoqAd0Zh9I4NuRS8NNzw
	B4OF7mU=
X-Received: by 2002:a17:907:94c3:b0:bc2:70ca:c41e with SMTP id
 a640c23a62f3a-bdd25ce0bf7mr183777966b.25.1779447099921; Fri, 22 May 2026
 03:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
 <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com> <f87e96e99d64c48bd92afecf3a6a819d36e56f6c.1778700883.git.gitgitgadget@gmail.com>
 <6501a3d5-a5ec-421b-8526-ee7d4ae5ea98@gmail.com> <f1d15d08-6fee-479f-8ed0-34efd256d8dc@gmail.com>
 <CAHwyqnVhhwT80Ao+7QLUAsTnUJaN5vE=ZiaxeqF3rYxxiD_Qww@mail.gmail.com> <6ae90274-3fbb-4d2a-b0f4-cd9260e4d6b3@gmail.com>
In-Reply-To: <6ae90274-3fbb-4d2a-b0f4-cd9260e4d6b3@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 22 May 2026 12:51:03 +0200
X-Gm-Features: AVHnY4KJYwj7f5cu3FTkOL3H7DEc9a6BwBbtPxYIAcT1tu2LvOz0nIMZisECWVA
Message-ID: <CAHwyqnXSq-fSE3vhtaOxQ9iy1dwP-Rg3Db5dD75Pn8N5dfJqsg@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] branch: add --prune-merged <remote>
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> >> While we want to clean up topic branches, we want to avoid cleaning up
> >> branches like "master" which follow an upstream branch and therefore
> >> look like they've been merged straight after they've been pulled. So I
> >> think as well as checking that the local branch is merged into its
> >> upstream branch, we want to check that the local branch is not pushed to
> >> the upstream branch i.e. that branch@{upstream} != branch@{push}.
> >
> > This one I handle already by letting the default branch be guarded.
>
> I used "master" as an example of a branch name above. There is no
> guarantee that a remote even defines a default branch, let alone that
> there is only one local branch where the its upstream and push
> destinations match. I don't see how you can avoid checking that the
> branch pushes to a different ref than its upstream and still be safe.

Ok, I'll give it a shot!

> I'm going to be off the list from now until the week after next, I'll
> catch up with this thread when I'm back on line.

Enjoy the time off!


Harald
