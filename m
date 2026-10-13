Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305F522EF3
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924247; cv=none; b=OFrngYSMp+Y2GDH0xNNPatTSUnhKfdR0TL5NcdYEtISvKWGCvOhi7FihB5pbe3XSVAjenh1qbTmSmGY2HQ+NcgWLhKG2gzXLvOcgPCLY2tF5zRijxo+eFNMmRusfyOdBO8wJNfMO11AvPn4n1R3mMjvluP9/T4M6dU0TbbFSqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924247; c=relaxed/simple;
	bh=C8xwEt+wXjnBAb263Ow5eWowJHq+DKgSZi/ukaQUXa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXxW5WBnlfk8GoY8c0b5ZxILkdxXRm9eKUYJmqCDohNkXDbukCH011CamAWV3j23WVTwZAgOVqP2mb/tKO1O9/z7DZrDlqS6cjdux2VCUyohm9Lglr9igHErpgF5oAZh44MsDXgufQoxZGcS7uZRwhD0sXSJqSLjZlrOqFhMWeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXnrRbXP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXnrRbXP"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so33547305e9.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924243; x=1792529043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=73prKGeE+NLOIQuZrR8b3ZXA9LJsxeqW9UjcZz1/51k=;
        b=oXnrRbXPKvZLJ2yzZAEB8BsqAph6uNtROXnu3LjM+XAEhYK2MMI3YOH70bkruvVoC2
         7tVtJ4/USjzVq36l5e7B3AQGxjz1fgBjItaxK87GK9PFwyY1ZSTw9lhvAsj4s6i3Ph3D
         tVyHtx6BhZ8GmyllM82C9irSbYpKJyS5jMG9egXf4MEN92cBpAVI4mYE+Fv6ISea2u20
         04/zxfd6FNygzwTlYkYUobJXH5zMwFjNFb0SxD7aMLSNNDvRPwx20EAntTnXSY78Mn0x
         C8HXuhreFCUePB3ZgHNHJT5sVNrJjSFozaexsHnwlxURalPM4b7h/7+qHOr4lu2cfvQF
         FLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924243; x=1792529043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=73prKGeE+NLOIQuZrR8b3ZXA9LJsxeqW9UjcZz1/51k=;
        b=ZWKytoJ3W+j1bXNd/myR6bVU2vheYnpRMAgwb5DpItMP01EttS8hXf0/xjb8bgp7Xr
         kdF0tGThsZ4oQgzjBLH4mH9sf94/hDOlJA3aNzy0v630loPAIUkZfsdMct1C43P9G3So
         ToAyHlI9srshqPo1HVpQVsiOdxAE4klADrpCDk/xmzjCEsvPfBWlAUXG/Aik0IAz9gc1
         Pk1Vki2kcvhLoKSeLKD2VM8DyT6w2Cud+tNUw8z/6Gk5272WPsgEeoB+eQEeYrEM/bdc
         CNSIlozrV4NdiuTyf5LOrROxP3f8xgHxT7lHcJXD8BSRwCz4tZVb7IX9v0K6wWC+I+0o
         1MCw==
X-Gm-Message-State: AFq9FYJl/3gcalAUmHV1dvpQVijGG4MKmp8S7kD9gwNgbBdsynYcQMJ8
	LTZVAyiQsG4JDE1XW9wLarHS/5iAJUaXy2Oep2QlK4M0LG31YSIZV/nb8XxBa8V1
X-Gm-Gg: AYBFou2b0wIY5y/HxURkcDR4CGprUiNZnoIz2/opikft3IOpV9kGURDZGYUCkO6xC9T
	0osvDSx0IZTvsdtenIG3r9FYH4IINb657nbPuKmj/qhNmKBIaIPnDZQwJSSlJOlOK/svvmCMXNP
	amB2FlQXz1xMYX4cD725/0KMgH4CY8A7ztdtH3g5y5OxaQZWzLG5kLnft4EEOudVbyNOr7R49QG
	tMKDe+X00WhSrLPNOofNBBP/lYpA4yfsX+jIggmBWG/ZvNNmRp8lHjcI9sRV6McPa9+PS4SS5kp
	N/26X5w5ndJ4QWvZF1B4DmzriL+IX1f+ZqJI06iQc2jszeMDVJWhpCLeWv6Zvw76wj+oAd/v5lN
	NhyiUSMXs0BJFDI1WmKiuCO71Bb4e33bXcJUe4+ZrD+lECMFkOYYkkwIwcdlctzyGgrM++Hy8pk
	P+rJrwV26r0FA4oDfxDjXL/ZM4GmBSDoF6LJjr2TBiBv8KzxhiOeLuzeRWs2Xh4Xz/NEBMOQxhk
	jO3gO9I3cNrfZsigUP/i55P+RE26o2IwiXo2lXw3y/CrikNhaR/+j6FbnEPLYocDSOs9ft8jtQ2
	4l0+w3doreom2v9f0hE4WywGEoqEbG4uYQ==
X-Received: by 2002:a05:600c:46cf:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-4a18e47ad5fmr300616095e9.10.1791924243371;
        Tue, 13 Oct 2026 13:44:03 -0700 (PDT)
Received: from antek-thinkpad.tailf34d0b.ts.net (217.96.148.114.ipv4.supernova.orange.pl. [217.96.148.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b4b8cc7dsm2863325e9.4.2026.10.13.13.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:44:03 -0700 (PDT)
From: Antoni Borowski <antekborowski11@gmail.com>
To: git@vger.kernel.org
Cc: Antoni Borowski <antekborowski11@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jeff King <peff@peff.net>
Subject: [Microproject] describe: pluralize tag/commit count messages
Date: Tue, 13 Oct 2026 22:43:51 +0200
Message-ID: <20261013204351.428800-1-antekborowski11@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two verbose messages hardcoded the English plural form
("tags"/"commits") inside _(), which is wrong both grammatically
(e.g. "found 1 tags") and for i18n, since other languages have
different plural rules than English.

Switch both to Q_() so gettext picks the correct singular/plural
form based on the count.

Signed-off-by: Antoni Borowski <antekborowski11@gmail.com>
---
 builtin/describe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index c0abc931a5..9fbb982417 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -481,10 +481,12 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 				label_width, _(prio_names[t->name->prio]),
 				t->depth, t->name->path);
 		}
-		fprintf(stderr, _("traversed %lu commits\n"), seen_commits);
+		fprintf(stderr, Q_("traversed %lu commit\n",
+				   "traversed %lu commits\n", seen_commits), seen_commits);
 		if (gave_up_on) {
 			fprintf(stderr,
-				_("found %i tags; gave up search at %s\n"),
+				Q_("found %i tag; gave up search at %s\n",
+				   "found %i tags; gave up search at %s\n", max_candidates),
 				max_candidates,
 				oid_to_hex(&gave_up_on->object.oid));
 		}
-- 
2.56.0

