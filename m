Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A336A376
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257145; cv=none; b=g7/cLUkORLxlvzrkmMjJMZKTwu/iJG4iUNMKXFJ7/yo+iu8scCTpXwyLtkp1R5xgcyIMJuqOztiIbGkAI0nbRGKQoXKm8GYPN5lOnMM5grjzjaf1wpzlENURmwzVIgL6xrHgtVUEi6QOtTuEGHGgIPvFZIIAbgfWth7uiZ2p3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257145; c=relaxed/simple;
	bh=IuVU2NgYqOYDP20DZFqCp12bJCMHaHvjLWtZVd1FGL0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=AKpY3zC9GkUr+Ut6SjbatXL7CmpIxaxX6W02t9ppgc3Re8kCV3hiYES1vbMmb1hIMY5xvX0ddtixEMuGOgEPo7Qjs4mCQlBYdryhSC/1EuvUaHeJeheU8QSx/gvSkSKxy+HK1hTUHvFFPNfdF21jeQ4pZfANGInFyKpggBzu8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gcDwq3mRyzRpKJ;
	Fri, 12 Jun 2026 11:38:51 +0200 (CEST)
Message-ID: <ca428e6e-c840-4ee6-9fcf-39889fc07400@kdbg.org>
Date: Fri, 12 Jun 2026 11:38:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: [GIT PULL] git-gui: repo discovery with rev-parse; pick and gui
 subcommands; silent make -s
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit bb52cdac6254c006e06bf0bb820268dcf024fc22:

  git-gui: grey out comment lines in commit message (2026-03-04 08:04:37 +0100)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to 1b2c2a2edbaa1638becef4c3755b3e0633b9c304:

  Merge branch 'ml/repo-discovery' (2026-06-12 11:05:28 +0200)

----------------------------------------------------------------
Harald Nordgren (1):
      git-gui: silence install recipes under "make -s"

Johannes Sixt (2):
      git-gui: remove unnecessary 'cd $_gitworktree' from do_gitk
      Merge branch 'ml/repo-discovery'

Mark Levedahl (11):
      git-gui: use HEAD as current branch when detached
      git-gui: guard set/unset of GIT_DIR and GIT_WORK_TREE
      git-gui: do not change global vars in choose_repository::pick
      git-gui: use --absolute-git-dir
      git-gui: use rev-parse exclusively to find a repository
      git-gui: use git rev-parse for worktree discovery
      git-gui: simplify [is_bare] to report if a worktree is known
      git-gui: try harder to find worktree from gitdir
      git-gui: allow specifying path '.' to the browser
      git-gui: check browser/blame arguments carefully
      git-gui: add gui and pick as explicit subcommands

 Makefile                  |   6 +-
 git-gui.sh                | 376 ++++++++++++++++++++++++++--------------------
 lib/choose_repository.tcl |  21 +--
 3 files changed, 224 insertions(+), 179 deletions(-)
