Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD6220357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbdGQULv (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:11:51 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32785 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbdGQULu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:11:50 -0400
Received: by mail-lf0-f65.google.com with SMTP id t72so27199lff.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtJPwgyMxIGugXYOXhutD/wqKFjii3KTDjEGTN6HJQQ=;
        b=FARHVU01JB7qv+fMADN4DKj9NPDGvQfGO2g11SjgO6EthW3KMAxCvRSXrHg3axkoim
         tmvLWGgdcPHcwqPgsEjXDuhXO9oy0H6l6H42kBNYr7A5MIFG/m4EAvgri1rAL9R+BOdQ
         /e4K1iFHXRLW1lAM8x0tRhDu4SwAQ//OfgnWYncE52Cf4MJtu/7kZ/9PHYeIasC6vu8d
         cnaMai+X7p1EB0HcXmQlKj+FiFAzDErHfMx5VetdLG7rGqcu7cAmrUbal/0Okz633mA8
         oezHKoAxRUOr6JLiXTB74wl/uq8GMi7LpppAkQvd9lFFxuhk1A33bKowM/mvvj0WNxhr
         uFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtJPwgyMxIGugXYOXhutD/wqKFjii3KTDjEGTN6HJQQ=;
        b=Nfym9FRjys+2blGFcClnavxJMKmsRibuCI51vOonpxkylka5VHhMywljpXdcAwNx2Y
         c3nVeXTsvGGhBwVHZl/EZ/1zsyuhy/OjuTXEiy0gms4Wn39P/BeW7WgPduMReD1v759L
         7esRq0tLcotVCvkrahx3GFxPyMP2Dfbn3D5H+rCndtewipOq+IVyCGuFdMD11clqSHLs
         R1cpHi6+c7w8SxFVf2HNmWSj9KtsS+DI3/rwY3V29fuXVBOTpIQtt41ywToZF/o6vmr2
         vGHV10Mi3A97FR1S3iGJR2qDuB3D5Tgu0prlsuJvO3loy64O/5BmSRDfHdaeuTvzfpAK
         gISw==
X-Gm-Message-State: AIVw1117th4hjUE2/Jn782VCeNEbvFTAOTi2lEv/yoSvOJZy76KYCgWg
        T/2T7RzD1Z2BjHAZ
X-Received: by 10.46.5.151 with SMTP id 145mr5647771ljf.91.1500322308545;
        Mon, 17 Jul 2017 13:11:48 -0700 (PDT)
Received: from localhost.localdomain (c83-248-253-33.bredband.comhem.se. [83.248.253.33])
        by smtp.gmail.com with ESMTPSA id l12sm30752ljb.39.2017.07.17.13.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:11:47 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 09/10] tag: change default of `pager.tag` to "on"
Date:   Mon, 17 Jul 2017 22:10:51 +0200
Message-Id: <86ab09419c951ebeee2435c9c294f4b3f8816775.1500321658.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0
In-Reply-To: <cover.1500321657.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patch taught `git tag` to only respect `pager.tag` in
list-mode. That patch left the default value of `pager.tag` at "off".

After that patch, it makes sense to let the default value be "on"
instead, since it will help with listing many tags, but will not hurt
users of `git tag -a` as it would have before. Make that change. Update
documentation and tests.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-tag.txt |  2 +-
 t/t7006-pager.sh          | 28 ++++++++++++++--------------
 builtin/tag.c             |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 875d135e0..d97aad343 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -206,7 +206,7 @@ it in the repository configuration as follows:
 -------------------------------------
 
 `pager.tag` is only respected when listing tags, i.e., when `-l` is
-used or implied.
+used or implied. The default is to use a pager.
 See linkgit:git-config[1].
 
 DISCUSSION
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index a357436e1..df258c5d4 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -134,16 +134,16 @@ test_expect_success TTY 'configuration can enable pager (from subdir)' '
 	}
 '
 
-test_expect_success TTY 'git tag -l defaults to not paging' '
+test_expect_success TTY 'git tag -l defaults to paging' '
 	rm -f paginated.out &&
 	test_terminal git tag -l &&
-	! test -e paginated.out
+	test -e paginated.out
 '
 
 test_expect_success TTY 'git tag -l respects pager.tag' '
 	rm -f paginated.out &&
-	test_terminal git -c pager.tag tag -l &&
-	test -e paginated.out
+	test_terminal git -c pager.tag=false tag -l &&
+	! test -e paginated.out
 '
 
 test_expect_success TTY 'git tag -l respects --no-pager' '
@@ -152,32 +152,32 @@ test_expect_success TTY 'git tag -l respects --no-pager' '
 	! test -e paginated.out
 '
 
-test_expect_success TTY 'git tag with no args defaults to not paging' '
+test_expect_success TTY 'git tag with no args defaults to paging' '
 	# no args implies -l so this should page like -l
 	rm -f paginated.out &&
 	test_terminal git tag &&
-	! test -e paginated.out
+	test -e paginated.out
 '
 
 test_expect_success TTY 'git tag with no args respects pager.tag' '
 	# no args implies -l so this should page like -l
 	rm -f paginated.out &&
-	test_terminal git -c pager.tag tag &&
-	test -e paginated.out
+	test_terminal git -c pager.tag=no tag &&
+	! test -e paginated.out
 '
 
-test_expect_success TTY 'git tag --contains defaults to not paging' '
+test_expect_success TTY 'git tag --contains defaults to paging' '
 	# --contains implies -l so this should page like -l
 	rm -f paginated.out &&
 	test_terminal git tag --contains &&
-	! test -e paginated.out
+	test -e paginated.out
 '
 
 test_expect_success TTY 'git tag --contains respects pager.tag' '
 	# --contains implies -l so this should page like -l
 	rm -f paginated.out &&
-	test_terminal git -c pager.tag tag --contains &&
-	test -e paginated.out
+	test_terminal git -c pager.tag=false tag --contains &&
+	! test -e paginated.out
 '
 
 test_expect_success TTY 'git tag -a defaults to not paging' '
@@ -214,9 +214,9 @@ test_expect_failure TTY 'git tag as alias ignores pager.tag with -a' '
 
 test_expect_success TTY 'git tag as alias respects pager.tag with -l' '
 	rm -f paginated.out &&
-	test_config pager.tag true &&
+	test_config pager.tag false &&
 	test_terminal git -c alias.t=tag t -l &&
-	test -e paginated.out
+	! test -e paginated.out
 '
 
 # A colored commit log will begin with an appropriate ANSI escape
diff --git a/builtin/tag.c b/builtin/tag.c
index 5ad1af252..ea83df5e1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -462,7 +462,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 
 	if (cmdmode == 'l')
-		setup_auto_pager("tag", 0);
+		setup_auto_pager("tag", 1);
 
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
-- 
2.14.0.rc0

