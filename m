Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42EB248897
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410889; cv=none; b=p3lRyxPZx8UGwaTEyggPcVb0sm4qWcEXTHbUjXGBE0RaHOlJ1KW9PHz3+99yRAdi/4DITfoY6ZinTU6CHnsyt63GIuExC3+rtr/PECkHrCqVzDSTkHBQxuctj+tTZjWjceBJ4+fpF7K+JDkfKrO031bQV+giVdwwx/ACnMYsfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410889; c=relaxed/simple;
	bh=TXnxbWtCxkkpg4tetnNr4pXo680l56oSidooiSs5B0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foSbbRSgjuMewmp4KZjvNvCChu5mrLQoA/iavMWr8K7ySwAE33HMJhtm98D1+wPX5tUTJFoXL4Dq7nmGZn3RNmoM/kOSJxwE60WexdeoxEQRoIMmegvInxvRgoxAgxdrXdthxUHOLkSDnpMyDdWG0eNUZl4KzSvZz7cWBXanDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aM93+MyF; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM93+MyF"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ce85545983so13401425ab.0
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 07:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740410887; x=1741015687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXnxbWtCxkkpg4tetnNr4pXo680l56oSidooiSs5B0w=;
        b=aM93+MyFnjKMozL4DLwSQ6oRc4roayYBtYcoPxr5xY2MyfYEYPKUYQJwf2NVFgSg8c
         KHFeGI/IIuY/DR8H4hswT3XMVV5KoUuHGo4cLVlMwH6dklBgqRNlBT6aJBDIF608kGFF
         RJE/HHjy1Z+A7w7JqEqOhX/teYhDXaC831ukX9vYpU4ees4MS9m2dKqfoPOZ4mwY4jDD
         wGigRnCqrjC+Gl+cWuS95pRzx55d4gqDP4pkYDDHrIg54SR9PEPV196wBiDFh9VPZF/u
         g1BwEvBP+TU5DaL/K6sxS5vSiT/Gpi2R5QAeiJJd61eQe8ndr5xIcCXzmfsWy/dU8c1o
         Y7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410887; x=1741015687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXnxbWtCxkkpg4tetnNr4pXo680l56oSidooiSs5B0w=;
        b=NOkDm0roegl+Ih7JP+HWQmBMq+7gHuOFobjTfi3v4sAyX5wy1MHWoe3f28zvMpmvvS
         tZiLj05PJkR193woKwUEo9s2TEBs2pQvGxsdeMryZkKzPnJ0Tw2ChRJUoT1SYZ6n8F34
         toLPnjgsJUnbO51mXnAKKS1e5zCAyOOrTtJGkPAew3oKwBY5s2698FtRnyHQ1txf55mD
         24itFYz5byu5Ufa5NP98HcShtqAd2gCqpx/R8t+yOAHk2d16KhCGDM5ERpZqctnWw5UH
         1oFKeZzy9UwR4jrdh7qIgOIoAmmNqZeMCpmwfGR0bDyRIv/NDu2mZ7Rs1XzB0leFEjyb
         dvyw==
X-Gm-Message-State: AOJu0Yzk1mWfS+fk/kCiXZBEgjeiD0RUtrsfsJSachX8y37UF+kTJM6r
	NweSY8EapcXtXiJUNLEJzQH0UmnDwnUixO9qoYoUlkawAfBenZaO583kgIYmv965vJMYVz63FkJ
	UXnJwqzLDw+Bp60chiGCniCad91A=
X-Gm-Gg: ASbGnctMyRDnE9jobqe/83XDZg19WapfAHMKoV188W/GHR9LHXJ674EHuHsbV5Rcl8y
	d9dnmy0Pbg4Kl2f3a55CW5N0egbC7a4apxvwoFvOowm9AlyP/9F6h283lh5Uvh5KdHFMJyBzvdM
	xUc43ytTtyYQSzXShLj62yOEa0/FTQAZTBugbjUo0=
X-Google-Smtp-Source: AGHT+IHDzdvXOvhYCeRUC7D6+F0Y1UJlG/Tp4Q9ZE3zKgwYtkbAqon/h3ORa4t1Y3f5i4N2WqwAkjnHOHQxCKghINbw=
X-Received: by 2002:a05:6e02:1522:b0:3d2:ed3c:67a8 with SMTP id
 e9e14a558f8ab-3d2ed3c67c1mr21037675ab.4.1740410886884; Mon, 24 Feb 2025
 07:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025022016263355354612@163.com>
In-Reply-To: <2025022016263355354612@163.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Feb 2025 07:27:55 -0800
X-Gm-Features: AWEUYZmdwjtf7xPyd09Lq9UO4vmDvWFq554zN5PXH5lucl8vNwNDljtyPiH9kC4
Message-ID: <CABPp-BEzjk0PLEMjtk-0jQOAag-s_iJkKMbcU+o5vv8BzRVV2A@mail.gmail.com>
Subject: Re: Bug or just a mistake : --shallow-exclude parameter behavior
 anomalies in Git 2.45.2: "no commits selected" and "ambiguous deepen-not" errors
To: "bolide2005@163.com" <bolide2005@163.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:27=E2=80=AFAM bolide2005@163.com <bolide2005@163=
.com> wrote:
>
> When using git clone with --shallow-exclude parameter (specifying branch =
name or existing commit SHA-1), two different errors occur:
>
>
>
>
> Case 1: git clone --shallow-exclude=3Dmaster <repo-url>
>
>
>
> Error: fatal: no commits selected for shallow requests
>
>
>
> Case 2: git clone --shallow-exclude=3Def5974fc470ad7a08f9b58dcd78724e9329=
910db <repo-url>
>
>
>
> Error: git upload-pack: ambiguous deepen-not: deepen-not ef5974fc470ad7a0=
8f9b58dcd78724e9329910db

They actually should give different error messages, but the one given
by the second case, in the version of Git you are using, is broken.

The error message for case 2 was fixed in 5a875ff7fbd ("upload-pack:
fix ambiguous error message", 2024-11-04).

The documentation was fixed for case 2 in 00e10e07510 ("doc: correct
misleading descriptions for --shallow-exclude", 2024-11-04) to point
out that this usage is flawed.

Both are part of Git 2.48 and newer.
