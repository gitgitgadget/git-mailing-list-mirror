Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11E42D838E
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728182; cv=none; b=LGloulN0zIh3951Oi4s0+RA/qe9+bdEwlhS74CLAABZMO1KuVDkbiXHLonTIQVdbRxRz6k7tvdXsZIDcKjkTOo7Wfsd7aFU+OYuum9/GdjDR4W1NPP3MKnT8+0Gp6NbOHjJCdnfumFijE6herb6+ieRcFc5kPfdE2MDevz8LHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728182; c=relaxed/simple;
	bh=RIDwn7FTgLFo9zt5J/1d08mrVJFWHJZf8KFtw6OPbGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZtvwX1a3y/af2mY+DKTBbTVErZQCAa16Aih1+6f7Nxw8lyjtUTLSv7rEegIiEh12oZM8tQYyK38EbBxPhS4J2BUa4Id2peAf/L38gMxRaq8lcZMx8CeWDbbERExCsczQL/UgpWQV23q/5yZqaxKVVfLzkMRp8KUgISQi3RTob6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqQiYhAp; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqQiYhAp"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c648bc907ebso2231629a12.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728181; x=1775332981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O3/1paYAqgeJZLEughnrOWshHaIFC/pnMfEuX91SddA=;
        b=UqQiYhAp2f9otQs94Yp2/JWTNxn0NjZwYyE/XRepIupZyzC60+t5glAf28JSSkMpIc
         +42hFgn223LRtl3K2egdkMtJNLS5XmKlGfNZgrZe0HzXyMgd1kkFmBxStwAW5eEu5r9W
         EDWWE7gh11oo8mJXQL6t93n6t2IRntX5OMxQBrKnHaXQdQfdEwTrql8Grc+B7FLjEL52
         1cTblm84nvl03fIRDFymN8oWgbYRMmbaaXTX9m42luHuJusUiVu11z4xdfdGo7adhjSW
         giNMscc4NLig2KsW3v+2OhLKVvmGn1B98+BC9ghYdzPqie8A6vYTlNETjitNto7QSOa1
         2YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728181; x=1775332981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3/1paYAqgeJZLEughnrOWshHaIFC/pnMfEuX91SddA=;
        b=qIAlvSWcqR6fypLc+9kHV7yhhotm0xkI8JAt+KrCFWVJ8c4lj3a0GdZ6iuQeLyn5c8
         F5vNcpnwKrmupo+B/B/kpUXhwCc76s0pKLqNPbhNoKSSzrqoBBO0KLW7iR+4LOP/od9h
         cObk/WA+2vCIsJvt0NCo/JlFl1x6iiHb+YW9cmnebXuTqjdbTa6PXTnj+H1X5CrFNT0R
         c3hn3eihrUZraOiFJ4SyrxaLO/ErCI0cbkesFbV/RdqbzstVJbPMTQGNah8WIRIybTvK
         pepbhHniRTRtNNZsX2CzD8LCULKL/YnM8ErxF3fNJ5X1gJM+y3mbUfwlIcsx9Rx2YyjM
         YLRA==
X-Gm-Message-State: AOJu0Yw4eVVSFqDWF9RSa/7HlTNdT37nvkJYtlfp+bnobRMqbkc6Tq+x
	XWZm5ZpNQxc5unww4Z3Q8E6wNt7GBQs1u4olmfD9k3Qi5NVSCJWWKO8VKAxuqLzM
X-Gm-Gg: ATEYQzysKFQA90PD1ekxk5KKL308zszrGMPRUv0aJXWFMP1NttyXAXc24sZ9CZAE4DV
	5G8lY3BbYP4G/HcJEjDWXBEjkrzrdLgM2zJO9MfjwpY9MWsoa8htUrycvU+8sH5RW4TjPrCOBSI
	JfgWcmL5CHNvLT2627BcHllXIew3c/s/OEYAXu7yJaOyRoVQnUBrO0cfES/qlsPN8ZYFUaVudno
	iCcc/H7JjHrEX5k1hzBlrsXDTPQmEScTM2jY6g4lHDxcvBJTVOFFYv4xoJcuZPIkdfZ3tD0xiCV
	v8AbHxfsUFNCJmtN0ORAsJPFcYWYdtjXDyIXC18j92HUYGYBYYUXQZKUbHd3gAFq+1lKK3A+RmM
	1b1Pmps8ZrJkmeRQNvuA4K/FokPfWtqg7C5rNRNew7tcNhqFYW1Cmffp4PeKxV7V15NyUe5ZT5z
	RqB66hTUtEKpfj9AwpinlYXAdTGs7/eiMxQl+BinZHFM7iWen/tuQECFFnXdjE9flzND0bSJ5mm
	M/9aZlHPQ==
X-Received: by 2002:a05:6a20:158b:b0:39b:e789:7d20 with SMTP id adf61e73a8af0-39c87abff3fmr7968170637.44.1774728180616;
        Sat, 28 Mar 2026 13:03:00 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:00 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 00/16] Microproject: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:39 +0900
Message-ID: <20260328200255.247759-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Piping git command output directly to subsequent command (eg. grep)
hides the exit code of git behind the pipe.  A crash in git would go
unnoticed because the shell only sees grep's exit code.

This series extends the same fix to 16 more test files, following the
approach introduced in t8003 [1] (redirect output to a temporary file,
then use test_grep on that file).

Note: t2206 is a special case -- some tests cd into a subdirectory
that is itself a git repo and run 'git add .' on the whole working
tree.  To prevent the temporary file from being accidentally staged,
it is written as '../actual', outside the inner repo.

Related-to: https://lore.kernel.org/git/20260328132955.172262-1-vikingtc4@gmail.com/T/#t
See-also: https://lore.kernel.org/git/xmqq4im2sjnu.fsf@gitster.g/T/#t

Trieu Huynh (16):
  t7004: avoid suppressing git's exit code
  t6423: avoid suppressing git's exit code
  t6411: avoid suppressing git's exit code
  t6101: avoid suppressing git's exit code
  t6006: avoid suppressing git's exit code
  t5304: avoid suppressing git's exit code
  t4153: avoid suppressing git's exit code
  t4150: avoid suppressing git's exit code
  t4140: avoid suppressing git's exit code
  t4039: avoid suppressing git's exit code
  t3903: avoid suppressing git's exit code
  t3701: avoid suppressing git's exit code
  t3412: avoid suppressing git's exit code
  t1400: avoid suppressing git's exit code
  t0100: avoid suppressing git's exit code
  t2206: avoid suppressing git's exit code

 t/t0100-previous.sh                 |  3 +-
 t/t1400-update-ref.sh               |  3 +-
 t/t2206-add-submodule-ignored.sh    | 45 +++++++++++++++++++----------
 t/t3412-rebase-root.sh              |  6 ++--
 t/t3701-add-interactive.sh          | 12 +++++---
 t/t3903-stash.sh                    |  5 ++--
 t/t4039-diff-assume-unchanged.sh    |  3 +-
 t/t4140-apply-ita.sh                |  3 +-
 t/t4150-am.sh                       |  5 ++--
 t/t4153-am-resume-override-opts.sh  |  3 +-
 t/t5304-prune.sh                    |  3 +-
 t/t6006-rev-list-format.sh          |  3 +-
 t/t6101-rev-parse-parents.sh        |  3 +-
 t/t6411-merge-filemode.sh           |  6 ++--
 t/t6423-merge-rename-directories.sh |  3 +-
 t/t7004-tag.sh                      |  6 ++--
 16 files changed, 74 insertions(+), 38 deletions(-)

-- 
2.43.0

