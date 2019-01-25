Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_BLACK,URIBL_DBL_SPAM shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36DC91F453
	for <e@80x24.org>; Fri, 25 Jan 2019 22:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfAYWBE (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 17:01:04 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:41164 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYWBE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 17:01:04 -0500
Received: by mail-qt1-f179.google.com with SMTP id l12so12379021qtf.8
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3YgiCT41sd9EAjz7fY8NTvVE+kPiftBv9T2Isd85FvY=;
        b=uNeWrXcCXqe6IZ9rFzmBjfFDq3iAGEKldk9eHme7LA6wz/2uCUy62s2hJdRyb5FmRX
         0b7NV7xRJHpLxwjLCc9Wq3hqG8G+pYo5Mhn/LkWEbQZ92QDOiZ5UgDi4WdRs8URstGL6
         tUuJBZ+6hJuWHJO4KSTzNRSb5scIgv/hZ+KGsX1T1RnNsvwf2eoKt20okLqKSs9W+vB0
         WFqeJm/rpSX/Q6kn+3p6z6Ga2tXp6nxxegMm9patOrn5uhuOJm55AttYJBbpCAGnMZ1Y
         4CGxC4WhAqvqhzFxwGzHvJJMTfH+3IgCTRFOVw3ugjr5IT+1mVyHBQfs3CbAq2Vt+JFr
         JNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3YgiCT41sd9EAjz7fY8NTvVE+kPiftBv9T2Isd85FvY=;
        b=hZNzedM/jbyqnVvZnepcCItCGlYe7+/+ebDWiIMeG5mIEtACoDfzEo0Dk3c+SPTF1M
         RWPgIyA45qojMnPdpXpoqoHrmbHssfGHLrKkHHlTrGam45wZtRGJbJf18LJQJFY6fWwy
         9/kWOgX/WyTvElSFvjaYbXeKh0GQahAUZo1sd6hdWzOGGdu8P7uPvI74fUBMJy+WLCzq
         xeyDkUYfabjYPpDWW6AKLrskb6VJa/I48r5NjjinM7SgdnZz0fM9ICn3gVP0EGdRlTvz
         7Iz3PEFnTw3V7wu3R2YXmiNTXmmlWab8p0k/V8uoxaCwDd1xfR+tW9XZsHKx38yTwmIV
         hBpQ==
X-Gm-Message-State: AJcUukeDUmbTTGXcDNT657FZC4/2/AvAoWzK0/qL5flLEcpSYT42uaaG
        XvP9EClNqsCipZNhZj0aIp4OA6BC
X-Google-Smtp-Source: ALg8bN505TT4mOVAzwEVDtaMPpld2vl/zeRGUqqBZHYzWDPh9TrhdZ2lWAtmNkrKY2MJLRGsSt6IkA==
X-Received: by 2002:aed:2217:: with SMTP id n23mr12299718qtc.288.1548453662736;
        Fri, 25 Jan 2019 14:01:02 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id m68sm63235856qte.49.2019.01.25.14.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 14:01:02 -0800 (PST)
Received: (nullmailer pid 30179 invoked by uid 1000);
        Fri, 25 Jan 2019 22:01:01 -0000
From:   William Hubbs <williamh@gentoo.org>
To:     git@vger.kernel.org
Cc:     williamh@gentoo.org, chutzpah@gentoo.org
Subject: [PATCH v2 2/2] tests: add test for separate author and committer idents
Date:   Fri, 25 Jan 2019 15:59:55 -0600
Message-Id: <20190125215955.30032-3-williamh@gentoo.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190125215955.30032-1-williamh@gentoo.org>
References: <20190125215955.30032-1-williamh@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: William Hubbs <williamh@gentoo.org>
---
 t/t7517-per-repo-email.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index 231b8cc19d..06c7c0fb78 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -85,4 +85,21 @@ test_expect_success REBASE_P \
 	test_must_fail git rebase -p master
 '
 
+test_expect_success \
+	'author and committer config settings override user config settings' '
+	sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
+	sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
+	git config user.name user &&
+	git config user.email user@example.com &&
+	git config author.name author &&
+	git config author.email author@example.com &&
+	git config committer.name committer &&
+	git config committer.email committer@example.com &&
+	test_commit config-names &&
+	[ "$(git log --format=%an -1)" = "author" ] &&
+	[ "$(git log --format=%ae -1)" = "author@example.com" ] &&
+	[ "$(git log --format=%cn -1)" = "committer" ] &&
+	[ "$(git log --format=%ce -1)" = "committer@example.com" ]
+'
+
 test_done
-- 
2.19.2

