Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0AA383A4
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040563; cv=none; b=L8YbSPTPD7qWaFs1XNXFfBDXwHzt+eDLbH3VqNdihbaaxrsqWcOmGnSzkdMuyJXlKtIBLH+W6ig5TffZJph8blKtGtSd5ozR9rCNDtGhxZRJwF6vqfK1dKi/6Lc1Dt+AhMX8zzsgJ9vvHHOoJYQxPKnVze+H1laqRtIqReddXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040563; c=relaxed/simple;
	bh=kEbB0V95fjwZgjjEy3hOJ40Y6tNb+lHOM3EY7ffY0C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avCHW7qT4VqEiEEz+Ub6dLdTsimgW90X6S9ZycumIiRQslKf6Ft0W+wMYiLj2VwcQ5Lo1JUT5/itUxxs2s7zk0PlGvttiUS+bs1+LscTCu2ogtfl/c7mGXtDF9EqalNHwONalVrvWrKzrrVEeraEEZqUP4CGI3TRDyEJqIQwGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=horwlviy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="horwlviy"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56df42c2773so46589a12.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712040560; x=1712645360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CtRqjcEi+sax23l1IMLNzursNhOtcBGv23GA4znGgU=;
        b=horwlviyrlrdv4736aeLM7Uiws2hDcYyXpqfD2X1EtvENpMlk0As/JLNrZnCBAaOxa
         H8I3bhJDt/g1oJv7lDntyFnku10KccGWI+grLkH9IDnzBlHvIbAGCPJoRgG/rtggfMP8
         +fBxOSF+T056WBXuLiRvDKY8w/TvwB1ieBvWLFbPVQOYvjUsr2h7jqIUXNhj85Z01bhe
         jvC5v81KoG7fe9dXDZLgN6otz57MIu3ol0ka8RjX2+jaHrKywoMIep6QiwgHlzyTigK4
         wsthM549Fd7dLDo0f/i6U5+9COGqmBKzyQsQr1AICNanAbRDgOmXr6UB90kepFwVANAo
         m+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712040560; x=1712645360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CtRqjcEi+sax23l1IMLNzursNhOtcBGv23GA4znGgU=;
        b=O0ae7nEVeKwlUYuSp+fVro+HOEisWMHSsfSeW8cMNOPutud9uDUVHiyWczQKgZUF4/
         HD0sSsgD8Irdhz7J2NZH/3o+DmAA8VOHUVxAGOpzKI9a2umZEHBkLmkFxrviT1PTBW38
         ts45mD1xcewl+D+40x+5zQgRGVX8b2Qq2NXaqDQd2yGffx9BkNBkmpgbj8GgsGjcaRkX
         wVxP5F0Pm3q+2jcvshqHjSc9lWXTIPy7k6bMdJWNjMSGecCOu2eSval9MFQS05hC3Ucz
         bsO2JGc84U/imNPMUGGu4wqFcgjfsw+vz4ZjFi1G5xokS6LgVy1wW+YB/pqcs+irYo2u
         tnew==
X-Forwarded-Encrypted: i=1; AJvYcCXHYztgPdE+zMidZBEx6h1xxzW2gwGN5k57FUl6Sk7AZyAqQykacBp87uQ3SBc54cL3h+DW7kIrhyBqxVm6ut0w3zQ1
X-Gm-Message-State: AOJu0Yx0J80ZPu/KoFq4nd53g1jzVMT6w70UIcoeQTi3DLLnxwG2sKGh
	wAd/HcbXaOjn7mQrPzUw/J81lbz5y1ZPcaMjtKdNLI/E9YejqjVB
X-Google-Smtp-Source: AGHT+IEBxBsY8BjLuVT8dgXZO8CIfiHGmlW286RnznAXezpJ8lAyzakfgGMDwWX1rMHt/zos590vHg==
X-Received: by 2002:a50:8a9e:0:b0:56b:8f6d:8a99 with SMTP id j30-20020a508a9e000000b0056b8f6d8a99mr6343946edj.22.1712040559475;
        Mon, 01 Apr 2024 23:49:19 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:c3e0:2f8a:1ead:1494])
        by smtp.gmail.com with ESMTPSA id n7-20020a509347000000b0056c24df7a78sm6582774eda.5.2024.04.01.23.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 23:49:18 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v2 0/2] improve documentation around git-update-ref
Date: Tue,  2 Apr 2024 08:49:13 +0200
Message-ID: <20240402064915.191104-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401144542.88027-1-knayak@gitlab.com>
References: <20240401144542.88027-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

This patch series was derived out of the discussion [1] around my other
patch series to add symref support for `git-update-ref(1)` [2].

