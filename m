Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C02F12AB
	for <git@vger.kernel.org>; Sat, 30 May 2026 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157161; cv=none; b=Teqaz8pZ+nnL50H+QgqDqT09dlnPLSZfvuV/MlNqK5Pe5vHkJr+M5vnDpnmBlaiZfWKLsgwIZwcZ+Xd9EZ1oE7a4SpYBlbvfYUrO1qmYQuZV0e3takgugFPeLCBW1TgaM3k9cs93nTqTPOB5BnfSDcXaPaR66MK0MlhXzUxh5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157161; c=relaxed/simple;
	bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rL+LTgPswagfbBi36IM7EOZ+aFPQbXlQFgwq2NKbjzl5pTPjCDaXUe84MlxveMj+JojADJKpXF1Wq0O6uvRBnLzQjCbOffw4fiCdHfQlB7h/yOlfRXZWGKI9oWNw/j/+TEXA4x+cqtzTC557VCrLPyjh7idw5/OvQ70L/V+Cm9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=rxbjKuo6; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=e4b9B+t7; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="rxbjKuo6";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="e4b9B+t7"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=rxbjKuo6hw29+RRGDD1/Wu+y4KESN0W8KyYnRx9E0ZveR6zoOXMLA0w55rmbZ/CiL/voxiWd22fh9RXbWRj1N4vU65MIEOYaSTKlO7TOBfiOhJ4WmyOHmxqfc5i9P4i2OWj8751pcobxksXR2oTg0q3qumlkGxk2MrxIGpPBwZWqLnCKL7RuoilZNV3bDfXLvo+OJmQtL7Kd3uiaCRPNRG2Jqwj3JaJukC5YdJ9Dio0YxLhAmEoBEjJvIQGv2VtraJsoBPy+8/IBjt8F9QTyUM/abrJN9clPW3qjL5CNMuusB4N9pdLZ50UIIphF1tH+1t45oXqP7k9MZFpyT5Xf4w==; s=purelymail1; d=malon.dev; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=e4b9B+t7jP14QcLKgas70ntFPSlJUMzuoEmdj7y8Tp+6CfmC3bJY/0/DRRTqSOf8SNojiBWqVgQ1X/nwxR3hiVxf6Nrwk3LEcbYD6TH1XHsR3L5A8bp0NJKocUah5a+0RXS1mzwmshOSAonPT+cTnRZ8z4vWJ5rBC53rTRNiehi9ZYyM9RgZiJxfAljRpCpkPBo1R16LQIFE+4lPDrtUK4yOhao7ViCrBJjskjFOJCnPbMkyehXhSMZ1SVxzSta/bK8VOjZl4pCoYqdZK8mmSSI84TiF5mVltohAVwZ4KFaHJl4vFPfnNNcKf0vp8MMmlp7P3kNydJq4+8W+8PzwTQ==; s=purelymail1; d=purelymail.com; v=1; bh=Tx5a9uTp4ac/kZBXRghvhh8wX/Yo263WVhEq7ZBjQkI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1173446767;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 30 May 2026 16:05:31 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 1/4] read-cache: remove redundant extern declarations
Date: Sun, 31 May 2026 00:05:16 +0800
Message-ID: <20260530160520.77859-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530160520.77859-1-cat@malon.dev>
References: <20260530160520.77859-1-cat@malon.dev>
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

