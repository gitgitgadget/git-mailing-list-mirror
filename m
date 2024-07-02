Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611F1DA30E
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719959819; cv=none; b=Zbvg9drft7lsl18ztG0m/UQgO4EcQda7z+6rAnuh3ySYFHLpf5pYEUd7/rI8A8cO22rlJdnSquUBUKWu0ickWarJLqoMA4Yp8H6GAy2+V61wcC9WTCR0uYwG/Z8G0yvot2/KsHX5XlXEmJywUox/VsZ5kBCIb2moU3147zPSccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719959819; c=relaxed/simple;
	bh=FaHYatPswwfKTQ8rKH3AdhQFEmYWokG/L5yglR+d3vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3XE9lMxVZmf22mpbqE5h9+LjVHq+q63CZbtLGU+RM2stpnxmWmHd6VLDMBu0yyooYe86HTdeK6vExsBWObQLCF/ufuJmwHY/dm22e4dRQa5fLX+kbl47Ty1bSRTNKJWYTdr0V/Seb+5E6TuLvr+x/3G7RMHcxfjeHAX6Pr/xL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b50aeb2424so21463196d6.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 15:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719959816; x=1720564616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NevpaEsvQyWSMB4Em6HjKlCIjI4caThEavWlSZHGLA=;
        b=r7v/x+F0lrHPIqZDScLu3YSLmPxHsx+FSh4Mj2yhp2iAqBFC7faeDI8ft85CfXO9kI
         HYm6xrbAZLiT1mrrYZySqwur4ooKpPmccvjV2yaa2vfQ3is7sg7E3wHKQVnuFXLFLDkt
         QRpo9YlcjqW1BVSal1IIZjv6PsIARFu8yCWTThVGbgMKIKDtyiM97FhS9f+cvNFesSjY
         nMCZHPoS1Z9rJyuBrDS4ZNDwhgkBgX1MB3ykpt/NgR/B3REwY0kvflAtZRmx373xPoCs
         K24ikLV7aDTovp02eV064KG4wz5i5VOnATYcCUoMvTmimPwYuQKcqxMtEL00xY30B5UA
         VqDQ==
X-Gm-Message-State: AOJu0Yy2NIZvc+johzG6qJIPoipzilXwLmypMGdkj5zaUOwdhjrR7xnM
	GYM/UBxpdm57EHMS2nPdkYs1i1QAaneDYGs0N9OZ2YwerZed1tOVv1tUznTc6hyKJpCRDU38OII
	DzMq+r0cMBz0lYkOxroGMg8OqlBk=
X-Google-Smtp-Source: AGHT+IH45yShuAcOAUBbUvU8CM9wP8J7i+lVOOvaqF69r4/z5DuGMk1zujb1Xhg46jdH98bIELZjVfSMiC0+SpS9io0=
X-Received: by 2002:a05:6214:2265:b0:6b5:dca9:6746 with SMTP id
 6a1803df08f44-6b5dca96a3amr19887106d6.60.1719959816029; Tue, 02 Jul 2024
 15:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net> <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net> <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>
In-Reply-To: <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 2 Jul 2024 18:36:44 -0400
Message-ID: <CAPig+cTExD6_5N63Rs4mqp+DqgLVq+aXM84Kp2T0YicMfGX9Sw@mail.gmail.com>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 5:25=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
> On Mon, Jul 1, 2024 at 8:51=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> >                         my $body =3D substr($$b, $start, pos($$b) - $st=
art);
> > +                       $self->{parser}->{heredoc} .=3D
> > +                               substr($body, 0, length($body) - length=
($&));
> >                         $self->{lineno} +=3D () =3D $body =3D~ /\n/sg;
>
> In my implementation, I use regex to strip off the ending tag before
> storing the heredoc body. When I later looked at your implementation,
> I noticed that you used substr() -- which seems preferable -- but
> discovered that it strips too much in some cases. [...]

Nevermind this part. I just looked again at the misbehaving code
(which I had commented out but not deleted) and noticed that I botched
the implementation in two distinct ways. With those botches removed,
the substr() approach works just fine.
