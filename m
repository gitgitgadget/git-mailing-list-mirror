Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB64267B89
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789824870; cv=pass; b=hm7nHs3w20bODQem2qmhvXOONbF8M2s0gJrKXJ6o5AMzDrkcsdD4DrIZqMhm1vbojYEyvOFHHEJKYhjg9Ba1taEp+z8t9BkoXJxskW3delqKMlWlW+kk17Y1tseWs3qgxLIUxh7UzNmpvxGAW4joncCyJH0esWoC5FWoL99AgV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789824870; c=relaxed/simple;
	bh=3xG6KJB53S/KkMfpt8x9h/GZtvE+jEd/DUoSl+phiUI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=i1aTYVhmOgnxm+3+uy/ihRn6NYALU7+5Gz0Ht/uwQkJc17+jZbWScT3dlo64vbAJRUAuEik91pg0m/NVivlU4QYjngiLONTztYbDksm007/zK7v1vWquFXWlwMw1VgtTwLIHmz29mlOTzhfS/ItIihIdCERgMUZyGfzzsi9dFA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oayvVRjv; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oayvVRjv"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a49c068e85so14362851fa.2
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 06:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789824867; cv=none;
        d=google.com; s=arc-20260327;
        b=cc1kGED/i1YnrWIfSUXQteZYkh3iKuUPWoYi36X1fJMmTY3goFjdDNaEd9IEzKxvvE
         eiMNqtImaJ16NmnuYHeLU/S77IiMMius7JI5fwPXbzaPXHcPCeNYzU7S/Afka/PvL/ba
         hXmjzi7Metph3ME7401qIquRvKb/jn7fAxKkDWFIXmNawZsve/A+51yp/kdPB+QWNj53
         223fqxhBLtq1oI52bp7AUFqHdrRmehyeoh+UeZ8sOhlW/8tc4/vQteI5hvRCp8P1WW1j
         pkALC5xQzGfLxAy+mLTSC08fnF0jpgPNfmkDXKarFj+nj2tzlAdesFtQOEEnbYkYKNg/
         IL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=nrdeuxn3tdsZANgZu1dloEPlA1J2XdwBligNzosRc4o=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=h+ZbZV0aC33Q1LMcBL+t1mQ/eJiOmmGnBbBdCEK6Te7EjLR0jvuAWJTIkHhy0KcEPB
         2bYxXxEDVClnlKsvU2GJCEONYtVS/1F93omTsUEqXyyoPQm4bkwdv8d+nHfCq7PEGeH+
         D4eXP2odvG6qut6NMqj/7DDKGhoC/SFi4N7mCwFWRzZL6g++xOu4vLXk0EHhrlD9NinO
         iexpEdgAf+/8f+L5Y1piH5e6ke3ax64BtEE0+OMVFgiiagVPoho63lR/as/Tq/RUgeHT
         VhaW8JZoLtVRtdS7URm5by8QEusHZCCZ5iXAzxz7zZVTk7I+KrvyyydJOAvVmyyEMYiS
         sYHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789824867; x=1790429667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nrdeuxn3tdsZANgZu1dloEPlA1J2XdwBligNzosRc4o=;
        b=oayvVRjvLGY4YPK1PzngcwzRfVTNCTgWu6dvqwM4DBFj3SelsHfvdKlGkSwHjiDigZ
         f5E6SwvLxpBAAM0Zo7Hq6pDl33Nih4rYDMwQedPp7HxDNEq5hvesbiej9ksonKPYTQwQ
         EkYQ2CHjkXHQEBSQCN0iyh5K3byVbTs9zBOBm8krRgMfZNKMRUa4F8Qp2GCrTTVFju88
         s8QDPJoWv4sNcTNe7BsQ9CAZxIXOivDmzKSdyvMId3plOkrWUkdMBB+AUPUnZXDehLkO
         xiPCux6KDiH7NEgIOol09Qo3PCjnYpvEmpmA1fWYckJYiz1P/Y1jUSTNLGv67LT6CGHu
         9EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789824867; x=1790429667;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nrdeuxn3tdsZANgZu1dloEPlA1J2XdwBligNzosRc4o=;
        b=oUw2BwFiTwCqqCAMXBhYukfEnWH7y+YNxQm6zTLOwjgTuehfa7MmZLfIgN6RzvRig7
         jetNUvjYtUhd0Iytyq0o+41NhLFxJphxK5p+FIIi354jhT8o7/wx7gmzV6a+LbuP4l9k
         6fJ7FgBQnsphgfM4Q8ROyGhGE1BbgZsYe6YitRaHm3p2QGRwCaTcp4YcbeJSag4thtyf
         SLc8zOJamNvgIVTBqSK3ynRPON0cF9YXTEw7ji90esHxie0IuI7+spCjbl9Wfx1c/9Gr
         aFTbIYVqSnkXHcgk4Zl8yJG0STdaPViQpGreE/tv8slvvbfq67Nci0jO50s1MtGAAEVV
         E+eA==
