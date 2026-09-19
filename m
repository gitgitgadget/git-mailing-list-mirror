Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F7267B89
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789824839; cv=pass; b=Sn+G2I76HVgnSvw1ZU/PIrlg3pe3RpQwwpHXJVtTYIpLLjqJleHvDudnUK/ZR3qQ3sIM2guwyejGUap4e0TywDL37W7kP717UiX41AfDdaEkxt5f7wtzvO4OfJfvOEKGyelSuHtK9els+vN4oRAHS33Z3xDk17kladvX6nE3ciY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789824839; c=relaxed/simple;
	bh=/d0TEAWb8+w74/PRRyhBwLBAOOkGSW1FLDO7lnTH0lU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GezkWdAB5vS1GpE8gqJ7gij+ki3aBcawjgqtmgrfsMa0Ku03eIf1fwXOxwCjX5VX516RSHbkpk6KXF2C5r/VrEWpQhG/Cl1NQT4SGf8wCEk2xGOVRyswnugJsLH+UUO6BzGe6yl+JZU69x5rLXAIDn/AGaP6y5HBDSKth9ezjEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7557Hlm; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7557Hlm"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a58fef219fso6441471fa.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 06:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789824835; cv=none;
        d=google.com; s=arc-20260327;
        b=hsUleWH0+VK1/oUWtzxhHC3UEnKQfBINCbfQhfe0nUW9WGRA05ILnk0paJFdmZAIJz
         t/qK4g+e0N7O3ZXWCoE4mtm0RhtwI4t8RNGtqpB3DbbK4tsr+dHH5uzz8G5O+P4L9MeH
         N3B1dVCw1lOCuKAbwdd7F6+RijUaKKtLbtNW8DedPzH4oiMBrvTWZhD7f6FIr+3/k/Cl
         NBqdFO4+zgUy1YHNkbL66zeV9vSS512VLtMz0iRvF/vLe7QVHjM6D4mVlSQWwtFMcH6E
         rGsxpP11M4xcvF/VgOJ5WqYA8SbYXxILL+R7Zcz6PsXhagEBlTK93vzTJ7Xxqt23rzXR
         gMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=5LEj1PTa0KS1INDtwYCXbdUTDPYUpXbXmygwQBEUvTw=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=CjNudxflM0EC+jTEbJ7j7xzHuJq9ZUGrCcDi0iPU6eMBBKv/yZBc4/igIV7WFCTFUd
         eR6Kf//tBXzuARA0rH7btRZD2HEui7vW+dEucXVJXOLokJv/w5/v7xWVOCfQxSja2+8V
         K+3Xnb9vRft8kVyQikYZ8Bv7mrlVGGZOx2Fohl1l7wtuSxjh+Lu7nMETBau7peRGdN54
         ad/o1yjZWPOT7YELQy2DJ8CL8+Poxutwg+elY+ka5HXtNlIxyye9CmH2Nurug5v/nv5o
         nHF8xdON1nHVKYBH69XnVpzMHD1gSgCpzd+SKt85E7KO0nWQgxhZHSeV3frS1C5pU+HQ
         vuZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789824835; x=1790429635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5LEj1PTa0KS1INDtwYCXbdUTDPYUpXbXmygwQBEUvTw=;
        b=V7557HlmjhsvnmeH0x/WBvvvikTG3aXz+jCVIOibbO2WlPGhssnVD6EaLKQ5h0oAZc
         pW2imtbVSjP0gBmJ2N5ag//eQMJ3OK4eF/vaR5C76h0LEhOAD1l39HVPTOvbb3+DLmto
         9rjF2npPNqDNCo1hAf2LpL3izoFJzqUc0BRIlqa/soRh6G6px3WfhvgyPey2pQH1866R
         LyYSw0xL+RlGdNXA17tBIxoZVEx8cS5S3EZlObyie2Ltm9AoyFOP8e8Ksy1t/uCxlx85
         MLLVwzX9Bs1R3hjwpzf1NK34pvqqsGgtjKgsUMzKVC8RiMhO4mtL435BlLIRAmnESGUM
         +6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789824835; x=1790429635;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5LEj1PTa0KS1INDtwYCXbdUTDPYUpXbXmygwQBEUvTw=;
        b=dfFPIxzHHS5NcK3PFram6XTtnwDqu+Ac3xkZJ+uHsT8EBulayIXqGt09JbQaR6YNZN
         X91uz2v+N3OpZGDHBV+OlSB1CmI0v407K5tcj5rAI36yZm6+J0aFtrvWueUEjToOW5ro
         i82piYsCtmRfhZvSerG4Vt8F9VK/tI5AysvFHxCO+oAodein49UlluUfsoympzsluibM
         OwKLBOpPJt6Dy6w3EJebsK9F3O4S8Ux8LUmsypCX8O/hsj0X30rdSE0vAgAG9y5PywVW
         EsMc2NEo8Bbyk7Pl2M3jn1z8YouLa8maNZBsMu2BqxGuloCUJ4enH44mlLCs/0rX4R2n
         y4cg==
