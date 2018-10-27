Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73FF21F453
	for <e@80x24.org>; Sat, 27 Oct 2018 08:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeJ0R2s (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 13:28:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45900 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeJ0R2s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 13:28:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id j4-v6so3282308ljc.12
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sMXe16CaugEFTWDaDft2Q/DPRVnaBxREy0z6kecoBmc=;
        b=IjKabJX+RsfI0TeNdcUd9YeKhB4HNnXweJkBDHxFly9BROpDtV4snqhkV4N3kx8sUo
         O36EqpETGVFHXKS/SnMlSFOsjlMNyziPuD9CaqKhYxQ9hFnnXzStQGw7fg+YP+A9Xyk+
         4N/Pnr6m0V89Dh6Gqbey9VNqeXalcm3t68kqrV8U6Hxuv5e6uvTVISVl/K0y6B2XdNBo
         u6q/DA6IgJIN0FfIOUwhQ7iwYdvkOp5xeK9IuVJpjEXlGmUwE6RYr82SXd46CD9eJnHt
         Nl38GecpMsQQHs23i3mtGg+uIbeNC5Db3bXX0hnRX4q6bRR1pmoStUOpSbfIwmnIIoPK
         AHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMXe16CaugEFTWDaDft2Q/DPRVnaBxREy0z6kecoBmc=;
        b=oe6JvF2ynd/WUzlYwD/+mjtR7fcYKTq1owNoFHgLGFDReDerstUBMbSk9ANrOzn4pR
         QoKF+p5uceYEiJdSeeqrs5IEnOVrwbZjOdILM0AdW7qXLsfvbH5o5jiqzPyKlKS1nXmG
         ojPUJi1EgK9XAKysoJVuJlXB12rkxQQWOX4AZe5g8omCIbNYNGvok7YDlT6CfsiWFBUI
         x9yJppaU0tTR7UKGBSfGCRuhi7fZr76gUiOXHK4TS9A0w4hOKzreOHz7/PBFuUxsjh9X
         k6q7nOOw7JIrSzJjJN+1I2Wsx3X7GXRcutSRnUQFjiHbtvoNPSCbrvZmgrVJeO1SGk7b
         gkWA==
X-Gm-Message-State: AGRZ1gLOs3c0Cr/o4Xbk6Q88/XQ4DnDQvT8ZdIYIgVrbHGh8RUk+98r4
        EDcj/0bP13i7neKl4oAxCf9Rq6MC
X-Google-Smtp-Source: AJdET5fcQRzcT99DXTF+dBbmURKXJE56vg6Txv2yzsjSfWj39YO67bxRMcvuTeKn4CvEmb+SDB9v9Q==
X-Received: by 2002:a2e:2b46:: with SMTP id q67-v6mr4378304lje.126.1540630112467;
        Sat, 27 Oct 2018 01:48:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o137-v6sm560029lfo.81.2018.10.27.01.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 01:48:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        dana@dana.is,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] wildmatch: change behavior of "foo**bar" in WM_PATHNAME mode
Date:   Sat, 27 Oct 2018 10:48:23 +0200
Message-Id: <20181027084823.23382-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In WM_PATHNAME mode (or FNM_PATHNAME), '*' does not match '/' and '**'
can but only in three patterns:

- '**/' matches zero or more leading directories
- '/**/' matches zero or more directories in between
- '/**' matches zero or more trailing directories/files

When '**' is present but not in one of these patterns, the current
behavior is consider the pattern invalid and stop matching. In other
words, 'foo**bar' never matches anything, whatever you throw at it.

This behavior is arguably a bit confusing partly because we can't
really tell the user their pattern is invalid so that they can fix
it. So instead, tolerate it and make '**' act like two regular '*'s
(which is essentially the same as a single asterisk). This behavior
seems more predictable.

Noticed-by: dana <dana@dana.is>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/gitignore.txt | 3 ++-
 t/t3070-wildmatch.sh        | 4 ++--
 wildmatch.c                 | 4 ++--
 wildmatch.h                 | 1 -
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index d107daaffd..1c94f08ff4 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -129,7 +129,8 @@ full pathname may have special meaning:
    matches zero or more directories. For example, "`a/**/b`"
    matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
 
- - Other consecutive asterisks are considered invalid.
+ - Other consecutive asterisks are considered regular asterisks and
+   will match according to the previous rules.
 
 NOTES
 -----
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 46aca0af10..891d4d7cb9 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -237,7 +237,7 @@ match 0 0 0 0 foobar 'foo\*bar'
 match 1 1 1 1 'f\oo' 'f\\oo'
 match 1 1 1 1 ball '*[al]?'
 match 0 0 0 0 ten '[ten]'
-match 0 0 1 1 ten '**[!te]'
+match 1 1 1 1 ten '**[!te]'
 match 0 0 0 0 ten '**[!ten]'
 match 1 1 1 1 ten 't[a-g]n'
 match 0 0 0 0 ten 't[!a-g]n'
@@ -253,7 +253,7 @@ match 1 1 1 1 ']' ']'
 # Extended slash-matching features
 match 0 0 1 1 'foo/baz/bar' 'foo*bar'
 match 0 0 1 1 'foo/baz/bar' 'foo**bar'
-match 0 0 1 1 'foobazbar' 'foo**bar'
+match 1 1 1 1 'foobazbar' 'foo**bar'
 match 1 1 1 1 'foo/baz/bar' 'foo/**/bar'
 match 1 1 0 0 'foo/baz/bar' 'foo/**/**/bar'
 match 1 1 1 1 'foo/b/a/z/bar' 'foo/**/bar'
diff --git a/wildmatch.c b/wildmatch.c
index d074c1be10..9e9e2a2f95 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -104,8 +104,8 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 					    dowild(p + 1, text, flags) == WM_MATCH)
 						return WM_MATCH;
 					match_slash = 1;
-				} else
-					return WM_ABORT_MALFORMED;
+				} else /* WM_PATHNAME is set */
+					match_slash = 0;
 			} else
 				/* without WM_PATHNAME, '*' == '**' */
 				match_slash = flags & WM_PATHNAME ? 0 : 1;
diff --git a/wildmatch.h b/wildmatch.h
index b8c826aa68..5993696298 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -4,7 +4,6 @@
 #define WM_CASEFOLD 1
 #define WM_PATHNAME 2
 
-#define WM_ABORT_MALFORMED 2
 #define WM_NOMATCH 1
 #define WM_MATCH 0
 #define WM_ABORT_ALL -1
-- 
2.19.1.647.g708186aaf9

