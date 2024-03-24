Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78523DDB3
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711316627; cv=none; b=cXQ8E48AmGQwddHwc/aLx/6oq+caue/iOq3zj+DMeasFRBSOYtcpBYF6o8SQrx03U7rbqT5gbHw5PSrY27cDAHXpqWShnQqor9EhbscXl4qOxOr5UN9VaJ5zmX3i2nTlyC80uZBBfG5OPKTJLxzblU9sYmTI7g2Fratvu9RBnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711316627; c=relaxed/simple;
	bh=fZ0GQJB8H2STYCtykZRaHUIl16zFnbC78ehFe7MvlIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXAkzt5yEQy9XPyQiqK4GVXuO3vETwNLF20E7/g94RGIicwhX5e6HqbgNBRH/baZYx0NL9tyErr8yYPHls6U15UV/rClKW60ThhZ5F2qAhBegEBtcqz7KPeARQ4OHGa6NnHwXZnxO7eRYq60lhrzdMwlUx+HfhrZ60tsvNugOik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnSvtx5l; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnSvtx5l"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-222b6a05bb1so2417536fac.3
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711316624; x=1711921424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=evlusR2YUYy2A6rUAg+h9l7BaEM/WTYlMPKl/7lMZ5I=;
        b=hnSvtx5lq3tHYSEb1j6yFVvU5RkQIbSantrjiWUQxtvFoMxOBVsJecSf+E402zEeDo
         3U760uOes1GDvgQhbvoHV1i+6bdNpFb5jjTWs2pnOSDYf4T3VN91n6Cjaa9tuvogwkK/
         YSOyoJFH1vToTdqCqHjZuJhYwXe13QL5WBwPibLCnIMMECJSzpPbiFfbmcwWejhr+6Sd
         bVFBw6UxQtiCfq1mNnHUowv+Xg5ANpfgWs1GjNeFe0smKRBkryyM+edOXSyAuVoNlwYz
         fzZfjwnJ67cMgyoW+svb5QGhOYQTSrhXCcsBe2GdPF92c2DfZi/iV07KkFYgN911AGOP
         2NxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711316624; x=1711921424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evlusR2YUYy2A6rUAg+h9l7BaEM/WTYlMPKl/7lMZ5I=;
        b=Hpctt3FGEAIyRHzwh1/HXlJJSEK27iOK+HepiqGGAbbkmDasDZo34xo3iaMlw+YUqc
         jUpeMMitxi4OaCPquJ3V1VHN5D2TutecEaIYnihMS1uSD/MaEofDpoDp8qsZrYJc4ZqD
         Oyfr4Hsg7xmO1yQ7HHBtODH5VUUilvZ1BuAKCj6IeiNLCBEyXJ83lcVeF4hmlYvntldP
         N6/MoJ5AXnD5eb3kjH1qmU0UNp/F2DLRu0NOyYmxJCzAYTnUyvAzy0RTgEorp17IO+4H
         PnSXj18aKkRYyuDkTrWHu1DLI+skc+e0in2on6I3oEINzP3LqOSq9lGhEIwXb+xClf47
         t77g==
X-Gm-Message-State: AOJu0YyDy/JNZl1sPf9aYCU9t8GxPloVqJCDxjmSTQNXj5Tz/vbPMrdu
	XLG+1sKnWFiPAlub/5Hi/Ofo6smpY1HTF8m884uAn5++XOEtD451YO98xzCB
X-Google-Smtp-Source: AGHT+IHK09NlB61hF9uXV1OV01nys0uLUD2H2jt7aI0ws0QzjyTL8P/JskrcjXkX6aUlwOVCStAx0g==
X-Received: by 2002:a05:6871:80c:b0:21e:f15e:836b with SMTP id q12-20020a056871080c00b0021ef15e836bmr6164181oap.20.1711316623825;
        Sun, 24 Mar 2024 14:43:43 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id pl9-20020a0568704e0900b0022a31bec4a5sm406529oab.32.2024.03.24.14.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:43:43 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>
Subject: [PATCH] pretty: find pretty formats case-insensitively
Date: Sun, 24 Mar 2024 16:43:09 -0500
Message-ID: <20240324214316.917513-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User-defined pretty formats are stored in config, which is meant to use
case-insensitive matching for names as noted in config.txt's 'Syntax'
section:

    All the other lines [...] are recognized as setting variables, in
    the form 'name = value' [...]. The variable names are
    case-insensitive, [...].

When a user specifies one of their format aliases with an uppercase in
it, however, it is not found.

    $ git config pretty.testAlias %h
    $ git config --list | grep pretty
    pretty.testalias=%h
    $ git log --format=testAlias -1
    fatal: invalid --pretty format: testAlias
    $ git log --format=testalias -1
    3c2a3fdc38

This is true whether the name in the config file uses any uppercase
characters or not.

Normalize the format name specified via `--format` to lowercase so that
format aliases are found case-insensitively. The format aliases loaded
from config against which this name is compared are already normalized
to lowercase since they are loaded through `git_config()`.

`xstrdup_tolower` is used instead of modifying the string in-place to
ensure that the error shown to the user when the format is not found has
the same casing that the user entered. Otherwise, the mismatch may be
confusing to the user.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 pretty.c                      | 12 +++++++++++-
 t/t4205-log-pretty-formats.sh |  7 +++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index cf964b060c..78ec7a75ff 100644
--- a/pretty.c
+++ b/pretty.c
@@ -168,10 +168,20 @@ static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
 
 static struct cmt_fmt_map *find_commit_format(const char *sought)
 {
+	struct cmt_fmt_map *result;
+	char *sought_lower;
+
 	if (!commit_formats)
 		setup_commit_formats();
 
-	return find_commit_format_recursive(sought, sought, 0);
+	/*
+	 * The sought name will be compared to config names that have already
+	 * been normalized to lowercase.
+	 */
+	sought_lower = xstrdup_tolower(sought);
+	result = find_commit_format_recursive(sought_lower, sought_lower, 0);
+	free(sought_lower);
+	return result;
 }
 
 void get_commit_format(const char *arg, struct rev_info *rev)
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e3d655e6b8..321e305979 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -59,6 +59,13 @@ test_expect_success 'alias user-defined format' '
 	test_cmp expected actual
 '
 
+test_expect_success 'alias user-defined format is matched case-insensitively' '
+	git log --pretty="format:%h" >expected &&
+	git config pretty.testalias "format:%h" &&
+	git log --pretty=testAlias >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'alias user-defined tformat with %s (ISO8859-1 encoding)' '
 	git config i18n.logOutputEncoding $test_encoding &&
 	git log --oneline >expected-s &&
-- 
2.43.2

