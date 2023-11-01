Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48F1FCA
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDVhJr/C"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8580C2
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 16:31:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da2b8af7e89so404914276.1
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 16:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698881482; x=1699486282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvIPpmiKrCZHHh5FPE45ZaWjjEXy5Rnm3F1wIJ1+mJo=;
        b=LDVhJr/CI7bvwD3bfrZwF+nQBWPuYLQGxY1V1PrtJ04Kx1jtqTL08/0kZ7yRTVOcqA
         iaQLyAqprtfQtDvD3SETj1860GlLk3xmKDY9ceuU9nfc6rjSO0SUoi4UZL+VdNZTGQr4
         +EemzX89pkA678zmu8k1Ulpbj7BUKc1JO3VRAV3daf0pFx+1iWxAPzw6GwqNo1N09vVK
         57m8EE4bg3UdwW/Uh4heJhYI6IfJSS1rZAffmBjNsaHX4yFjEvoZnV3GKWzf/d5MNVGi
         Yfp8CPeqYA7izdzkTq1CkvLH17KgqydWscUkX/EOsaSZ+KU07YsQYg8ZWtbcqSJJxUC8
         e9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698881482; x=1699486282;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HvIPpmiKrCZHHh5FPE45ZaWjjEXy5Rnm3F1wIJ1+mJo=;
        b=S+asDnKtVZWt/xYya+syN/954YequEZdlsXMDIvERVV7ysirhSptDRqYoD6T5XxARa
         5P7SZu0+DgZtuBdtHUVrv6ntrQJgtnxipT4OOPlHXMQbfzX7qPB9hLodGahMQnmWUWYT
         CBkxRt8j3O2zYxZj/7cOlsbynmNLGOl3Tkbd2T7KNoALezJlU0frg/DoMd+ZcvIQUZjs
         Ha8zL6YcBLwGzF4wINc8fue+QTsuxU7xl9Hk8cSVDCAhhUxwou4+girgdYEiRLSNHqIx
         wWt5ET5z3GKHcboCqSF4YsAz7REMUAICyBYJg/iqIrhecK3OSGrnW9pSzfDRYju/v5jV
         ffcQ==
X-Gm-Message-State: AOJu0YxsrbZsMwvP3C47kwObJBH6pKym4xO4oFj99KOzhL5rqHuoZryO
	mwhlOrIQmnMyQydA2azyFtUtqBRKSZjjX/m0NsybX1nVUOe5aRx00TTfrWMRTyE6uw0D+64wryS
	Gchu9pxd5tHaOrrq+schOKXNoSbJEKimerPIAqjlQ9UeTN1AXn9EQ+b/Q1KxpFdk=
X-Google-Smtp-Source: AGHT+IETHVrPh8UKGxYGVuWOtLOQk9ELWhmX2a0b2ojZ+4JrIiRalx1nc7/qQUzAVQYvxjOQnL5k0hda+9/HCQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:fc30:220:f2fb:969])
 (user=steadmon job=sendgmr) by 2002:a25:d449:0:b0:da0:cea9:2b3d with SMTP id
 m70-20020a25d449000000b00da0cea92b3dmr364249ybf.8.1698881481363; Wed, 01 Nov
 2023 16:31:21 -0700 (PDT)
Date: Wed,  1 Nov 2023 16:31:14 -0700
In-Reply-To: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <cover.1698881249.git.steadmon@google.com>
Subject: [PATCH v9 0/3] Add unit test framework and project plan
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood123@gmail.com, rsbecker@nexbridge.com, 
	oswald.buddenhagen@gmx.de, christian.couder@gmail.com
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
 t/unit-tests/test-lib.c                | 329 +++++++++++++++++++++++++
 t/unit-tests/test-lib.h                | 149 +++++++++++
 13 files changed, 1040 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/technical/unit-tests.txt
 create mode 100755 t/t0080-unit-test-output.sh
 create mode 100644 t/unit-tests/.gitignore
 create mode 100644 t/unit-tests/t-basic.c
 create mode 100644 t/unit-tests/t-strbuf.c
 create mode 100644 t/unit-tests/test-lib.c
 create mode 100644 t/unit-tests/test-lib.h

Range-diff against v8:
1:  81c5148a12 ! 1:  f706ba9b68 unit tests: Add a project plan document
    @@ Commit message
         rare error conditions). Describe what we hope to accomplish by
         implementing unit tests, and explain some open questions and miles=
tones.
         Discuss desired features for test frameworks/harnesses, and provid=
e a
    -    preliminary comparison of several different frameworks.
    +    comparison of several different frameworks. Finally, document our
    +    rationale for implementing a custom framework.
    =20
         Co-authored-by: Calvin Wan <calvinwan@google.com>
    @@ Documentation/technical/unit-tests.txt (new)
     +can be made to work with a harness that we can choose later.
     +
     +
    -+=3D=3D Choosing a framework
    ++=3D=3D Summary
     +
    -+We believe the best option is to implement a custom TAP framework for=
 the Git
    -+project. We use a version of the framework originally proposed in
    ++We believe the best way forward is to implement a custom TAP framewor=
