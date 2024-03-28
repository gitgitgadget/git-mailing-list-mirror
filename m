Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94787E574
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637633; cv=none; b=iROE1X2h6QxmeK/49rEH0ZRMwLPSEhkvKWdqjnGdSt8j2Uhw6f4bzD/RAYVpL+a/xz/nE5sWcf3+kXAJYc6iRzrxLYV9me7y6Z+UbIery/4FxGw2h81FLQI8/imPYfBWL4zO4Vq1r5UxP6Nkp1np+lc/NwvSrYrwFhddeEgDK/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637633; c=relaxed/simple;
	bh=vroNsreKmfFmtRs+J1PgZa36yxnBzSjfq1oTZQgYeTU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ifOTN8HzsY7TTAdFeHIE6H1XiIv3VY/RINY2wHMrtGRGUQl6okEdLQFWnK7GgR4dEu+hC5CqA6kf6q3Fuycf4MkM2bA+Mvw3TV8CYXDAyMIKm6mRP5+ILLdOHun75/ZsOYhse34hfim4BGqMsO+i8Pn1zPGhGp5rZmNt1ZznOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fuseenergy.com; spf=pass smtp.mailfrom=fuseenergy.com; dkim=pass (2048-bit key) header.d=fuseenergy-com.20230601.gappssmtp.com header.i=@fuseenergy-com.20230601.gappssmtp.com header.b=E8uSq4jr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fuseenergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fuseenergy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fuseenergy-com.20230601.gappssmtp.com header.i=@fuseenergy-com.20230601.gappssmtp.com header.b="E8uSq4jr"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4e1742d3a3so132119166b.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fuseenergy-com.20230601.gappssmtp.com; s=20230601; t=1711637628; x=1712242428; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L5ju9MpD4x4+Zv3jm5mKETm6jkNzNz/+eNg96UQDOvQ=;
        b=E8uSq4jrdDll4huuacbqOuZ9cKMOsBfxCyCW6W+loFbdUJdGC1XyUbgLYKFMsUgBcB
         S0V+E65SjN6uRPgQZmzKDS8q9dTvqgA8ADreAjrdowV7s+n9U+1XbwEn+AmiKwQP3jLt
         XlcbNVQ4FCazh+V0gzO7hoPjDY3C6XYKJj0vs1dWC8YT4vmCbooGoVdl/K3B5Q5iygm9
         4gUiJZ8ZkyGgB+pvzghCKCNbeEMMQPt2QBjiZawvd6hNZL88ErzjhD1e5S6ph5oTzHcA
         9mkfGCifzmTVqQW7qeFy/3Ra9vukBicVn2RNCUpXo3q5ADz/TmCIeqCed++8YCrxQbyn
         UOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711637628; x=1712242428;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5ju9MpD4x4+Zv3jm5mKETm6jkNzNz/+eNg96UQDOvQ=;
        b=Bvny1ArH1Vy85JPN+a2RGctUi9X1lXsUMxBqkPaKsdc5GA9n9aPP2mAor9yKlpUYBK
         eGAEVyRfnX588vylG7NksggfJui0ozOqghYr9oO4pBHLTG7AcrHSdrlPb2zJAT7DgQ1P
         RF+8MbMbVc1tAHzMNVUjPiQpiLjqViLDgPaOdcd2gPdIFPGhwaIL16kKxKGwf5drbsKx
         Vqv6CdTaFFHNsJ57LtXK4otjhI4SLgtqF4ja4WIg6MnLuZUQX5L1W8BxM5V/o7G2/x4G
         kuNkKPwbDLWAWZcgqRrV/3NsTPeImMcLgl2dyJVnt81CFZCgWrzyu578r5kE1Ephaxk4
         8maw==
X-Gm-Message-State: AOJu0YyH++Xy9n1T2YeENryXwvnzqM8Gr7qZttHUWdhDTmOdgUNMOC8u
	ixMpPYRC+7go6QQc0dSqFS1N8wIKA56iRmc/yf818/B9xjLHRf/KaxPiFTXi0ZP9+CHMz5+ZjKB
	XrKnbSOxONdw3bWR6A9PpcdNSe9j/hv8bg/PcmYPPtixJJevKgmZYbhsn
X-Google-Smtp-Source: AGHT+IFhc95Z6v70DAXhI/SQbbhMSqkfagGF8dfwJfmrEtNKLLPrl2ggA3O1EPnNP9UV7uUCs6LoUHQf24Xr3KObLZ0=
X-Received: by 2002:a17:906:57c7:b0:a4e:1508:9e8b with SMTP id
 u7-20020a17090657c700b00a4e15089e8bmr1906112ejr.5.1711637628496; Thu, 28 Mar
 2024 07:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tamir Duberstein <tamird@fuseenergy.com>
Date: Thu, 28 Mar 2024 14:53:37 +0000
Message-ID: <CAEYvaskGHYrQgke=gf1sXYhrwbd+SeTpcjGF0fpxK3hQbyPFKg@mail.gmail.com>
Subject: bug report: spurious "cannot delete branch '%s' used by worktree"
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pasting the output of `git bugreport`:

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I created a branch, pushed to a remote, and then the remote deleted the branch.
Then I tried to delete the local branch.

What did you expect to happen? (Expected behavior)

The branch to be deleted.

What happened instead? (Actual behavior)

% git branch -d cleanup
error: cannot delete branch 'cleanup' used by worktree at '<my source dir>'
% git worktree list
<my source dir>  dc46f6d5e [main]
% git branch
  cleanup
* main

What's different between what you expected and what actually happened?

Git reports the branch is being used by a worktree, but prints the current
repository's directory, where a different branch is clearly checked out.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.44.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.4.0 Darwin Kernel Version 23.4.0: Fri Mar 15 00:12:25
PDT 2024; root:xnu-10063.101.17~1/RELEASE_ARM64_T6030 arm64
compiler info: clang: 15.0.0 (clang-1500.1.0.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
