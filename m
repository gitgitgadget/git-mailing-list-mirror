Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40840F722
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437238; cv=none; b=OdL90SKJG2Vvy4/gQ/8a5jo3aUvYESnFpzDSlvxTAc3iKNIiFm/87yos9MGi3goT0ZAo9oJICb634ulPcIui5mX/laToNQcVM8ysAsfHtl7mRSYxgkS58cBTo3pO86yiTPuANmYLvnMMZiPOy1mNcqreZ5x4PKoGYKb6DVn2I0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437238; c=relaxed/simple;
	bh=VRkCIYtIeNjZg1XmXoM2dpK3nHs/9FfmHaacIq0fshM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWL1mAqBUtBmItFJvZJwbWDM2yMUTsIUY/OrjphkuhMPy5iE4PitzESSlydchkX3V1mavbH8iF7wMiMlPNOyT2M8VcRJLhaKQnoCvZgxftaRVCRyWi7MTCj/6SLcXl9sjJpQOJsNJWcYsgZGgAVhSpYSOJn5x3r90jiC1Fg1xKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic/BQzJ1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic/BQzJ1"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so24797975e9.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437235; x=1787042035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7b/MU4aLvWFEMgp8+uKkzFfZhR7GImiFoHKIck+oSKk=;
        b=Ic/BQzJ1U7u4DCLV8fWJWHrc5LxhU2kUNZR+EBgFcnU5FGEWzoRd+FpxnnhR3DmLR2
         VHottYstPKc7oXxjT0mpnsZ9O7gAHNNGuLSBz4nGeCJ6oFxMCk2STfY2JzIhFKl7G8nP
         Iz90Bxgpg82nWuKb6/Fl+lLQEjzIt0T8TFw9xciodjNdP5J6iShtMCCqtyTfLRnoNr9Z
         jJ2Yk8sFZvPY8LzOV0ISgcz43KmjZtEfm+orzQHtAOpYdOfoKHg6Bi9Tm9BuDMgWpubL
         07VgiHC7VIqVJaBCYBzh8GHqeROAKwHQBPjkGrhx27lFpWzyRjknwEgtD5Yr+FXgdoyp
         1vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437235; x=1787042035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7b/MU4aLvWFEMgp8+uKkzFfZhR7GImiFoHKIck+oSKk=;
        b=PzJn/bcuke3zFbJEVqlGxL1YBIIplBLrFsurSfWUNUM3QkQt65BXKmbXjbXblW0+AR
         W1uRJEfInlriHhux9mB1gugBFJsWsmZfAFa9qAtYyPD9tGiACBk7lnugkBXlK4ORxsmI
         WAvB1Vq1CfeoF6vNCJSusSFOc4eaDnPy8QVtUWW5LptpahxlixpToyCc+ib4mlQQHuZy
         iOL1dfGoliBmP7M1FR6VLkcSJgLx1BpM67u1o+K5XPmswaBiJOFT6rE6G7IwRoV/2Ilk
         VgD45BVphsY5U7Xg9Prv/4foOZNNWZiJpzjgh7d6pSkQZywuC9pD3Jx/OcPV6YGWgFWv
         QOyA==
X-Gm-Message-State: AOJu0YyJaPg03pzHHd5ICa+1cvcURx7/KYM2IlaDYvhorDgB9EXfDOva
	0q3ANRGrsX4LU+DIM2LDSOMZzGugBvSzmdR3nReLoBcYhhIu6k6jcyLuAWv6UA==
