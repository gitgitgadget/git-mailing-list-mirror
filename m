Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357909;
	b=pE1omNN9zR59HmF14IiVsRUdblQ7nYjJLpoaOnNnKpz+meLApCBNprf5rI8a5L/Pl4o/
	 JRXgcfjuKzDqod8pAShp80sA4dHBlvb/76ZcO6pAmxdYf6PkKim8gVqLzMElL5iyUg7Pt
	 5qHOlJBdjJrQu1+j37KpkPRUVqpPr+zTnyfwUjC+ICyL4VSxzMqOsIC+mPu6Qcle7FOsf
	 7N5xIe+PXlqcKlU/DsJHrUJLP7kC/zytd+Rj/UnurHPKBsGCf1HqP2k5kc70XFKhOSCTy
	 +SQNQqTFi/PaFrH1dqyvD7siAkWXmK1FuMm5c7bXa4w171KzizSHHhJm+ilR0/Pm9Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=yL/5fW2Db3fIuMACRqg1UmbT1Nel4XMx5gC9KO6biTk=;
	b=SmvVFCBH+IeCXXI8sBhRtToDArv6U2VEt934ag/MpoCdcsfHT5niRw/ZS1S2PdUJvzv3
	 5+enbXO0jZsj9Dx+sU5LbouEvnUxwMGQGHd7pXpVx9FfC1XtkLGgywO1HYPBZsNiAZJjh
	 T72us5Ju9ZDsb4a4p6KpzMTAmlfDCASjxiIQWNt60Y5uVlf/tUgi2/m2IRN2IW2eA3TPf
	 6CWs85Z3BXhBT8c0TJVdmUCZ5Vx+JjDXdVqGLSR8BXHgT/We8UTgolxpDsiwhBYQOG3Fz
	 6ryBSwbd2FHg/f16W+CVm+9gCZRDzCI+Q44aTCsPHDmvN7xO1JbnroUrOHpIsa0BFPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zdkz7imo;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59607606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59607606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zdkz7imo
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so3923415e9.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357908; x=1793962708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yL/5fW2Db3fIuMACRqg1UmbT1Nel4XMx5gC9KO6biTk=;
        b=Zdkz7imovt/dIVVSsiaP68XuSfKO+gCUuKIMOknqX3BEGLN934OTDIiLJsx35qRyVO
         92jy1eOlqzVl/VYPHcr3wgPl5viLMoMHClqgSRy1iumXCn6bg1EvqIxgjIfvPjyHfdRl
         bcrLY+Y+JqOcHOwjCL6YkzUWhGJQxFhW7/6OLq5AI1eQoP8yDWEav/sWTLhnWPwS7fSp
         F3KvPbZkKPapVT+5cr6r6qEJ4N1rnywXJqbHOUeONSDcZW3XwOZDQknhk08KnD3GYZNw
         8Yc8eIxfK6EPauGmVsoBLG/oyheHdjfrkm8T6/8AQd05Hj3B10M86laTe2FtGXCiEbxG
         eh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357908; x=1793962708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yL/5fW2Db3fIuMACRqg1UmbT1Nel4XMx5gC9KO6biTk=;
        b=iGLuU5I5IuITXnDVGKU3S5CPxynmfLl6uAQwlLiE31OnXZSMHkVSBc3NrYf5T3rk0H
         3Zng0VrtSbjnwzfarUCGVlUBnHxxOxcalOld/P5caq+SczWgvL0le7dkCla5hAu384/z
         N1kyunAb7X7Cb8F+bkJ6dfDR4C2Mz6e+qiBYccMrmblNFwHMVNYOPeGRI0/Xz15sk59Q
         SZcx72yKWQm0//qkmk0W3cMN772+TBf+JwwMBSRxwYrGx93g6xLuRGXNUsozL3Aio5oT
         fLNu/BBrTyQgYik3Ulo6wZ28YzeNOL0+Ckx7I/qfhClQdev6LgCzzQUWOKr45LM0b7SY
         OWpA==
