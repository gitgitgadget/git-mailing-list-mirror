Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D7A20248
	for <e@80x24.org>; Mon, 25 Mar 2019 21:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfCYVlk (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 17:41:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43324 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbfCYVlk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 17:41:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id d26so8911421ede.10
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 14:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+eu+jYqaz2y0yXgdpoQz4S0wZNUQdFEE0zmHNHrw/vc=;
        b=tlcDs7P+0cZK16C7v8L1brPYmBK3i5epR0GwgtKYePMEffSnIIOhAOda8MC1DyVhth
         mUf58Drejv1NnBtFgb4/a4TiM1THuj87Be4hBAmToRLviqpCjVka+hrHIjf3z67hAf1b
         aWtMMpoN026w71QrT1ffpBFzyFSSgKYedwyCIT0lG00DzZ6O2f27pvDpHXE84HIwtGJ5
         NotV622Au9b6DmgWJeu7AtJbe2pziCzqCN4CfHVvRkDfi31z5rUx0kfQrb2TpF/Iah3W
         RsdF86rv3lL/3Aq0zUFvFhXTfd9enMMkDKgdo2iHkDzSHevIUwd89t/dqf7LGVshDVBr
         QZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+eu+jYqaz2y0yXgdpoQz4S0wZNUQdFEE0zmHNHrw/vc=;
        b=GzZtuOV8yfEouvzMqY/GsBny3JdD2HfS5jo1dpPJ4IuSCMQ9JQk2ByBNbOMSp6Nhq5
         S30O5eUEuy3w4UVaSL/OLKskT6j+sa3zcABeNUMFvu70hhdEkCPUL1rINN4cIZM8ugZj
         kzgux6Kd7qMH6S+qJiwCAfVrcgsYUmjSQjDb1NSXhWNWzjPLfxauZgJdi7/TqzudKGfF
         95iraWCHIj0OF5fTmqVOwX/0SaaQwT6Ie6chiywLSQw2NWGtfwhDJm9Rsn+87caUEjPX
         WuvQshxIbbgmzyPAdVV7EZPvMXzC205ligbk68ufktt0zJlTmpeSGg98RgA5HRitMQEd
         at4w==
X-Gm-Message-State: APjAAAVJ4by+XX6WPzZ5BoyooSsSStSuURgJcLG0rDhWyFjTIcjZtNUE
        sgRLtKLwNKAabJsGqJEy+fWqVrpc
X-Google-Smtp-Source: APXvYqy6Qv+0mOAB0PJVakLj/4wKo1GxiQLPKXPCCWJhUTMjJMU0d/fQVV7mtIkkUeyWq9KRVvOzOA==
X-Received: by 2002:a50:be05:: with SMTP id a5mr17515198edi.87.1553550098231;
        Mon, 25 Mar 2019 14:41:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d37sm6109088ede.79.2019.03.25.14.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:41:37 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:41:37 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 21:41:32 GMT
Message-Id: <0dad6abd2f949b81d4d763b9d8439853a35d3eab.1553550094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.162.v2.git.gitgitgadget@gmail.com>
References: <pull.162.git.gitgitgadget@gmail.com>
        <pull.162.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/5] check-docs: really look at the documented commands
 again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As part of the `check-docs` target, we verify that commands that are
documented are actually in the current list of commands to be built.

However, this logic broke in 5fafce0b78 (check-docs: get documented
command list from Makefile, 2012-08-08), when we tried to make the logic
safer by not looking at the files in the worktree, but at the list of
files to be generated in `Documentation/Makefile`. While this was the
right thing to do, it failed to accommodate for the fact that `make -C
Documentation/ print-man1`, unlike `ls Documentation/*.txt`, would *not*
print lines starting with the prefix `Documentation/`.

At long last, let's fix this.

Note: This went undetected due to a funny side effect of the
`ALL_PROGRAMS` variable starting with a space. That space, together with
the extra space we inserted before `$(ALL_PROGRAMS)` in the

	case " $(ALL_PROGRAMS)" in
	*" $$cmd ")
		[...]

construct, is responsible that this case arm is used when `cmd` is empty
(which was clearly not intended to be the case).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 537493822b..76904f07fe 100644
--- a/Makefile
+++ b/Makefile
@@ -3099,7 +3099,7 @@ check-docs::
 		    -e 's/^/listed /' command-list.txt; \
 		$(MAKE) -C Documentation print-man1 | \
 		grep '\.txt$$' | \
-		sed -e 's|Documentation/|documented |' \
+		sed -e 's|^|documented |' \
 		    -e 's/\.txt//'; \
 	) | while read how cmd; \
 	do \
-- 
gitgitgadget

