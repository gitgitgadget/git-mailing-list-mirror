Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8233BC32789
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 19:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiHWTX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiHWTXG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 15:23:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D86E134CBF
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:04:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k17so7604840wmr.2
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=M/2g7wHp52k6Rtik7/3DhHa3bU30ZQdpTtM1UecamjY=;
        b=BclyCqVpvuH7H3rUS3XOoYpAicNJzCd8Hajq10oOulIeJex2ThnczZj2KUYmUM0rjG
         R19WY/NSR4Sh4Jr7UsgT/pJ2PSAZvRTpJVqzPVhhbnj/YKZWMQ2ist2vCek0sJ4AeLPi
         wtbXFCoKqEF3oLSscX1t+v/28rbLfooc5S6394at1CoAPA8E3heIboV97L9NdSdMEj7S
         KFe1YFxATbb7E8hXBctfzpFTo99dmfkwj7Ey79yQ7aXe2qKLYLIjjl/2cr+/Po2RXSTG
         mV4nIPhAdJEWoQyYRSkbV65VtzzFvOPWStHa+9uf9eZbz1GxZS1WkIFE590nAQ7uOtGi
         XpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=M/2g7wHp52k6Rtik7/3DhHa3bU30ZQdpTtM1UecamjY=;
        b=my0ZUideC7PqCk7G65VNnTed3KKcSneWyzKR4XRi5TavS8EP0djqwH2xzoiWKzlG94
         b3LsJ3vWEIIztHIqEXN8dI1Sjh9rp6Aq2/3OR+7loVvzW5IHUCc+dJEF16IGzSm5Pk3T
         yNMlwXp+Riyiu/d49iYrw2aNWPQzc3Fpslgb1RIi2W5tdNGVfKIPX2nHh1JtVb22mtv0
         y0Hb7kBQvGNTCpD+PflQRJYEcVRxkfw6yRkjDwAwNJSlse3WoQ5tvfWu0wt8M4RqMnQ4
         gUwSGheSuyFq/1ibKmnRiqqIpigPxWBHIu98Jb9eh37UTeU9iMfwsOlPeWrkcVJgoKiW
         ZFsA==
X-Gm-Message-State: ACgBeo2JUIvUj28+gxt4ExebeX4BDSniNbgbvuHWCBO+E1bqgDSkwub8
        sqCfdegSRnYp2TKv7mkAkTW/g9z9x38=
X-Google-Smtp-Source: AA6agR6UFhnABT8DI5d8SFyR1qKLVJKFmx/S+7aHYvkVDGkfzIxWSnrNwBXPWxWzTzHwg+muyCFA3w==
X-Received: by 2002:a05:600c:3846:b0:3a6:5292:f8af with SMTP id s6-20020a05600c384600b003a65292f8afmr2944949wmr.50.1661277874062;
        Tue, 23 Aug 2022 11:04:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b003a61306d79dsm22786647wms.41.2022.08.23.11.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:04:33 -0700 (PDT)
Message-Id: <b07f85a035954bb9145a0fe034e6f17aeb128f52.1661277870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 18:04:29 +0000
Subject: [PATCH 2/3] add -p: gracefully ignore unparseable hunk headers in
 colored diffs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In
https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com,
Phillipe Blain reported that the built-in `git add -p` command fails
when asked to use [`diff-so-fancy`][diff-so-fancy] to colorize the diff.

The reason is that this tool produces colored diffs with a hunk header
that does not contain any parseable `@@ ... @@` line range information,
and therefore we cannot detect any part in that header that comes after
the line range.

Let's punt for now and simply show nothing apart from the line range in
that case.

[diff-so-fancy]: https://github.com/so-fancy/diff-so-fancy

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                | 15 ++++++---------
 t/t3701-add-interactive.sh |  9 +++++++++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 509ca04456b..f2fffe1af02 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -357,16 +357,13 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
 	eol = memchr(line, '\n', s->colored.len - hunk->colored_start);
 	if (!eol)
 		eol = s->colored.buf + s->colored.len;
-	p = memmem(line, eol - line, "@@ -", 4);
-	if (!p)
-		return error(_("could not parse colored hunk header '%.*s'"),
-			     (int)(eol - line), line);
-	p = memmem(p + 4, eol - p - 4, " @@", 3);
-	if (!p)
-		return error(_("could not parse colored hunk header '%.*s'"),
-			     (int)(eol - line), line);
 	hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
-	header->colored_extra_start = p + 3 - s->colored.buf;
+	p = memmem(line, eol - line, "@@ -", 4);
+	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3)))
+		header->colored_extra_start = p + 3 - s->colored.buf;
+	else
+		/* could not parse colored hunk header, showing nothing */
+		header->colored_extra_start = hunk->colored_start;
 	header->colored_extra_end = hunk->colored_start;
 
 	return 0;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b40d1c94d99..7e3c1de71f5 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -766,6 +766,15 @@ test_expect_success 'detect bogus diffFilter output' '
 	force_color test_must_fail git add -p <y
 '
 
+test_expect_success 'gracefully fail to parse colored hunk header' '
+	git reset --hard &&
+
+	echo content >test &&
+	test_config interactive.diffFilter "sed s/@@/XX/g" &&
+	printf y >y &&
+	force_color git add -p <y
+'
+
 test_expect_success 'diff.algorithm is passed to `git diff-files`' '
 	git reset --hard &&
 
-- 
gitgitgadget

