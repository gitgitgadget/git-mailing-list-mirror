Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78532EA75E
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658976; cv=none; b=BfvbcZ2lIogxMzN1KCcV9nrJgHcoRG3zLTeDBhenSfwQ1yyQ/KJ0j7s/O9LNsTu7AXYpAid67G1D9/ncEsGjLhRDbgY7LMFrL3jYzW358B2Uic+19iKaaJKkBApz0sWbll3UIQpg4dRp8EnL/fT5kS0gBowAiStU4BZvsNDocJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658976; c=relaxed/simple;
	bh=Lr/K2vyes0ur+5/4vXyKw2/PZMbA2J03HPxOZaarlDY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=aHh+xX1loKezqRrBV5YHySM8t6o3NlNWgXZrbSX/4O47CeMk+Tnf38aBO7KmKv5uzDfvzxrscBJdxlpPlciVcWr7IV+I1MHVH+r7ecGiZLmMGfMFgaLKcnmqLN2QVseGfem70EMegDTPDPHDLLyeVyDxZhqqTIF9D9kX3WKd4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ML2/WtO6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML2/WtO6"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-505a1789a27so32971331cf.3
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775658973; x=1776263773; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O5MYVpDas7ZH7zxNExa8RAid3lrbDPWH4OUJG/AVugo=;
        b=ML2/WtO6mJLTDxfotqzqbyN+FuDl5qTcaHEc4kUgE7NWFnLhiR8Z2n08SDVjzXl7pu
         bdWsaEYko+H96Zc4S7SPD+Q6hTdTbhIblkRbGWOikXHh/AXxEPISj9XjY+EAK/IuF3J/
         uDssVexcMPakhsPeVf5YapIpM8zc/ns+2BTJIRbRW3mXoRgLRz8xTqhDmcILnNi/cJR1
         J8Lbr+Fug1HWQ1u23/vj3VZyQnIgL5RqmiEbvH98qIAmd5Z9THMkKp5tRvYuDYD+6EqJ
         4g4Ha2qyaJlVf6CBducX0wMjQkJaY61R9oo6hCZER4GQr+K1T6qAi4Z0YlbPCD/XmN8q
         n8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658973; x=1776263773;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5MYVpDas7ZH7zxNExa8RAid3lrbDPWH4OUJG/AVugo=;
        b=rBqbmmumn+umHaVFtnZLg47RAWPM5U1kteELwx9nCWNZZbpAyNAaLf8m9JXn3W7Tm/
         WAKaWwc8EnIZweqwmbga8al7nQxoca12bMgNrpELlikQZa6kIWZPiQqGfoB0BHfCIo3v
         uq3D6c3jWwZGuZ6jz+Cl/6Kc1fb0xGoL6Xgbn54uxZUQ6o0bqjn4dqJAVPTsp8Rvpj9k
         58IsrsPNCBr6o1Blsiz0YT+kZwprC5ApVajspow0p9tns1qan3bS/7a3Ua31pZVT7X86
         vy1hbmF9LD01WV9Ze7R7RPh7+QrGGBErh3Ddrjbhk7LaFBDFAQu9GF41ibl226bXCXkp
         chaA==
X-Gm-Message-State: AOJu0YysoRE8+7wHdNkMN9WoN9B8gxFcTZZVdS72miUgN8WmmObaF2V3
	jGqJbQVp2OKWhpvwWjRDM5zNpMZ9QVsSBiddpRs8nrclyt4TkM3CFGvldqAP3Q==
X-Gm-Gg: AeBDiettrkuwxOmFHSnAk2atUXdN+7JwiEMd+wcU0BshAOR/ArIHBLdLi3yKbu0jN7o
	88DDyQbASzbYOjOdRO8GvWJIhYAp2zDoZ2617Ys73WYMwsN0noeglYHEloPeYhrDW/SlAyJ5lyK
	4Dk5i0qT7Ip9CDb78bzNL1ywxVOZ+Iu/lB67rT1F1B9kd11xx+WkKN76XqbOjOjUeZyeMY8Gn5m
	uSzbRdFtvB14FBP+w8LqiQdwE6hnFOut308AxVDd2AL7ogg4CJCdgYqpHUhbgnuhSLFG+Oeb4o2
	35vT1pXWRYkexBJSueyV9U4FEIIVEux91fhBKyrNOQG7pCveC3mTlgNP2v7KR4aQs31j9ZKVM5L
	W3fihiGHpTs3RxPTHoQrk9Y9FkE0v86IWwM8AEuhFgGlJrxdzJvPUDzlTpgNLjOx3i6EMVz4cMu
	7WePmmmI2BVU0k/AbmITvVV5QD8ZI=
X-Received: by 2002:ac8:7d11:0:b0:50d:65ec:a071 with SMTP id d75a77b69052e-50d65eca37cmr302458891cf.5.1775658973030;
        Wed, 08 Apr 2026 07:36:13 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50db5cfd8a9sm14047891cf.12.2026.04.08.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:36:12 -0700 (PDT)
