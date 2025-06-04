Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EC12557C
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045425; cv=none; b=DZneKkovmKfxQbry1dLWoIB7PA97p+y1ij7Rm+H8EqOPzQFfGSgJUmVxMsUu6vo9rEhTyWrqezYOT/p73179+GO5KlqD6h/NYpOiM+oW4MFpUKn7MTDYOfq480ia0sbujS39AAfs23dSxkJs2OtuVLhSKFDBqO4m1cLBuWZiMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045425; c=relaxed/simple;
	bh=1Bl1DJmxZ2bGvymzAtszpeJT0mFnm4vHcaHOS8GZwCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYbiTOpcNKkkcDfBFR6pKrXLdlhf0VbCith+zoH8/Sc4qtKwGVziVCe10WK0tcF8RNv2n5WtZw6dTYhP1INWLqFw4QH4CmgVKbuBxmfnDlApjSYgH+rhXr17kO3UgqYnYYr9wWDyPKGqIgrOY+bFmuOQZ93mwA2dtUcZ0PgoaL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nutrient.io; spf=pass smtp.mailfrom=pspdfkit.com; dkim=pass (2048-bit key) header.d=nutrient.io header.i=@nutrient.io header.b=Y2WDIs4Y; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nutrient.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pspdfkit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutrient.io header.i=@nutrient.io header.b="Y2WDIs4Y"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acae7e7587dso978072166b.2
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nutrient.io; s=google; t=1749045421; x=1749650221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCljNj5Gqv2s49hX4PwnLmlKzLqd3ghLfIW4a1qpZ6M=;
        b=Y2WDIs4Yq+dpROpI8Ls2YKNR3nups0LoBpY+mjExzuG1MoMk2cxJN89nqZd7EJKw09
         KVSbtUyTukQHD4qDEapg5k43/BydcCyamK2eFinqMx275d4Y9IZe5QKD0+J5Ydj8wW6X
         GQcbiwoSymz+9hHNl4awOGn6nK3UdNN5jBWx0IwhDZpMvAuqudbkw81dBoZLMNT6ol3G
         6lMWHKvC41JlvAkVXZH412z8Ti8GssVjVATNreoBDPYQmUw+5f7j0BIc+kVq+tGdKXTl
         NHw8XnRqDp7mpm8FGfJl+eVwNHLVblzf8et6WGi/OEEwTXN2VT4oEbfHZwGWwcotlGRy
         oS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749045421; x=1749650221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCljNj5Gqv2s49hX4PwnLmlKzLqd3ghLfIW4a1qpZ6M=;
        b=DaIgugtcRn1TYjH5WNgP5l+GwOm6nVcGw7GkNqbQr6mhot6vzVQaWcV7nyvCyql65K
         WEAS70bEyleemntkOHTfOazpTYFK+O4Jp1MhyanMfFd7UKo3pXuxO34Wy7/4YKSo/3Uw
         dLolGEnNf3ICmg8yYtkskmJTkIKATznntoeQ9ocw5kq5D2JV1VtmYQloDvjepuLVU2uF
         3zM7HYcXQcXFu+p+VXAj4BO/2QVTK3qOQMBjUKc2heAx3x1Zb/4nw3FAxV/fkVK0U6Fe
         KDlQGuYwdjw4IbRQWKukS1byDQDFt7iAuvEr1+5AYxOinQ29BidzSlTgfN8O9TLmvBxm
         yk4A==
X-Forwarded-Encrypted: i=1; AJvYcCV1v3Zxm7Qqqnrp7f+UAG1VdGKtWIHV3xuU/JSeWgFZOJaZon8UM/s9ZOkmrJ3FlzNtlos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4hMf6Miqv/0mq5QzcI3L/Wzb9D81ooaV7M1Jhbv7QJpl+UFq
	veUYBzOcSVTjQwy349B4pkNT+8moxf8iagBWCCy+fF55nJcEmrgQW13azDt6lybauX4hW0pxrpc
	QpiWuNOabZ+ZOgp8b9xKK30ymlibMSuisviRmfb+U5g==
X-Gm-Gg: ASbGncum7d75SpyzJbQemyWt6TqtQEm8UbHqC+cFLVTo+xJychc4q5pO284M5qo5Zul
	DD2fXEVJU29kmIWWxAMopqcU264YH6H+da98mhbucWCunFrnyzqJaJarEuA12bVM1oHfc5uPPH1
	wco9Asz70cmJTpBGtiXj89g5rtwH7PBJPwXQ==
X-Google-Smtp-Source: AGHT+IHFNHjJk8CfmmimcjbP9J2sWlBDwsvOTl5Z421x25rS+MmfBfJsQpdmAMJ3NuvBbBnrbNsIxa0kJxB4AYtiiuE=
X-Received: by 2002:a17:907:c13:b0:ad8:9ab7:a270 with SMTP id
 a640c23a62f3a-addf8e986e3mr276587666b.38.1749045421390; Wed, 04 Jun 2025
 06:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1928.git.1748882439.gitgitgadget@gmail.com>
 <fe7e918ba1831fffead46791441da350223998f7.1748882439.git.gitgitgadget@gmail.com>
 <CALnO6CDk4cP1Mef07F6Z8Sm-1MxwWWd-rYEfL-e5_Nnq50B4ng@mail.gmail.com>
In-Reply-To: <CALnO6CDk4cP1Mef07F6Z8Sm-1MxwWWd-rYEfL-e5_Nnq50B4ng@mail.gmail.com>
From: Patrik Weiskircher <patrik.weiskircher@nutrient.io>
Date: Wed, 4 Jun 2025 09:56:50 -0400
X-Gm-Features: AX0GCFujnlAxp85xFthLbqi13ipX7O1C0Umg23i7fdAny0ApJrk_h4EetAQYWAk
Message-ID: <CANMzfzjhe=mxrcxgyXYqOD3GJ0UdX=xsP7oq3H8OGPfuwOphow@mail.gmail.com>
Subject: Re: [PATCH 1/2] contrib/subtree: parse using --stuck-long
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Patrik Weiskircher via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, apenwarr@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 4:42=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com>=
 wrote:
>
> On Mon, Jun 2, 2025 at 12:41=E2=80=AFPM Patrik Weiskircher via GitGitGadg=
et
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Patrik Weiskircher <patrik@pspdfkit.com>
> >
> > -S/--gpg-sign requires an optional parameter. Optional parameter
> > handling only works unambiguous with git rev-parse --parseopt when usin=
g
> > the --stuck-long option.
>
> Here we mention "-S", but that flag isn't implemented yet, right?
>
> Perhaps something like:
>
>     Optional parameter handling only works unambiguous with git rev-parse
>     --parseopt when using the --stuck-long option. To prepare for future =
commits
>     which add flags with optional parameters, parse with --stuck-long.
>

Makes sense! Changing that. What is a good policy to resubmit
something? Should I wait longer? Sorry, very new here!
