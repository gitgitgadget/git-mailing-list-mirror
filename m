Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3B292B4B
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128121; cv=pass; b=jy8nckI7+cZJShp8oeG0JTFVobm9d4mHcK7qtmnX9xDkGXH21/K448Lo/lLxRxygBUB2tmxFoZNF9MoZJQgU0WUX9yib4U9K5C0+yhNYfDvVNvkLd2WrpdOdOhsXctcKZpwYw+PaDtYkJwi6f+1u+uyv6/ZKVEq9+51/zFmt9hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128121; c=relaxed/simple;
	bh=jpJ+ZiYeXnQWcUTkDCaIpYHeQO+nBZNd4I/ParjKQP8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PPSBDCbBaCZbW9Y2MlRs2VdmbVTK+h2mloWlJa5sXVtv/gcM34ns9N01IR4vhvTVE8+VM+v6KcTmbc7si200zGNk6mw3sq7Du6zJQScNrG91AFYVo+zUoSkQhpQBltwU9Mr+TRuTWk6YSud5jkw8IiZ3Eol61udFpZXXhZVJjOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As85uerH; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As85uerH"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-662bb8b1f93so4005677d50.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 04:35:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782128119; cv=none;
        d=google.com; s=arc-20240605;
        b=MJwrzsNC9Dfhfx1oA17O03dkMHFhaUNfTeOKe2Sw8W7zoUOdZgQilekLQjBqbdg7Te
         VNDMGcdc1seSAYgwJV+Zp+RzyBWKYzxtj9fVhleLtJgZ6vLq5JmPVcyYTq8mPNPgIDMr
         oXYDnlre0nwHcjsLkO/8S4yjpX98Ss7ys0jOMXbUCIoArpY4kFn1Y/Pf6VFIjURy9SkN
         B3T7YLAgAre75lQQoeprqwhoevbr2kLIPx7P41Ci6PlTjSPiEfQVqWwvYZnQe5YYXd0W
         SyKfbNd833pcmq2aohFCrbnHfQVIlCEiJiug8Xxg9UV9Py3+ZVG166bRhAVHGmAY6mqm
         9fyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=RfpTR6WHQTIbLo2wLiDOzrvUHKrolPMkfX0MpSpIgJg=;
        fh=C2tFeZSjQ5U2DbsKPSTaDUz6Yew+nfnvrCXoFTYwlBE=;
        b=M20cwFM1yAgtDHQ23u9T92PCRWROgIhWxloD8WH6s1LU7JHEe0jSmtyvGalIOq+9Am
         imbeM1EDPfjErj7XixjKdf6QWfMOwPJWK6oiAZjraeZ/8+1kPRhUof0OpT4hqcsfJvyO
         2kOeupd1MV1uLy6gpegfOLATnF9JgUrcbP6qGzO8y16z2UsNJHOZswEr5aAEiIVj61fI
         hZ2Ouu1DHWUt4xOIO9ZzvU2XI3PnOKqx+u1DJimoH/MeQ/NoJ0ZwUvQBjZ5FJU1jRIvg
         mE8EvQ+7AhrIPv7HPp76QieTvICDYznOKzX3qiArzQKDqTS00wNTAh4mt/idah/HB3hX
         4Fuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782128119; x=1782732919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RfpTR6WHQTIbLo2wLiDOzrvUHKrolPMkfX0MpSpIgJg=;
        b=As85uerHE+nsHt6uOn6QiSH3jy/Lh5rIx7spTISagLieIeTIYfrdA9ylQwoi+1kVGI
         j3lBk+I4slHFsOf+ubh98YSwOTfMAItLuzUkMHw/AfUyMAZQna3ZD853zVJohRfi9QNJ
         iXcbs6PdGD+8jk807eNV5xDSVsDfKY+qJiyB6wa4duca+alQ4EL91PTbC1CuBgffrzmY
         SAG55GjeCC5WAE5RLGnmXlPkL5J0iQ5RzfESjkGX5MAq0M1uP90tIMqQ2K02CRMff0Hw
         pqZXthy4g6TcGDvxOcNd0YMBL+GddOP7rjMXXGQLrIUHHwSoF9q1cjRP6DXBz2okTaii
         azsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782128119; x=1782732919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfpTR6WHQTIbLo2wLiDOzrvUHKrolPMkfX0MpSpIgJg=;
        b=eSMJKnW3XoOKyWwrahThcDiEdGLev/blYCFOo81VlxHHyRO2LJFDP2+r26hbNVhLZm
         mmhi31+XNvTwYhJeO7SVmXIP2kPdXJ9EwDjSoYeNC/A/MZMi5KBOTVyz8a1vzjyX25Ki
         MFc5GvcafQ586WD9/q7qO6or594JIl4kDEK1aILWy7uOrAfdwtOFKHRKOGWrMakjWd6Z
         GbpeDZatU/rH+JU8A1DV4NeFN22man4LTU2PH7d2CTHWksXYJMGjigutTguS0Qt/raIp
         vQQuJ+KATYWYlyG6anqjq54zue8iCDkN8FT5kru+ly8avcH6lB1oOhzFVN9QKDZMSZq5
         JPLw==
