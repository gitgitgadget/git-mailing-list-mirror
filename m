Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910841;
	b=Uvpbmc4v2bFom0YUXD5HJ3cD/wF7Z1ZVfWObKFrvuVL4Hdxh6sEKU1HNX6q2ox00rjjn
	 D7cXS/JWpOpbGxoO+Te/zSYpO8vGJ1MXJCZM+0FHoX6+errfgTP8li+Hu7SuDlGuU3K+l
	 IQk9qArCuHOwjPLF99MkWJVVe1Dj6Gjv5VBljS0CozZp6nQ2JOeBOr1coEcX4GRK6wdmB
	 NntCZg6I/SSzGGlSvbzRiJ03poD03DWZTCrXatq3kjO0Jbs1r0/5pkXAs1lgqNAm9FX9q
	 FuK1pwHoJ+xfSUTCIbChyXk5ZjMQTVAdqqmPGWCNIzvpKxOp19jYnYFZauqCAdqfXtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nT1xKlywmPWxsyV85QF6+L59g1T6i+SGwGbFVlMFaO4=;
	b=05/D62f7KHZLO97Fgu22vYXQOE49sojMNjMYdzbkwENoD4Pwu0EhmnblYOaSnIekMVqB
	 Qvo8daSwOkJ2ldd1o4ZtuGlk+HKYuivZSDzpz/4bYq2Rvm5KqDYNpR6czJvlB2DHaDn91
	 1tyv4A28JEfsb9JCZO6QlxIBDQnGi+7kvFyzfXcrmhOiY06kARNpBodDcS0Y62oQRTHWT
	 LMIFVHT872IONNvjHe/tC7xZJ7L8jtbKZ5oQzOs4TbpldYI9zjlzKDcd5B0HLcWGV4i0m
	 ewedzR5Iea0HhjCEuD87Vz9E5tEh24V1Rw/8z2bBKeX2bAhMdPv6ywx+hZod4R5ntSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oK5SkNQI;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC2606A328
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 20:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBDC2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oK5SkNQI
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b561b60b78so1562454a12.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 12:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910839; x=1794515639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nT1xKlywmPWxsyV85QF6+L59g1T6i+SGwGbFVlMFaO4=;
        b=oK5SkNQI9rQ7+tnOxLYkpC6dPxe/XXvErSlzVmTKEdbnAriPXDSWSwWjmIaVC9qayf
         xGvxUtBrEow/9pTHiAcp3Zrf8/QfKnEDi/wYFgp/HsDisOq6RN9rhIyWAPmYZGnqLjn1
         IwHrp7FHgJK+9fv6pDK3Hoeqpk5hGZlUIElg1C2pSe+jNsmbhs9HDfTTFkxeEBZzLru5
         92fziEh6J7TmqoNm2R2KC7GwJY+IRbyj3Tjg+1f5xmJ8AL5/glcnXEV51Ze6uMWcBLTc
         GUL8pWnCxDaTUshJlxc5PEDG0GAFWaMAXKXA82e3GgKLHHHZSqsC1Ghpt8Dx48ZfljMB
         jbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910839; x=1794515639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nT1xKlywmPWxsyV85QF6+L59g1T6i+SGwGbFVlMFaO4=;
        b=SsN0ml+PezD65v0vW3hWyPD+d33tuRK7TY52dsWfMePLRZJ3yAy05D4+3CfarqxaiB
         36MUYHQL9YLh677NyY4jSgTITEmMKTuOe0RHCQqC8+siAesF7tYZ1QqarznncKRd7X69
         8yftgsLDAQ2QFF+t77AxmOPHyWcMqciszg9v1wSjAUCJ2Awhl2mVyN9aWivUQBAMd+Qo
         H8QQpFkPg6BwIkmAaPuIuBMvDcpqQQWHEDcg1sQeFHQq/nHiEAe4tx7T9s9DiAnBHbqa
         YOoOI6xMjbFHtFkovEo9IuiDI5Geg87SQAGMugSsMoGgZQIM9uwUYKGXz8gEi9VkFxPy
         TP2A==
X-Gm-Message-State: APuU4Z/vFOcxR31t5XF0UHokP/sFcbIRt7mHkEz5o6u6umaoLmZX/qg7
	KxqzAEtrS7Lg0jS9Nu1lBCNkFLMpj4y6u+pt+uOaM77O0JhiKApO49fHFejsdVbHg94DGQ==