X-Gm-Gg: AR+sD13Dluk/Q+5s1cTyN7zIuEEKbf5XhVPDSrZ+Dn0nSrx7fTM9CKTYwNr1cQhK3YL
	LhdTJyChQxURk3TC0JxjjzoFlwHi55+q4m4K7lwx65NTwIloonLEXbHvnLeimffEawyD0FyctSy
	Bp0CXFd9/ZNoAtQD2DgscU2ZN7mhVMOhI9BReO66CmqYtLUnKpVaLUHbGz8/WvfT9gurgqdqxnV
	DAq49GjHnlhkmwSBuzGTwuCnpXGIw9HDwU70buMuEG5F7PezOC0wqcCh+kXgjHuLQD+qUxWoP/V
	Q7neK4Mcf7ULt3AYGBbikPeFNpFXfMLoCUmaqkiGatClwtn+X55Ap4BVlO3acMgq3xV4sjWhGnA
	Et4LzsAqgyVu+Pw998hdKu/NvleLdV1lKdDZBn595kMbUhp0m5+01dKCtBatsY9yzJyS/1OCru8
	dnjG4/yHusWE9ZeHPi7LF4v5hIzAea2Rr2Ktq+71v3haCjli0cZF13hhVG9j0EKu2pdPHuzdcdI
	b/BJgJyHZ7TDWUsfJ2sg2UQim3wSCVAt0opqh8dF5auSvrUpRgaq5zaYOVaGQAgWbMQ0ibjBjSW
	6nE=
X-Received: by 2002:a05:600c:3553:b0:493:cc25:85cb with SMTP id 5b1f17b1804b1-4997844ed1cmr22319785e9.8.1786437235239;
        Tue, 11 Aug 2026 01:33:55 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:4d0d:8be2:b2d7:3667:a5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c302sm18728075e9.1.2026.08.11.01.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:33:54 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 12/12] fast-import: remove useless from_stream argument
Date: Tue, 11 Aug 2026 10:33:14 +0200
Message-ID: <20260811083314.2023489-13-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260811083314.2023489-1-christian.couder@gmail.com>
References: <20260804100355.1299498-1-christian.couder@gmail.com>
 <20260811083314.2023489-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that a previous commit has removed a call to parse_one_feature()
from parse_argv(), the former is always called with its `from_stream`
argument set to 1.

Let's take advantage of that to simplify and cleanup the code a bit.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index dd873ec433..4e3c960150 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3867,30 +3867,28 @@ static int parse_one_option(struct fast_import_state *state, const char *option)
 }
 
 static void check_unsafe_feature(struct fast_import_state *state,
-				 const char *feature,
-				 int from_stream)
+				 const char *feature)
 {
-	if (from_stream && !state->allow_unsafe_features)
+	if (!state->allow_unsafe_features)
 		die(_("feature '%s' forbidden in input without --allow-unsafe-features"),
 		    feature);
 }
 
 static int parse_one_feature(struct fast_import_state *state,
-			     const char *feature,
-			     int from_stream)
+			     const char *feature)
 {
 	const char *arg;
 
 	if (skip_prefix(feature, "date-format=", &arg)) {
 		option_date_format(arg);
 	} else if (skip_prefix(feature, "import-marks=", &arg)) {
-		check_unsafe_feature(state, "import-marks", from_stream);
-		option_import_marks(state, arg, from_stream, 0);
+		check_unsafe_feature(state, "import-marks");
+		option_import_marks(state, arg, 1, 0);
 	} else if (skip_prefix(feature, "import-marks-if-exists=", &arg)) {
-		check_unsafe_feature(state, "import-marks-if-exists", from_stream);
-		option_import_marks(state, arg, from_stream, 1);
+		check_unsafe_feature(state, "import-marks-if-exists");
+		option_import_marks(state, arg, 1, 1);
 	} else if (skip_prefix(feature, "export-marks=", &arg)) {
-		check_unsafe_feature(state, feature, from_stream);
+		check_unsafe_feature(state, feature);
 		option_export_marks(state, arg);
 	} else if (!strcmp(feature, "alias")) {
 		; /* Don't die - this feature is supported */
@@ -3924,7 +3922,7 @@ static void parse_feature(struct fast_import_state *state, const char *feature)
 	if (state->seen_data_command)
 		die(_("got feature command '%s' after data command"), feature);
 
-	if (parse_one_feature(state, feature, 1))
+	if (parse_one_feature(state, feature))
 		return;
 
 	die(_("this version of fast-import does not support feature %s."), feature);
-- 
2.55.0.530.gdb3615d990.dirty

