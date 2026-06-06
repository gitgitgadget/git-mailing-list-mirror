Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178B4071DB
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780756507; cv=none; b=gfLg2q/u3tla+XsDSwF8qX9AnFrYY+QPLZhlUcs3A7r1RMbX7ifT3diw3xDAblnJlnpo5OCuVG50NMp1dss/hrK6+bbbgDe6Yb4yotWTc25bUZblHkujf9OtpGYcHqLUkyN0BWh4tBRAqQBhhKeNV4JKbiJezI7M2Qpqb3sK6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780756507; c=relaxed/simple;
	bh=7xaIL/B3QHi7EZzQLJlMP06UkmFTkbP1teXNMTZcQYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8eQn0qnOsxypoTCHSwSU7GLVKx2cKCUiZcdwqCElULajW7z/wfQBCleyWCX3ZSWwVxz0JSQTLsmzWBmD8mSs9smjaFvcZ4A9eBWrAJvb4N8m+hHKLjIOGPN/7OVMv2ieSNO5dHQKvAorYZBDy9p+hrhwzVZG7GvWwzUCCZ1RmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=gtvMTpoG; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=HrxvOMth; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="gtvMTpoG";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="HrxvOMth"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=gtvMTpoGkay5U5FQ1iWAX0e2mYMMd1PVh3+cusnjnce0mgUocLUWeu5V3EUVCwgc8aziSvcvET+fqFIPPn9NhY4jnd1ds5jqRHjLRW+6u/1a6POLwGjVPalNtXy9jaLo2j5Hy2af/yibehR836J4xTkiGP+1EwGei7cMZXXD9gdcrHn/WFCYcr30nIwdaDItnvmWbSBQJ+OKjyKkFgsqfd2DcTnLpTiyFkmAGdaCbxzp1FdqJR6OwciGX3+OxdXcuId2m9Eis9woEY+uqpl+/9CJ0q+zN7KwY/G+mQUANA06IINDbf3Sh8WaRuhSJi55dmuHIrJS9HAuR7z526B6IQ==; s=purelymail2; d=malon.dev; v=1; bh=7xaIL/B3QHi7EZzQLJlMP06UkmFTkbP1teXNMTZcQYs=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=HrxvOMthue0Eki3QAidgZa8kOyO9M67JeifyHuwlRSwzxlko/btAmsC48rm+Gey2dPxFjrNFe3rEI3eVU6K7zJf1vmiFQ9VMbrKeVmaG+afWMYdP02Coa70K60ky12k3dQEZ2pB/OYDLJ1ORryLHTR6Li/B4VgqtgQXLwV9rJWLzXg9k78saC7LEngyH7NNqmaT459B0nsaxXTtFunLhsw3LsVbSsCFppW71RYkOl6mLICE1J88UFAR1WGDYCZrxe0ISqZb6EjnfDf+45F5fzNRB5rtYKrss+dHIeXaA0XGRqG2PBxBEIgTucOBBF+UzdCdvmpa9cSoNwoWaGGKYfQ==; s=purelymail2; d=purelymail.com; v=1; bh=7xaIL/B3QHi7EZzQLJlMP06UkmFTkbP1teXNMTZcQYs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1807185963;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 06 Jun 2026 14:35:03 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: christian@gitlab.com,
	phillip.wood123@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 0/1] environment: move protect_hfs and protect_ntfs
Date: Sat,  6 Jun 2026 22:34:12 +0800
Message-ID: <20260606143412.15443-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606143412.15443-1-cat@malon.dev>
References: <20260606143412.15443-1-cat@malon.dev>
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

This series continues the ongoing libification effort by moving the
global **filesystem** variables, protect_hfs and protect_ntfs, into
struct repo_config_values.

Place them within the **per-repository** configuration structure
aligns with our goal of removing global states.

RFC Questions:

1. Should we keep PROTECT_HFS_DEFAULT and PROTECT_NTFS_DEFAULT
in repo_config_values_init()?

=09void repo_config_values_init(struct repo_config_values *cfg)
=09=09{
=09=09=09cfg->attributes_file =3D NULL;
=09=09=09cfg->apply_sparse_checkout =3D 0;
=09=09=09cfg->protect_hfs =3D PROTECT_HFS_DEFAULT;
=09=09=09cfg->protect_ntfs =3D PROTECT_NTFS_DEFAULT;
=09=09=09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
=09=09}

Or is it better if they are used anywhere other than in environment.c?

If so...=20
2. Is it worth introducing a Macro or Getter for safe access?

=09((the_repository->gitdir ? repo_config_values(the_repository)->protect_h=
fs : 0))

The current approach looks verbose and lacks readability, and
hard-coded 0 and 1 are used as fallback values. I wonder if a macro or a
getter could be introduced, for example...=20

=09#define SAFE_PROTECT_HFS(repo) \
=09=09(((repo) && (repo)->gitdir && (repo) =3D=3D the_repository) ? \=20
=09=09repo_config_values(repo)->protect_hfs : PROTECT_HFS_DEFAULT)

...to improve the coding style a bit. Although I am aware that introducing
new macros is generally frowned upon, I would still like to know which
parts this might make difficult to maintain.

3. Note that Derrick attempted to use get_int_config_global to wrap
this kind of Filesystem Level global variables. This approach bypassed
struct repository, did not actually eliminate global state, and the
reviewer politely rejected it. Nevertheless, I am still curious as
to whether this approach might still be inspiring today.

https://lore.kernel.org/git/a42dd9397d07b2dc4a0d7e75bfe1af2e46cad262.168571=
6420.git.gitgitgadget@gmail.com/

Thanks!

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>

Tian Yuchen (1):
  environment.c: move 'protect_hfs' and 'protect_ntfs' into
    'repo_config_values'

 compat/mingw.c             |  2 +-
 environment.c              |  8 ++++----
 environment.h              |  4 ++--
 read-cache.c               |  7 ++++---
 t/helper/test-path-utils.c | 26 ++++++++++++++++----------
 5 files changed, 27 insertions(+), 20 deletions(-)

--=20
2.43.0

