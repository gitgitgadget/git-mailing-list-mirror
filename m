Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AAB3208B8
	for <e@80x24.org>; Mon, 14 Aug 2017 08:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbdHNIqK (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 04:46:10 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36226 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbdHNIqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 04:46:09 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so9615451pgy.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=28JRh0mK5zUiiZGMI9TnJ44oDfsmvNFP1sUohMVeUG0=;
        b=NDTlqEBZZDfMWKNhC2Ov1NYpyJIhnG1+hEbYrnM0H/2FlcdJgcI9ZbPlUBebIIe/SE
         j0oEEEDFclWe5DzUp4Fy9rMzrKm27KtB0VmxgCsrvX2uqmYrAY66ZRe8ir9s63XA/fLq
         zzUmF53yZ2BB9fVfhjNfuA7pWPyedh+zMNPmNhtpNE+yyziHTW8prA2/oJbh8a6J3wRS
         Dm1KA5QQBoXGCpFzCXRzy2HKpAzZcePs9hKli/3jVisKtP0f7e1Z0/ccbYz9nJm6k4kM
         1j1L4qEu/djUpibF3Y0teBxVMFFAwMpUv8gCn4ykjF1cNl1+LgepKQ3BM3yRk8wZS782
         nFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=28JRh0mK5zUiiZGMI9TnJ44oDfsmvNFP1sUohMVeUG0=;
        b=IebyqTxIJ6LzcoMASfmmD4XF+wMmrJ5e1P68rMYWXYf8cFK27dWGi06/T6DY2f41sY
         D+9/rWqMKB7wdR6LrSojMCkZJgMTsamDoANKpCkZ1cXT++UjKD/ebjX+OalmJwXWz09m
         lto6fpig/xxetPmKZGdO89TQ9gtft+PJKhjTeo67Z8A+8sZ8cAJsIIMjSxEvZ9yZ2Rc5
         P0QTa3XVEPgdzZGxu+7R9mmHrnOHyOU0Iwn/igeG72KQ9TMo96NqAIzyK+Xm3CDNunKf
         sp5Vrv+6K2HeKRlcUOFcV8aObT9qqACEiEhLz1moC5E1NSiaqVc5G/1/TAdj0VUGmhjP
         qbiQ==
X-Gm-Message-State: AHYfb5hQMLF7u1D9QOMld7fv0EDsuyr/6fsxllp73MwX6PR2PMQReYqs
        eZBP5oCR9hDxhYQmd8aSmA==
X-Received: by 10.99.97.68 with SMTP id v65mr23221223pgb.200.1502700369392;
        Mon, 14 Aug 2017 01:46:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7086:24:a9b7:4f7d:37ad:9d03])
        by smtp.gmail.com with ESMTPSA id g1sm12296165pfk.92.2017.08.14.01.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 01:46:08 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] hook: use correct logical variable
Date:   Mon, 14 Aug 2017 14:16:46 +0530
Message-Id: <20170814084646.30781-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.534.g641031ecb
In-Reply-To: <20170711141111.7538-3-kaarticsivaraam91196@gmail.com>
References: <20170711141111.7538-3-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sign-off added should be that of the "committer" not that of the
"commit's author".

Use the correct logical variable that identifies the committer.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 This fixes a small issue when trying to do the following with the script enabled,

    $ git commit --amend -s

 If the commit being amended was signed off by the commit's author then the above command
 would *append* the sign-off of the committer followed by that of the commit's author.
 That' because the script is invoked only after the sign-off is added by the '-s' option AND
 the default of 'trailer.ifexists' for interpret-trailers currently defaults to the 'addIfDifferentNeighbor'
 thus interpret-trailer fails to identify the existing sign-off of the commit's author and adds it.

 Anyways, it doesn't make sense for a script to add the sign-off of the commit's author. So,
 fixing it seemed correct to me.

 templates/hooks--prepare-commit-msg.sample | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index a84c3e5a8..12dd8fd88 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -34,7 +34,7 @@ SHA1=$3
 #  *) ;;
 # esac
 
-# SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
+# SOB=$(git var GIT_COMMITTER_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
 # git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
 # if test -z "$COMMIT_SOURCE"
 # then
-- 
2.14.1.534.g641031ecb

