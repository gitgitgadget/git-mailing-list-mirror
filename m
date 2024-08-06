Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5411018D64C
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954044; cv=none; b=iEV//cY44ADNwiKU7LHy06jt+8AfJ6aJ8WzzyiVb9lkdHufGDDIDedsael36mgzeZ9w6RGSVdwmF1KV/tQE54vOLpeGsUVAL0cmtl08OPDtUTaVwBAMNwbp9pQ1Ozc3yABQghonT3cuISaL3tsPxx+yUP+JzZU71KeouKVNbeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954044; c=relaxed/simple;
	bh=Yq7Jso1qaNyf1C57hJymqsGPjG3dQohNVHJjxLVBg1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iavMU2bQSYyGJlpSDLeufd1f+Wp8pmDuT2E0udh+MDagprQisPd8qUYb1cGvujmZ5Q0fUo4t2qqWiHuvmt6a0XH5KQQ6xA9of4g/WJvjNF92qBo7eE52fCzq+OtKVirqKrPYwFcHW+c85Eb1QyWoe8fzvYKqR7KuQqsCXEq6p8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTaITnTT; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTaITnTT"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so466565b3a.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954042; x=1723558842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iK55DSUqQPJqgu5sDlx2q4P/RBb/TqVH2k6q+PlMLEo=;
        b=LTaITnTTBjj/Wni62qQibUV5zGGGHzURtJ2luDYen29+MOshMKd3Tx0Z/fGgRpB0Z4
         OhxhFbeMiAm5nrgqd+PvS9USZV7myiMi9QWH+bm/TnxSekJSJJIli8Y74IDZjpmX0t/g
         h/J2tCcQmF3m9+57DgYheSzp5fWLMC50usILCIHA3yWfGYZHENG8P6M6aNwyxt8OoW46
         NMtBFn4PFQGivG+62a1BGTZjc8s8QN016ZR7p05+extYvJBJuYRifgnbzrbbnF0J/kTF
         gwv0UqJttQ+Hk6M3fDsJnw+swhCP4LDywAv5/0V+d+dUkVzZfxYJnhjrcV0uhgmb/AKF
         QhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954042; x=1723558842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iK55DSUqQPJqgu5sDlx2q4P/RBb/TqVH2k6q+PlMLEo=;
        b=Aiqa+OHfoqtVPX6yJvFl8x8D1BfLE5WKJOJB8DWupg4vRy910PxD7s+tn77GGUOymc
         Xf/Kyrh97fQb1Xe2np7LOzQU6uPsMWheem8nYgtegv189g2hwkq3krI/OzxLDIuwjykH
         JpYjnmOpgTg14MULN3s8aqVJojfV6UW4/BISPKhboIRSkfC1i7EWaviHiXZQ2Gv61qjG
         lgM68K+wUcYYJea+KQsyMMlYteahwjd7aCAU/cY5vMy/1YEXt8Wgextbjwn7CflEzrNY
         HxysyWkPWECA1HZYpjSKBC7G8F6jnQmv+URjUqa2Uow4HW5RfMfuENFDP2oRs8v1s3lh
         epfA==
X-Gm-Message-State: AOJu0Yy2FVEifq7ntNTGlgne0KaMYcFdPa6onRqRaDuaAwJqGFjO+sMr
	Z5dfOh+exIWQ2OOv88C1fJ7OribC4qs7rIv4/OEGjH2GJjsfeg5zSY8UiCQv+WY=
X-Google-Smtp-Source: AGHT+IHdjgA/nrj6wdiz/DUt6kFnOpFSLuZQ1sRpzPNmv0bOexpboBthQFTDlrD4SRYw8V7urLPbOw==
X-Received: by 2002:a05:6a00:14c8:b0:706:a931:20da with SMTP id d2e1a72fcca58-7106cf8a9d2mr18558269b3a.3.1722954042145;
        Tue, 06 Aug 2024 07:20:42 -0700 (PDT)
Received: from Ubuntu.. ([27.59.87.1])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec416aasm7040563b3a.70.2024.08.06.07.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:20:41 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH 0/6] t: port reftable/stack_test.c to the unit testing framework
Date: Tue,  6 Aug 2024 19:43:36 +0530
Message-ID: <20240806142020.4615-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reftable library comes with self tests, which are exercised
as part of the usual end-to-end tests and are designed to
observe the end-user visible effects of Git commands. What it
exercises, however, is a better match for the unit-testing
framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
2023-12-09), which is designed to observe how low level
implementation details, at the level of sequences of individual
function calls, behave.

Hence, port reftable/stack_test.c to the unit testing framework and
improve upon the ported test. The first patch in the series moves
the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
CI/PR: https://github.com/gitgitgadget/git/pull/1762

Chandra Pratap(6):
t: move reftable/stack_test.c to the unit testing framework
t: harmonize t-reftable-stack.c with coding guidelines
t-reftable-stack: use Git's tempfile API instead of mkstemp()
t-reftable-stack: use reftable_ref_record_equal() to compare ref records
t-reftable-stack: add test for non-default compaction factor
t-reftable-stack: add test for stack iterators

Makefile                                                 |   2 +-
reftable/reftable-tests.h                                |   1 -
t/helper/test-reftable.c                                 |   1 -
reftable/stack_test.c => t/unit-tests/t-reftable-stack.c | 600 +++++++++++++++++++--------------
4 files changed, 355 insertions(+), 249 deletions(-)
