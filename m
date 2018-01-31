Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE531F576
	for <e@80x24.org>; Wed, 31 Jan 2018 09:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeAaJbP (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 04:31:15 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38848 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbeAaJbM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 04:31:12 -0500
Received: by mail-pf0-f193.google.com with SMTP id k19so12010603pfj.5
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 01:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fX/Q2ZGCX1y+rpMAbESeDkz5leJicny8KqgtxPIUBrA=;
        b=Hhorg8rOQ3hGHJeYcWIxt2Glqp+oVwI3LeWlXcRVV2duMP9YcEbeHMGcEW6VjveegI
         lH6FVG5W/HdAsOa1+KpkXWOYTyP5/2KO8j1yc0duoaFusjGJMQoNbs9eW4swwWuPM1+F
         8jO1/m8pHtOd6gHspapSQ+aulqHTZg7J66/08w5Pa3Z3W2ZsfBqyHPSxDgZzm1u8yv9P
         wK17EWG3FaaEDHXo/h5utFlEblSvFmy1jU2v+6JDDigq7G12f2fYEAqcuvZPqL+nsucU
         aP9QTRuIzyN5QuXAts580Q+yqpwsvo3nk6j4uwdDsjTGWzc0VjDbVoZVuHnRPQwFGGLZ
         kXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fX/Q2ZGCX1y+rpMAbESeDkz5leJicny8KqgtxPIUBrA=;
        b=tZ1BtLCzW8OCx8AOVxJ7L6l3FcjJ3CT5IvYA4atjIQ2jUqanwt1SxxSDa/FyiG1gTe
         S65ufWSFu35upkn9CxYhG2LX49pd15jT89qqFGnouehecZlxGfkk6NoJKT56d9Yb++pc
         A+HTgnmeuaxWzMf5pLgXXp5BtPitxMhr2Z8As3MeaopMPoqohRgDQgOMC+Wm8LgDHrqv
         YLsH7+ejbck/kDiS873F++meXLBG1ZqkernkRuW4hFSsdISUesD1/LJ+L5WvkPQ/i8ec
         7r8RzFn9K59ft7+2gm4OOpDrge2EtTvazMpDM2oFItdn2fIQZqbN5CbAqpxPjJG91Jv8
         Bp0A==
X-Gm-Message-State: AKwxytcYJ/q/WnhhhcPg7D7YRiIsdC/jT1bGwok/hS6JKwOMsI4lJpCw
        aThj7/mbKiIk1sPpM6WAGRmYqg==
X-Google-Smtp-Source: AH8x225ywUABxftWIHhqJGPHAZz8nN2LT0/qPoKzmUaB+Vs6aX8yJ5oxalxYHdxLO/S8Qw6DZRB79A==
X-Received: by 2002:a17:902:1a2:: with SMTP id b31-v6mr26320175plb.28.1517391072004;
        Wed, 31 Jan 2018 01:31:12 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id g13sm48481156pfe.50.2018.01.31.01.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 01:31:11 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 16:31:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        tim@tim-landscheidt.de,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] gitignore.txt: elaborate shell glob syntax
Date:   Wed, 31 Jan 2018 16:30:49 +0700
Message-Id: <20180131093051.15525-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131093051.15525-1-pclouds@gmail.com>
References: <20180126095520.919-1-pclouds@gmail.com>
 <20180131093051.15525-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`fnmatch(3)` is a great mention if the intended audience is
programmers. For normal users it's probably better to spell out what
a shell glob is.

This paragraph is updated to roughly tell what the main wildcards are
supposed to do. All the details are still hidden away behind the
`fnmatch(3)` wall because bringing the whole specification here may be
too much.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/gitignore.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 63260f0056..0f4b1360bd 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -102,12 +102,11 @@ PATTERN FORMAT
    (relative to the toplevel of the work tree if not from a
    `.gitignore` file).
 
- - Otherwise, Git treats the pattern as a shell glob suitable
-   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
-   wildcards in the pattern will not match a / in the pathname.
-   For example, "Documentation/{asterisk}.html" matches
-   "Documentation/git.html" but not "Documentation/ppc/ppc.html"
-   or "tools/perf/Documentation/perf.html".
+ - Otherwise, Git treats the pattern as a shell glob: '{asterisk}'
+   matches anything except '/', '?' matches any one character except
+   '/' and '[]' matches one character in a selected range. See
+   fnmatch(3) and the FNM_PATHNAME flag for a more accurate
+   description.
 
  - A leading slash matches the beginning of the pathname.
    For example, "/{asterisk}.c" matches "cat-file.c" but not
-- 
2.16.1.205.g271f633410

