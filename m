Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6543750B5
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570546; cv=none; b=QHYFk8XyCnw8XeMU71cjN3jYqXywGeyKkhynRQQWAYRancWSqlmJqfL8ra6wHKbwEn2kyIAxyHxw/IRuORfXcN7nL1Xq1BC21wvBxL2TALzSv8SwD2kmLL0fRwIxyYHMeV+qKvuUAg6XVFa7LUsCLJBmnt49Vbihhl6dALiMFC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570546; c=relaxed/simple;
	bh=lcpW/M9QqK0FZgUBpgMtQklPNeiz2L40uac5KdBdYKs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NdNDBjaXFMKgPLymdap6yT5uvAREmzVYxlpgmKRL6AOg5OKQJi2rh69g1Um7XDuCGl8/NdPiMXtbIgIDEyuq53fXmdpt6PtGUcayi0OySaQsGQBW/yKOMEU0iHF5UmlVehOEXRjKmI+MfsLuPQPgjNZ5dYnAwXrPe7by1VEUXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IT/HIc4/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT/HIc4/"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439bc1a201fso155143f8f.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 12:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772570544; x=1773175344; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jB0NeMY1B8R0IDkgccf3YdMvvifX50R6O+rwVVhfzhw=;
        b=IT/HIc4/4zglZDa98sufKuLeMWv72v8ipD0hGBABqpHHTxqchr+QzAwyrjUgjwDgSX
         8Z/S+qmk1ny2oZtuPi5KOj7nnXU6AloeBtyaMGzeysoBSjhmwzUKvgvXlFSSv/fvmVGS
         jJUzH5w4MDYHE/QiLKsBKjUSWYC2UyRris7K1/NcqBRw4nh5a1ZSKNsYsNCHBOyWsMM8
         Y4nHfFi30Ot3WS6MalSzCPo7rXp4oPLAX70QDWIzjcdGI175AzYrKrdGSj/aNvZff+CA
         PH/o8BmmprNRTy+1X5197QgddAVUhuGe4um7N4SdnizJ6MqXg8b8g6ySa8S3qsfa37Be
         TiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772570544; x=1773175344;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jB0NeMY1B8R0IDkgccf3YdMvvifX50R6O+rwVVhfzhw=;
        b=Al31IYnKLIm/Kr1YciGFfL1R27s4SbtDVPq+s9VeANbGZJSigZwWzfyT23xqyKw7Xz
         FTsmG0sZO5USkEiGsAFsTm3Njuz6OVZc6ZwmQC5nKA5GAXkaG18JHFamy9KBktJU3lAm
         EsP4WRQ3ZrOT2Bn0cLBZThl9TLLq9nCe8zZbSNOJ+Jhw4nHtr5oCf2pe7XbAPgc06brJ
         LDLaATrUzKDFelDCzUUjhatonIJaX8VrLVsYT0MBGgisAyQ2jYanN5vdsAzcaL5tvSXb
         97FFSE48zT+x1Oixqu9sBZ6Uu2NBo3E693515X95BMdczXqbo3eNNECqOAPmzhSUsIo3
         mCmQ==
X-Gm-Message-State: AOJu0YxR5oMogg0czciDlqIkTCvYgBDxJWDHnEPt+D9Np8cMJsZWqHWU
	ymghn45M2j2mc8DiSANbWf4oaWBLe8oe5Ikgcv6/gSiy4FZl7nfMgTgQl/ZoZnWq5k0=
X-Gm-Gg: ATEYQzzQ3kXD0o5GHewokj3bjGK+MXj8M0lsZuGHNDabEPdN/YmnMccMJzNFjxex3BN
	Lg+H7dGqxeVA8QzhEXakfMsbWrdUKjxLf8O1JGXvipK0zLOMKzJ9qMK+v4JKe57Go9xbSPLTfHw
	TIHD+oS5FmduVO3S1MA96Yr0t4/SYTrZDmZLnuMbLRju4wrW+HHUrbxbimvahwnaJCHyiyzhHsu
	PQ7tyJjyEg791dtHMaw4Y11jI0dHCFQJcQBPzzdtTEnyYdyPaU/uDqtDKS0/J0eqIewttpsT1o3
	DzRi512Zwr1zE6PPueHDHfbH6kFgEqhPs3k2GstOYENs5SQS1y5APKCVVmesbjPULSkqfV50OTc
	O/3zw+TUNZmUk1ceXQeqY9M8bMCIYVpo6MYnOq4ToGvA12adYLmtTYdXh/UtKINCOVseBp8RG3Z
	FIXkxzpZ81Dyj+cAcXvrXofG2APnQ=
X-Received: by 2002:a05:600c:8b56:b0:477:9fa8:bc99 with SMTP id 5b1f17b1804b1-483c9bba8cfmr166819415e9.4.1772570543361;
        Tue, 03 Mar 2026 12:42:23 -0800 (PST)
Received: from desktop ([194.127.199.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485178845b8sm13031875e9.1.2026.03.03.12.42.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:42:22 -0800 (PST)
Date: Tue, 3 Mar 2026 20:42:20 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Subject: Crash on git log with -L and -G on file rename
Message-ID: <aac-QdjY1ohAqgw_@desktop>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I hit a crash (assertion error) running `git log` with both `-L` and `-G` under
certain conditions. I've created script to reproduce the behaviour in a fresh
git repo:

    #!/usr/bin/env bash

    set -o errexit

    git init .
    # Note: example is .rs file, but it should work with anything that -L understands
    echo "fn my_func() {}" > file.rs
    # 1. file named 'file.rs'
    git add file.rs
    git commit --message 'Add the file'

    # 2. separate branch with the file renamed
    git checkout -b some-branch
    git mv file.rs new_file.rs
    git commit --message 'Move the file'

    git checkout -
    git commit --allow-empty --message 'Some extra commit so we get a merge commit'
    # 3. merge: one parent has file.rs, the other has new_file.rs
    git merge --no-edit some-branch

    # 4. post merge, move the file back
    git mv new_file.rs file.rs
    git commit --message 'Move the file back'

    # 5. things go BOOM
    git log -L:my_func:file.rs -G '.'

I'm not sure if _every_ step in that script is necessary, but it's the simplest
setup I could figure out to trigger the crash. Running that script I hit the
error:

    git: line-log.c:1056: process_diff_filepair: Assertion `pair->two->oid_valid' failed.
    Aborted                    (core dumped) git log -L:my_func:file.rs -G '.'

The backtrace shows that the failed assertion occurs under
`process_ranges_merge_commit`, so maybe there's an issue with the file being
renamed on both sides of the merge?

The crash requires both flags to trigger, remove either and it will run fine.

I've tested the above on the `git` from my system package manager on Arch
Linux: git version 2.53.0, and one built from source at
2cc71917514657b93014134350864f4849edfc83 (the version of 'master' checked out
on my machine at the time). I don't think reproduction relies on any specific
config since I've had it trigger with both `GIT_CONFIG_GLOBAL` and
`GIT_CONFIG_SYSTEM` set to `/dev/null`

Just for reference, I originally triggered the bug in the `rustfmt` repo[1]
(checked-out at cebab3e99259be82ff069e5ae89e91855d79e534) running:

    git log -G offset_left -L:format_trait:src/items.rs

Link: github.com/rust-lang/rustfmt [1]
