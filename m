Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE7B1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 15:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGLPDs (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 11:03:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41796 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfGLPDs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 11:03:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so4426310pff.8
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U27ZmKKHtWAIWeBzhMuIcj29oghVPrQelDSsP8Ms1zs=;
        b=AMmlVx59K2E6cz/b0ezo9CQvK1G+vYbDtKia5pGuF8dR4fm4bnl9pOomjFYD+gOfQ8
         AZi0hFBvAHrbiDeJAUM5u44Fta7g9rgqDwx+6POGQg8Jz8vUngR8PGgGrmFr54iVU9Ig
         ucVjAvpt+rwDA0hb2P4Ik+aQaJoicJH1A5BSN74g25PmpcBBiMeAookh5L6nKTpxwAaq
         1VZnyZfoXDTH66BcjUg6243UBzVDtefdlkSna1100+7g+6xQpjpPvpORFN4qJ7CrsDXU
         CjLUxN7T+ey4QXeasAEQska0p3glZbReGDBwBRtmjXKl/mkS3kVkUCGvsqNC0OIw2Jzb
         U8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U27ZmKKHtWAIWeBzhMuIcj29oghVPrQelDSsP8Ms1zs=;
        b=mmhd6tmtdMC5b+0Om6+FkhIAmh2B7acg6fSR6U47R+b3GLCuwosVqQPKHGjrgsx3RZ
         Bk0sb1Uun7xOfNON5VueRdPcsHo11aC2bMxdcCW7h9+af+/6cOFe0eK9s0ZHhdYbZJe7
         SHTDnlySK9JxZ8PQRNPmS1hLX9b7YlJkRO3rOo9dhI4pJjdMEYC2jZazgPLbdk5nCQzg
         +6Dek7VQhYVegGR6IdzYVJ9cBOCYp2zbQgqkfFcnHf9nCGi47D0y7J0WbOaQlsNlvhYg
         S/J88jpdc07wjQKvAJe2fkFwA+AhRNbO7UjyB9u3S/W7S7dVuUzUSd8Zu1BXneR4ZebT
         BkCA==
X-Gm-Message-State: APjAAAXbWBUKkipEfjIzAfqgf3lbt593E4POGJqOyzea9pk0tVZ2Qrik
        gRBwWtBICvaOSFxDHcl/36aeZQBa
X-Google-Smtp-Source: APXvYqz6fWLhQnGfAb+TSrWhanjf70fHHB5GDYV3Rao5qYrL4cWpIvb67BqP/CI/xHxRSOlAvHVlWg==
X-Received: by 2002:a63:2026:: with SMTP id g38mr7345883pgg.172.1562943827164;
        Fri, 12 Jul 2019 08:03:47 -0700 (PDT)
Received: from localhost.localdomain (92.18.24.136.in-addr.arpa. [136.24.18.92])
        by smtp.googlemail.com with ESMTPSA id s67sm9894185pjb.8.2019.07.12.08.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Jul 2019 08:03:46 -0700 (PDT)
From:   Varun Naik <vcnaik94@gmail.com>
To:     git@vger.kernel.org
Cc:     Varun Naik <vcnaik94@gmail.com>
Subject: [PATCH] reset: unstage empty deleted ita files
Date:   Fri, 12 Jul 2019 08:02:35 -0700
Message-Id: <20190712150235.12633-1-vcnaik94@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to delete a committed file from the index and then add it
as intent-to-add. After `git reset HEAD`, the file should be identical
in the index and HEAD. This patch provides the desired behavior even
when the file is empty in the index.

Signed-off-by: Varun Naik <vcnaik94@gmail.com>
---
My first patch!

According to an old thread on the mailing list[0], this issue is known,
but it looks like people overlooked the fix that I'm making. Basically,
this one line causes diff-lib.c:do_oneway_diff() to call show_modified()
instead of diff_index_show_file() for ita files.

An alternative to the last line of the test code is running `git status
--porcelain=v2` and then inspecting the output. I can adjust that if
necessary.

Unfortunately, "restore" has a similar problem, but it follows a
different code path into read-cache.c rather than diff-lib.c, and there
does not seem to be a similar one-line fix.

[0]: https://public-inbox.org/git/CACsJy8Bov1asw+_J_fbhKqigM==xNPi8itDGkhibkYVch4pvmQ@mail.gmail.com/

 builtin/reset.c  |  1 +
 t/t7102-reset.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index 26ef9a7bd0..47a088f4b7 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -163,6 +163,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.format_callback_data = &intent_to_add;
 	opt.flags.override_submodule_config = 1;
 	opt.repo = the_repository;
+	opt.ita_invisible_in_index = 1;
 
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 97be0d968d..250fc1c890 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -566,4 +566,15 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'reset --mixed removes deleted intent-to-add file from index' '
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	git reset HEAD nonempty empty &&
+	git diff --staged --exit-code
+'
+
 test_done
-- 
2.22.0

