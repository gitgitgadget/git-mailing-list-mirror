Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8040E8DC
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668965; cv=pass; b=EGhrcXu836tkAfSxlihPPtCjZOPHa+5BhtvzC25ryy4MjLj8p1ZqzvZJDGXHyogoJSMblFhJesWWV9daojqQlDPBRrvWT3g9cBLM1QeseTw5ikqXwHfGXJ4cspm+a2HW+rUvZjhjpRk1BIMc86GVULk0gTJclAXFQXwWWaUcOG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668965; c=relaxed/simple;
	bh=kdJOOx/EHNO57URLLDLHWm0vQkLN8Cp1LLpxMnIXVY4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9l8Vt/wkX104DqZOFlAIffUWYS9bRoxvB0v4zXkBJ6EvSp8W/10EfSAEoTtNLDKsyOmTKKMol8ABUvRm/W7rIi3IYH9SS6DNZuf8ZN9W/JPitWphUE60ulDExqoI89Hgv0YIWm/8EZ3DHCAJ0EyoV35rYiAkbwm77zEPywSMD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki5mSifl; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki5mSifl"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304545f5206so2322968eec.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 07:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780668963; cv=none;
        d=google.com; s=arc-20240605;
        b=T2eYOIcpzePuAHCgt2mF/LteigyFNcpvsuznwzEgCBL1nOGghsn0vgXfDmsJq2Hd8A
         3ukx8l61scm+50TqnqXl6dArCO4D8VSy1zCimIYnCD5bgT9u4DhxKsIa96/2qI1LP1zm
         DJsEZMX3nVw4PaMDmhxvB35QhKasiDwtBP9mABw6LCuy2ouuH6Evte4nZjqje1Ij/K0y
         AIJbjsF/9bzZeSQGgEKIy2bX+EFuTz5/JEfTNJcCeiYVXjB1TJm4Px+x9GtoDdRJGR8m
         uuIENq4hFM/wYYDtii/+ia5LqZBIl559A3oHtMFbXLUfczMRGk1unHr/kcVHkucyRKr2
         sxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=EArTwNnYdQwvS39C3eGUe5ID34hvojzGf19mkWvddfs=;
        fh=0iMh800H4eMw0x2zG5Ehmvxfig0jJuD+QdYLthhaIsA=;
        b=e3QFo90DdciGQp1o+nZM1ZaiVBrgWtw5AnPclizZ169pcaiVMarBthDG1Dn/D3FEqF
         /mwfuxdsT+S3ONEAT7irdxIX/x/XKHxp1P3l7sLN2Sb9P6rQDAm1ep1gEbe1ASk2SLAN
         kkDxfe69tqHN4CsEa2oDhqc0VgM+QIuBM1Gt5i8Imw2LWCJ2nhWWTb/V1nA1wzXrYJ6J
         fLuCd01kZeadnwS4m505ho3FaWPozx8OcqpdxLfmi8OzekmSIEZw9kqRUXG7MRUNLnp5
         aF47rTu1gJd3W49xlJh4vuYMc0jmxbBsnQiPdxY6qnLX+usV1iIvh2LjuAJxxVMLiLEQ
         kdnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780668963; x=1781273763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EArTwNnYdQwvS39C3eGUe5ID34hvojzGf19mkWvddfs=;
        b=ki5mSiflDdPnTY89n66MQuzBd3ie7uSjg7DJXYVDQUxKlQE1ohxyepyc8N2b9RdSh0
         UsOE3Oe/qWM68HOGeGEecR6ZFdwtnlhdTTtRtAINWR8TQq4iVS/vvdhxxjE7zAgUBqyk
         a87NU6KdcO0yUqdO2RS+WjnmwGVk/fiDj8rpNfesC6Jsw6umuenNFPKZpDEAZgibzrkx
         LuTLpDrMRsfFGqZ0CPhwK5oHXUMaY0txF4aagSOUWeI/AF48G2K1MSLHpGZyBpdF785T
         3XeUbupUNWudNznZdebOJXIsg2Fv2fOIiT5J4JZTHHQC/+xiGqyvQtWA4IldlqB8WN6r
         OOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780668963; x=1781273763;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EArTwNnYdQwvS39C3eGUe5ID34hvojzGf19mkWvddfs=;
        b=V6ybNvsYtfb6t4uCnQf97cTaoJAXIbfhEzHkim1CYB76kbSCFl2axwKf4eT/WwANLm
         78vzWJ3kXG2BLpHZNg3HRk/U3I9OoM18RfLyQmqhfegoZDm6cuCArt1h/ZwunMCmZDdN
         O8/3PDIlSPf7v9haw1eznBswGrp1OZK38Ks1Ehif1ecoD1w1nL/yGIfG9xZlQs13gqGb
         caJ9Pgb7TqEdBwi8goq6zucx/m7gT1eQSK2ju79LbKV9q2a1rN+tBXvLP5mW/VJcHV1f
         90Z08wN8LxZBSFmo12W22nQRkUylZuY+scDHm2n3YUaFPEY8DRdDeCbTe+K1OuAecGIK
         XJLA==
