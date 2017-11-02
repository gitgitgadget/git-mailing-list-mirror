Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18D720450
	for <e@80x24.org>; Thu,  2 Nov 2017 06:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755242AbdKBGyR (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 02:54:17 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:45662 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755193AbdKBGyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 02:54:16 -0400
Received: by mail-pg0-f47.google.com with SMTP id b192so4270157pga.2
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 23:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=YM3cHX8aNmyjdCCM1EWhk5BHOZ9nwIvKNj24Yhi2ulk=;
        b=COr+UoGAUKOjbvVOHiiR0IASAGjqSOj36vjpMgbEAsMQm5BwkuzXBSjLSW2dYwAWRD
         jSvgVJ5HZZCa7wXZQ+ylQZaeJ9HmR0KM8OEjT9n6a72VggXw/KROykv0bAD3yTZ0+XmH
         g20Xrsi3RA36K7hQek9gY/2hUH4wjjJkK7NMVEPMwDspnwyZQRQ3LndfXjrIo/c27xEB
         RGYTbKYDZWYwjNbLT7ZrbkrM8dVtQh/EdaopOygm3zaYJIuMI1ComxJbFZzX9NyHjOSH
         ftMWoq2ycN6UZb8YAuApTppcXHEUYr8gqRI0Tb1K22arL23VqM1wKMtkGHSIjwokD8ZK
         iiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=YM3cHX8aNmyjdCCM1EWhk5BHOZ9nwIvKNj24Yhi2ulk=;
        b=eQvtDnphdYxVz7Oim38KNzf5rZEsZSpKOWgxqxCFw2coBkygE3zoXyWZVWT5UUwJVL
         c9Z6qidA8E8hM4cKfSFKmLioqy5y1iNgYInUoA5lX3yfbYLeXBcz3M8pWPfMAY7lvffF
         GYeTiRHyJqlUzz/oGPqWcIjAq5blUwyCWWUoRYlFMipGbRHlmz00IijqzallD7DGptt0
         /N/KRBDIwrEFDZ1ywJMmKMRp+vImGCagD5D23Ohic0WUugV1wCiOPS+OHwnYPg1AcHXQ
         1tOr4yDKn0tJALC8U8VfRZp4RgBg29e0HNubDp89YNrJqWch9hilALaOzkJLFAQ1+Fda
         DdRw==
X-Gm-Message-State: AMCzsaUdMAmBc67pOWYMzVqla9dGynPXhU3OgpuUDdGalxzxSqONPDOx
        pnwdyJl0zUhYZcwaSmX+sN8r56m+
X-Google-Smtp-Source: ABhQp+RNCBFp4xirbjC4CaEjwZldmdyj4BeQSfhXN8NAlIEaL6uGmlFEyi5qtVAZVSi4+JYj6pqu4w==
X-Received: by 10.99.113.29 with SMTP id m29mr2535303pgc.309.1509605655545;
        Wed, 01 Nov 2017 23:54:15 -0700 (PDT)
Received: from localhost.localdomain ([117.243.29.9])
        by smtp.gmail.com with ESMTPSA id q12sm3843567pgn.56.2017.11.01.23.54.12
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 23:54:14 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH v3 0/4] give more useful error messages while renaming branch
Date:   Thu,  2 Nov 2017 12:24:03 +0530
Message-Id: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.461.gf957c703b.dirty
In-Reply-To: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In builtin/branch, the error messages weren't handled directly by the branch
renaming function and was left to the other function. Though this avoids
redundancy this gave unclear error messages in some cases. So, make builtin/branch
give more useful error messages.

Changes in v3:

	Incorporated suggestions from v2 to improve code and commit message. To
	be more precise about the code part,

	In 2/4 slightly re-ordered the parameters to move the flag parameters to
	the end.

	In 3/4, changed the return type of the branchname validation functions to
	be the enum (whose values they return) as suggested by Stefan.

	Dropped the PATCH 3/5 of v2 as there was another series[1] that did the
	refactor and got merged to 'next'. I have now re-rolled the series over
	'next' [pointing at 273055501 (Sync with master, 2017-10-24)].
 
	This has made the code in 3/4 a little clumsy (at least to me) as I
	tried to achieve to achieve what the previous patches did with the new
	validate*_branchname functionS. Let me know, if it looks too bad.

So this could go on top of 'next' without any conflicts but in case I
missed something, let me know. The series could be found in my fork[2].


Any feedback welcome.

Thanks,
Kaartic

[1] : https://public-inbox.org/git/20171013051132.3973-1-gitster@pobox.com

[2] : https://github.com/sivaraam/git/tree/work/branch-revamp


Kaartic Sivaraam (4):
  branch: improve documentation and naming of 'create_branch()'
  branch: re-order function arguments to group related arguments
  branch: introduce dont_fail parameter for branchname validation
  builtin/branch: give more useful error messages when renaming

 branch.c           | 63 ++++++++++++++++++++++++++++++------------------------
 branch.h           | 57 ++++++++++++++++++++++++++++++++++++++----------
 builtin/branch.c   | 49 ++++++++++++++++++++++++++++++++++--------
 builtin/checkout.c | 11 +++++-----
 4 files changed, 127 insertions(+), 53 deletions(-)

-- 
2.15.0.rc2.401.g3db9995f9
