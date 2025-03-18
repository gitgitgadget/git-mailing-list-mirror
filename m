Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F45EAC6
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295627; cv=none; b=rfImsuCOeqneE/iY0m5hSDqxItOF8BDlEnPvfnsiWxQAW6QwidUCMiX3SLnhie+Xd7wYLDgzaR555GiKbqSGw4LJgJp6DyVi0otMLL1rvZtmg7EuqbIQl9vSzdCZoKZK0sT5x14A0outYypsMH+aK3fOxn6475jk1gXkunqH5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295627; c=relaxed/simple;
	bh=GcvntGJJMfOwg/u2WcjRHiphPXmmzv434lmkxDDMPss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNlcHZ7LDQaS/+ioKsaQN1pXol2tHIQVlfIJFgnaNBVtAFQ8WTYmL53y8rQRB4xxev7Gy7V05T1pN3ntvMxAARNXoqbw3EpGmewo208ZYHuBSlJnxdMVshVwp6uDRIvrGeO1onrpm8joZcjpCJFAYuXY8mrTqWA9NppyVv1/URI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTvoRLkw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTvoRLkw"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso14332945e9.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742295623; x=1742900423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYdM3Ap2VYGz2tjlWR83QAo3yOJUB8rw8Eqzf96q/Bg=;
        b=aTvoRLkw4aqffugrP0C3XBZQVPyvgrO1TGRfEYDelqQMAegesORHfTCARTUX7oa/eX
         Dr+Fr0wJ/GTskW5mG0+Q8lQt2vMZlBytGg8AoMZxr+xHw9AK/5HGkAXmE05AuEK+m4Ht
         ctUAq5txvG6bkHhdiSi/EtQ9z6VP9jQehL6Tuj8YHjhJep7KdY1NajFT1MBC6tpbxHiY
         Zc/8pbDMg901TJrBVxH7OJpRmbXZyILTpZptqYS0BLjYKIETqLGi76zoC/TwVECOGETI
         7wu3Y3kFuD5YUw1MmCMYtwjgU/FVbv+dAehFZ5Me2Xrm8XIJsH+jcFpIgauC8gwsnGKC
         984g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295623; x=1742900423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYdM3Ap2VYGz2tjlWR83QAo3yOJUB8rw8Eqzf96q/Bg=;
        b=FaLW2J5Z8WwJFsxk5mVG717kEl6dCFLNjmCLHd+r7O1ix3sSlOxuSuUzBRFOmrssaa
         JMw35mzPE2hKPmb4pwO9UkfGVE74Hp01X7c98SPTd4IYYGxKL7N6Nk3uKvWPFQ2FAmcv
         NprRiHWYDNrj8pEkdBHVX4eKu0oofywUVzGv0vgwKd9FaK7wnuq6w3YGcrH5HEFx5DId
         da2BnrXVpXGTo62nAMJSsiH8n2Tn5hlqom6vdp5PfGx1ZJWRIhJhQxRFWvdRddVxMGLx
         1/HIBxFDVXiz1+on/nLAzHz8XAIyo4LHmQm2QeFEfkN4qxQjhnVsGcJNlWauMqK24U1V
         uEUQ==
X-Gm-Message-State: AOJu0YySqmFBUUwnqqZ2E0YzkysJn4gGydW5DT3YdVlJjTVBPnL+tIUM
	4VEGfTZzsphJMS16TiM1NLYAkdw0f6Qy1Y2dlkj+6BslDIo9SFXEmu1NIg==
X-Gm-Gg: ASbGncs5d7DjVJ28O5FW8dhuzUJplD0mleQkgX4GaV18NOueTuw8PH44T5mdId0J7ni
	DtfIrY6ExvzhpacmaARjt5uJzjc++3X+Xy6B/BUZFPz29B7QLu7/j5obnC1mCGGifASbcXd6mBU
	fJeexQGQmevmP44wTw7yDYtmTj15ECSeyIXvmxsZNM0dGQJvy6MeOZjcupo6swKsZnhndNmLjso
	GQD1bSy4xYGtDjbCJ/0UszSe7uxLn7kvspqK5xlZbrxXwijZCdsWM2KE4uQbItGjuiqrkdRcbsF
	7OAhDRFGKtZU72MqykulH9vxk68Xf5b2HNl0VVJQ+/BFz0X7AHnOtaw7Tq0xO5rn30o5sI+86A4
	DZA==
