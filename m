Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD5E1DE3C7
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369789; cv=none; b=JUxCsZxuIvoODwvZqvzuny2vu5XiONRT0yeHX/qq2BQWbvF3/dlQVH5mptB7Rp61V/AqRVrFMzW74iHE3h3zhTrrCZjcHm5hqrNNIspmMYpPtu/E5fWwHMerPF+C7Bb6gNphR8xvIlq+HREd8ttb2fRV5FzDwCEQuJoZubOrKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369789; c=relaxed/simple;
	bh=baPAcRBoA/X2loWOVR0TSRRAHLOv/7BrEW4DwaSG7NE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bMHhU/Lm4EpkF2lpqT/jORyfL4Bwp66/uO3xxP8frxNI2Bs7LjvfSuJPqnhW0uHgzE5Y4FW/RR5J7sc2JOHO19z1DTl+kF5Zq5ds9lPLWdlNjXpAhVdvN/PWZJ9opJt8K5C3unW+kAkVRl43EM6k+rEgSR89N6i7CDov2HzrNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laoH8XzI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laoH8XzI"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac73723b2d5so367125466b.3
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 04:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744369786; x=1744974586; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=baPAcRBoA/X2loWOVR0TSRRAHLOv/7BrEW4DwaSG7NE=;
        b=laoH8XzIiKee58X3OPKcnhRSaWbe1vfZ0n+Xit/9yu29Exs9co/W473LxsRaK9+Dk5
         4DEs0rRUOv+RGeeBMIL8eOZMZEyorUog1BCVywlwp6xR9uhJLdeWunoyJtJEMzJXE3IJ
         86cpD0hGEZ4qStO/XYiDNTnd7VhT4SqPx2LsQ94iNaKKYQQBkbIdOJkal8cd6ur/GvZA
         wXehG3BnPM+LfYohymdM9TtD8x4x2SBInVZUktALRp3f1j6xV/owP+bQ3S8/l+LBnaD+
         X6deU1afReJd4qXP+nr1E6gbdNNIyvwI6uioGvvy2MyMMJBgQJrIc5IEszkXC5UZ/zJ6
         sX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369786; x=1744974586;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baPAcRBoA/X2loWOVR0TSRRAHLOv/7BrEW4DwaSG7NE=;
        b=SFk4XacyWlL2Ug4Wp5e0HxbuorkUBSxjPS8Tq2VeZSCEN/NmK48SYTk8CZ39YXkKZq
         dQE67TKfUdFkRlQwrDz4ZeJftyEZlR3IIYn5KubFeM/VERNlbsy44HWkgxEeOWUM6ray
         HtsxqSX5YveL7ITk1mEWKIR7N4bWsqAs0iMuVWxQ85OwxQNH1D3W3ZukoopJTjruZoss
         fFH843AzJXYxMzO9fHwDMmDX/8AClzvqfr3RlaW+HFLCi9EYf7WmhWn6YnFORgonYdXZ
         Oqdh3hKJAbPLRxlavCntpxqnrPssBOyCjpBcdk+87/6t95NbbMzgdCm2vDtOMuS0RiwW
         3OlQ==
X-Gm-Message-State: AOJu0YzELslgZiQ7SOTttwKTXKOHHXdMbel3X/1ojntr+M/LZjrP+PeM
	PHVWtkVSLclPrlyubkcxn9JEsLZuehTMxsMablGLl19O8OWit3mVr+IMOVocVgio3SJHjcCu+aW
	s+0SSPZ23x+dDPlruxRWwxbb62e1kgQBUdk8=
X-Gm-Gg: ASbGncsLhvf7j/Zd3mF4P86lA7z6QwcrThxSNf4i5vcrNF8moEo5l/hIS6PD1gmrLN0
	DQsMZCQViS1yW2qbN9nViO71pYlCt3ujTFPXFkqRayPn7t50oVfH3qmt+y+3yhpv5LGmnvKtSF9
	DiPDcb0grM9o3WTE7iKmbxpnhfIqjY8JcJ
X-Google-Smtp-Source: AGHT+IH/YGS4+2/R+GD8hFU5Ys9lvUIq4GehfKioR/BwBLfL2PIAtlmkfCQPiPWVwjSOPN9/vvH96z9zlZqAYgbBxx8=
X-Received: by 2002:a17:907:72ca:b0:abf:7453:1f1a with SMTP id
 a640c23a62f3a-acad34fcb7fmr163005366b.36.1744369785723; Fri, 11 Apr 2025
 04:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lukas Michael <lukas.23022005@gmail.com>
Date: Fri, 11 Apr 2025 13:09:19 +0200
X-Gm-Features: ATxdqUG07tmtWfYsMdyiMy_S0DDwXX3F2iXJwRoGIUncXuq202nQXJzxcwv8wG0
Message-ID: <CAEbzv6TfMai+vu76Jw157KyMNScwW6pUZaDXbN_u-XRKz_3wnQ@mail.gmail.com>
Subject: git credential management Mac OS
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear git kernel team,

I want to know if there is a possibility to set my GitHub PAT as
credential without the need to clone or push a repository at the
moment. I want to setup my Mac and store the token for further git
clone / push operations which then need the token.

I hope you can understand my issue =F0=9F=98=85

Kind regards
