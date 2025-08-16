Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E62238141
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755380259; cv=pass; b=WiXWGZGV57yjI48fh6yqagbArO9G6IXW5YpqGZrvJrr9t/C4jcRLbVPwO0qPDwtQVSgTVP2suuv69mZ34Orsi/5sLzqxq4rjE4XkSkN9K08Ps2YubFMmfgHXKZMH9cvMU2JhxD7BZS07diAYmlL+/NVzVbFNObSgpHddPGXF4jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755380259; c=relaxed/simple;
	bh=6x1X3vTgUGIob1B7RbJAmvR3JiHv14O7DLJlP5KE1Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQwoiqHx4a7LvHTWcP6xvCryCqwgoUUaHdFJMoKtCionR7Sg1xqjbqiJM8Nwmy7tdQkoXenXl31eTgo15FNwRNq4ykYDc+50W/vjW3AfpsQRTfR4Q/FGK4DHty0hUBh980x6rOYR/w8RNmq0J7g05Yiy52P6Ip77qBGttGjaHi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=IJoa7r+B; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="IJoa7r+B"
ARC-Seal: i=1; a=rsa-sha256; t=1755380233; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e13n/NI/A7EBP84HOYr1nJYNl5Pk6kT2+BXgaETXYuTDZzzTukuqXfYvmpyB+kUyQYLVAtHWCI6UT92jhe06F328FsFNzHpKP0mY8sI1BbDOjVJSMknB6q9vQr2P4mmDbzTYe/fa7ZAzRY3n2xKzSzsiSEtyLTE1ZRHLXqljYuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755380233; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0FCiQB9FrzQAk/tY+CGrB0bp9/9yFnX1TjiuZRPJQ5I=; 
	b=YM6MSu9y+p/nBLy86RN3hJAqt+cNu+ACLeylNj4d6NtqcSsOcyuChhXmDvvNmW8Tlfppsm8ITGbmZ9rZMKRXM9wXI52AT1APCzs2wIs1dhe49CW7mw6ldENaYJePCCxeI0oubbhAIp+0KsL2lotCtqYetgnKN43sAYB+pKXkC5A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755380233;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0FCiQB9FrzQAk/tY+CGrB0bp9/9yFnX1TjiuZRPJQ5I=;
	b=IJoa7r+BKiuRdL+cwnG5+mWsRkFiAONBkYO4TNbiAjcMj686vBL+RbkWQXEWnCY4
	u4HuNMiE3mEF6eLLyU4qjGG5k+pCG2MPmiEZyqP61/egj4UZ9a13cvshEIByd86oCH6
	5MdXPkszfW/H+OOeYFiLaJwp31ffGUJ+q0BcfAZU=
Received: by mx.zohomail.com with SMTPS id 1755380230983865.3636189735729;
	Sat, 16 Aug 2025 14:37:10 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 0/9] Encode submodule gitdir names to avoid conflicts
Date: Sun, 17 Aug 2025 00:36:33 +0300
Message-ID: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.50.1.679.gbf363a8fbb.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello,

This is a continuation of work done back in 2018 [1], so a big thank you to
everyone who participated in the initial thread, especially Brandon on whose
code this is partially based upon. Hope you are still around and doing well. :)

It's mostly a rewrite from scratch addressig open feedback. I decided to
iterate upen Brandon's url-encoding design instead of pursuing alternatives
like a custom encoding, name hashing or round-trip encoding/decoding using
an in-memory git mapping (we'd still have to encode/hash the paths to avoid
colflicts so IIUC this last one is more complicated for little gain).

I tried to organize and explain the commits in a logical way which is also
easy to review, keeping the encoding parts, new tests, code moving around
and path update churn as clearly separated as possible.

This is based on master and I've merged and succesfully run all tests in
both the next and seen branches.

P.S. I plan to give a short talk at the mini-summit in 2 weesks based on this
series and some other patches I wish to propose on the ML, so if any of you
are attending and wish to connect in person, see you there!

Link: https://lore.kernel.org/git/20180807230637.247200-1-bmwill@google.com/ [1]

Adrian Ratiu (9):
  submodule--helper: use submodule_name_to_gitdir in add_submodule
  submodule: create new gitdirs under submodules path
  submodule: add gitdir path config override
  t: submodules: add basic mixed gitdir path tests
  strbuf: bring back is_rfc3986_unreserved
  submodule: encode gitdir paths to avoid conflicts
  submodule: remove validate_submodule_git_dir()
  t: move nested gitdir tests to proper location
  t: add gitdir encoding tests

 Documentation/fetch-options.adoc           |   2 +-
 Documentation/git-fetch.adoc               |   2 +-
 Documentation/git-submodule.adoc           |   2 +-
 Documentation/gitsubmodules.adoc           |   8 +-
 builtin/credential-store.c                 |   6 -
 builtin/submodule--helper.c                |  49 +++--
 setup.c                                    |   2 +-
 strbuf.c                                   |   6 +
 strbuf.h                                   |   2 +
 submodule.c                                | 158 +++++++---------
 submodule.h                                |   5 -
 t/lib-submodule-update.sh                  |  50 ++---
 t/lib-verify-submodule-gitdir-path.sh      |  15 ++
 t/meson.build                              |   1 +
 t/t0035-safe-bare-repository.sh            |   4 +-
 t/t1600-index.sh                           |   4 +-
 t/t2405-worktree-submodule.sh              |   8 +-
 t/t2501-cwd-empty.sh                       |   2 +-
 t/t3600-rm.sh                              |   8 +-
 t/t5526-fetch-submodules.sh                |   2 +-
 t/t5619-clone-local-ambiguous-transport.sh |   4 +-
 t/t6120-describe.sh                        |   4 +-
 t/t7001-mv.sh                              |   4 +-
 t/t7400-submodule-basic.sh                 |  33 +++-
 t/t7406-submodule-update.sh                |  14 +-
 t/t7407-submodule-foreach.sh               |   6 +-
 t/t7408-submodule-reference.sh             |  22 +--
 t/t7412-submodule-absorbgitdirs.sh         |  22 +--
 t/t7423-submodule-symlinks.sh              |   8 +-
 t/t7425-submodule-mixed-gitdir-paths.sh    | 207 +++++++++++++++++++++
 t/t7450-bad-git-dotfiles.sh                |  73 +-------
 t/t7527-builtin-fsmonitor.sh               |   4 +-
 32 files changed, 451 insertions(+), 286 deletions(-)
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh
 create mode 100755 t/t7425-submodule-mixed-gitdir-paths.sh

-- 
2.50.1.679.gbf363a8fbb.dirty

