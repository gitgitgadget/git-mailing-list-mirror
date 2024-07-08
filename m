Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF33D1E495
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445544; cv=none; b=PEAUWHlAbttpPtyicQzPQDyy2N+2GhMxoJci+2nQEHoK1Xxx9OaHKtNr40EwtHsYQ8ixQahXQbQCCPXbdz1gu7PS7IGFhk/WULOvSYFWA6UmnFoFQ9W7aJHT1QkXt8AbVmW7UlLzcfJfypAxXz74rWY7E2SPp5dxR4DYjkSboMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445544; c=relaxed/simple;
	bh=RDmnLrMIvr569Z8417UuXoeTkzuLdnGlmxkTAOG2r0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPDDKk/M9LjtONyD8Lu/C8oddvTjpieV1S8OCImLGGc31F+lKqoiljsG3DLncs5+e6AKfcecmNI7i7H5ATpTxo7IlxlnCAfvYRLDqVaeJ504IjOCMXpzIwvN4FjP0E/DDWkNxpjHj1o1Ai0/s4/JGuWhD8+uMttbZSgGBGAMLYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIc/NqG5; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIc/NqG5"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-75cda3719efso1791008a12.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720445541; x=1721050341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCUGeMyTqolPUh9pYobf6bWMXOZsI0tNWbqcagMd16Q=;
        b=LIc/NqG58aewI1YTIQGotZogo3k63uUu71RJkqEYYREcJtOGMxtWvVQpDmOcLttE/j
         OvF0bX8hImrEmEN2Ul9uMi1ManxIRgxkbMZ8w+hwr903zl44JtzfSVblfOnc4KHwoHbY
         P/hOpbyq02UjShUFKvzF8TcYKVrVKwenDrhr+nteYfNjD3ngDKrqvRwCDAV5AKWi8BKF
         +Ocj8XcAZz41kPCyaglP67ywgvYuAGJXfhr4gnsxatuRcIWI6evn7qqfBB2oKIRbpFhl
         CZo0FjFf74BP8K7kYCM99wQLDJLdnM/uiTRQsIjqEVPNk8ETzrR4ykjyl8hv/xcnUiDV
         tImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445541; x=1721050341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCUGeMyTqolPUh9pYobf6bWMXOZsI0tNWbqcagMd16Q=;
        b=IPRYOwBLKpn15SgzAbsZ1ORdWguX6jWADqGW7uw6VkPlLsopYn8QGxvWnbsnO4Bu+o
         SCWmOQ6dPwnIgl0VpqoX34aQsFGCgQS8GJ23ixz0BrEZcbLzvAveaRsNL1xmnYUrKiyd
         FiIFTbT8Sl37K0p5YMie9POA7toGw1knPRKJH/ec4LXPWIoE354JMeGaPu8082A+zG4a
         /xc53+3l1kkKVgbxGr3WkKXB4zlK8MKiidqcsN5F5pHFzgK4z7DOWK8CDTE7IMVHVJnB
         UHrhbN2fPPtIenHaOhYQiH70vxVob/AtpH8pBen45ReZAyx79uhALADBMRI/TBMkvlfF
         xQdg==
X-Gm-Message-State: AOJu0YxXIBqTFsIoQDfgPzXf4dcuVv0oqwUpJy8v8LC2hYLQ/64O3lTU
	tmWq/FtqZnw2eza00hnv+7e7OsuYouNdRdF7mwImTdhrsA8bhiZIfNVJqGgc
X-Google-Smtp-Source: AGHT+IGD0D+ho7OaFrZMCyrfPgWk1FfNkgRR03K60f1vwEk0hI5s+fKHb1OPOnon3YPR9RI7avm0hw==
X-Received: by 2002:a05:6a20:1591:b0:1c2:8cc4:908a with SMTP id adf61e73a8af0-1c28cc492d9mr1698059637.46.1720445541324;
        Mon, 08 Jul 2024 06:32:21 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b2203a058sm3849013b3a.195.2024.07.08.06.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:32:20 -0700 (PDT)
Date: Mon, 8 Jul 2024 21:32:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v8 0/9] ref consistency check infra setup
Message-ID: <ZovqY4vQnQBAs7PH@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVX6sn2C9VIeZ38@ArchLinux>

Hi All:

This version enhances the patch 1 and patch 2 commit messages according
to the review of Justin.

Thanks,
Jialuo