X-Forwarded-Encrypted: i=1; AFNElJ9yfKyn2OG1LPKbvQp0OQ3PthFmRUC2zzi0UrqQHVjW3ONSH5WSlm4LG/3vG22lla1PvPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB0Gr4wjX+PXid7g2L8mduh8rZlJOEm/YHWH6vgTyHfNZv85hx
	9X2Wx5ktmTAwbjl4MCE6gx1pt6txPgDo9SKiq8vG1B523e46BR+2RE73Fgd98GX7Ghl++QqjHr6
	ymtqBdRLUVuztKq2dUv/BAtwHLDucebIOFA==
X-Gm-Gg: Acq92OH2bkK1IBpANiv5k8UNPF3nZIX7J5JIfbQFkNsi8BO5L1VO0J8xD08dkALPKeu
	AYjTlf3A/KB0U5W9+vnU/0pBTZ3lDKiY2eal0wXFpsSvY22q5KlyWrQ18uku2altTZ301mu5qfH
	LMSwQG5ugLvlptZ6rqLsparBS6r7UJG4vCfxUe5QXYJza6UmmxYAg3b9/Z/GerlGjCBDjpsPTfv
	jn9eEI185OBiu5onz4g314hxU49b0Py8OjEscAWPGeSUMpiHMuxskpXljz/WvyDD+NNR91A0Pwv
	iLVKv7ku2NsdP/stQ0tEExCnmTraTw2wugZzdm4jlLSQBnUFkp1WOpc8uhbIjGi4Pz1LWVWtzmN
	phQBrNg==
X-Received: by 2002:a05:7300:2152:b0:304:3c33:7ad6 with SMTP id
 5a478bee46e88-3077b080e0bmr1933024eec.11.1780668962692; Fri, 05 Jun 2026
 07:16:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 09:16:00 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 09:16:00 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
 <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 5 Jun 2026 09:16:00 -0500
X-Gm-Features: AVHnY4LyEHiOkGbcK7VlLg8tKctbNsOJ2pYK3tgfGC1KX8nDGE_fgd1L0J0WwPo
Message-ID: <CAOLa=ZQwVbLsOcajaxQwtkTPm=4St7EiGEEyL6_B0o3Tt1v1pw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] setup: centralize object database creation
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000fc64e70653824c76"

