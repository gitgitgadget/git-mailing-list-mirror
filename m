Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C843E1693
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084225; cv=none; b=XssQjkC2q02U6Qp71jnSjQa60PkHmXRs1BMhVQBhDQO3nUqGW3QEwFUeMJmfSktUX9kinKWQKbb2K6K8l3/agd4d0bF+ugsS1GvT0UHNDi0zfjHTRQoQ6j9CY2gOy+QkncCO+eSDo7lJeoHsIHuEUNuT7SXQf/1lZSadUSn5Ca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084225; c=relaxed/simple;
	bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4YGo2SWzhqyOSKCWR1nwwLqzDvmy2HaNWnMGeQJyl7sc8ZSk3e5j1s37wYmguLTwKag8QrmOFWZGCmmGk4pxG9mp29bCwW5nc/isi0lxoYixXsgTePoovPRflfEYIS+S2cR7+PIgy9REVTqtxMd5kO1HkHiHxARHce9rPRxCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=mcd0sV+N; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=jlMEjk4i; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="mcd0sV+N";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="jlMEjk4i"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=mcd0sV+N5ZMPPflIEn9ACnHh7rfojv1iNp5V1iidQP60T/ii+QVd2wCVHaMHaJ1fvsaSj8woZfst8rqWPmjkZbvTaFAaHZsp3UW3xGjLurieMg3e0lNuN0hAB9iSt6fDBPv00tojh0DfYmN4P5vS2AzgOzNNz0LxO5frsG1mzZ90lPJf66Vyv8V5plizDz/DfgXXGn/gAjMiHb/lbtoQCSSIcpin9DbgGxoGkybHQYOATjv89FcqfC0ObdTtUf7fJrvt0bUqNGUG6wDZU/xWldkhrPrAGrQB+64GL3NzNdZNzDMs5h68g2+f3rlG0eDJrND8tF0RuIqxi9U+K83xmg==; s=purelymail2; d=malon.dev; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=jlMEjk4iLIYxwreRQ2BFV6fm8Y3JvkiLFdQ28CUfdwc54bXI7DPYRWF/6i1w/LvDM4YoUdAyzcYXvGVj/yOKrj8RYMbrRLfV/BXgtqcQ91nMDWnZk3p0SLXsOdhgZ0yBtXz5OjYuUGXKURQJaIAGeuTjfpq9hcK1qi8R48dXVCeIg+ZPZAvN1TTkWCQQXdKB7uY6NXF5XXHLM+iQF80q7O8SbKnCgTuSz6BMWDJoV/JQETxPiHgsStELdimsyZyUXp2yyhIuTTdfUef2OtRmn9x+6kzNYY4q+pcSFiPi2usVyOErDXG6y0305zp5SOECgD7LhcZgYb+y9h8qTHItAA==; s=purelymail2; d=purelymail.com; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1035819346;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 10 Jun 2026 09:36:54 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 1/3] read-cache: remove redundant extern declarations
Date: Wed, 10 Jun 2026 17:36:32 +0800
Message-ID: <20260610093635.139719-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610093635.139719-1-cat@malon.dev>
References: <20260530160520.77859-1-cat@malon.dev>
 <20260610093635.139719-1-cat@malon.dev>
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

