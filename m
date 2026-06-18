Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7F3ED3B3
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781782945; cv=none; b=OL41nt6+2i0L4rFiRNAkvKe6G0DYQQ+6DFMxOwY9ZRDcj7cOQY1LGE6HYH2a/HVCbuzRLDnXpe9aWOT16I9lTR9160CsOblg9HwDw8Sgjez6a37XMVLKyFLLvFS37dJxCWN4mVcAdQ6xXDbRaQ/rGjb3/HyXaEADSfqpE0a9wVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781782945; c=relaxed/simple;
	bh=Du+Gaty/FqiH1oDawXT8omAz+dlIXAN8ZS0diBfOGiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyhTKBfnH/o9tQJ3vBnLboiloNN2zKYKfiBji/I1B/oUrXob3G+ZPkc1rQuG/wLaB0QLKH6lN18XI1NJqB6aye+rbXzqZBaz1dXvKe8RgPzAxzNTaV97Ln5ycNEffydaSK/TNrV2ly6J4Q5qC8v3tsndKGVcbShHexlYJOZXJ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=XVXEI9DN; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hI/KMiK/; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="XVXEI9DN";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="hI/KMiK/"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=XVXEI9DNseOFCVCkhrleQbCVYFW3ngX5lMylmk8GiqRWuj57vha1y2pnglYJfLrCPWMRIaxSYJKDR6HJYVrmGvgaq3sFjlxh31k8L70YT2urrBAVQTlyCeCSpTCQbVGYzeIJWcPJ4K9246EzaMME+YF2LZoCO5MKy2kNuQzmdmlj+4isHhLaf1vhjZqsTEfitP420Ep/04MoROSmUpgzrCn0Sv8iVYIPc532oTpnDDzTOCBm0dpNGJi4dA3B8Y3uz4xWxCRZU3QY/q6am36cTE8eUNGapb4ol0yaEe6ZEKRP9/KiCcID7OOGNNBudG67GUwvaoLOZliziuWruGnbtg==; s=purelymail1; d=malon.dev; v=1; bh=Du+Gaty/FqiH1oDawXT8omAz+dlIXAN8ZS0diBfOGiU=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=hI/KMiK/2ET+etI0nN0gzt29qkNCkPQOSY6b03EWIlCl0MI5XNuHWNDV5YdlEbaGv5t1bejxbCc8qSoN9pOVfZV3aHnbf8a22ndK9jz+nDi+8QuUV2TlDtyT+5g/QRHr2i3en/CSMu3ZeDG7eBZ077e9k7GE/c16CtberTPgyglWNQfSqqevCR4/DTFj4V9lnSxXoF3tBgNwkWYx/tEHKlhWSkdCTeNLmYlORp4F+UcPmjXSiGaOWkRPl/79SuaurURgJSw7mysTqiU9Mw++PdK/pkQfiTnVx0z/BPu1MDMOGFTlimtsKqs/bkHub8lAGxZoLS6TABXsXpA8o6JYWw==; s=purelymail1; d=purelymail.com; v=1; bh=Du+Gaty/FqiH1oDawXT8omAz+dlIXAN8ZS0diBfOGiU=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -632351446;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 18 Jun 2026 11:42:20 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	johannes.schindelin@gmx.de,
	stolee@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 1/2] environment: move ignore_case into repo_config_values
Date: Thu, 18 Jun 2026 19:42:06 +0800
Message-ID: <20260618114207.605211-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618114207.605211-1-cat@malon.dev>
References: <20260617154929.564498-1-cat@malon.dev>
 <20260618114207.605211-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The 'core.ignorecase' configuration which is stored as the
global variable 'ignore_case' acts as a core filesystem
capability flag.

Move this global variable into 'struct repo_config_values' to tie it
to the specific repository instance it was read from. This reduces
global state and aligns with the ongoing libification effort.

To ensure code readability, the getter function
'repo_ignore_case()' is introduced.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c | 8 ++++++++
 environment.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/environment.c b/environment.c
index fc3ed8bb1c..bfa3cb3045 100644
--- a/environment.c
+++ b/environment.c
@@ -142,6 +142,13 @@ int is_bare_repository(void)
 =09return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
=20
+int repo_ignore_case(struct repository *repo)
+{
+=09return (repo && repo->initialized) ?
+=09=09repo_config_values(repo)->ignore_case :
+=09=090;
+}
+
 int have_git_dir(void)
 {
 =09return startup_info->have_repository
@@ -720,5 +727,6 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 {
 =09cfg->attributes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
+=09cfg->ignore_case =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 }
diff --git a/environment.h b/environment.h
index 9eb97b3869..39a8bf0b49 100644
--- a/environment.h
+++ b/environment.h
@@ -91,6 +91,7 @@ struct repo_config_values {
 =09/* section "core" config values */
 =09char *attributes_file;
 =09int apply_sparse_checkout;
+=09int ignore_case;
=20
 =09/* section "branch" config values */
 =09enum branch_track branch_track;
@@ -123,6 +124,13 @@ int git_default_config(const char *, const char *,
 int git_default_core_config(const char *var, const char *value,
 =09=09=09    const struct config_context *ctx, void *cb);
=20
+/*
+ * Getter for the `ignore_case` field of `struct repo_config_values`.
+ * It checks `repo->initialized` to prevent calling repo_config_values()`
+ * before the repository setup is fully complete or in non-git environment=
s.
+ */
+int repo_ignore_case(struct repository *repo);
+
 void repo_config_values_init(struct repo_config_values *cfg);
=20
 /*
--=20
2.43.0

