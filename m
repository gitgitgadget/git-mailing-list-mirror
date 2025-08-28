Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D95270EBC
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409967; cv=none; b=TybTDGBS8A2ZAw3IbDRU1dC92B6tZHxWWokt7ev0f18Ro3I+eZCAGcylkD2E1zg1lQmQlSjduwwBs7uskXEetx6/royirDV4KZxpOTb+fJ4yQRNO4uWQdfmKU0TMRzOjk5r9yEJV6pv7bQTJdhcT6jHN6i0aSzjxKxrz5vrlITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409967; c=relaxed/simple;
	bh=z/d/dS5JI/OlIHcZxqCppuMDe5NfqhPMsFD8LFN7J9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guehGom1kThjjIVb5+jidnM1ACEmOj5cBbNqgasR3l0PMrO/VaGqzmGL7QfUL3kcXbUAvu2pZreh4jOkMi+qHq6kBdk/S8YsYkWl2nLvdIUPT3cxo7yaSxzdkNpxhLJWCRE9WTP4QYXGtGDnY2337y9tO9grLFiLJyEdIz9wvxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8I7YhAl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8I7YhAl"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so1642902a12.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 12:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756409964; x=1757014764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/d/dS5JI/OlIHcZxqCppuMDe5NfqhPMsFD8LFN7J9o=;
        b=X8I7YhAlwIA+4CcgPUhDsMKDYYCGJoAg6uIGv3wO6MkffVqdOZ+zHbJIkwpQIdfDd6
         +gk3dvOD2sGSSurI9xim/FHnTUZhiAlBF9Ly/HCrxiIFieKGDtkjEA3krug/LL3Zxs/p
         eGMQndlBShTnLxoUW0siUEb83uxzCHGZd0G3LP4m+W+7oJViY2yLn7khJbCdNCbeHY1E
         t50ljXhb11TE6zh6X3ZyaVue9ZYgQelk5xyi6905K9OO/agJHs17vQyfQTJe5sR5uyGV
         IISS3TshO4Nb1873jpNQEE460aZN0x/SSygIjtDSLAkuzkyFw+4+y3OwgO6uulOBu0/W
         TOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756409964; x=1757014764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/d/dS5JI/OlIHcZxqCppuMDe5NfqhPMsFD8LFN7J9o=;
        b=r71GXEkb319LxtqQ4ySOcoahyw4UFSyGKVlsaYEdkVsNZMaX1Z89zVa+BD1j8R7UKQ
         S4uDNIVyEZ+MV3CtNlEHsL7MkHCuOSSM5bpLV6KXsphaFohVAnoCzYWAzf+58aUH1h0t
         HVfdDWtIl5WfIgXkqpwN2gouc/Ell38puVVHG8F1LQsxV+6HCzo7U7EavT9PcLKKJR+G
         LKXx9QSIEoROr43GqOOVvZyivzKba/zBYxj2ywqUeMkjRB/ecbPlm52+ZC6id9DvdWEK
         M673p/iPvgEwuWYuJpqyp9oNUF3ZRAiikp0er7vgUAtOpmVzGZXIt+CLV28wZ/t6VPzi
         WuWA==
X-Forwarded-Encrypted: i=1; AJvYcCX7hQIttdO+ryXnRVvoaihd+NEzjKT4QoRl/2347gMACe3pz36OHnkXVsQufRb15wRSTi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUXeX4SyfcqZaspwjSfRCx2e1ceiFF/wHJnst47bHF/e24yN8D
	R0NvSQ6Y0cl1zQPtfc+tuTxItoHwujSYYm4Y7/shZBgfJOR8AyCNVeG9eBHQ5QLe6Rd8OjAU4eT
	ldzM0rViirXBlgKtKGArFi7+cDN0HX4wN/OxD
X-Gm-Gg: ASbGncsxTs7wpdsEHxh7439OGaWPp9PoRl2jpT6ozV4xeWc2IphJsNFnNKTaD3nlV9a
	Y+EwCXO0OIQQtQMyA0MwYu0IPdq+K5YAVqb9zr6QSn8fMy79m6PGLQd7Yd9Tu5gzSXSbKVrvOah
	VUsuGwGogJIlmMqcTWT51oF+04z6ZTWMxp33nEgt/Hl1rhF52R80aVPbndFN5ucY5UMoz1R8x5A
	4BxndjuLH/EzntJWqIg/C6/PKm2HmCddKbg3GdYVkz9zTtoQOmV
X-Google-Smtp-Source: AGHT+IFS25j8dV4O/zfQNEqa1qfg29L27h+fKaAne/6S4W8OeSH5vZCDmcGVL3HtVC/soCEHd7gse1igK0sRXQzT90I=
X-Received: by 2002:a05:6402:5107:b0:61c:9970:a870 with SMTP id
 4fb4d7f45d1cf-61c9970ad55mr7387670a12.37.1756409963835; Thu, 28 Aug 2025
 12:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
 <2fa98fb5cae78b8872d0b864ee246ba619ef631b.1756240823.git.gitgitgadget@gmail.com>
 <CALnO6CCca2Yp7K16ShqUaZNN_POv106qyXfKq1aJMyXhA+EyCw@mail.gmail.com> <4d9caee9-973a-4d41-b6cf-d399a238942b@app.fastmail.com>
In-Reply-To: <4d9caee9-973a-4d41-b6cf-d399a238942b@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 28 Aug 2025 15:39:12 -0400
X-Gm-Features: Ac12FXz-bybRtInN_z8dKadwNErIYxwUrXEGrL0_nd9KDARBweOgHxhdXNbSvAo
Message-ID: <CALnO6CC4e_CY+D7_d151dyZQS5t6ukEgkyMH=qy39ZPttSPOvA@mail.gmail.com>
Subject: Re: [PATCH 1/4] doc: git-push: update intro
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+cc Junio due to his reply to my reply

On Thu, Aug 28, 2025 at 1:48=E2=80=AFPM Julia Evans <julia@jvns.ca> wrote:
>
> > Considering the glossary entry[1] is for "ref", not "reference", what a=
bout
> >
> > (a) linking to the glossary (is this possible?), and/or
>
> I like this idea. Over on the HTML docs side
> (https://github.com/git/git-scm.com/pull/2040)
> I've been working on a way to show an interactive tooltip from the glossa=
ry when
> people hover over "jargon" terms. The goal there is to make the glossary =
a lot
> more discoverable.
>
> Right now it only works for terms inside angle brackets (like `<ref>`), b=
ut
> I've been thinking of adding a `linkgitglossary:` AsciiDoc macro or somet=
hing
> (similar to `linkgit:`) to link terms to specific glossary entries. It's =
hard
> to tell what that should do in the terminal version of the man pages
> (maybe nothing!), but it could make the HTML versions a lot easier to use=
.

I think we could so similar to existing "linkgit:" and expand to
"gitglossary(7)" (or "git help glossary")

--=20
D. Ben Knoble
