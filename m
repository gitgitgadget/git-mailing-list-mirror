Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567261F404
	for <e@80x24.org>; Sun, 15 Apr 2018 15:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeDOPge (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 11:36:34 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44523 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeDOPgb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 11:36:31 -0400
Received: by mail-lf0-f65.google.com with SMTP id g203-v6so18586710lfg.11
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSxnuzR9kPM7/y4cm7V0QwkA/Y995BExEeE0s33T+I0=;
        b=e0uSuf3tYeHuoeIEwiYPzr5L0anhU8+5MGQPnmv7TVqQyHV33xaLwY+Dp6MZv4gYn2
         WPlA4LwoDr1OrxUb7B8leTMkHFRPLgscGCz3/QBTijgI/0mvFSZCjPBS0l1xzpvZwZ2G
         L06wo3pWNSoQiNZxFyI4T5ki3tF1U31QZF6zJJ4piDN7QvoJM6TU8CqJxYXhwQpTTGQ6
         oj6pBoigEYiNwI4aAv+u9RTi+M7unmw9/2dPES/CDh0h7PcBWdsBj8wLMrU29ReqCvr9
         82a5Gl1VgLG0vDw95Uxyi9lIufktO4ohN4RQzxA+2WDDu9On5GztsMbpK/Bf7DF9CMaq
         rmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSxnuzR9kPM7/y4cm7V0QwkA/Y995BExEeE0s33T+I0=;
        b=PXFnCVfz5jqgqVWg7OoMBJfPmphafTam+MryUrlXLsvD/fGGnEsweU/c7FVx9dDnIo
         yAtbWHwA85jQT1+91tmmFs1sbGrDU9OLlN0mjG2Zxpo0qGbYS3EIQ+QJsUcarZ5mdBeN
         B2XCc69eMYkCk8iIjRSFFavxUw3TiRXZ9ZC3FyINCAPgpWgLqHFaTQcVbiFKPQYREG7j
         YFJTxWMvoAhQZh2LUil9sgRTTKgl0YMvBwTKDTKyvuTH7QWSbm01IXHG/LWftBI7mfTJ
         4viA15wWPi+UfhTVJe7UF3FiEMH0r/o2LBhOtYxMb7mYRaMKCsFImmqHJXQpce33W+Ji
         h0zQ==
X-Gm-Message-State: ALQs6tBhWFrUkEX61efMR0tpk7MlSdmi6RoSAV3uHEfL56rlWYGrzNur
        /Jye1aCvG2Eax05h6D2P4UY=
X-Google-Smtp-Source: AIpwx4/qBHidVMce8ywyQlkSvuMeg6d9d11zM8lFKbs1yjWakIf7vuDPzzLw51cAn3YxCr4C8KrDrQ==
X-Received: by 2002:a19:d8a5:: with SMTP id r37-v6mr13084399lfi.88.1523806590634;
        Sun, 15 Apr 2018 08:36:30 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w10sm826176lji.47.2018.04.15.08.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 08:36:29 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>
Subject: [PATCH v2 1/7] t7700: have closing quote of a test at the beginning of line
Date:   Sun, 15 Apr 2018 17:36:12 +0200
Message-Id: <20180415153618.32019-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180415153618.32019-1-pclouds@gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com>
 <20180415153618.32019-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The closing quote of a test body by convention is always at the start
of line.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7700-repack.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 6061a04147..38247afbec 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -194,7 +194,7 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
 	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
 	git repack -a -d &&
 	git cat-file -t $H1
-	'
+'
 
 test_done
 
-- 
2.17.0.367.g5dd2e386c3

