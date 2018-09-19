Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F9E31F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbeISWJ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 18:09:26 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:46863 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731983AbeISWJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 18:09:26 -0400
Received: by mail-lj1-f181.google.com with SMTP id 203-v6so5625260ljj.13
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 09:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDgNAyrFZYtb9v6tkUHn9s7OerKlkbcz2+KOs1ZoPl8=;
        b=I3xOZU/pa6Gxxr6r8h4djbPVaE5//l3wJ3Piln3Eem5d8aOBPK1fVQxF80rdUwaqci
         1rV3hm2K+5FlFJPviRI9ShKIRSN9uTuCTiNQaQxefua9Cd8fXdCPzRDYMhdgpDgy11Cw
         x87dc1AkWLiZTiX0inFNMT0fhNcTb5Yx6s/1TJ7kqlm2PhgAY02G01fbIQ6j8aV0pKIs
         UU8RZK8kjzQxOKR3E9RHujwXRyQpjFuYSI9+Ppd9ew3oU/odnuPv3FpxkW/2o6yjvXRS
         zzf7Zu36C9RXUOtlAEwNbX+8M73FZj2f2N0ZsQSCCkD0q6ube+JagyAfyNqeaVtU0TT2
         xUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDgNAyrFZYtb9v6tkUHn9s7OerKlkbcz2+KOs1ZoPl8=;
        b=AdtiLu3HMoS2BfQ1qfwC0V0zMZImETnQB6A4Lo3tn+2ghaD6Mj0orw5Vt0QMmw0zl5
         O5DTixoIfKh1wURmv/vnBDgbK3woLR+5OADUd2V9JGFo0avKEC1RHYJkdilY8EXsklO6
         aW9O4pchTMip1X3iCzoqW7uEROUTUjeLrivisuTPfPkFSyR33z7vykfGz48aCk6/+tqb
         DkBNdrK/9oYYHaSO36aQ2BoOoFjo44E5Dq/qEGFN+AV8uMOWQPU+A7Mv4GCZfBLMEHGf
         j0UiyRpMQ4rCTRJkkC+zxmNZkTflnral7sKgpUrwMhwHulwVfZfUz/ma6g5vFcbV83bY
         QCdA==
X-Gm-Message-State: APzg51Aka4F2xrMf4aL1xYJUmff5xdpaQhAQN5RXETmJv8ZE9hFNAWEA
        eM0xbC/BxfhrvLc64ArCUconXC4x
X-Google-Smtp-Source: ANB0VdZUHf1wrZwqlNxbT8Z3WHCEaitO3xSQjeR6pHPv/iuzB4NuZBF4smUENH+OIN/owje26i0wuw==
X-Received: by 2002:a2e:9448:: with SMTP id o8-v6mr299559ljh.34.1537374644512;
        Wed, 19 Sep 2018 09:30:44 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id x8-v6sm3903594lji.53.2018.09.19.09.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 09:30:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 0/4] git-commit-graph.txt: various cleanups
Date:   Wed, 19 Sep 2018 18:30:31 +0200
Message-Id: <cover.1537374062.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch is a bug-fix. The second applies some more
`monospace`-ing, which should also be good thing.

The last two patches are based on my understanding that `git
commit-graph` handles the "commit graph file", without a dash. If that's
correct, there might be more such cleanups to be made in other parts of
git.git. If the dash should actually be there, I could do these changes
in the other direction. Or maybe dash-vs-no-dash is not an actual
problem at all...

Martin

Martin Ågren (4):
  git-commit-graph.txt: fix bullet lists
  git-commit-graph.txt: typeset more in monospace
  git-commit-graph.txt: refer to "*commit* graph file"
  git-commit-graph.txt: refer to the "commit graph file" without dash

 Documentation/git-commit-graph.txt | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

-- 
2.19.0.216.g2d3b1c576c