The aim of these patches is to improve clarity around OIDs in the
documentation. This makes it easier to draw parallels between regular
ref updates and symref updates. The symref patch series will be rebased
on top of this in the upcoming version.

Changes in v2:
- Fixed broken tests due to changes in update-ref.c

Range diff against v1:
1:  5a315a0aa0 ! 1:  f5cc3738ee update-ref: use {old,new}-oid instead of {old,new}value
    @@ builtin/update-ref.c: static void parse_cmd_delete(struct ref_transaction *trans
      		have_old = 1;
      	}
      
    +
    + ## t/t1400-update-ref.sh ##
    +@@ t/t1400-update-ref.sh: test_expect_success 'stdin fails create with no ref' '
    + test_expect_success 'stdin fails create with no new value' '
    + 	echo "create $a" >stdin &&
    + 	test_must_fail git update-ref --stdin <stdin 2>err &&
    +-	grep "fatal: create $a: missing <newvalue>" err
    ++	grep "fatal: create $a: missing <new-oid>" err
    + '
    + 
    + test_expect_success 'stdin fails create with too many arguments' '
    +@@ t/t1400-update-ref.sh: test_expect_success 'stdin fails update with no ref' '
    + test_expect_success 'stdin fails update with no new value' '
    + 	echo "update $a" >stdin &&
    + 	test_must_fail git update-ref --stdin <stdin 2>err &&
    +-	grep "fatal: update $a: missing <newvalue>" err
    ++	grep "fatal: update $a: missing <new-oid>" err
    + '
    + 
    + test_expect_success 'stdin fails update with too many arguments' '
    +@@ t/t1400-update-ref.sh: test_expect_success 'stdin update ref fails with wrong old value' '
    + test_expect_success 'stdin update ref fails with bad old value' '
    + 	echo "update $c $m does-not-exist" >stdin &&
    + 	test_must_fail git update-ref --stdin <stdin 2>err &&
    +-	grep "fatal: update $c: invalid <oldvalue>: does-not-exist" err &&
    ++	grep "fatal: update $c: invalid <old-oid>: does-not-exist" err &&
    + 	test_must_fail git rev-parse --verify -q $c
    + '
    + 
    + test_expect_success 'stdin create ref fails with bad new value' '
    + 	echo "create $c does-not-exist" >stdin &&
    + 	test_must_fail git update-ref --stdin <stdin 2>err &&
    +-	grep "fatal: create $c: invalid <newvalue>: does-not-exist" err &&
    ++	grep "fatal: create $c: invalid <new-oid>: does-not-exist" err &&
    + 	test_must_fail git rev-parse --verify -q $c
    + '
    + 
    + test_expect_success 'stdin create ref fails with zero new value' '
    + 	echo "create $c " >stdin &&
    + 	test_must_fail git update-ref --stdin <stdin 2>err &&
    +-	grep "fatal: create $c: zero <newvalue>" err &&
    ++	grep "fatal: create $c: zero <new-oid>" err &&
    + 	test_must_fail git rev-parse --verify -q $c
    + '
    + 
    +@@ t/t1400-update-ref.sh: test_expect_success 'stdin delete ref fails with wrong old value' '
    + test_expect_success 'stdin delete ref fails with zero old value' '
    + 	echo "delete $a " >stdin &&
    + 	test_must_fail git update-ref --stdin <stdin 2>err &&
    +-	grep "fatal: delete $a: zero <oldvalue>" err &&
    ++	grep "fatal: delete $a: zero <old-oid>" err &&
    + 	git rev-parse $m >expect &&
    + 	git rev-parse $a >actual &&
    + 	test_cmp expect actual
    +@@ t/t1400-update-ref.sh: test_expect_success 'stdin -z fails create with no ref' '
    + test_expect_success 'stdin -z fails create with no new value' '
    + 	printf $F "create $a" >stdin &&
    + 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
    +-	grep "fatal: create $a: unexpected end of input when reading <newvalue>" err
    ++	grep "fatal: create $a: unexpected end of input when reading <new-oid>" err
    + '
    + 
    + test_expect_success 'stdin -z fails create with too many arguments' '
    +@@ t/t1400-update-ref.sh: test_expect_success 'stdin -z fails update with no ref' '
    + test_expect_success 'stdin -z fails update with too few args' '
    + 	printf $F "update $a" "$m" >stdin &&
    + 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
    +-	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
    ++	grep "fatal: update $a: unexpected end of input when reading <old-oid>" err
    + '
    + 
    + test_expect_success 'stdin -z emits warning with empty new value' '
    + 	git update-ref $a $m &&
    + 	printf $F "update $a" "" "" >stdin &&
    + 	git update-ref -z --stdin <stdin 2>err &&
    +-	grep "warning: update $a: missing <newvalue>, treating as zero" err &&
    ++	grep "warning: update $a: missing <new-oid>, treating as zero" err &&
    + 	test_must_fail git rev-parse --verify -q $a
    + '
    + 
    + test_expect_success 'stdin -z fails update with no new value' '
    + 	printf $F "update $a" >stdin &&
    + 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
    +-	grep "fatal: update $a: unexpected end of input when reading <newvalue>" err
    ++	grep "fatal: update $a: unexpected end of input when reading <new-oid>" err
    + '
    + 
    + test_expect_success 'stdin -z fails update with no old value' '
    + 	printf $F "update $a" "$m" >stdin &&
    + 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
    +-	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
    ++	grep "fatal: update $a: unexpected end of input when reading <old-oid>" err
    + '
    + 
    + test_expect_success 'stdin -z fails update with too many arguments' '
    +@@ t/t1400-update-ref.sh: test_expect_success 'stdin -z fails delete with no ref' '
    + test_expect_success 'stdin -z fails delete with no old value' '
    + 	printf $F "delete $a" >stdin &&
    + 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
    +-	grep "fatal: delete $a: unexpected end of input when reading <oldvalue>" err
    ++	grep "fatal: delete $a: unexpected end of input when reading <old-oid>" err
    + '
    + 
    + test_expect_success 'stdin -z fails delete with too many arguments' '
    +@@ t/t1400-update-ref.sh: test_expect_success 'stdin -z fails verify with too many arguments' '
    + test_expect_success 'stdin -z fails verify with no old value' '
    + 	printf $F "verify $a" >stdin &&
    + 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
    +-	grep "fatal: verify $a: unexpected end of input when reading <oldvalue>" err
    ++	grep "fatal: verify $a: unexpected end of input when reading <old-oid>" err
    + '
    + 
    + test_expect_success 'stdin -z fails option with unknown name' '
    +@@ t/t1400-update-ref.sh: test_expect_success 'stdin -z update ref fails with wrong old value' '
    + test_expect_success 'stdin -z update ref fails with bad old value' '
    + 	printf $F "update $c" "$m" "does-not-exist" >stdin &&
    + 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
    +-	grep "fatal: update $c: invalid <oldvalue>: does-not-exist" err &&
    ++	grep "fatal: update $c: invalid <old-oid>: does-not-exist" err &&
    + 	test_must_fail git rev-parse --verify -q $c
    + '
    + 
    +@@ t/t1400-update-ref.sh: test_expect_success 'stdin -z create ref fails with bad new value' '
    + 	git update-ref -d "$c" &&
    + 	printf $F "create $c" "does-not-exist" >stdin &&
    + 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
    +-	grep "fatal: create $c: invalid <newvalue>: does-not-exist" err &&
    ++	grep "fatal: create $c: invalid <new-oid>: does-not-exist" err &&
    + 	test_must_fail git rev-parse --verify -q $c
    + '
    + 
    + test_expect_success 'stdin -z create ref fails with empty new value' '
    + 	printf $F "create $c" "" >stdin &&
    + 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
    +-	grep "fatal: create $c: missing <newvalue>" err &&
    ++	grep "fatal: create $c: missing <new-oid>" err &&
    + 	test_must_fail git rev-parse --verify -q $c
    + '
    + 
    +@@ t/t1400-update-ref.sh: test_expect_success 'stdin -z delete ref fails with wrong old value' '
    + test_expect_success 'stdin -z delete ref fails with zero old value' '
    + 	printf $F "delete $a" "$Z" >stdin &&
    + 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
    +-	grep "fatal: delete $a: zero <oldvalue>" err &&
    ++	grep "fatal: delete $a: zero <old-oid>" err &&
    + 	git rev-parse $m >expect &&
    + 	git rev-parse $a >actual &&
    + 	test_cmp expect actual
2:  17950e0693 = 2:  972faccb4a githooks: use {old,new}-oid instead of {old,new}-value

[1]: https://public-inbox.org/git/20240330224623.579457-1-knayak@gitlab.com/T/#m7bb4d1f44b656d7cfb73ed3220b990aa6d1ac247
[2]: https://public-inbox.org/git/20240330224623.579457-1-knayak@gitlab.com/T/#t

Karthik Nayak (2):
  update-ref: use {old,new}-oid instead of {old,new}value
  githooks: use {old,new}-oid instead of {old,new}-value

 Documentation/git-update-ref.txt | 58 ++++++++++++++++----------------
 Documentation/githooks.txt       | 16 ++++-----
 builtin/update-ref.c             | 26 +++++++-------
 t/t1400-update-ref.sh            | 34 +++++++++----------
 4 files changed, 67 insertions(+), 67 deletions(-)

-- 
2.43.GIT

