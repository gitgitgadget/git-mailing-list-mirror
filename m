Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792864807;
	b=AYMv8+8PwLZ/YN2BO9Nq2BcNTdnclWwtYMZNksBAslS/KlYXqtKIGFi1QTIZjfwU0Y8T
	 2H0J8EmeiPEHowJA5HFSmCvSRzr5XBR+h0rPSpxshkLmGvaBKqhZ/9flU4i06hbWjbWIH
	 i3VTNJf1AoTiZ5U73NBO4VVDI/zcxqOjYS4H9C9KKda0YZOqRS8sQGRoFCSFb5ktrWDqH
	 Eh6f5KFE1lNBEtjMfSFlVXfavAmuFUVUXkUsOqf5wGJ1RcQkg5zH/HLL/vSBDoukgheSo
	 7MfaciYZ74dtnNM0lAo3UFsx321GAg4sQrwWIF8m0YYZYGzN5rjpnYnUkq2oQAZ0gbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792864807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=J8iOlQi17M9tA0T5H8J7DqBCzrLXFkxVTEb9MEXRt/c=;
	b=1yJ6qK9LtFWi8mM3JXD+k2JadLnakFrUh7zQIefnRriTUDfCslUFrYXHHAPLGseRLaF/
	 3sxIVkguYqjk3cC6ffNCJ360HkFNYYlJuU2M4WlWSB0zQ4TPkMgDu8N+EkdNBD84kcauZ
	 1MtAjh51wEfDg0YYLWxMbphHMvtKI9VagI5Mt3yHYYIzWNvPRn1ShFP64K9fJkFyr3sHE
	 8AvVQ3EDj1ZhEUZSgiKUsUo4Xk7JpEWZGavXNN6gA4qA+LELYYKLN526afYQr+6AdYlLn
	 qXMgvSDY72DsoV9qarFaZHmuD15dajskiIkNGHEWOCiWS17qxenZOYzLZAgYVmVORYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=latchkey.dev;
	spf=pass smtp.mailfrom=latchkey.dev;
	dkim=pass header.d=latchkey.dev header.i=@latchkey.dev header.a=rsa-sha256 header.s=google header.b=UNRgFep9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1270606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 18:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1270606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=latchkey.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=latchkey.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=latchkey.dev header.i=@latchkey.dev header.a=rsa-sha256 header.s=google header.b=UNRgFep9
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4c3bb46aaf0so659301b6e.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 11:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792864806; cv=none;
        d=google.com; s=arc-20260327;
        b=ZJ5nOgs6WFxhEhbyPpErym+iuAE0wCCwDtta9MNojYAmEthH7gIPxjk5Lc7ipAy+K1
         E+zLIWX0slER/8VSOBmAMnJZM29atP46dO5hE8TlmUz5iDtA78vGB2zGKEZS59oMm5jY
         K0izRlhvMQPYfT3GKsaoEeRnuyii2/oBXvie3WqRIy9ZVBnhkIrY8u8EqExRuGGV3Ewf
         otjGZkMWK/p3RujLd2cDdJL7Fab0GqMurNZo9ADtdnXHmjG9iLW53vrXCQnxVDDrYwQY
         PWHcGD4GcOwiugnstm7iPRnCxMYsdB/SjM07yQxInKUAeQUi+MYMU9bbQDypXln4tejW
         BH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=J8iOlQi17M9tA0T5H8J7DqBCzrLXFkxVTEb9MEXRt/c=;
        fh=IlMV9CQq8DWBqhDig09zJ3PiWmDt6zcudgxfCnKlaR0=;
        b=kH8Z/FEDeA/bN+6akG3OZIBNFHAXzktozr7S0+/XW8idpo9ddo4bcIoKTF94pX5XVZ
         Bp+rfJg7IQ+mC3ykTGcQGgxGOpkZY1VFu2XqERqKy8xRZ5DQhXnyOX8bu4+fRZf6jWpC
         ob+Vq/EoLCs2ZDb+jWM5dUNCPGkm83/FM2m8o1tExkLf4+DTQEL78mkwIS43KQX0LIyP
         xAxqBGjPH6SlRLLdU1tlkj1BWybaWrJDTpK3G2Ke17gKxbIXfDqf892mpbeScKOUUX/O
         3KpGfxSCgxijHrh7Wip0v+WCoB69WQ46ZVR/xfszQTz/3hJGjVCDB5MFuvm5LWMhKMrf
         QFog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=latchkey.dev; s=google; t=1792864806; x=1793469606; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J8iOlQi17M9tA0T5H8J7DqBCzrLXFkxVTEb9MEXRt/c=;
        b=UNRgFep96KePtRfL8wYyT3XgVaoh0/4W0MpvDK8an71BoEQJjyxnSM61zYbS1eeWpA
         8orwS5rVC5WxggqEROw3PgypbT0+mZX6SxN5ci2UkcqfI/G2N1xpkZzpi13ZRdavGRR4
         ioDIdZkOlxaokMykjItIYJ86tNRJpXfEZb55ryk44/mCx2Ky5NsnE3z4f2omCeDKh1C6
         jBU69cozqUFbnZvqEO5Nyr9PFeB+IvLvvOfffD7uxOw68kH41vUJJg89JG378ATWAu32
         +wGeszq0ToFyKaifaZhcNtAzjDOpxJq9wYcgbBqu38WOfySIn0qHCltcodYjYVHxdQrS
         oiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792864806; x=1793469606;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J8iOlQi17M9tA0T5H8J7DqBCzrLXFkxVTEb9MEXRt/c=;
        b=zyruE6J6EJAjURkGphJQNInpUUQ6DeU50FDhhSO+QOi3saOtb/QcJ7ZyX5lePKR4rH
         NMCMEm6UJOiDc4CXryLOrNs3g5dq8MUEPPsQEq+698IQymPyENnqbmCqADjhs+a7Oam9
         xYZWiOgpqr3UKXfeu98ARN5Xi8nRAbVu2AlH5Fkhf8vKA7Ww9NrlGpcGA2X/jlTRb2Pn
         wT1JGWV2nA6IWhqN3zaiTt5OR80f/Mpy1YZaoY7fjiEWt/TWp27qlirgBFX3NEKHPHTT
         bg2FX0HENpOturm1/YJzGxTIlQTs/ibSchOG95/CvU7BmP2ZZ6bhfLd1mJRAi6mli1Kw
         cBiw==
