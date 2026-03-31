Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125727FD49
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937878; cv=none; b=M8o8P1cuQI4Hu073+vcyBubaHT+lrQty0wzbKX7cjNDBWroxD1oeGKLGZWLKwdT1UeqV+IJCZyEFTqFLwCzXwSb/zD9n6tWuC2gXNayyfA3wnMSlPMw8xRAi2K1vtXQi+C9q4eIEgqm2GIMPDqoKYp3XhLnF+sNbHzOySwJ9be4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937878; c=relaxed/simple;
	bh=+gsEZ5HA6kpw1H8n+GFg3W9/94/+aztgPiAOrYUwr/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igsxok37IN6WQV3lO9MioiZ66lkLGr4n8dZLxVzRCwSdA47W6nmfZpiwjHx6n0xeNOGJvIxxjzmTilSSSWSJF4KMGiVbM71Oe602fKb4iTudVpCmz/kUtwVUd6uSKypPHg2d8HqxvCSHvyKwujUPCGSuHWw8JvHrr51PYhwbYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vsi/GfaY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vsi/GfaY"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so1608227a91.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937876; x=1775542676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpLCR1w/yIxtf3tclhwXnzTZA6KSrS9lHm7VW3gjMho=;
        b=Vsi/GfaYDVcyIDAGZuHqbXnfTLq9ljhX3jXVrb1K9tUNE354Gz+eRBr/cn3rgwXNq4
         wuW3493vF4jnUkmqekF1NoMMIxPcVr3fswm4v0okTesZIYh0RgZI9EXUEUsC+AkTKH6F
         SHqLtfLKvqiV0/D0wJBJhISCQtb17eZIfwD64F51QaHnxnQTaHKo5LNkcuLPnShzvU80
         k9okgzwgDmxvrBH22QEjWGIwhMbi+FiRkTJEbv/JkzIGPMmf6DKlmAGDiAJ3Q1o/NLty
         SHZWC3lEboG5mg6kKOEZX9sdvmAgqp6qcEa1Iz4KEnAaw4eXyo6lu8zwfI5fcd7yoR2X
         eKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937876; x=1775542676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpLCR1w/yIxtf3tclhwXnzTZA6KSrS9lHm7VW3gjMho=;
        b=oL4A4tpgg16oAoAekV6A/5aGuIONwikOXnvL2cXyvi8cgNpdlPXrWi5kw+Fkc6Vb96
         KM9callc/mnw822Na8g5SwWYGM2eW+X/Ti9iJYNL4IMdeOxvuvlpAnibo6cYfuNdKilu
         WU5WZWRGJRwRVQB9GrmeBTVKg98eZ1A5HOf4EEVqxAUxN77uuDXYxQD2wl/5aKhSi/SP
         HTUVTiY9kKPkw2TFuhDqg7wYXLLYNhBCw2UTQ6RKxR+rcAl9dPBHIjku9x9MQCoR5CQn
         MskAn9MkXIjTDM9im8Ig2Trqbuqu6AUdBld6td6DaUTNY8qFkaruh56RCX/O6GtfslTJ
         PCKA==
X-Gm-Message-State: AOJu0YzudebgDQj0UzfR6Ta0VxQLi6WSoJ50u0TEN6DvSPBgizNbu1Uq
	Ni9/eSh+iPimsQoi7xnRwDBDxba7V19IU4dRozcy0UULnKedhVYoYRKEdfxBy1zk
X-Gm-Gg: ATEYQzyBcrYXbCzgCiLqJk7THkWZsBk2AGAg74tXxLrEb8Qd5IK/B1pB9bsSrjth59j
	eUyjf5QXNgyx9lSEkYrMnSx49MJ/aoKVQ0vjS7ttMFmi/6j5dIQIJmUhi1vomk6OTYjmwsAefRZ
	BQUdMVQyfHjv6XWNstDLDkAgkcCGw4ubi+Mi4ix2Ov4nH5ATFncYB6NTMqR72Go/LociFgJJPO/
	18HyW1TS15nWt+2ZKHTdK17RPEHAGS8JUdWsjpwkzsNbY3tOpmYlxamxwX3ncWkV8Q0H0L//miE
	/bUqYY9w25MRllBcyUV2Rpoad4iuc92Ns+Oy1sJcwKLld8mCDdbo33DTygVhZ2WFgK5y54GcKR6
	HYDaRcfksW4djJAyPDrR6C9NIV0L8/m+mfBNHKqRZ/U2SUbrobRA/R7U9lINk6tr5rEkh/COd+T
	UYaUm2DH9TDB/h7muqUbtq1Va4OaRga0Xww8Y3dfidNGvk9CvPgAHA16khVdShTxEO8BlNraJ3F
	MZKNJnF/w==
X-Received: by 2002:a17:90b:3c8a:b0:35b:e4d8:e21d with SMTP id 98e67ed59e1d1-35c2ffb7102mr12407468a91.2.1774937875955;
        Mon, 30 Mar 2026 23:17:55 -0700 (PDT)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76b173a38csm834055a12.22.2026.03.30.23.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:17:55 -0700 (PDT)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	gitgitgadget@gmail.com
Subject: Re: [PATCH v11 0/8] fsmonitor: add Linux support using inotify
Date: Tue, 31 Mar 2026 00:17:54 -0600
Message-ID: <20260331061754.83335-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqjyus4qp2.fsf@gitster.g>
References: <xmqqjyus4qp2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> In any case, when this topic is merged to 'seen', it seem to break
> linux-TEST-vars CI job, which essentially runs the build and test
> with these settings:
>
>         export GIT_TEST_SPLIT_INDEX=yes
>         [...]
>
> and t9210 fails with this topic merged (abfd972), and succeeds
> without (4b8355c6f8).

Thanks for the pointer. The failure is:

  BUG: fsmonitor.c:27: fsmonitor_dirty has more entries than the
  index (2 > 0)

It's a pre-existing bug in the interaction between fsmonitor and
split-index, now exposed because fsmonitor-linux enables the
daemon on Linux for the first time (so scalar clone actually
starts it). It needs the interaction with
ps/setup-wo-the-repository in seen to trigger.

This is related to the issue that 05f28e4b3c ("scalar: use
index.skipHash=true for performance", 2025-06-04) worked around
by disabling GIT_TEST_SPLIT_INDEX in t9210, noting "the issue
should be resolved in a series focused on the split index." My
fix covers the fsmonitor bitmap side; the index.skipHash
interaction remains.

The fsmonitor_dirty EWAH bitmap can reference positions from a
previous index state. With split-index, cache_nr can be smaller
than the bitmap expects. Two places hit this:

1. tweak_fsmonitor() calls assert_index_minimum() without the
   !istate->split_index guard that the read path (line 98) and
   write path (line 128) already have.

2. fsmonitor_ewah_callback() unconditionally asserts and then
   accesses istate->cache[pos], which is out of bounds when
   split-index hasn't merged all entries yet.

I reproduced this in a Fedora container by merging fsmonitor-linux
into seen and running t9210 with GIT_TEST_SPLIT_INDEX=yes. Fails
without the fix, passes with it.

Fix is pushed as a new commit at the end of the series:

  fsmonitor_ewah_callback():
  -  assert_index_minimum(istate, pos + 1);
  +  if (pos >= istate->cache_nr)
  +      return;

  tweak_fsmonitor():
  -  assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
  +  if (!istate->split_index)
  +      assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);

Paul