k for the
    ++Git project. We use a version of the framework originally proposed in
     +https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmai=
l.com/[1].
     +
    ++See the <<framework-selection,Framework Selection>> section below for=
 the
    ++rationale behind this decision.
    ++
     +
     +=3D=3D Choosing a test harness
     +
    @@ Documentation/technical/unit-tests.txt (new)
     +configured with DEFAULT_UNIT_TEST_TARGET=3Dprove.
     +
     +
    ++[[framework-selection]]
     +=3D=3D Framework selection
     +
     +There are a variety of features we can use to rank the candidate fram=
eworks, and
    @@ Documentation/technical/unit-tests.txt (new)
     +
     +=3D=3D=3D Comparison
     +
    -+[format=3D"csv",options=3D"header",width=3D"33%"]
    ++:true: [lime-background]#True#
    ++:false: [red-background]#False#
    ++:partial: [yellow-background]#Partial#
    ++
    ++:gpl: [lime-background]#GPL v2#
    ++:isc: [lime-background]#ISC#
    ++:mit: [lime-background]#MIT#
    ++:expat: [lime-background]#Expat#
    ++:lgpl: [lime-background]#LGPL v2.1#
    ++
    ++:custom-impl: https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6=
027557176@gmail.com/[Custom Git impl.]
    ++:greatest: https://github.com/silentbicycle/greatest[Greatest]
    ++:criterion: https://github.com/Snaipe/Criterion[Criterion]
    ++:c-tap: https://github.com/rra/c-tap-harness/[C TAP]
    ++:check: https://libcheck.github.io/check/[Check]
    ++
    ++[format=3D"csv",options=3D"header",width=3D"33%",subs=3D"specialchara=
cters,attributes,quotes,macros"]
     +|=3D=3D=3D=3D=3D
     +Framework,"<<license,License>>","<<vendorable-or-ubiquitous,Vendorabl=
e or ubiquitous>>","<<maintainable-extensible,Maintainable / extensible>>",=
"<<major-platform-support,Major platform support>>","<<tap-support,TAP supp=
ort>>","<<diagnostic-output,Diagnostic output>>","<<runtime--skippable-test=
s,Runtime- skippable tests>>","<<parallel-execution,Parallel execution>>","=
<<mock-support,Mock support>>","<<signal-error-handling,Signal & error hand=
ling>>","<<project-kloc,Project KLOC>>","<<adoption,Adoption>>"
    -+https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmai=
l.com/[Custom Git impl.],[lime-background]#GPL v2#,[lime-background]#True#,=
[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[li=
me-background]#True#,[lime-background]#True#,[red-background]#False#,[red-b=
ackground]#False#,[red-background]#False#,1,0
    -+https://github.com/silentbicycle/greatest[Greatest],[lime-background]=
#ISC#,[lime-background]#True#,[yellow-background]#Partial#,[lime-background=
]#True#,[yellow-background]#Partial#,[lime-background]#True#,[lime-backgrou=
nd]#True#,[red-background]#False#,[red-background]#False#,[red-background]#=
False#,3,1400
    -+https://github.com/Snaipe/Criterion[Criterion],[lime-background]#MIT#=
,[red-background]#False#,[yellow-background]#Partial#,[lime-background]#Tru=
e#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,=
[lime-background]#True#,[red-background]#False#,[lime-background]#True#,19,=
1800
    -+https://github.com/rra/c-tap-harness/[C TAP],[lime-background]#Expat#=
,[lime-background]#True#,[yellow-background]#Partial#,[yellow-background]#P=
artial#,[lime-background]#True#,[red-background]#False#,[lime-background]#T=
rue#,[red-background]#False#,[red-background]#False#,[red-background]#False=
#,4,33
    -+https://libcheck.github.io/check/[Check],[lime-background]#LGPL v2.1#=
,[red-background]#False#,[yellow-background]#Partial#,[lime-background]#Tru=
e#,[lime-background]#True#,[lime-background]#True#,[red-background]#False#,=
[red-background]#False#,[red-background]#False#,[lime-background]#True#,17,=
973
    ++{custom-impl},{gpl},{true},{true},{true},{true},{true},{true},{false}=
,{false},{false},1,0
    ++{greatest},{isc},{true},{partial},{true},{partial},{true},{true},{fal=
se},{false},{false},3,1400
    ++{criterion},{mit},{false},{partial},{true},{true},{true},{true},{true=
},{false},{true},19,1800
    ++{c-tap},{expat},{true},{partial},{partial},{true},{false},{true},{fal=
se},{false},{false},4,33
    ++{check},{lgpl},{false},{partial},{true},{true},{true},{false},{false}=
