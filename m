Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1EC3B6BF1
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886079; cv=none; b=ddfcDEsQMJmCRzy3zyG0qVosi8GfwjxPN88XEAbu2yDbCe/2ke39I6MX9zFyVx1rjNX0cS6/bwKV7Kz9YKD7ioUD1J22HC93mtWfByFzbADvhvuY+KrQ1g4MCh7sllw1ucS/EP7J8MexmYJbt/fG6RbSYqVMTYgdAOWlKvkJN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886079; c=relaxed/simple;
	bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeAptmXP/sGs43ZduL7V+A8ZXCuUsIL/ob8+kulGe+bEv1ZPDu8eccqm2pT/2DUqbM1IevJBl0YFhDQ6pzzJSBDU2TvuiBpDEoPw9UbP2nQVw/FDV4oZtrvawxIwm1y2bmfpH09DxIHspNVswxHLyT4VFn6+qNzxYP/ka9w19+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=G69U5j/+; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WumpeLQq; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="G69U5j/+";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WumpeLQq"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=G69U5j/+vBzN9jbWxnSOsftg1rRjBs4jjr4xJtwKL7bakmWehcgfovu9VoA6GYT5923LhElJLBeaQtFBiNeUMDOUf1Nk02xCH1bjFkZlZt9+Fq2L1QFRvjDKDDB2QivGEpXZK2ci7cXqf9hh5cJGQXVe2e3FzGY84z3Xz8LXHne4gCQ4SE/SVyNDexFElTRxhiHCFErP65zHO10YinIOk3qHJYMh48A5YedAyjGmGV6zQKc0WHlt8GxzJO2xpyPJNAMVccQsZzWpFz3YmHwp1aIutZAMx4owMcEqur3BZmXswMylTt6f88tenkCJq5aLe/vtspm3FbnUGYRJZ8fW7Q==; s=purelymail1; d=malon.dev; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=WumpeLQqzfBikiRzJoEWiPIcYJ/kvQtvTXTmymLeqnVeqCAAw/AbDm6wE8+yhODXC53jx0MbYB7G2BEyMZI7tbFdhgJzqA6TXkg18pzbtX6IXjqKeoC5qYEBf6WxCKEhDXfVpMNjqQn3TDuNwpPwTQxWMGHRcerECLzcxaQ++zIy35hUHQw8eBgGJwgnosW8GSkqKNKn05hGBWCDyu4fzQzmhEkMvBytINzTzu8HtWZj4I4tkctGJXYGb5kfWHQv/Gt+H/s0Ut9CTh9blmBZOdh46PyOgFMPafa5DA/QdT5NIIAC6dULA/zDUcvDOcV1/aCZqC5y0Wo5DYjwR0m8bg==; s=purelymail1; d=purelymail.com; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -489877588;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 19 Jun 2026 16:21:16 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 1/3] read-cache: remove redundant extern declarations
Date: Sat, 20 Jun 2026 00:21:03 +0800
Message-ID: <20260619162105.648495-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619162105.648495-1-cat@malon.dev>
References: <20260612160527.167203-1-cat@malon.dev>
 <20260619162105.648495-1-cat@malon.dev>
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

