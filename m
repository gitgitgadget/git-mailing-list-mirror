Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8948E18D636
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 03:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999569; cv=none; b=bum6m746QhnKSRNT6MMDt4d6vqD44d5fyC7NuzQL4vb4Gv8HF6L90pmfmsjZH3QWm8VAtkJghWzUj81uQojGck6AHofT6FGFNMxxt5JmNrXExUf70nPS7GALYwPJEu2waMcjVQs50U5U9Dad5bWkbDuFMAyj0RH43p7JVaE9CdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999569; c=relaxed/simple;
	bh=nbViuMEx1Wqw5LvJfshsSR9cZsdO0H9yEmsXC2xyzGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeTm/Pw/uOTBoHNVUnGiLmxx/SSR5Uil/xbcdB3FQnPWo9q8UXR+L6VW+IS7jPVYlErfJG9JJYUoGNUOFe1W5Gt8svVQzSOfEfslAkx9Ro6TkzGnmp2Nx9JKZ8aYTpfMSXVxcIDLI9OdepoqZtBps1sdxpXtyuTw0t0xLPMA0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=B6zjrRds; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XzpG+2k7; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="B6zjrRds";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XzpG+2k7"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=B6zjrRds15slGiHi6aBtvAmBkHroeE/3aDE1iFClS/TFylq6Qib4KAxq6vX07RPSb35FbU/tHKjfIzVxNfqwBa70O+TLP6foj657LlfL98EpFdhVjDqqcyYkWaEQ/QRfCfLMFyFaMos0kcccU80ZX9NmhxEaasczIf93l1YdzBbv2FJsahzm5xGoCZUs2FAhpJINtEVZeTOVt5MRHlIg6E0/P5FQmNWFibX2NTMcUXLh7odZ14acZFQ0iBXrqdIhIiDNQCKdXmfC3J0+RAmjKi+xOp4nmKtJffreVe5opLEAr6IVJZnvccNeQuWJ0uEc++FysCyGvxQYO1PgAw9cBw==; s=purelymail1; d=malon.dev; v=1; bh=nbViuMEx1Wqw5LvJfshsSR9cZsdO0H9yEmsXC2xyzGs=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=XzpG+2k74qGMk0D/DfFX5+PZRvQAOYxUUwbYiQKmg4sUw6ih7jN7wgOGZToKz5WgIn31f4K/hpK62qJSC0qfDIDJfcgDjlpmYm6yAM1/l1vX5mafOaF2HAQcRFp0z2gys7qNWwV9UhIVWUlPxTlCAma07sNUL42KmWFcFjRSnlHRRCxZoSjEvpURX44ztebFoTCUKJNssA6UCm1xVeGSAmcHNGeNsHhVnB83AfDHMHh3oBYfrLMimQkSv8mpLqWBCPZEHRCNbgNGYHSsJl+hSlo3r5oIoNkNkyb7shukIaWFOJPJonUytKE7PaVucIU9etftx1Ksi5hWOl0bcCZg+Q==; s=purelymail1; d=purelymail.com; v=1; bh=nbViuMEx1Wqw5LvJfshsSR9cZsdO0H9yEmsXC2xyzGs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1695711826;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 14 Jul 2026 03:26:06 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v12 10/10] repository: adjust the comment of config_values_private_
Date: Tue, 14 Jul 2026 11:25:25 +0800
Message-ID: <20260714032525.1611141-11-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714032525.1611141-1-cat@malon.dev>
References: <20260712111734.1073514-1-cat@malon.dev>
 <20260714032525.1611141-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The configurations in 'struct config_values_private_' are not all
parsed in 'git_default_config()'. For example, 'pager_program' is
now parsed in 'pager.c'. Therefore, update the comment.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 repository.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/repository.h b/repository.h
index 36e2db2633..9093e6af93 100644
--- a/repository.h
+++ b/repository.h
@@ -152,7 +152,7 @@ struct repository {
 =09/* Repository's compatibility hash algorithm. */
 =09const struct git_hash_algo *compat_hash_algo;
=20
-=09/* Repository's config values parsed by git_default_config() */
+=09/* Repository-specific configuration values. */
 =09struct repo_config_values config_values_private_;
=20
 =09/* Repository's reference storage format, as serialized on disk. */
--=20
2.43.0