shejialuo (9):
  fsck: rename "skiplist" to "oid_skiplist"
  fsck: add a unified interface for reporting fsck messages
  fsck: add refs-related options and error report function
  refs: set up ref consistency check infrastructure
  builtin/refs: add verify subcommand
  builtin/fsck: add `git-refs verify` child process
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend
  fsck: add ref content check for files backend

 Documentation/fsck-msgids.txt |  12 ++
 Documentation/git-refs.txt    |  13 ++
 builtin/fsck.c                |  32 ++++-
 builtin/mktag.c               |   1 +
 builtin/refs.c                |  44 ++++++
 fsck.c                        | 107 +++++++++++---
 fsck.h                        |  63 ++++++---
 object-file.c                 |  11 +-
 refs.c                        |   7 +-
 refs.h                        |   8 ++
 refs/debug.c                  |  11 ++
 refs/files-backend.c          | 255 +++++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 ++
 refs/refs-internal.h          |  11 +-
 refs/reftable-backend.c       |   8 ++
 t/t0602-reffiles-fsck.sh      | 211 ++++++++++++++++++++++++++++
 16 files changed, 745 insertions(+), 57 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Range-diff against v7:
 1:  f5fcf36132 !  1:  61e475840f fsck: rename "skiplist" to "oid_skiplist"
    @@ Metadata
      ## Commit message ##
         fsck: rename "skiplist" to "oid_skiplist"
     
    -    Because we introduce ref consistency check. The original "skiplist" is a
    -    common option which is set up during handling user configs. To avoid
    -    causing ambiguity, rename "skiplist" to "oid_skiplist".
    +    The "skiplist" field in "fsck_options" is related to objects. Because we
    +    are going to introduce ref consistency check, the "skiplist" name is too
    +    general which will make the caller think "skiplist" is related to both
    +    the refs and objects.
    +
    +    It may seem that for both refs and objects, we should provide a general
    +    "skiplist" here. However, the type for "skiplist" is `struct oidset`
    +    which is totally unsuitable for refs.
    +
    +    To avoid above ambiguity, rename "skiplist" to "oid_skiplist".
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
 2:  c81b5b6fba !  2:  f2576d88a9 fsck: add a unified interface for reporting fsck messages
    @@ Metadata
      ## Commit message ##
         fsck: add a unified interface for reporting fsck messages
     
    -    The static function "report" provided by "fsck.c" aims at reporting the
    -    problems related to object database which cannot be reused for refs.
    -    In order to provide a unified interface which can report either objects
    -    or refs, create a new function "vfsck_report" by adding
    -    "checked_ref_name" parameter following the "report" prototype. However,
    -    instead of using "...", provide "va_list" to allow more flexibility.
    +    The static function "report" provided by "fsck.c" aims at checking fsck
    +    error type and calling the callback "error_func" to report the message.
    +    However, "report" function is only related to object database which
    +    cannot be reused for refs. In order to provide a unified interface which
    +    can report either objects or refs, create a new function "vfsck_report"
    +    by adding "checked_ref_name" parameter following the "report" prototype.
    +    Instead of using "...", provide "va_list" to allow more flexibility.
     
    -    The "vfsck_report" function will use "error_func" registered in
    -    "fsck_options" function to report customized messages. Change
    -    "error_func" prototype to align with the "vfsck_report".
    +    Like "report", the "vfsck_report" function will use "error_func"
    +    registered in "fsck_options" to report customized messages. Change
    +    "error_func" prototype to align with the new "vfsck_report".
     
    -    Change "report" function to make it use "vfsck_report" to report
    -    objects-related messages. Add a new function called "fsck_refs_report"
    -    to use "vfsck_report" to report refs-related messages.
    +    Then, change "report" function to use "vfsck_report" to report objects
    +    related messages. Add a new function called "fsck_refs_report" to use
    +    "vfsck_report" to report refs related messages.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
 3:  53156dc847 =  3:  c3c2dda50c fsck: add refs-related options and error report function
 4:  358f4a1be9 =  4:  e826dc17ec refs: set up ref consistency check infrastructure
 5:  e632859df6 =  5:  33cac4882b builtin/refs: add verify subcommand
 6:  5d7a6261ae =  6:  32668e3543 builtin/fsck: add `git-refs verify` child process
 7:  33311af1b1 =  7:  df83b2a990 files-backend: add unified interface for refs scanning
 8:  02bd3ac952 =  8:  c696c15651 fsck: add ref name check for files backend
 9:  94d123471d =  9:  8b0f3aeb9c fsck: add ref content check for files backend
-- 
2.45.2

