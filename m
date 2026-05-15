Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6C48033B
	for <git@vger.kernel.org>; Fri, 15 May 2026 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845790; cv=pass; b=tdELto4yRT0yOnEpnScVpPIcbs1DpvO7OEtT4S5U+Cc1FD467lJ9D1vNBFe5PAUTsg0T0qQBw+XAGjNjmFam5DntPC/MHGqemr37Hpr5WbGNLzqGehAt7obPriw8aiKaI+jVIxtNexJ90d1WfShsy+Nb1WIGOblLw8faIEHLo4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845790; c=relaxed/simple;
	bh=E4icbnn1ouQR+0mwLv4/gQOxS89YJ6AgtOwMuU7oD9c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=eMDTaEQ94d+ro/f936BvDAFfgct38vcoNq7gFOTN7ZySOgcq7pSs9XAvsSqK8NeVKkTmF1hhGlwUpwbCChGVcd3gs2KDTm5f+HmQCEQ2uFiK+cJCv+J0CJgo35Jv23BYAU8HUaRBugF71j3hJ8olZ8Q+G9yhaDm5+2oAscub7jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpUZmx7X; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpUZmx7X"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-6329f0e0a16so4008314137.3
        for <git@vger.kernel.org>; Fri, 15 May 2026 04:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778845787; cv=none;
        d=google.com; s=arc-20240605;
        b=Y7kazXrboimHyxv7gyN8sH8Vuqknsb7B5fnBCiiPHq+68iDZRdUVLitT61TfCq7t3+
         09Q9i993+R+hEQBUuLgP5SwHLRH6ocp7H+a/FrRNSrcgbjTOne1eKRptdclxN7AyYVuc
         MAlI629gEoBKbvUBffupMF0v0K9WaNxGnNZH8BJ6Svhcd6f1E9pGP2bSKdLMh11ZawWT
         e4zc+bX0WLy1V7uQafDj1mVs2vv0kNQB9OmQNlf3xDMLxJeZKynKoXB6YTzqUb/fhApu
         eFawYjL3PdiFU0OewwBswmCFtzHGl/40BeJmEOxaJD5C//JJDdfyi8Thh1ryCMVFAnuX
         9NSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=xbnslWgDsy5+eS3PG/hNNJjuqOKBZFETEX+FKvDMl6E=;
        fh=iVjumE5beZLEwbDnYMbSXvAgB6mw7pwkwBl2bDIVjQ4=;
        b=SZoFdsT3EzYnYoYECwmKk57k4FOfj+4MPcox24U+vBPVPtRJWCm5S6ilv1dD/uxusp
         FVg2Swy6KS/2+dWk2diDpbBrFh5lK/z5qdoy7vvjfUvdkIvAKhnlstjgVPrdD8TsxPgZ
         qXJkuy2+lynyRx1CDcwI43hzN4NbFQL127rag3fjX21zXV95rDtuC66C+kBCAOR+T8hT
         0Z8L8FpsKLWvEQ1oEr6uGjmxEqJLDWLHt5do9W+yJHt0nCIZhUbhlkrc3bTPWR9TR5dy
         Dnvp7qhq01NKlbx8lgABwf8duSOs4nZhaeRYlr2Ph+mromUk8uxAdCrWPEJrYKcTt4vu
         cCzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778845787; x=1779450587; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbnslWgDsy5+eS3PG/hNNJjuqOKBZFETEX+FKvDMl6E=;
        b=LpUZmx7X/qwzzbR4JVQ2RbXKFOEGyLdiHsQyDD3AacdRcW/wnrfaytPTtWaOyNeiMb
         iNFSnN/8l+AKwVHb7mbKuC9C5CeJUqAoSjJI6LfuXupBAmI0ZIjIS+EHm8L82gaQ05nG
         TehW41s96H6FqvGbHg1xSgBsGf2P7O9grzmgXJQ8m/GRUjzUvB5WefBj3P/F4C55DDeY
         RItCfPBABSNW5BGuqn4s3ytjBpzQ5fIdV3Yxb6h7Ci6SrFKJQMWRRb2jHfTNaLh7rQH4
         xMr1oKyCxf6HGx/AUsB9+fw7wezPMS9JFJBmHMiNPfQZIh922RSpLP+dXDL11hGWy/ik
         pAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778845787; x=1779450587;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbnslWgDsy5+eS3PG/hNNJjuqOKBZFETEX+FKvDMl6E=;
        b=EZnaArxNucxdH9P2TP6wSNjZQNRmE0gi4KcyWKP6x0fkFv4aBGCIJQimLz58vJpcKV
         O1Tce5flYlTsPHdNjIYH/VsIwWotXrWwFqOhPgzHj9AcDv3Igr1ssK+HHAtcCcVkodOK
         2DPu1qHIX2t2Hk3kiAFlTo9pi6uOmpwRVm3IHa0Fva30HWGdERCvXqeXSWqg9GB4RmCZ
         cntBJVrCOybOWqoGwZx4CCR1GrNnHh81gnIZw/x0dXxzTAnd2m9cVQbg0+iON8my8Vae
         WEyGwNsoQ2v6tbi7dwlo4eMHGsy49ViW2Gd5eXuPppY6rBNA6ylPjJoqq4iI9tOosvmA
         XWtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WJza6PRkpPu7jKLHkRlTdamBgEB2hypn/NgmnypJ/ZgKMR7QDfHm/cKEQBgvE6nCiyf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybOUAjeZassOUbU8TNg97KKr+AzTyCgmiG9SsQ9g2QBfxdBN9V
	Gt0yjFIQQODw+SPXyKshTrd5GPQVQ4z0H4D9glHApMG9jo8e5jk/D9B3Ph53gtZlYdwRlfeZdee
	fv4Bs3Ch/H4NOez/NMz/SoscAzN5Nwbs=
