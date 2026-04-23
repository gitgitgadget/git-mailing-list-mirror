Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AC3921C3
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979579; cv=pass; b=TGex0CUFQgceX9K82U/YPjpELQHb9Bql4NbzEn7ntCLPr4drchgUUYLl/Do7x3ab6KWVDIIZdVLQraHLorPCLtScZ5j2kmcIFxyoDQ2juRpVWkW1Ygr9e06UtrXBAvP/xY/HPlZYQ2z6VxjsjkNjEgEg6Lu2MkgQftDPj5kBuao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979579; c=relaxed/simple;
	bh=N7pGPAJUJNok0CLhh03SufbZdrzvpiwcuMBk3O/d0Mo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kAFcDaDcuYy6UZL18XzjMqfhiUrJM25340fl+T3z1uIFJOs4qiqjQHMkrZHzos2j6mvx3bqUKeKb0EFntK+oYjsUzJuXV5WURSVs6YO/5a9DwxYuJVHbRVxOr4ze7ecaqVfm+BaG1cY6zEKOWVlA1OAw4ry4kgixeICzofa+0oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4TYCZsK; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4TYCZsK"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c795f441ff7so4883389a12.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 14:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776979576; cv=none;
        d=google.com; s=arc-20240605;
        b=CHQmin2G9Qn6EFY5OwndkYvOtpUy4CqnTqkatIwa2KH5y3Jwj9viVAk5DdqdigxIMJ
         i8svmnF6dsMbNHdQAo5bz18Aynxaaffmscv6hxy7o/F2Wfds/TgLyiDKYtZ0BpzxlNJa
         H2Z0Upn+hkO8yTNipIDAVojYpORu3i1IGaZR5/T3Hx6N3NhY/iaRznjeL9z35I9G5FfU
         ya1OhGihz+iN+d2zzeKAx78XOPRYDauxj5+IIGQMw6VXF5iZEv5gl/CY6VGBHZvHbQh0
         wJY9YVt5ChBccjvBWqdFl6zYHW6bpPn6C9wD4CqrJol7zL86QMCyZ1cLKxiuLX0Qb57g
         UWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=SvZkEdGozyUwkfo1z+/2xYH6Juxqmqb7yQXnOKeRaMM=;
        fh=WfJB1YkHjfxkSMCsogHMbYc3pvCTmQRpLXh1eGJSZoM=;
        b=ZUiPHp6kiMQasmdeuqrWGTNM1eLN58fvbIDs5kMcjlzpMhgBeUDT8PR28g6UezTaVS
         sECKBNiiquix7N+ggdapQ6qTwbaW/Hm23st5qHWpXakA8PRfZUuwaITABz1IR6odLyc/
         l/QWmLIBi+KMjrrnlLtBI7DxNZVYZCBiBfCCQjOJCsdWpTmg+AzRrLApE4BREe9eNhrr
         1Nf1+qXIgOJx6Bs8UgQEfWzmXiIbnxGS2En9l0R4RyGqbRU9MO+deEQCdaHcvnIhow1N
         7brGDCfYpF10xYgg4gmam0K7zrj5tToScSjQ/6GtPkTGrAO73+WU2kCl/VhywtVd0a9+
         x7Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776979576; x=1777584376; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SvZkEdGozyUwkfo1z+/2xYH6Juxqmqb7yQXnOKeRaMM=;
        b=D4TYCZsKrkVyH3SyvVdUztQ/BsMCM5K3mWDI0B8lUJrBP9LJ+wIIDNFHbVDESHhODu
         lds0kj6NHGisZ1Du1eL1hXE5sijWn3L6lAb7ukrY4mF2DNSQrOnt+ElcF67DqtlXj7bM
         aqW9WrxCybcpueeI87Ixh1UoV+Glb5vEq99veaNuxKYvBHwiTUIl4cuvLndidT21XT6X
         bJXIJkP2Qs+BS9GoZkw+/0yKLcLVeezhJ2rOVPGgVTH3oN0ZdfYHhwGMHXxUqVSpjTtQ
         6XDOEsugrVm8GqTniBcKkRvVNEmckQs8tk/NVdBa3Mw9gTtx5dOBXoe02ERCLIkeFIkp
         VtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979576; x=1777584376;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvZkEdGozyUwkfo1z+/2xYH6Juxqmqb7yQXnOKeRaMM=;
        b=MoWw1zY4D+uHF2samsTLgjyyjLmhfNPwovUJpb/uU+a3fv8qcVxBj00s4Sk2Gpp312
         oa3fYvngO1ym6Q0ExmsxbN3L7QafPYf2fzJAQIVG0CwpWtVFfmHG6rk8PZbQKc9pyvS6
         /lB6Dzfnv2tyGfmHNCL2U7n6fQBWMQ2NDZzS0lvtZMrnMsI83FEhLFBqgPadOAi3W5I0
         hf3RlfE6jJPXI1PeIzb9Rz1K7J175n2QIhlaxfJqJ4MHx9wwfbRYBN8fFz3EZ4olqwpI
         OiRMIs8SdiUjGAQs74eNE3odyWUZz/Ja/0h/o4SYLteIN+1bnWjX3JwiO6ekXVEtKWxj
         PIdQ==
