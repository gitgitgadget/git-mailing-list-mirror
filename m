Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999119;
	b=3TbNvPA4rK+CwrWW5FGJKVUSpyAGuZD154oAx6ikmb8gMFoPztskPsNMaEtAsqg5ct0D
	 8S0rDlQdKRXRJPHqSyuPvAyaTTUbVzkiUgOzVa32TKrRnN2QvgkzljMxHoscDnbimq4Vo
	 R67L2t91VrNLBGQqr/1Yxilb+NGzqfkOROS7GrZDd1VM8Vb023+AkQJL0C5+mAUKEXyyr
	 L3ygKJzO9FVHCGZjDPbotuHQWk/gS7KuKDnBflnCR/mKNcDKWMb00tRxl0A2B86X3P6jk
	 tXljFX2pxl+qZBrUjjwpsTiMvJ8GVSRiF+Z/gLa8FIMYUQObSI9JOTQdWotaynH0i8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer;
	bh=zzxEUX9fAOi9EMz4cef+7KNjk5pcIKcFAjdA+rffXD4=;
	b=shwOYqmv9HOmxX6ZWhV/VnwFgyE02Ud/dC3lVutTY4NrLDyzqEmhZEsORpXyJgNuz+Os
	 csBju2lQee9Hv971Kpyx0Q5M3W6Kvqkc22L/XwkHdiiOHml1cNfNES2MvNmPgi4G9uLF0
	 OhYC2wFAihuczsphp61yZWV94W6uV3Tb+rkyVd8zZoAGLJls9A5MVrFqFpUi3S9kzhNZe
	 lN/aX/tfuUQtBKx/Js3AfUtVis1DUgzw+hPyOFl3VKK2Yoks39+PG7nyHEsLd1+nSSDpY
	 H45cIwMnXerMg+ePJrX7HxPlMCFxmtsS//G9AmwhZmzt77qBcMWz0IBg0n2qsdR+7tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ajWbUOpK;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E73606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30E73606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ajWbUOpK
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-369f33df08eso2247693eec.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 00:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999118; x=1793603918; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zzxEUX9fAOi9EMz4cef+7KNjk5pcIKcFAjdA+rffXD4=;
        b=ajWbUOpKnoz86TuJaRUkx5PuRbMQEI2cq4Pd0bwQOy6Olt5eUVeZocL3pu7RrVz5b+
         Cp5i/boS2nTLaBoYIw2dFWhN4Zk7KvQH9Qi8mtQ3FuoC1kDq2Up+kOoKf+gJ9B1ROtV0
         MoXtErM9Yqo+0Or4htLOG77ovRih5V1ANNcRnlksZ9cQwTR+6xnm+NG7kGPdoNEPZT7J
         eGdtVzM9UWvvTAmeHGnff72/GgvK3EcyQeIWGCl2nfC/hP0vxngQsujOqXN7cxxu7PGR
         SEvnrlMXx3IsTDP3aWEIEuFaEQJpGnp/olV/qlmlQtvRWi5TWEj7whN8YhLxweBN5TJp
         h+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999118; x=1793603918;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zzxEUX9fAOi9EMz4cef+7KNjk5pcIKcFAjdA+rffXD4=;
        b=w4pX8ioBxdqXpMZOml051mrcIp8oCT5EY/LpIg5yMZV47reaLkOWgDcULXqMzKuCOU
         yKHPxb+NbZRiTGV7S8PhSUADkpWAw3bpGa1T6VvcKUv7Pb9mSr42YJg9jZ/aINPTeJDd
         Atmf1WJmEIarFc9GKATKEnIWE205CrvTubHtabgQus9tDzdPeu6QpDkEiIU7ASlML8UG
         R/7aouKnxQoqVI9dtvLuMp/LVxd2PAwoZgzcUY1ySbm6GN9yMNsRbpyDx7GQvtS9UC03
         u1J338f+S5TEHAnhmRG1GkXQnarwn/RxYjZmeX+dsNjuXTcIPjXGnBwixcs1mki3hXEP
         S59A==
X-Gm-Message-State: AFq9FYLnJy2V7x59C2FMhVSme3Jw0hv1pFH3iDvUgFEe1N+8T0+nwmUP
	ozQiUAUA2I+MLNecJBm/IVeB9NX7ORcAk9qM9JUEkDFx+Dgj/wmbb9GoYz8dxg==
