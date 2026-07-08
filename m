Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835F52949E0
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526597; cv=none; b=iF6mYJAH7KJR3N1PJANw7k3PxzTqislVTnlTEKqC2aN4S6YzXq3sV7+g5ZGJ6Z6o+A4cyMS5lofavuhdvkEvf+magSJDDo4QSZa+kn5TG5KWbmYfJdRKoSXObD6xR616xi81ZGCEkcALgpBXw7Mtq1u3pMa10AELRCed7OpKFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526597; c=relaxed/simple;
	bh=Elyil7KPV3DJVJP6f2axlpZMcE1KEcWea93iMp04j+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAn5kyfKVI9rkwGJUiwsRV469TVCA1Zfy5w/Qh2Cx3iZLBjLBn0VCVALpmH8NgWY9to53OFlMV3SclxTWDES3Kol9w7cldUf0uA86qH3zAS7LYmXkUg/I2E3hVJ4IF1jr3cac0dg+s/GnW2f4bkzjiPBu2wSZ5TaiXSdSolEVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=lzaThji5; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=k1YAQS+n; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="lzaThji5";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="k1YAQS+n"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=lzaThji59/ypi+9pnI8z3JCY2BtttyS5v6B56aPKDVWLLWGWZvDupLXBaJ4QOu29ZH/IUDFgpYEtjadFrdl495P18T82FXwi5mBaZIARt90zIupMEr8YdZ6kOfVHZMmgBDBdmDcRP1WGov+fj6rDkR7956vsKdEaVnrjImpzBcf7mjrVEcasgalR2cxqXRRGN045oEHlMeaqYDFHywrSSiX8HqHm6SundIOspI8ctf/vTH0nuXuF5Ep9kzj0vAllylJRtHTubwPoxElgJLe8VbN2NsRQCwX3+aKmv1JJVX5cZBBopgf9nH41l9oe9R/XD0iYyLOzAhXFmRo2Vw5vfg==; s=purelymail3; d=malon.dev; v=1; bh=Elyil7KPV3DJVJP6f2axlpZMcE1KEcWea93iMp04j+8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=k1YAQS+nX9ORd7F833IawBtV1kA/sBTR6MK3gO70XP//rsU+9b9EH5ZgHRBP2PnlZ2byo/AZPp1+a+kCjVSEn+kEtnnKresnrZ+NjoaXRROSko0PRSM4EA6BJwQS4UqM9v9ADMpKA/9aOq5yS4mupBppkklHqSG/1Ni3Do+OKrBY1mbkiWbD+cubWloIDiL8WStseYwZyvctAUyUuvqdolrFw8HfEpzrzdi3ByMmMsPEpmlLYz2BbKm+XxWkDDIO8dYMYw5IuDBV/9xhd31zafgoLWwq8cDlRAAfeFX4avGvOch2FmTkB57f/9swfFCmmgcenwDhHekqVMNnl0tAKw==; s=purelymail3; d=purelymail.com; v=1; bh=Elyil7KPV3DJVJP6f2axlpZMcE1KEcWea93iMp04j+8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -238025841;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 08 Jul 2026 16:03:08 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v8 0/9] migrate more variables into repo_config_values
Date: Thu,  9 Jul 2026 00:02:51 +0800
Message-ID: <20260708160300.8852-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706142530.3681520-1-cat@malon.dev>
References: <20260706142530.3681520-1-cat@malon.dev>
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

Change since v7:

Fixed a memory leak in pager.c.

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
 pager.c        | 21 +++++++-----
 prompt.c       |  3 +-
 remote.c       |  2 +-
 repository.c   |  1 +
 12 files changed, 148 insertions(+), 81 deletions(-)

--=20
2.43.0

