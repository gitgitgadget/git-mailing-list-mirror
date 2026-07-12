Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D654723
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783855063; cv=none; b=YYwq36BdAlDJ9LARCARjolFDz1/+yyc+HLgcbTapbZilR/A+P1gFhFykJgtKCiWJmTN0P212SITSxlWMZvQscZRQq963iehGAGKbae/cJLKvzn5u+5oVDuFBO6Qc3XNQO2YDYHJR/CaWTynwMXU9IH7ehYF0Itsfc6vroJKx8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783855063; c=relaxed/simple;
	bh=/JnL04Rhz5NjN4Zgg4D1O0wtD+5+GFZEmQL9/8i+XHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NO3BPVSw5aX1lg7to6/pHMJLfYUe3lzCkiNFEq+mQ+Lz90d+hmxaHGsCVzNMBjRTq+uanwUPYiCRy8bUFqNNwOJG6SMBh3WoxiL2xAAlZHdzVI09GLP61eubxmEdLb4HZSrnFB9aFG+s6vkVv/IyhAOB69zL+y5cBSG/2vH68T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=g3s4UVfb; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=IB6djPDT; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="g3s4UVfb";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="IB6djPDT"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=g3s4UVfb7UPTn15kO9iilBYTIersAgdrpBVEpVP3iQ8z9mC0wRODZ1s6vGld83FsBFuuTRd1/ik6rM0T98pHV4mxuL85pLGRsci7M+pT01CCjZIJCQ9jXW4bOTloT6hoh7Wd+2wtllnwxjes9XF94MR/8US7/cId3vQwnSzTkeCX+ApvdrCsQITglkeklcF5SRiyf/520L1KreaKwH1JBlaSj45lFsNhDPL4nokaThCYoe3iP2u4vyDBZnowiPuloaHoLJP9MGjOZY9TpjomhI9oq9K6MnnvO5yVt978cP08+RPIFX3TthOuOW3bHhcX99FdR5UI4NOOAWHKjU0+IQ==; s=purelymail1; d=malon.dev; v=1; bh=/JnL04Rhz5NjN4Zgg4D1O0wtD+5+GFZEmQL9/8i+XHs=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=IB6djPDT9P4WUUprwEbQJCKtuzrYlRBRdcjD9VYfMiPx0oGgEeiYUqz30bTW7Emvu7pKmqlJ4RS9CYDJUFpvqZktshLrNoMNFuoy1x9PJFChrMcnILnARCTtsreXd9UfwJe6ag6assNRLupUqMtQniq/WgS6gQPKaS1xghC4O8Z0m1r6Zh78gV1ytZg6gqz4MYwm+Qb8lbTiV3ujCYLnkxMuaGJ0X2t8Svp3Kxcg4CU/a3wLYdRXpcY/C1qiwkDreR9NZIoDxV9A0z/XpMhN+Qg2CneB+y1Is5HCi/1qp0TRK9+h7zZb/pLp7MUe/7SPZkyi8qukUsrnrjdGfDF9Gw==; s=purelymail1; d=purelymail.com; v=1; bh=/JnL04Rhz5NjN4Zgg4D1O0wtD+5+GFZEmQL9/8i+XHs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -46196840;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 12 Jul 2026 11:17:39 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v10 0/9] migrate more variables into repo_config_values
Date: Sun, 12 Jul 2026 19:17:24 +0800
Message-ID: <20260712111734.1073514-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709161145.13349-1-cat@malon.dev>
References: <20260709161145.13349-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi everyone,

This patch series continues the ongoing libification effort by migrating
a batch of global configuration variables into struct repo_config_values.

What does this series do:

infrastructure & strings (commits 1-6):
Introduce 'repo_config_values_clear()' to manage the lifecycle
of heap-allocated configuration strings. This infrastructure is utilized
to migrate string variables, including 'excludes_file', 'apply' whitespace
configs, and external programs including 'editor', 'pager', 'askpass'.

enums (commits 7-9):
Migrate enumerations 'push_default', 'autorebase', and
'object_creation_mode'. Care was taken to make these types available
to the configuration structure without triggering circular header
dependencies.

RFC:

Commit 3~5. Is it really necessary to migrate _program variables?
https://lore.kernel.org/git/8e657184-ee0b-453a-9f2d-a98080d3582e@gmail.com/

Commit 6~9. Previous related discussions on 'git_branch_track'.
https://lore.kernel.org/git/CAD=3Df0L-mPX+KECUjXk-WBzEbTP7wCa8sB56GySQT0yh9=
mfUOWw@mail.gmail.com/

Note:

Since a new getter 'repo_excludes_file()' is introduced, as previously
promised, once it is finally merged into 'master', there will be a patch to
update and squash the comments.

Similarly, I've noticed that the classification and sorting of variables in
'repo_config_values' don't seem to be correct. There will also be a patch
to fix this, and I think it will form a commit series along with the commen=
t
patch?

Changes since v9:

 - Fixed a few typos.

 - Drop an unnecessary branching in editor.c

 - Use repo_config_values *cfg to avoid multiple calls to
 repo_config_values() in repo_excludes_file().

 - Let repo_config_values_clear() receive 'struct repo_config_values' and
 do not check (repo !=3D the_repository) anymore. In repo_clear(), pass in
 config_values_private_ instead so that we don't need to filter calls with
 uninitialized repos. Therefore, drop the NEEDSWORK comment.=20

Special thanks to Pablo!

Tian Yuchen (9):
  repository: introduce repo_config_values_clear()
  environment: move excludes_file into repo_config_values
  environment: move editor_program into repo_config_values
  environment: move pager_program into repo_config_values
  environment: move askpass_program into repo_config_values
  environment: migrate apply_default_whitespace and
    apply_default_ignorewhitespace
  environment: move push_default into repo_config_values
  environment: move autorebase into repo_config_values
  environment: move object_creation_mode into repo_config_values

 apply.c        | 20 ++++++++------
 branch.c       |  2 +-
 builtin/push.c |  8 +++---
 dir.c          |  4 +--
 editor.c       |  4 +--
 environment.c  | 75 +++++++++++++++++++++++++++++++++-----------------
 environment.h  | 75 +++++++++++++++++++++++++++++++-------------------
 object-file.c  |  2 +-
 pager.c        | 26 +++++++++++------
 prompt.c       |  3 +-
 remote.c       |  2 +-
 repository.c   |  1 +
 12 files changed, 140 insertions(+), 82 deletions(-)

--=20
2.43.0