X-Gm-Gg: AYBFou0c1xkcRtB3yHhZ+DZKZn5IwIVYQJEqezLq50+W+IGZfNEXLFfA7HudTrxKOBS
	TRP6N4cYbcMlzuT2gSnuVviAlU/EtYh83YkhiDpvPBdku2zT2Hu0PI8i67RN8HpTBwNhhWbaeto
	zK02ToMUjRvV5jivQ0nLkRpN1detW2LBFM5tnfPF2bp9A2bZyqIcjzn3vZTOWEI99nNEqMfozY6
	g60TQpGF+ztIvUfZFWUrDbRcdR5dNznEE1m7W60wA57mcK7EUg6jIkzELZJOfKtjnfuhNJnVz/r
	kCyqRhVjAv6aN9VPcXMnZeIIHf+TTil3wikSVuAEm+g2sNO+ve37BMPFOY+hhPqDFZAVMsa7b12
	A/Xwui1hNqFYi9QYQdm4pUnjJZD/2FmauGBNu6jq62h1qjqa1mPPtaJomGSDl/dUKw5quFtXM40
	Ra+zdR4m4bC5k043XfzTUiSk5dAe1Cbh5+JcV4XPA4CL/COmFj7I/brWiAcsyW/nbWFVBM4zIqo
	AEelT4+OvhNMK7vMY3LoOJk+sx21ax0jcoaIPgySoo7a5lr73Bzx+z3OdrvXPY81vVay/3iZ+2G
	gSkcRF6uRw==
X-Received: by 2002:a05:7300:5724:b0:369:fbc5:ce29 with SMTP id 5a478bee46e88-369fbc5cfd4mr6458050eec.38.1792999118060;
        Mon, 26 Oct 2026 00:18:38 -0700 (PDT)
Received: from [127.0.1.1] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a005c0188sm8871295eec.9.2026.10.26.00.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:18:37 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [PATCH v2 0/2] Make our clar tests ignore the long-tests argument
Date: Mon, 26 Oct 2026 12:48:20 +0530
Message-Id: <20261026-ks-unit-tests-ignore-long-tests-v2-0-eaab5657c19c@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALz+3moC/4WNQQ6CMBAAv2L27Jq2goIn/2E4ICxlI7SmW4mG8
 Hcr0bPHmcPMDEKBSeC0mSHQxMLeJTDbDTR97Swht4nBKHPQymi8CT4cR4wkUZCt84Fw8M5+Tdn
 tjToWVGqlIFXugTp+rodLlbhniT681uGkP/bXNn/bk0aFeZ7VeanaTBfXsx1rHnaNH6FaluUNN
 bI6Lc4AAAA=
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.13.0

This is a small patch to fix a hiccup I hit while trying to run
our test using the following incantation:

  $ meson test -v --test-args='-ilx'

  ...

  Summary of Failures:

     2/1063 unit-tests                                     FAIL            0.16s   (exit status 129 or signal 1 SIGHUP)

  Ok:                 1061
  Expected Fail:      0
  Fail:               1
  Unexpected Pass:    0
  Skipped:            1
  Timeout:            0

  Full log written to /path/to/testlog.txt

On some exploration, we find the following which shows us what's wrong:

  2/1063 unit-tests RUNNING       
  >>> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MALLOC_PERTURB_=103 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 /me/git-1/build/t/unit-tests -ilx
  ――――――――――――――――――――――――――――――――――――――――――――――― ✀  ――――――――――――――――――――――――――――――――――――――――――――――――
  error: unknown switch `l'
  usage: unit-test [<options>]

      -i, --[no-]immediate  immediately exit upon the first failed test
      -r, --[no-]run suite[::test]
                            run only test suite or individual test <suite[::test]>
      --[no-]exclude <suite>
                            exclude test suite <suite>

  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
  2/1063 unit-tests FAIL            0.01s   (exit status 129 or signal 1 SIGHUP)

So, the '-l' switch that's passed to unit-tests is the problem.

On searching for how these were handled before, I stumbled across
9faf3963b6 (t: introduce compatibility options to clar-based tests,
2024-12-13) which handled this by adding such arguments as NOOP
arguments to t/unit-tests/unit-test.c. So, this patch does the same
to make unit-test ignore the '-l' passed to it.

The CI pipeline passes (for v1. v2 only had a commit message change):

 - GitHub: https://github.com/sivaraam/git/actions/runs/39756087806
   (a couple of MacOS ones didn't run owing to the lack of a runner)

- GitLab: https://gitlab.com/gitlab-org/git/-/pipelines/2975804623

---
Changes in v2:
- Fixed the s/prerequiiste/prerequisite/ typo in the commit message

- Link to v1: https://lore.kernel.org/r/20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com

Range-diff vs. v1:

1:  66759f627c = 1:  60bc3f0d83 unit-tests: reshuffle NOOP arguments to maintain order
2:  0bea06fe46 ! 2:  c39dd72a2b unit-tests: ignore --long-tests
    @@ Commit message
         So, ignore -l / --long-tests in our clar tests.

         This does not show up as a problem while running our CI as we enable
    -    the expensive prerequiiste via the GIT_TEST_LONG env variable.
    +    the expensive prerequisite via the GIT_TEST_LONG env variable.

         Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>

---
Kaartic Sivaraam (2):
      unit-tests: reshuffle NOOP arguments to maintain order
      unit-tests: ignore --long-tests

 t/unit-tests/unit-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

${range_diff}
---
base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
change-id: 20261021-ks-unit-tests-ignore-long-tests-9f32078e9100
${prerequisites}

