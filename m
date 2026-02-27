Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3F345CCE
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218821; cv=pass; b=n7XldjTTBixOq0ulbjqDMUTIYEhSqEMHV7R8qvZ2vs2MuwJAhUExqpLHGdEd5hhty3jwj22WkhRvbEgbF/F3fBfF/63lt6VKWXSWBRyyd1z9Upb+wmbqzIDfh1yH+2kiWuIIR7qX+8yJwx4eUU2Q3oolYgQPRnSjI/mc+7GKKqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218821; c=relaxed/simple;
	bh=AimTi2KU9CB3UtDnG38CeXD7Y3vvprimtRtGTL9iHo8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Cx2GXW98+4aPpqS0uClnVbPjLiU9qqNa+rUq9ORYKdJ+ddonpbZrbW+6pD4c8XolqbIQek9pP91cW3cMG/O2u02taeQW0OORh7aqH6PCZt/WhnRlri5cWld1hgjbKhLA9xyc56b4hGkZWmlkktWZPkkaW5sMAn0Kw/VPxzc0o0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=anthropic.com; spf=pass smtp.mailfrom=anthropic.com; dkim=pass (2048-bit key) header.d=anthropic.com header.i=@anthropic.com header.b=FhKBcjHk; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=anthropic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anthropic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anthropic.com header.i=@anthropic.com header.b="FhKBcjHk"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a019a7f3so29229951cf.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:00:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772218819; cv=none;
        d=google.com; s=arc-20240605;
        b=IYMaktO3D2GmwbpRd8xL94vUmVIWJsr2RzGoFnmLA9W2bfEbWiJjI6/UgSOew5bKwz
         3hrPl2KFQ1rNPI4fLMdWzdxP2JvHGyWPX7pM+OqB0sYLOzwIZgzznx21vXXm6xeHlTjw
         7P/C/f8mO/LeTafshAkxmiMhokeTvmXI2CYjBukIg3SAdm0XS683GU9YUfa1+kz3miWz
         OEXFeFKLrzodhtnKO4tn8BDpMHi4FckXZf4bGNjkZZQL16gMIjFCbGDQl/646F6GX33E
         6YFZcsOfKvqb+utzlCck/rqC4PvlBqsbHVZsYJstDU8RvhHa9gIlZ5jVaofKkbzFUVhj
         vP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=fPQOMCeV2MJzFtm08Jtst3YMULtwpnujywueAJYjUiw=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=bkArwiZewYELUlgzp+sOiIxJMA9vsfrDEFphNJOdFAoV1ekS46Zm3UIXMVALnvlbn2
         XdjQd3BaUcpvwKuNyCia9WuWmE8ifT10mgKga3L2ykYEfzAnXR9qMtYrmAGn2B4dJpzn
         Xsx+pysfyE4IVR+FLxS7519In6kKwv72hK7Hn+MqbLBJzruuvzC0GRs2Ygk1gcZ49LxX
         hv/ourGxuzrNVnbz2wyQEDPo5kRX/BqbYmBU0Divwnx9IIHgqi8WqMccGPgUBOApW1f+
         Jrez4gcVltMOvN0SnU4zWZk48qP7fxGBsBXfxh8sJ091lBK9MOKsQGkqYvMIZNmGSKr+
         6CAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anthropic.com; s=google; t=1772218819; x=1772823619; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fPQOMCeV2MJzFtm08Jtst3YMULtwpnujywueAJYjUiw=;
        b=FhKBcjHkxRBVQloUv84j2vhiCIN+uYnm75y4okDkba2xoXB55FECVZECnqE42jGjrm
         8FZOqfglcJUdKPgQGX9f50/wgcqr9Xo1dBRLzvVDMmRLWRScIO3b5HqZ2PiGFeKNyhnL
         /bgICWDhbIdHB3IwcPJu8ZQ9+8qAm2woxZgNpDGxsZnQr262PkzzfOv1M6xowFaRqcco
         pRC8z4hLUXxT8Dxuhqwxz1VmajvCm8zh1Z45JSqC7K5eooXPCzHQUSN6PwS5d8oH2uex
         UnawsRbVeNqm+IwKADqjJ9Nk3NkfgomHU2jeKTd6/bI4eF7JPCULzpt86GejdwktiV+h
         jYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772218819; x=1772823619;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPQOMCeV2MJzFtm08Jtst3YMULtwpnujywueAJYjUiw=;
        b=RmpHX97p7H4lmEO4SyoQ48Lu/bw8FjLWzHQLtC3kye91Q4o9X3vsafg2iGc2MmCLvX
         44mIeDdkPvTyvHcuYt0EXFeA7v6bB6lM46B6kdRTNQwNdNhfLW9JwWoI8umDaHVso9oA
         FiKHnSWXtuXZtyRd3RFphnPzTMgLKTEklee8xpxls2NxasVYglKZt3Ic+WTQL7joN5wN
         7jzqDHuhcZrmFpXUYSKweUErWEqi1kRbbL2yLSKv5dyAg/R6FI6n5CKhlDH1Et1NIKhS
         5kg/kAro3ryLkd93XIhU3YxULC7cwtY3sWrJBwWgXdAzzMj6YcDPZFNqFpjHdiwOXXac
         aOew==
X-Gm-Message-State: AOJu0YxUgiCw2luHD/O5eL26A4a7LgCXKz91Si5kTuDzqJ3+rvUnXAkr
	N1VWte+WtrAEzQ4xbeiLnorLEEGkxga4AT9T+pR4ruDaIH7yZ0lTUfVhJqLfilkd+CeyDMNVB9X
	ac8LuQlzXAflxMNMFeWQNB3e4gqytJvXi88DCyGSJ4oWSlYexzJgBxqDzHw==
