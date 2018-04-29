Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB791F428
	for <e@80x24.org>; Sun, 29 Apr 2018 20:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754270AbeD2UVb (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 16:21:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40340 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754247AbeD2UVY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 16:21:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id j5so11156430wme.5
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+bHIm7PB8JLGb/EqtwO9wpZZPWinU7EB4rbuVFFPBfQ=;
        b=rnj4h7vX7dfNNjSQu263H0WeCsi0S5df1XLbqnojNIzTdox7hB/x8D9tZXNgxoWQb0
         sA+N65unskyKyiIIjFNUm6q5hQojr7U5pMv1av6xsq/5dQt1M2WiO3grM39x2BF74XWk
         klym88wIaCz/nN3heIDPhv5xQtvmI4DIAK4GNDHSa4a8HmXoqAScMkWYrrg8iK90DRcf
         pwsruLfZvVsa8hwsuFUxS7qRvu0P2e5aufgku3IyYNHAft7kWO8t8shKkbm4JLyGihkC
         NlJA4a0auBjhh4ivhNPVFrFEmvjaIQdxfDzjv/8qtc9wz36Yl10KJKLmkyso4Jxdq+C5
         +9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+bHIm7PB8JLGb/EqtwO9wpZZPWinU7EB4rbuVFFPBfQ=;
        b=lofnoHY1rYpmkenib29HJM+nij0rpscOYQIV2dC67V8yOPDbwyC9s5YW0zbdpR3ZgL
         Ai9foyj3JvLjZ0UWNnMlxSyaHCqUfM1519mmFz6ZlE8XH0G6TizqFuWsnB/ia4IoLE+6
         RdIc0r+ok3EtUnToWcdgUNm8Ig2emnzwSY66hJlE5m+QVBoCTHF9IoSVb9K4quLkvTx0
         vHfbN+ulQ0DndlNnkBXs9HP7SYQMDtfuid9XnJ3eKDIlLpXBTVmEzzSWv1NyF6rLCw4r
         ocnj9fSrv1WUmKyCcQCj3FAXXUMopQ/2VBm0s2L7wQHMTACWvFt4aAwNuoUBZl7btj/2
         6IuQ==
X-Gm-Message-State: ALQs6tCZYRjwruW4hrH7u/MT4GT805L4gsEMJDDTkw5Wz2p9OXH2LM9K
        nPYF8V0Ku5F81XCw8DZ7Alb+ZqH5
X-Google-Smtp-Source: AB8JxZp5X/Ao7fY083jipGQfwqNAlKprS5qECwajqSe5kmr71yZNCYYjg83ovHZ361aUiyCHodU0bw==
X-Received: by 10.28.66.73 with SMTP id p70mr5939447wma.17.1525033283103;
        Sun, 29 Apr 2018 13:21:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y42-v6sm8134917wry.21.2018.04.29.13.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 13:21:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/8] push tests: add more testing for forced tag pushing
Date:   Sun, 29 Apr 2018 20:20:55 +0000
Message-Id: <20180429202100.32353-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
In-Reply-To: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
References: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the tests added in dbfeddb12e ("push: require force for refs
under refs/tags/", 2012-11-29) to assert that the same behavior
applies various forms other refspecs, and that "+" in a refspec will
override the "--no-force" option (but not the other way around).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 15c8d5a734..c9a2011915 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -981,7 +981,17 @@ test_expect_success 'push requires --force to update lightweight tag' '
 		git push --force ../child2 Tag &&
 		git tag -f Tag HEAD~ &&
 		test_must_fail git push ../child2 Tag &&
-		git push --force ../child2 Tag
+		git push --force ../child2 Tag &&
+		git tag -f Tag &&
+		test_must_fail git push ../child2 "refs/tags/*:refs/tags/*" &&
+		git push --force ../child2 "refs/tags/*:refs/tags/*" &&
+		git tag -f Tag HEAD~ &&
+		git push ../child2 "+refs/tags/*:refs/tags/*" &&
+		git tag -f Tag &&
+		git push --no-force ../child2 "+refs/tags/*:refs/tags/*" &&
+		git tag -f Tag HEAD~ &&
+		test_must_fail git push ../child2 tag Tag &&
+		git push --force ../child2 tag Tag
 	)
 '
 
-- 
2.17.0.290.gded63e768a

