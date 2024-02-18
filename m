Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5CFCA6B
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708241618; cv=none; b=Z66kiLdTm/2LuBF2DmJi4Zh8VexhmdA10XaScHgDiz4i1hidcmCRH6gaNGsUbLx49o6QK686B6OoGoPoEHwwW+Mlref2iQTPxkj67tOOiZbFdX3LvTckZPBnM1Tmax5qv5D+kTh/o1sbmaCaRfuGpFuVhVl8aZPVVNmMAKyKwsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708241618; c=relaxed/simple;
	bh=GGKJM45aHjxiaKTJ+TAeExEflCIPElTkQ1Dh8adruFw=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VbL6lYIAwSJISPXUWMEHUV12BRr7c0iENL+3n/Dv/5959MwAsvij16rj5w7e/9Lzk4Ba2ZkAdChy1cp0hLT8u9hiLwoMCCfTaSwrNc6nOmCCTbJI8Th6Fgf1lOSJ0IsJVnqTcaxZhR8uY1OpslyKJ8crAWjYeFArHzY3l+3lFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNSappv5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNSappv5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4125edd1433so5284275e9.3
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708241614; x=1708846414; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt5NH7Sr8t1H4pQG1YWH1gxDrmplpRF4qPZTpWifI4g=;
        b=hNSappv5p4iAGqHdCJeoVEy79p/hmInKbNUXZvi6hzUnGxtX+nPsoV3jexu5jOHXWR
         tx5Glu7Mq01NSdm3UzYHrmDWuOkHJPeDbkIG/UDagd1oAj3X11Hs6iiDmkrheWqv9V/r
         50CooOyINPucitmB0GeYjqFkCJHyEjrZbCto1qtdEKMeA+1fVV1A79JsIWkc65J9elCM
         vNrFp+iPY5oZbUmpuqdUgfuEkg9/D+Xks4n2t7Z4GNhczCgNfUD2/ftSUBoNPfjbg6qX
         g+MNmWjW3ox66qOfEltDxRt/ZWSqiEVep9gKo0s5TXkGQUjNn0sP+mvbRKfrFHG4wVjM
         2h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708241614; x=1708846414;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wt5NH7Sr8t1H4pQG1YWH1gxDrmplpRF4qPZTpWifI4g=;
        b=uapOXkOBQFdrPktQ9NtUCNQ9Lodmzv1uf/4v/acT1LCwsAL/F+0W88gPtd5q7QkqGJ
         GySQHOwsTuIW8kj7r4XqE2P75pBitOzDDrN/ZGLY/5wsHDWuZaf7j8ir17ZC7xgn6nDz
         TyFsJMA5EqsVmDGZ9fsju3dUYUNwZKuWAJE7fZygFzKS3FBR23ZbhwwwR6bad5L4lMHe
         UV9apnsWTQBnsLKUn+Ts2eF4icHH8CdzHcPss4lx37CzKkmatMrdfPcnspKVeCHAYQRZ
         GonFRFtrMcTuDnhrFJyIsLjj22J5mj+jkL2iYLVd67UiKo+VTNjmpexNOPoGcklFsmt/
         GPAQ==
X-Gm-Message-State: AOJu0YxE/pRkAKSyM0CXRYvFzH6oBI/nfTd0LRd7Xby9AckdTWuvPUK9
	9LH5K6Da+zWXUnyUerjxmdCZan47ku3Fgo8F6xpAm3QM7hVHzaFBkg3LyqY1
X-Google-Smtp-Source: AGHT+IEFmr6bTC5S56NWlCzhlWk5Rfw/XQ7vLC/ui4XNMA6rlL854jjmlFyDLeVcVyxLQ5LUwqi+oA==
X-Received: by 2002:a7b:c4d7:0:b0:411:3632:8184 with SMTP id g23-20020a7bc4d7000000b0041136328184mr5959342wmk.40.1708241613929;
        Sat, 17 Feb 2024 23:33:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id co22-20020a0560000a1600b0033d2848046asm4115511wrb.95.2024.02.17.23.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:33:33 -0800 (PST)
