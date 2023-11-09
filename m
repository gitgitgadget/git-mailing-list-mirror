Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D959524D
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYFwr9gA"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11B03C1F
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:50:48 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b0e9c78309so17462437b3.1
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 10:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699555848; x=1700160648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBkpr93oeQ/BFb42T3NEsarv9RvWR/xsOsNURBenhck=;
        b=eYFwr9gAWoZJRQv9kt4zIh0MRGuRvWLsyIRPhoS9f/jCuwnzNsftLB5CBgMICI+ZkZ
         6gTiDNxez28cSWwfv/D35ywni5oqIgqrq8s5UT7ZnNGR7U8Wi6EZOZIaDCU1RuC7ymKL
         Z5cI3oWWgH0DBpJdRYa7a8SA8/J1KXj0l1Hj9QgMoCKKUJo/yMFHCmVvmlDnSFX4ZE/v
         tzu1Dp8JErBWpBN8qItWCk5gca4U8lQKxg7o8pb8j8efJB1B7bcYeVKseYKXmYvQukHU
         g+Dh71WdYREOkP0yyHC9o38T+aa0FXWvADatruVeZVu3eKUVqMypWlzR1+ZnDe99OdYT
         Ggdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699555848; x=1700160648;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pBkpr93oeQ/BFb42T3NEsarv9RvWR/xsOsNURBenhck=;
        b=ss5BC4JjxZSsTxXI2PUNFyLfe2abKaCAYLMlyN1EUbI8KT1AzQQ6XlCXs6OlhpZy/0
         46JwV7PGA23GDIQ1uD1ET9aLHaw09k9sY/+bnNZqU9vDrPj68i/vt9kkS1HZHVb8T+6H
         ATA6CivbWBpHWNEcX7ecbHpHvTw1aj6XW9CLn0JlKdfnUeXhHX4RaOygOkKZSf83ydvE
         Z3RhSigUSeYMZok94COQramysA+avoBExHNqwsm72/cVL2qxEzzfKGPMIcmwfJ03NLmt
         rwGHi0++buPUmbUGCi+OIXevaxHM+8nhL3TDSY6S0IZ9G9BwzhTvYtAIOQnXo4C1qpV6
         72tA==
X-Gm-Message-State: AOJu0YxUW5bJB18o9vKI2IZB13lNN4/xRlVZrREM6GIX0oiUURDX2II+
	rLjZf+YSxkqJLlQp+cd63/wAj8W9nTtlEfAS31Km/+ACklppDzyQKcZ4dPnOCA/cJ3UfumOLFH3
	+9qgjDWVNI/Qaw7BxPZdh3GIm+srZRHLkZoctC/ba2diby1Jvgm5UCtQcg4h5d8k=
X-Google-Smtp-Source: AGHT+IF+JQ0S0Twxw0J6/l/hK8iw6eZNDPHuSKy9Lm5sBMZFoydpLutWRrlQZ59UiRIyIYSGHDhS2OzSjz/DBw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5c8e:97b9:4fad:1ea4])
 (user=steadmon job=sendgmr) by 2002:a0d:eb8b:0:b0:59b:f3a2:cd79 with SMTP id
 u133-20020a0deb8b000000b0059bf3a2cd79mr159641ywe.8.1699555847886; Thu, 09 Nov
 2023 10:50:47 -0800 (PST)
Date: Thu,  9 Nov 2023 10:50:41 -0800
In-Reply-To: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <cover.1699555664.git.steadmon@google.com>
Subject: [PATCH v10 0/3] Add unit test framework and project plan
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood123@gmail.com, oswald.buddenhagen@gmx.de, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In our current testing environment, we spend a significant amount of
effort crafting end-to-end tests for error conditions that could easily
be captured by unit tests (or we simply forgo some hard-to-setup and
rare error conditions). Unit tests additionally provide stability to the
codebase and can simplify debugging through isolation. Turning parts of
Git into libraries[1] gives us the ability to run unit tests on the
libraries and to write unit tests in C. Writing unit tests in pure C,
rather than with our current shell/test-tool helper setup, simplifies
test setup, simplifies passing data around (no shell-isms required), and
reduces testing runtime by not spawning a separate process for every
test invocation.

This series begins with a project document covering our goals for adding
unit tests and a discussion of alternative frameworks considered, as
well as the features used to evaluate them. A rendered preview of this
doc can be found at [2]. It also adds Phillip Wood's TAP implemenation
(with some slightly re-worked Makefile rules) and a sample strbuf unit
test. Finally, we modify the configs for GitHub and Cirrus CI to run the
unit tests. Sample runs showing successful CI runs can be found at [3],
[4], and [5].

