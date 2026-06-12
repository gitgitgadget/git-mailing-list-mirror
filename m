Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306A6377567
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299603; cv=pass; b=uF9T1psCV9GsgcPbkLoOb65Vlfd2n+h0j9LrJ2W6D4hhtkgHlshw3SGUslOPcRtsTO5u11Rx+vfVXJ7rzqKD48AZ2jd4M8wYOEqx5PrgV8xaG1XfiGKRb7IiMBZk5wJ4SQGyDPeDvM9GeG4V2xLFx8J5960H/WYilrfIkMdlHfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299603; c=relaxed/simple;
	bh=LXyFWXjTPpb02G6oOlmnfM2uLWgrrkjE58ZqMxzh0O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwzvQu5rN7ycdUT3h6QgV8/glA1PhZCyykPUn4IrYHsnS2CcUQzLht7rS1U65v1gcEaah/HU9MWrXhjYiehDR2kCATAWHfrm4znJlEEUvxLvasrItsIsNGrPLax8VMerH90exdaUYsXYZxwmNXnepm71CCwz2+1KqfHZROCWLY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r98S0wMv; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r98S0wMv"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa7a7ad475so1625178e87.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781299600; cv=none;
        d=google.com; s=arc-20240605;
        b=AM97EG57roiOq5WbFRpXwNXHArm8/3ZWwEng7wgryQwtQ9aUfKWtP21VWMmNjBFHS4
         0fvCGg0GzCfiEcwXGekTyptPuEa32+JgHs1IdVTxf5dw+85WpQ5u1DQJgoe6KdI4l0dI
         GG5+AAwMMs4bxA8iSAb2FOH8XdAPj2lgUg8f2D/xhCOzh/zUG142txgvWVzVMyVe2j16
         nHCHU8vN2AH2TCiaywznbEFrJanLedMCE2UJUhmmLpkdNP1k0pK5BObotxUDT8T62D7j
         4riP64C+by0IsQTt8/4yThWGXwumWz/xXEeABxUVyXzIUSBSFT9EiRY+zA9i5hPbFufh
         3p7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RnZRkpNvL6ok8vImUx7cazn5KnbipnFp4X+0WwDFEQU=;
        fh=LZEgid/AfemsFiZwffY7wXuKEMSws2L/WldwtnvdoFM=;
        b=WtzimcMUIUG3al09Lcwr8kBGRIYDA0mWBKxZE6FV8E2vr0Lo+IQax2YA29lCMybgEM
         r1nxJlzU1upSFYWGPSmW4c8wzPvjC7GdAR8sQdPYrm0J1bPl/2VhImCjeoWO1Ioo6cTz
         407FIBUBxTu4BCcWF2q5jP4DKeHJmSeJ70Gg/2cknUWeGTrQUfsn+znRCP7m7Mz97IKd
         0JI2nxIS55Q7FRAF2ercjG0pZgD67blaSlnvoo155rwiA4aHVh3M9LHPKtJbI/famtAT
         iZDAbKoOD8ADQ8jDBcySJPtUyjNgh6SsE5VkqAWgl9x86SOg2TebVSjzpNa7j2eYLlT1
         BTlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781299600; x=1781904400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnZRkpNvL6ok8vImUx7cazn5KnbipnFp4X+0WwDFEQU=;
        b=r98S0wMvz4Eu7FOK8FLZHrvN42j0N4cz/rmTs4P0r497NS50x2LnpNgbwj6ejoMW7T
         rkk70ZJrQ4h38BEQhKpBwLf7JbgU7sq8tzVbZ0pqAE2+uScgAf9YmqKkdJvCPir8999i
         ZZXDv0fCDJ5zBeQcv4kxOQgVjENLnyvKvRoa/sgB4oiY35ozVWjO8FhdOcA+XkKi8eK7
         wqkiOJwXyeIkdmaXVtQ5+a4UWzkOrz1jHpJH+qPNJ3LLNzmgxQKNRe/aS8KX1XmqFlHL
         +giJw/ujfwCF2L9CI9Z1Tm8bGCp8zQJSOORW1EODcP5ewV5QFtxcCPSaSO4epNjhEalU
         hLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781299600; x=1781904400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnZRkpNvL6ok8vImUx7cazn5KnbipnFp4X+0WwDFEQU=;
        b=sZP0iw6OtmlWWKi0LKK+bdlgcYXd01mNXxi+p8vBwrwH3EjdKSBJg3tghHkVPvKRxY
         9t360kAFrn6pz98FVZBF426WeYGMWufV2c75s86/FW1Gao1Xg8Sx+YXjxGsj6uaCT72c
         P8IhL7M21Jp45Ay3eWOEwAyduaGE8/YjULFOfRC0vv/J3IUgAdsUK6GIkIaPIJP/Ra89
         tYzg3HA/lQwTMhqKf3Rd9/6PBwgihk63EgzERrRFhcT+vOQKU0GOYi9XoWQI2AFDRdTc
         0vNrCh2GNtY1V/zfgzkwr8X23LUGseim8bXC93fR48zN1N1WW+HOoGxJ3qimCkXRuCNJ
         dzGw==
