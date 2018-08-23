Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D06DE1F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeHXAH4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:07:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40201 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeHXAHz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:07:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so5674221wrw.7
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bek+ADgiK+VBh5A0DOkt+rUD/8rca6qLqmg3fzvIiio=;
        b=u4Qp645QaeB4D5pyE4eF5jIEvWpicibvi9vezoGtGjbkbQA0Floi6D5wG0cc0K775O
         sOk8xVpRUnrBJys3Ke+82wxWovbNH5Ob7Wa9iKaxz+WTwAYrIyUWyDby3k5WW7P9hP5O
         Ys/bsn+cvhGTPRHfMdBNBynQUMKYRIrtdGwTrFAG9GV9FKEItyig3UiuzuvZ4GeYQQT2
         MlVKrEIIkOy31uqgcTYPEuOjp1BNL0f17vOpkHoWOEqyRCvQ43W28lPaj17Z8HKWIA4d
         6lBJXdF1/TCxEx9Tli3mtov4OmJa+kJ+Q7pwtvQ/YMFedsUTY4AuInCzpwbRMd+g0RzP
         XNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bek+ADgiK+VBh5A0DOkt+rUD/8rca6qLqmg3fzvIiio=;
        b=UGkw5JZuWRdO2+B4elQ4GUkTq0GWRqvn/1+DAp5eg9eFP9mdavchN0ypWlFRc4x8f5
         5J1TitR8CHvfGq4YL+81r53iBrIEYbEBK1IyYddOiF/nSOlmEIX9cNqbwWJpjej0b9c+
         Z2jgbz/nJRyyeCJExVdkemT2mypl08jztEgNwyNn41yFUld+8h3+bZoCIImHUGV+l6RK
         +WwcKcr+WJEbygt/yb9dAJmnKd0pyJ3Bps5p8YlTw/vXPEpjqdu1xyR8EWOv4Db9A2+A
         J0Z4fys0EO2WFwD3eYusVEo2vYncnEJmD0Iqy/4L8gou6nddA2v8j1UxYX8T1sllKWI0
         TBMg==
X-Gm-Message-State: APzg51Cw4hp0rLjwwIbZZXqjjf7jawHeawNIsVcYeqV7/ZCa6rBiiO/c
        sQ1Vl+SXLIusyW2Qwkc+gGHsN+KXXKE=
X-Google-Smtp-Source: ANB0VdaeS8jKPepX3M8baReTKa8XyaMRCefumlz/h0oQZpUa4Q6ZyB5Kgl5ByPHnYaku4RUnY+j79g==
X-Received: by 2002:a5d:608b:: with SMTP id w11-v6mr8479527wrt.193.1535056592619;
        Thu, 23 Aug 2018 13:36:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q16-v6sm3641898wrn.41.2018.08.23.13.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:36:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/5] tests: fix and add lint for non-portable grep --file
Date:   Thu, 23 Aug 2018 20:36:04 +0000
Message-Id: <20180823203604.5564-6-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <20180823152502.3886-2-avarab@gmail.com>
References: <20180823152502.3886-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --file option to grep isn't in POSIX[1], but -f is[1]. Let's check
for that in the future, and fix the portability regression in
f237c8b6fe ("commit-graph: implement git-commit-graph write",
2018-04-02) that broke e.g. AIX.

1. http://pubs.opengroup.org/onlinepubs/009695399/utilities/grep.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/check-non-portable-shell.pl | 1 +
 t/t5318-commit-graph.sh       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 75f38298d7..b45bdac688 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -43,6 +43,7 @@ sub err {
 	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
 	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
 	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';
+	/\bgrep\b.*--file\b/ and err 'grep --file FILE is not portable (use grep -f FILE)';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3c1ffad491..0c500f7ca2 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -134,7 +134,7 @@ test_expect_success 'Add one more commit' '
 	git branch commits/8 &&
 	ls $objdir/pack | grep idx >existing-idx &&
 	git repack &&
-	ls $objdir/pack| grep idx | grep -v --file=existing-idx >new-idx
+	ls $objdir/pack| grep idx | grep -v -f existing-idx >new-idx
 '
 
 # Current graph structure:
-- 
2.18.0.865.gffc8e1a3cd6

