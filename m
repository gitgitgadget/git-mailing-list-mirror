Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA723EC694
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544834; cv=none; b=AhQ1RyE49Y2yXhPX7ZxX7b5SI1YhOCiiHeRKL5SdaoEsPxMxD3sQwIWeidU5DLh1RKh9wnmpFI2xRjWoiUmTQQXbFK6Z9YX0msQMrnSKA24hzaaic0fhmuoleazO5u8cIOoQTZ3mFd8bm9hmn71i5LcVqzXk9Xen4L9XctjYRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544834; c=relaxed/simple;
	bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7/d5sfQA0EGUWgUGCse5l45NIo46yqBeqqyAziDVkJIs0MgxLiT2xMnthDuFD14kBe+3MdoJR+P5N/1UTRLqZ94OPTmqEOE81j5MsLBjpgd9QzNLnpnTiXp+P0vSWgOi+1iklGAfyqkvtyTUiK6sPtinJcgldOqHxvip4LtIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=BbVBDqpz; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Z4oTYL5I; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="BbVBDqpz";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Z4oTYL5I"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=BbVBDqpzmzfQUPUuGD7pgXts8pVpdx88bb6sMxbmkYtrtFyowyQKvEpDh9FYp7m7N2ULqHFjw80/8HlR3+6My1FqRiyKIZPDi+o93GjgBYVbtvQxiFSUK2ls7ZzOnvclbjOSiJ3pbcqG/Edm79ZSDsD6iUtdTXSe7oIbCKc4izgXSdJuVL2JArUAhYZN2prBTMjCNzmC6g/LpR8D3aT1ykC7Wj0KzAb/Y6QERFjvb92UfTLno4hgTCTyit7Eelv9UivT9hA+/9h06vj8SnzESZtknDzXtxxHcnvFExKsI015hPO1aLi/9eSrJbeFPeJya+V1cSOG9v1AUIPTZR7nMQ==; s=purelymail2; d=malon.dev; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Z4oTYL5Iex3jL+vOcaPABYS5EotpGZuzNnpLhXlEgDC6WPGX9w5CVh9nxtQYTh+QxjFZ3BYYsBxjJoS5seOuhj8KyZQK3xS1qz0uSG6ZmpKEHrG4mDhaOZ0niCwzMNkIrxWe7pcsri+T0to+07nT4rKDD0DtlDsAH8aUM9MxlISdE/ZigUSzHEw2gObjj8DrwaOweF1OJGIKr3wtAhCQaD0VTQlY9O0Bx0WocNSl4hJmSIM2L28swt5qGZIVtZfZnACe61TXabQNkd6dDDJPt5Z1Ov0ejNwhE7cGibc0tMfE69mCzen/LFNIyyYkc5ljtku2Cv7TL0j0ArJy33R+ug==; s=purelymail2; d=purelymail.com; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1835461667;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 20 Jul 2026 10:53:48 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v8 1/4] read-cache: remove redundant extern declarations
Date: Mon, 20 Jul 2026 18:53:32 +0800
Message-ID: <20260720105335.3202013-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720105335.3202013-1-cat@malon.dev>
References: <20260717063559.1633567-1-cat@malon.dev>
 <20260720105335.3202013-1-cat@malon.dev>
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

