Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD23815E9
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939499; cv=none; b=VbXsukhVZ2TJhln00HJK0mVeLltot9hRzCcZVFwuBY0miTbikhHCrKR8Fn5gp6pM5v7ftmcnNmZweCwftvr5OpStBr8JQ0tAspAVpv79jBBsK0i9bzlH9Don6RkqEEez8Iezk8OokUYcIyp3zxywaGA4JRoI6kGoOq7LZlQUg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939499; c=relaxed/simple;
	bh=ddEn6mLBsLJuKy4DGHfEmuqkyU7hyII0OmyPvcKcvI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naxeMUfCGQMd/nhClROENg1zhMpou1EdWfRkjyIxk8pYHldqCTeX3r9vlZcCqsqDMsMCpKBY+cpL0tZ/2w7aI+EWmuCkALbfXlaMEVwr3P5LMMm0NsJ4WCwhKuzFAbjFlBPY02Ja2PfJD1dck25i34s4F+BUbObS7lfMpevP12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWxLjIgK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWxLjIgK"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493f75f7172so17971795e9.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783939496; x=1784544296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GY6IbiS5AO90iKqlfxLzz6Vph+r4oKCYpJpZmPhxfjc=;
        b=DWxLjIgKYqCIPVo7vSh3JO+U+WbmlSskMt+dE6ADjKqBBDCxzN9MNtMOpbkdgm5GQj
         8EVkZZDMhicFZ92Hq0Tdr5hOjcV4/L8TKOF3XLx0XBrDb1+xWNOwQ2q+PHy6FxQsxxe0
         1CFlobhknU/RMXmj/5OqHsqioMvAgBAGWhrk+s7iwlOZzWpBifs38gxz2ggvyRde5nfm
         C9PbufXDjSMEgSsZaz6Dh0kz7kSq4uvBYVwzHaUjA0Jt/clj1A5LO+9fkfpXU8i2iFIv
         kM2s3cTEm5XVzm3ZuoMxnzd/hYfM46cTgctkAhYAPtEfCc05L1+4AptBbfUn312uWEts
         Zhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939496; x=1784544296;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GY6IbiS5AO90iKqlfxLzz6Vph+r4oKCYpJpZmPhxfjc=;
        b=Qe6FjyXHXfA3QSsT3lbZqCAAW1av5rBljyasnitQXEQpR8IIH49Ut29a0ZDTKheqJJ
         1Qt2vNZBAlbDw0AMYDHOI969Y70U/V2cIdjbA/lxvZ7/hNVt3V7r1oqJwoyT6jszBx2M
         8eTDIbA5luU2/za57qrZfLScLtYXwwkTkk6b/2qeJZH9pPHX+EXKqHxFKCO6O5PZQAXG
         vsfx7TNv5IYZqXmPoy10vl+HRcznVsgJjG7SVAQ8Jz2sRts3Gse2mpEjI6yg543D6+VW
         b8GaovkxtyVzYxV8C7YRK884diOORpoaOgxFum3roiRYi6WSlM8L8jDADSnfkKwbWRZt
         AeZw==
X-Gm-Message-State: AOJu0YzqzizMADN5fVNpa2Torq1Co1tUBCyAX0FaMtzUoM0hZ9Dw2ie7
	Xae4tdLRbEx9EWIDZJL7KrzHk2A8PUuMg2cE4+/EBl+VBkMxWJmFP4PJCpqynosz
X-Gm-Gg: AfdE7cl8+Rvr84LOw/v6y+fWCWC4JUyHO+aWD4HO7njdGLjhX0IWAfR/M7NCtP+jR9q
	BW/xImbh5aYSyPD3xOrlebBu0e38x4rxikhA8jbTxUAYj/I0ChLzAc6psTN+AUpQC6dDRI5Ephz
	DWxeDnGULNSkYIeaCk/ZKU+dRCLcFZgBEWCGPT2iRuhUnGK0SLXrLOHa06ROZ/HcWl8w80S5FPq
	rqPaBfZgT9+WxanVHRT/xexEm7q5PcVeU7QAfdXRaO+HCqCwy6HDD40buXiJ7OSV5ueOKRFnWXY
	PegdnnVSmU+gq2ZsEMonVuzR18PeUTS3hYgLt43jSfp+6MxHYV/YyM9z9SDyrvMVdV0pOx080Bv
	NC9Cw8fwEcavUj7Fl3kCWK2caAYkSaypPmnm5vJnnWsuUNjkkT6wRCs+Z/HqRRUFMTGr0PjPiB9
	P7Ep4onsSlFJN9A5U2cVk5LMPaKnUX20TKHMNHnCA7RkAUPDEXmfhf8vFoRZkRGbD0ltvVGvpHr
	dqfKpVLum8FNl1bq8mwaqgFtnlzxlhegzQMI2YcpY1VBYk0xgcZcnKiMkCMbyrzZZhQ2DCGtZZ9
	0xVNrpdYZZfW5nQpDaAq0460TLJwmcF/RyV1Cerdgck1RCZmTorMMAzWDcvyIQJk7fYdxEDYvj6
	Clrr4UQVaVg==
