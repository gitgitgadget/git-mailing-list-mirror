Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2C34E75A
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 03:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915070; cv=none; b=dp97RKgAw1TB5UQ2w07UHDc9dANGVGRpvQnTnRkjmKxlgKtT6F1enWYP0SLe+XrNvhDL8VIXd2RIz+u+oSrXuGu8f1Tc3M84iYka13bMveHnzcXOY93u/zhrA9EMgjyenLoSb2cLXaCa0L8VQRCXBV8zKtXzclhQhJ1Dh4lCKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915070; c=relaxed/simple;
	bh=DAWlwSGa5xZ+DvEHf3fpEP+kWCUmZNwzuouN4+/HhK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHP3k40PMr6sTJ40PLh0w9zb2X2SaYjsNEagwd4/266I6YxKp6KKqRmulLHiAvSIVrUOFHUCk/DaHe3GaH0xLtgXnbtYaRTrfvcQSGkWdMJ+aiGHv5v/x5MOqQs2PX1FIOwRXf9Q75RueT+jsL/smM3jhrp4tCIc8vG9Uy6TRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=COgN5ULi; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=KzYeywPP; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="COgN5ULi";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="KzYeywPP"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=COgN5ULiwznay7YSogxmyufM59RuQ0cA5OMiCk/qAKg7GtuLTJWw7EiA68dFecbZhgqP7VFQRi0Ox/M31dfieVg8oxmT1/yiAP71OrGJrRW+EVm5atgzuuN3dOhmcd+z8SFg0Esq0od1lfTEtbzeLUOHGttts+CK1J5y+xmTfG2ca9Lir8Tem1NVvGIFitPYJnC+0w3d1Z+CRVo2exD7ilP0Z1UzvacfVyWGEx2sKbKgk4MG6AbJnWpEOFnY/ESek2HOFVOSb+t7FlFL2Jupk6tu+2lQOxQUw4ANg3cXowLDubszEhsgxJrDVcpFNWk0gWblbdqU2Vl2asRbUlqAsg==; s=purelymail1; d=malon.dev; v=1; bh=DAWlwSGa5xZ+DvEHf3fpEP+kWCUmZNwzuouN4+/HhK4=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=KzYeywPPsZ+HdVeDmN1a1b+msgD7NzoYF9tUMUkWeSZFiZ/Rp9z1I5QuLd60092rs4KTHWIL5kPPoG2PK4lYeTVbMHo35aNNdH/dQ3itYoaDusMYE9NizrmqbzV4SKVXmDFby88K1gKaTNkmpnHV1im4FR8OJfb9wypvLnWfd1JTanguoGUSphYCpiJlRYc++yU7wjz2LXeo97NnSzKweH7FPyRY4qRv0UVMbJtY9nmSnYi56GCsBwUwKHrXNtubzFaH8awgdZzV0kgFeXsFke5+BzZO21umGNTuwXMHlyL1IEhVVQ6kUhVDFUtc7JzIMvaXtVxAWekW0oTEEx4TEw==; s=purelymail1; d=purelymail.com; v=1; bh=DAWlwSGa5xZ+DvEHf3fpEP+kWCUmZNwzuouN4+/HhK4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1573664722;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 13 Jul 2026 03:57:45 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v11 00/10]  migrate more variables into repo_config_values
Date: Mon, 13 Jul 2026 11:57:28 +0800
Message-ID: <20260713035738.1606138-1-cat@malon.dev>
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

Changes since v10:

 - use repo_config_values *cfg to avoid multiple calls to
 repo_config_values() and avoid overly long lines.

 - drop the extern declarations for askpass_program.

 - in the commit message of pager_program migration, mention that the
 new assertion is fine since current callers pass the_repository only.=20

 - add FREE_AND_NULL()s before repo_config_get_strings() calls.

 - create a new commit to adjust the comment for config_values_private_
 since it was no longer true.

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