X-Gm-Message-State: AOJu0Yz0vQxQasyW/pk3DfjqXyfVt9sBrfmED0pjpS1uZ7uNxNQntAJg
	9Pl74qr5kPNIvIA90QGBXJ8kvHq5L7YVe6kga/lXvFIZqkS6oaajHvN1kOdOsYOCPwkIStCNc81
	Z25b/bbLrKv6754VWJwypuyQjTbEzJSlcjvuq
X-Gm-Gg: AfdE7cmxDKJN1l1UB4+VP4HM8WxphnuoX4ljOqIujcFrBBN+lrKKzL0WJLL5jirpOk/
	HlmY0SXdnTgYSM0/hwc1NtP/qDiKRQK4uSxSfAyz3Pijh2RUy7U2c5Gk01dbwptDWW0nTdqZdkU
	bWmB73k0a8f3pMr1TIfjzA7sPq+ALFPKRYESzGJ/OAkncMwgz63qf//+zMTP0+XSDJyrZgpf0zI
	EX6pHoNXQvOaMTTCefM6BSeOVH0o2b4d/r/pz53/9/xnFRx/qzGWTzhJ1Bg4GL94UZD+Tw=
X-Received: by 2002:a05:690e:4501:20b0:662:f28b:7c63 with SMTP id
 956f58d0204a3-6630372ba3amr7879820d50.63.1782128119210; Mon, 22 Jun 2026
 04:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Mon, 22 Jun 2026 17:05:06 +0530
X-Gm-Features: AVVi8Ceyqx6HaykfsByHlMl3bnuScmpiAE7_IpscBZhutxxJDdIAl3LJc8JWM_M
Message-ID: <CALE2CrTVVQF4rGhGG-9kmjweFHHYw+xnPU6Jtt=QmHpq7L6P2w@mail.gmail.com>
Subject: [RFC] clone: allow sparse-checkout paths to be specified during clone
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I had this idea after working on several monorepo-based projects on
Github where I only needed to work with certain parts of a repository
rather than the entire project.

Currently, the workflow for this is:

    git clone --sparse <repo>
    cd <repo>
    git sparse-checkout set <paths>

While this works as intended, it feels somewhat cumbersome, especially
for someone who is new to Git or not familiar with sparse-checkout
workflows.

Personally, I do not think of the problem as:
    "I need to initialize sparse-checkout and then configure pathspecs."

Instead, I usually think:
    "I only want to clone these directories from the repository."

With that in mind, I was wondering if it would make sense to allow
sparse-checkout patterns to be specified directly during clone.

For example:
    git clone --only=3DREADME.md,frontend,tests/frontend <repo>

and optionally supporting exclusions as well:

    git clone \
        --only=3DREADME.md,frontend,tests \
        --except=3Dtests/backend \
        <repo>

Consider a repository structured like:

    monorepo/
    =E2=94=9C=E2=94=80=E2=94=80 README.md
    =E2=94=9C=E2=94=80=E2=94=80 frontend/
    =E2=94=9C=E2=94=80=E2=94=80 backend/
    =E2=94=94=E2=94=80=E2=94=80 tests/
            =E2=94=9C=E2=94=80=E2=94=80 backend/
            =E2=94=94=E2=94=80=E2=94=80 frontend/

Using the command above would result in only:

    README.md
    frontend/
    tests/
    =E2=94=94=E2=94=80=E2=94=80 frontend/

being checked out.

An alternative interface could be allowing repeated options:

    git clone \
        --only=3Dfrontend \
        --only=3Dtests \
        --only=3DREADME.md \
        --except=3Dtests/backend \
        <repo>

but personally I find the comma-separated form easier to type and read
for common monorepo use cases.

The exact option names are only a suggestion; the primary goal is to
allow sparse-checkout paths to be specified directly during clone.

My intention is not to replace sparse-checkout. Internally, this would
simply initialize sparse-checkout during clone and then continue using
the existing sparse-checkout machinery as usual.

For implementation, my initial thought was to extend option parsing in
"builtin/clone.c" to accept "--only" and "--except", split
comma-separated values into individual pathspecs, automatically enable
sparse mode, and then invoke the existing sparse-checkout logic with
the resulting patterns.

Conceptually, this would be equivalent to performing:

    git sparse-checkout set <pathspecs>

automatically as part of the clone process.

I would love to hear your thoughts on whether this sounds useful,
whether the proposed interface makes sense, and if there are any
concerns or alternative approaches I should consider.

Thanks,
Pushkar