X-Gm-Message-State: AOJu0YxkqEohcWiwl19wUV+w2MGNg5NR2QurROkgMUAvk31FGn0wjOF8
	XuF83BtjQhRuziIX0fqxSM43zVmgL7ytVXuiW9CkkvWoq7dn/ZL9fEfTlcfjqaqpP0Ru/g6TjID
	d2Uci8KmD5A0jCoOUwxF7RJjEWK/ycQc=
X-Gm-Gg: Acq92OGwcR/EQX32g54QYycKP6xrhKXx2JbMggMbHzkmJnn3pUiFmTMvxgkySp3kXUJ
	8ZNv2zR3f/e8xqYVsZsQ42xE9JakFXBzRQs6Fb5SuXj4TwotJfG5YSF4MjxSSZQMYSi+95aG1Z1
	QLxzQ6CEsP0jOSA7ReMx+ptxZ9dUX/qr0sqr9mDPoju6C+Z6huOsus36C0O1KKQibZxuKmCjUzj
	Ela2wcBVEbIWcDiHeAwiSnHfCWm7zVKx7zZN/Et0KmbdgfyRtsl/9T9/5nuia3EN8pfbaD3KZJh
	p8jyIw+PDblaqNxd0611+jleh/2eaX4zxaW2dTEH+SRJvh9AU6VRWkXPj0/2KtPa3eOWhTLwnAb
	FsigdasgMpIwxcADx5ug6owgHLYw/OhG+TKtg2S8NBtGDXec1gBYF
X-Received: by 2002:a05:6512:6416:b0:5aa:6232:5766 with SMTP id
 2adb3069b0e04-5ad2daade2fmr1060514e87.0.1781299600171; Fri, 12 Jun 2026
 14:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
 <20260611-ref-filter-memoized-contains-v3-1-b26af3dba285@gmail.com> <CAL71e4PRqN9iPCzvgwC1Vtj-kzn4Udv+v1LTFSUXtGnC5KGrpA@mail.gmail.com>
In-Reply-To: <CAL71e4PRqN9iPCzvgwC1Vtj-kzn4Udv+v1LTFSUXtGnC5KGrpA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 12 Jun 2026 14:26:04 -0700
X-Gm-Features: AVVi8Cc6RU_IFZOj-dGz31XL8vHXbFZ2ho0FfI7x3HvYRtUljX3I7gZ-fJnqsyQ
Message-ID: <CAJ-ks9n4461G-Me+1rf0ZgrC15ZW+1b1xcip=11e8=S=OjOuiQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] commit-reach: handle cycles in contains walk
To: Kristofer Karlsson <krka@spotify.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 2:53=E2=80=AFAM Kristofer Karlsson <krka@spotify.co=
m> wrote:
>
> On Fri, 12 Jun 2026 at 05:00, Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > The memoized contains traversal used by git tag assumes that commit
> > ancestry is acyclic. Replacement refs can violate that assumption,
> > causing it to keep pushing an already active commit until memory is
> > exhausted.
> >
>
> The cycle detection itself makes sense, but would it be simpler to
> just die() when a cycle is found rather than falling back to a
> second reachability walk?
>
> A cycle in the commit graph means replacement refs are
> misconfigured.  The existing code already loops forever when it
> hits one, so detecting and dying is strictly an improvement.  The
> fallback adds a second codepath through the function, discards all
> cached results (so later candidates redo work), and papers over
> what is really a broken invariant.
>
> do_lookup_replace_object() already dies when replacement refs
> chain deeper than MAXREPLACEDEPTH (which covers cycles), so the
> existing contract treats this as a fatal configuration error.
> parse_commit_or_die() sets the same precedent within the walk
> itself.

Yes. The test creates an ancestry cycle through replacement commit
parents, so MAXREPLACEDEPTH does not catch this particular cycle. But I
agree with the design conclusion: the history is malformed and the
fallback only adds complexity.

Done in v4.

Thanks!
