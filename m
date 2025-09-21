Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886978479
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758471092; cv=none; b=Apvw61cqQmiCJd2O6SJxDDMCHA9oyOA6/A8BOlT6ZIeGPiTLvIjBOijfdABF6jgEZkzPWdsV87G0D8ohZ3IFW4g1llFUw2yia0U4BWN5iqd0KzYPmwBnFxTkB2m4U4+HH0Ox9rtYOhCWlyEPKY36CHoYv6UgJ0P7m4oAo1M0K9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758471092; c=relaxed/simple;
	bh=Z4S+4Yw6f/gOYcyLjl965MzTc+n3Kpw+YNTj/h3L2tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUZlMKv2xgrNiCo/NtJtKZET14bTaQ7EVLvXjytBuoWGonrvEqM5MXKjdiBxAVuqDQ/iFYo+T8z18zefwXZ7/M7SN/dQZGwFWlUJlKzU0vf6Mry8qQI7o2U7BhKMJiRqw/lvGXOJtBJ3De0t9zP9ztMt8CsgZLdW7actIGsQeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bp97f4i7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp97f4i7"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-33730e1cda7so29997651fa.3
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758471088; x=1759075888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4S+4Yw6f/gOYcyLjl965MzTc+n3Kpw+YNTj/h3L2tg=;
        b=bp97f4i7jNHpGfLXpfijxmZVjiXgGWvGhfPBsMOosxcFN8NHaDez+fSX/epsbtu2U4
         ZN6XP5xzh5qdBHvZuX5OOPzJPHeVjfhY6k9Drzig1vxQ+LF/SyTuZRka1M1MVaSwxUz2
         IqMDSWq9EKEeO8/vC7StAmR70kZ38xkhggOi/R05fNKRs4iJCdIuINv/1xjyH10Eedxx
         OOnPzXnVLMuZMp9/Kyy5VhxKovDcugvmj7osrlwOM95a+ZQobJHZM0p2OEAfiVxhX9ex
         4ApltKQCvELokJfigPcDqaNrCHSuuVE46ClfPPW8bH0+d5KUNlbUXp9c0GPfXhQsy6Dz
         xgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758471088; x=1759075888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4S+4Yw6f/gOYcyLjl965MzTc+n3Kpw+YNTj/h3L2tg=;
        b=Pm8Nt6oeWylW/zfWJWHroQ1HPh2wJhCuHQTiQR8vHeMH3clSbHzQ3cyRkmQHn9lwHa
         VjsV5zMh27PD4NJfX15ITJ/CqnhAx27WrPNQiZO3F3LDKnGk1RQ8b92lXOSuMrANy6Ff
         LdL/3PWwQ+vtQKdXxxO3cr8h7oMdgf7MCf6khdYeKEF67jVRMaJla8YjTFqn7k+dAnjk
         FG4v8RnBP/4aPOF7tmr2myrsE3/4xoVzBJA+58wFFhrEKDtLnk4hBKyMQNvIkajRw5wa
         PxkuFofl9Mh2lToOgIYgBIaqBRE/WputBa66Z2hE3/IQnYo9ECzVhrx4xdM/NA3fSocj
         vVGw==
X-Forwarded-Encrypted: i=1; AJvYcCWbpDiQTdcYnZ0162oOZxSq5Ily/HBFx5392msqvTuHcCze4EX5+u3lNSjn5uVlEiW4d6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/HBu5NsHgqSWL/2rDKUArdoz9/vfcT2QT977K6PGtkHdL5Fb8
	eKDflN8EKnNegSfat03zQXb0EGWR1W048kDk15qsL+eHxSpalWwuksEUxa5xRszVsjBzZaGleCn
	iOmyYsZAFe0YZFyVNT4VBQGyFXt7SeWw=
X-Gm-Gg: ASbGncvSoi1WUbsRkdvhHREz8LtQ7hy6F/5lAyXeB3sHywTbIBnftCw1YWxP+1Qrz8h
	hJ2x2TjcMXiXWnjs1aUMDuICkRRXyYnxN9tNE8hLThl2z18/cJ4xfXiqX+9L1OIOTYFQcAAPAQQ
	opVWPXE+3/Y5I7b/NHKitTqs11R9ftioXo1Q+rlW37VT8N/xyoiAzvb/M+YQUoGpI2A+XRt8o9J
	32XYDpc
X-Google-Smtp-Source: AGHT+IFzQgebqedKfgRZIuVEqSDNpZgAwdY6f06zjM1GbGjA3CoPk0odxsgb2cOFJQAJ8ZqI2gX8BtF49yzKCSAQ4Kg=
X-Received: by 2002:a05:651c:4412:20b0:351:786c:e50b with SMTP id
 38308e7fff4ca-36418be5c4fmr36536221fa.25.1758471088315; Sun, 21 Sep 2025
 09:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com> <1e404c3290bd4ba8b4973a597b976c301138cf73.1758294992.git.gitgitgadget@gmail.com>
 <xmqqms6owu7o.fsf@gitster.g> <CAH=ZcbD4oi1hdWDK8s2g6mQGrk+kwWffnSYE5gQZ_d3Z2Z3euA@mail.gmail.com>
 <c8a35919-e1d1-4d85-b7d7-81923667af60@gmail.com>
In-Reply-To: <c8a35919-e1d1-4d85-b7d7-81923667af60@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sun, 21 Sep 2025 10:11:17 -0600
X-Gm-Features: AS18NWDc2lhLl0XgsIfVDmfnxXHE5hBz7E1cQpW4-2G2b4HdZUfR3T4EHqgd3_M
Message-ID: <CAH=ZcbAEho12zWy4fTis0hjUa8+wXm=WwHNG0Dj-Fd0GBvoe7g@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] xdiff: treat xdfile_t.rchg like an enum
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 3:19=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> > What if I move NO, YES, MAYBE into xprepare.c and refactor `char rchg`
> > to `bool changed`?
>
> That would be good as it avoids the possibility of using MAYBE outside
> of xprepare.c

Ok, I'll do that.

> > The problem with bool is that C needs to include
> > stdbool.h to match how Rust defines bool. git-compat-util.h didn't
> > include it, then it did, then it didn't because compat/posix.h
> > included it instead.
>
> 75a044f748f (git-compat-util.h: split out POSIX-emulating bits,
> 2025-02-18) moved '#include <stdbool.h>' from "git-compat-util.h" into
> "compat/posix.h" but also added '#include "compat/posix.h"' to
> "git-compat-util.h" so there should be no problem.

Oh, I missed that when I was reading through git-compat-util.h. I just
searched for `stdbool.h` and saw that it was in compat/posix.h instead
of git-compat-util.h.
