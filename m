Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808F442B2B
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930855; cv=none; b=iVExq0zG2ahzziNHUZEzqc+b6tl5R9vUr9+urUJG8Alw9c37D84sBTu1S7mz1yzmm4fvoseDkxj21i3w4yXcHrvNpY+IKJT/oPKFh2pucL8iGpjD4qSSZc0NUKwQANFPkjzV3Grn05JKbMuUR/Gaf/urRa6iaXriENaAw8b3+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930855; c=relaxed/simple;
	bh=30sPTqEj5BTViInOSONxJBsFWuzIzRO25Ci61LhNKvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjjcyhZo6VZDZC146E/NGWevG5pjjbm2VgPqagTbkIVKIVCjxp1LKmumFf3IMQEzjTSo9gnRWad3CprsOds1GQpd+F2N3nKvY57VLDH8rxlyLKMQUl9MUmQAyD0Ct7nodWarcBuXWL9JsoIQwZY42RxetGoqAS9ZEpWtnwPm0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=FHQdYgRy; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gRYXoy9i; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="FHQdYgRy";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gRYXoy9i"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=FHQdYgRyw/saR4WUEcE6yS6XAytWzOHP2a8WKR2VYxsGbSrjBs+BMdgoGq0EIbheUz8igzWBLOnP18oRzVZaEFaIPAZ7llJp6Rbh8W+Ut5eM7GBsxNFTSg2DFUv+leNd4MnEKvzOAllwUN6Pn+zGuqpQFUJfr4xWvhDjVEXElGkLauRsvFFlD4p6n6JnFEie++QWTLCzZ4njnmYLbIU5vEoU1h3Elvd/lTWGxuBYIwzFg4ObukNXyxJM+oGC8SSRJhhAjsMgGtsOwf8skQN7Rc3NmFaoe8p9NPDWCfkB+HTdDGU3nfq/+9sfzHfwIIzZfC1Q8jKtDeOGJ3S/vQWtkQ==; s=purelymail1; d=malon.dev; v=1; bh=30sPTqEj5BTViInOSONxJBsFWuzIzRO25Ci61LhNKvM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=gRYXoy9ikdmhuz1oaKd+JjvNVVEkraQuon5VXeQg5gFUyJ36Je1MCFOjVaa7XBx0IQlNzSLDzUb+wnwQTlrSpxS2OxpGy1LrPg/ZxS9TiHA1tS5olXivT/S+ajbFLUHv18W0AwkSWKiXtmjZ/isO5tD+TZcjSmqZpQSrKB5zuwAvvCpi6r9m9k/yB1s295KqrZcm52NkCzMEjbBBMkQRCMO4nL31ZvTUVZs3pa1+JEeH6QadKonlCyjEXQxTxoiErjydIPLERKnYsIPmy36KLFIqH9dThB8gZu7c5AU/mrf7gwDAgqM58emq0+UjPKHT0KmD83xF8si0bFnyoVFg8w==; s=purelymail1; d=purelymail.com; v=1; bh=30sPTqEj5BTViInOSONxJBsFWuzIzRO25Ci61LhNKvM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1777023232;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 05 Aug 2026 11:54:11 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH 2/3] environment: clarify repository config getter documentation
Date: Wed,  5 Aug 2026 19:53:40 +0800
Message-ID: <20260805115342.3939931-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805115342.3939931-1-cat@malon.dev>
References: <20260805115342.3939931-1-cat@malon.dev>
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
 environment.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/environment.h b/environment.h
index e7ec5b0437..30678257b5 100644
--- a/environment.h
+++ b/environment.h
@@ -175,18 +175,13 @@ int git_default_core_config(const char *var, const ch=
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
+ * These functions handle uninitialized repositories or non-git
+ * environments by returning appropriate default values.
  */
 int repo_protect_hfs(struct repository *repo);
 int repo_protect_ntfs(struct repository *repo);
=20
-/*
- * Getter for the `ignore_case` field of `struct repo_config_values`.
- * It checks `repo->initialized` to prevent calling repo_config_values()`
- * before the repository setup is fully complete or in non-git environment=
s.
- */
 int repo_ignore_case(struct repository *repo);
=20
 int repo_trust_executable_bit(struct repository *repo);
--=20
2.43.0

