Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC1566C49
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096056; cv=pass; b=ArMQ6zL6xd1lHMz/P/8NHICAXEM354YNJE4kH57pHxa1UlO+ZUJCV4w1SYq3OAn2QTLWYQKAodjR3aOz2SHbiO0Yk+MQvN7ulDIf3sNhijIMNHvr4wKXd19VwXsPuu78aK8XoqOtoAxLtAXt+9CZLRwa6lBo9cY+mBWJb5Ai6ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096056; c=relaxed/simple;
	bh=Ank4Bl8S/MV67bxhgPNvpD61BhDACdEdxnMOouyq8tY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=skhty7JgdaJ/ukjlUi3uIQ39EyUpBA6aFje0nZ4xt3I7bCzqZ45kMg4le86PasRBQfSSeXTq0vOe0FV+UV6eZkkjeWw9Crqof14FTh9nLH8qed5aV9eGGqVGdEslcluv+gNaxOl7tvdeAbYkDLcJWpt/Dbndv5l5Uf3GeHcFnhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYTPlj0c; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYTPlj0c"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff148dfdso29401fa.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 09:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790096053; cv=none;
        d=google.com; s=arc-20260327;
        b=jfFE8PA+eoNSSm3xeJKoTzBaINW5csFA6Q0IqOgi2C3gkjixIS/dZ1yHIJTASIJA0S
         FE1NY5ITxyHeshoowTC8i8WaYjxuJawvFhrxCgQRE5cKvhWznv1GzqJgUAutZpQz0WyS
         rIqxLlRcuYAwP6aEOD/w+kpiOzchn7BNVUX40Y1K7Qh3F3UwmVJpBc9z7wVxT7unE+qR
         DCJGa/4nbI5CrsbWHNnZ2iCXMPxGfTuNjnv/VNTf4fokBBtVvv4JHMntIMacplWROxFN
         zb/xhnOcAs/EMtMM9XJhWX2l9WibWBWfTkJ6pUDCsW2wiixJrZEW11WdvVE/hoSnJzrI
         kyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=Ank4Bl8S/MV67bxhgPNvpD61BhDACdEdxnMOouyq8tY=;
        fh=KkvO+ySLzeJ/VR6kXLCkmdOWHvH55t2VxhB4rxnp/q4=;
        b=ooueqHtyxF8I59izLKzYAXJpVDe4cQXZl1y3unl/AfwDXu8Rw3DKSy78cgEWIbpsn1
         YkOzzTVrUqW2tODRSMlmwdkElhjXJ5NBBgyqZYTaVUGfLirHs6yHJsIUfuli/8jBGB3j
         MCsB2tn5gbbeujcXDTrdLvFqTbBpMzHeUGbCA3yDH9801oPa9lZqtgYXZ8E0T6spVg3e
         560qXbFo7Tt9eV05hBunavxYOoiUEHerkArW8pBq3yU0/4OfRfssDoboX7pLCBW0Nbq5
         iYarHafybyH7wy/WVeswWaWRB9qg3g3UTfoMU85eMbGEFbo4VZJJ4bjhBQ7rUJnMw5aF
         QrJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790096053; x=1790700853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ank4Bl8S/MV67bxhgPNvpD61BhDACdEdxnMOouyq8tY=;
        b=dYTPlj0cBV3FQ65AnYYIMSajbzjoOmk3N8dmgomCl4iQFxMqiUf8hvwarTgczbvRtK
         yM5fWPwdvuvvOXPjIIAObI/Q+9ZiRPz4t8E1D3pF350PI7zQshb/XiPYsW9RqMZ8fnUF
         t31OYfxaNNzxLqohmYn1iHXq01R6HlbGhOSAud5DKyHlVf/ODz3dluyI/QYSO78YwZZW
         AFjbVUUdohpV9fCxN9+ocvpzT//KZrbOYkkAvfMR1yjNW/HoVK5kpGoszSbOeuuwGyj9
         KUyF3GgVLuapwwtnATUoLZZEXv5Rn3ejh+9lM3ytDeVtkLv89vZI1bX5GR1QDvxkoAHg
         4F5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790096053; x=1790700853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ank4Bl8S/MV67bxhgPNvpD61BhDACdEdxnMOouyq8tY=;
        b=hyUEeQOI4qunvF3Ltmy8qc7hcdFe+r78uzyIjAYqcjGt+kvLSKr9o6ZXhyGV8NTHdg
         sVjoGSVw4ATeK9FOt9W8kqRj+RsRNuJqsSEyybiavJapE2fM/TWdQKLa98X58Rma1yM8
         o+zgkbecLiYs9VGxd2t+IsyyqB+NgyX/hjf9PCcCo2ZF01DWEzB9I3XrwTcOiGTHWRV8
         q3EyfwPx1PiRWivCd0N42pAzPdzFCSIZE1UMedC4Q9EjA+EPaUGGgTVBvV0F7hm7y828
         Lc+CsIiQXDowXk7PTsAj7NhgRNI07OrjcPXflXiVv1j5Kw88xDyXIp69+5f/DRQgn4IV
         1Eww==