[1] https://lore.kernel.org/git/CAJoAoZ=3DCig_kLocxKGax31sU7Xe4=3D=3DBGzC__=
Bg2_pr7krNq6MA@mail.gmail.com/
[2] https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentation/=
technical/unit-tests.adoc
[3] https://github.com/steadmon/git/actions/runs/5884659246/job/15959781385=
#step:4:1803
[4] https://github.com/steadmon/git/actions/runs/5884659246/job/15959938401=
#step:5:186
[5] https://cirrus-ci.com/task/6126304366428160 (unrelated tests failed,
    but note that t-strbuf ran successfully)

Changes in v10:
- Included a promised style cleanup in test-lib.c that was accidentally
  dropped in v9.

Changes in v9:
- Included some asciidoc cleanups suggested by Oswald Buddenhagen.
- Applied a style fixup that Coccinelle complained about.
- Applied some NULL-safety fixups.
- Used check_*() more widely in t-strbuf helper functions

Changes in v8:
- Flipped return values for TEST, TEST_TODO, and check_* macros &
  functions. This makes it easier to reason about control flow for
  patterns like:
    if (check(some_condition)) { ... }
- Moved unit test binaries to t/unit-tests/bin to simplify .gitignore
  patterns.
- Removed testing of some strbuf implementation details in t-strbuf.c

Changes in v7:
- Fix corrupt diff in patch #2, sorry for the noise.

Changes in v6:
- Officially recommend using Phillip Wood's TAP framework
- Add an example strbuf unit test using the TAP framework as well as
  Makefile integration
- Run unit tests in CI

Changes in v5:
- Add comparison point "License".
- Discuss feature priorities
- Drop frameworks:
  - Incompatible licenses: libtap, cmocka
  - Missing source: MyTAP
  - No TAP support: =C2=B5nit, cmockery, cmockery2, Unity, minunit, CUnit
- Drop comparison point "Coverage reports": this can generally be
  handled by tools such as `gcov` regardless of the framework used.
- Drop comparison point "Inline tests": there didn't seem to be
  strong interest from reviewers for this feature.
- Drop comparison point "Scheduling / re-running": this was not
  supported by any of the main contenders, and is generally better
  handled by the harness rather than framework.
- Drop comparison point "Lazy test planning": this was supported by
  all frameworks that provide TAP output.

Changes in v4:
- Add link anchors for the framework comparison dimensions
- Explain "Partial" results for each dimension
- Use consistent dimension names in the section headers and comparison
  tables
- Add "Project KLOC", "Adoption", and "Inline tests" dimensions
- Fill in a few of the missing entries in the comparison table

Changes in v3:
- Expand the doc with discussion of desired features and a WIP
  comparison.
- Drop all implementation patches until a framework is selected.
- Link to v2: https://lore.kernel.org/r/20230517-unit-tests-v2-v2-0-21b5b60=
f4b32@google.com


Josh Steadmon (2):
  unit tests: Add a project plan document
  ci: run unit tests in CI

Phillip Wood (1):
  unit tests: add TAP unit test framework

 .cirrus.yml                            |   2 +-
 Documentation/Makefile                 |   1 +
 Documentation/technical/unit-tests.txt | 240 ++++++++++++++++++
 Makefile                               |  28 ++-
 ci/run-build-and-tests.sh              |   2 +
 ci/run-test-slice.sh                   |   5 +
 t/Makefile                             |  15 +-
 t/t0080-unit-test-output.sh            |  58 +++++
 t/unit-tests/.gitignore                |   1 +
 t/unit-tests/t-basic.c                 |  95 +++++++
 t/unit-tests/t-strbuf.c                | 120 +++++++++
 t/unit-tests/test-lib.c                | 330 +++++++++++++++++++++++++
 t/unit-tests/test-lib.h                | 149 +++++++++++
 13 files changed, 1041 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/technical/unit-tests.txt
 create mode 100755 t/t0080-unit-test-output.sh
 create mode 100644 t/unit-tests/.gitignore
 create mode 100644 t/unit-tests/t-basic.c
 create mode 100644 t/unit-tests/t-strbuf.c
 create mode 100644 t/unit-tests/test-lib.c
 create mode 100644 t/unit-tests/test-lib.h

Range-diff against v9:
-:  ---------- > 1:  f706ba9b68 unit tests: Add a project plan document
1:  8b831f4937 ! 2:  7a5e21bcff unit tests: add TAP unit test framework
    @@ t/unit-tests/test-lib.c (new)
     +	if (ctx.result =3D=3D RESULT_SKIP) {
     +		test_msg("skipping check '%s' at %s", check, location);
     +		return 1;
    -+	} else if (!ctx.todo) {
    ++	}
    ++	if (!ctx.todo) {
     +		if (ok) {
     +			test_pass();
     +		} else {
2:  08d27bb5f9 =3D 3:  0129ec062c ci: run unit tests in CI

base-commit: a9e066fa63149291a55f383cfa113d8bdbdaa6b3
--=20
2.42.0.869.gea05f2083d-goog