X-Gm-Message-State: AOJu0YyODIuTjo+ho59v68GpmojykzJiR94qqPa8YRL+xMe7Szmcjymz
	zzyr40FeJfmfZnkbbnfNg+P80r3hNaYHm1Gj8f1x4A22hMfqqgbm2J0VDsjhU1CTtzHfFFTryLt
	wIEx0znYrANERY2L3L1gBsbEHL9gRlipFSA==
X-Gm-Gg: AeBDieuK7qXU7CZZUwBGKbZibouNXgLfZGlcrYLS6KfXotYKHOCLJjU+ep1+jz3n+UR
	E0IQT4vnB0w2cgnLqPZ6oJS+KR6xRojE9xE/WIabrwhyT+pq7rVW9BeJW/BFeFPCFF0iwlVDCqH
	Lx08upjTq0dfrISLY6r8b144fP1+VcImYxR3OyVzeHwow853VrnHKc2uQtvRnE/l2AU5vo8DI/9
	tZ5LhlxVvDTSVadPnW1zNFevpglpHKjFYdnhmaBBfjU3m05BjwxAeAo2egF8SKQOpRdfmXl3Dha
	qA7/LtfPoDvfZVQomQyeemzwX/XYEz3dTFhqfs4Np+OZFiZRVuXfPGeIjBUhowFF0XtRuDqbMPp
	pLZKCBm6i0snydb0=
X-Received: by 2002:a05:6a21:338e:b0:398:7256:3c0 with SMTP id
 adf61e73a8af0-3a08d73e948mr32092022637.13.1776979576566; Thu, 23 Apr 2026
 14:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 23 Apr 2026 17:26:05 -0400
X-Gm-Features: AQROBzAdDauNz0kqRtBMkTS1vG5tmZx-j007aUpX-Gi9XP6VtcQN3mZsG02hIR0
Message-ID: <CALnO6CCXmA+ATT7CuyWkU6P8qmLCCpMi5Ppr1c78s0heznpVyw@mail.gmail.com>
Subject: Advice on per-worktree private gitignore?
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Today we have $GIT_DIR/info/exclude for the main worktree, but $(git
rev-parse --git-dir)/info/exclude for secondary worktrees does not
actually contribute to ignore specs.

Is this a "we never got around to implementing that", an intentional
omission, or something else? Since --git-dir is described as parsing
$GIT_DIR, I would naturally combine that with the gitignore(1) manual
to think that the worktree.git/info/exclude should work.

(Currently it seems that main-worktree/.git/info/exclude applies to
all worktrees, which may not be desirable in some circumstances.)

Thanks,
-- 
D. Ben Knoble
