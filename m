Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B520119F12D
	for <git@vger.kernel.org>; Thu,  1 May 2025 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746139944; cv=none; b=oBkBljgOyICqa4VN2RCsmR/323PlvsMczyhGyPiFWQp6tBbwcCmY/SD3AmDmjbSFzp0OsAvJOIBwcyTyQi5I/oALUJNZXVFgvcgPhiaOkzO2MCZs86q7wcFXX1u6V6eY+2dzg9yovFUuIN3WTBj1dHXcEHmQHqNTs09HuVvwBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746139944; c=relaxed/simple;
	bh=/9HHu0NQ/bxoarLx3dW70bl3tgfXhWYwyjYSJ2iLrnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTLggPkc0dEedoShnvqrW1bY0bIDUW/arGLA9Pu/LqTYyBpq2YFYUaY0/EUQSMzkm7y48j1UI4cOmXQfWosca2PTKit7ane/h7viNvJabV0QVkLNBquD5Cx7eOyO/z7CZdk84JjpCJ/tPr/q8xkCAYFikdNp7XdUtoo18B0PvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8ff1b051dso3055116d6.1
        for <git@vger.kernel.org>; Thu, 01 May 2025 15:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746139940; x=1746744740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKzWfa9u6wkQN7hBRvqbGMb3tAUCNeVVT0gFan2cjLA=;
        b=vOMsFAvoBuMv7mdlPMpOc2Yd5ChVo46Eg16UzNhzb3SQhZw0G435hK3wUCwXF+TgQK
         i/Gfm084rc+kdwbvu7DSuDXJP79PYK7OX35jfOiqDm/rdmPuCNYohIBd4oYILhFruDez
         EaDG8jv/9s8czcl6qCdKAfXU5GtuxMJXAueP/E5zkHxz8H9LqMY1RrUaPgP+SvpkULBM
         VUH5FP2FM97VTRGWCbqkDa+QBwG5KUvqnh0UT64U1ieMBRFbbZ2op+mte6AySdPmBAXo
         pvJS35Sl4NefYzsrdErDhyAfeHP/hFaGg6Wqr66ddojPdwM2BUB0XHd9OY9aijfLN68k
         SqSw==
X-Gm-Message-State: AOJu0YwCSO5X7ojvWaAvFwXfhRXafmfgYSYlrP2JXFcmUutWDIePw3ro
	oBHVKfVrl5rwzWT4ax19fTByAnW73Q01V9kVq84fB03fyrFzeGOlJNBIWR2a6TrbZ8Kp2oMU2SC
	yKDxG0Xn4UdyTliYh9g/0mORGb7rS2g==
X-Gm-Gg: ASbGncsMbobHskr0Vy1oxcA7/LLKPp/GVib0NZOZA1/CKUAG2b1wOPyOG74l4HbRrhG
	gOb31nc+HRp4R5ASEi4eVrFXRb16WgizECNP79RQYskcPvxAkUpH5IJeMrO7xKU10NMOeXkb6mY
	UP7wCapOzmcDRXngcr5AWt+n4EU4Jts26qn9ptyJduF7IptXNfHWB8Mqo80uh1/52e3w==
X-Google-Smtp-Source: AGHT+IFgfP7mretX7U6X4csjAQXG3UROpjNJK8+/PmFEynNj3IbaDW3DNb1ftKSibcNaBGq2dk3o5GTmGJLjJs6Rxsg=
X-Received: by 2002:a05:622a:354:b0:475:876:ac3d with SMTP id
 d75a77b69052e-48c331c7062mr4342871cf.13.1746139940555; Thu, 01 May 2025
 15:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501213414.370514-1-gitster@pobox.com> <20250501213414.370514-4-gitster@pobox.com>
In-Reply-To: <20250501213414.370514-4-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 1 May 2025 18:52:09 -0400
X-Gm-Features: ATxdqUGSvfiY0SnAg_zn5hriAIoiAVbIJFO765xq21CU4d0LEFShwSiarO_UyiQ
Message-ID: <CAPig+cQ1CC2SXN6bViusJXy93jZ6k8UvxRXa6mE0At6FgvS2-Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] git-daemon doc: update mark-up of synopsis option descriptions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 5:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> To unify mark-up used in our documentation to a newer convention,
> started by 22293895 (doc: apply synopsis simplification on git-clone
> and git-init, 2024-09-24), update the documentation of 'git daemon'
> to
>
>  * use [synopsis], not [verse] in the SYNOPSIS section
>  * enclose `--option=3D<value>` in backquotes
>
> Also, split '--[no-]option' into '--option' and '--no-option'
> to make it easier to grep for them.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/git-daemon.adoc b/Documentation/git-daemon.ado=
c
> @@ -46,26 +46,26 @@ An `upload-archive` also exists to serve 'git archive=
'.
> ---strict-paths::
> +`--strict-paths`::
>         Match paths exactly (i.e. don't allow "/foo/repo" when the real p=
ath is
>         "/foo/repo.git" or "/foo/repo/.git") and don't do user-relative p=
aths.
>         'git daemon' will refuse to start when this option is enabled and=
 no
>         directory arguments are provided.

Should 'git daemon' be wrapped in backticks instead?

> ---base-path=3D<path>::
> +`--base-path=3D<path>`::
>         Remap all the path requests as relative to the given path.
>         This is sort of "Git root" - if you run 'git daemon' with
>         '--base-path=3D/srv/git' on example.com, then if you later try to=
 pull

Should the '--base-path=3D/srv/git' example be wrapped in backticks instead=
?

>         'git://example.com/hello.git', 'git daemon' will interpret the pa=
th
>         as `/srv/git/hello.git`.

These are inconsistent, as well: the first two use apostrophes, and
the latter backticks.

> @@ -135,8 +135,8 @@ none::
> +`--user-path`::
> +`--user-path=3D<path>`::
>         Allow {tilde}user notation to be used in requests.  When
>         specified with no parameter, a request to
>         git://host/{tilde}alice/foo is taken as a request to access

And this URL has no quoting.
