Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98AE431A2B
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008391; cv=none; b=s9KKb9YREvdRG6aUCmnZA+5EUxgr9dNVLVB5fzOKoZ7bYR4wI+90N4+WMMcJYLp+2qPi4JCYAciC7XTKChnVqvQGxwX0nGURxnXidYUgC+Id+bed7Kw1+s9CYjiX6p9dA0ANe2DcQXywIBKSiODduEKvzbfJem0+A3+r6nqz4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008391; c=relaxed/simple;
	bh=GcXVKy7idXLpUxMZvB1QDb94ALJ+EwY5/JzYOg57yIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g803yPlE/D6oRbtKYhWY6JVY2UnIEe3rrOHvO4BDCgx06qZZWHOAxK9Sje0R3/NJvnlvACftt9JcFV16k1nILkjFtoFQjU0Z2IYHPe1A5vrYX/2JPFohpY/lWT9FFggcCwHC7mOZqXI5E/W6bRVuDG3LIicUEDgjNgDEqm1kvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=JiXNIhhb; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=D6ktJoT2; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="JiXNIhhb";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="D6ktJoT2"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=JiXNIhhb6EVUSy5W73qQtNGsRLkqxdAvXdkTld9nv3RILC82SoMDAFTWxHM+AIRP32XEGZ/9aF0dD+8Ibdi9GFxwS04glRJhUOaZZahzq5SF0Dg4BHDH/gIqTq31ZCPEbqp9HPxnVOK4/8ByIfRrBj+vGQWj64I5TiuUnv+AkQ95RWLHX9H0pz5aWfTcFwI3pz6apgf98DRA1Y/G9kOLBoP9yR+qfgz2q+oKktszqgHAJoFT+8EiaKtxBItVV/eynML6AvaFHR9s9xn80a6Oqnlj/p+iINJhrfP+FZ3b31xZOtR6Yjm1JnEBHYlh7dZyOsiJe1z8s0C5dSH2bX3KYA==; s=purelymail2; d=malon.dev; v=1; bh=GcXVKy7idXLpUxMZvB1QDb94ALJ+EwY5/JzYOg57yIs=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=D6ktJoT28/zv0TNPv2yetjx9kH8eR89zoajKJVA8K1CH9VgnxH101xa0PfEvurz5Vm8uwjamTSfjL7h9xTSOKBDyQpNliVjvVQwn5/8udRE291pJ+gtHOpawMocYhztkql8Tu33MhzNrzNrSbf3knmYtvsMuPmx3uW5yfYIZUY7UVXiJwyhVVzOzsD9lC0w+kEzaR4BkSi5SyBAM8M1z0mVv1vlrtRlB3XzHYaY4zsfClQKBUcpVJ8vBCYgsaSjnhxJVOnZyj5baPSjTNRaTuEWzuKjwUngIpDIN5Nju4qGJwa1FHxHeRpstR/Z8+3gx/qZBSJBf8C+njq9Upt1yeA==; s=purelymail2; d=purelymail.com; v=1; bh=GcXVKy7idXLpUxMZvB1QDb94ALJ+EwY5/JzYOg57yIs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1822299684;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 06 Aug 2026 09:26:28 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 2/3] environment: clarify repository config getter documentation
Date: Thu,  6 Aug 2026 17:25:56 +0800
Message-ID: <20260806092557.3951208-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806092557.3951208-1-cat@malon.dev>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260806092557.3951208-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Update the comment above repository config getters to describe their
common behavior.

The getters handle repositories that are not fully initialized by
returning the corresponding default values.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.h | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/environment.h b/environment.h
index e7ec5b0437..1a58b553b5 100644
--- a/environment.h
+++ b/environment.h
@@ -175,22 +175,14 @@ int git_default_core_config(const char *var, const ch=
ar *value,
 =09=09=09    const struct config_context *ctx, void *cb);
=20
 /*
- * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct repo=
_config_values`.
- * They check `repo->initialized` to prevent calling `repo_config_values()=
`
- * before the repository setup is fully complete or in non-git environment=
s.
+ * Getters for configuration variables in `struct repo_config_values`.
+ * These functions handle repositories that are not fully initialized
+ * by returning appropriate default values.
  */
 int repo_protect_hfs(struct repository *repo);
 int repo_protect_ntfs(struct repository *repo);
-
-/*
- * Getter for the `ignore_case` field of `struct repo_config_values`.
- * It checks `repo->initialized` to prevent calling repo_config_values()`
- * before the repository setup is fully complete or in non-git environment=
s.
- */
 int repo_ignore_case(struct repository *repo);
-
 int repo_trust_executable_bit(struct repository *repo);
-
 int repo_has_symlinks(struct repository *repo);
=20
 const char *repo_excludes_file(struct repository *repo);
--=20
2.43.0

