Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216A3B3BFA
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 03:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784087714; cv=none; b=Muc7Ag1diWgzYL54kkngNq4tMIQ4du4EthDt1zX3hX9ArYQTNvQKn6IfIOtq+YcMnnEq4Bwv9wk9krCihAIvgqKkvtDfG7jNVqxANsiRms15amxRCqrrn0ats/KdpP7H5NQJd2O8BYKYY6dJPUWvGSoqI9Ybcl8mZQicpjfDAmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784087714; c=relaxed/simple;
	bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoiuZK/F6EteyAoZ7nDuAFvxnwSzG7lQBepJJUZ4/IiA+0ngPZdFIGatG6KmNJJZ5D8yHdlRSZQ2LIkvPyLWKXBtflpJDDOgvYbdiAG51KzW4KhRMOGCPrpDexpVe7i6xJsezkkU7WUjLc7b6za1Gj5dpQ9Y+gN0n3gytn0TRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=bEVvvWcQ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YpR53dM2; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="bEVvvWcQ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YpR53dM2"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=bEVvvWcQ/F2lPOsMVT/jEc1bh6KJUX5hs6x5ocsYFrSSmQtlkwY/MbaRf3EX4YiPVwrVTgrnXdgchMJahvKF2upXLrf1rlY0VHJ6Qnftao21ZNCpzoNUJsq65HWdkM99rbA+eKN6PEjoPKLYT81Ah76I8VEb4Cj0oS80Uy01x0S3Jzr4L7HQ5iFNubcEdNDNKoyIKR6ewYXGW6INGrkGCF7p/c8DeRYN68fPmuRnAPQ9BH4E4UH5rvcGjUSyI9C4leClqpzL7cc65iFANGa3hOen4q9jBXR7XCvk92T1oAQ9y3PP0ymMiWDXAy6OJ+6kFT1wQKkUH5gx/5nrs46kSQ==; s=purelymail1; d=malon.dev; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=YpR53dM2x8DGgmclMsru42UsmiPIHI83wPH9L4BcY6tZU2xQWK6ddORN9wDMgmYSGGXabHvRNAxIhvOYSLAoHKFpGJ3k/jLWTAjrL+q4ruFa4JVgkxi2gV1gsxv/Wk3UsLdbtd1XOOg7hNL8bOFqCWEnzxUDXuylqQPOqubAjXPR8ogBTi+LNEGhBekdlleu8w6SkerZkubrLqSf/A9jivkhcOmY5QerZ2uo59X7JRbHBNy8TrwJegaFTSuVEtlLIEYSw4Xb5TkQEmI/CNDmVDu5gaSL1BVxI1zSigrWxaxzCKer5UCxbl5GXZNHMw5cfJFqf8V2d3mNs94khBa+8w==; s=purelymail1; d=purelymail.com; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1876003495;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Jul 2026 03:55:10 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	cirnovskyv@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 1/4] read-cache: remove redundant extern declarations
Date: Wed, 15 Jul 2026 11:54:58 +0800
Message-ID: <20260715035501.48271-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715035501.48271-1-cat@malon.dev>
References: <20260619162105.648495-1-cat@malon.dev>
 <20260715035501.48271-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The 'read-cache.c' file already includes 'environment.h', which provides
the extern declarations for variables like 'trust_executable_bit' and
'has_symlinks'.

Remove the redundant extern declarations inside 'st_mode_from_ce()' to
clean up the code.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 read-cache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 38a04b8de3..c44e4d128f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -204,8 +204,6 @@ void fill_stat_cache_info(struct index_state *istate, s=
truct cache_entry *ce, st
=20
 static unsigned int st_mode_from_ce(const struct cache_entry *ce)
 {
-=09extern int trust_executable_bit, has_symlinks;
-
 =09switch (ce->ce_mode & S_IFMT) {
 =09case S_IFLNK:
 =09=09return has_symlinks ? S_IFLNK : (S_IFREG | 0644);
--=20
2.43.0

