Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666924;
	b=Evjs5HFPIxmh9F/ckw8ljylWRnahSZXrBZOh24vvsVEfLlIrrveaKlQOh5GpdDsfbflG
	 pSOaDPvS1E/fYxeHEkybMB1YVL8a2Sfl1TuYSMg6dT1u0iLp2vleihQ0pTfSHRjApgM/+
	 kzJYWQllKWIqyjxxmaWWGgVQw4lf+8sTxH9J52iEuXdrjXRfmawlc2HmUq60/X6gopdf+
	 LsZAU5Fdrq1YhPbVR0Ff/GvlZxdyz8EM67vavsEnKPtoC7KyNwQgUdN3OPkF9FZE+Q7Pm
	 watiLrzdtkk7DlPODK4XLge6qTnB+UceAHgFKLnvnWH5t7u9mU5MFCpSBwfTWpPyLbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer;
	bh=Uw6im7uzm/XFO3yQqlqg5rkQfHmeNJy/cZTGemRUWAE=;
	b=soGGP6SBQ0DLxb2F1pY2g9Q/rLVx77MDJKpMZRF5YYkzi3qUd0Y9Z06DdODi3eNBHgWT
	 wdAdn1G8xr+KRwK0ztLub+pkjzpGZ28mitJ7Y4e+hUbqK94DLZNasv11AzWbBY2Mu7pal
	 sbL0ry9+8f0rGzPNA42SdDyRDF3utYJh0oktERV6PE8G+16CER6h77x7bD37xf5AoDlvE
	 fwDd1ppGT+xwKvUGeKLsX26MrAJ9tyiVkjkE9dMMgte8dEraowMrwkSLCOYWF/FqX9LsA
	 oFfwFzMvg/9a+bhGlaTf3+DnFJ7zFAUyjxPnVX7TWbvbF5/weRp3AZ8zZHpCZEUGXgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="qm/4+Dfy";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C28606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81C28606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qm/4+Dfy
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35f036b17easo1299936eec.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 04:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792666923; x=1793271723; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Uw6im7uzm/XFO3yQqlqg5rkQfHmeNJy/cZTGemRUWAE=;
        b=qm/4+DfyZF4gnx7tJEjPZjFZGiG/1kTM2rLio5YDISNc0mTDgz4u4D9YZZC4K5cxdv
         +bL14Vu5PNsR/oeHlfYL3F4oyQvP+DHKft/oKQGfs0DS6szyVYOKCS8dZJqVMZbQ9bbL
         SdTl2JO9SdzKN1du19PEQOjUnsfz8F3aCOV5BD4JfJotxe1cH0S2PKmcce9PsDbw7ogL
         XTg5QLwA2I2qE8GW4h484aDYoacXmZJNyUZLIfdssFHCmlDBEZG34vQILN1coCRjkB/8
         8F1IWxOGqh602iXDpyaYPzG1pC6GjI9xGhvGJ6hfuu2tIOZyE73DPbBfJqdkTkIaT0rf
         Rk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792666923; x=1793271723;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Uw6im7uzm/XFO3yQqlqg5rkQfHmeNJy/cZTGemRUWAE=;
        b=bGoPQd7hs4un5cj+0yifc8OnVSscnKHe6As645+iZRAnEBSCiPXiPHi3+3h33L5C9j
         o1mTKtfFgKXJE6PUNxMoLefbWjL5vGMS+YcEJoyhCdxb7FAFfQHhj42MgKB2pu4wFXro
         xySDc+SECfdZIWfnWu8n3uRHBlevowXJJT/aZfxu/dWCGJK5XhsbQBHDAV+c9loIuwok
         EliVO/7LTX8UO7cz8TONomKTDfzDxwNC/fVs7rNjm1wQmGinmSTfvt/is9kaIRhIjdLe
         xq8dbmKc9+P/GECEH3FcbJ9y7I8W/TWuvXGdDx4Vcm36NO/0vliMA0nQiWpHX0rDnT0H
         Nbng==
X-Gm-Message-State: AFq9FYJhiPsRc2swvcfsIMm/D071znonbZP9P8/NqlhvUxkQOgNFM/3Z
	RAXQyQL7Nj5myctpVmNpyrm1rkonIWwJf6/9/BCB7h15E308mPNYCJg/sGp0JQ==
X-Gm-Gg: AYBFou0vvkKlpQQurd02y3PbMuWP3CrvSdlVhHVae5Xllf99vmVI3DE2paHAPPtzE3d
	ZNpsiRaSMtL0C5n6g2uEkXVcKTdznbKCXIK1nrB8mTe3BGnAa+c6/6CNuQk7BG9MPZKvbP1jz9y
	cY33+GL/+y79ZksrZLIxipXnFAy3hvSxeq5OCNLxUtMcvPz2GnHpsEPeiVSsoVhuxQBsJ2ACUgs
	iTj5NwOw82wzI5hzUo8DlMjDj3ZYPGswflrqG7M67RtckUoJOoXX8SJj8nAx80d0TVGveGaD3SU
	EpKUwyqXPA095yYk14hNg4w/PEkwPYAuD9UHYHRhnhQ7soEYSanX0hx62JgMEQnOYWxzuB3tRx9
	9+Prcn7aGl8bkrBHVrUsH+ReGAChOMn8J5e9XBXcwUCTivWWlT7wYglQ3o1PFnYMwba1Yj3aPZW
	hU9v8/DGwWS1VTDqnnITw47gbhjXCMtSz/wpTpZuAElDShBdH5BswgMHKfbbzkXBlkYOgVxkon/
	5OySOxRy4cA1EB8oVg8Fn8M6MiraTbmEVsZAUaDtmtpWD4SewF9+PFjmSNyR0cX
X-Received: by 2002:a05:693c:42c3:b0:35f:2349:a574 with SMTP id 5a478bee46e88-367508e2009mr6359141eec.40.1792666923220;
        Thu, 22 Oct 2026 04:02:03 -0700 (PDT)
Received: from [127.0.1.1] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368ca914bb8sm6277428eec.5.2026.10.22.04.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:02:02 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [PATCH 0/2] Make our clar tests ignore the long-tests argument
Date: Thu, 22 Oct 2026 16:31:56 +0530
Message-Id: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIACXt2WoC/y2NQQqDMBAAvyJ7dmGTglW/UjyUdo2LsinZKIL4d
 4P0OHOYOcA4CRv01QGJNzGJWsDVFXymtwZG+RYGT75x5B3OhqtKxsyWDSVoTIxL1PA33fjw9Gy
 5c0RQKr/Eo+z34TWc5wUXhbsmcQAAAA==
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

The CI pipeline passes:

 - GitHub: https://github.com/sivaraam/git/actions/runs/39756087806
   (a couple of MacOS ones didn't run owing to the lack of a runner)

 - GitLab: https://gitlab.com/gitlab-org/git/-/pipelines/2975804623

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