Message-ID: <pull.1666.git.git.1708241612.gitgitgadget@gmail.com>
From: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Feb 2024 07:33:27 +0000
Subject: [PATCH 0/5] promise: introduce promises to track success or error
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Emily Shaffer <nasamuffin@google.com>,
    Philip Peterson <philip.c.peterson@gmail.com>

Hello all, this is my first patchset so thank you for being patient with me
as I learn the process and conventions of your very fine project. These
patches are intended as part of the Libification effort, to show how we
could use a Promise structure to help return values from functions.


Problems
========

We seek to make libification easier by establishing a pattern for tracking
whether a function errored in a rich way. Currently, any given function
could immediately die(), or use error() to print directly to the console,
bypassing any relevant verbosity checks. The use of die() currently makes
use of Git as a library inconvenient since it is not graceful.

Additionally, returning using return error(...) (as is commonly done) always
just returns a generic error value, -1, which provides little information.


Approach
========

I solve this problem by splitting the single return value into two return
values: error, and message. However, managing two output variables can
require some coordination, and this coordination can be abstracted away by
use of an existing pattern named Promise.


Promise Concept
===============

A promise is a contract representing "some task" that will eventually
complete. Initially a promise is considered in a pending state. When it
completes, one of two codepaths will eventually be entered: reject, or
resolve. Once resolved or rejected, the promise enters a different state
representing the result. Reject or resolve may only be called once on a
given promise.

Until now, everything I described up to this point is consistent with other
implementations, such as the ECMAScript standard for promises. However, this
implementation departs from the complexity of those promises. In this
implementation, promises are simple and canNOT be chained using .then(...)
and do NOT have any notion of automatic bubbling (via re-entering the
pending state).


Sample output and reproduction
==============================

During an error, we can have richer feedback as to what caused the problem.

% git apply garbage.patch
error: 
    could not find header
caused by:
    patch fragment without header at line 1: @@ -2 +2 @@


To reproduce this output, you can use the following patch (garbage.patch):

@@ -2 +2 @@



Goals
=====

I would love to get feedback on this approach. This patchset is kept small,
so as to serve as a minimal proof of concept. It is intended to abstract to
asynchronous use-cases even though this is only a synchronous one.
Eventually, any top-level function, such as apply_all_patches(...) would
return its output via a promise to make the library interface as clean as
possible, but this patchset does not accomplish this goal. Hopefully it can
provide a direction to go in to achieve that.


Diversion
=========

While building this patchset, I noted a bug that may not have a concrete
repro case in the master branch. The bug is that when invoking git am, it
can call out to git apply, passing many flags but interestingly not the
--quiet flag. I included a fix for this issue in the patchset.


Potential Issue
===============

There is one difficulty with this approach, which is the high level of
repetition in the code required. Tracking which promise is which is its own
source of complexity and may make mistakes more prone to happen. If anyone
has suggestions for how to make the code cleaner, I would love to hear.

Thank you, Philip

Philip Peterson (5):
  promise: add promise pattern to track success/error from operations
  apply: use new promise structures in git-apply logic as a proving
    ground
  apply: update t4012 test suite
  apply: pass through quiet flag to fix t4150
  am: update test t4254 by adding the new error text

 Makefile               |   1 +
 apply.c                | 133 +++++++++++++++++++++++++++--------------
 apply.h                |   9 ++-
 builtin/am.c           |   5 ++
 promise.c              |  89 +++++++++++++++++++++++++++
 promise.h              |  71 ++++++++++++++++++++++
 range-diff.c           |  14 +++--
 t/t4012-diff-binary.sh |   4 +-
 t/t4254-am-corrupt.sh  |   9 ++-
 9 files changed, 279 insertions(+), 56 deletions(-)
 create mode 100644 promise.c
 create mode 100644 promise.h


base-commit: 2996f11c1d11ab68823f0939b6469dedc2b9ab90
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1666%2Fphilip-peterson%2Fpeterson%2Femail-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1666/philip-peterson/peterson/email-v1
Pull-Request: https://github.com/git/git/pull/1666
-- 
gitgitgadget