X-Gm-Message-State: AFuF++ktg1gK8G7NCwD/1LY+iQZmqtOQgozoHK6laLaxfJoBiFsLBlwZ
	c3tOlXmwu9uYTEtBVPwDcKLrQFwOfB0yRS7EWe1XZhyvK0h6n+CNMikrUUaSzKfPlM68t0jRN6D
	wTG+XHC8prDapJq8WvNDCPGsMMcD5rxM=
X-Gm-Gg: AYBFou1CKhsxqBBkW4hKHNfEFRTewcqSe8uzwD2G+qH/AjRP5wzkFg87kEp13k1e/wz
	HypaNv/JEhUQ/tlofP3Vfp5QHKJYhmm6LcB0kbCOnQAMD1b+hsi96Fz9Lss7C5/Z5+nmmUZ016K
	fBcI/w9rVLtYqlhcNQE1vyKXi/P4s3SVxgRNxs0dDoPT69grEd5/gaZRqMu+zHO6gGg6mETI1DU
	Ay+YF6CZvLecgF5LaL75EeW0a1+Xy7adszR2AvwVqp7bxjJAgGPEiOj+hArGJAcX9FjzjHasAdt
	AUFZYgaFljAwsG9mAndqzZkhMLP59mFkmMg6AmOhTT9hXMbS84VaNVw=
X-Received: by 2002:a05:651c:a20b:10b0:3a1:1181:b2e with SMTP id
 38308e7fff4ca-3a5fbf067d4mr23183691fa.12.1790096052685; Tue, 22 Sep 2026
 09:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Micha=C5=82_Papis?= <mpapis@gmail.com>
Date: Tue, 22 Sep 2026 18:54:01 +0200
X-Gm-Features: AcwNN1VXl8JrnMFBOcAdP7nBvFp1F0LsVyClRfe1zFJ9WpZVLOjRqFIvRYU5TCY
Message-ID: <CAJtm2pzYE5bNbPMATXczCYCVRf3q1T=tyJ1asfSYk9widQmBvQ@mail.gmail.com>
Subject: Re: [RFC] worktree: add lifecycle hooks
To: maciej.ciemborowicz@gmail.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The important piece for your use case is the pre-worktree-remove hook,
not just post-operation hooks.

Post-hooks fire after the worktree is already gone. That's fine when a
tool's state lives entirely inside the worktree. It breaks when the
worktree points at state outside it =E2=80=94 a docker container, a databas=
e,
sockets, volumes. Then the worktree itself is the registry: its config
is the only mapping from worktree to external resources, and
pre-remove is the only moment that mapping is still readable. After
removal you're guessing =E2=80=94 hunting the disk for orphans, diffing
against remaining worktrees, turning deterministic teardown into
stale-data detection.

Real example: with AI-generated worktrees (one per task, created and
discarded faster than a human types), I was exhausting ~200GB of disk
every week and ended up writing cleanup scripts to reverse-engineer,
from what was left on disk, which containers and databases belonged to
deleted worktrees. A pre-remove hook runs the same teardown with the
config still present.

This is not about vetoing removal =E2=80=94 pre-remove needs no power to
countermand anything. It's about doing cleanup with full information
instead of reconstructing it afterward.

One limit, which is why post hooks still matter: pre-remove only
applies to git worktree remove. For manual deletion + git worktree
prune, the tree is already gone, so pre-remove can't see it. The two
are complementary.

Cheers / Pozdrawiam,
Michal

--
Michal Papis
phone. +48 603 751 266