X-Gm-Message-State: AFuF++nPHH0JJTj8m9+O8RxO3JpyVdQYzpHqhZPVeGxa+tdthn0HUa21
	UQHc3pQbMtqkJ6rXe/SRXPKYxXE4vpnJdbcKYHly1XNxpJnulVn7/5xcy1fTIj6ohlZusJMjxQF
	JWFWLDtTwTpJBqftZWjEYxqB2pJ/5Zt6tx18g
X-Gm-Gg: AYBFou3IMbqZEi+iLn6GH0YqOicmArJ0JCZupJmOgOqx6/Y++zXGfgquP7FFLAIIDrH
	Ti/HqgM+auldz+d+VObAphuJfAJf8Nnjt1au1ZoBTtjLbBQOwMYTc/FOXeBahJFkpfOoDMZv1xH
	yHhOVgCQnGn9i/Ws4NZNj5I9l8AHH4FDgoEh3LPw9bwy2scWza5aAONSP5AjCrGTqnUVkRcF0eR
	0pIcKBASe3dJkmJwlXOPPX0ZGys3bXn8LEf4VYrmqe6546qyXJev1W4hur6DG25bKzJaxcxJExx
	c0IzvzkGUCvmNg3KxTs/VoIPZytSrmTvJIuUX0jDzdZTen/Ft8IaN2j0/FB1BrD/IhKWiVsvHxK
	cu/OoKziBXBUA8RLmDWwYV0m04NozjF4vUwQ7r4Bl8bYvFmFUEDEmDPOdoOJ/Kda7dgVNEMr0XQ
	==
X-Received: by 2002:a2e:bc17:0:b0:3a1:fa0f:5d21 with SMTP id
 38308e7fff4ca-3a5fb15b8admr10951531fa.3.1789824835433; Sat, 19 Sep 2026
 06:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Sat, 19 Sep 2026 15:33:44 +0200
X-Gm-Features: AcwNN1V6zxXU112hq7YxLftMII28K4nVo1PYkvsCTwjn2Z12kvS7KOsyCsFz-bI
Message-ID: <CACQ=SRHCOCcmVCgHqd+sjMsZ9LCdSHuXdCo0gkwxXwYgF7iwig@mail.gmail.com>
Subject: [BUG] reference-transaction hook misses destination of git branch -m
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

`git branch -m old new` changes refs/heads/old into refs/heads/new,
but the reference-transaction hook does not report both ref changes.

Observed with Git 2.55:

* files backend: the hook reports deletion of refs/heads/old, but
  does not report creation of refs/heads/new;
* reftable backend: the hook reports no usable rename payload.

The equivalent atomic operation performed with `git update-ref --stdin`
reports both updates correctly.

I expected the transaction to include:

    <oid> <zero> refs/heads/old
    <zero> <oid> refs/heads/new

Minimal reproducer:

    #!/bin/sh
    set -eu

    format=3D${1:-files}
    root=3D$(mktemp -d)
    trap 'rm -rf "$root"' EXIT

    repo=3D$root/repo
    hooks=3D$root/hooks
    log=3D$root/transactions

    git init -q --ref-format=3D"$format" "$repo"
    git -C "$repo" config user.name Reproducer
    git -C "$repo" config user.email repro@example.com
    git -C "$repo" commit --allow-empty -qm initial
    git -C "$repo" branch old

    mkdir "$hooks"
    cat >"$hooks/reference-transaction" <<'HOOK'
    #!/bin/sh
    printf '%s\n' "--- $1" >>"$HOOK_LOG"
    cat >>"$HOOK_LOG"
    HOOK
    chmod +x "$hooks/reference-transaction"

    git -C "$repo" config core.hooksPath "$hooks"
    export HOOK_LOG=3D$log
    : >"$log"

    git -C "$repo" branch -m old new
    cat "$log"

The behavior was also tested across Git 2.28=E2=80=932.55:
https://github.com/ciembor/git-hooks-ext/blob/v0.2.0/tests/compat/README.md

The reference-transaction documentation says that the hook is invoked by
Git commands performing reference updates. A branch rename changes two refs=
,
but the destination update is not visible to the hook.

Thanks,
Maciej Ciemborowicz
