Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F4B2AE77
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771233811; cv=pass; b=r9aNzAYexIZ7BkXNu6M/BXzN6bwhzN2xhz+kRkRSId6JZ3BVkJuJ/2/8VmGDOSxhlasMFsBULXouPTc0U+KxZBsVk19RtrNnimZliclCv5VUnHla5yFJW658G14W9bCq8Bw2ukMcSEehy02zDzqYS0cj2o0sEBBHQTTAZPx20dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771233811; c=relaxed/simple;
	bh=0zjGTAMtmjqz/PjwIdhzrMjS3lqxOxiG/6vr3ZBbogk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4fIDD304GhfDQhWybYsWdxSDSjeR+8IF2d0iFhlu5YgsSanwxGMEq7X8HAnCMbXeIL7LcsI0QcZTL37Y/eLyl0iTpnxZ2qYJEdnttHlhrfO47gs9ddRodDxQP91XkYKSBUxTwXomQE4zbl0iAZu/N3w5dNyRhe/pPWg461WGWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGXyip+/; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGXyip+/"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba68df3687so5270542eec.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 01:23:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771233809; cv=none;
        d=google.com; s=arc-20240605;
        b=M271umdnP6P35q6PxZO2EClLJ9iLjk47CFpvFKyvuCv+5A1jirZu6pYLTuDimjeqgI
         Bq7Ws2HHVDwKuo/QuRikZoUh1yR5i7eKW0Y/Zq69tzUVIZGEWn4aWjd+dVEdWabkyAzA
         6Dzf7pRamFTlvOWaYd9xdXETaAcoLqz4FGVdW5x+20aT0bImvuij/t+WgWBDzJvbAm4J
         c9YmxMEG9T9qu7hIttXf6iu5z6i6nernEw0m+H7xS5M6jmqZX55Hlq3gXOWrnX0PRvcj
         z36wfYhb8nb5F6d3MpASBHBM4vGuZ+Ra1K0QI1JZ7e5MZtHTWXHwGXtWD63UX9RbnW2+
         UR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0zjGTAMtmjqz/PjwIdhzrMjS3lqxOxiG/6vr3ZBbogk=;
        fh=ixUb2l2hrASaZJ+AYipvdfT+QE47GqYCY6tByYLgH5k=;
        b=Jf75vaKtb3oI4IkBjHUM13voa37BPxQcKV+3Ug8fSsPc4jTHBYKzUDBqgy5yj3ts85
         Ye1Ll9XAbPRwEMyeEoyVsQouoPBXWztDbxQfIoWdsg0+Ws/j3ICCl/M/0b0spFxzeypc
         rsEni2Gj2fVZO4XFZZxDIj7XzfwK+0GuTWm5s/4fu6FA88bznXFd3V3Uo7iyQZhvOTlE
         N2GnX+v3/93xyi/+B6kIERzKur0nxAhfnoymonlPWmkIZjbs4rVYxiWrrxJm0r5v7t7G
         Ka4zHC3JT1xRcUFL79aTJJwH5CRrayvhsfe8Muq71xpVYvjVSAIi41B+vXvSeRNWOqLL
         wXWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771233809; x=1771838609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zjGTAMtmjqz/PjwIdhzrMjS3lqxOxiG/6vr3ZBbogk=;
        b=BGXyip+/WUkaCioqiHElRJepRA8tPOuPu3a7dkgJdqIT+STYoIvOfTNg1lY5SVcqKa
         FlQWDvFjZBaXar7C14PSH6osopgJjeO7YmLRf6Z/EJOeHKF3FYo0pJX0rf3pFUa03J5V
         jImCuC7Op6eNUwOGjr8C4Ws8eWm/xeP0jYPhh/L1XRRP353y3OrN9R5Pw1+IuGKiZqUc
         ZWH6t+Bcf9gBI8bOSrmLEiZal5u5tfNAf5ak1DQXpyvlYoU+uiR9KiEpvooOYxvCVp1A
         cB4a4PSgBlrTI5F8txABDZEsx2X5BopwFVItSS7YuyF2f1h41FGVPfvT5QHOQvOZIKvI
         s9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771233809; x=1771838609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0zjGTAMtmjqz/PjwIdhzrMjS3lqxOxiG/6vr3ZBbogk=;
        b=MnIof0Ndkavvm4ww2Oer9lFBkgiOgn54ed8/HoNzsPh8tyswnM3UiF3ZckW9OGJqTJ
         VIDVh/BlIHl0KAVu8VgOxqTu+xR18j4v4rSQK1Qz3YS4+KIcKKmBMXVebZQ6J9o9bkJV
         +ESV7ORZ1JlrHDUoQ8Ths3fZkyabbIF6LA88qk5sQm61aWAq0wh+Ylhc4yBJ9PyfbR8C
         B89Aj+eperVymk9LSGNmK7BYmKHprOaRR2FCaSLPzT/JWwjlkqugfAC3adRTemZQ4dCd
         4OArm4hTkKh3ULf4eM2QacqhncFBXtEcQyXyg6/TPgZxr97+4iXaz32Q3ADcVWVbtFfO
         yDmQ==
