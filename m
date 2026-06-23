Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EFB2D7393
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230051; cv=none; b=eq5rPT3NVaJCZAVe13qYM4LU/+4yhKrQK2miHUeRfo50U4KuKEnqKRUiY/7XPcBGA7c4FB8jZ0WfDTpegqPmSPRY8pdtuVVMAS0fSAeV/k4TqlWADO8XbBEE+RPg6SKToYzJrFbD1GDfAGIf8DLBnZya/gQoV7lP5n0bqQliIHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230051; c=relaxed/simple;
	bh=KNElVpsv5s2YsH61yo8e+EoFGpYeVYGS70O46A6advM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdmuxPpRCw4qcNBq5Y33MIwlcoNyPlDx1ZsR95YSJ9PGR8HNexVSCcHVaCVLUo7N3wDxogjAmOtAtpQ3em1EIKK5Hf+TtzAy/KNbE/f84wubaSSL3yoGhTZVaM6n/JhxEmeHN8mP+aQqwiHZUar6SVmXcK/eDZnx04gu0Kqzk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWwPUncP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWwPUncP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4924593f45dso635125e9.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782230049; x=1782834849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EtJ5dxWl7Ixrqa2mP34NolhKsIoNoGNcKmEqb381lLA=;
        b=AWwPUncPuwZsNG3Uire2KV+bZg2DYgtiv9EYvzYGPDOLD8M+QtQRWxTi/d2qVjXgjK
         ZE8duSbnb2B/RREcpA/bY7Wl+VqTH4pbI6/lmq+eF622wARo/r0XYAeaWpxrFNf33adJ
         1sBX1J8JywjBPJHBj4YeZjWJJENxq4pvWP5HsS+h2gkHj6jz6XxAUIsZvU00rqzsaAyV
         ddh8Bc2EYP25+dZ3Py0fnsf+QtVDS9MY6SW4M3hjrKC7iWoci/s8W9FF34JvWvZTwVRs
         ozJjDqplYc1j9tKvVXhACWbV0NLixNS2gqsGBKkpFXP9SnPpss+CxBtEILZQrp2pSegI
         yVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230049; x=1782834849;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtJ5dxWl7Ixrqa2mP34NolhKsIoNoGNcKmEqb381lLA=;
        b=Wt4nwNO55AoMrkQgAixxZzALR2SA5F3WZjp4tSa4OS8aVRKTkPvi4mWLZzxsggkehk
         u8QLPLBua7pID0Y/NBk+w5kzfQ10Sly88uZ2sxQGqOH/CfH2SaUpobVECVWqZojlxTqx
         QiFnS/wb/rd19iF3XlQLsSEfnQuzDagSO4DTSowzIB9kXdyvw1Bx5K40yEuobO5oimFZ
         KgXcdsnJN7kTgP/EtHKX1yOm5qUR2a8e0TwDngWeaIa/AO2OFdog8VTB3AdmVrgHNKu/
         sdl/3H1WgtUlPcXsa1yzETYSrGhNLbWKNotCG0havJr51GQ9031intrdN21C06G8LM+6
         E0RQ==
X-Gm-Message-State: AOJu0YzhazppEPR7LSrKB07x8yeNe6lJ1XWgzKt4eoo6EZRpF16nWLgv
	O1TGCytHSkW4/jwdvlwKHzh3qs+c8j2pMtMfHxFBRl0z3aC4vHGXirmfXg6Jcg==
X-Gm-Gg: AfdE7cnhQ79ftcCo1J/cP09Omb7KYUd3acvWm6nNK9+eCt+H3wXDF1yyLbgMt9tXHTI
	165i3CPOATUGtV0z41G0TBunftEGhr+IwzC1LTF+ExQCIO39t/d8N1G5+RPrB+5eWHMHE/ZJqzp
	40ClYVmz1sLxV2KYLdSftsT+u6K7blzhZT5v/KKtbGox9ZisAbGDHAnZK+xsXFR+eEN2LeOX1+J
	4QdHRfiID3Lmpv7MzZcJ2ypDg1+FIUTGOOOwvBktkbmtz/fD6t5pBUt200FxzWCT1DOE05oZVxJ
	2lRUGHr5o0shTaid65EhDB3vv9BagU45tAU1jNJODpXTTgN3jmeiF/UOU3TuJM7z9LdD58wOwt8
	TXgdEszuP0SndOj0XZIioAkCTFQ3xWqYuTd2K5C7MHg2woSApHE1t1OucsvV40t1j5JsyBT61sK
	JgjP7H76Rz9MdxpCEf
X-Received: by 2002:a05:600d:6443:10b0:492:4e6f:d994 with SMTP id 5b1f17b1804b1-4925b3b7be2mr39375565e9.32.1782230048819;
        Tue, 23 Jun 2026 08:54:08 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7b9e5sm371729505e9.10.2026.06.23.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:54:08 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 0/2] status: improve rebase todo list parsing
Date: Tue, 23 Jun 2026 16:53:55 +0100
Message-ID: <cover.1782230024.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is rebase in progress "git status" displays the last couple
of completed and the next couple of pending commands from the todo
list. When it does this is tries to abbreviate the object ids of
the commits to be picked. Unfortunately it does not abbreviate the
object ids when the line starts with "fixup -C" or "merge -C". It
also mistakenly replaces the refname in "reset main" and "update-ref
refs/heads/main" with the object id that the ref points to.

This series fixes that. The first patch factors out the sequencer
code that parses the command names in the todo list. The second patch
uses that function in "git status" to parse the command names so that
it knows whether the line may contain "-C" and whether there is an
object id that should be abbreviated.

Thanks to Junio for his comments on V3.

Changes since V3:

Patch 2 - Style fix for cast.

Changes since V2:

Patch 2 - Check if the object name is a label before trying to
          abbreviate it.

Note that a number of the CI jobs fail[1] due to the rather old base,
but a test merge of this branch with "master" passes[2]

[1] https://github.com/phillipwood/git/actions/runs/27906115900
[2] https://github.com/phillipwood/git/actions/runs/27908204055

Changes since V1:

Patch 1 - Expanded commit message and added a code comment.

Patch 2 - Fixed some typos, added a code comment and clarified that -Wswitch
          is included by -Wall.

Base-Commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fimprove-status-todo-list-parsing%2Fv4
View-Changes-At: https://github.com/phillipwood/git/compare/8c9303b1f...90c4659b8
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/improve-status-todo-list-parsing/v4


Phillip Wood (2):
  sequencer: factor out parsing of todo commands
  status: improve rebase todo list parsing

 sequencer.c            |  45 ++++++++----
 sequencer.h            |   8 +++
 t/t7512-status-help.sh |  74 +++++++++++++-------
 wt-status.c            | 154 +++++++++++++++++++++++++++++++++--------
 4 files changed, 213 insertions(+), 68 deletions(-)

Range-diff against v3:
1:  d27dddff931 = 1:  d27dddff931 sequencer: factor out parsing of todo commands
2:  b3514e9b1c9 ! 2:  90c4659b87e status: improve rebase todo list parsing
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
     +	struct strbuf scratch = STRBUF_INIT;
     +	char *p = line->buf;
     +
    -+	if (!sequencer_parse_todo_command((const char**)&p, &cmd))
    ++	if (!sequencer_parse_todo_command((const char **)&p, &cmd))
     +		return true; /* keep invalid lines */
     +
     +	switch (cmd) {
-- 
2.54.0.200.gfd8d68259e3

