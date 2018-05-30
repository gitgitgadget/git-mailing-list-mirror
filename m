Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0BE91F42D
	for <e@80x24.org>; Wed, 30 May 2018 21:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932438AbeE3VHF (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 17:07:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44750 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932429AbeE3VHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 17:07:00 -0400
Received: by mail-wr0-f194.google.com with SMTP id y15-v6so30885372wrg.11
        for <git@vger.kernel.org>; Wed, 30 May 2018 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lcfYWfB4xAgfNNhN5e6LEvGrsutVeSxFLNuXaMTiBCQ=;
        b=ZSWc8Eh/muBpbwhGo967zDxeS4HM4Mkap1NQWCTEE5cUM12uSAg2RCruk9UDLQkoHM
         IGcylHo7rGvs5gfpQzYPbwzRdNr7/GyWhqGUDujx66Eu4iNhM1quv3+AP10PbBC5uIPo
         QsJ4X6rQ0WdjlnujqxnjbmkIm2Gcqp7RwkCJNFB2jG1QjsCTgdjAXQTYjwh0HG3uXVIQ
         YVlo7zW93mv7E2d+ATn7RA8svWLvRo7OKg8vFxn3YErEGeZwOiDeQU2oqIAYcGQJhd3R
         JqroXUaqZL7Z9nS5BsToJRIVvRBz/NSPEKIMt5XKTO69KVwJp5kzTO3nHy4AhXOt0cgg
         Lo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lcfYWfB4xAgfNNhN5e6LEvGrsutVeSxFLNuXaMTiBCQ=;
        b=cjnT5Mo/DpfDU0lcTibx6HjicWjdoAihLM+U/I4jXKXZlTw+VYIZRqYiFjdDkqYeoV
         A/LvgtgqI5ywPRXJeAH2w0yWf/10xoWF7ytCgZuIYAB52iVxAUV/ojrB3yQuXSwiAzU6
         BUw6j/t5760ubLmW1S4xh+gFqcsAm31WTMdkRwm/fter8w6XOBF++b/b6QpmWrmQleHk
         dAY/lxPTelEv1Jxs0eqIyr6ngYeaFKXK9Sl4SmkpLk7GNi7m9gSOttY8tMmbAqIh1v5Z
         2uuGAAruptPaeb8ztu75Lbi7d3nZmd2+WqounTnshVzEo0fYo+REBzfCchDnT84MDn5P
         eeEA==
X-Gm-Message-State: ALKqPweAVayudQW/owGZrYNt6obRU1VwzaSZQ/IDINAanZ3XthiicbcI
        xcUKNrso+lCERb+ZOVJxwNGtw7y1
X-Google-Smtp-Source: ADUXVKKWDExkTEJLq0edZppHrFWxXSSV68mj701i6K1n9ZYz0wVMOWhwnWWwp/SZZVxtH3z8I8c7BQ==
X-Received: by 2002:adf:f546:: with SMTP id j6-v6mr2988682wrp.241.1527714419214;
        Wed, 30 May 2018 14:06:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o16-v6sm18237097wri.67.2018.05.30.14.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 14:06:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] config doc: clarify "to a terminal" in color.ui
Date:   Wed, 30 May 2018 21:06:39 +0000
Message-Id: <20180530210641.19771-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180530210641.19771-1-avarab@gmail.com>
References: <20180530210641.19771-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the documentation added when color.ui=auto was made the default
in 4c7f1819b3 ("make color.ui default to 'auto'", 2013-06-10) to
describe "auto" as kicking in when writing to the terminal or a pager,
not just to the terminal.

I had someone ask me why it was that git was writing colors with
color.ui=auto in situations where isatty(3) would return 0. The
existing documentation about that would have been true before
85fb65ed6e (""git -p cmd" to page anywhere", 2006-06-06), but since
then "auto" has always used a heuristic that isn't quite what isatty()
would return, rather it checks if we're connected to a TTY or if we're
about to emit to a pager, trusting that the pager can handle color
output.

Instead we have the color.pager variable introduced in
aa086eb813 ("pager: config variable pager.color", 2006-07-30) to
explicitly disable color output to the pager. Let's change the
documentation to reflect this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 44735dd88e..4767363519 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1288,7 +1288,9 @@ color.ui::
 	or the `--color` option. Set it to `always` if you want all
 	output not intended for machine consumption to use color, to
 	`true` or `auto` (this is the default since Git 1.8.4) if you
-	want such output to use color when written to the terminal.
+	want such output to use color when written to the terminal (as
+	determined by a call to `isatty(3)`) or to a pager (unless
+	`color.pager` is set to false).
 
 column.ui::
 	Specify whether supported commands should output in columns.
-- 
2.17.0.290.gded63e768a

