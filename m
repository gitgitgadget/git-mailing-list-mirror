Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729C1B85E5
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651969; cv=none; b=TJbwwXFPXiHUKfGCYEOAToXh/h+fllAEqxWPPPM4oR5FNaK35PP1eZ0V4fYv7wgPTl3yuq1dGFWNrVpnU+Cd7nsobBgMDZy2efriDK7p6iCdtmhhNWidTJZCDrc2e7vMt8uRxf7Y7iTHQh1zXU5kssqRP8UQTd2ppJTOjlpules=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651969; c=relaxed/simple;
	bh=CkF3B4zrVqdyV1G++XZBiJMhnBw7KYwJ0qiBVZnmZis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDC7+PL6V6tKkRsDwWaOrKmDVSzF+FdQUNy4Itz5MpfJcrNVtC5tBh3iWgJ7RwE1VF/7uTKD+l8OklVSSMF2JGLUH723dZzY34M9IWVaues47ArndPeTY1MI7vC+uYGSZS6nBi1Omv+mhpvmocJJC3LiEL22iznQwSrgt8tEXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qzHmDzwX; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qzHmDzwX"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e1a9e4fa5aaso2516519276.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725651965; x=1726256765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLTLHDx3Yo3I8vbQ4CJVjz5alxa7WNzGThcuWaC5JYU=;
        b=qzHmDzwX48S5O5H5IAnjKt+HibxqQfXXufD+AYvI9cFnnWBsSUylGmHUuHm419zv78
         cbLlo45BZEqxWrcx/c8U7WR1jItoit+fZUN1jXcs2SR1VPaa+URy74iVny85RfExD93O
         VxBsFjui6Vd8E96wgK/3ZWV0h0EvfuU/NtRPwMPpYiZwodsZ2xOeLE7kFuvq9E130iaj
         NR4NMLsHqowGdPCSFbLa1scAzPaxJMsGthaT6efXqhvH+oEZR37hSIqXK3axAeVdTzpE
         DXNO1w04y7OTjchcO+bLZzjJ/ysv3T/pMoGDMd63RVXgDY26ffSHNbCmkoizJXRK+lNg
         1u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651965; x=1726256765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLTLHDx3Yo3I8vbQ4CJVjz5alxa7WNzGThcuWaC5JYU=;
        b=LEHADLZ7UxbribDVuyZ4pTJLTsmYoRubq30gW/4D7JUV5JkEpFUMEWsOOx324JIYRR
         d0AMYoKHZGnxr2JiuEVIr4hd7NAWb696VXNhLc1IEYwaKPxN86jgbrXFtS98meXCtoss
         /6B6V45DHFnkRIYZVYp4PtBJVYhgwbzciool3e+nd3uCp2YDmUsvmhcYxKDyq2EOVOMW
         kZikBtALeYaYLBkJ6AIeiAJ3VzABJHlLfMHelJ0VE68m1kDHpjIHVXh98QTIayqkP9x/
         k1KEAUYepXuKJzeTmDvj3ocB0dHY6S7d+VKHrmxJk+zEwZKcgLfahw31jZazndZD1OPP
         ugRQ==
X-Gm-Message-State: AOJu0YyiUJzP5LRB+77ahz6BG0LsnT/w6RutojdYZpAR/imQsrWHnwBg
	rCqun7qKdx9j0qNnXXYNdttWCKt2tMl0YypU8EUvI8saAOYPTZKEM6/4V4VeriG1yir8RdjeJW6
	9aGg=
X-Google-Smtp-Source: AGHT+IENmALJO74ciyzwjaVZf8Dos9xDSTF1BlO/2t4+spwn960zgkyn14QFiwvrO+zj6bW84lB1eQ==
X-Received: by 2002:a05:690c:ec6:b0:6b2:28c3:b729 with SMTP id 00721157ae682-6db44d62c2fmr49288097b3.4.1725651964905;
        Fri, 06 Sep 2024 12:46:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db56337757sm1156237b3.39.2024.09.06.12.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:46:04 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:46:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/9] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <cover.1725651952.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725206584.git.me@ttaylorr.com>

This series adds a build-time knob to allow selecting an alternative
SHA-1 implementation for non-cryptographic hashing within Git, starting
with the `hashwrite()` family of functions.

This version is a more size-able reroll from the first two rounds, which
updates pack-objects to use a (hardened) version of
`finalize_object_file()`, that is now sensitive to checksum collisions.

Peff and I wrote the first four (new) patches together, and I feel
confident now that we're in a good spot to address the concerns raised
in [1].

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/20240905202707.GA2602440@coredump.intra.peff.net/

Taylor Blau (9):
  finalize_object_file(): check for name collision before renaming
  finalize_object_file(): refactor unlink_or_warn() placement
  finalize_object_file(): implement collision check
  pack-objects: use finalize_object_file() to rename pack/idx/etc
  i5500-git-daemon.sh: use compile-able version of Git without OpenSSL
  sha1: do not redefine `platform_SHA_CTX` and friends
  hash.h: scaffolding for _fast hashing variants
  Makefile: allow specifying a SHA-1 for non-cryptographic uses
  csum-file.c: use fast SHA-1 implementation when available

 Makefile                              |  25 ++++++
 block-sha1/sha1.h                     |   2 +
 csum-file.c                           |  18 ++---
 hash.h                                |  72 +++++++++++++++++
 object-file.c                         | 110 +++++++++++++++++++++++++-
 pack-write.c                          |   7 +-
 sha1/openssl.h                        |   2 +
 sha1dc_git.h                          |   3 +
 t/interop/i5500-git-daemon.sh         |   2 +-
 t/t5303-pack-corruption-resilience.sh |   7 +-
 10 files changed, 230 insertions(+), 18 deletions(-)

Range-diff against v2:
 -:  ----------- >  1:  738b1eb17b4 finalize_object_file(): check for name collision before renaming
 -:  ----------- >  2:  e1c2c39711f finalize_object_file(): refactor unlink_or_warn() placement
 -:  ----------- >  3:  0feee5d1d4f finalize_object_file(): implement collision check
 -:  ----------- >  4:  620dde48a9d pack-objects: use finalize_object_file() to rename pack/idx/etc
 -:  ----------- >  5:  bfe992765cd i5500-git-daemon.sh: use compile-able version of Git without OpenSSL
 1:  e7cd23bf4cd =  6:  22863d9f6df sha1: do not redefine `platform_SHA_CTX` and friends
 2:  3b5f21e4a62 =  7:  119c318d812 hash.h: scaffolding for _fast hashing variants
 3:  02764de1395 =  8:  137ec30d68a Makefile: allow specifying a SHA-1 for non-cryptographic uses
 4:  311fcc95960 =  9:  4018261366f csum-file.c: use fast SHA-1 implementation when available

base-commit: 159f2d50e75c17382c9f4eb7cbda671a6fa612d1
-- 
2.46.0.430.gca674632b70
