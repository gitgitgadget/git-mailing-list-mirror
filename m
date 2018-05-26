Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C781F42D
	for <e@80x24.org>; Sat, 26 May 2018 13:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754521AbeEZNz5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 09:55:57 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34272 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754692AbeEZNzv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 09:55:51 -0400
Received: by mail-wr0-f196.google.com with SMTP id j1-v6so13546153wrm.1
        for <git@vger.kernel.org>; Sat, 26 May 2018 06:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EBwKeuO7CyBH5OIdlV0hJaK+QUdREB7+IYUlMKI5tXo=;
        b=G4HPac3+5jlDkUgKQCH8B2jnkfp2kuRc3yIfZ4f7LlXTJfJwnTjz1G4aQ8sbXzSxZA
         kMrfrWpk9XEC1BksTc/XVt9T9T4/3iavHa40XvJAB/AaLHfEIeLYXY6ZpuXtcwtlTiSb
         kSBv5ZJDzIjgtXs0PPD1w8cCXs+W7/WjvPpetlU5yw5TqG8eZdPp45V7DM3hR/S6MHQk
         yW63eU3GYfKErCr5xfVz865xX3iss7j/tArFjLDYacrJUsUkKRxJ60c3z4srDe01sn9w
         eQFFZQ0ejKcwbJy4Z3NUFdRZ5vL0UMMyRVyiAwuFIdcmqgX6HlC73j59jLxroQNkplSF
         N/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBwKeuO7CyBH5OIdlV0hJaK+QUdREB7+IYUlMKI5tXo=;
        b=lREchRdsUOAI4bAU3/uC5st/55uM4Dg21LXt8pT09aIl3sdTXGo7A5Q1LcedDvQq+9
         drWEu/dr/04xgNKgh/wr5Old9DJNE/ifNpte4ytrMUUcs1IzCi2IdWyURAs+rlOLlxQ9
         8PZ1+wtJXUZXaM94+Kp6SNkSZ5tqzBdTrAqSiwSqXMSn4C7PnQNJROLXNaBAnYerh2VY
         4nTqhOQo2kpzeZ3PbDx2KUZE5U0GRUTWAv5OIzviX78zp9bnzUYaJTm2qIIrw0lVSmZw
         cxFXfy0hig7DGr/yYCi28LfSMjbvdcSwmpzuomk4KOrivRU7jezDJgZjJaKcw+rwpzpZ
         mSXA==
X-Gm-Message-State: ALKqPwevOFEqKYM+Xwo5jwPzBeaX6Gd17o1dsCng8HCxb1JzFha1cMY9
        5OlMyjdWicMALFpimrYFKEc=
X-Google-Smtp-Source: ADUXVKJotrXTLZl5jEha83RMotoiiIEnW+youGksxHbFkwHiesql5GmTVupTtithYVjR8XbGBBGUxA==
X-Received: by 2002:a19:9dca:: with SMTP id g193-v6mr3672290lfe.65.1527342950666;
        Sat, 26 May 2018 06:55:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z4-v6sm4941431lji.14.2018.05.26.06.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 06:55:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 10/11] completion: support case-insensitive config vars
Date:   Sat, 26 May 2018 15:55:30 +0200
Message-Id: <20180526135531.4516-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526135531.4516-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
 <20180526135531.4516-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Config variables are case-insensitive but this case/esac construct is
case-sensitive by default. For bash v4, it'll be easy. For platforms
that are stuck with older versions, we need an external command, but
that is not that critical. And where this additional overhead matters
the most is Windows, but luckily Git for Windows ships with Bash v4.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index efc930c9d1..2cbd14b346 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2151,7 +2151,15 @@ __git_compute_config_vars ()
 
 _git_config ()
 {
-	case "$prev" in
+	local varname
+
+	if [ "${BASH_VERSINFO[0]:-0}" -ge 4 ]; then
+		varname="${prev,,}"
+	else
+		varname="$(echo "$prev" |tr A-Z a-z)"
+	fi
+
+	case "$varname" in
 	branch.*.remote|branch.*.pushremote)
 		__gitcomp_nl "$(__git_remotes)"
 		return
-- 
2.17.0.705.g3525833791