X-Gm-Gg: AYBFou36YAbj3VHMsupYoc2MCu9cNl2FT6qZELqRUWSKa4FEc+r792yMlwWYu4z5xqv
	EUoK0poJ8+H5XceO1QXoaVuPhUruI1G+twjUIjqIXfw2RcLhWcD2uJiXnYIvq7Oc0nqL/qM3l8J
	W7dy4WwcUXQ/WgPRTTrpfS5IQZSmDevaxfg7zFCYT9PkOi+ExtNTcLw58zpIumZG5pv3n3wszJJ
	rgD/uopSmorhU74xemdXXRdZPyYrXIi0nJdl0MFoBNjr7QhEDBwrBJ+HmkUzgA1NKYEi9xaBwpr
	2D+wncKCArMSXPuqQoGA9Yk08ki1P2xQJ5M7i7oiTdZoxeTmSglmJqkJx3/ueSWIWuCHkVnMqgh
	3JW7APwP+CpT6kTrRyaxTSfmnNmGEHFR9lSvMfnLQC82Iw4Ac3UqEyLBIFCCsHqcaCnLWahA6Dx
	LozepWjYN5Zvcb9AxIRZGv/MGH834WB98B2jWtOlWVRDGQYjIpskOJOfz/rnB3bKnWbQ/uTy1LE
	zb4M+rZ6ioWsUBft3RFvDrr+KUhdcoI7XH4vuKbLtmgFjh92dxe95iemBXIN+/eBAj4yVW/2tdA
	2dT3ElChgwAb0GCtKhh1N4YzsZNUB4w4l1fo43tiy9Egi1eYOo8GXlMDTBIMtPwQt9xQESG8GZN
	GJXfZB2E1S2aslPX/rFbCyxv1ura/nht5/LXI5vbTIh9pRDO1OKGeNWAt7ssUhLOZRYTCBfUpTZ
	zoxAcf0gbKTBb8CQU9+GXD1cNmJCeyiFLt6IKYfJd9LHOacS1kbw==
X-Received: by 2002:aa7:c719:0:b0:6ac:ac15:f14b with SMTP id 4fb4d7f45d1cf-6b576fb553dmr2072754a12.0.1793910839085;
        Thu, 05 Nov 2026 12:33:59 -0800 (PST)
Received: from localhost.localdomain ([104.28.219.97])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b5853e0536sm702689a12.31.2026.11.05.12.33.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 12:33:58 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: [Outreachy PATCH 0/6] notes: use the repository stored in the notes tree
Date: Thu,  5 Nov 2026 21:33:38 +0100
Message-ID: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqq1p8zw49g.fsf@gitster.g>
References: <xmqq1p8zw49g.fsf@gitster.g>
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

Patrick suggested fixing notes.c instead of hiding notes-utils.h [1],
and Junio pointed out that removing the_repository from notes-utils.c
is not enough while the notes.c helpers it calls still use it [2].

This series stores the repository in struct notes_tree when the tree
is initialized, and uses it in notes.c wherever a tree is available:
reading and writing notes, pruning, and the combine_notes callbacks.
The ref glob helpers take the repository as an argument. With that,
notes-utils.c can use the repository it is given and drop
USE_THE_REPOSITORY_VARIABLE.

notes.c itself still needs the_repository for the display notes
code (load_display_notes() and the default notes tree),
expand_loose_notes_ref(), and a few uses of the_hash_algo for
sizes. Most callers outside notes.c still pass the_repository.

This replaces my patch "notes-utils: hide functions that still need
the_repository" and the earlier notes-utils series.

[1] https://lore.kernel.org/git/auyRGpaHb5rdVP0d@pks.im/
[2] https://lore.kernel.org/git/xmqq1p8zw49g.fsf@gitster.g/

Okhuomon Ajayi (6):
  notes: store the repository in struct notes_tree
  notes: use the tree's repository when reading notes
  notes: use the tree's repository when writing and pruning
  notes: pass the repository to the ref glob helpers
  notes: pass the repository to the combine_notes callbacks
  notes-utils: use the given repository

 builtin/am.c    |   2 +-
 builtin/notes.c |  10 +--
 notes-cache.c   |   3 +-
 notes-utils.c   |  20 +++---
 notes-utils.h   |   4 +-
 notes.c         | 160 ++++++++++++++++++++++++++++--------------------
 notes.h         |  38 +++++++-----
 sequencer.c     |   2 +-
 8 files changed, 141 insertions(+), 98 deletions(-)


base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05
-- 
2.56.0

