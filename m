Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B542020248
	for <e@80x24.org>; Thu,  4 Apr 2019 07:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDDHeo (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 03:34:44 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:40355 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDHeo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 03:34:44 -0400
Received: by mail-pg1-f181.google.com with SMTP id u9so787707pgo.7
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 00:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mg0hes+MQWC5nxAEVrQEAVbmxzqdYrTgmPYkG3d/JPw=;
        b=E8zqeIzg5TV/I79GhOcG7s2DAwjBLeUCpwu2eur3SJ5yLnMYK/DVoB5Ih6Mo6+SNKD
         Atc+QYlpID+JonFBBdZsc2xqNLACKF+3S+SmKiXXVk8zOEySRV3CqZdXOoPV0QCjw2xO
         Mo6gZ7+I5S/epDHtKpVwzGENntiUmpAScFkZ/RgdELkjKU6cqUTg2nFfenHkWEfzIDmv
         Sel06qRRw8PFDA9DK5bPopXXaN7fuKDzSwzRk0JV9LSD6La3fd/oWR6/0VHCTONGfl5v
         YMz221cVIRkppiJ/aWGC5UU981cWzKdMdqqhY1CIayTTaGtg722c7oYpoElat08Uu8G+
         84FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mg0hes+MQWC5nxAEVrQEAVbmxzqdYrTgmPYkG3d/JPw=;
        b=TnFrMsT4cLAJeF6arbhjTHdu+Ym69Q7MrEMZHU/5OtJJGIQfSnzM8xKBMNx7dTfBU2
         eUGfJvYzYbLWLoQgMbUejJDyErkZZMquJQ33geDIJpIZq8olMtqia8MMCm7414bIZYcI
         sReoqN9rzwcEAgFkk7HrVJLKK+mq04eRngiTWdl4NBhr+myQb07p4WbETXLZJ43YPpRq
         ync2DLtpOqw2zhY5pA245KXnL+8hRURmos3cuMX/0uhgK0j1kpLIXVi0NC5dtOBSQIjg
         LAdOCl9ReP/4Xwq+nCMqGesPiHYRRsAxDfboS7HspaAkHWIS9qmp4YcdvEu7vPkwRPEp
         XtkQ==
X-Gm-Message-State: APjAAAUZQzZWLySniacmGE/LikEf071aisfizhtUhXx1d9JrLQ8lmTCj
        bzWeJfasVZwObBSYvz7QfPw=
X-Google-Smtp-Source: APXvYqylsMn1XYnccK/imqcFkKfqtxxxTc6nz9FtmcDNkbO4WXj6JfWXMUyV/aZ0wwBTCf2oexbndQ==
X-Received: by 2002:a65:6108:: with SMTP id z8mr4385552pgu.106.1554363282075;
        Thu, 04 Apr 2019 00:34:42 -0700 (PDT)
Received: from localhost.localdomain (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id b26sm41802310pgn.4.2019.04.04.00.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 00:34:41 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: [PATCH 2/2] contrib/completion: add smerge to the mergetool completion candidates
Date:   Thu,  4 Apr 2019 00:34:39 -0700
Message-Id: <20190404073439.9558-2-davvid@gmail.com>
X-Mailer: git-send-email 2.21.0.198.gfad8868f4e
In-Reply-To: <20190404073439.9558-1-davvid@gmail.com>
References: <20190404073439.9558-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 976e4a6548..b6d69bcaeb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1501,7 +1501,8 @@ _git_diff ()
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc codecompare
+			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc
+			codecompare smerge
 "
 
 _git_difftool ()
-- 
2.21.0.198.gfad8868f4e