Message-Id: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 14:36:06 +0000
Subject: [PATCH 0/4] fetch: add --must-have and remote.*.mustHave
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    jonathantanmy@google.com,
    chooglen@google.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>

Fetch negotiation aims to find enough information from haves and wants such
that the server can be reasonably confident that it will send all necessary
objects and not too many "extra" objects that the client already has.
However, this can break down if there are too many references, since Git
truncates the list of haves based on a few factors (a 256 count limit or the
server sending an ACK at the right time).

We already have the --negotiation-tip feature to focus the set of references
that are used in negotiation, but I feel like this is designed backwards.
I'd rather that we have a way to say "this is an important set of refs, but
feel free to add more refs if needed" than "only use these refs for
negotiation".

Here's an example that demonstrates the problem. In an internal monorepo,
developers work off of the 'main' branch so there are thousands of user
branches that each add a few commits different from the 'main' branch.
However, there is also a long-lived 'release' branch. This branch has a
first-parent history that is parallel to 'main' and each of those commits is
a merge whose second parent is a commit from 'main' that had a successful CI
run. There are additional changes in the 'release' branch merge commits that
add some changelog data, so there is a nontrivial set of novel blob content
in that branch and not just a different set of commits.

The problem we had was that our georeplication system was regularly fetching
from the origin and trying to get all data from all reachable branches. When
the 'release' branch updated, the client would run out of haves before
advertising its copy of the 'release' branch, but it would still list the
new 'release' tip as a want. The server would then think that the client had
never fetched that branch before and would send all of the changelog data
from the whole history of the repo. (This led to a lot of downstream
problems; we mitigated by setting a refspec that stopped fetching the
'release' branch, but this is not ideal.)

What I'd like is a mechanism to say "always advertise the client's version
of 'main' and 'release' but also opportunistically include some user
branches".

Based on my understanding, the '--negotiation-tip' option is close but not
quite what I want. I could have the client only advertise 'release' and
'main' and never advertise any user branches. But then we'd download all
content from each user branch every time it updates. Perhaps this would
happen even with opportunistic inclusion of more haves, but I'd like to
explore this area more.

There's also an issue that the '--negotiation-tip' feature doesn't seem to
have a config key that enables it without CLI arguments. This is something
that we could consider independently.

This patch series adds a new '--must-have' argument in the same places that
'--negotiation-tip' exists. This adds a set of references that will always
be included in the negotiation as haves, but then the rest of the
negotiation can proceed as normal. It also adds a new
'remote.<name>.mustHave' config option to enable this behavior without CLI
arguments.

The series is organized into four changes:

 1. The first change updates a test that started failing after I added some
    tests before it. This fix should be valuable on its own, but I need it
    for my tests to pass.
 2. The second change adds the --must-have option for fetch and tests it
    relative to --negotiation-tip.
 3. The third change adds the config option to enable --must-have by
    default. Any use in the CLI completely overrides the config option.
 4. The fourth change adds capabilities for the config to update negotiation
    during git push.

During development, I had briefly considered only using config values, but
that required some strange changes to care about the remote name in the
transport layer. This was most different in the 'git push' integration. When
I discovered the '--negotiation-tip' feature during the process, that gave
me a clear pattern to follow with the addition of a config on top.

I've CC'd some folks who have been working on or near the
'--negotiation-tip' feature for feedback as to how these things fit together
in the bigger picture.

Big picture questions to think about:

 * Is this a valuable addition to the fetch negotiation?
 * Is the interaction between --must-have and --negotiation-tip correct?
 * Is the "must have" name sensical to users? I expect that this only
   matters to experts, but I'm open to better names that could be more
   self-documenting.
 * Should we add a similar config key for --negotiation-tip?

Thanks, -Stolee

Derrick Stolee (4):
  t5516: fix test order flakiness
  fetch: add --must-have option for negotiation
  remote: add mustHave config as default for --must-have
  send-pack: pass --must-have for push negotiation

 Documentation/config/remote.adoc |  23 ++++++
 Documentation/fetch-options.adoc |  22 ++++++
 builtin/fetch.c                  |  14 +++-
 fetch-pack.c                     |  92 +++++++++++++++++++++--
 fetch-pack.h                     |  10 ++-
 remote.c                         |   6 ++
 remote.h                         |   1 +
 send-pack.c                      |  12 ++-
 send-pack.h                      |   1 +
 t/t5510-fetch.sh                 | 121 +++++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh            |  17 ++++-
 transport.c                      |   5 +-
 transport.h                      |   6 ++
 13 files changed, 319 insertions(+), 11 deletions(-)


base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2085%2Fderrickstolee%2Fmust-have-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2085/derrickstolee/must-have-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2085
-- 
gitgitgadget
