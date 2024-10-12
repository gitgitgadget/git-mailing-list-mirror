Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7684D0F
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728715406; cv=none; b=GbtIkPYGrdXEPu0Oma89mBaLXmlPEIYNwvxn5eUJ1ZZD1Y9dSlE6hvDivcKsWHCImOEgXVNA0hKH6acP5pHvX7byET0ov10dNyYPJ9cmYhpAPg5bbHZ9kqdqDBVeYnbzAbq6DD9ew251RPqerkknHRMZVMwtJc1Bh21tK4y+w9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728715406; c=relaxed/simple;
	bh=OJOe9QsXLtntYaucXM9EGQdOj/Z3Oal3v8q0zsIQxPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iE9WUPx3uAEJ5HcAL7o68j2EU9jjjZJ4wohCun1P2s/DwWi9rkRMhOlXKysAxIzETF7xvbYuGAN/DPeK/B+vdwRPv7PPp2UFZUzV13IWd/5cSpzJFgH91cIuOAJN2eKKsJBpaevSh0kAYB6mo2UWxEFK1kGJtJS9p5V59PQgDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbf3f7272eso2356996d6.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 23:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728715403; x=1729320203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GM4r1L6eCMrWqDVn2w5zYDN1CLM2olIBJlJVjpYppro=;
        b=wcmpw2N1Hw+9bp06SFPdh/TVkVdcCIyh+sYvt1c8WWiCOxzvZoOM6Jfj+1RR1Dt+PZ
         XWO3LX6lg+kR/ir/+6EnRjH7/aUK+6e/kXKMelpwnSrws+gKqg/hndVVKOdPd6wZEVIi
         53Ae3RMDaXGPS7i38knS+D3J8/rvVjOaPDb4nhkAfqp/6Flo1mjRugyWTQ6osOLP92Ir
         w1zkBaJYAsRypSBIIH04pQoeJGjl7khOmtUyL9isKmnVLNTAz4FKlYGo0x+T0Mo8ud7y
         gR/69xGoXmnkNDPWde8TVv6O3wcSoFUAPMwhx9HN3DNjzDOXB37bWlglTJp5az9xLtFw
         qUyw==
X-Gm-Message-State: AOJu0Yww8UoqFqtXmbLysWCwOlC0v4/IgwqP9WYcqrdMTRUE+rroDuTY
	9mUv4jhywW46o+R6xMecqMvB3onJp5LE4gKki2OVH8cjAMefqMkZ6MHnFZ7LTIsh+bf7+m4osTJ
	6cmgvN8M+bQio8i+1i4HdFEyngLU=
X-Google-Smtp-Source: AGHT+IEbDUpP1Dd4liixDfDMTvj75pzxIOLaDhA3fH9gp4AwXFJLqcXa/qtuYLGezAbQzVGKH/2p72iwQ8Vb3waRDCo=
X-Received: by 2002:ad4:5966:0:b0:6cb:e610:f8 with SMTP id 6a1803df08f44-6cbf00445fdmr29134916d6.12.1728715403107;
 Fri, 11 Oct 2024 23:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com> <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
 <CAPig+cR4WbcDDav0cdXxOMC-EDe2ipWxEzB+0C7zbFjvY_kXtg@mail.gmail.com>
In-Reply-To: <CAPig+cR4WbcDDav0cdXxOMC-EDe2ipWxEzB+0C7zbFjvY_kXtg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 12 Oct 2024 02:43:12 -0400
Message-ID: <CAPig+cQZkBVEHmUqzmouM4A=pgpXhTPNc8cBg0rDdTN=v=hW=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs automatically
To: Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>, 
	Abhijeetsingh Meena <abhijeet040403@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 2:07=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> On Sat, Oct 12, 2024 at 12:38=E2=80=AFAM Abhijeetsingh Meena via GitGitGa=
dget
> <gitgitgadget@gmail.com> wrote:
> > +       /*
> > +       * By default, add .git-blame-ignore-revs to the list of files
> > +       * containing revisions to ignore if it exists.
> > +       */
> > +       if (access(".git-blame-ignore-revs", F_OK) =3D=3D 0) {
> > +               string_list_append(&ignore_revs_file_list, ".git-blame-=
ignore-revs");
> > +       }
>
> A couple style nits and a couple questions...

One other observation: The comment above this code block doesn't say
anything that isn't already stated just as clearly by the code itself.
Hence, the comment adds no value, thus should be dropped.
