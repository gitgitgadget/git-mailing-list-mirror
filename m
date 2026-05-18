Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA838AC85
	for <git@vger.kernel.org>; Mon, 18 May 2026 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128850; cv=none; b=XtoX61Gwo98DNKg06a0NN6bdzwNuOd+K9Oyle9hhmnm8LvctxzK241hgCVf72DtIowOMEY9q2OiiXiAyQl2QWkNVUL216RZd2pZrpp4jIFPT12E6axs67hbTJYVTpbh0MWrtNdyxzaGjtwrGJecBDO5w2nJZz/U61FwS0/lsn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128850; c=relaxed/simple;
	bh=S/MbysyGPzw1PYQ+H5AdBqTg57tg6XB7zFpI7yqsles=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxcd+U9ZhJ/A3Os7YY/7AUj5DJ7EYz1ZZieBLbqmuOv9ZvTcNKF1m8e1MuOdD9pFxSnD2hnJa7gEj2SradIyw4X33jvZqkJPk83hB/W5pSBF73yyXffCDZEl+VTS2QEUIpnvy6Dx9oMQmvXN5EzRI9EBtnIgQS8IfKBPDtrf0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRvzwhMz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRvzwhMz"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba928852a5so18222375ad.1
        for <git@vger.kernel.org>; Mon, 18 May 2026 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779128846; x=1779733646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bSNmk7tfqS8aCYKqi7f2E69WWZeKdm0hHiySnfJOIU=;
        b=SRvzwhMzldJu0gxv16/p7PYUB9g+L2q2SqsaFY6otZClWaAWNSrAxGvRBYMJCqCmzW
         4YpLPIWG+HXE72Gpy36uRxB5Sy4ER2oJJapDozqEnFNwF7oPhNs8bzCYXRs4o57KUvEV
         ke9rKnfv/vhI+L/q+A2GIKwYH364n1ebguRuhQzjyB/8FL01jbnWqFhzJNOEmzOf/a6A
         xJ2lKFX9jAYzE07GVm4Sp+0lq9qvil/VreW0hgXFV/IivpCpVUI31IbYcacNINAbBvt7
         xymVom75T0UNG8V7oF0T3J24mmEYaHM7WhZTXJHdm5NoK/X79ZLB4IbO1G8lagcDDThU
         V6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779128846; x=1779733646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/bSNmk7tfqS8aCYKqi7f2E69WWZeKdm0hHiySnfJOIU=;
        b=KS7htb7PyEl+uY0nSczty57zjMesjY8uh8HvTqduChmuWB0jLOrl527zOXSxKrLEDa
         5h1uBRQ9ve+xqjF+C1+WV1BXUezzRMkLlxWfRshD7dz6CtghFrsHl715tn/c49Bw9Z64
         g4DCRMQLvh6ong/p2rvJMUUXg1DnHBPg6rLLExiPt2h1RyWEGAfycswvrDk+cxehYaLD
         hiKgk4rjGvPFA3qnWv7BjUQj7aKBaKsh28qgLoEDqkbe+z9/Yyh/NlC9hu2GwNqzz+t0
         JCbKAr3JUW9QUkgCoy4o7GBxjNaD/zTw32hZhg9jik6dXd4i77DvEGww32P5Iz7YRyDi
         5wNA==
X-Forwarded-Encrypted: i=1; AFNElJ/p0KWmW3D8KgiO26xaZJezMS9mr1Esjg1RhxKBDh29Ljj5yDfjyQpqKGkn+zC9vXVfSRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcFAihIpuKrCSEWW4MoXoJEwrAYzv2EcBrW7VvjAcZf0qUdOsm
	KEnthm0IRQ+qsJgr1lT1oy+GsXk0L26bNjIhrZBEMnJ87ra/wXRcilSW
