Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678C207A2A
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422620; cv=none; b=D8bfMJEgsi33F6R8hPsAWgOf276hPUcjsNl8Vcn7b8tDdST1rMDZSyiKtzs/m3aZ3mWwIOLnOOgRO1paTQRXDXJk2/aLmfgD4b74nfXXZGzQovc5BGvoVg2+UhWEVUSqcsArqzca8cOaBbKeevY7ZCiJW3YMzmcs5Ghr+EgtcM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422620; c=relaxed/simple;
	bh=N0p450eTl/YbOAydyZRKO4bQLmxlnF1oe8zbZX6xz7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFHT/P9c/pvn/7acg2Ph1Vj1/hf6lSbRs2wfdhQxXRAdY2+johsWzWPNWBKjXFGiVI63nPMLx/ZvxdfHIKubyPiSKOsmNRqL0cI09SquKyzPqkmEMnWQ+ikoPzHIOHYmJUHXTZ9QOKNVRCHFCkZWxVA/UYtSMXew7aRvKJIvPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=felesatra.moe; spf=pass smtp.mailfrom=felesatra.moe; dkim=pass (2048-bit key) header.d=felesatra-moe.20230601.gappssmtp.com header.i=@felesatra-moe.20230601.gappssmtp.com header.b=y9utbjab; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=felesatra.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=felesatra.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=felesatra-moe.20230601.gappssmtp.com header.i=@felesatra-moe.20230601.gappssmtp.com header.b="y9utbjab"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86d5e3ddb66so52107241.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=felesatra-moe.20230601.gappssmtp.com; s=20230601; t=1742422617; x=1743027417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSqg+serqfY64NHkUCKRgPAmGNpi9OKK1W3vgWmMNyU=;
        b=y9utbjabye7Dq6siy0uo3sKdf0QmYBZMCku92HEof1YXr/UluCmuN8NLgZhi4r0WYx
         zEabdF3XoIXvlKGN47yau/49YNSxHuzr/jTeCJCidL5bleiXnwuLIu5Vld+feEEI7vVQ
         XDBSenqIla3RVbydkfdIRg2Y1MGz9abozRVQjk1Nw8chZV00U2pY8Sw/WDkWZcT0vTbz
         Rszs0wNUDZUGi4qSxVKYyNsrMUXAk1TDrzu0Pb5gvIyDZoYYVbueZziOXFO3QbZ0ug37
         CkfeDiZ6+Cwunj8VQU2b5H2Un1QfTU5Go5q6n/iVF+Dsjc4QSjvS1nyWn01ug+jHAcC4
         l7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422617; x=1743027417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSqg+serqfY64NHkUCKRgPAmGNpi9OKK1W3vgWmMNyU=;
        b=vhh/bWsqMBmAeUxj9hZw3AhITcI/Eocu8Q4fyX758xfkR2PCeJQSn0rxsEwtAxMk3y
         ec4DRRWib6XhDQ/5iqFs1mtY41hlelBO+oulfai5w6TwjYmwHtFrhh0lESDnzrBLyXl2
         HOMa4BpQTQtMSUiTDIORWQZzj9txLIb2bDgzreU14Qc/IzP3vCmwVwMhIRanJUf24oUD
         X8pIZDJbOsr7Jl+S+UmSFNhABAF3TLnlSaow1+shU+P7jDaU5yKx2Lx+j6PgwNL2Ugo5
         l5FJ4n14ncyfis2Oz9AvqomkrilK6S4ocU41HLxy9pMwZIkb61MbP64G2k9r1K1cnHjk
         dxmw==
X-Gm-Message-State: AOJu0Yzigw0cDnWx8aXVPj9y+0MF2pITGKTjClw98t5VyMa3WPaPCvnb
	Kq1xHyV3IO3F8A89BsCm7+avn7O4VJDB/oHG3CCW+YVSSNvw86fGy8v14RnTEKV42G/4yFWQY7M
	o9o95c0zY8nK0HnaFaN5V7x/RmH2y78FFsmfVMw==
X-Gm-Gg: ASbGncu5T7e3+uyZjAOaNMCysmpTRx+oTMPTd4/phCHH94YftEMfeG8T+6Lrx7nRzdr
	8OpHOanJzmRjfT2j+dfgcc5J+jCTpVCtqVU3fITQ0Oxr3j4ip7676VyaSKDux3KuPC73ASelJhD
	Cw7QfqgCtdSciMFKcqaKHSTJ9Rww9axiJmBwBTLod15oQSzKYvUm2Vo1k=
X-Google-Smtp-Source: AGHT+IFjnXQpY7yJILJEpDOeBjMB2P9dZsojt+H5oQDEKR+viPrEW/xxAyQXhhVKT7r/hz1VUckATbiM/ZxTyrGrCyk=
X-Received: by 2002:a05:6102:80a4:b0:4c1:7ece:88d9 with SMTP id
 ada2fe7eead31-4c4fce427e4mr956167137.21.1742422616743; Wed, 19 Mar 2025
 15:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADbSrJzNCOP0t=Vsdopa2+GFth_J84E8SEvpRJYfg8uxYnH3ng@mail.gmail.com>
 <Z7xrr-O1QdhXWftj@pks.im>
In-Reply-To: <Z7xrr-O1QdhXWftj@pks.im>
From: Allen Li <darkfeline@felesatra.moe>
Date: Wed, 19 Mar 2025 15:16:45 -0700
X-Gm-Features: AQ5f1JoiglvpAFNk12FMvvCETvrDNloTw3BnjhhBbrFwRXrUGNkW4oLI0rEms9g
Message-ID: <CADbSrJxDP6ZFqE709ZBeg76LUsXkxwWeQBCXRuY9oPO8fiAAMQ@mail.gmail.com>
Subject: Re: Unknown error with concurrent config read/write on Windows
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 4:53=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> I'm not quite sure which version you're referring to here. 28.0 is not a
> version released by either GIt nor Git for Windows. You probably meant
> to refer to v2.48.0?

Yes sorry, I meant v2.48.0

> In any case, it's not entirely surprising that this may still cause
> issues in some code paths. Support for POSIX-style renames requires two
> different bits:
>
>   - The `rename()` implementation needs to know to allow POSIX-style
>     renames even when the target file is currently held open.
>
>   - All code paths that open a file need to be taught to open them with
>     `FILE_SHARE_DELETE`. This flag allows the file to be deleted while
>     the file handle remains open.
>
> The first part has been implemented by the mentioned patch series, and
> some code paths have been adapted to also do the second part. But not
> all code paths do this yet, and those that don't will not be able to use
> atomic renames when the file is open.
>
> One important omission in your context is that fopen(3p) does not yet
> know to set `FILE_SHARE_DELETE`. It uses `_wfopen()` right now, which
> does not set this flag. In the best case we'd convert the code to use
> `_wfsopen()` instead, which allows us to control the sharing mode. But
> unfortunately, it only allows us to control `FILe_SHARE_WRITE` as well
> as `FILE_SHARE_READ`, but not `FILE_SHARE_DELETE`.
>
> So to the best of my knowledge, we'd have to reimplement the function on
> top of `CreateFileW()` so that we can fully control the file sharing
> mode.

Thank you, that makes sense.  We ended up committing to a different
approach which
sidesteps this problem, but I think there's enough context here for
anyone else who
may experience this problem to take a shot at fixing it (perhaps it
will be future me).

> Patrick