X-Gm-Gg: ATEYQzzFD/Xmef+m9mdfFbQ93aojs0J5EXeLnbPoxXw7qEkHkJWdWgfzMNw8A3fnrxL
	mQ2LSYF3C04qvD5FkywCxlYJXUHCNpOM/x0/ySHmga4jwsc3Zc+aISgJM+p1wNw4yCasJX0EmwI
	rDHlulC4rU5Wi/KBa2+TPxQa9+nB+7I3Zk0mfxgMC8mlqzjSSb/JwAp9Dp4k1X3UvbfStVO/Ggq
	S07vGCxL1G3duRzodLE/q0yw8S7VMrjaDBPxXerS4fUkWw4zTGTYIi58AIGDepOUQnaBEj6bCG/
	+kN9UkMjYU2oUMPPc5mt6932Si3OUnXSmvbWFr8=
X-Received: by 2002:ac8:5891:0:b0:4f1:d85c:d7c3 with SMTP id
 d75a77b69052e-507529161e2mr45264111cf.66.1772218818223; Fri, 27 Feb 2026
 11:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nick Gavalas <njg@anthropic.com>
Date: Fri, 27 Feb 2026 13:00:07 -0600
X-Gm-Features: AaiRm52YYDGipxkrGc5AVzL_cX9waYob5lpxea5KgZAlWpfb1S0ZD-4lHv67_V0
Message-ID: <CAHPsMLNvvneszHtBfHwuADss=_rtbi3jYkXd8gYFrxSs8A1X-Q@mail.gmail.com>
Subject: bug: fetch --shallow-since can produce .git/shallow entries with no
 backing objects
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm not sure if this is a bug or if I'm misunderstanding the intended
semantics of `--shallow-since`, but I'm seeing behavior that surprised me
and I'd appreciate another pair of eyes on it.

When fetching with `--shallow-since` into an empty repository, I can end up
with entries in `.git/shallow` that point to commit objects which were
never sent in the pack. The resulting repo looks healthy for read-only
operations, but a later attempt to deepen the clone fails with a confusing
error.

Here's a minimal reproducer:

    git init --bare server.git
    git clone server.git work
    (
        cd work
        GIT_COMMITTER_DATE=3D"100000000 +0000" git commit --allow-empty -m =
V
        V=3D$(git rev-parse HEAD)
        GIT_COMMITTER_DATE=3D"200000000 +0000" git commit --allow-empty -m =
T
        GIT_COMMITTER_DATE=3D"300000000 +0000" git commit --allow-empty -m =
S
        git checkout -b feature "$V"
        GIT_COMMITTER_DATE=3D"100000001 +0000" git commit --allow-empty -m =
Fold
        git checkout -
        GIT_COMMITTER_DATE=3D"400000000 +0000" git merge --no-ff -m M featu=
re
        GIT_COMMITTER_DATE=3D"500000000 +0000" git commit --allow-empty -m =
want
        git push origin HEAD
    )

    git init --bare client
    git -C client fetch --shallow-since=3D"150000000 +0000" \
        "file://$PWD/server.git" main

    # Check each shallow entry actually exists
    while read oid; do
        git -C client cat-file -e "$oid" \
            && echo "$oid OK" \
            || echo "$oid MISSING"
    done < client/shallow

On my machine (git 2.51.0, and also against recent `next`) this prints:

    79f92113... OK
    bc6015ef... MISSING

The history looks like this (newest at top):

    want     (time=3D500M)
      |
      M      (time=3D400M, merge)
     / \
   Fold  S   (time=3D100M+1 / time=3D300M)
     \   |
      \  T   (time=3D200M)
       \ |
        V    (time=3D100M)

With `--shallow-since=3D150M`, I'd naively expect the cutoff to exclude `V`
and `Fold`, so the shallow boundary would be whichever commits have those
as parents. The server does seem to compute both `M` (parent `Fold` is too
old) and `T` (parent `V` is too old) as boundaries =E2=80=94 both show up i=
n
`.git/shallow`.

But the pack only contains `want` and `M`. My guess is that once `M` is
treated as a graft point (no parents), the path `M -> S -> T` disappears,
so `T` never gets enumerated for the pack =E2=80=94 but it was already prom=
ised
to the client as a shallow boundary.

I noticed the same thing with `--shallow-exclude=3Dfeature`, which I think
goes through the same codepath. `--depth=3DN` doesn't exhibit this.

The repo looks healthy for read-only operations, and a plain incremental
fetch against the same server also works (the server has the object, so it
just silently ignores the shallow line). But if you then try to *deepen* th=
e
clone, the server sends back `unshallow <T>` and the client dies:

    # after the reproducer above
    git -C client fetch --shallow-since=3D"100000000 +0000" \
        "file://$PWD/server.git" main
    # -> fatal: error in object: unshallow bc6015ef...

I believe this is fetch-pack.c:receive_shallow_info hitting parse_object()
on an object the client never actually received.

Is there an invariant here that I'm missing? Should `.git/shallow` always
point at objects the client actually has, or is the client expected to
tolerate missing shallow objects?

Happy to provide more detail or a larger real-world reproducer if helpful =
=E2=80=94
I originally hit this on a repo with heavy merge-queue history where about
a third of the shallow entries were missing.

Thanks,
Nick
