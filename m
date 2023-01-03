Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8B7C46467
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 08:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbjACIVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 03:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbjACIVG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 03:21:06 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FEEFF1
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 00:21:03 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso12312343wmq.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 00:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8+/gjab5poe6CNlZJIhOGbtCP7HHJl5wDu4R/ZlK78=;
        b=dtL1xSBfUiICWwFS/VAR7seiEpxZu1pvNJBRSHYJvcQPg14w4D8TnP4Zx1MFY0mfRk
         yJ91E4VJT8KavcZBxlUt6MTx2amXCG7B+HpcclMItoTOKzwJDj95i2oeSrJ5bMJn5s3h
         8NLJMQvmWqA12CpmwW7ze1QudouoRHNp7cytC7rI30gn7gr+8c3zfNDbuP1KWQujlM6f
         j5YVvlbSOJeNI8tvwSoBvFu2mveoJvUomEmDORlaBvP5Q69MQOVAszdLH49i301MbwK3
         i63jwgxsQYwA9Ikom/hFrE7NWOBMKsPf1Wg+ARyFgizkKi5yNBhfEqyXUJeKt4KtLVbi
         uIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8+/gjab5poe6CNlZJIhOGbtCP7HHJl5wDu4R/ZlK78=;
        b=OehXadQ4KHohQIZAQaIm2bgohTfofMIlM2sA0uA6zZlS2X7H21j8RyBS8jJFsJICUo
         3Ru8G5SqDMmso9mNmtojlRFk8fBEUZp5SRHN6SuqFQzpvXZVHiSpvCcTeEOAq/ASH5XK
         flV5WUlisQLnHVV58O57k2QXWYzERINjhjAYuJQYlBxvKmsDwfEK/OpirUbiIaFPr3CX
         7ZHNfIyCLDNwL8GocqnfbLYkt/E+k0C/ZfqPGCoRHbTWHqwxoHJOncUEpoVP+nymEibi
         zyj5DEojI+ES8nXq2fkzrpS06kAEnReLRgZlJ9Z8gSBmoR0tGVywX1eiQAZlvOdTuguU
         Nz1g==
X-Gm-Message-State: AFqh2kptMxzsfEqgaWuMopiihjww+9bZgOEicU1jMOOwy/ekv9hE5TLy
        8To6fZuI0YkUTE/U6qLFWivrWq+bkRQ=
X-Google-Smtp-Source: AMrXdXtnpYk9LBSNhy8yztRgcY4e7PYWj3yi1kAPcZvqidkk3nIiLspnPPpsKbRiiu6uuYDHkxK4eQ==
X-Received: by 2002:a05:600c:5554:b0:3cf:8e5d:7184 with SMTP id iz20-20020a05600c555400b003cf8e5d7184mr31006358wmb.28.1672734061402;
        Tue, 03 Jan 2023 00:21:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003cfd4e6400csm44850662wms.19.2023.01.03.00.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 00:21:00 -0800 (PST)
Message-Id: <pull.1446.v2.git.1672734059938.gitgitgadget@gmail.com>
In-Reply-To: <pull.1446.git.1671546459151.gitgitgadget@gmail.com>
References: <pull.1446.git.1671546459151.gitgitgadget@gmail.com>
From:   "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Jan 2023 08:20:59 +0000
Subject: [PATCH v2] dir: check for single file cone patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, William Sprent <williams@unity3d.com>,
        William Sprent <williams@unity3d.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Sprent <williams@unity3d.com>

The sparse checkout documentation states that the cone mode pattern set
is limited to patterns that either recursively include directories or
patterns that match all files in a directory. In the sparse checkout
file, the former manifest in the form:

    /A/B/C/

while the latter become a pair of patterns either in the form:

    /A/B/
    !/A/B/*/

or in the special case of matching the toplevel files:

    /*
    !/*/