X-Gm-Gg: Acq92OFXhZrUAhu0J7kHNgVcBDh4dU+LOlI85/jbggbIAJNkl9tIddhQLsAr5OB8Jas
	HKVScq617/kczCLxB3/+6CQ4v6yCcXvwjZYwnn9Xx/A4Uyzc4VkBbSeoFPzYAkJBc2pd7df9XUo
	ELs5pdV5h+ImAARVoIBho246w4+XdZk95orfRFwoEoRdi4regBHhmYirAexfgt2Dsg90XzUUHta
	xMIX0GlegJGbh412IMXRRYEIzevhGFIJ5tQxhW9ez1J6842d4Fbl/pstDSc8lHdvdYWcqS9qakt
	17WdQaswTKmssF5klk1McHQ0L/BXXHNcB1oVzFvxiKKSdHjmwLWkQr0tt2EbBtVeuLvgg8eFalC
	kE12wbtxu7VpKqPeKiSi5aOXVG3rWcOJgY/RndQgvfIUDsPoVTqEgGVWY5DS2D/VqIA2Kygy9O9
	1iQbtWqAwfOy2/KX8kz/HZaSQ+ALjXi0REvOhEu+HQQAA/tGLeYTqEfBxAjPLnQfdq
X-Received: by 2002:a17:903:240c:b0:2ba:de0:1eea with SMTP id d9443c01a7336-2bd7e8196dcmr176744795ad.18.1779128845758;
        Mon, 18 May 2026 11:27:25 -0700 (PDT)
Received: from archlinux ([103.177.178.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600a4sm148530085ad.30.2026.05.18.11.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:27:25 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com,
	git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH v5 0/3] push: add support for pushing to remote groups
Date: Mon, 18 May 2026 23:57:18 +0530
Message-ID: <20260518182721.155070-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503153402.1333220-4-usmanakinyemi202@gmail.com>
References: <20260503153402.1333220-4-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This RFC series adds support for `git push` to accept a remote group
name (as configured via `remotes.<name>` in config) in addition to a
single remote name, mirroring the behaviour that `git fetch` has
supported for some time.

A user with multiple remotes configured as a group can now do:

    git push all-remotes

instead of pushing to each remote individually, in the same way that:

    git fetch all-remotes

already works.

The series is split into three patches:

  - Patch 1 fix sign-compare warnings in push_cas_option
  - Patch 2 moves `get_remote_group`, `add_remote_or_group`, and the
    `remote_group_data` struct out of builtin/fetch.c and into
    remote.c/remote.h, making them part of the public remote API.

  - Patch 2 extends builtin/push.c to use the newly public
    `add_remote_or_group()` to resolve the repository argument as
    either a single remote or a group, and pushes to each member of
    the group in turn.

Changes in v6:
- fix docs formating 

Range-diff v5 -> v6:

1:  e01126890c = 1:  e01126890c remote: fix sign-compare warnings in push_cas_option
2:  adbce652e6 = 2:  adbce652e6 remote: move remote group resolution to remote.c
3:  a8d5f4b7bd ! 3:  62a4499be6 push: support pushing to a remote group
    @@ Documentation/git-push.adoc: further recursion will occur. In this case, `only`
     +	...
     +	git push <options> rN <args>
     +
    -+where r1, r2, ..., rN are the members of `all-remotes`.  No special
    ++where `r1`, `r2`, ..., `rN` are the members of `all-remotes`.  No special
     +behaviour is added or removed — the group is purely a shorthand for
     +running the same push command against each member remote individually.
     +
    @@ Documentation/git-push.adoc: further recursion will occur. In this case, `only`
     +any member push fails.
     +
     +This means the user is responsible for ensuring that the sequence of
    -+individual pushes makes sense. If `git push r1`` would fail for a given
    ++individual pushes makes sense. If `git push r1` would fail for a given
     +set of options and arguments, then `git push all-remotes` will fail in
    -+the same way when it reaches r1. The group push does not do anything
    ++the same way when it reaches `r1`. The group push does not do anything
     +special to make a failing individual push succeed.
     +
      OUTPUT

Usman Akinyemi (3):
  remote: fix sign-compare warnings in push_cas_option
  remote: move remote group resolution to remote.c
  push: support pushing to a remote group

 Documentation/git-push.adoc |  80 ++++++++++--
 builtin/fetch.c             |  42 ------
 builtin/push.c              | 251 +++++++++++++++++++++++++++++++-----
 remote.c                    |  37 ++++++
 remote.h                    |  16 ++-
 t/meson.build               |   1 +
 t/t5566-push-group.sh       | 160 +++++++++++++++++++++++
 7 files changed, 502 insertions(+), 85 deletions(-)
 create mode 100755 t/t5566-push-group.sh

-- 
2.54.0

