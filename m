Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E7200BAE
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563521; cv=none; b=tPQNn14GFlVEoP4koLqpE+d81yHwS1TBTY5GmZwaQVYtAnQqz3AbUK19zSItO73JLvs1ec97mV5JG0iAJ8Lg9B8H0QNsf11nmGVfPS6L4iEzOu9l17zLIXQZMcHTIBPzV0h75+xmVjji1lRCddh9z3sLTXokCs3noYV0UezwGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563521; c=relaxed/simple;
	bh=rgVPjLhhthMxmHRDmXwl5h9FN/htNCfA1cQeH59dWAw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IIpx8I5D7JSUBl/dWIykb2JwTRW6RAVrdGnP6pnzZiaO7qsMM3SMxWs/1t7Gj83tYxRywdQjMAomvtmrRnYWlLBYhJ71KUJP9ftrd3d0nwLqgR5SEQOCm8T4aoN08R6kfpKdRmiPYiSZIc88ixZDRRo0hNsCVErLWpWZcMLAViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAy8yxpm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAy8yxpm"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b07d4d24d09so2095566b.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760563517; x=1761168317; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8IWIXFP5Mm/2s7ABrcIE3wuP3n95XmyxIzbNFvZYlS8=;
        b=SAy8yxpmOrhJlruQlJ+G69f7H3oMK2YjYilyJH7KxkekyHt6Aebbx74/FwSxjCFz+V
         g/nxeRzaqWFiCFBcAGNv30E8ZPvtrHnOvwSChFonKBowE34nfd80eqHppzwe2q8f0jU7
         CQ7Aq5GmThXM7EDJHlVp6McHm1R0MM6qIgUL3cxQbyYmCAJjaatVqgEG8z1nn+hMbsy0
         J1kPXp3nRNeD5hCBboVidnwePJMu4y+4/3EC2k+P2AeY3G3z1uTP4pkj3H/1PjTcOq7D
         pAVsiXNfUCBP7yxQupPUDhIzWkihRBCXGuCwqKWZuZZZDBV/Q5FFnLz4c79uV+zrOpjM
         iq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563517; x=1761168317;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IWIXFP5Mm/2s7ABrcIE3wuP3n95XmyxIzbNFvZYlS8=;
        b=pdcGBVzmrt50ED7nr1rGmrZhMPEo+yuMdKJRmu8W+3Ok6AvR/3d8LORDHqpKpS5LJr
         kpeoNFVxJ/wxUhQ10Vyzw4HwJ/UVjUOvPQqZlJ2ZMY3xTn3BeEcuAFCtDVG3S809wsTT
         lWoZ4CIwhUkbkUHExYJxd4QX45mtY2qt87Q23uX9EmeVEiutjuSKKllHYVh2ezkbnxsn
         x8SKuUHiGl5Qp7wEh7VFIeDVQzjxolSVTciiCc5iItfDvp/FUSbhKRitbvbHxBRf83B8
         WZPJmiNnPSP+Ma3TDAYEXH8a4tEczLZr8JqdV5t8T+7dNW3nYNOLO3mM3paONTWvI9E8
         ZPhQ==
X-Gm-Message-State: AOJu0Yyb2qdBTNvE8hTdtSwdXFNAbj6nPngVKsKEgKVxG4sFgEezPrOz
	lGgu4uycFkWgYRvQl7i/rJRQt1pPUBwZkuaDZi26Uv/q9qspwmypHPPZfamEyEHr
X-Gm-Gg: ASbGncueBg8AmGAhluTSK8zgBuUmN4kFQPK5Vv3MOHNJOJKUY/nsZgE5AOGRyVzrTYL
	rr+b1ROf663+MITqe27Zy7Rc9/YWJPpd0QiH8TlgNFRSFY/m6J3GqMFOK/n6KRg6artHXHa7P5R
	JiTHAlKPH/WjT8XdZM2sXrAYtFwbqeSp9MLLMlctGyAIb3ts8J/y/VKizhxELFLVTryrOVRfgPH
	k54Wm80JeYLzpcTXb09B+Aqxp/k65D7F9itNVuV3Gxj3220/eelxETxN7jCwCmc9zzjEtHcEnJG
	YzjaWucmwTDKNreOWFzjFznTZwt+6UbwOZyCkAY5ujb4/1BwgBY7fWl0RPSaC3+LuDpVN+s13in
	erPLpExByvcOy/h690Ot1oztnBgJ4isbMOdguueMSxXNLFgYPKVNb6OewHjF0Sbw1OrlWJXYjs1
	bmdfDwqb/X
