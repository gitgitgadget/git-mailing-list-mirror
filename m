Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572683C5848
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791492506; cv=none; b=OR9uVYzT3NrWYsA37cMLyhyLrMuNOI0jymS6nKCq585vzsTkofcr3dnqTF91wG+vjHEScpUa1kQGNnuNgycUltA8HBEZjKDfVWc6yOniKadelNAuJGDj6yeG3v1IAGjNS8IWR+2XaPU9SYoKB24Pvhag6gBZu4fuD3zcVXNfvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791492506; c=relaxed/simple;
	bh=+7qqxGtfbSDf0PFGX8dAVqMmfG4RjiykPMMRALXHSfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKwX5HffSrZ9fO1EytgC8mKShf7IQsE5iJBQf3q/a3Uyt2rqrrDa1dczoucGfSmkcoVXwNK9YTQwILhwcPm5FtLD4j1uY1ZUNRdK/hnEOf3ow0341/m6J0+hGTmpdS/OUJsVk18rKJHCmZMuszPNF981wLjWiTqD0Lpxv1g6WpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOQQbzHq; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOQQbzHq"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3530a44737cso112705eec.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791492504; x=1792097304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mkpd+eig3g6w+fp9atNcrPPl9NQe/hZAPhlrlCfrjMs=;
        b=eOQQbzHqcaJvVe+eISPfEIpsTV/lnHKO9cnI0OSCZuM2o3OXcnf1HFNnBc2EMmbf5E
         QSYfQF2f4cVXWh+8NzFGrFcPSGunFtVM+k77nTp0ZAwYbhf8p0TA36/l+5vb6kKjxchx
         W4tHB0kDo5w3oY5AUpe3tW3Fh6Otpvh92uIZuhYOzg2tQ0M7pw6ATfz+yRHiK7wWaBcx
         QDrMOmEtA6kjBuTarHe7yUqy7hnD6dt36f3g8spRxMRDMmTQtNz4S8+i6hY4IQgFDsTn
         U11ujNNZS3K9wTvZ/D2oWAHZ4ZgDChaGekiF3RcFWRDOJTU+u9tXgQtp1cpssZHB/YXQ
         VvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791492504; x=1792097304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mkpd+eig3g6w+fp9atNcrPPl9NQe/hZAPhlrlCfrjMs=;
        b=ThA9N39DL59eC5oHSgZr0dhZUUvIyUzrpQUa7z/nQOHPz/29VhDUwDLHdhqQuXsTGJ
         SvTk0mE+HPET0p6tcHUEt8DYEKyLAy2NYpr4tgmWA07qFGHNd6WbrCw907jP62ZftYz9
         q7XcMEmK1mOpZgxoNfH8jcgBxsPfS6b95SZz3v5Cs/B54p3uccahDnNPaDntY9bz6V3l
         8Afno9167/encQgMSWpt34YWuyPF9Gc7+MGqxhcOI4zfpONSVwPN6RlP4BD+ghOPc3hS
         g9gKRLmm8OyklrbI0Nn6APM73sfDEji0SzgA7NjF4WpJJdHBsMcFA47JCb1k5C6W4LyW
         gDgg==
X-Gm-Message-State: AFq9FYK7JUcCUVpaVTQ18iDCk/lyP18AubmFaaiIvYHXy+CUsbFQPG1/
	zXVgh+cR90ibk2teJbKQ0RMWvV7He5AC3eVJ+w5h0KnR7kX2HANexex418RESg==
X-Gm-Gg: AYBFou2uE5XGbjhzzELprU6NgSdbKZC5Oeb5YOMO8nVzIx12TscwDCBdyFl+1OEEiay
	MlugXd5zagus9JGw81H8tk3wJacB+uqw5erFF2Q87jc44NKzF7JOu0WT6byUOecIM2jdiGBtjzt
	7z/v0NMXD1cV2v1uadlkeIzBdcUxe7aLiiIkLaxDxShkB9PYeWM/0oN9FQSCbGb258PHC7hjIri
	WSUmcRFAsgeBObH1QddqADTw1PUpreAOxgbDNGT9On1/PLSu33N1ZgMN5L7IEgXH3HM1614br0J
	Cle/h2cUTPR0ikXUpnq0p5YcJiL+xz98B2WsZRc1TCq2HfIhX8TaUDhApUC9Ar8ma1tWLTzPIOB
	1E4xDl2wV8skO0FhSZGAGaD0DUGJxnBKU8B1Yy74t7NPQoa1eKSnm/w4vtO6IgioODFUZbr5pgJ
	v1E3Uxz3R/O6VKHVqgF76+FCbeahZr6stQ+y9DyWbZlmDYetJgRAQONbJ6Aa1gSAzb6fyX08Z1i
	raeqJy06JwbTmnDjaf5n6LoW4VGV4FyJJ/iC0R9rjaprK2I
X-Received: by 2002:a05:7300:c01b:20b0:351:e21d:357d with SMTP id 5a478bee46e88-3537dfdd089mr72522eec.1.1791492504063;
        Thu, 08 Oct 2026 13:48:24 -0700 (PDT)
