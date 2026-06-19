Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3172EC086
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884331; cv=none; b=or4kPjsNdytJFpzP/wZmgmKTxFnHFDCi58CSSSL6Ez43873Z9L+nFhA43S6T5kUNCNyqOZSQv3GRpn6+EwaWi6DavL36iPbGbMHG6ASaqf/or+yKwY3cBu4yej1TSkphc1r74VJAzbx0oCfa5BYUgCpT1GaICG3fs2h9CGaT1HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884331; c=relaxed/simple;
	bh=Du+Gaty/FqiH1oDawXT8omAz+dlIXAN8ZS0diBfOGiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1IqKOTIUudeh6kyIkklPTyLXnfy4g4Ri0E2eRsiAQkB7/aa6rZD4EKxmW+Tbe/npUnvxzwYVvcuYsXUdZZ8a9CqRxGk8rJuxqdymiZxHoILFnUBuHB2bg9fVSgxdLABZEbbhPhfaez+UB8gV1PNOs4D85hVuS36C1OyLnp3nMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=NYWCJ20Q; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=kJ+UCnDg; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="NYWCJ20Q";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="kJ+UCnDg"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=NYWCJ20QuuxhQitmjLlTQPneQ2lIL1VUhYQlpKlClvj35tb5bb92/GctmlVMenzimkpTADx8CevQ38/LDzcEmzQkXsrEXYzMC7MwDW9X3Iq2fxFdKareJPk6M1Z6ZVyWisuNIMFDbduoowQI13o2vRxGlRSntsgI+NAEWY0iUxKn4odU6uKek4xrH/8F/a5X7rOUeSAOi4cZUUZKRqhN94nG8gvsj5/hz9t+tz0zhhKYfcucJ0QrpV/NwTXrt663qujv0NrGkylFDWIUBvofxL72CFZuNBvYoRI3ISzWzwHYsScZ9CM58HQ3LWhk71Og09RSSh2DP7WgTQDm+ZmeQw==; s=purelymail1; d=malon.dev; v=1; bh=Du+Gaty/FqiH1oDawXT8omAz+dlIXAN8ZS0diBfOGiU=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=kJ+UCnDgl144YeAlZ269pRVEvPbO+HxghI1QqewF9EBKLvRNBnTQhton4mK3a4OALsH9ZS/2GRBccbHbmxBJ9/EG3nb/rwrOCmQS56rEqCrS/4MADFQWOmrfsHxyUcBEsSa4maugiHkq39Eayg0zpucwBoafhzxVvMOx8k26TWJg5keEOQ6EPZoSCw0lpf+V4OBzskw4Apf8mGfY3b6DB5Ao3FrDy/UF6i4TtWZHebDEvsuqa6+Vp5jQwBnk99dtYHH+sBOQ+y/z3LNKltWvjKFE+mfXVtOn6je83f4SYcaL8m6LgDBxK1bbrYo3lYwfOaQf4Nu6QACgnYXwAze53A==; s=purelymail1; d=purelymail.com; v=1; bh=Du+Gaty/FqiH1oDawXT8omAz+dlIXAN8ZS0diBfOGiU=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1694538670;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 19 Jun 2026 15:52:04 +0000 (UTC)
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
Subject: [PATCH v3 1/2] environment: move ignore_case into repo_config_values
Date: Fri, 19 Jun 2026 23:51:51 +0800
Message-ID: <20260619155152.642760-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619155152.642760-1-cat@malon.dev>
References: <20260618114207.605211-1-cat@malon.dev>
 <20260619155152.642760-1-cat@malon.dev>
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

