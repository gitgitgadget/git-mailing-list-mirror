Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07983271FD
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270185; cv=none; b=PYeLzpP85IuVHwCvFFoir+o1Hizldtn3dbgFc5k+p1zREPCqM3x0CpSJOktIuDkyCVporMPLg/HtKnF9PucieHBAjzsUFmkCH3S1Vfnt1aL2qJYZcY/tfjMZPUOQVqTCMx3p24nILPuNbaDUr81pRRphUZiWEmtVohILIJxHK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270185; c=relaxed/simple;
	bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6Y8y2ZMll0l8PV7RW685KXGZo8U7E8QEv+f10V54P5xly0SK8mLVMREaNQ1L8hDla55+BlPKLEROu6G2vc6mKVmJcUeQZKoqtaX3JdXydA7QE9twtQgVPH5PlF5I0WJ2TTRRcRAbkGVMvIEMsVU11ZIpjaCcB6IZR++Pm+itgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Qa+LxBuE; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=oioEt3Ku; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Qa+LxBuE";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="oioEt3Ku"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Qa+LxBuEC3Td6TxLVxiOTyg5Af4slwlKcfAxidrjF8pSMvP7qHE78yF3RoylfJkLLpYZh7MLjH7WgLeC+CbVawjGfjyFPB6VGiHwOOqOYwYmA7jhfhsE8xsWOqsNS475Hhcq4AOxkdClbdnvTH9oOWKVibWffObAreGfbRHbnkmkQ4C4sOGKXGv2NYUwj9vMnyRiRvKMHBKvb6YG8qmm/yCe1xuM9zLnRzIZ0g+DpMzMWuM2SyaUHOntBktvpIAw9j69coRIh2GXU79iI81ymJpdEp0towGInOhfnZ3pK/lWzzTqV5bfG5+WwdHmM7saNFuv+cIAuHJv5fH36Fentg==; s=purelymail2; d=malon.dev; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=oioEt3KuUCwJP5LrrcuuRtenuYhcKnuCl3nSbA8/JXtCtBWxglmtD6qjfGzLuC3f1T/9cwYErDJq3+gsDo5/BUnGYnN74hOpdpSa1F7zH91sYp2/TDT/daPztzQTbEEMuZ8X9XMgdBqj1E5pvRkpTztbP6EiEPS/NaOTb1ZJypX7aYRW9+nfCWkClNWYQ8m0DnLr6IHmCIol0iEmcGLGLXBrUXxUbhkYWE1r2Xujh3bPxvLK9ZHrbZbLmNQDNWtBnos2fubO6tjlvN0ZWXleu8+Ryy78nhOLQBsfJCbHXWnP08AJQS0DE/7gV9urqCDy6qZ1+uyNU52yFnCM2h2lbA==; s=purelymail2; d=purelymail.com; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 894201780;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 17 Jul 2026 06:36:15 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v7 1/4] read-cache: remove redundant extern declarations
Date: Fri, 17 Jul 2026 14:35:56 +0800
Message-ID: <20260717063559.1633567-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717063559.1633567-1-cat@malon.dev>
References: <20260716084941.1101918-1-cat@malon.dev>
 <20260717063559.1633567-1-cat@malon.dev>
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

