Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9843B491
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951356; cv=none; b=Y+Dgur6dwEZ3jPN5OA8fT9G6D6cxr27LQY9FNHmQ+9i4XztToquzgVezQjBZhbfpdwrxaZ+YoHMdjSsN+sqOUUNdirJ5w5nuseKR2w858bIE+gNgCQl1A7n0AdfnCVQ4QCG1X4/0wGEwJvJZ8QhhCKUjT3FYe48DNEk4ZvvQor8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951356; c=relaxed/simple;
	bh=GQqCVt51Lg5AYHL3m0boK1JVKGYvFeF7mC4NWFIOkW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IEBQvKZyeDkEKdQ6RAj1ewjUaGtoKlM6guWHIzGmWQzkbd9tA80gBpaxAejnL3qm9gTN2zXtEdy58AYi8mjVKNLL6kTxGwwzle8Ui1OohgZIhKLl1fsCcLHKLrWtgHKVXH/KEw9X3wac1+w574zBwKVUWgr0IDURwWdSjRfh0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2LQOJtw; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2LQOJtw"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so1894794a12.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783951355; x=1784556155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/pLS34LkTqqEQJIoeYHBO3lxl720HeH5FwGyNLbgAs=;
        b=Y2LQOJtwAPEHicd592MwzUFohO7+bWIGgBz7nnkXIKB0KBoKUI8gLO+OAWU0i16w1+
         ppb+RlcFZmRZrtCb8QBvz+NX6tCas9hCW9bvSQ/6sm3uS0amjgA+fiHzZ49qyyoFv0Os
         lIrl9HXACeWBZMVN9QTPWzGfFZtLdIXm0/5/hucDA6D2NEdKowxpAntVWJB1ZHbLrBzd
         MpcNrzm6cIvR0k4UyhrC0ctFyQ0NuvlFSJxoy++ZxrJFY7vwGvge6l3a7J8bTZTLrnFX
         9aJwpk27uuE/sN3Y9tqyQV6FK9WaPNEyi4/dbUMR49r4fcha0uVE9p5J+mFYFCu5qjln
         4Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951355; x=1784556155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/pLS34LkTqqEQJIoeYHBO3lxl720HeH5FwGyNLbgAs=;
        b=QsrupE1iICp6ldF64tSXXXgGbAi3CLkfufJShyggkLy+G9YsDcNZtwZlkEcW6siV1x
         Rk1uK0e2EiWtVSGjgX/F/i4BCKCOZNIbQg0RxO7vASvu8L5TkOi64RttEuX14PWWhMBJ
         3QDR993Y825aSYCM4mfZ5j+rB5y4n31pkfRtceMmJoKJVrT08L2QSe88rZa7qiCTY/GL
         Ujbgn2DFrWipP+frMoF3igBp3F7z+lhbwmgckF4JuLcrhX/t4IkSxDqbX7pVz3IKKDTf
         PZtU+tqY8oflgm+0ge3ZmcFt4nmXVu/b0E8m+9Bi0H93qmx3029hrRS7AatOO8muIAIO
         27Ug==
X-Gm-Message-State: AOJu0Yz4ZLiXGjLYaQPJMi+NcEUTjpTfUew/LfRWlqlmvdYzQZLYOHyx
	dQpEp/B01UE36ZIvN2odPriyxB1b931iyQQTpKDifbSj+9XhEt+mGKbI1zuEYQ==
X-Gm-Gg: AfdE7ckJxls7ugauRdgitQXGlzPTQdezE1xZ3dngIzU+pYJZ5Rkv50dI/8WcozAG9UJ
	oGBHK0wlV1mctEJX4w7y8dWLVXO1lvjND7yn2pCtFbSqpnRbmhRkOGkdy6RfOukQ4iyoBB+fevg
	XaMN4RV8P0ANK2i/F/Zdso23xJ5ASNJgN5mZtI4zYOf+c6OWTQryemN3KcDh0Qe9J2KKU/t0ZB4
	Vo/zy9m4YxfYGHZ9FBslfahhy8suXJf9w5kq/F86zvTn2CwQ7TAVaS520xyh9nuqwCEIsCvCLAf
	lPmI0PWjYmgRIzuW5D6gZxz0tt7c7DYehpExKIwbVvzGKys7+TKchJls4qSUfHRDXkoHzBVLo2w
	nhAke9BNCZBouOucTDm9Y9AmZpr8vgtAIq+W7Anv4L5/8et386fQedFPqjxB3h50BTS3+KHJYR+
	szcc+ERPpbFi91WmpJRzZl1SdsRq81xM6gC8/Z2VlvwcQkrg==
X-Received: by 2002:a05:6a21:7701:b0:3c0:9c1a:8951 with SMTP id adf61e73a8af0-3c110b34ff1mr9202045637.73.1783951354731;
        Mon, 13 Jul 2026 07:02:34 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:5c10:3a1b:ac91:58ec:550:f309])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b93ae3b45sm19600646c88.15.2026.07.13.07.02.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 07:02:34 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH 0/2] t1100: modernize test script
Date: Mon, 13 Jul 2026 19:31:39 +0530
Message-ID: <20260713140142.27898-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a GSoC/Outreachy microproject ("Modernize a test script").  It
cleans up t/t1100-commit-tree-options.sh following the guidance Eric
Sunshine gave for t7001 in:

  https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/

Each patch makes a single kind of change:

  1/2 converts the tests from the old backslash-continued
      test_expect_success style with space-indented bodies to the
      modern quoted-body form indented with tabs.

  2/2 moves the here-doc that creates the "expected" file out of the
      script's top level and into the existing setup test, so it runs
      under the protection of the test harness.

There is no change to what the tests actually verify; t1100 continues to
pass all 5 tests after each patch.

I confirmed t1100 does not appear to be currently claimed on the list;
please let me know if someone is already working on it.

Thanks,
Shlok

Shlok Kulshreshtha (2):
  t1100: modernize test style
  t1100: move creation of expected output into setup test

 t/t1100-commit-tree-options.sh | 59 +++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 30 deletions(-)

-- 
2.52.0

