Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876763E6386
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280350; cv=none; b=uwxbHEmvNNHtdDV5Vhg0YZ5oGmG35WAbyd+6E52oE5vGYQPBHnfDtragp1FFLhkazYz+QxRoApK+KvCF8llupGePbBv5vrNytsJ09uul+FdEWUxJcUq0s8gstil1vb0VuUoR/IHFH87Tmr4jDh385c9T/pKXTJGRaAs4Wgjg3k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280350; c=relaxed/simple;
	bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljX5HzG2U5qla4dX1T/aDzSnMBiCbm3RCziV/U51kB4ao2A3qMXEXHAA4rkw5Rsm/elxkioWt3SHcYUGjW5qjPzasxy9T2m3lm+ocXdXOmoe4YVejhvtTXze5GeNfPFxTtFAaTI6VvUQrxAPdtDwZU08g8XBGJPiuIw1KoCSo6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=boN7Ox4H; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Ig3LBw/0; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="boN7Ox4H";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Ig3LBw/0"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=boN7Ox4HO6jjeOwhfbF2NqPYo+joM+N0O/hjZwOoegAN8hSCVRnWQNTddR5WnZjTgJzFBtu5xRYg2vJ8FpNjE12tWOrje6JpOoUwW2I2bRYSI9Y44xe08X7ooqjcV8xRZzoFngGkcYPzN/4C3nqaSQMyx/vgijQ6O+Qv4c8P1wNR1THl0QwunyCcMcMWKbdYXbyI0seJ917AUIDczQz1u6n11UKcKE5t98XfUM849WNGq6wV9OAVuos0i2vmMBaRnDBBTlcXUyZSrUab4Q/x9qkMURH8ksILKGVNXqvpZXJNhTnV7QKuajnP+MdlEUMTNQO4UVnWadBEUDmhgDFUUQ==; s=purelymail3; d=malon.dev; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Ig3LBw/0Kel+kVczWn3kx13Odfy7zJUcUiNBGO2BI5C8X8u7bWoHJVNZIFHSsW1v1w/X3lK8KBqfSEHAsLbOkz8mj7ErzbGIU+PTz7bkm0slpE37SquFNQH6J77Y1sI5i4mBNJicRF0AzMSnIFi4kRn9hvARN+n2jDmn+fVuJoaVUcXGdJ6iRu1qDNoda/KsNIftYvuCXFy07GdRccxyuiO/sbEgWfdv6WSE5Kartp6tOnGkFkJNjTp9wYNznqT/HbiG1OkcQQiSk1P4TAnIi0Dk/KDz6wKSfZsuBoUCu/v7caVnkCfthMzY/P+v2HFklsTx4knfNbMVUdorpBqAwA==; s=purelymail3; d=purelymail.com; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -702755865;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 12 Jun 2026 16:05:40 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 1/3] read-cache: remove redundant extern declarations
Date: Sat, 13 Jun 2026 00:05:24 +0800
Message-ID: <20260612160527.167203-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612160527.167203-1-cat@malon.dev>
References: <20260610093635.139719-1-cat@malon.dev>
 <20260612160527.167203-1-cat@malon.dev>
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