X-Received: by 2002:a05:600c:314a:b0:493:e404:3727 with SMTP id 5b1f17b1804b1-493f8818d5dmr91060765e9.23.1783939495698;
        Mon, 13 Jul 2026 03:44:55 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm318564645e9.9.2026.07.13.03.44.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 03:44:55 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v10 0/7] graph: indent visual roots in graph
Date: Mon, 13 Jul 2026 12:44:35 +0200
Message-ID: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
References: <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260612-ps-pre-commit-indent-39ca72816382
Content-Transfer-Encoding: 8bit

When rendering a graph, if the history contains multiple "visual roots",
actual roots or commits that look like roots (i.e. have their parents
filtered out) can end up being vertically adjacent to unrelated commits,
falsely appearing to be related.

A fix for this issue was already attempted [1] a while ago.

This series adds indentation to the visual root commits, so they cannot be
vertically adjacent anymore making it easier to identify them.

Before indentation:

	* A
	* B1
	* B2
	* C1
	* C2

After indentation:

	  * A
	* B1
	 \
	  * B2
	* C1
	* C2

Indents the visual root commits that have still commits to show after
them, and if they have children it connects them with an edge at a new
row.

If there are multiple visual roots adjacent in history, the indentation
starts with the second one, avoiding redundant indentation of the first
one and cascades after the second.

	* A
	  * B
	    * C
	      * D
	* E
	  * F
	    * G
	      * H
	  * I
	* J1
	* J2

The indentation wraps after cascading columns and when wrapping back to
the initial column if the next commit is a non-visual-root commit, force
the indentation one extra level.

Series explanation:

- Cleanup to bring a common function from t4215 and t6016 that will be
  used in t4218.

- Logic extraction of the chose of from where the commit source comes
  from.

- Add a buffer for lookahead purposes.

- Principal commit. Implement the logic to get the visual roots
  indented.

- Make visual root cascading wrap after 4 columns

- Add --[no-]graph-indent and log.graphIndent options.

GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/29241054418

[1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

V9 DIFF:

- visual roots cascading now wrap after 4 columns. This was introduced
  into a new commit to make reviewing easier because the Main one is
  already big and has gone through multiple rounds already.

- Made a new graph_read_config() function where the calls to
  repo_config_get_*() live to leave graph_init() simpler.

- Added --[no-]graph-indent and log.graphIndent options so a user can
  set his preferences about the graph indentation.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>

---
Pablo Sabater (7):
      lib-log-graph: move check_graph function
      revision: add next_commit_to_show()
      graph: add a 2 commit buffer for lookahead
      graph: indent visual root in graph
      graph: wrap cascading commits after 4 columns
      graph: move config reading into graph_read_config()
      graph: add --[no-]graph-indent and log.graphIndent

 Documentation/config/log.adoc              |   4 +
 Documentation/rev-list-options.adoc        |   8 +
 graph.c                                    | 332 +++++++++++++++-
 graph.h                                    |  17 +
 revision.c                                 |  57 ++-
 revision.h                                 |   2 +
 t/lib-log-graph.sh                         |   5 +
 t/meson.build                              |   1 +
 t/t4215-log-skewed-merges.sh               |  33 +-
 t/t4218-log-graph-indentation.sh           | 595 +++++++++++++++++++++++++++++
 t/t6016-rev-list-graph-simplify-history.sh |  25 +-
 11 files changed, 1031 insertions(+), 48 deletions(-)

Range-diff versus v9:

1:  22ab444372 = 1:  9541b410b7 lib-log-graph: move check_graph function
2:  ebb88c8b29 = 2:  4f8fb2cc1d revision: add next_commit_to_show()
3:  0705ee321e = 3:  b50574bbe1 graph: add a 2 commit buffer for lookahead
4:  fa2e60fb3f = 4:  fc3a8253fd graph: indent visual root in graph
-:  ---------- > 5:  204aae5061 graph: wrap cascading commits after 4 columns
-:  ---------- > 6:  1b42ed86a1 graph: move config reading into graph_read_config()
-:  ---------- > 7:  737331b68d graph: add --[no-]graph-indent and log.graphIndent

---
base-commit: f60db8d575adb79761d363e026fb49bddf330c73
