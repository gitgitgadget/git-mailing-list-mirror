Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14472E06D2
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985348; cv=none; b=m9yzVHx928tXpeVFxEh1LWxY3oeTB0HPpZtZJuJ3abXRPdp50JB1fGMw+7MrTKARN8U1W8KkCKscBexuDDO3ZdO8i59OBuJy9F2NMNnyX5F1KFFkdcTgrI8FRuOz1FT8u+s4xxtGERHTmx0Fy8VIPAxZ7MzlUb4F/4NF+whmV+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985348; c=relaxed/simple;
	bh=hYqcDJ4zw4hjQzcc/qEKSAWcFmvFSCfCvzGGojBziFY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UraExOPpx5PLM2/Xw3G8wGFuL7Vx3oDq/CdzzvknluqeoYTyWwN6azYpZmULOqFhsHDst67Kd7RMlqgeijyRqv9K99c22XG7cSavKjTx1ofQea3W3jXHepxaY9ZSdMbbvMoEqxrXUx3bSecv2KPKcxEdwUfc9R84NQ+2ZCPrDc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/Zis/i7; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/Zis/i7"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-88ba493e984so2617146241.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 00:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754985346; x=1755590146; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hYqcDJ4zw4hjQzcc/qEKSAWcFmvFSCfCvzGGojBziFY=;
        b=d/Zis/i73IzyZmXvjYwOpBPVWlkwe8zI8fVhgHitbI2FhkyM7yvlEzSUAYIMTpl6L+
         tm5padbMqPpJCScybBkbFprgLiiIpRU0c+oMK+xDIXHlHG6v+pWhEb8Uf8X6ESJdB7uy
         JsdBgYSaix0VTw/8kWHD0DAR3277TMar+G86EZFc5U/AOa7HQ3elJKdJL7VESeFxSboA
         cGle0uqOocxT7i+h6cncFiIyj5b8MpW7c3PKqFf2Qevv0SEMkXRTOd/JNtVCVc2HylfT
         r0tFJhxVDNE8NtlV99hWOvojTdWioevxDvh9uJiNnn6IjKdgkr3fu8UmTm5TPFQfmYaJ
         bnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754985346; x=1755590146;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYqcDJ4zw4hjQzcc/qEKSAWcFmvFSCfCvzGGojBziFY=;
        b=kiID0SyT9aMY45l/OwRqS3UyJ6XIMZpkXl3NPaGvT46zY8dXFy+48dO7pYGROu7tdP
         ci5VgJYsXHBC1h8jlXApulu0rB3kbsm+eSEFZ8+YV7eadfc5CtMtNqAdyXgl+LiiItw3
         qfpdjP84/D1D2a1k+iclunyLloDrlXa6+G2r2Ov4q+BG3JLx9JJvHvAPk3B9aHgl9s9o
         aizl+7ykfWTPZWFOFuuYtKY1i2b664UGHubjm784u1lRHtJNBEnoAG/bl4ZKSc3Ts/vt
         cvi2n9j2niczb5y3mO1FKASgoeH8nDBoZiBKRzuWeeReYpbtfDZnJDg2gghYvHZCnFMj
         2Qvg==
X-Gm-Message-State: AOJu0Yw88diX03hnocn48PDA8PjNejGVE3RC8RBLJcuDo5HuBQTBp0rm
	+JNQqbYMKKiLpDCWaSujGy5fdkCUu+JHSze/S7PF0Udt/mk4Bqkpz4N/qgWILSalcd6NdaX5nxI
	6pF0/5TPcgtgr2p8H3ysUKU57rARO+lFXjYHOPzNjZ5w/
X-Gm-Gg: ASbGncvRmSkBig3ACvciPDxmP1QZZV4ipKDd5mvLKpbDLo1xmRiAtuQ0YRdOSuz9/R9
	g+ksiD3WoKAZ2Js3I8DdKbmpimTrr25m9QBEd4IFR75zMkP5WM0fczyoklBaTRb2K+knrot1Y9I
	iTXfhPmoQdau9QP/QO268FFSOyJYckQ8AKTz0iU1Zt7CZK1st/iQz5zNo2Ye+qhWGe8irNir1Qh
	1jhVFo=
X-Google-Smtp-Source: AGHT+IHysstVHarWgaCwVH3NpseDBewznOkt/n2AvBganA+UvT96pNUzxxrQe52nnL/OAPEL1Gk9kJXc/55JWR2aP+Q=
X-Received: by 2002:a05:6102:40d4:20b0:50b:e7a4:4d5c with SMTP id
 ada2fe7eead31-50cc622de63mr622683137.9.1754985345553; Tue, 12 Aug 2025
 00:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: jimmy@thrasibule.mx
From: Jimmy Thrasibule <jimmy.thrasibule@gmail.com>
Date: Tue, 12 Aug 2025 09:56:11 +0200
X-Gm-Features: Ac12FXx_fRBmXP4E4xSl-apevf0oOgALMUqsISNQ9oa3J5BRim1irf0RUdpprIw
Message-ID: <CAMqSRmCj-wcra=HE1=kv1LQU3UxhBg6zfbtO_OhWwJEqdf8gmw@mail.gmail.com>
Subject: Git synthetic worktree
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'd like to create a single worktree where files from multiple Git
repositories (or refs) coexist side-by-side (no subfolder separation),
but each with repository still independently tracked by Git.

There may be multiple uses cases such as vendoring where a child
project constructs a synthetic worktree with all its dependencies.
Another use case is to generate patches with a tool such as `Quilt
<https://savannah.nongnu.org/projects/quilt>` where the ``patches``
folder is an independent repository.

For example:

```
PROJECT A
=E2=94=9C File A
=E2=94=9C File B
=E2=94=94 README
```

```
PROJECT B
=E2=94=9C patches
=E2=94=82 =E2=94=9C File 1
=E2=94=82 =E2=94=94 File 2
=E2=94=94 README
```

```
SYNTHETIC
=E2=94=9C patches
=E2=94=82 =E2=94=9C File 1
=E2=94=82 =E2=94=94 File 2
=E2=94=9C File A
=E2=94=9C File B
=E2=94=94 README
```

To put it simply, I'd like to replicate `Overlay FS
<https://docs.kernel.org/filesystems/overlayfs.html>` in Git.

Now what happens when we have the same file in the repositories? We
can specify which repository is at the top of the stack.

The CLI experience could look like something like this:

```
$ git clone repoA
$ git remote add repoB
$ git worktree push repoB/main
Usual git commands now applies to `repoB`.
$ git worktree top repoA.
Usual git commands now applies to `repoA`.
$ git worktree pop repoB/main
Files from `repoB` are gone.
```
