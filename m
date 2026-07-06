Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED0258EDA
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347956; cv=none; b=k7xdIKRf/OvFDuqIwdVlShAL/mPDBo3psEzGtOoeEGLDyEfew9FyWt0Tl/cCIuf8Q+4JeF6n7ci21neSbTfFxbvc/cKhv4mfpCiSkQeaUWWAr4UMJNXzHoNzVMp9mMmdvwBWs+q3FwNcZNqjPq3Xh5bAoz7n6XypHWLU9WYMeBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347956; c=relaxed/simple;
	bh=u7YDo1jiukpTz9YlxgR85BMc55V0RvRWupBMXIxk6F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uClu2Vb9WR2gI/ZMihJWVyDfAJ2jR7sqA4li8WDnBESV+r38t7jWtOk+fHj+7M6FkS8M8Kc9JtZX8jyXiDqDdGiRWe5n4QwiGHH7jDyAIcGEydyFGPQpbswC5OeIadMyX33oobp4EQ9uY/qUBC0HyL8ZjwXuaYcHK4cLwf87yAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=gWWk/aAQ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=agUiBsj2; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="gWWk/aAQ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="agUiBsj2"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=gWWk/aAQL+cC1eMrlA+93Na1BaqbGGI8TmkFHS0vBx1tkUAzYzEtX3Y9Urb8jnWT7HJ5Hy9u/wvxFyVuZlkGYNs82O4oc84y5IJJ+FhOs8vYAB7i7Lw9RCIMuylYRXmE3aCfx/AOK66/BdMPsTYETzl7BUG0hy0i9egs6b3NHy3MxccZWoF3ULWAgaI8t7zieou65JflfvQjzG0OrgBLbdUbSNRfI/huTqRa4Wzjw90gd7xjY+2rzjGK+otKiNjoYsCRnIDIyLLESUEbyVObB+nDcPjWC9Pi7vIgsTAKdaUTOxndpQaNNd5OlIBLXv4cDBYM6fdfs5g4Zuxfh7L/ZA==; s=purelymail3; d=malon.dev; v=1; bh=u7YDo1jiukpTz9YlxgR85BMc55V0RvRWupBMXIxk6F4=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=agUiBsj22N+fAG1cNJu2Wod4+KtyOCD1ZNLXePpgsa+V7KKX55DAU29QtRXaam7ysOXBmgC1wlyIw2lSpF0x8lvAjrGxcNsc3OsTgdMt/A7yFVvh72Mnx/rPOpPKnrCMMoYMN8cmM7O01fkRxJqv3+EAINHU7ODcm5mc7l+usvujMkjQH98ShhmhoGy/AD58syU1cNencTSL76GKpmiGu9Yqge+TEHY3dS8itcnV22amb2pgO/eE8sfRqJNhhO+NvPO2iIdfZaF4PQITzDIuVRAUbBcGL3vGv1RVoDAW1Jy6LmmCPrsEAOvLlJOaE5Dhsz7ZpC10F9iQJI2cMUsiPg==; s=purelymail3; d=purelymail.com; v=1; bh=u7YDo1jiukpTz9YlxgR85BMc55V0RvRWupBMXIxk6F4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1851978137;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 14:25:52 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v7 0/9] migrate more variables into repo_config_values
Date: Mon,  6 Jul 2026 22:25:21 +0800
Message-ID: <20260706142530.3681520-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701180813.776173-1-cat@malon.dev>
References: <20260701180813.776173-1-cat@malon.dev>
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

Changes since v6:

Only the first two commits in this patch overlap with v6. The reason the
subsequent commits were not released separately is that Christian suggested
placing the introduction of 'repo_config_values_clear()' as a standalone
commit at the very beginning.

In other words, the v6 structure has been discarded, and this series is
being released as almost a new patch.

Thanks!

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

 apply.c        | 20 +++++++-----
 branch.c       |  2 +-
 builtin/push.c |  8 ++---
 dir.c          |  4 +--
 editor.c       |  4 +--
 environment.c  | 87 +++++++++++++++++++++++++++++++++++---------------
 environment.h  | 75 +++++++++++++++++++++++++++----------------
 object-file.c  |  2 +-
 pager.c        | 17 ++++++----
 prompt.c       |  3 +-
 remote.c       |  2 +-
 repository.c   |  1 +
 12 files changed, 145 insertions(+), 80 deletions(-)

--=20
2.43.0