X-Gm-Message-State: AFq9FYIw9ePXELiDT2hBFZn6tPucyW9lo8zeqY4PCFg6cV8WAxlI4Fvv
	6h7y4A8wmq3fh2cfFW7TCBy0J/gRD4wLLBBQdzU0XANPOJ+J0D39/Vr6+AMAPg==
X-Gm-Gg: AYBFou2dmKsGo9B2UJuxTB4cUzxxhgAOxrl9RnCTcE309r/zfA11zlJE3bEaRvB/CMr
	0DPl+pZGXxPMdKv3PGMrmjbNwdYrHYuasFuvBWAnNVTHi5ResZEch5WNjHvaci1r/J/y7HREmqk
	7wIzEnKYMmn6qlFC1nkxzh1rOkf1dqN0N6E+bvxzaoJBc2h/XTQq5jzXDUi8L65bfl/TPXD4+Kz
	EfXxcwOKdkxqKUesI6VfB6VHl1XW5ku2AeJslY32zkYqrtufsltmFpjLqiWcYGBSRrDuX5MoYWY
	RbVn0ZVzU+dCvBwUvRH1JmhPMB0qoa+FZgpSX9SW5PlaCJLjPDEEDBL2djivCfq4216AVRXjehq
	RgXUK1lfJX5ENVVfT7YG5kE/roidDH5Cf2mzdYiUxX6UJqYPwAHcZVjjR2lUNGto25BqCHUORzN
	NmIrS5qGlW016XtDdcvYIvZNXvnEzVuHpeYWbuqlTgqz4ipTECabkHR9T1mCYKTBVFRxqR/C0v9
	4Vpwy0Bo0k1bkPcuiTWesC97FDJM5DLjz4y+0QmsWPTTbcCgjQsk7GHbLDd5pY3Lyrz1SqqTgaL
	AYA+2G4+8Z+40yfkq6I5gtkAnfqzyEqVm2rbYBBFPw9B1QZaVJo=
X-Received: by 2002:a05:600c:19c8:b0:4a3:59c9:a743 with SMTP id 5b1f17b1804b1-4ac1913ef8fmr39982865e9.27.1793357907622;
        Fri, 30 Oct 2026 03:58:27 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b727c6sm2677980f8f.16.2026.10.30.03.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:58:27 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 0/2] tree-walk: use size_t for tree sizes
Date: Fri, 30 Oct 2026 11:58:21 +0100
Message-ID: <cover.1793357680.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct tree_desc keeps the size of the tree buffer in an "unsigned
int", so a tree object of 4GiB or more is truncated on all platforms,
and struct tree adds another truncation on Windows, where "long" is
32 bits. The walk then sees only a prefix of the tree: it never reads
past the buffer, but when the cut falls between two entries the rest
of the tree silently disappears, both for commands like "git ls-tree"
and for the checks in fsck_tree().

Trees that large are not something one creates by accident, but they
can be crafted, and fsck is what is supposed to look at every entry
of them.

 1/2 moves struct tree_desc and the functions that set it up to
     size_t; this is the part that matters on all platforms.
 2/2 does the same for struct tree and parse_tree_buffer().

There is no test, as it would need a tree larger than 4GiB in memory;
1/2 describes how I checked the effect with a simulated 16-bit size.

This comes from the same search for truncated sizes as:

  https://lore.kernel.org/git/cover.1793352943.git.gitter.spiros@gmail.com/
  https://lore.kernel.org/git/cover.1793355390.git.gitter.spiros@gmail.com/

It is independent of both and merges cleanly with them. The series is
based on master (b9e5cff180).

Elia Pinto (2):
  tree-walk: use size_t for the size of tree buffers
  tree: use size_t for the size of parsed trees

 tree-walk.c | 14 +++++++-------
 tree-walk.h |  6 +++---
 tree.c      |  2 +-
 tree.h      |  4 ++--
 4 files changed, 13 insertions(+), 13 deletions(-)


base-commit: b9e5cff1803ab24582201ef059516eb16014b9d9
-- 
2.53.0

