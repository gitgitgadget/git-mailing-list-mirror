Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBB2E36EB
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754186873; cv=none; b=G+4LM1kYIH/ch10VMV3pCbDcSL8V/+YxmdwwBCrxmZeqWDPybh7CZxSuKO0BBW1oPiIhTgEIJTArBPZPk/IADV9yYNYhSU6/KX2AasrCvkaVfXHHlEdtpDYh0tJKO4QL1rkJweCrtQIF5SCLLGZ7ZFC5T4/wBPE68ygRdy90n2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754186873; c=relaxed/simple;
	bh=x1CVyb40Uaj/CVEgTkOx5RtlQ4VWuE+hQdmz1uSlU98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0ECIfOB6gyE8UkaAi3o5bLbweSY2Qa2ITUldXNu7t3aVbMQc/tJDD5N5MlZtZQmLozMJ106Ev2mpEzyTEFkEw6rHh6ZcwYkhHjvdXUFuNRt2RwzG2r3YyKFdbdIH133wZMjY7V3Yof6yS5kdCLj/mw7kB1WJIpCNx25m/q+xmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3G3w0tg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3G3w0tg"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76b8d289f73so2254579b3a.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 19:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754186871; x=1754791671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7lhR6EM6xoW9EUQo8qHhSA+OtttRzMRjCewQT1kCjc=;
        b=L3G3w0tgrJPnwhvY8nYwMDQb0gmf8+ea5dIb44RnHJl1mTPiajkcQZ/6qOa3FgNkb/
         5JvPus5ZxY1iS7ZByruXDfFZecZEa5V2HTCgh84KDH9MdYVXhAsHzHDNUZ7i1C+9uCrQ
         U6STHLvo+h16r/zMKiFDGKnF8PWS7i0wl+3+t0nyfU/HPvJ/9WmPHrKNw/unVgrvnXPM
         AGX5q30vcRQo2syBR62ZJl5b9NMrWiu4t0j93IwU/M343CFE6B59q25VtDGX5Rvfn3KE
         nB6LuD6iSYuaOasncYckJjAedMD+YTzysv6/Lvp25U4MoHwHn70/Xk8VnWv9J0lT2buY
         sd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754186871; x=1754791671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7lhR6EM6xoW9EUQo8qHhSA+OtttRzMRjCewQT1kCjc=;
        b=WS/8nVc4IBNMA6gXY5OCOzqFkYFrSozJf0O8nG8tFfWjquQkjBkeGUkuz2ixtz18PC
         TDPr9kTxF5ZnPM00tgMmef3MeTJ+gj+bcchjEeLsebmOzYSWPDJIP8Ag3ga/Bw7xB8PU
         kHzoZ3IhA0bGsOIawxFfV02WOSG9Ijs8YmysGcWMaFs0GJhDVJE5GIHuJ1OcQfj+r/M+
         3NiTgB2PpSu1SnTiYUTXQDBgrjoqPUG6q/CZZf7N3NecaMObc+VJ0b7V9mFkejLT/WzG
         l+SKJCV5DhkioV2hgsMl5g/c86awGY33bP87zesdBvAYFeN8VXG9WrR4XbtDb1ouAiJz
         kYDw==
X-Forwarded-Encrypted: i=1; AJvYcCUXyPxynMMUP4uepUKdMb04rTvo/8jnirdOLFdZXiA2KycYQpdaNoSueL/ciYTifb80ejc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0f4ePx9RIfTj2tcGjp3QqJ5lPg1G2izkZQIIQzz+JvciYUii
	oCfwa5aAYWB5Yj6C5eTW6tOFrmZa3R7V+D5ShbmhQu7/HAXoA506I1Jh
X-Gm-Gg: ASbGncvmHKckxdYX9HijS9mDeLwybnxRtJfE+Um9pvCAqRC42LtTV7+0HMSF6Hd20ea
	1F7n5aenkj7pnvu5a+xegIYPM9ab0i/wgh9EEh5SAWRUZMelzgmkNWJDK449Mn04Yu+RgwEiP2w
	jgyGZPi2B360QqKrkuCPifFZHFgpV6xy15I0O5hnFtnro89HJu3JpWIGG4BgIbFmfqiuzpv4eXc
	v2PN4iT7prpx5NASlMBU2dYTsLAziV/4BWCJGpFniwWkKZCJhsM18jG7t/SEQdezsTi/mnU82Wu
	dNVyGDCEEvvJIFOBN0acxuyrzrwHOtoYn3mwcsco0M1S/o99oM5EMXRzXqTWvWDvtnsPyUPUmGV
	OUH5QkkY9wJ/4XLklgnOmLCbKKbPYTuFdcQXiRx3QGvMbNxj1fwQ=