X-Google-Smtp-Source: AGHT+IFTgJ1Xr6iDkOawnxzgtz/6Vy5kT7VJFvkuCqaAcVO1t/VS3A3NTmidbYriOUefCvMgvHAFSQ==
X-Received: by 2002:a05:600c:3584:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-43d3b99b8e2mr17573345e9.11.1742295622286;
        Tue, 18 Mar 2025 04:00:22 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:f066:6e28:cef1:9d6a:ca5b:64d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60951sm131169515e9.26.2025.03.18.04.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:00:21 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 0/4] "promisor-remote" capability fixes
Date: Tue, 18 Mar 2025 12:00:04 +0100
Message-ID: <20250318110008.656695-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.4.g81387f61c3
In-Reply-To: <20250314141203.2548803-1-christian.couder@gmail.com>
References: <20250314141203.2548803-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This addresses a number of different issues found after the
"promisor-remote" capability patch series was merged.

Changes since v5:

There are only changes in the "t5710-promisor-remote-capability.sh"
test script since v5:

  - Patch 1/4 ("t5710: arrange to delete the client before cloning")
    is new. It moves `test_when_finished "rm -rf client"` before we
    clone. It's a preparatory patch to avoid possible issues in the
    following tests if a clone ever fails in a weird way.

  - In patch 2/4 ("promisor-remote: fix segfault when remote URL is
    missing"), the tests have been improved in a few ways:

      - a `test_when_finished "rm -rf client"` has been moved before a
        clone instruction to avoid possible issues in the following
        tests if the clone fails in a weird way,

      - some instructions to reset `remote.lop.url` on the server to
        it's original value ("file://$(pwd)/lop") have been moved
        before the instructions that unset it or set it to an empty
        value,

      - some `test_when_finished "rm -rf client"` have been added into
        the new tests where the clone is expected to fail, to avoid
        possible issues in the following tests in case the clone
        actually succeeds.

Range diff since v5:

-:  ---------- > 1:  12e6251c65 t5710: arrange to delete the client before cloning
1:  f01457943d ! 2:  9fe0844b72 promisor-remote: fix segfault when remote URL is missing
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownNam
      
     +test_expect_success "clone with 'KnownName' and missing URL in the config" '
     +  git -C server config promisor.advertise true &&
    ++  test_when_finished "rm -rf client" &&
     +
     +  # Clone from server to create a client
     +  # Lazy fetching by the client from the LOP will fail because of the
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownNam
     +  GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
     +          -c promisor.acceptfromserver=KnownName \
     +          --no-local --filter="blob:limit=5k" server client &&
    -+  test_when_finished "rm -rf client" &&
     +
     +  # Check that the largest object is not missing on the server
     +  check_missing_objects server 0 "" &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownNam
     +
      test_expect_success "clone with promisor.acceptfromserver set to 'KnownUrl'" '
        git -C server config promisor.advertise true &&
    - 
    +   test_when_finished "rm -rf client" &&
     @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl' and different remote urls" '
        initialize_server 1 "$oid"
      '
      
     +test_expect_success "clone with 'KnownUrl' and url not configured on the server" '
     +  git -C server config promisor.advertise true &&
    ++  test_when_finished "rm -rf client" &&
     +
    -+  git -C server config unset remote.lop.url &&
     +  test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
    ++  git -C server config unset remote.lop.url &&
     +
     +  # Clone from server to create a client
     +  # It should fail because the client will reject the LOP as URLs are
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
     +
     +test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
     +  git -C server config promisor.advertise true &&
    ++  test_when_finished "rm -rf client" &&
     +
    -+  git -C server config set remote.lop.url "" &&
     +  test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
    ++  git -C server config set remote.lop.url "" &&
     +
     +  # Clone from server to create a client
     +  # It should fail because the client will reject the LOP as an empty URL is
2:  8981eb9dae = 3:  f56dccc5e2 promisor-remote: fix possible issue when no URL is advertised
3:  a8a9f9b33b = 4:  81387f61c3 promisor-remote: compare remote names case sensitively

Christian Couder (4):
  t5710: arrange to delete the client before cloning
  promisor-remote: fix segfault when remote URL is missing
  promisor-remote: fix possible issue when no URL is advertised
  promisor-remote: compare remote names case sensitively

 Documentation/config/promisor.adoc    |  4 +-
 promisor-remote.c                     | 27 ++++++----
 t/t5710-promisor-remote-capability.sh | 75 ++++++++++++++++++++++++---
 3 files changed, 86 insertions(+), 20 deletions(-)

-- 
2.49.0.1.g12e6251c65

