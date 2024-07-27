Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE118410B
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722096317; cv=none; b=HFQ9umV1uPlhNluVDjkpxp7CLvzNwPx+XvwnRdWkm68dvsmsdvg4CljFL3ozKLNGD7y7fTMM/8GHgXnptnYy+dR2fn1q8s6UsDKM+C0Gq0Qxjt/JkoecyLPCIwBJwf9DNDZfv9jXKiTgXBeJhemQ+CxPsjH+CbgRxHzQxc4jukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722096317; c=relaxed/simple;
	bh=qmEM+oFHniA+/1IpfHBGTmku9vDiKRf+GsUVm/n0GP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyaLJTVXOllr7HNIzTJqWLBsuTB1WhkFr2KbZw2LCxuhiANsv7cXautk8GYAZio0QhwS2REMmd4gJcqotIlIHdhp/TIQ6U6IeS+9gHcTmaCptwNaZgktOC/ICY9fH+dFanAmgPd3Dz6eD+ZhSuLIOwnt8qCqV2JOUBpwK0a20iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so14061746d6.1
        for <git@vger.kernel.org>; Sat, 27 Jul 2024 09:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722096314; x=1722701114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuqdHfu7aqOwg8JR8W8GjGAbGOgP47oh7FZDbvF9Lj0=;
        b=qCGutsiT/PMoO1yENGtejzzJiBzoX8wyx38iEraFfAhcOYdm3ZJISffhEsDKFRvMhW
         6QVCNbi7sTNUJ/CgYG73P/hx7SMiLLbvA4c2997CBmge0smZ+oA41ttg6JW1968wOzkR
         utxfdIaAz0BgtLhwPq93MfbyNKTDGazJkwr7GHXr9B/Ixt3jRfYjNiE0wWc8oQRZHUMG
         Xzw50AAVpffNj1CirRgSJqjWclaRUYMeOhvLltPz671GeWkzMN2WXyOoZDBAygFbKenp
         owVao58hje3Q/LfjlGz9E9tU8oJedhtj5Jr1YYOdeWX7M+0RdYnz6uiqT5fb5imcIKde
         fEZA==
X-Forwarded-Encrypted: i=1; AJvYcCU5w9ySHjgibUG/HeB0Ss40sAi71MFJ12PiJtZ7CTmn3XR1XX7T6blNOv4ovp1DcqmkbW180N/zuf5QwbJJ1glWsRjp
X-Gm-Message-State: AOJu0YyMYFM0feRQGln11511KfzJyHOGWlMcNYI3l8DnKDEGTDxQt0ZZ
	FDfw67ep+zSwCVqFDs6OdagtW5MD/CftweKZMN/VsQsIuaCszb0jWy1Fe/+V8BiCMs1jUxBCLxx
	9xL16z2U3KIJA4/I/sAo/fHJR3J5BrQ==
X-Google-Smtp-Source: AGHT+IGqsEymfwi5a2KScwB03EcaB96bHDqsCKQgbuXZT1T6L36f8Mg0ApRb93Rzxwvskgv6GaA679JKmweUFj7b0hQ=
X-Received: by 2002:ad4:5aeb:0:b0:6b2:dde3:f945 with SMTP id
 6a1803df08f44-6bb563899a3mr53071266d6.26.1722096314418; Sat, 27 Jul 2024
 09:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD+08a87xxVRxO1eiWiam-7xvq=AyKUB-MzqG-r=rM_SYbquBQ@mail.gmail.com>
 <ZqUF0ANz9qX-wWEN@tapette.crustytoothpaste.net> <xmqqttgasufx.fsf@gitster.g>
In-Reply-To: <xmqqttgasufx.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 27 Jul 2024 12:05:00 -0400
Message-ID: <CAPig+cSRuEtd0OX+RmepdHzC33SLvmzmkQTmpbqr4_rpUzXUAA@mail.gmail.com>
Subject: Re: Bug with bash and OpenSSL usage on Windows
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 11:53=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> I've been wondering if we can somehow reduce the occurrence of such
> an issue in the first place.  Elaborating a bit more in the
> "Reporting bugs" section of the documentation landing page is
> probably the 0-th step, and if people agree that it is going in the
> right direction, perhaps we would extend it to include something
> similar to the top of the "git bugreport" template, by futzing with
> the implementation of builtin/bugreport.c:get_bug_template(), and we
> can even encourage customizing it by distribution.
>
> Comments?
>
> + Git for Windoes: https://github.com/git-for-windows/git
> + Ubuntu: https://help.ubuntu.com/stable/ubuntu-help/report-ubuntu-bug.ht=
ml.en
> + Debian: https://www.debian.org/Bugs/Reporting

In case this ever gets turned into a real patch...

 s/Windoes/Windows/