X-Gm-Message-State: AFuF++njKbGmTj3pOc/l4Wwl9Yhii8bF0VBPRO0/UB2KToIi2JyM/zuT
	5IXsJXBBxN8AMjK2oy0fvjreXL8f6cXNf3dnB6olm4Elxp0nmdNLamDopPdvnHN7A0HbZ3vYNW4
	2fZRL7tZMv5mRPmvSskWDaUr+PvWMYGbDk+KX
X-Gm-Gg: AYBFou35s/vHh48ISWoulEzufd5yaLC0XaVBJjJg2Fnf7UfHRM3AplX6vHMC7LHjVEw
	oYTEzyP+0s08N9D95MhE6LeRyMSdKwkaBpcy9TJZWYH3GKZblw1Lh3WjW1sJrtKxkKnJsR9aar2
	k0bAAYPwdKYFofFVw4T3bEqOajMwCtkZEHE4zBg2s8/C7VaS/BZwQP++wbp+pIOT/fLwKHcjoIA
	YMOwvKums4O2VK2tCTdVv96yF5I81M6AMRIrLMPVVCnlZM9VKkJkERTXVzXcgqj/xZhOTzqtUa7
	AJ2FI11g2NrHQcB1CcMTYYqgRxa4nTjkrzS2+tGf+uPlXrf0H/0E2gs0k51+ne6T6uVooOddB7H
	RL8yFZh96HgeRZW5MR+9ZmpIZgluc9s94XvFy8/i4LiSTUofuLX0bzuV2LSOh8g8G8a9BmWaeYQ
	==
X-Received: by 2002:a2e:bc02:0:b0:3a3:364:f797 with SMTP id
 38308e7fff4ca-3a5fbf024acmr11922871fa.8.1789824866575; Sat, 19 Sep 2026
 06:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Sat, 19 Sep 2026 15:34:15 +0200
X-Gm-Features: AcwNN1XzY9qohuEUAISb3TJ-NzvFhxKK-W6T8VWktnPqOxmTsP3Q8Px_QDR1Y80
Message-ID: <CACQ=SRGTTdQ+dHXhN6F52dBv5KxZBRfk_Em2fvmEmGJDoB6oTg@mail.gmail.com>
Subject: [BUG] reference-transaction reports zero OIDs for branch and tag deletion
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Since Git 2.31, the reference-transaction hook receives all-zero old and
new object IDs when a branch or tag is deleted with a high-level command.

For example, `git branch -d topic` produces:

    0000000000000000000000000000000000000000 \
    0000000000000000000000000000000000000000 \
    refs/heads/topic

The same happens with `git branch -D`, `git tag -d`, and deletion of a
remote-tracking ref by `git remote prune`.

Git 2.28 through 2.30 reported the previous object ID followed by the
all-zero object ID. Starting with Git 2.31, that information is lost.
The behavior is still present in Git 2.55 with both the files and
reftable backends.

A direct deletion with:

    git update-ref -d refs/heads/topic "$old_oid"

continues to report the useful payload:

    <old-oid> 0000000000000000000000000000000000000000 refs/heads/topic

Minimal reproducer:

    #!/bin/sh
    set -eu

    root=3D$(mktemp -d)
    trap 'rm -rf "$root"' EXIT

    repo=3D$root/repo
    hooks=3D$root/hooks
    log=3D$root/transactions

    git init -q "$repo"
    git -C "$repo" config user.name Reproducer
    git -C "$repo" config user.email repro@example.com
    git -C "$repo" commit --allow-empty -qm initial

    git -C "$repo" branch topic
    git -C "$repo" tag v1

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

    git -C "$repo" branch -d topic
    git -C "$repo" tag -d v1

    cat "$log"

Actual output for the committed transactions is equivalent to:

    0000000000000000000000000000000000000000 \
    0000000000000000000000000000000000000000 \
    refs/heads/topic
    0000000000000000000000000000000000000000 \
    0000000000000000000000000000000000000000 \
    refs/tags/v1

I expected:

    <old-oid> 0000000000000000000000000000000000000000 refs/heads/topic
    <old-oid> 0000000000000000000000000000000000000000 refs/tags/v1

I understand that the reference-transaction documentation permits an
all-zero old value when a ref is force-updated without checking its
current value. However, `git branch -d` is a safety-checked deletion,
Git has already resolved the branch being deleted, and Git 2.28=E2=80=932.3=
0
provided its old object ID.

Was this loss of information intentional? If not, could the previous
object ID be restored for these deletion paths? If it is intentional,
the documentation may need to clarify that high-level deletion commands
can provide a zero-to-zero record.

The behavior was tested across Git 2.28=E2=80=932.55. The compatibility res=
ults
and test implementation are available here:

https://github.com/ciembor/git-hooks-ext/blob/v0.2.0/tests/compat/README.md
https://github.com/ciembor/git-hooks-ext/blob/v0.2.0/tests/compat/e2e.sh

Thanks,
Maciej Ciemborowicz