--000000000000fc64e70653824c76
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this small patch series refactors the logic for how we discover and
> configure repositories. Most importantly, this involves the following
> two steps:
>
>   1. We unify the logic to apply the repository format, which is
>      currently open-coded across multiple sites. These sites have
>      already diverged, where some repository extensions are not
>      consistently applied.
>
>   2. We then centralize creation of the object database to happen at the
>      same time we apply the repository format.
>
> The end result is that we apply the repository format exactly once, and
> that's also the point in time where we can finalize the setup of the
> repo's data structures as we know about all details of the repo at that
> time. Ultimately, this makes it trivial to introduce the "objectStorage"
> extension, even though that's not part of this patch series.
>
> The series is built on top of aec3f58750 (Sync with 'maint', 2026-05-21)
> with ps/setup-wo-the-repository at df69f40c34 (setup: stop using
> `the_repository` in `init_db()`, 2026-05-19) merged into it.
>
> Changes in v3:
>   - Explain the move of `verify_repository_format()` better.
>   - Document that `apply_repository_format()` also verifies the format.
>   - Link to v2: https://patch.msgid.link/20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im
>
> Changes in v2:
>   - Commit message improvements.
>   - Link to v1: https://patch.msgid.link/20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im
>
> Thanks!
>
> Patrick
>
> ---
> Patrick Steinhardt (8):
>       t0001: plug test gaps for git-init(1) with GIT_OBJECT_DIRECTORY
>       setup: drop `setup_git_env()`
>       setup: deduplicate logic to apply repository format
>       repository: stop initializing the object database in `repo_set_gitdir()`
>       setup: stop creating the object database in `setup_git_env()`
>       setup: stop initializing object database without repository
>       repository: stop reading loose object map twice on repo init
>       setup: construct object database in `apply_repository_format()`
>
>  commit-graph.c  |   4 +-
>  environment.h   |   8 +---
>  refs.c          |   3 +-
>  repository.c    |  40 +++++------------
>  repository.h    |   3 --
>  setup.c         | 130 +++++++++++++++++++++++++++++++-------------------------
>  setup.h         |  20 +++++++++
>  t/t0001-init.sh |  10 +++++
>  8 files changed, 118 insertions(+), 100 deletions(-)
>
> Range-diff versus v2:
>
> 1:  50224c1a12 = 1:  a6f452b947 t0001: plug test gaps for git-init(1) with GIT_OBJECT_DIRECTORY
> 2:  6d655e00e3 = 2:  905e618dc6 setup: drop `setup_git_env()`
> 3:  2e7e9bb052 ! 3:  e11f16333d setup: deduplicate logic to apply repository format
>     @@ Commit message
>
>          Introduce a new function `apply_repository_format()` that takes a repo
>          and applies a given format to it and adapt all callsites to use it.
>     -    While at it, rename `check_repository_format()` to clarify that it
>     -    doesn't only _check_ the format, but that it also applies it.
>     +    This function is also the new caller of `verify_repository_format()` so
>     +    that we can ensure that we never apply an invalid repository format.
>     +    The verification we have in `read_and_verify_repository_format()` is
>     +    thus redundant now and dropped.
>     +
>     +    Rename `read_and_verify_repository_format()` accordingly. While at it,
>     +    also rename `check_repository_format()` to clarify that it doesn't only
>     +    _check_ the format, but that it also applies it.
>
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
>     @@ setup.h: void clear_repository_format(struct repository_format *format);
>      +/*
>      + * Apply the given repository format to the repo. This initializes extensions
>      + * and basic data structures required for normal operation. Returns 0 on
>     -+ * success, a negative error code otherwise.
>     ++ * success, a negative error code when the format is not valid as determined by
>     ++ * `verify_repository_format()`.
>      + */
>      +int apply_repository_format(struct repository *repo,
>      +			    const struct repository_format *format,
> 4:  81b92bca7f = 4:  b0d7c11fe6 repository: stop initializing the object database in `repo_set_gitdir()`
> 5:  807fc56353 = 5:  d0af56fdae setup: stop creating the object database in `setup_git_env()`
> 6:  96563ff99f = 6:  3e75c5b0a6 setup: stop initializing object database without repository
> 7:  c14f45169c = 7:  50fa2fdb3c repository: stop reading loose object map twice on repo init
> 8:  e67c6e66d6 = 8:  4dff9d1794 setup: construct object database in `apply_repository_format()`
>

The range-diff looks good and as expected. Thanks!

--000000000000fc64e70653824c76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d8fc1798dbba6255_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vaTJob1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHhTQy85UHI2SVl2WVUwTjdTbk1RRWljUHRyaDJjagpNei8rL0ZIS2NH
M2IyL0tHUEZZdUxtZ1FFNklSQ2QrOVlRSjhDclBWVFhNa2pIa3JQYm5zK3p1ZDBUNnZZaGRMClVN
dnB4Y2ZyOGxOeUtvcHo3Rm9rUEoxOU9Tc2xPYkN4L0xMYTJJY09hVEtPN1VJS2ovMFlZbFdDcWlH
UmF2RHcKaXdrYkxkYjR2Z0ROOE9sMisxNDdrcGhvR3RHUVFSaTIwWTNIQnBRWTBONWRmd1NFajd6
WG85VlZKanhUMFF6Ngp6VDRXQmZWTlpOdzFxOWpDQ0NqemRwUFI4dG9hcUZSZU5wSWFxV0R1MVZF
VUhqNmlJWnNqZCtyTGU0T0VDU293Cm1LOEp6anVmZ1lqSGdLMkxVY1hTdnhqbkZtWjFSc0s4MFdm
Zk9sdDdSUE1aNVY0RXVTWjMzdEV5QkV3dVZxYUYKSEw1V05zbnRsNmtpYXYrVlFQZTl4N1puamQ4
Y0RTaVpTemFQdEdwcnJTTC9aVlZxNUg2ZUZrT2kxRm9udHEvTgpLdmtnWWVKQU9hNUZPbWJhR1RN
dzFEMUhIODdBQVJSZXRXNVR1VkRzOWtvLzI5U3h5aEJ4c2JiVmNLMGR6RTBwClk1aXdqMnJhMHNV
SFpwR1VudGY3MzhZWlBsZ1V5dFBOZnhjMlVZZz0KPUIxSTQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fc64e70653824c76--
