Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73535E937
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 03:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999534; cv=none; b=RkOb4NmyPP4k9XbKjctX7oKygfVNNeNZyMl6UwQ6xzlqyKgjiyvnPcANk+ye9pVq+rDuqz/1Nefd+npIO+a0v4zucanqLkGuFvrKytv3pq9S181ie3q8AOijiZUlqFrmAZ+gjXsoXnLXKqKL4iSd+pw+zPPy9ZXGbbj/ovXLmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999534; c=relaxed/simple;
	bh=bXly1VUKeQ/x6nFmaz4H8hZ/SbjXrsAAhTpvr6OSNaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5Luhfsd9gB81sbhvQq3HFo7zff4UsfKHlLGZncKlGmasvahOA6nU5um5ez7v/lOH2ZxjHPuxL8DiML39JjXo8hez02kD2XxpLRWKxKB5SamfDSXCwLFsNSLDVi9OuL1rWCZxJ53x0w65bIuI1XauoaPd3ksoqlmFEquU95rc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=AL+I3c9A; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gBeCjgEo; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="AL+I3c9A";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gBeCjgEo"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=AL+I3c9Am3ILvMUJTOAj51x6syQNGPieYeQVjiltSVBDGjK3qhU8qZshOPLleqZNzFzZXZqnSqZYfySjkQTBfscla8v57FkCw9Kybyc36SIKbXV0zw1sQO9fJP6XnbgXi5hTvGoZsclPDwXpQPnv3mg+xHGd+rS/BVrAKsMdGZc8UzZL/TnftSmrL+rMCF3h2zuEhQiSA3aiHlRSKdZ3jKJXo+1sDJfrrNpflyF6KoX3H6jgY1Osjos+pcIuTeHQlXqMjFjBSmYRxXignkGb8GL8G9k5vnD462H3J0C/BiK6GXyJZPtuzKQH4VWZuDvtA3V65Y5WoxSP4y8P0DW3WA==; s=purelymail1; d=malon.dev; v=1; bh=bXly1VUKeQ/x6nFmaz4H8hZ/SbjXrsAAhTpvr6OSNaU=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=gBeCjgEovtU1bsEKmdrtLyBW1i0jTL8YkV3yBcShwMIPTEyGm8m94f3BBPLrsrrKScCY/p/H7Y6JB3YlzUV9S/er6v3We04GIhT8vim2X8Y/MzYR+MxskrCAx++RLP0YmQDEzuXDR/SwyeHLOmDN443zMqO2Y6KoBJQIEQKgKUcKCQndL67GKzpT4oKsqRIjaRmCMVajgc58Qu1xt6uqP8gPMcE2tiyVhc3L+4nwWNMgIF0gOrvDtsv/T/+LCtn/OH8MfoDVLYiKWHPNvRh6vKxgMGIPUpUGStdG8gJ8516dbawPlhv7oB0jXwfRqfdZI6ujRct1uagPL/boNYqAGw==; s=purelymail1; d=purelymail.com; v=1; bh=bXly1VUKeQ/x6nFmaz4H8hZ/SbjXrsAAhTpvr6OSNaU=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1695711826;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 14 Jul 2026 03:25:30 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v12 00/10] migrate more variables into repo_config_values
Date: Tue, 14 Jul 2026 11:25:15 +0800
Message-ID: <20260714032525.1611141-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260712111734.1073514-1-cat@malon.dev>
References: <20260712111734.1073514-1-cat@malon.dev>
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

edit comment (commit 10):
Adjust the comment for config_values_private_ in repository.h.

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

Changes since v11:

 - Resending commit 7~10/10, which were not sent in V11 due to network
 issue.

 - In commit 6/10, fix a declaration-after-statement error in apply.c

Special thanks to Pablo and Junio!

Tian Yuchen (10):
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
  repository: adjust the comment of config_values_private_

 apply.c        | 28 ++++++++++++------
 branch.c       |  2 +-
 builtin/push.c | 10 ++++---
 dir.c          |  4 +--
 editor.c       |  4 +--
 environment.c  | 76 ++++++++++++++++++++++++++++++++-----------------
 environment.h  | 77 ++++++++++++++++++++++++++++++--------------------
 object-file.c  |  3 +-
 pager.c        | 32 +++++++++++++++------
 prompt.c       |  3 +-
 remote.c       |  2 +-
 repository.c   |  1 +
 repository.h   |  2 +-
 13 files changed, 158 insertions(+), 86 deletions(-)

--=20
2.43.0

