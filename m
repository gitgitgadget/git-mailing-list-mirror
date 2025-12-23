Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F092D94A9
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488295; cv=none; b=P9+OhZ63yYNKHjvfA3qCi43Dn9g/NIYkhgdmfUnBGDNWaUq9pUK/qmcXUHkA1iCLC+AQM7S7VDKfpDKAWh1/RpHW6xNagHjmURdl8VPVIcDj0NPBJkY/5ExvnKFU++bH/y4sU3SAIUP/uJkpe0cymeW8f/0bMmrx1/jj5qx150s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488295; c=relaxed/simple;
	bh=1NmVDs6/3bNv13P2r5m6ImkTpbXFwC2khAWfxSe6di4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWoRorg3dgX5EjWKgwBDslIQXxE3tNrCYlL+Zc4sQEIc50TkMeWDCwztoaN+fO2hXznRXJ4YHCDlyS+I5nn3Q6SzDvZFblFwRR7G9N2CA4AoOsA4opOxogzkxHqYkZKvqfyMnVHWC2U/Qdhrf2ScWjPbM26nbtGD2OPItX49Ksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb7XeTtI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb7XeTtI"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc305914so3676184f8f.0
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488292; x=1767093092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ll0zVyna6uzkrdt1IrRHCtN5E80jzqr5EcPHi0cJZvQ=;
        b=Kb7XeTtIzEpVJPgt0cI633drN6udrwaC5Om2Rz3fE44x5UrMZGUitOs4UJFB7ismbP
         mhNOq1pkxFu18IT5yfk2sd+1fA2lC01VQr3spJojt2xerJcFgt4fpZZCT4Lu+kW5fBwe
         ijQE16c5WMO8Z24W2+nsBnRhTflP6CrvUtk9xkOXOBKhiTn/zHyyQYHXQoVoX4p0tcJu
         1CT1MuRvr31tMduihnnM5PbPp8cnFK0bvQFQL29ssNdejWeyRdwtzyVSS6X/gLAIW3A5
         bw8okJrbtQr8tssLTsofp1forGGTp+4T4IpCCREzDN3FembLvbD/4armX51d5Rpv/N4P
         ICmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488292; x=1767093092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll0zVyna6uzkrdt1IrRHCtN5E80jzqr5EcPHi0cJZvQ=;
        b=RnCDl2nnMgthDJs014tCzEs7+RS20t+t5yR6RDeGbLW4y/qI155KazJNgwXcjoJCA8
         RMatXUvHgwSzRpW7C4JmRky3v8qzQU/HIpWJPpZXYfOLkw2vJ2JxeFGOSAqiOWkQqcIp
         3XOz8D77SUw5F3n6JtH4YuIPXLNpJj/v3EMoCgaTHPV2XSqQHJQfQdpICQNu645RINiv
         VS+L+iiahtnbulv71kDRN7AYATaQs1jZWUj2pBR65sP6u5emT6yyz0V+RDvDcG1R75G0
         dBOMnF5fwCNWvSOiJIVbyL1zmZ1XDpZeMg7zzcdtXLuLLEO/nfMT2livHeGnIXRCBeAM
         0bKw==
X-Gm-Message-State: AOJu0Yy2hqB2uJbqdGWmigCHsO3rHqRq5p+mFWQK7RzBPrulm44tER5M
	ZzRJtKgWo4YQDzvb4XFD7mrXmCYvp6xxGtgyZXu/stq6tXlKYA7hHKaqxpXXpw==
X-Gm-Gg: AY/fxX6eEX6Dr95vJ1tYIDJ9jaAeD17LQ6lGQI1dTSGHehNRMP5MrvEQsVXJ3WqFXqs
	Ix2OjYWXPKPFgzzimrYd+4tTW42JG7iu2ReJ6oX+wLIeOfqM1XFpY0jL2CEhGDa+GX6KICfHNw2
	GMOzPYXRVRvu35lG8a1eq/6obONoLAwyvjTna6RQu/UwtCNWI5mXDq8XHt9f5lo+PuLNeut9oMg
	sj+KupEWqScMgU7E2xNr7jKnqJivwCFW+NDf6lPHHloBiPiOnKpHL08/s8RjY7OSjWdd83Qexf3
	5e7VdeETPx2+xhdFQjeDG48aeHGo/PJwvd4I6UlUF7KgTbvfNea0JeUpZEJ1/CI9GCzkWYA1oKP
	/N/ZPBA/CTO5N0rM42AA3Pff+9udtMZ4KCyg9LWqT2kef6GpSMyBYqc5KAWFcICZ0uPd1p4GIN/
	zqoTr+xgFzamFt3Wn6oGCCmTcozOF2D01CA9T/mDI6GXq3fP/7VcMtmpi1QJZwLFl2aeuj3IjND
	T4VwpN2a8MmgzUd2May63lGjGU4ItBzJGW+Yg==
X-Google-Smtp-Source: AGHT+IH0IUV1iBZlkoDbDUXaVJ9jEMjJ12cm9wJW0716JiD7I88cMzKF46eRKBRMRx+r1KGIDUPnHg==
X-Received: by 2002:a05:6000:24c9:b0:430:fc0f:8fb3 with SMTP id ffacd0b85a97d-4324e506148mr17127634f8f.38.1766488291473;
        Tue, 23 Dec 2025 03:11:31 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227e0sm27932795f8f.17.2025.12.23.03.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 03:11:30 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/9] Implement `promisor.storeFields` and `--filter=auto`