Received: from WF-A7VVAKE ([2605:a601:9a29:ec00:9c8c:3311:1812:c51c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm433930eec.28.2026.10.08.13.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:48:23 -0700 (PDT)
From: Curtis Allen Smith <curtis.allen.smith@gmail.com>
To: git@vger.kernel.org
Cc: Curtis Allen Smith <curtis.allen.smith@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 0/2] status: agree with diff and add when conversion is active
Date: Thu,  8 Oct 2026 14:45:02 -0600
Message-ID: <20261008204603.1988-1-curtis.allen.smith@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git status", "git diff" and "git add" can disagree about whether a
file has been modified.  Under

	* text eol=lf

a tool that rewrites an otherwise unchanged file with CRLF endings
makes "git status" report it as modified, while "git diff" shows
nothing and "git add" stages nothing: the two commands that actually
run the clean filter both conclude that the contents did not change.
That contradiction, rather than the line endings as such, is what
this series is about.

The cause is the size comparison in ie_match_stat().  ie_modified()
takes a difference between the file's size and the size recorded in
the index as proof of a content change and returns without reading
the file.  That was sound in 2005, when the working tree file and the
blob were the same bytes.  Conversion made it unsound -- the whole
point of a clean filter is that the two representations differ in
their bytes and agree on their content -- and the shortcut was never
revisited.  The mtime branch of the very same function already reads
the file and applies the conversion before deciding, so Git pays for
the conversion-aware check in one branch and refuses to in the other.

Patch 1 makes the size branch behave like the mtime branch whenever
the path is subject to conversion.  Paths with no conversion take the
existing early return untouched.  It also stops ce_compare_data()
hashing a file whose converted length already differs from the size
of its blob, since equal contents must have equal length; that is
where most of the cost of the new check would otherwise go, and it
helps the pre-existing mtime path as well.  When the end-of-line
conversion is the only one that applies, that length comes from a
scan for CR, and the file is not converted either.

Patch 2 adds core.convertAwareStatus for people who would rather keep
the old shortcut, either everywhere (false) or only for paths with an
expensive clean filter such as Git LFS (no-filter).  I defaulted it to
on, including filters: the measurements below say reading is not what
costs, and the 2005 performance argument should not be re-applied in
2026 without evidence.  Being ordinary configuration it also works per
command, as "git -c core.convertAwareStatus=no-filter status".

Note that there is no way to opt out of the size comparison today --
core.checkStat=minimal drops ctime, uid/gid and inode but still
compares the size -- which is why patch 2 adds a variable instead of
extending an existing one.

Numbers
-------

Linux (WSL2, ext4) on an i9-14900K, warm page cache, fastest of 5
runs, "status -uno" to separate the refresh from untracked scanning.
One binary for both columns with core.convertAwareStatus flipped;
"false" is the pre-series code path.

	10000 files x 2.6 KB, "* text=auto eol=lf"
	                                   false      true
	  clean tree                         4 ms      4 ms
	  10000 genuinely modified          19 ms     49 ms
	  10000 CRLF-rewritten, 1st run     20 ms    148 ms
	  the same, steady state            20 ms      6 ms

	200 files x 1 MB, same attributes
	                                   false      true
	  clean tree                         2 ms      2 ms
	  200 genuinely modified             2 ms     26 ms
	  200 CRLF-rewritten, 1st run        2 ms    611 ms
	  the same, steady state             2 ms      3 ms

	10000 files x 2.6 KB, no conversion configured
	  clean tree                         4 ms      4 ms
	  10000 genuinely modified          19 ms     20 ms

A clean tree and a repository without conversion are unaffected.  What
is paid for is stat-dirty converted paths.  A file that was really
edited is read and scanned for CR, but neither converted nor hashed,
because its length already rules out a match.  Without that the
"genuinely modified" rows read 142 ms and 517 ms rather than 49 ms and
26 ms.  Of the 214 MB in the second corpus, reading costs 6 ms from
page cache, the conversion about 180 ms, and SHA-1 about 280 ms.

The last row of the first block is the case the series exists for: the
patched build settles at 6 ms where the unpatched one pays 20 ms on
every invocation and still reports the files as modified, because it
never refreshes their recorded sizes.  The 1st-run rows are the
one-time cost of discovering that.  Their lengths match, so they are
converted and hashed in full.

This was reported against Git for Windows [1], where Torsten suggested
bringing it to the list.  It is not Windows-specific; anything with a
clean filter runs into it, and Git LFS users on Linux see the same
contradiction.

Built with gcc 15.2 on top of 6de20f6; each commit builds and passes
on its own.  t0020 (with the new tests), t0021, t0026, t0027, t1300,
t2106, t2200, t3700, t7508 and t0008 pass.

[1] https://github.com/git-for-windows/git/issues/6410

Curtis Allen Smith (2):
  read-cache: do not trust a size change when conversion is active
  core: add core.convertAwareStatus to opt out of the content check

 Documentation/config/core.adoc |  22 +++++
 environment.c                  |  14 ++++
 environment.h                  |   7 ++
 read-cache.c                   | 141 ++++++++++++++++++++++++++++++++-
 t/t0020-crlf.sh                |  92 +++++++++++++++++++++
 5 files changed, 273 insertions(+), 3 deletions(-)

-- 
2.53.0

