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
	by dcvr.yhbt.net (Postfix) with ESMTP id CBCD11F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 23:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfJCXdJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 19:33:09 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:47469 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731688AbfJCXdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 19:33:09 -0400
Received: by mail-pl1-f201.google.com with SMTP id v2so2713225plp.14
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wmkMdwf8Hqfqt0WUgC/qo+wg+wKZyeTo0aV9UurjgFA=;
        b=mXgEWndU+SghdL87LWpfoK0zzddHwNsRIvl7gKXvgbfVpI65SmO5TGUN6aGzEV/Yd5
         LQgG8/z1FKRQB4glYMSaJzLv9sj+RmkfudwEMggCyxuMhCjPfmOilIXg04bOaA/HZ9Op
         ptafEPju1dMvrQb894K3Aow92Ydre/iDS/yXbwuJDq9ghXgK3beJZAVoe24no3PoQWVk
         So78Ur8qijQnuAUo01t/72olJJUoQ9JQsguFg6j9kzGw9XGYDkYvLmGHuJvhJT5otbg/
         7u5eYKsgSfFG6gHSESBmOLjJQfeQrya04BquVf846ZIza0xcEsK0mkcFmIuox+NOrsuq
         p94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wmkMdwf8Hqfqt0WUgC/qo+wg+wKZyeTo0aV9UurjgFA=;
        b=UfunW4zSykRVRugwZ0Pkzg/a+d1/4UphqfX3bC1BcOmZFASUvvFKJp7Qfc75kgr1cA
         o1UewXpioDUOCtEUoDCoL532D3GgoeXeK0XcSDJ7kSko/e4205z88A5UmR2bYXCkl+yx
         93L0wv8fBg90pHDsYuoTT4faxO3LhgZiXqy5ggntNYJBwMDbcAAeUoMkUSKwhwegG7ev
         qgTCJMx4m7LhGWSWBoghQkA3ESx0USFxRUW63IyR8DSqs6OHVPNEPFlQml2IBpVarW42
         3Fmr2qX88VbUDj+tcaX7hTKSdZ4l/WSO/CLfNWsi9T5ldTkd8o8fOaHfrDtmhY7CGYDO
         yYHA==
X-Gm-Message-State: APjAAAWEUUR7SaK4nSXWXs697Z7Gt3Fk+ooz+48Yw/cFEonQI4XhCSO3
        40j3/X0oMyNx+kmU7B4itGLI80L9xukffx69lpPjYI2pIt7lu9LALYW4XMX5foTOKiKnLDMCtyj
        nY85er6Wz4tygSdhOqPWGE3UjgoDLlIxCo8vyHQm2JAqQvf9pNku+0pkCMNAn5jw=
X-Google-Smtp-Source: APXvYqwDQzWg1vcvUUI3EWY+cWyjH7JkweAobJOUW9CsHrW0ox7qKw56rHbe2/TQWhklXlUfTwDHyOnu1UhKUQ==
X-Received: by 2002:a63:358a:: with SMTP id c132mr12312484pga.32.1570145587012;
 Thu, 03 Oct 2019 16:33:07 -0700 (PDT)
Date:   Thu,  3 Oct 2019 16:32:57 -0700
In-Reply-To: <cover.1570144820.git.steadmon@google.com>
Message-Id: <a757bca8f99bad57806bfdcd67ac1c1f6cc38584.1570144820.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1570144820.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v4 2/4] docs: clarify trace2 version invariants
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it explicit that we always want trace2 "version" events to be the
first event of any trace session. Also list the changes that would or
would not cause the EVENT format version field to be incremented.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 80ffceada0..18b79128fd 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -604,7 +604,13 @@ only present on the "start" and "atexit" events.
 ==== Event-Specific Key/Value Pairs
 
 `"version"`::
-	This event gives the version of the executable and the EVENT format.
+	This event gives the version of the executable and the EVENT format. It
+	should always be the first event in a trace session. The EVENT format
+	version will be incremented if new event types are added, if existing
+	fields are removed, or if there are significant changes in
+	interpretation of existing events or fields. Smaller changes, such as
+	adding a new field to an existing event, will not require an increment
+	to the EVENT format version.
 +
 ------------
 {
-- 
2.23.0.581.g78d2f28ef7-goog