The 'add_pattern_to_hashsets()' function contains checks which serve to
disable cone-mode when non-cone patterns are encountered. However, these
do not catch when the pattern list attempts to match a single file or
directory, e.g. a pattern in the form:

    /A/B/C

This causes sparse-checkout to exhibit unexpected behaviour when such a
pattern is in the sparse-checkout file and cone mode is enabled.
Concretely, with the pattern like the above, sparse-checkout, in
non-cone mode, will only include the directory or file located at
'/A/B/C'. However, with cone mode enabled, sparse-checkout will instead
just manifest the toplevel files but not any file located at '/A/B/C'.

Relatedly, issues occur when supplying the same kind of filter when
partial cloning with '--filter=sparse:oid=<oid>'. 'upload-pack' will
correctly just include the objects that match the non-cone pattern
matching. Which means that checking out the newly cloned repo with the
same filter, but with cone mode enabled, fails due to missing objects.

To fix these issues, add a cone mode pattern check that asserts that
every pattern is either a directory match or the pattern '/*'. Add a
test to verify the new pattern check and modify another to reflect that
non-directory patterns are caught earlier.

Signed-off-by: William Sprent <williams@unity3d.com>
---
    dir: check for single file cone patterns
    
    Resubmitting this without the superfluous double negation of the
    'strcmp' output.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1446%2Fwilliams-unity%2Fws%2Fsparse-checkout-pattern-match-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1446/williams-unity/ws/sparse-checkout-pattern-match-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1446

Range-diff vs v1:

 1:  cfb4b75c378 ! 1:  d5406e62f6f dir: check for single file cone patterns
     @@ dir.c: static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_
       	}
       
      +	if (!(given->flags & PATTERN_FLAG_MUSTBEDIR) &&
     -+	    !!strcmp(given->pattern, "/*")) {
     ++	    strcmp(given->pattern, "/*")) {
      +		/* Not a cone pattern. */
      +		warning(_("unrecognized pattern: '%s'"), given->pattern);
      +		goto clear_hashmaps;


 dir.c                              |  7 +++++++
 t/t1091-sparse-checkout-builtin.sh | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index fbdb24fc819..4e99f0c868f 100644
--- a/dir.c
+++ b/dir.c
@@ -732,6 +732,13 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		goto clear_hashmaps;
 	}
 
+	if (!(given->flags & PATTERN_FLAG_MUSTBEDIR) &&
+	    strcmp(given->pattern, "/*")) {
+		/* Not a cone pattern. */
+		warning(_("unrecognized pattern: '%s'"), given->pattern);
+		goto clear_hashmaps;
+	}
+
 	prev = given->pattern;
 	cur = given->pattern + 1;
 	next = given->pattern + 2;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index b563d6c263e..627267be153 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -238,7 +238,7 @@ test_expect_success 'cone mode: match patterns' '
 test_expect_success 'cone mode: warn on bad pattern' '
 	test_when_finished mv sparse-checkout repo/.git/info/ &&
 	cp repo/.git/info/sparse-checkout . &&
-	echo "!/deep/deeper/*" >>repo/.git/info/sparse-checkout &&
+	echo "!/deep/deeper/*/" >>repo/.git/info/sparse-checkout &&
 	git -C repo read-tree -mu HEAD 2>err &&
 	test_i18ngrep "unrecognized negative pattern" err
 '
@@ -667,6 +667,15 @@ test_expect_success 'pattern-checks: starting "*"' '
 	check_read_tree_errors repo "a deep" "disabling cone pattern matching"
 '
 
+test_expect_success 'pattern-checks: non directory pattern' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/deep/deeper1/a
+	EOF
+	check_read_tree_errors repo deep "disabling cone pattern matching" &&
+	check_files repo/deep deeper1 &&
+	check_files repo/deep/deeper1 a
+'
+
 test_expect_success 'pattern-checks: contained glob characters' '
 	for c in "[a]" "\\" "?" "*"
 	do

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
