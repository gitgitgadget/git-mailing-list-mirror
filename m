Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0419A21845
	for <e@80x24.org>; Mon, 30 Apr 2018 09:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeD3JvF (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 05:51:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53268 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeD3JvD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 05:51:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id a67so4520539wmf.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gtPZDs/PRAxM6b3py1XBVkwXO+pHwUJMhJnsq8OQFok=;
        b=bDMertmXqy7m5Jo326JLpZOQ+cWZzpZ4J0YvfTBCnEPw4CQhxzRgMPNZpVNPvl5bis
         RWtQi5DJp1QrgawV/inWnRmANDN+VFnJMIk72ALszVTufNO99uUS/k2OZdsfBmVNo4is
         DOFMGcIbJAeBYTKL/EaMYV7anNTdt8P2FyivFGCjNMxzq6voac2yJkOto7EUf5pAt+QC
         UxqZiCxHvYoVntDYbryukz4bT3E8Upk0hwD6/XnK/+hh8vKYHwWh8ebR0P4POM0MDhKe
         0iwB4MCj9KGx4EO4PQMw/KKJqNLQkrVFO1rwKIBbm4EK4qg6xwIzqdu5S/aLT0lIkEDN
         GJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gtPZDs/PRAxM6b3py1XBVkwXO+pHwUJMhJnsq8OQFok=;
        b=HK74GTmPggT2C+ASY7rAUdYPpFtOBwzHKxcn+ys1+NMpBs99ypGdWVkYFQnFmEqlFg
         LaYXuz74DoRSOfg3h/SZgEr7l9zhQfaGlvw3zJM8nwoWKsFWoJUHDARrzhGxI8U5esCE
         f2W2zQDkH8y448kj6Bk5mMM9gOQl8TTuChnGffmo7/X+xzi0Sx2+girBVMvBrvm9nXuC
         4mTgfKl5kRxgs0oDb+UODsJz2tWyUxKWjPrVxqx42Zb+FYgJcS3kmv7a4mQ2/bMV2hQV
         Cg+oSLlAPfAHpGQxjBMK4bn6z0pTM0ti5TcEvITORdzljMbJZh6ujfal7Z7oSyyEAAXa
         NbFg==
X-Gm-Message-State: ALQs6tA2bolqe8dcaW7pWrDP/DidvOiC+tjNSW02EplQtt/ay4OYbRvj
        CQhoSRgCaW9C37epqOawvD9tzndY
X-Google-Smtp-Source: AB8JxZrCHJWpNTEhhLLle38ARY9aJVd2aNH9e6qwHsn/qjVlimcTACvBt7ribQJSZZfjN8aEU4v75w==
X-Received: by 10.28.50.135 with SMTP id y129mr547149wmy.22.1525081861532;
        Mon, 30 Apr 2018 02:51:01 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 42-v6sm13178687wrx.24.2018.04.30.02.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 02:51:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@Wilcox-Tech.com>,
        David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] subtree: remove support for git version <1.7
Date:   Mon, 30 Apr 2018 09:50:42 +0000
Message-Id: <20180430095044.28492-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180430095044.28492-1-avarab@gmail.com>
References: <20180430095044.28492-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that git-subtree is in-tree there's no reason to be supporting
older git Versions. This reverts & amends 448e71e263 ("Use 'git merge
-Xsubtree' when git version >= 1.7.0.", 2010-05-07).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-subtree.sh | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/git-subtree.sh b/git-subtree.sh
index d3f39a862a..1b8cd53c7f 100755
--- a/git-subtree.sh
+++ b/git-subtree.sh
@@ -810,23 +810,12 @@ cmd_merge () {
 		rev="$new"
 	fi
 
-	version=$(git version)
-	if test "$version" \< "git version 1.7"
+	if test -n "$message"
 	then
-		if test -n "$message"
-		then
-			git merge -s subtree --message="$message" "$rev"
-		else
-			git merge -s subtree "$rev"
-		fi
+		git merge -Xsubtree="$prefix" \
+			--message="$message" "$rev"
 	else
-		if test -n "$message"
-		then
-			git merge -Xsubtree="$prefix" \
-				--message="$message" "$rev"
-		else
-			git merge -Xsubtree="$prefix" $rev
-		fi
+		git merge -Xsubtree="$prefix" $rev
 	fi
 }
 
-- 
2.17.0.290.gded63e768a