Date: Tue, 23 Dec 2025 12:11:04 +0100
Message-ID: <20251223111113.47473-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.319.gfcaffa7898
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduction
============

A previous patch series added the possibility to pass additional
fields, a "partialCloneFilter" and a "token" for each advertised
promisor remote, from a server to a client through the
"promisor-remote" capability.

On the client side though, it has so far only been possible to use
this new information to compare it with local information and then
decide if the corresponding advertised promisor remote is accepted or
not.

For the "token" it would be useful if it could be stored on the
client. For example in a setup where the client uses specialized
remote helpers which need a token to access the promisor remotes
advertised by the server, storing the token would allow the token to
be used when the client directly accesses a promisor remote for
example to lazy fetch some blobs it now needs.

To enable such a workflow, where the server can rotate tokens and the
client can have updated tokens from the server by simply fetching from
it, the first part of this series introduces a new
"promisor.storeFields" configuration option on the client side,
similar to the "promisor.checkFields" configuration option. When field
names, "token" or "partialCloneFilter", are listed in this new
configuration option, then the values of these field names transmitted
by the server are stored in the local configuration on the client
side.

Note that for security reasons, the corresponding remote name and url
of the advertised promisor remotes must have already been configured
on the client side. No new remote name nor url are configured.

For the "partialCloneFilter" field, simply storing the value is not
enough to enable dynamic updates. Currently, when a user initiates a
partial clone with `--filter=<filter-spec>`, that specific
<filter-spec> is saved in the client's local configuration (e.g.,
remote.origin.partialCloneFilter). Subsequent fetches then reuse this
value, ignoring suggestions from the server.

To avoid breaking this mechanism and still be able to use the
<filter-spec> that the server suggests for the promisor remotes that
the client accepts, the second part of this series introduces a new
`--filter=auto` mode for `git clone` and `git fetch`.

When `--filter=auto` is used, then "auto" is still saved as the
<filter-spec> for the server locally on the client, and then when a
fetch-pack happens, instead of passing just "auto", the actual filter
requested by the client is computed by combining the <filter-spec>s
that the server suggested for the promisor remotes that the client
accepted. This uses the "combine" filter mechanism that already exists
in "list-objects-filter-options.{c,h}".

This way by just using `--filter=auto` when cloning, a client makes
sure it will use the <filter-spec>s suggested by the server for the
promisor remotes it accepts.

This work is part of the "LOP" effort documented in:

  Documentation/technical/large-object-promisors.adoc

See that doc for more information on the broader context.

Overview of the patches
=======================

Patches 1/9 and 2/9 are the first part of the series and implement the
new "promisor.storeFields" configuration option. Patch 1/9 is a small
preparatory refactoring.

Patches from 3/9 to 9/9 implement the `--filter=auto` option:

  - Patches 3/9 and 4/9 are cleanups of "builtin/clone.c" and
    "builtin/fetch.c" respectively that make the `filter_options`
    variable local to cmd_clone() or cmd_fetch().

  - Patch 5/9 is a doc update as `--filter=<filter-spec>` wasn't
    documented for `git fetch`.

  - Patches 6/9 and 7/9 improve "list-objects-filter-options.{c,h}" to
    support the new 'auto' mode.

  - Patch 8/9 improves "promisor-remote.{c,h}" to support the new
    'auto' mode.

  - Patch 9/9 make the new 'auto' mode actually work by wiring up
    everything together.

CI Report
=========

All the tests pass, see:

https://github.com/chriscool/git/actions/runs/20455758377

Christian Couder (9):
  promisor-remote: refactor initialising field lists
  promisor-remote: allow a client to store fields
  clone: make filter_options local to cmd_clone()
  fetch: make filter_options local to cmd_fetch()
  doc: fetch: document `--filter=<filter-spec>` option
  list-objects-filter-options: support 'auto' mode for --filter
  list-objects-filter-options: implement auto filter resolution
  promisor-remote: keep advertised filter in memory
  fetch-pack: wire up and enable auto filter logic

 Documentation/config/promisor.adoc           |  33 +++
 Documentation/fetch-options.adoc             |  19 ++
 Documentation/git-clone.adoc                 |  25 ++-
 Documentation/gitprotocol-v2.adoc            |  24 +-
 Makefile                                     |   1 +
 builtin/clone.c                              |  18 +-
 builtin/fetch.c                              |  50 +++--
 fetch-pack.c                                 |  20 ++
 list-objects-filter-options.c                |  71 +++++-
 list-objects-filter-options.h                |  25 +++
 list-objects-filter.c                        |   8 +
 promisor-remote.c                            | 222 +++++++++++++++++--
 promisor-remote.h                            |   6 +
 t/meson.build                                |   1 +
 t/t5710-promisor-remote-capability.sh        | 109 +++++++++
 t/unit-tests/u-list-objects-filter-options.c |  86 +++++++
 transport.c                                  |   1 +
 17 files changed, 663 insertions(+), 56 deletions(-)
 create mode 100644 t/unit-tests/u-list-objects-filter-options.c

-- 
2.52.0.319.gfcaffa7898