X-Google-Smtp-Source: AGHT+IE5qqjCKdfMRVzbfqzJzlF84ZlvaMnpp00ApCROwXz9+9yLqQkb4gWtXf7B1Llin2r/pP16Cw==
X-Received: by 2002:a05:6a20:3d8c:b0:220:631c:e090 with SMTP id adf61e73a8af0-23df8d498e8mr7833151637.0.1754186870760;
        Sat, 02 Aug 2025 19:07:50 -0700 (PDT)
Received: from archlinux.tail6959dd.ts.net ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b77f530sm6466535a12.1.2025.08.02.19.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 19:07:50 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: ben.knoble@gmail.com,
	git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH V5 0/3] refactor t1517 to focus on help output outside a repository
Date: Sun,  3 Aug 2025 07:37:41 +0530
Message-ID: <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721115519.140361-1-usmanakinyemi202@gmail.com>
References: <20250721115519.140361-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors t1517-outside-repo.sh to focus on testing
`git subcmd -h` outside a Git repository. It does two things:

  1. Moves the existing `update-server-info -h` test to t5200, since it
     tests behavior *inside* a repo and belongs with other update-server-info
     tests.
  
  2. Introduces a loop in t1517 that automatically verifies `-h` output
     for all main Git subcommands when run outside a repository, using
     the `nongit` helper and `git --list-cmds=main`.

This makes t1517 easier to maintain and ensures that new commands are
automatically covered for this class of behavior.


Changes since v4:
  - Changes the approach from having the t1517 to test
  both help outside and inside repo to just having inside repo.
  - Drop spurious message during test 
  - Fix known breakages that actually work
  - Fix new t5200 by removing the trailing &&
  - Move the `prune -h` test to t5304

Usman Akinyemi (3):
  t/t1517: automate `git subcmd -h` tests outside a repository
  t5200: move `update-server-info -h` test from t1517
  t5304: move `prune -h` test from t1517

 t/t1517-outside-repo.sh       | 34 +++++++++++++++++++++-------------
 t/t5200-update-server-info.sh |  5 +++++
 t/t5304-prune.sh              |  5 +++++
 3 files changed, 31 insertions(+), 13 deletions(-)

Range-diff against v2:

1:  11eb3e7bfe < -:  ---------- t/t1517: automate `git subcmd -h` tests outside a repository
-:  ---------- > 1:  75a1d540e4 t/t1517: automate `git subcmd -h` tests outside a repository
2:  5cf43192d0 ! 2:  8c028256a0 t5200: move `update-server-info -h` test from t1517
    @@ t/t1517-outside-repo.sh: test_expect_success LIBCURL 'remote-http outside reposi
      
     -test_expect_success 'update-server-info does not crash with -h' '
     -	test_expect_code 129 git update-server-info -h >usage &&
    --	test_grep "[Uu]sage: git update-server-info " usage &&
    +-	test_grep "[Uu]sage: git update-server-info " usage
     -'
     -
    + test_expect_success 'prune does not crash with -h' '
    + 	test_expect_code 129 git prune -h >usage &&
    + 	test_grep "[Uu]sage: git prune " usage &&
    + 	test_expect_code 129 nongit git prune -h >usage &&
    + 	test_grep "[Uu]sage: git prune " usage
    + '
    ++
      for cmd in $(git --list-cmds=main)
      do
      	cmd=${cmd%.*} # strip .sh, .perl, etc.
    @@ t/t5200-update-server-info.sh: test_expect_success 'midx does not create duplica
      
     +test_expect_success 'update-server-info does not crash with -h' '
     +	test_expect_code 129 git update-server-info -h >usage &&
    -+	test_grep "[Uu]sage: git update-server-info " usage &&
    ++	test_grep "[Uu]sage: git update-server-info " usage
     +'
     +
      test_done
-:  ---------- > 3:  c1cdbf272f t5304: move `prune -h` test from t1517
-- 
2.50.1

