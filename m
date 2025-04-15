Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DEB2DFA29
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685886; cv=none; b=KwD926FHgggzj+uTvLT3QZ5UmFDTPoebRim7vdqnZBYpF7FdYfXwQshMJPMuAPiki9/x6juFkcOkGccHOV6bE8HOJqI4g3VCBVIP8Y2aK758juL0M0CX48c4AMypGXSEeNff5zNcMwTqPbTNdepM3D/buxcM3NB1l7Ona9Q1HNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685886; c=relaxed/simple;
	bh=EVg1S8MlZSr8G8jZlbi8QIft8hNFhyCmAW6lGLZwxn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZSpjE5l3fwCGkLiaFmb1dyodX1k756NvHnppok5/oqy1i3/w6XSEjNx1UukurrOW9plsnqe+n/SftBstvuYW4ppGffE3BBDfVuSocpfvp2c/IXIzouxSjtuS36hUndKZtkrho7LaYH4YbIPcpnp6XSEuuh7ICkr2Q6XULuzVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoUha3AR; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoUha3AR"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d45875d440so21943605ab.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 19:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744685883; x=1745290683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWkV97Ckdt3a4q0O7mTLZ8QEUo3VAZ8paAPUldtfSzA=;
        b=EoUha3ARd5BGGLuQRPiSBeeF3i3vdDY8blDsUcB8Vy5OVFP1oc7aKLk2yNkG4dClVM
         a5mI0ApbyxksAWyhYVkLQO4jXf1rc7eiov1WRHyPLziWG6HTaHXjGrB/yVXp7sUAoufT
         suNi/jcfkY2KI70pDzRuk/3hM+x3agzPGo7F/fnN0gw8A00bKWQ5pv1NrlZHTRje0XDp
         ULwg7uC0Bz6pd5x9Khs1rQDsjiY+3KW3tExKU85gy016bNRsghNjPumnbjKRTu7zWtxo
         4DTOOUi2DtAdT9V8g9r56b+ql2Ej3op7/Exl2axwAN4mo0H7qdwKam5YovgkQG9CjRDr
         P0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685883; x=1745290683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWkV97Ckdt3a4q0O7mTLZ8QEUo3VAZ8paAPUldtfSzA=;
        b=GvGyFLVw4X9n6rD+9wfbOrcpLtMk5R9Qomo0AAPRoBacUSWaYptB2vekbNc6SHFrrx
         xQ3gVbCTeLGw51wOe3rF91RTY5juCxCre4QcVzs5GymG+QHGyRvjxG3RYwnaw/X2u6mG
         cIpA56aMlMEa+e+1R6axm3coMqUvuR7q7qqw8N4fEWiQJ5DkjIACRnykYuCJfKKTe34s
         qkbO0ECv8Om/ozzVFyRkaNkDZX9KMgfiK7lsrp0o1+ziwm8hd4j8uMOmKSy/nXkSCk9S
         hY8KHCYTvs0tzxcTU4M0Eng+TYdpr8+VRG3XbdFvOMV9n9LHbeWGV4tb1LtZg/GZlBHX
         OCOA==
X-Gm-Message-State: AOJu0YwqCnweF2Bhpz7Gyo0i1ur/3108ZzI9tlDX2ppAZpNcfTglUKjp
	smGg6sRnDBprz2dHZbrRuCZOyAGW/lsXx2AwzaGHFSf3zzUuBJerkcesFCDH5nTiiI2R/EfE6rr
	g9IHxfmMBtJsgMP5Pxbie2tWtmBk=
X-Gm-Gg: ASbGncvVfjcVEikzIhS7120vPtPIODIZO7tytofbpcV0Qlk+27AtRIuCLL2av8nQgeB
	koStpUNjhOiSLBWCvVv21Avlj+oewS2jPFvofPMkHwicOUw1lWb9YViyYt4RiN+eFALys2ksWOf
	WcRpGKDkFywAG5yRGulMn09dxvczOMHkcX3WL2o2hok/A/bx3bY3lr7vQ=
X-Google-Smtp-Source: AGHT+IHnA3uNSof8cBuA5M9CDqNsPsxUAnmEOEZRypz7scjKOs2hgAJ3ztzLlDjMHu5CQ/y30DI2HExo7LDwmuQzCQE=
X-Received: by 2002:a05:6e02:1d9d:b0:3d3:e11a:3a8 with SMTP id
 e9e14a558f8ab-3d7ec276573mr116759435ab.14.1744685883569; Mon, 14 Apr 2025
 19:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744413969.git.me@ttaylorr.com> <cover.1744661167.git.me@ttaylorr.com>
In-Reply-To: <cover.1744661167.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 14 Apr 2025 19:57:52 -0700
X-Gm-Features: ATxdqUEp273RWQPb_Cquv_MgxO0XTDXBMuP5sSNyme3ZXYJLzxrNC_-JgwPcnbg
Message-ID: <CABPp-BH7U4Vh8b6L9_FNUsBqKB+4hNT_Twn4S7LTocLvbw1LjA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] repack: avoid MIDX'ing cruft pack(s) where possible
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:06=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Here is a non-RFC version of my series to explore creating MIDXs while
> repacking that don't include the cruft pack.
>
> The core idea behind this approach is to ensure that packs generated via
> geometric repacking traverse through objects that appear in packs which
> are neither included nor excluded.

This phrasing feels confusing -- what does it mean for packs to be
neither included nor excluded?  Maybe:

"The core idea behind this approach is to allow some (most) of the
objects in a pack to be excluded, while still including some subset of
objects from that pack as part of the repack.  In particular, we
include the objects in that pack which are reachable from the other
objects we repack.  This is different from our current handling which
either entirely includes or entirely excludes all objects from a given
pack."

> Then if some commit (for example) in
> a pack reaches some once-unreachable object stored in a cruft pack, the
> pack generated via geometric repacking will pick up and write a copy of
> that object during its traversal.
>
> If you repack consistently using this strategy, you can guarantee that
> the union of geometrically-repacked packs are closed under reachability
> without having to keep track of any cruft pack(s) in the MIDX.

Also, if you do a single non-geometric repack with this strategy, you
are also closed under reachability, right?  Is that the suggested
transition plan for those that want to use this...first do a
non-geometric repack, and then ensure that subsequent geometric
repacks are done with this strategy?
