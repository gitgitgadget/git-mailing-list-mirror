Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7951917D0
	for <git@vger.kernel.org>; Sun, 25 May 2025 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748212977; cv=none; b=QbFoG7tNPSrDpd8mLpOJW2jof5F1uRAX0msI6m3EB5Bo8Eo37WYNCiFCpqm7AoaF4G+cgGCKj2noKJQYizK4OCHvRwgxjNWusGYAWrJp1X9GkbgUBbjc74mbKv8nlbRtQm4oS2Nrvu8YgWWnP0DILXFoqg2bzosV6EXk0Z1bCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748212977; c=relaxed/simple;
	bh=qGllS4yQs6qxf6WOd4A7em07YKUUnoWqdGoAFbyE4YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hp5ThJ2B4e8PPdAIE0xM7/93nBikwjJf3bYRjBJdw0dHiC75Eqyd1eWyVMIUMTD07IJzvXXFJRyPfQdgZKCEIXCqWEQZH0bTvIW1CdhG10XiIAw9ExkBs/8pWiiOzcOFmbI15VBInixlLHEVGWyFnLFEhDm4dIYC3MksedD4KpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5a3334fddso36500985a.1
        for <git@vger.kernel.org>; Sun, 25 May 2025 15:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748212974; x=1748817774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHoc6d7XuNF1J2/lsgvVERVVC1eE4FK/mE0G4scBLW4=;
        b=Yu8qyFkpoKDKYB6MHgqBScZ3QzLvkYkDpZYEP17BQU7iE9JwLZWqlzaAwgN9M3stog
         7ISmoBfZx4JaXOXGh8h0QXZ6g2fsPDB3yf8vQxNCKT2yg0Ow7JqZAhuSsLBxOmHCjcOM
         /meZZWltrDXe75cSR22cbZKqer48FL96dlM8ztIxUacX7Zsq5h6nQp6ub1QVwEbCzJY7
         GCSHabYvvdkt3MYfiPXbYi9B2u/TaQQ9nG4r5RYzpcgFzQQ9ME0v5NjXzUxE0ehCYqMp
         6yd2Lh0KaP/dmZV/5WrBEVi4s+MmnM73+/8AMWlFqSS9Kwt2aqyrwh1ecDUthd08YktQ
         5RnQ==
X-Gm-Message-State: AOJu0Yz23mEgGKAHH6H06193FZvXV8pFdXdQyZjeRUuo1qv626jMDB2n
	JFapd3BTosQ8GXdRyx02ZktaPVpvFJwWc4evxgDiSiw/hxRXHnzecKbXW8Lc3LdaksDAa5mUy8p
	GCMtUB/q8nbiHd/Bz8BsW7aUdhHy1d5A=
X-Gm-Gg: ASbGncu6zcpJYcS+w539MmjtM0dwB3x/5OYv1CehWlMxGK1JTqZZtOfoBY34ZfTw7OA
	5v0sdhtcUOkf9bvh7Y1LO+rhXrGCN641E6OOxwfkfbxXpmhAXvf/HKEigmC9nnADwrjiOGRv1U9
	Ou5/+AqYEswFNG8KhH2TXItLpRfAr/cd3Paw209H7DuA==
X-Google-Smtp-Source: AGHT+IHeFK9xuaTmfAiZs8yV8FMrG8vt8WFH3h3BdZLg7KDaHgpp4IHA7JLNZ0OqQcnjPtYDCInWL6b8AG05lroF050=
X-Received: by 2002:a05:6214:19c2:b0:6fa:a0ac:8d44 with SMTP id
 6a1803df08f44-6faa0ac8de6mr37248166d6.0.1748212974002; Sun, 25 May 2025
 15:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525210236.116342-1-rodrigorsdc@gmail.com> <20250525210236.116342-2-rodrigorsdc@gmail.com>
In-Reply-To: <20250525210236.116342-2-rodrigorsdc@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 25 May 2025 18:42:43 -0400
X-Gm-Features: AX0GCFu6drjEs3J6FNPRTEUYs7lVkWa0iO2kpQuggPvg5yR7FVlrR1n9DrVEyuk
Message-ID: <CAPig+cQ07SMbfD8Er1Ukdpih_8AL_exbz7U6WzZ3b2js2ge1cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] t4018: add two userdiff tests for R language
To: Rodrigo Carvalho <rodrigorsdc@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 5:03=E2=80=AFPM Rodrigo Carvalho <rodrigorsdc@gmail=
.com> wrote:
> This patch adds two userdiff tests for R programming language
> files. These files define a simple function, with and without
> indentation.
>
> Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
> ---
> diff --git a/t/t4018/r-indent b/t/t4018/r-indent
> @@ -0,0 +1,6 @@
> +RIGHT <- function(a, b) {
> +    c =3D mean(a, b)
> +    d =3D c + 2
> +    ChangeMe()
> +    return (d)
> +}

Although nontraditional, do we care that some people define functions
using `=3D` rather than `<-`?

    foo =3D function(x) {...}