X-Gm-Gg: Acq92OGEo2i0JDgMkrZe4D53XCCviAIWhAfd0gVlWQX829dATnbQ/GAZqXitKVKDScF
	2GRoHBMdP+eD/pqZ03yHS8cvVNsURZaYzSUdVKH28BRc2LaVt7+I9ToIinwoow4SnhLLmsoYPCv
	406uiaf8EDRKsFLAHEdqndpVlze2FWoMhbc6r76us0ZOr7QUH64jo67aa5W315F1RO5TkyNvE+H
	oW58mMTK07ftbQqzcyBa9aaPoBuZ+zZYea0kRyJOJE8N5tDIT613q0GmoslGWAr8/UVKgDiWL58
	K2QYi1bCARCiakmqRKZoxkGj7g8Lwahzyn2S8Mmo4avpHr+VhCx3
X-Received: by 2002:a05:6102:8029:b0:632:d8d5:2908 with SMTP id
 ada2fe7eead31-63a3fb923edmr1509663137.26.1778845787407; Fri, 15 May 2026
 04:49:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 May 2026 04:49:46 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 May 2026 04:49:46 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqik8tm16n.fsf@gitster.g>
References: <xmqqik8tm16n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 May 2026 04:49:46 -0700
X-Gm-Features: AVHnY4IUN7eyM4_hYUfN0FNM4LItdOJLcK0gViBfiS1jCtgFtwTY7Dwe3kgomTw
Message-ID: <CAOLa=ZS8a2R79+8hD-r1JpJmHUatHo4VEC=ybjf02jLEHWsRoQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2026, #03)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000044ea500651d9cf3a"

--00000000000044ea500651d9cf3a
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and is a candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen', and
> aren't considered "accepted" at all and may be annotated with a URL
> to a message that raises issues but they are by no means exhaustive.
> A topic without enough support may be discarded after a long period
> of no activity (of course they can be resubmitted when new interests
> arise).
>
> The first batch of topics marked for graduation for quite a while
> since 2.54-rc2 have all been merged to 'master'.
>
> Copies of the source code to Git live in many repositories, and the
> following is a list of the ones I push into or their mirrors.  Some
> repositories have only a subset of branches.
>
> With maint, master, next, seen, todo:
>
> 	git://git.kernel.org/pub/scm/git/git.git/
> 	git://repo.or.cz/alt-git.git/
> 	https://kernel.googlesource.com/pub/scm/git/git/
> 	https://github.com/git/git/
> 	https://gitlab.com/git-scm/git/
>
> With all the integration branches and topics broken out:
>
> 	https://github.com/gitster/git/
>
> Even though the preformatted documentation in HTML and man format
> are not sources, they are published in these repositories for
> convenience (replace "htmldocs" with "manpages" for the manual
> pages):
>
> 	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
> 	https://github.com/gitster/git-htmldocs.git/
>
> Release tarballs are available at:
>
> 	https://www.kernel.org/pub/software/scm/git/
>

Hello Junio,

I've not been active on the list past few weeks, did we reach a
consensus about
20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com ? Or was
it missed, I thought it was in a ready state, but happy to reiterate as
needed.

Lore: https://lore.kernel.org/git/20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com/#t

Thanks

--00000000000044ea500651d9cf3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f1a96436996e9762_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vSENGZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mei82Qy85eTdFbWZoWWc1QkF2QllzVVdjUlJjQVhJSwp1Si9GdW1aOVRm
Q05OaVVYUUdRMllCamtuUHZnRGpDNThleE1wUVFBcWxCRDQyWWllODdTaTZOU3NRL3NxU1M4ClEy
aEgyeVdzQzJmYlFHQytzcWNKdVBqM1dVWTg1N0JvZXNEU1dnZiszdE1kRlU0Si8xNmQ1Rm9qWXhW
WEpxbGUKK2JGM252S1YxY0tjd05iQ3NMMlJwNXhMNmJwVVlLSDNWbDhYOXBqYXVWRzhyeTZOdXBG
UVRLOFBsZnA2THVObQpobnloMTV5RVlwUWFQcXdjL3FKdFRTc09IVUppdy9PeTlTUlBOYURtckNM
YW4yVTdGaGc2aDIxSTR6dGlxNjA4CjRnMGRpUzJtUG5ZT3FiVXBsNzMxVlk2UkozSDJBZGJiUldq
M3d2QVN0UFpmVUdsRlBEbGo0YmVGV3BFUVNSdjIKV0VVWGJabTBFUi9EM3ZKQlA1c1N6NVFOQjBL
MkxCMjRVV3ZRN1BSa1k4QXByQjArdEJIdFpxRVB2b1RRUUVwaAp6Ly81Snd5R3g3Y3FqZHZ6M2tT
Y2N4emVkV3NyeDl5bmpZR2pkSHdyMVRKcnBoUklTR2hzaHRieHdaZW9jQkF5CnBZSTNGZTFLTkZT
SEV1eFR0b3hxbGJFSm9LRjZFT05UeXNYV3Nscz0KPTkyeXgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000044ea500651d9cf3a--
