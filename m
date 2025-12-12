Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560AF2264C7
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765571564; cv=none; b=JUMKt0TpWnO/GgnKXf+skosO95IXJPOf6hp8IcX5ZMp1P+YgScKfBLuqW6zMGLkCFrn1dVfUPspm+o6H+B1gCLyxdxExs1Jmd9p4REXdrdOHMqczgUhHn81i0lP0uX6S/8ZsNo7LBUYJZWeLpxjJO44SCico7utCpCRD24hXpZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765571564; c=relaxed/simple;
	bh=16ED3zcuIiE7JsdkBbsA7FzpFqEOCkDSyvGJsiAmRMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/xpFhr/PBBiLUXcLdz7XpPr24RX9RCHelLKB4/ejDgRvYV6yMc6prbQhZvb6+3xmOOp4CjuuDC/Ku4F2Wqj0YEqHgbKj1pYicikqw9zGHQG9eqTfe1VBojDDKlmc8/k7lx3jgc64GNoTwMmaGYlfAUQdasR2SjfNOI6wtRVTzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8886fed78afso780106d6.3
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 12:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765571561; x=1766176361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TtIAIEz16qmLZ5y3U9CH/7XeGHvzPCl7x8qDEUiXBis=;
        b=o/jjQ/LJkKtaMHccZQT77x7liPzn1g1lUPhu9n+yplROHtSn1TkU9K8SwBcoN7Bzr6
         xD3E8Ec5JdMh6ZYiKOveSA/VBAlMbdqvXt+Crf64YRxA+5XiXQYBI3GncRLfRiNXpwoW
         BdJ0nTgIb/3n5FWH4VMWyrQAwwfJvzMzXoC56OGhbXehIFgiLpwIU0ZNkPX7rIOLQI7k
         pPrMgniDiHwc/UGH/+xC37kEFnz4vegKIEw/QTDity/HVBo8zzhqpvIZaJd40VJzXeU7
         hRP6BNzEr+u1SMbO4rHvBxIi4Ex1nTZOLKcmxmmwgNWFSNQJC1qIDrVicwXQkbzvqLpb
         fx1A==
X-Gm-Message-State: AOJu0Yzd4bgCF1gTtbIQIGPlnonJLx3x8qDzH6wsfVfgMv1ZNa6QiFeO
	0KXjPWveEUCncE761w7RUl5G+V0BAnwWGR2ttQMoDjBtg/GjJ2BJFCxopdDoDgaEF3nqHG9J5EG
	/+DIp5lDL3uHhlB6U/6QCtWP4HuvAAds=
X-Gm-Gg: AY/fxX6NJIy1fXl0hhS8AUyB6JiLcNMrdPPWFbHdVx0d//z/fJzzYS7OxSQh1F38gjN
	Tb5jJd7h3PvhOUbzytUl2Z0d26ARAy2BzoqnlVcflROzBsz5vSOWJ2UKt3yvg1zfBrojoEDG33x
	1S7DSy8gRZhZt656ihkIScwBdGLq+sEjnjjKIZSLQaVo2IkiqFeWXR9byty4pz9m33oMSGoXhIX
	5U2Co2FyzPG8jb1Mk7mahxqGExbqyI5EuubRcLoWLt5GP3iQIiJH6UnodbpXVtg8saJt+w=
X-Google-Smtp-Source: AGHT+IEznrifS6yS6mtW5zpEI8rFNEznnkskQVuu1+ftxoT06ysL02ghf2mD0j0GzjXBeEQg7zEBD9ypzm3q3Rn5m7E=
X-Received: by 2002:a05:6214:40b:b0:888:6dc8:5f96 with SMTP id
 6a1803df08f44-8887e7f69c2mr40512636d6.7.1765571561305; Fri, 12 Dec 2025
 12:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CCu7A7mkLy==K9a-u-z0kYBKLiyBz+Qq8c7PWLHO-YuNw@mail.gmail.com>
In-Reply-To: <CALnO6CCu7A7mkLy==K9a-u-z0kYBKLiyBz+Qq8c7PWLHO-YuNw@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 12 Dec 2025 15:32:30 -0500
X-Gm-Features: AQt7F2qYZNy8kx15n1Ggt_Hq0x2CguJVEuK8_AQMyWszZIkshyLibz58PhmZewk
Message-ID: <CAPig+cSctvQoCNvQqrsLjzLQBc7H9u2hpxeBHE19_AQsup+kFQ@mail.gmail.com>
Subject: Re: meson -Drust=enabled fails on macOS without GNU sed
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Git <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>, 
	Ezekiel Newren <ezekielnewren@gmail.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 3:01=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
> I think it's due to e509b5b8be (rust: support for Windows, 2025-10-15)
> [relevant folks CC'd], where we assume sed can take "-s" (which AFAICT
> is a GNU extension). But perhaps "-n" was intended with a "p" flag on
> the substitution?
>
> I've been building with Rust enabled on Gentoo now for a minute and
> haven't hit any issues, but that's perhaps because the command is
> running with "-s" and not working as intended (yet still producing the
> expected results).
>
> The relevant snippet is this (reformatted slightly by GMail, apologies):
>
> case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
>   *-windows-*) LIBNAME=3Dgitcore.lib;;
>   *) LIBNAME=3Dlibgitcore.a;;
> esac
>
> but "cargo -vV" produces something like
>
> cargo 1.89.0 (c24e10642 2025-06-23)
> [...]
> host: x86_64-apple-darwin
>
> (on my older system, on which I haven't tried the build; the failure
> is on my newer system with close-enough-to-the-same output). I'm sure
> you can see why I don't understand why we need GNU's "-s" ("consider
> files as separate rather than as a single, continuous long stream")
> here?

Yup, that's a strange one. Indeed:

    sed -n 's/^host: \(.*\)$/\1/p'

would be the correct way to do it, while also being compatible with
BSD-lineage `sed` (such as `sed` on macOS).
