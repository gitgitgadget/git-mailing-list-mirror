Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB33B1F461
	for <e@80x24.org>; Mon,  9 Sep 2019 01:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbfIIByW (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 21:54:22 -0400
Received: from omta016.useast.a.cloudfilter.net ([34.195.253.207]:46759 "EHLO
        omta016.useast.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732197AbfIIByV (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Sep 2019 21:54:21 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Sep 2019 21:54:21 EDT
Received: from cxr.smtp.a.cloudfilter.net ([10.0.16.145])
        by cmsmtp with ESMTP
        id 70etiGXSMLe2C78luiC2xt; Mon, 09 Sep 2019 01:47:14 +0000
Received: from thunderbird.smith.home ([68.231.71.156])
        by cmsmtp with ESMTPSA
        id 78lriEE3LaXIW78ltirdd4; Mon, 09 Sep 2019 01:47:13 +0000
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
X-Authority-Analysis: v=2.3 cv=A9ISwJeG c=1 sm=1 tr=0
 a=3BwGCz7hYCwPRAPwzRnSaA==:117 a=3BwGCz7hYCwPRAPwzRnSaA==:17
 a=J70Eh1EUuV4A:10 a=5rxgeBVgAAAA:8 a=vZxbLtyPAAAA:8 a=QIikmRi9JciU9tiKHaoA:9
 a=PwKx63F5tFurRwaNxrlG:22 a=YIznc7gRMHvxYRuyG5Sm:22
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 95D86B826B1
        for <git@vger.kernel.org>; Sun,  8 Sep 2019 18:47:11 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] Date test code clean-up
Date:   Sun,  8 Sep 2019 18:47:09 -0700
Message-Id: <20190909014711.3894-1-ischis2@cox.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDi2KZrr2Q6RLnK3k5TNrbfcQrRq6S3O7Qqc+bZthSM0VLqsAAU8WlgN1JKup26qv8Jqo9yxRPD5GLJqFUOuSU3IwjJBLoYsAdPkJGyOcslh5SZgxbtL
 3fbLoydR1hsKUfbkuescGA099vWuVWc1iu6koe3epQV32GQ6Rxw9o6lIW5Kt08uxOh9XcGTCGAzsnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of a previous patch submission[1], a cleanup patch was
suggested to remove a now unnecessary passing of a date environment
variable to the production code.

While the two patches in the set could easily be submitted as a single
patch, I split the removal of the getenv() call into a second
patch. I did that to make the comment about the initialization of `x`
more localized to the change.

[1] https://public-inbox.org/git/xmqq5zuge2y7.fsf@gitster-ct.c.googlers.com

Stephen P. Smith (2):
  Quit passing 'now' to date code
  test_date.c: Remove reference to GIT_TEST_DATE_NOW

 cache.h              |  5 ++---
 date.c               | 27 +++++++++++++--------------
 t/helper/test-date.c | 27 +++++++++------------------
 3 files changed, 24 insertions(+), 35 deletions(-)

-- 
2.23.0

