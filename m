Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60AA11F461
	for <e@80x24.org>; Mon, 26 Aug 2019 23:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfHZXwi (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 19:52:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45007 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfHZXwh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 19:52:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so12818802pfc.11
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 16:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfIlnwiZHRpanMdQFm0z5kcTeu7+BtgILRG0c6KAIBc=;
        b=r4zOjXef5OhfuPGeLmpYgSu3Dlh2rP0wD4u/y1S2YctYXzhmRg6z96mJxv4BKe2ptx
         TJMcsnoFAXWojPaocouMLgKaTG6fa1PbmKmEZu+7BSBEjCWm1wsh9Xh3zK0VnYSbMe9J
         I1eU47HxXrzHP8NLqSHfpD/+Ytf7/kyxccY65aXylESLA62IoWGRjuV9d4SBBrq/TG8r
         tSB0EEAS0db07sz+NTKm5+Woi2LuTm5Jt1esTsmthg7age6WPWbmPfWflVBngqgULw3A
         gILpPZzwUQWTfNWFaRmV5vItp7xQHfXrYRliFVjhyrcoqmlMtRTQinJq1Ey+zljTJXP1
         MSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfIlnwiZHRpanMdQFm0z5kcTeu7+BtgILRG0c6KAIBc=;
        b=XgWxJc8TfmPiLih6AMo/NnRf6MNmi5ea2VYh6XmH9I3vHWnA9zuIuqGAAuOqxmC6e4
         UrA1Ohd8POe8cYmTadnzgpqsEhfORujAv1F2JEWlVDLGlvPtShH3u2QBBMc2sqL+OO6t
         xHkAPXuo8ppcJcLr87UFKxOYXu3wKa21pl23C08Yw8k2WoALP0I6ugJY+x9kHHiwhd5C
         jZmQkG3+AKKhOxBJE20qspF/++FMUrY57F+a0ReBMOYii+3BSGBD6Kk/4pNY0t8HjbiZ
         TmP3q4RVUCDXBHub9eW/KJmNP70AWN5W7EqVGVsAwQ0x/nnLKAl0on21Bg3WiUswh/RH
         uqsw==
X-Gm-Message-State: APjAAAXqfxHDlHT4sEsQfukJTtjHHgEIPLH3R50EwUXatvt87/7GpVIv
        DiNgSAWJIZaviQsm5G6pPLYiWgn1
X-Google-Smtp-Source: APXvYqxsrwn0OyGDQL3AKpOoGQjghEedzEP67fZup8iN+dvTmpcCr9SY9CFwDBr5g7F7Rx9hZXyYiA==
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr22585897pjq.120.1566863555682;
        Mon, 26 Aug 2019 16:52:35 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id 21sm5939047pfb.96.2019.08.26.16.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 16:52:34 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 3/5] git-sh-i18n: work with external scripts
Date:   Mon, 26 Aug 2019 16:52:24 -0700
Message-Id: <20190826235226.15386-4-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.5.g775ebaa2a0
In-Reply-To: <20190826235226.15386-1-newren@gmail.com>
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
 <20190826235226.15386-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Scripts external to git could source $(git --exec-path)/git-sh-setup (as
we document in Documentation/git-sh-setup.txt).  This will in turn
source git-sh-i18n, which will setup some handy internationalization
infrastructure.  However, git-sh-i18n hardcodes the TEXTDOMAIN, meaning
that anyone using this infrastructure will only get translations that
are shipped with git.  Allow the external scripts to specify their own
translation domain but otherwise use our infrastructure for accessing
translations.

My original plan was to have git-filter-branch be the first testcase
using this feature, with a goal of minimizing the number of changes that
needed to be made to it when I moved it out of git.git.  However, I
realized after creating this patch that no strings in git-filter-branch
are translated.  However, the generalization could be useful if we move
other tools from git.git to an external location.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-sh-i18n.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 8eef60b43f..3d04d5d515 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -5,7 +5,12 @@
 #
 
 # Export the TEXTDOMAIN* data that we need for Git
-TEXTDOMAIN=git
+if test -z "$TEXTDOMAIN_OVERRIDE"
+then
+	TEXTDOMAIN=git
+else
+	TEXTDOMAIN="$TEXTDOMAIN_OVERRIDE"
+fi
 export TEXTDOMAIN
 if test -z "$GIT_TEXTDOMAINDIR"
 then
-- 
2.23.0.5.g775ebaa2a0

