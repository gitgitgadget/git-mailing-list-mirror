Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A553DEAFB
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679861; cv=none; b=SU1tIcF/pY/8+Bly6yXhp+L7bpmrRb7tuxCgv1DQS2UtSiRfNJBRcAr8ob1BxGl6zgV/Qxtmsw7v2QhAlqp50Qy8Cs+iku4pAqWetghPMrl8Hm11XW7Cg+J7JFgAgyUgenST9G8BOBKiYPks8WcsPY540CPV0NlVPc2xPESa0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679861; c=relaxed/simple;
	bh=y72Ra+CpcbaXInX3Q7CHmeNjIHNURpJ0tBoiXxtoyN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJz6LC+J8TUwjJKSzIFT82It+HA4XQBLEe3ijh2Oy3J9VLTWEP5rwzBw54HAEstNQPXBybUle6N6Clca1Gk6b2YdzHyX5NIKUZ+OBwi/chGhNRN95L59ngxqDh05a73SscKmLDHkjGz4B69YoAwkB9ZNWra1p9Q9DwRVwVqpWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdxYJAk7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdxYJAk7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so5266725e9.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783679858; x=1784284658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dEF+T433KBeJuxES+DtcmBg+6u7OGub/H91sE7QDtas=;
        b=FdxYJAk7E+dmk+xApBROs7F9djCNM1H3izF+8lbkzISa7W7PhM577u0F9HtJyFwv+6
         nLkeYB0gnRi0O8mNjoUBrsjv9mi7VACHNHHBmhNsDDz44hmayhzqPHrQWKS9ngEh9cCp
         bEevMatFJsMV+7b7Qs4n1OdoPdHUhh3gXjuOgdVxo2rmBc/Lk+PiLtlsC8peehKbb6hN
         vRXH2lyxAw5PmxvcGnCzTd4MInqOp1xfV+/YHY2M9A5XOq9VD8licAQFx0qkSBVkNdNV
         6FqxoaqVWAMlYmOGKJ3xCI6INCLPezyzDaNLEkCa2qrRReEYagCf6DFVIsFHK3fkUGVb
         AL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679858; x=1784284658;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dEF+T433KBeJuxES+DtcmBg+6u7OGub/H91sE7QDtas=;
        b=M82sYj4j8gJpt+ExLIL3OmLB4R86P8w4Ve9caFIMxUIlS0qOWU/ghJlD7z723CFX//
         BmXvmgpX5MfwsGlRwBfqyd4NvE4wMwjp725Gw4NMjL877oIL35OTmQsYEmKvEyb95iZJ
         pyjuT9cZLOJ5pjZJJIqPCe4T9d+ZEy60LaWZWXriGezT+EOYqntFRoEdNfAhYmZg67Z9
         Vc+OcQflMm0CcXh/PBDCZ0bwE+KpUrAzANfiHncd3JtHjjkqzykR0EgrE/Ersyz43mEf
         yeTRjUdRGYiEn0VuadFo3CR/mnHOzUHlb+vhdukgdF2Z8V2BDPHsavgiVLF0DjE6NjfT
         2z2w==
X-Gm-Message-State: AOJu0Ywsd0QYACakNu57M3fM+g0s4L7ANsztDl8SFBFSVtTHj5OG0u1o
	pYbDvgj5Mvn6ighc2VJZP3kuQZ0ymoau4oSFncK9YVnh4h4ZQbQTUA/DjiXXbprP
X-Gm-Gg: AfdE7cl+sGWAzeD/Jg/gQpgJsdyUQpPhX3Eej+E4xhBULa81+9yofn21ZtfPJiCR9+D
	7/yTiCL7HS3tmn85eH7bHpX2CovVspMPHZ63RRBbQy1IAK2cPVo7+lUnhN+sCsiOd3lWoVZDJKP
	F4He1gg4QwIkHcFnlTvoDD3E3CwMBRm1yLRemIX+XNMsF3X1RoQHyHzO5QijbU4E+JfSv3I4tIQ
	Q5V0X4Tt7O7qlGM76nYJbQd5qUbnvb9U4G7fqjAPM6A+l9cEeuLazefzOaXiHC7joLcLBoaC5A3
	60uBMRD6h47VlRETLdMuHic61AkK0gfZrBxmm7ypSSmBqp1NUkF9v14bJX0yVk0Qa5hpInQpTLx
	vClZrAtPCYQ08m+s1vzuYrEKfH72aYIalKMixKcCNZTCtrht1bUU4dHLCPMWewJ3zRvTGPCL7oq
	sG/zQAPwOVE/P+dkp3ctr4+Whj8Xs5QzTaFcdg3xNOs+H23tmvIZG5l1kLM4hG+P5tokm5clxUf
	kq49Pz+e3WdqZAxKItzUxR4ARyNOw3mEiHobCBYAPVzTGkuODMw2k7Q2q1KwAklNxUUW92wfwuP
	el3tVP/UXB5y3EXpKLhoCp1EUPqeF116Nz6kigs0c7sIUjAccu9zyAeRjwJc80Jo6jwg+0SrJGK
	Uiw1Ymd3BPA==
X-Received: by 2002:a05:600c:8b09:b0:493:ee3a:f05b with SMTP id 5b1f17b1804b1-493ee3af190mr57723685e9.7.1783679857835;
        Fri, 10 Jul 2026 03:37:37 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f25b23b7esm4222784f8f.18.2026.07.10.03.37.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 03:37:37 -0700 (PDT)
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
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com,
	mroik@delayed.space
Subject: [PATCH v8 0/4] graph: indent visual roots in graph
Date: Fri, 10 Jul 2026 12:37:03 +0200
Message-ID: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
References: <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
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
	* D1
	* D2

This series first commit is a cleanup that brings a common function
from t4215 and t6016 to a graph functions file which they both use, so
the new test file for indentation, t4218, can use it as well.

GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/29082267633

[1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

V7 DIFF:

- New commit (2nd) "revision: add next_commit_to_show()" I wanted to
  drop (!revs->max_count_stage && !revs->reverse_output_stage) because
  --reverse is not compatible with --graph and I wanted the indentation
  to work with --max-count-oldest. Dropping it broke tests at t4202
  because the lookahead buffer was being populated from a different
  source.
  This new commit adds a helper to get the commits for the lookahead
  from the same source.
- Typos and style.
- Added --max-count and --max-count-oldest tests.
- graph_get_lookahead_room() now uses ARRAY_SIZE() instead of the
  hardcoded size 2.
- Added an assert on graph_pop_lookahead()

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Pablo Sabater (4):
      lib-log-graph: move check_graph function
      revision: add next_commit_to_show()
      graph: add a 2 commit buffer for lookahead
      graph: indent visual root in graph

 graph.c                                    | 286 +++++++++++++++++
 graph.h                                    |  17 ++
 revision.c                                 |  48 ++-
 t/lib-log-graph.sh                         |   5 +
 t/meson.build                              |   1 +
 t/t4215-log-skewed-merges.sh               |  33 +-
 t/t4218-log-graph-indentation.sh           | 473 +++++++++++++++++++++++++++++
 t/t6016-rev-list-graph-simplify-history.sh |  25 +-
 8 files changed, 843 insertions(+), 45 deletions(-)

base-commit: f85a7e662054a7b0d9070e432508831afa214b47
