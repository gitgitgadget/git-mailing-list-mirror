Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A381F4617
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300584; cv=none; b=vFUXE5l6qUWatjJ6/EA6niAW1Htp/oLw/uoRnQexr/CGcsS23cGa9vLI7sw35POpGHtG3oj4UzHS21Sz+QxyYwDJxCpNVOFvul3vnThvWD7zBAtGemFctWcoPhax+GXtjQFfYUNp1OA6OzFZPw3P9t+tngSbIR0uUEhNKVFxjXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300584; c=relaxed/simple;
	bh=kFmKVvruUFRcYjZT/dS6B9XJ9a9+9zHuAobJUEz3IPo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V0p3ftKmPvybuTA3dZ8nMcC6H3r0dJP0HTN3B5ReBzkGafByPe2ISMQQ9rGsVnLfVvJSMl7VnWNJJ1xBAEn7PH2PRewM8BvsN0hT/CDOzx6fWkFlNaDCOL3rgZGVXr4vFzj7P1V80EPpZo61hgjGLX98CCg1bEt4YCZz0KZYzC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwd+worT; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwd+worT"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b350c85cf4eso467051a12.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 02:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754300582; x=1754905382; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gi0AAvxky+sMzDizkvZdNy1G/+wNN/djL8fVPiLXLho=;
        b=iwd+worT2YnC0KJ/Y8JlIxGKXiiZjMlCpGf1goUaUiGJ91pY5fkYK/k0K4+7/ZXt2K
         8mISkuXZxjmYft7OCNUGyVUUwOguxWO882EUmNTYU9Smgpt4Ig4IV6Ykw6mAWh9RwIq2
         zzxCpdG1A7EOvSenEhnVwvroyNYG4mkeLN4goWj23/o+PtmuVxEhCRCrOSq/f25supaf
         V1x45s3GxLPppk2WAkB90y8CdUoYjP5G4QzsYndWNEaFO4GZrZzKmQw/C3xvafuC4liW
         XSf4CKNDb6tIWTWsJUCA+bCMl5KJfWpfA3WNkzUHYPHzR9zVKFLnslIYmNAFVq/rc7+6
         rkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754300582; x=1754905382;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gi0AAvxky+sMzDizkvZdNy1G/+wNN/djL8fVPiLXLho=;
        b=eWKJ7VhYVCf76m7UCZEpbYxVEbsjA3xEXlqFxTRV8V/4k2MdElUnSKPtAqZOhJTOkL
         J4cmS+M50k8a1bUGdjHL88Es3UVTQwjMUu1jXouX9yYH1d6EG0TbdumGJkZfX3sSEoGG
         Mh8ucYNoWtC7ymcoD9mG+/uww+dW9g8aI42IjRoLWGr83r4e+W875m3c7t8FfqoWUyl+
         HPWW6151aKb1uoeyM7OM2vmKeMi44HAfkI6THclhQ0ZRJ5rhyISz7cKhu/Om7z2UBi85
         8kQkwXLoodD4b/rAWyK7ppyNq+nV2tTjwEYzPsZhx2lgTZbCudvQIaxWUoiZh4aullMI
         7y6Q==
X-Gm-Message-State: AOJu0YzsEW6+ZXWc3qvsP30fXcc692NbrDBor1buXGMbMIWlP0BU2fMC
	LKw5B+vOcRYDXHz/OhOU+JQQNwhKzvxHi/TBRYkfq7mUbeTIcGgneHRsQjjXxQ==
X-Gm-Gg: ASbGncsSfFQBn7VJ9VATHBEFS8sFHqZb0OHzV2qnSkjoFNv51wXWpvvmFhr2+h8AOaB
	UNW7GpP2zEOUmFjclPiCMcB9BRtg37fJrjyj3ZL2XI3wbPmN1n/ixCnPpc/i8ky3i8PpCz/YkWj
	A977g9Ewx+q64Cg25HqtTxvrytFzsxGRQhxN7djLMTug4gohXd5jV3LHKHKgT1B5nxjDXrSzUzB
	WyIK7Mr7UIOfcgqFNWb5FAfxM3rIeIhFMgO6+akQyRtgk7bUrOqF8aD/IannqPZdsyNLypqQYKa
	ynwnoctX6q3HbskR3ACS9NQ4Cb+beXVkG7YQnSkfarPz1vBm3lEnIPWBpSVb48l9pcW2M7a1Axj
	oS27B1fh9h1SzKvajIB58naHE6KcC0A==
X-Google-Smtp-Source: AGHT+IHpwv7ohdNwRdnSCQtMt6oi3ogFeuHZ6WyfFlVSBTmwqTqHUSK0rrOncvwgt5r2v3VUadENbA==
X-Received: by 2002:a05:6a00:4614:b0:730:9a85:c931 with SMTP id d2e1a72fcca58-76bec4d97e8mr4918290b3a.7.1754300582296;
        Mon, 04 Aug 2025 02:43:02 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76be8650387sm6163727b3a.51.2025.08.04.02.43.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:43:01 -0700 (PDT)
Date: Mon, 4 Aug 2025 02:42:53 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/2] remote.c: remove erroneous BUG case
Message-ID: <cover.1754300389.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In the case where one pushes a non-existent oid to an unqualified
destination, we encounter the following BUG

	error: The destination you provided is not a full refname (i.e.,
	starting with "refs/"). We tried to guess what you meant by:

	- Looking for a ref that matches 'branch' on the remote side.
	- Checking if the <src> being pushed ('0000000000000000000000000000000000000001')
	  is a ref in "refs/{heads,tags}/". If so we add a corresponding
	  refs/{heads,tags}/ prefix on the remote side.

	Neither worked, so we gave up. You must fully qualify the ref.
	BUG: remote.c:1221: '0000000000000000000000000000000000000001' should be commit/tag/tree/blob, is '-1'
	fatal: the remote end hung up unexpectedly
	Aborted (core dumped)

However, this isn't actually a bug so replace it with an advise()
message.

Denton Liu (2):
  t5516: introduce 'push ref expression with non-existent oid src'
  remote.c: remove BUG in show_push_unqualified_ref_name_error()

 remote.c              | 5 +++--
 t/t5516-fetch-push.sh | 7 +++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.50.1