X-Gm-Message-State: AFq9FYKtnw82w65P6bA9R5fLZH5+P+UhWXqJIoqHOuuExO8vFc2VudqP
	CwlAgPHnxfz1F8LTGyjQtimHNv1VaNaVyHiJoZI5DveyfmHhBAOydBscFwKYdXHYrVJOTaKyM/z
	IVmLe6o0WOrTK9rl+STyoFOYoKQX5jEsBP/N1YA6ScRk6v9jAQjWGxaL5fI/19kb9fw==
X-Gm-Gg: AYBFou2gml5CQv/yXV6gW3RVTavkpCKfhJ6s0WCRw+q51tgBGtoA1rrY1CUsRMr3kMe
	kS7zT4wTma3/sfNCbTwVd6DyXczMJ3IVOTd2TdZ1lzBlGPLJxlY6U/xoLAJfIlVYzKeJc1iRedj
	KZGGktEWDW3Q/XxT7A8kzxovF3AONv5/+jTjboUhLElecJtGdkwOmvMRZ50tmwAgD7Wkj3JeFlY
	ieGruSjlYqzdMIuCc7PRnVfrUVchHVxN19seCvEtqhvaUaCYJbI5yBGQbATVFw0Ol0NowQf7PAb
	Q6YOxHshXo2qa6/DnWKVlJ1IP2H7BnmRXnzRFdOLaMmtlGiRaGCBgy5L+oFS8pxDteGISCAWEra
	JSpC9fcCICU6Cpq+tKcsWpzl814zlp9tN
