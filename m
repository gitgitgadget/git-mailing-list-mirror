Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B43B42EA
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884327; cv=none; b=u5GQTPX4IqVopMHgy0twNice4d0m4eRbHpNFOQLM638XCHGp6DSdF0Yqbdvtw98zphRoB6qa6PKwztZbwJO9r+yjefuWsyJ7gnx4weWDWMcuDiHFMijf2vC6+MKHO6+30xUrBOpN3oft4L8jr9oAZpeW9NNchR4EvGqopKxfNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884327; c=relaxed/simple;
	bh=LtoORQdzKx5zXEPHyClSnyXfJuk2ZBF6g9Rdj4yyc88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkZbC7IJfdF4I2BxB9IENGZnCN8+tpl00XwonXhSGbt/tWUHW6pypVcL+59FTYIB+KKW5scYJzjHaHDcSLjSqn6qFu1Jg0/BdRxn9TrEiupme7Nq3B4fnLZ7sXDy3b0KIK43r3PeU3jBW8xnQLM0PK0z6IWrF4LIZzS/CSl1w7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=DXdcoztB; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=a+Kxy9nt; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="DXdcoztB";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="a+Kxy9nt"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=DXdcoztB+DyT29AnXS6Lu0fAO9p+hZTo/Z4wy2Cdd2vkiSOZ3AmtCEsJpcNON95rT7ULN7LqgemOh8ykmLjTqKwWgMWbsy7Xhhtlq87J9G+6Kq910xQ9Q12t59MJ4NuFL/JGb5tTKsLpVtZlHLymk5lQavu93uHRroFGdHErUYsZLU+MgkXdSBwJQvU3dwvZY41capwWczST3atzP86zHg4YAgtd9QDZo76lGF95byYZV1ZE+LrsMNJeTztLJcE8w1fD+5VVjj1UL+fC0RwGqBM3D0xpjdGh/MKxPq2O7hGPpFwDeEdc0PQTeHcsjDkc2+W9sKpZk4+OWy4k8RK13w==; s=purelymail1; d=malon.dev; v=1; bh=LtoORQdzKx5zXEPHyClSnyXfJuk2ZBF6g9Rdj4yyc88=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=a+Kxy9nt7nzeSOmi5UCQi7S/aPwiTlvL/SJjCoXmdbpaOlY+OPUcUDrbJaKJHIooI4ZOhvH6ee3rlja6ueRzFJiBaX8HGTuIoU/NqM3XaBIfDRftdt+0vsgaXwSae8MCLfMtrq+mk/cAuG5CY0EsjPq6PXDbhHJJCWsKP5TWbLCH3notVl9E2scoaY2Ydo/yzR8te+mJ696Gchp85F3t8110lYyvDXfDP3emI6Gl1ich/JsfEZfpDMk8BhqaBI2AIHPkkfjknuaepCICzc10H4I06jWAbIF1P0dg9GW+d+Ba14mwEggWWWWGLX6a7ltakDe6nlgacRWLC2Q6JIYH9w==; s=purelymail1; d=purelymail.com; v=1; bh=LtoORQdzKx5zXEPHyClSnyXfJuk2ZBF6g9Rdj4yyc88=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1694538670;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 19 Jun 2026 15:51:59 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	johannes.schindelin@gmx.de,
	stolee@gmail.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v3 0/2] environment: move ignore_case into repo_config_values
Date: Fri, 19 Jun 2026 23:51:50 +0800
Message-ID: <20260619155152.642760-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618114207.605211-1-cat@malon.dev>
References: <20260618114207.605211-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

This series continues the ongoing libification effort by moving
this global variable into 'struct repo_config_values', tying it
to the specific repository instance it was read from. This allows
us to encapsulate the configuration without altering its
eager-parsing behavior.

The getter function 'repo_ignore_case()' is introduced so
that we can safely retrieve the configuration value whilst
maintaining the correct fallback logic.

RFC Questions:

dir.c --- Performance overhead?

compat/win32/path-utils.c --- Is it appropriate to include the
repository.h header file?

Related materials:

 [1] The practice of introducing getters for filesystem flags
 to ensure safe access was previously introduced in this patch
 to migrate 'protect_hfs' and 'protect_ntfs'.

 When migrating 'ignore_case', the same approach is strictly followed.

 [2] Derrick Stolee's previous attempt. This patch series attempted
 to wrap this kind of filesystem-level variable using a lazy-loaded
 global accessor get_int_config_global().

 However, as Glen Choo pointed out in his review of that
 series, it is strongly preferred to use plain fields in a
 repository-scoped struct over global lazy-loaders, provided
 those fields are properly initialized during the setup process.

Changes since V2:

 - Revise the cover letter to clarify what the links lead to.

Thanks!

Mentored-by: Christian Couder christian.couder@gmail.com
Mentored-by: Ayush Chandekar ayu.chandekar@gmail.com
Mentored-by: Olamide Caleb Bello belkid98@gmail.com
Signed-off-by: Tian Yuchen cat@malon.dev

[1] https://lore.kernel.org/git/20260606143412.15443-1-cat@malon.dev/
[2] https://lore.kernel.org/git/2b4198c09cb6c04c60608d19072d419503dfe5df.16=
85716421.git.gitgitgadget@gmail.com/

Tian Yuchen (2):
  environment: move ignore_case into repo_config_values
  config: use repo_ignore_case() to access core.ignorecase

 apply.c                             |  2 +-
 builtin/fetch.c                     |  2 +-
 builtin/mv.c                        |  2 +-
 compat/win32/path-utils.c           |  3 ++-
 dir.c                               | 18 +++++++++---------
 environment.c                       | 11 +++++++++--
 environment.h                       |  9 ++++++++-
 fsmonitor.c                         |  2 +-
 name-hash.c                         |  6 +++---
 read-cache.c                        |  6 +++---
 refs/files-backend.c                |  4 ++--
 submodule.c                         |  2 +-
 t/helper/test-lazy-init-name-hash.c |  2 +-
 unpack-trees.c                      |  2 +-
 14 files changed, 43 insertions(+), 28 deletions(-)

--=20
2.43.0

