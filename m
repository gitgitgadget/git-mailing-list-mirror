Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513566;
	b=1xWjtI1p0Uxlh15oIGautYZQvlVMw8ug9/W68bASZEyRDhQhqxqwa+GcU/QzYJQlThYx
	 KZ2PGEmouIWbKczjUQjNF7IbDdYXdaTQSMb+Cs8GuggN8Cdipt31jtA5pmEdjjc7kxXj/
	 swRLt7SRt2pfH8EggnAfmPHTliKPHFjH2Za78XyDaD1LcuQjMx4PjOxidh4g39IP9nZQ/
	 XLSfHKl229UjOPNhKqjBH9QJgVPL9K0LsKPRW/gj9HiWUCxcHksdLC5Cf8UvVQU0VruNH
	 EGNw72UAY+6yqbMQiYPvHYsKrK3pPb1WoTWmpcMx7Nfe9thTCd+4f7jY0KVfr1tsFmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8qj8ovk8UJgh1XgIG9ikrTPmnxrDNA4/ynvTv2RbAsw=;
	b=snPImFBydsGNOvuo6Cj/d94IjXPgduYZdu0upT4faMveTOSPirMkuGGocxdB0PkSn67x
	 MciUtDb4vKvvMpCkB1DSVMho+yE4MGrR0r4KZnckaouj43qDS7WCsAofQnx2I4vBnFVOm
	 1uDmHx6TbdUUIQp6KtDAmfI8CZsIGnR7GQalqMumgx/4ZKcdOjKDMOBEjxzEJBofe5UqE
	 wWJpESZqTqP62uQtAFXkEyw8U1HLJng/wLvj1SVGyFYGJuHgeeERDUjdufisDHE4dNHBL
	 ZdF25WVCTbGR+X5BU4cOPrfwDgVHgs9m07IOPfneCvjGv2B78EiKeWusYhIeKCzsJgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j0BrLaEi;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFCB606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AFCB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j0BrLaEi
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so173386c88.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 11:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513565; x=1795118365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8qj8ovk8UJgh1XgIG9ikrTPmnxrDNA4/ynvTv2RbAsw=;
        b=j0BrLaEiAcX0fp6N0SLdC30eCOaMn1WJowfzLg2hmqEFWb1qNm9/LimQsKOYPd+vF3
         BOtlK0bwigTDK+ntwLs1bvAEuwyB8KXpvIfTZP0/Jxx7UXsV54TktJoQG1Cr0I8I7X2f
         uO11NJyYNeauASzgIHyLjwM8LkI2oAiLSv9Jf5PHRJHLebvRyufCPkAm2Av0NhlNojpV
         nLqoHW/MoQP+BCofwBi2lcxw0vhJYRvVCgYkBkACR8G1jGXV6+zs8zPu78LOAOChwinK
         qjiFVE6xcDQ61yiA7CdhjheRZAaso5WLIHYvkjKOduMe15t5DP0M6GsUv8avfR1Sw9Du
         uMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513565; x=1795118365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8qj8ovk8UJgh1XgIG9ikrTPmnxrDNA4/ynvTv2RbAsw=;
        b=ccGg2iAiC5lnPDj9WyYh3NgcAakhQyRa2F1laesX9nR/qwOsPWyGjU0NEdBWcg4Dcf
         HdqdR+nD8+KnIyPZSFUVRTZsEiqNts5ETBh6qvkKfgDORIA5zjYPDZE5J8RncL9t0gut
         g5fXvJWuMmoYLIm4H/Z7kvX/meSePPUdUILvhYxSmXb54s8iN52ndKOq8rxRDusmDyE7
         T/D1iTiDGhJzkRZCPJqyHz5MXJh0c2mWPVB/HM4rhn3WW+G5ur6uG7iBXT1QuE1+8STD
         89URBDroUwVEzp/FDfIroEeNpoiG5eE2So3HbJQdKrZBodzu9PnPNJgDP74L1sPXcOEL
         67TA==
X-Gm-Message-State: APuU4Z/Hv8a+VeflYnGeMEs8gF6MAgJbzyUMJmDIopPq0v9B+wUGKYsT
	Uaw9PimCU0RDMuPWNhEO8nTenFO68XyhnWkWcv5P+N3kYG0uxyxdbsGyah/t/a0s
