Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E951FF5E3
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766105604; cv=none; b=uTVa5vVhNOuBOpjxZsFWco0QBOGcyAhn3DlKOkjrKpR+gTjkB03YWq5vtC2WRB9UDWPav7onsimGfz9BzBwHuYOyx3Avn/U0CW2DgxQJZVOgL90e7Vqw7lHyC/KOLEoHyc7cwg08dm5BX+E13UChDnC/SRXN4aGSZ5t0oOgwlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766105604; c=relaxed/simple;
	bh=Azl4Sjn1wljwizHpNEM4aTqceOvVBR8V/8D4zFTA3qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q24JgBLO4VXBpM7MeGeYOLIBG+unVt+1lf5krh6vLZOhOOvObuNyTlTfJpa/hSuqirseYPADP7Kh/bvufEMBhNH8EUU+8+5bcJWGIlE6ftOD65uEtHy24Y1u5Sp1LsE/KnF9dP54X+zHGrKZiKwj11F8CQTC6HNKy6xLeaHYlXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8bab61442dbso18475885a.0
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 16:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766105602; x=1766710402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ylslWx6AX/CcRrW0Gbe83XEbx42Xi71CbyhnmwbXrQo=;
        b=fOXdelAVKYw2DlMS3yPhH4nQelT1HUnUX6W2gouzLbHxaj1HE4zQ1PaG+pbw5zsZqe
         +t/98zVU/zU6fA1nNZ0QTLOiJuoRHEewfI/keLBRr1IXGn9vYUuWuRDPFcJKGxsGJaXB
         7yT2x/yZL4h/i7tJ0na3TLSqff20H86+zzwziBsSwpFYER2cmgFSPhc5Z1NH8vD5nQM7
         4Y9j8z4xOa1W2U7em8gIUm9RVvc8DhfanDGFowV5va7edCQIfyGs59OXdZlgUKzzQ2ws
         Q+CKdy0tpEIkkPd9QnMRWfj7oJQoQpegYVxps8D//ejlkrgaTVG22DStJ2bvjluyysj7
         y1oA==
X-Gm-Message-State: AOJu0YziSlwHGbo86czP3woqsDkKc4ZXTVtdJ3z0FlbC14bgXH6/lcOI
	bELdMv2rie5Xo1L0g3B3ZZ7AhzvYLvShElnd4k/lgKUfMCfFuKw/Pq88iOK101L1Yn8P/0vg0U0
	xp0hBRUxv7+Yxqlp1sivHUej+zdcwmiHScw==
X-Gm-Gg: AY/fxX7nGUU7KksekO4h80Y8FgyAb6mGRxHNijyfmUJByulW1hs+2xVgokLTzD3lXl7
	ujo0pcDoSxzon5yEVtl1O6tWXIdwhfajuv9MFyYw7uKYPYrfWft9RZDf6KY3kL9ATMAP4kO61Zx
	eN00jd6FhMCJ/JyhO68E7OzQdIxHyBz3bhmZScUhERVaVe8Ys7U+CIoqyrd+oFHx0FvvuqHQtPi
	GIr5ZgT84hglH2p9OQ08pl7j6yxXjfJnAk1sud2lwj014Y2rWMdzROZ9rnQHHzV6NLH8MUC+OUw
	sd0hc0wqgAkg53NQboDT/Chokl0N
X-Google-Smtp-Source: AGHT+IEpUWhEs3QWbhGGjhQajX/srybnmFaNAs2sV0TzxiM1LMLl+yfb5R4Vj6JvcpHPa2EXCS8ZAoGi6krI0wBFuqc=
X-Received: by 2002:a05:6214:21eb:b0:888:2032:4ad2 with SMTP id
 6a1803df08f44-88d84b20362mr19157436d6.8.1766105601716; Thu, 18 Dec 2025
 16:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a33f4e5118938300bcd5b2991feeee855a1c8f86.1766100330.git.ben.knoble+github@gmail.com>
In-Reply-To: <a33f4e5118938300bcd5b2991feeee855a1c8f86.1766100330.git.ben.knoble+github@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 18 Dec 2025 19:53:10 -0500
X-Gm-Features: AQt7F2o1-J2CZz8X7M2SDFdKOS_7NvBDlHuvj_J-QA7zdx7d9BN56LC68g2GuXE
Message-ID: <CAPig+cSJa8JQRBATOYoizE4-Li_zO5o4FkFR7okiVDYdndSWZQ@mail.gmail.com>
Subject: Re: [PATCH] rust: build correctly without GNU sed
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 6:26=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
> From e509b5b8be (rust: support for Windows, 2025-10-15), we check
> cargo's information to decide which library to build. However, that
> check mistakenly used "sed -s" ("consider files as separate rather than
> as a single, continuous long stream"), which is a GNU extension. The
> build thus fails on macOS with "meson -Drust=3Denabled", which comes with
> BSD-derived sed.
>
> Instead, use the intended "sed -n" and print the matching section of the
> output. This failure mode likely went unnoticed on systems with GNU sed
> (common for developer machines and CI) because, in those instances, the
> output being matched by case is the full cargo output (which either
> contains the string "-windows-" or doesn't).
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
> @@ -26,7 +26,7 @@
> -case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
> +case "$(cargo -vV | sed -n 's/^host: \(.*\)$/\1/p')" in
>         *-windows-*)
>                 LIBNAME=3Dgitcore.lib;;

This change looks good to me. Thanks for tackling this.