X-Gm-Message-State: AOJu0YxdN2LAznEZcMffWG+CneuVpnJA2L7HwaeS/uqvQUTzTZBNOgHI
	ZnxA31pPaOrubmfJu6+AigkS6kam4d0SgL2xvnB+9A6oSZ6xZmgI6d0gLWf7BCz18JPC4vczMgJ
	lEfAuPYBx7I5eUo/YipvOaYczVtekQb0=
X-Gm-Gg: AZuq6aI5bsBTKRoBauyFk1uD3BF5Wx4/WgNESFQSQ5aKIwVgGFQSYoGSxK2ELTzalfP
	Ch2WSNTKEaArzFGM4gB5UvMuBH6hL7Gfdvs/bYa0SABqcp/HKMqzJXCar2Y9oHU7Ylis7oM8kv3
	B3MKRNoRDUOr8Tp3QyYzboJExJy5i4GdKjD+F1kfPIcbGzlegl+HA9RJ4W9hZTcc687eqgoNG9l
	czAfdiMDvfqyTiJsFhp8txkayg3bqfCRYjJuuadivKk28Q/xiPU72r+vAFLOELlE8jIP4hWU22Z
	8FDi60pqHlV2EXGBux2pfe8SMFec2h3vPko3dE6zYHH0Wsx0ifMuyjy+DYVDZDv61M/j
X-Received: by 2002:a05:693c:60c2:b0:2b7:f145:a94 with SMTP id
 5a478bee46e88-2bac97c4fbemr2394410eec.30.1771233808909; Mon, 16 Feb 2026
 01:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
In-Reply-To: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 16 Feb 2026 10:23:16 +0100
X-Gm-Features: AaiRm50O0ebpyQTjxGKjVglgiHeWMrntz6BtJlyxbMq_-v9JE8wZdCsQugUszeo
Message-ID: <CAP8UFD0=7sCe6oEG33gb8Gzug_ig4m-breNJeUbBk1AUvuaR4w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix tests with missing iconv(1) executable
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 1:42=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Hi,
>
> I recently noticed that th MSVC-based tests in GitLab CI started to

s/that th/that the/

> fail. The root cause is that the iconv(1) executable cannot be found on
> this platform anymore. This isn't entirely surprising: we depend on the
> Git for Windows environment to provide necessary shell tools, and that
> environment of course is not a fully fledged MSYS2 installation.

Maybe this and perhaps some commit messages of the patches in the
series could also talk about
https://github.com/git-for-windows/git/issues/6083 a bit now that we
know it's related.

Except for this and the documentation issue in the build system I
mentioned in my previous email, the patches in the series look good to
me.

Thanks.