X-Gm-Gg: AYBFou3ymmC9oF6ustCq53pImfCj2ys2bgq5gdv3GwcB2aJbE2BOc4n4AfHjtjshd9a
	wLNYNaM20K/NY6hT8pzT8fc1jbV54gEEz7DK7z1c9psZ1D77v9GPfbTE8EfHZA0KiAMI4uGLf5O
	xSmb5Xrsh4zJ7uKjHHcmMFdRHWVrG4Lr2WPo/8dhQDGfFkwc1KAprQmlA/dMdFBzEQvYrQsgmIJ
	JXl5PSmccV5gkzl+rGQhtw/02i8eDrot2Ns6wt25wPytirLtETuJzv01LWWeP99nYRSTZmka3XD
	PKK5dVjNy1qqQjxIFdCslWSRWjOraGdSmnTJrneMznrw0XAWMy5MxKXr3KPunTGCU5S4h7nkSC+
	CqCk85qv/shefmd5vQJGckr+654llKGYK5F54z3uu6gN0pe0oxH9BjjcriDGm8MlGx3ZAa9ERm9
	ylMp66WSlscGdssIbHR4HwXvWX80d4OjEFjseWJ5kevXunmmFLK4/3ApN57RxqmbaoKgVU9nbVR
	YdYD+vuenTVIVXjTTKBNihypa0ww/DBs6slNopKUNmBaAtScYFj6wlMCZK+z7xCuVcGNy4PJQce
	4tGcCGfgQ8JKvod2OBhtMFHIj5xYmxIYrLuBmxUBWGdg2nTvQTE3df/l+nYBPUR5p8oG3CV490v
	CUQSqfOLXq9BQ6JQg/J2rZg9GiOJrcKGSjmzz6XRBqSNxM+zjJzLhRmHtz9nW8d766stwOW/OaM
	kvTKghGZgzHPG4Q6VuRv15ZRd5vwtkjuYKBzgGAM/1xiAhbcIR1nWvEtJklQ==
X-Received: by 2002:a05:7022:ea8b:b0:15e:9126:c60f with SMTP id a92af1059eb24-1b5030e2ef6mr429815c88.29.1794513565058;
        Thu, 12 Nov 2026 11:59:25 -0800 (PST)
Received: from christian--20230123--2G7D3.nvidia.com ([216.228.127.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316fdsm640395eec.5.2026.11.12.11.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:59:23 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/3] Fix promisor-remote reply missing from fetch
Date: Thu, 12 Nov 2026 20:58:59 +0100
Message-ID: <20261112195858.53788-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.471.g1891de46f7.dirty
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

This small series fixes a brown paper bag bug in the "promisor-remote"
protocol v2 capability found by Matt Cote during the NVIDIA hackathon
following the Gerrit User Summit 2026.

The client doesn't send a "promisor-remote=..." reply with the `fetch`
protocol commands. It does send such a reply with the `ls-refs` and
`bundle-uri` protocol commands. So this works by luck with a Git
server over file:// or ssh://, as the same `upload-pack` process
handles all the requests and remembers the reply from `ls-refs`.

But it doesn't work with servers that handle each request on its own,
like Git over HTTP or JGit (so Gerrit). It also doesn't work when only
object IDs are fetched, as no `ls-refs` is sent then.

In these cases, the server doesn't know that the client accepted a
promisor remote, so it doesn't allow the objects available on the
accepted promisor remotes to be missing from the pack, and fails with
"could not fetch <oid> from promisor remote".

This has been the case since the capability was introduced in v2.49,
so it would be nice to have the fix in maint too.

Other related issues were found during the hackathon, but this one is
the most annoying. The others will be addressed in separate series.

Overview of the patches
=======================

  - Patch 1/3 lets write_command_and_capabilities() send a
    promisor-remote reply, without any change in behavior.

  - Patch 2/3 is the actual fix, with new tests in t5710, and in a new
    t5711 test script for HTTP.

  - Patch 3/3 documents that the client should send the reply with
    `fetch`.

CI tests
========

Some failed, others didn't even started, see:

https://github.com/chriscool/git/actions/runs/43285535901

But the failures all seem related to the test infrastructure.

Christian Couder (3):
  connect: let write_command_and_capabilities() send a promisor-remote
    reply
  fetch-pack: ensure fetch sends a promisor-remote reply
  doc: gitprotocol-v2: send the promisor-remote reply with fetch

 Documentation/gitprotocol-v2.adoc          |   6 +
 connect.c                                  |   6 +-
 connect.h                                  |   6 +-
 fetch-object-info.c                        |   3 +-
 fetch-pack.c                               |  17 ++-
 t/meson.build                              |   1 +
 t/t5710-promisor-remote-capability.sh      |  40 +++++++
 t/t5711-promisor-remote-capability-http.sh | 126 +++++++++++++++++++++
 8 files changed, 196 insertions(+), 9 deletions(-)
 create mode 100755 t/t5711-promisor-remote-capability-http.sh


base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
-- 
2.56.0

