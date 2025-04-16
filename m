Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D97A227E89
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783032; cv=none; b=Ha5LLrkGfrPaRAfE34njl0Lnz6BqDAlfwyZKE7DZDJLaQ2lECoa/iy66MM2+kIJo/Ig4L/Q7nSK41L/c4PIMYKhnPJtCpwLKS5ieOeijovsKUf1xWF5025SzqtHhPziEa1KbaQYBxb3B1y9tVDabwEPive5k3af/pNkS2x0tvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783032; c=relaxed/simple;
	bh=MVXGt/ou9YLE0YDhg8LHPNMkN9XeEubn53zlp6bAvOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tlh9tamtaVzEqs7tfm0fkw9YbQwuTWVqPVVyCSfq0KL0Znu1NNfXAd5sODpOHMEie1J7aiPj5R79/1fxPjb6EhywOmUtK8DZZcGrfSqOwClsGMI7Z5GIPns2gjyemHqmbpdth/fNPXn7owyF7rs7J2Q5uTyJJhu8yXA2RmXnuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZaaWZwf; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZaaWZwf"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8616b7ad03bso121615139f.0
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744783030; x=1745387830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co7x7oUqTH9cPKI8o4pgzGvhvDxhJ58WYCP2nhp//+c=;
        b=lZaaWZwf4J3nGDEwvKncKNUrLWuCndOBRIuZ9PjO683h2nRcHfMT1SmMHK/sVkxyew
         5+V9ldiBeForPwK/+Pkgc8cxZEns/DAOi6bsOKMSLHwsj6iXrT8/efIq0Jdx9Z/iXBPj
         s0X8GHwypwF4/+daw2fByJpN407gh7T9csHyRaVHBqOm7QpYqJkjFsR7SdXu4QCI3nFk
         /RkRkfgbV2aeTeqzk9sh6jPSzwtXAawY2AeI9e/T/NFGS0iQGg2QrvPWfZ1ovkDb5bRn
         vnvUCgzQ33vAGtEsLsWKqiZRY6CAnjakMbYY1lIjJr0oMZHhaiRMfR3InyvP/PQRF5yr
         xwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744783030; x=1745387830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co7x7oUqTH9cPKI8o4pgzGvhvDxhJ58WYCP2nhp//+c=;
        b=uA1dehJIhyA4EzbQK3nxAZjC09yeEAxz4ju5VH8aWlQYupDvPT8WaoRBPcTe/8RVQZ
         blLHi1Drmpn0vmtUY4RGivVFL//kOGKgoSJIXxMVP0VncpIRZwnsml6AIQ+l4vDB7kOK
         72S1oNo3QtvpqGtsvKPjmCHCLTiE5GWrkHETS8btWLd8kCRBJiNfL65F7sgzcB2zrKrP
         JpiSqVzdxeaOxWkopl2nL1jhHn1JTEEjZHDlwysJadErnbmUlaP2Q8gNInQhQ6iJWmvz
         Bkyak9QahEeF4exG7FWNrGrDJCAnVKhJEPxlUac0jHd2+KyOZa3W/PhwEY9YjQ/nqObw
         k++A==
X-Gm-Message-State: AOJu0Yxtrtol1x+VQPV2v7aCZAvVxAOscuitr7VV4RH0oT8wX9//sYhT
	YcYOkvVNY1s59s9MGTXu+AQAfg3vhKB9vse3sobHOyDFWB5a/8Lo+zGqK9t4P2/sBfEIsN6xtVk
	78GMzhzAUuxGXPYdw/zl6pS6HjI0=
X-Gm-Gg: ASbGncu2MPp/tpgsZ394u74JaMXP8zhpxijGj/91TzZ0tZ9NCY0l9c/XhdtTcHVRada
	/6wxYA3a/tBew34imROzUGpMzrrXNZv5I15pnueRW19L4Au0M6LTzuPa6l+ADQQN/1fO2/YXZA2
	PlVcGenEVStdczvDp/ei7BiIRmFskaBbXTZYXO/c329inW/k2KX/fFs2o=
X-Google-Smtp-Source: AGHT+IF5fVx6j4iw3LtnSFc7t6z6YkvZtVFk9yeWE1AICkeZA0fx36NIps7KTbPfWFj4jf5g2IXUbvGvXS2PNwnQCeA=
X-Received: by 2002:a05:6602:4c0c:b0:85b:505a:7e01 with SMTP id
 ca18e2360f4ac-861c5082d9amr45781139f.5.1744783030095; Tue, 15 Apr 2025
 22:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744413969.git.me@ttaylorr.com> <cover.1744757204.git.me@ttaylorr.com>
 <58891101f377267df120dc4a9edea2997296dbec.1744757204.git.me@ttaylorr.com>
In-Reply-To: <58891101f377267df120dc4a9edea2997296dbec.1744757204.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 15 Apr 2025 22:56:59 -0700
X-Gm-Features: ATxdqUF4OZo1XFwILzdWFzVn09MBKdptnS9IPGhnmkq_tXymOnil0rPihJy0pJ4
Message-ID: <CABPp-BHOSiOSFeqTutAqznTCO6Fh-kM7d2B-jF+LU1iTQzOTOw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] repack: exclude cruft pack(s) from the MIDX where possible
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 3:47=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> In ddee3703b3 (builtin/repack.c: add cruft packs to MIDX during
> geometric repack, 2022-05-20), repack began adding cruft pack(s) to the
> MIDX with '--write-midx' to ensure that the resulting MIDX was always
> closed under reachability in order to generate reachability bitmaps.
>
> Suppose (prior to this patch) you have a once-unreachable object packed
> in a cruft pack, which later on becomes reachable from one or more
> objects in a geometrically repacked pack. That once-unreachable object
> *won't* appear in the new pack, since the cruft pack was specified as
> neither included nor excluded to 'pack-objects --stdin-packs'.

But immediately prior to this patch you implemented
--stdin-packs=3Dfollow, so the once-unreachable object would actually
appear in the pack if that new option was used.  The "(prior to this
patch)" addition was meant to help clarify here, but to me it doesn't
succeed.  (If it had been "(prior to this series)" it would have
clarified that we aren't yet using the new feature from the previous
patch.)  Perhaps you meant that geometric repacking doesn't use
--stdin-packs=3Dfollow currently, and therefore the once-unreachable
object won't be in the new pack, but if so I think it would be helpful
to call that out explicitly so the reader can more easily follow which
hypothetical state you are discussing.

> If the
> new pack is included in a MIDX without the cruft pack, then trying to
> generate bitmaps for that MIDX may fail. This happens when the bitmap
> selection process picks one or more commits which reach the
> once-unreachable objects, commit ddee3703b3 ensures that the MIDX will
> be closed under reachability. Without it, we would fail to generate a
> MIDX bitmap.

The comma between objects and commit seems insufficient.  To me, that
feels like a contrasting thought that should start a new sentence.
Perhaps the last three lines could read something like:

"""
once-unreachable objects.  Commit ddee3703b3 ensures that the MIDX will
be closed under reachability by including cruft pack(s); without them,
we would fail to generate a
MIDX bitmap.
"""

[...]
> ---
>  Documentation/config/repack.adoc |   7 ++
>  builtin/repack.c                 | 163 +++++++++++++++++++++++++++----
>  t/t7704-repack-cruft.sh          |  90 +++++++++++++++++
>  3 files changed, 242 insertions(+), 18 deletions(-)

You addressed the rest of my feedback with this patch, other than the
two items I highlighted above.  I'm excited to see how this works out.