X-Received: by 2002:a05:6808:148c:b0:53a:b182:9999 with SMTP id
 5614622812f47-55c00263132mr1653434b6e.43.1792864805592; Sat, 24 Oct 2026
 11:00:05 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Daniel Zoghalchali <daniel@latchkey.dev>
Date: Sat, 24 Oct 2026 10:59:55 -0700
X-Gm-Features: AclHuK_0nUkMxeq0rOgN-ab9-Viz8aei56J3J4UimEmqzRwHtU-QYTfRwFUpSWM
Message-ID: <CAJwQ=KQynymg4CJOLkyebACYVQa+LhXB2UifniTASkLyArWejA@mail.gmail.com>
Subject: [BUG] 2.56.0: filtered --unshallow of a moved ref aborts in
 pack-objects (should_include_obj) via inherited GIT_SHALLOW_FILE
To: git@vger.kernel.org
Cc: ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Hi,

Since v2.56.0, a fetch that combines a tree filter with --unshallow
(or --deepen) aborts in a non-partial shallow clone when the fetched
ref has moved past the local tip:

  BUG: builtin/pack-objects.c:5098: should_include_obj should only be
called on existing objects
  error: pack-objects died of signal 6
  fatal: could not finish pack-objects to repack local links
  fatal: index-pack failed

v2.55.0 completes the same fetch. We hit it in CI, where a job checks
out a single commit at depth 1 and then unshallows its branch, which
by then has moved on.

Reproduction (offline, any Linux):

  set -e
  W=$(mktemp -d); cd "$W"
  git init -q -b dev seed
  for i in 1 2 3 4; do
    mkdir -p seed/src; echo "$i" > seed/src/f.txt
    git -C seed add -A
    git -C seed -c user.name=t -c user.email=t@t \
      commit -q -m "c$i"
  done
  git init -q --bare o.git
  git -C seed push -q "$W/o.git" dev
  git -C o.git config uploadpack.allowFilter true
  git -C o.git config uploadpack.allowAnySHA1InWant true
  git init -q co
  git -C co remote add origin "file://$W/o.git"
  TIP1=$(git -C seed rev-parse dev~1)
  git -C co fetch -q --no-tags --depth=1 origin \
    "+$TIP1:refs/remotes/origin/dev"
  git -C co checkout -q -B dev refs/remotes/origin/dev
  git -C co fetch --no-tags --filter=tree:0 --unshallow origin \
    +refs/heads/dev:refs/remotes/origin/dev

The last command dies as above with 2.56.0, both Ubuntu 24.04's
git-core PPA build (1:2.56.0-0ppa1~ubuntu24.04.2) and v2.56.0 built
from source. It succeeds with v2.55.0 built from source. With 2.56.0
it also succeeds when dev has not moved past the checkout, with
--filter=blob:none, or without a filter. --deepen=N with the same
filter aborts the same way.

What happens:
- fetch-pack runs "git --shallow-file '' index-pack --promisor ...".
- The pack names the local tip as the parent of the new dev commit, so
  index-pack's repack_local_links() starts "git pack-objects
  --exclude-promisor-objects-best-effort".
- Since d43b9acb05 (setup: unify setup of shallow file), --shallow-file
  is applied by exporting GIT_SHALLOW_FILE, so that grandchild inherits
  the empty shallow file.
- The grandchild no longer treats the local tip as a shallow boundary.
  It walks to the tip's parent, a promisor commit fetched without trees,
  and is_not_in_promisor_pack_obj() hits the BUG on that parent's
  missing root tree.
- Before d43b9acb05, the grandchild read $GIT_DIR/shallow and stopped at
  the tip.

To confirm this, we wrapped only the repack child. Unsetting
GIT_SHALLOW_FILE for it makes 2.56.0 pass, and setting
GIT_SHALLOW_FILE= for it makes 2.55.0 fail the same way, at its
builtin/pack-objects.c:5004.

Separately, the BUG() is reachable without the environment change. On
2.55.0, a filtered --unshallow of the local tip, followed by a
filtered fetch of a moved ref, also dies there, because the walk from
the local tip reaches promisor commits whose trees were never fetched.

Thanks,
Daniel Zoghalchali
