Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5F920380
	for <e@80x24.org>; Wed, 22 May 2019 00:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfEVAWW (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 20:22:22 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:44410 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEVAWV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 20:22:21 -0400
Received: by mail-qt1-f201.google.com with SMTP id t51so398013qtb.11
        for <git@vger.kernel.org>; Tue, 21 May 2019 17:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Le9FMCTJI6pXCdFlqVPhGri1nKiAp54cd08micw8HzI=;
        b=Pr2GWo8zDhW1iw5Xoj9Eis6e/qX8dUf0PMQct4nVcZPPh80X1J4hnfJWTd7e8V5XL5
         WhabebwvZyFoRYXRsVReE06fGlKPrIMfPEe+6qt76jsHXUog8zxBcwway6Jj/IfTwauZ
         OFwX0vtc1H270Ka/98G1+N0wje9uz+mHvrzMrsQhangCto4dImuABlgcE7PBZRSwXVZc
         9gmVEktS1PWYLmithKriZC2whyEjor9I8Bp0dzix4ubhES+7dqKhGOtNDEXCchIeXYbT
         ZFeENBSI5/FENtd1xPc5tOVgbECOZeRvaD8UbZffdIqeBRiWk5hIvquyy9lX2oTNXpyR
         cGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Le9FMCTJI6pXCdFlqVPhGri1nKiAp54cd08micw8HzI=;
        b=ZSLFi76rjpA44Xaj7WUNRBXK5Yx1fM3SSzFRecdUhbJpnupOtqRNtLYOqr+ODRqnHZ
         Ov45/lYZmzPT7kKH0+ArK9O+Rv9HZy6l1DyDgHPXtuhQW8pdKdJ9ii3IjRNMdWOl5vU4
         Ab5aEYlYMqJ/9QSPdN45qJUk+z+Nai9rnGxSHKiihEWKMpXjfGWfOWQ5qEhENJ9VIB+K
         QImIGeevwixqlRcuXTwQUCCZi87vAaczEZSHIK63RG+KUayBHOxUTMzrltWiEFOhfMJk
         e+V6hipqEVCe0Vqqg4Cz86lQWX+ZEk875smkmJ2gwwuH6Jkw811SX+y5ZPAu2ZCdKL5L
         R65w==
X-Gm-Message-State: APjAAAVXIUV1ZOljsHqz/hNrNByYCpaZxVhg8uGLhdyhHosN4EZx8lqd
        cMzAwUjJm3ZeI+lhEg2WdKK0A2KgVio=
X-Google-Smtp-Source: APXvYqxIhYykKB4R2pEw306eTKPrbdlc9cjkJ8pFjIGkQw1twOhru6BdkRDQJQ49OtGC2sFactVElV6whphH
X-Received: by 2002:ac8:7585:: with SMTP id s5mr43854032qtq.38.1558484540879;
 Tue, 21 May 2019 17:22:20 -0700 (PDT)
Date:   Tue, 21 May 2019 17:21:51 -0700
In-Reply-To: <cover.1558484115.git.matvore@google.com>
Message-Id: <6f4da02d494323e3ca946b4b20bf78d9dee419e4.1558484115.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1558484115.git.matvore@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v1 2/5] list-objects-filter-options: error is localizeable
From:   Matthew DeVore <matvore@google.com>
To:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "invalid filter-spec" message is user-facing and not a BUG, so make
it localizeable.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0036f7378..e46ea467bc 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -81,21 +81,21 @@ static int gently_parse_list_objects_filter(
 		filter_options->choice = LOFC_SPARSE_PATH;
 		filter_options->sparse_path_value = strdup(v0);
 		return 0;
 	}
 	/*
 	 * Please update _git_fetch() in git-completion.bash when you
 	 * add new filters
 	 */
 
 	if (errbuf)
-		strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
+		strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);
 
 	memset(filter_options, 0, sizeof(*filter_options));
 	return 1;
 }
 
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
-- 
2.21.0

