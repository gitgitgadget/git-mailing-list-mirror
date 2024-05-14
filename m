Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458807602A
	for <git@vger.kernel.org>; Tue, 14 May 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690657; cv=none; b=p8zGvetmKQJl2/r/X7z57X0rNIl4Y9CEmQCsBlC3DJI63zJjcPgqv8c4fkLlNpyUPzHy2ovh/EeeURWZuCPlTCjlKyMzGyTfH9Rivb5RaR5uvE67H0dVYw3BpIb3xhVBR/hgyquACj76rMQRn26JcVuyuOOiLouOwUqcEWGOJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690657; c=relaxed/simple;
	bh=aWowG0PR6sJ4lF3lBbqtgy4ogw8JRuuovhpZInohed8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPPXPwa5VZZhUUyFj+mDA7EQl6qp9tonAOHEZhEam40sZpoKZM954AaXdbUcx5lIZj2UVpuDNiZ62b+uvRoAczQnjOcxwqUSOncqhCfODv9lLRsz0GOMEreL/QF+N2CE3tFMR+y9KstklCR/5wLKlVPlrr0ntUQwx29rZT/5Y+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw90Iknx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw90Iknx"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-574b3d6c0f3so52590a12.0
        for <git@vger.kernel.org>; Tue, 14 May 2024 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715690655; x=1716295455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EwGaUfTFRMSbVFQh9+jhYhGLgj+HXWgI0D8E4g4JsPg=;
        b=mw90IknxKGYc/vpQzKDKRbZCWqL+/u5mK/pzE3lfnoCkIB/H7vE9J4HpH6rr0CVrF1
         sIxsfgKZfYO+AAPtMYbl3KpgTKVjC5SeNn1QJc9WIzByXEyGu21YqpFWdXvGBsSmqWl7
         LFnUA0SqtE62VMhDVRkPma58gbgC+rBMzo0CvivqA3eA1JZ0dnRuS2mZBhEkAO5mwcpD
         74OFL0cCl7DsXznrXCgVb4GtovIgD9o+tZ7+h6zVAgakuFfqR1g7z4j2L+ir0H1AIZAw
         ml8OcufG7y/NvoWmrxAjcJlA8XqvcvCvaQ74GCsWcZtpocZ8pGMxDXj6y3bqEaRyf1JL
         1Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715690655; x=1716295455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwGaUfTFRMSbVFQh9+jhYhGLgj+HXWgI0D8E4g4JsPg=;
        b=bbaMX+FOFPuZPk9tJbLOVwMm6G3vPemWojiONePVu1RyxfY4jpHoDg9wjVg4psGPXu
         vvHNI75gmKVLy0hL/pA9U0kmhur8aApr0QE3RDldcupgV9pnnjcGpX5gCukU/xUt/fOY
         97lDrrpUuv9ZZoKEciOOcLExxPtNDGjYw/ePBwpwieA3SYwUWVI5cwUpX7Mpbws5TiHA
         DqWevKrd1aDDavs65lqhVHULdFwTeTY4UOk4/C1/wWwdWrsUye+oJByOmVJAEkq1JJPq
         6y9Jkz3P2TVJPuFk6GYEySpoUxC+OsqbsmivZmGUflehuXcDap2F55SQxyx93TlUCiCz
         /l7A==
X-Gm-Message-State: AOJu0YxonLbTZFRYfo5BFKpOMOBmR+GRX9YLjK/4lnkX52vNWE2dt5aO
	5uWLhhDdtksufuXENfWA5CywrvQjJzr12p0YotYyDhAxAzmWqoDD/twavg==
X-Google-Smtp-Source: AGHT+IEWTSaO5X0cUubtoFXuSyZ2BU8+SrVnIHrV3sVTVj0nWvWdoZUMCwelghuisbqDWScVXA9tTA==
X-Received: by 2002:a17:906:b1d3:b0:a59:9a68:7327 with SMTP id a640c23a62f3a-a5a2d66aa45mr872629366b.54.1715690654353;
        Tue, 14 May 2024 05:44:14 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b019edsm730530566b.174.2024.05.14.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:44:13 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH 0/6] update-ref: add symref support for --stdin
Date: Tue, 14 May 2024 14:44:05 +0200
Message-ID: <20240514124411.1037019-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'update-ref' command is used to update refs using transactions. The
command allows users to also utilize a '--stdin' mode to provide a
batch of sub-commands which can be processed in a transaction.
      
Currently, the sub-commands involve {verify, delete, create, update}
and they allow users to work with regular refs in the repository. To
work with symrefs, users only have the option of using
'git-symbolic-ref', which doesn't provide transaction support to the
users eventhough it uses the same behind the hood. 

Recently, we modified the reference backend to add symref support,
following which, 'git-symbolic-ref' also uses the transaction backend.
But, it doesn't expose this to the user. To allow users to work with
symrefs via transaction, this series adds support for new sub-commands
{symrer-verify, symref-delete, symref-create, symref-update} to the
'--stdin' mode of update-ref. These complement the existing
sub-commands.

The patches 1, 5 fix small issues in the reference backends. The other
patches 2, 3, 4 & 6, each add one of the new sub-commands.

The series is based off master, with 'kn/ref-transaction-symref' merged
in. 

Karthik Nayak (6):
  refs: create and use `ref_update_ref_must_exist()`
  update-ref: add support for 'symref-verify' command
  update-ref: add support for 'symref-delete' command
  update-ref: add support for 'symref-create' command
  reftable: pick either 'oid' or 'target' for new updates
  update-ref: add support for 'symref-update' command

 Documentation/git-update-ref.txt |  25 ++
 builtin/clone.c                  |   2 +-
 builtin/fetch.c                  |   2 +-
 builtin/receive-pack.c           |   3 +-
 builtin/update-ref.c             | 230 +++++++++++++++++-
 refs.c                           |  34 ++-
 refs.h                           |   6 +-
 refs/files-backend.c             |   3 +-
 refs/refs-internal.h             |   6 +
 refs/reftable-backend.c          |   7 +-
 t/t0600-reffiles-backend.sh      |  32 +++
 t/t1400-update-ref.sh            | 404 ++++++++++++++++++++++++++++++-
 t/t1416-ref-transaction-hooks.sh |  54 +++++
 13 files changed, 775 insertions(+), 33 deletions(-)

-- 
2.43.GIT

