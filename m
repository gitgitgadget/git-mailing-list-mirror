Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8F3B1EFC
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889476; cv=none; b=bbEnNaEoDXTQx5N5sReJ5CdLBoyGxdHtb95YgogE7nQ/bqoztfdD+kfgqeWcksgNUuna4KSvPc7+57E4AISwq8PFPxZrA28WK55rP7yVyd6Xk1B9fyKmLf61BZjX0dkzEWhoScPPxnDJt6OvYiy7GoOS+TnO8HqDZHtUIt9kaO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889476; c=relaxed/simple;
	bh=NulvNIUZ3YXptWJa3nYotIN4mTgBAPyqUPXiMEN9eBA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=RHNBkWOQ0jz+nfe0b5LcfC8P6vZzG7ExuKQ2Ks6kVSLcz7HEH4csm5AJwM4tc9fKI/5ki/h5D+q0G1GuZIP2P4jyjDr+LgFgCgSsGzVm64LVQmjfdPTA8qFFsTxg3iJpCgAE2RUoy90+2t6mJxIDy97F6OcjtXIZg1DJqzHCTSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaN528Uu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaN528Uu"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e5cb052edso28177485a.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889474; x=1783494274; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EQ5K97Jzqtlhpsu4EBF5lwaVRqQq8SBmBHpnjgavQ40=;
        b=VaN528UuejfK6YRbxABw6CzJUf5fYX4G3LFoZ0E6ZWnibf3YzdluaMVkwy61Ztcr7Q
         MwVbChyshHFTAV+ipxJmstCdvBwXpdvKcS0i+xxjCdmIxUCZGaeSs4DStZFtN5dsXmx+
         K7YMXcGqb20fqYMoKCoNOmrzmQTJshYZyWeKdYX7u52qZaLgLb9pFA8+F7MZpFt1tkoh
         +//3Q/XgZL6pyoYHXuM8YIw0qg90liIjlnlBj/tg0Z+mIXVrdsO05zPrVoGiahCRiKp7
         Jiuj12QgOeOY4mkeNiovCdsJxnfy1qKh+NsU3aTZcAN5NOwb12xUziq2dlOuzcZQtwxa
         ja7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889474; x=1783494274;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EQ5K97Jzqtlhpsu4EBF5lwaVRqQq8SBmBHpnjgavQ40=;
        b=PUQkcfXi/vU7H5FQSCuFM5TAM0hyB+yooRC05Ou51RE4AbJRZ0XZoJShbeJbXVAnXF
         1klihy+NewureNC2brez0pWMWfOS9cXtuQAFxFDbZhvcavky8hFEdkephFTRf9GTTBMS
         4xxNUN9DTF68ETDSd40tdG4Jawqm5k+J+v0sr2I09rRsMxsa7xfvDGaZpGx6kwlLAF7n
         17n2PlH2yCc4t2qlKcLk08hUNWGlgdOBHyUnLLx8rDd2OQkl+W/HfLjOAHEMEq03KsZP
         MIsoCoeKK5ANnszwfXHPbX1/FHaI3eQB5CNNyPT2z3+IF0sOxGv6p0ppKyYMdXiKFT/L
         38QQ==
X-Gm-Message-State: AOJu0Yw3aISVvu2XZ66e4ppgtYtIB7l642tfv4cQbqEFw6V+tPDgdykC
	nSsJ5Wrk3QmBuTOOzwPAuwo/Mr+kUrP/BPBGO03gZDi+Sfx7c0USDDkzac4Q6w==
X-Gm-Gg: AfdE7cl6U1Xuw1o6pIiwtjGc9TSB3wJlxM8lky1Sza2kunmy5rVyBr8eGFf4ha+pjHp
	8isdRPES9/ROxGvHv5DH/azjTzuUtOVQVXFHeyU4gAJKj0dHNfyip/QOvF6FL0YNLCNTXiuJ6fQ
	nxqjfrpT1EXyjru4MZJT9CBEGg0DfmPHv4vBHmIAY5ZYj7oi/PSwSEnDkTBreJpP9rLgy72T7ca
	OPxLayvK+hnb3GTCn1/rDHSn6+uLi+H8ndwxRobKvZ7e46qAKclLWk3IqDH96lHI+AW/lt8oSa1
	KBbiRgjyomu+XCiLJrs9PuBQctIW/MurNJwNjFLZooTspfM5h6y0C3v6nNH2bte/9L52Ae5NOPw
	WfL5fBTcgmISMlE17Oimg/ohi/N3vpAV9RqAjIGyxH7QUYMhHXu2JKtL1xgXE5FsHXVXVN5EWGL
	AREcDNBebLjXyb/MTa
X-Received: by 2002:a05:620a:390b:b0:92e:6637:db3 with SMTP id af79cd13be357-92e784cf338mr60444685a.38.1782889473621;
        Wed, 01 Jul 2026 00:04:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6218fa3dsm479570885a.17.2026.07.01.00.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:32 -0700 (PDT)
Message-Id: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:18 +0000
Subject: [PATCH 00/13] coverity: fix leaks and error paths
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

I wanted to whittle down the many issues reported by Coverity in the Git for
Windows project. Turns out: The vast majority of the issues are false
positives. Most of the remaining issues are in core Git proper.

This effort was forced on pause while Coverity was down from May 16
[https://web.archive.org/web/20260516152422/https://scan.coverity.com/] to
June 22
[https://web.archive.org/web/20260622182153/https://scan.coverity.com/]).

Here is a first batch of fixes for those issues.

Johannes Schindelin (13):
  load_one_loose_object_map(): fix resource leak
  loose: avoid closing invalid fd on error path
  download_https_uri_to_file(): do not leak fd upon failure
  run-command: avoid close(-1) in start_command() error paths
  run_diff_files: avoid memory leak
  line-log: avoid redundant copy that leaks in process_ranges
  dir: free allocations on parse-error paths in read_one_dir()
  submodule: fix cwd leak in get_superproject_working_tree()
  worktree: fix resource leaks when branch creation fails
  imap-send: avoid leaking the IMAP upload buffer
  reftable/table: release filter on error path
  fsmonitor: plug token-data leak on early daemon-startup failures
  mingw: make exit_process() own the process handle on all paths

 builtin/fsmonitor--daemon.c |  2 ++
 builtin/worktree.c          |  7 +++++--
 bundle-uri.c                |  2 +-
 compat/mingw.c              |  4 +---
 compat/win32/exit-process.h |  1 +
 diff-lib.c                  |  3 ++-
 dir.c                       |  9 +++++++--
 imap-send.c                 |  1 +
 line-log.c                  |  3 +--
 loose.c                     | 11 ++++++-----
 reftable/table.c            |  4 ++++
 run-command.c               |  6 +++---
 submodule.c                 |  8 ++++++--
 13 files changed, 40 insertions(+), 21 deletions(-)


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2163%2Fdscho%2Fcoverity-fixes-leaks-and-error-paths-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2163/dscho/coverity-fixes-leaks-and-error-paths-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2163
-- 
gitgitgadget