,{false},{true},17,973
     +|=3D=3D=3D=3D=3D
     +
     +=3D=3D=3D Additional framework candidates
2:  00d3c95a81 ! 2:  8b831f4937 unit tests: add TAP unit test framework
    @@ t/unit-tests/t-strbuf.c (new)
     +static int assert_sane_strbuf(struct strbuf *buf)
     +{
     +	/* Initialized strbufs should always have a non-NULL buffer */
    -+	if (buf->buf =3D=3D NULL)
    ++	if (!check(!!buf->buf))
     +		return 0;
     +	/* Buffers should always be NUL-terminated */
    -+	if (buf->buf[buf->len] !=3D '\0')
    ++	if (!check_char(buf->buf[buf->len], =3D=3D, '\0'))
     +		return 0;
     +	/*
     +	 * Freshly-initialized strbufs may not have a dynamically allocated
    @@ t/unit-tests/t-strbuf.c (new)
     +	if (buf->len =3D=3D 0 && buf->alloc =3D=3D 0)
     +		return 1;
     +	/* alloc must be at least one byte larger than len */
    -+	return buf->len + 1 <=3D buf->alloc;
    ++	return check_uint(buf->len, <, buf->alloc);
     +}
     +
     +static void t_static_init(void)
    @@ t/unit-tests/test-lib.h (new)
     +
     +/*
     + * Test checks are built around test_assert(). checks return 1 on
    -+ * success, 0 on failure. If any check fails then the test will
    -+ * fail. To create a custom check define a function that wraps
    -+ * test_assert() and a macro to wrap that function. For example:
    ++ * success, 0 on failure. If any check fails then the test will fail.=
 To
    ++ * create a custom check define a function that wraps test_assert() a=
nd
    ++ * a macro to wrap that function to provide a source location and
    ++ * stringified arguments. Custom checks that take pointer arguments
    ++ * should be careful to check that they are non-NULL before
    ++ * dereferencing them. For example:
     + *
     + *  static int check_oid_loc(const char *loc, const char *check,
     + *			     struct object_id *a, struct object_id *b)
     + *  {
    -+ *	    int res =3D test_assert(loc, check, oideq(a, b));
    ++ *	    int res =3D test_assert(loc, check, a && b && oideq(a, b));
     + *
    -+ *	    if (res) {
    -+ *		    test_msg("   left: %s", oid_to_hex(a);
    -+ *		    test_msg("  right: %s", oid_to_hex(a);
    ++ *	    if (!res) {
    ++ *		    test_msg("   left: %s", a ? oid_to_hex(a) : "NULL";
    ++ *		    test_msg("  right: %s", b ? oid_to_hex(a) : "NULL";
     + *
     + *	    }
     + *	    return res;
    @@ t/unit-tests/test-lib.h (new)
     +#define check_int(a, op, b)						\
     +	(test__tmp[0].i =3D (a), test__tmp[1].i =3D (b),			\
     +	 check_int_loc(TEST_LOCATION(), #a" "#op" "#b,			\
    -+		       test__tmp[0].i op test__tmp[1].i, a, b))
    ++		       test__tmp[0].i op test__tmp[1].i,		\
    ++		       test__tmp[0].i, test__tmp[1].i))
     +int check_int_loc(const char *loc, const char *check, int ok,
     +		  intmax_t a, intmax_t b);
     +
    @@ t/unit-tests/test-lib.h (new)
     +#define check_uint(a, op, b)						\
     +	(test__tmp[0].u =3D (a), test__tmp[1].u =3D (b),			\
     +	 check_uint_loc(TEST_LOCATION(), #a" "#op" "#b,			\
    -+			test__tmp[0].u op test__tmp[1].u, a, b))
    ++			test__tmp[0].u op test__tmp[1].u,		\
    ++			test__tmp[0].u, test__tmp[1].u))
     +int check_uint_loc(const char *loc, const char *check, int ok,
     +		   uintmax_t a, uintmax_t b);
     +
    @@ t/unit-tests/test-lib.h (new)
     +#define check_char(a, op, b)						\
     +	(test__tmp[0].c =3D (a), test__tmp[1].c =3D (b),			\
     +	 check_char_loc(TEST_LOCATION(), #a" "#op" "#b,			\
    -+			test__tmp[0].c op test__tmp[1].c, a, b))
    ++			test__tmp[0].c op test__tmp[1].c,		\
    ++			test__tmp[0].c, test__tmp[1].c))
     +int check_char_loc(const char *loc, const char *check, int ok,
     +		   char a, char b);
     +
3:  aa1dfa4892 =3D 3:  08d27bb5f9 ci: run unit tests in CI

base-commit: a9e066fa63149291a55f383cfa113d8bdbdaa6b3
--=20
2.42.0.869.gea05f2083d-goog