X-Google-Smtp-Source: AGHT+IFMsVjR0iQz7MFfxWZYmukwTb8dzysvRfyc0Ek43VeyJ2Tt5h1GwjEiRwApN+QW+yOG6mi3lg==
X-Received: by 2002:a17:906:c141:b0:ad5:d597:561e with SMTP id a640c23a62f3a-b50aca01320mr3357766566b.56.1760563516862;
        Wed, 15 Oct 2025 14:25:16 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:980b:e8aa:7473:ef22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdaa082sm315854766b.50.2025.10.15.14.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:25:16 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/4] refs: cleanup code around optimizations
Date: Wed, 15 Oct 2025 23:25:05 +0200
Message-Id: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADER8GgC/x2MQQqAIBAAvyJ7bkGDMPpKdJB1q4VQUYpA/HvSc
 WBmKhTOwgUWVSHzI0Vi6GAGBXS6cDCK7wyjHiejzYSZ94IUPSNd7MKdcLbGWWJLs/fQu9QVef/
 nurX2AXYV5QljAAAA
X-Change-ID: 20251015-refs-code-cleanup-871a7ce7c8dd
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=rgVPjLhhthMxmHRDmXwl5h9FN/htNCfA1cQeH59dWAw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjwETtgZEHXxLig8MYhryJoslNkelvX01LGd
 syZzEpbJ2fJiIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo8BE7AAoJED7VnySO
 Rox/ACwMAJzvELNaetlRCGw5irdwIlvKeEefBNoUWf3xbmKytt8+SMCVZ/pafcpjjl4J3vi/LNv
 J/1zKzAnojn1pBsJHkAIE1suOPqD3nC8Nfhj1IfKMQWYsSsbeig87ft6xpfyp90uhf+NvY/LBeF
 Wi/TNjpnApCN9MZtV4PHgBPJPblgp+yYuMTOzVWet3/MPzWIxMrdCreYRBG+eT68Z43fKOjxo+R
 +CVc5VoLyTvsA5UIJMwoyVRcQvNS3T0au2jv7RH8EdBSgPM7LC6/743T35ax98sXiL1NL/CbkVs
 v7MrJmN1y285KXWZyp8/o6y3ZrIhl50hD0tUSakJY1dKCOt8807YvWSQmsezKEDXrFAH9WtCLxZ
 TjKRFWysmd4Q/SziP/P/pmB6Hy8YPA/uFIvt0BbcHWTEe5xSj8H8vl6rZ+12NLoDgvCq4uUDJ7t
 EXcK6l3s91KwjhUmYqeFluoUirda9CIvtxG+k2n2VVU1GdYaaDP+78vElvmFiwP0x3xS4dz5gp6
 nQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This is extracted from a recent series I sent [1], which I've since
dropped to follow up with a different approach. I think these patches
hold value individually.

They mostly cleanup code around 'git refs optimize' which was added
recently in db0babf9b2 (Merge branch 'ms/refs-optimize', 2025-10-02).
The code in the refs subsystem contains both 'pack-refs' and 'optimize'
functions, which are one and the same.

This series unifies this to only retain the 'optimize' functions and
naming, since it backend generic.

This is based on top of master 143f58ef75 (Sync with Git 2.51.1,
2025-10-15) with 'ps/ref-peeled-tags' merged in.

[1]: 20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 pack-refs.c                   |  8 ++++----
 refs.c                        |  8 +-------
 refs.h                        | 24 +++++++++---------------
 refs/debug.c                  |  8 ++++----
 refs/files-backend.c          | 22 ++++++----------------
 refs/packed-backend.c         |  6 +++---
 refs/refs-internal.h          |  5 +----
 refs/reftable-backend.c       | 15 ++++-----------
 t/pack-refs-tests.sh          |  2 --
 t/t0601-reffiles-pack-refs.sh |  2 ++
 t/t1463-refs-optimize.sh      |  2 ++
 11 files changed, 36 insertions(+), 66 deletions(-)

Karthik Nayak (4):
      refs: move to using the '.optimize' functions
      refs: cleanup code around optimization
      refs: rename 'pack_refs_opts' to 'refs_optimize_opts'
      t/pack-refs-tests: move the 'test_done' to callees



base-commit: 854a80fd48848f942c4a566c9880dc5f089887af
change-id: 20251015-refs-code-cleanup-871a7ce7c8dd

Thanks
- Karthik

