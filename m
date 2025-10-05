Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370DA34BA22
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759660717; cv=none; b=raYwNVnu2dbGp2gIy+b/n4gDq/qnrVfuXGf/7hUjf5FSJj+fACH+z6PUB5ECWH3KRqtCFxq/fFCXWQcIJyIs14XjQ3Pxc4KscNMt2FLwvcnzEKT0iGPSfu2Q4M0Ny7vISp+9D1siCC5uvMMOUVoJBGTr1RtLInLMLRFTWjL/aeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759660717; c=relaxed/simple;
	bh=GmvNauz0fjt4klOI7XMd3X5JQ0KSl03b/tF2G3QDocs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UF5pnbbxuP/PyeRE76IojUVERJkCxIeMY0kgEnTAiizBPfmgrdoeTdlG1KglPwXUp/S6aMgbs7sAOGT0SLChP+nMrD+Vgjyn+6SGMGP/ohBmu+J3f6AElQ+9K9v+XTQqDoBs4bHn0Tbz2HgQyyWm8uIcUgmHR4ORxKnekxVv424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6pat59D; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6pat59D"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-330b4739538so3866743a91.3
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759660715; x=1760265515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs3KlzpTJOfms9XLnkOpwJnYN291Otea32OZjaQgs9I=;
        b=L6pat59DP20+EQXlYwM32YrgPtI4W/Ghb/1TQtP9HrcCvk1S/tK2h5/DDXurD0TodP
         Qvt1xg4iTaxmk87K1siO5DKaZJN6bI21rR6Sh2E5ovCwvx3+1VNrN/ynwyPW1ZQLTeME
         HbMfDOf/Lk9HxzVP6CzxwDHmcEbE263IK6iiasFh36/L9jp2eREqhdIZqfH7wMJIdQp+
         9VWB1VSGxFab8iIxrsAiQ/cB66zjWFunZxRC6V0QsBURL31bx8olEgVYfMMwckkru6ab
         NCF1AhZfuX09lGSMQu3+/FWfF/2dwLml3yWUNXV0wyjgqwiMNp6NkZ488VNu9pdcalSg
         KE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759660715; x=1760265515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs3KlzpTJOfms9XLnkOpwJnYN291Otea32OZjaQgs9I=;
        b=k3ZuRj5oG9SJTV8pMAYcjOpjE0TNtYilxwvALQmTfl9rXZOI54zgLD0hN2WHnQRHA7
         EBF3zJyRFi9KGPGqULYqiKNH2o8w7YBq/o0DGYMxngNy3MWLkMcvRpQIAfNEAUrWtEAf
         ID4IosjEgY8h/q7810/Qh2WYM0ufXAmwAlLSyVTJ2/pbQZU2BeLzGrHF6wZZ2hs0Urx6
         zc2GI3h+2jV2w6ip0xpvYeGjcw0hVZMs9m9tedGM4hJRIuxFU2wR8y+ygYktOSr8C/7v
         V86LNG+7XS68TxndeL4JNrAR4kBMUbJknRZrM7L9kpYr/EPeWwTIykCmb204ATvl2TOR
         WqLA==
X-Gm-Message-State: AOJu0YwvaLweod5f38s6v7t4BpF+zqmWYt8LKOge4DLsAFiGP4jlfPxt
	0dbUbs/6yd5tTyxqIdx8ulvXHmKdb4EOnoeY27tjNWaXXn0nWl1pOoQxlNYugDIg3YOZfqJpIGH
	+rQSuD/BNA92Q0cjXVXKUWmR3dZ2AKoAJuatVF68=
X-Gm-Gg: ASbGncuSZpZo1XFJaQbjNbBs9ZQEWbGigPAs+kfB4wpN83htTyJMRD2d+E+ZoQRrPwZ
	aGeHGqFSE5t8NOavUh/lgqYFVspKuBHfhGtBFhCXMeosBXDyTDTa4fxsdEOiPjUBuQ+mDCVrEBH
	pZuaXmi42qOW3EXvjzTtNPb3vYDDOvEz29MYZnYHaevBIOacZfpjOwvs2UuIlk6WaZNVxyGK18n
	EyuHhHbvvfGozqMXVFh1pubRYTRMhs2iPMagY6RxHiAPDMlBJinu/75wICTwmI82wNvWmbX
X-Google-Smtp-Source: AGHT+IH5eZFj3YIHgq5yq/k3p8TyY1vn7g6fKazacRq8ORRWi2wxZ3TrrLwUzbZ0jHfo6MZZ4X7UueaMxoi+MhVC1sY=
X-Received: by 2002:a17:902:b092:b0:26c:5c03:6781 with SMTP id
 d9443c01a7336-28e9a564e7bmr69293945ad.11.1759660715442; Sun, 05 Oct 2025
 03:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMWvevL03vRzX35tiRCkoU6CKucKim+GfacEVuN6wwm9r+1a6Q@mail.gmail.com>
 <CAPSxiM-veMq2TRJwzbRPpewrpCPYdieTjs3uR2L4e3ORQDsWgg@mail.gmail.com>
In-Reply-To: <CAPSxiM-veMq2TRJwzbRPpewrpCPYdieTjs3uR2L4e3ORQDsWgg@mail.gmail.com>
From: Vedansh singh <vedh2o2@gmail.com>
Date: Sun, 5 Oct 2025 16:08:24 +0530
X-Gm-Features: AS18NWCAu76D1ozDjhSzJJQMqcVKUu33wC4T3PTRq--IoYkjTB9_Kpc6Na5GHG4
Message-ID: <CAMWvevLjSiL=9kHzke8oWBSfXycmz7hyHbjaiZza+x-DfoVWNA@mail.gmail.com>
Subject: Re: [Outreachy]Microproject: modernize path checks in t1410-reflog.sh
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I have successfully built Git from source on Ubuntu (via WSL2) and run
> the test suite. All tests pass.
>Good.
Thanks

> Firstly, you do not need to take permission before sending patches to the=
 GIt community.
I tried to send patch using GitGitGadget but got Error: User Imvedansh
is not yet permitted to use GitGitGadget

>The main point of micro project is to get you familiar with the Git workfl=
ow.
Yes, couldn't agree more.

> This is a good micro project for both GSoC and Outreach but, the
> Outreachy contribution stage
> has not started yet,  so it might not be considered as your
> microproject for Outreachy.
I wanted to start a little early and get a better hold on the
contribution workflow. I=E2=80=99ll try to pick up more issues that need wo=
rk,
which will help me integrate better with the community.

>I will advise you to send the patch to get you familiar with the Git
> contribution workflow. The Outreachy contribution
> hopefully is starting soon and you can send another patch for that.
Thank you for the guidance! Yes, I=E2=80=99ll go ahead with the patch now s=
o I
can get familiar with the Git contribution workflow. Once the
Outreachy contribution period begins, I=E2=80=99ll pick another issue and
prepare a fresh patch for that.

Regard,
Vedansh
