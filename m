Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AD5E1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 23:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfKQXQO (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 18:16:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54984 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfKQXQO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 18:16:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id z26so15419507wmi.4
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 15:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=9xk0Ci6DMw2Udxn3VhQCnl8SoCduP5YrP7gtQJYJU+k=;
        b=QucswRPwi1OcV1PLUU69khwaE1paMw5op4YVWiZbC8L7dpXZdahh7waKGgADyriO8Y
         B5zvzSEAk0I5qQfWyl27pJyoHOhGjjaA2SdY8knhvIEjlDOlipe/0LlgjP8c6MsQn2vv
         oDQXSM/KxEYYbtkcwSv48kHgPdVMP99712AK7sZ8udohfeRlkxrmFNfhXphJkFdkBRdo
         Mz27PbyP7r/0Eq+jlKTQqz5J9AvNzHeBzjR/YdUIYaPX+8BjcdO14aNFuHAH7cPRtbTj
         FihYOMFZk4CMVCbrfCaZmdPwGpUyts4PqQlxPM4B6x91fg1fBF0dvPJSQd3lHVEjx82k
         zh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=9xk0Ci6DMw2Udxn3VhQCnl8SoCduP5YrP7gtQJYJU+k=;
        b=J4x3DCGHKTDRKghuTOsxNufxoCunSvSQEUoqhw3zxTK9MTbkW3Bj169KX6jXkEnZUF
         hbnIxBNEyuNV5SHUWLpV3G0d2Ml3foMSm1eH2ulp9CX4A2fruCKv9JwOFHwlbWxeNq0k
         5yiWM+FmWw/8cHuIvqDtRf1LJjdTgYB4rQ2bLkOuWi/J3b2JwRM+80slAi+L9wcqQU8J
         RCLc8pdEJqY9Ug0U4lKXScwdUy5r23JRsfzAdUXRp1U+5E2ke1LsW3FFQAgwBGevEmRk
         q4vMk4As9CqJBg/Y/mL6uHD4n9LW7RMQl+lUZ9fF2ZV28px2DX0SByLLZJ6fSSfS4hpk
         Eypw==
X-Gm-Message-State: APjAAAW3kvev0GsWZhZ+Q5eLPEfVWkNuxdPisHydXL/aLn7EQXbxxkNZ
        t/vcOA3TUWvTDX9a06NR6O9HjVEK4N0=
X-Google-Smtp-Source: APXvYqzJtf/ZuX6JLIZOB+z+kP72mQoksIWA1SNvIcv7tGjib+Wr+jNN2jfe0M6DIyHKw48L6s4z2Q==
X-Received: by 2002:a1c:b1c3:: with SMTP id a186mr26900217wmf.10.1574032573160;
        Sun, 17 Nov 2019 15:16:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm19815726wrq.51.2019.11.17.15.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 15:16:12 -0800 (PST)
Message-Id: <adc22c8ba2f14ee541f61ea06a5423deb3613e78.1574032570.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.327.v2.git.1574032570.gitgitgadget@gmail.com>
References: <pull.327.git.gitgitgadget@gmail.com>
        <pull.327.v2.git.1574032570.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 23:16:10 +0000
Subject: [PATCH v2 2/2] rebase -r: let `label` generate safer labels
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

The `label` todo command in interactive rebases creates temporary refs
in the `refs/rewritten/` namespace. These refs are stored as loose refs,
i.e. as files in `.git/refs/rewritten/`, therefore they have to conform
with file name limitations on the current filesystem in addition to the
accepted ref format.

This poses a problem in particular on NTFS/FAT, where e.g. the colon,
double-quote and pipe characters are disallowed as part of a file name.

Let's safeguard against this by replacing not only white-space
characters by dashes, but all non-alpha-numeric ones.

However, we exempt non-ASCII UTF-8 characters from that, as it should be
quite possible to reflect branch names such as `↯↯↯` in refs/file names.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              | 20 +++++++++++++++++++-
 t/t3430-rebase-merges.sh |  6 ++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 85c66f489f..fece07b680 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4471,8 +4471,26 @@ static const char *label_oid(struct object_id *oid, const char *label,
 	} else {
 		struct strbuf *buf = &state->buf;
 
+		/*
+		 * Sanitize labels by replacing non-alpha-numeric characters
+		 * (including white-space ones) by dashes, as they might be
+		 * illegal in file names (and hence in ref names).
+		 *
+		 * Note that we retain non-ASCII UTF-8 characters (identified
+		 * via the most significant bit). They should be all acceptable
+		 * in file names. We do not validate the UTF-8 here, that's not
+		 * the job of this function.
+		 */
 		for (; *label; label++)
-			strbuf_addch(buf, isspace(*label) ? '-' : *label);
+			if ((*label & 0x80) || isalnum(*label))
+				strbuf_addch(buf, *label);
+			/* avoid leading dash and double-dashes */
+			else if (buf->len && buf->buf[buf->len - 1] != '-')
+				strbuf_addch(buf, '-');
+		if (!buf->len) {
+			strbuf_addstr(buf, "rev-");
+			strbuf_add_unique_abbrev(buf, oid, default_abbrev);
+		}
 		label = buf->buf;
 
 		if ((buf->len == the_hash_algo->hexsz &&
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 9efcf4808a..f728aba995 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -468,4 +468,10 @@ test_expect_success '--rebase-merges with strategies' '
 	test_cmp expect G.t
 '
 
+test_expect_success '--rebase-merges with commit that can generate bad characters for filename' '
+	git checkout -b colon-in-label E &&
+	git merge -m "colon: this should work" G &&
+	git rebase --rebase-merges --force-rebase E
+'
+
 test_done
-- 
gitgitgadget
