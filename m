Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D632070F
	for <e@80x24.org>; Thu, 15 Sep 2016 21:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbcIOVRb (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 17:17:31 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36072 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbcIOVR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 17:17:29 -0400
Received: by mail-it0-f67.google.com with SMTP id n143so180598ita.3
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MJWPyKn6w4P13ib+HmsBNWKkmqbVfNpsDtTGMbRhGwE=;
        b=wy9odiia+ydl28yHdG3uv3ojlPQufr0ZP99YHQaruSRtUwySsknDnukdqWd5EJ7hRn
         aZMskKT7Rax0fNZNozG+fUE3nddLzN0aTl9na206T4Du2yNwntfMiMLZjI2VGhe3TSgo
         q5TK3rhKU9cYQvLZ4lUMeRKANzQsDv1BGLGwgHORklrvOvqIFDY6gJT9cLYWNV4jjtVf
         6VOW9eutTR51f40MIaAfcL5FQAAtp2wD04V9mQukj4U4Alfjf7JpVuBRRLFWvGDsE6iR
         vVkLMB27TUssHmheb71O4uHVexEMAkXYJ/bSQOv8d4kw243SOyl143fp0iGl6MzdVCJA
         +s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MJWPyKn6w4P13ib+HmsBNWKkmqbVfNpsDtTGMbRhGwE=;
        b=BQSz1RtR+BCdhsR/pgPLvhQSjo7Rf4TL6bmRQ8yweh+HRDkfCFZggzcx5ZY5Jjw7Tk
         0VW7TO3MVZQMGCsm+nP7C1imOi2dg5YmNfzdGI5NNrnlLllVLYxo7Hrw6wnnWEc/c945
         0Tl7f+GJNFIvr7L0dHaY83RzwSb8pFybnzDqrJvcB7GA6irn5Z/Vc6T3s+8ZhaAqlsSV
         SPLMT6cdW64d51Swf2KZKfdWgo50I+5zni9Lnco8MIcCBBL0B0WgKtL0E9P1nzToFZMd
         FyUvkZ748wJ3vRKvK+kYLVMBEGbcPn9NDZe+HbsAIG0dnSWJYp/JPrV4zhtWTIAzN5F8
         VAiQ==
X-Gm-Message-State: AE9vXwPf6PM4SVI50a1fd5vlHjTgOPbXw5dxPxDwFist1ZoqcSFhl3CR4UPboRMq9i78wQ==
X-Received: by 10.36.28.203 with SMTP id c194mr1988020itc.95.1473974248226;
        Thu, 15 Sep 2016 14:17:28 -0700 (PDT)
Received: from CHIC02QV065G8WN.sea.corp.expecn.com.sea.corp.expecn.com ([172.56.12.80])
        by smtp.gmail.com with ESMTPSA id 103sm2418177ioi.29.2016.09.15.14.17.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 14:17:27 -0700 (PDT)
From:   Ori Rawlings <orirawlings@gmail.com>
To:     git@vger.kernel.org
Cc:     Vitor Antunes <vitor.hda@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>,
        Ori Rawlings <orirawlings@gmail.com>
Subject: [PATCH v2 0/1] git-p4: Add --checkpoint-period option to sync/clone
Date:   Thu, 15 Sep 2016 16:17:17 -0500
Message-Id: <cover.9c54bbdd9f054215b5432c4ba3081110e2e91724.1473973732.git-series.orirawlings@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1473717733-65682-1-git-send-email-orirawlings@gmail.com>
References: <1473717733-65682-1-git-send-email-orirawlings@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Importing a long history from Perforce into git using the git-p4 tool
can be especially challenging. The `git p4 clone` operation is based
on an all-or-nothing transactionality guarantee. Under real-world
conditions like network unreliability or a busy Perforce server,
`git p4 clone` and  `git p4 sync` operations can easily fail, forcing a
user to restart the import process from the beginning. The longer the
history being imported, the more likely a fault occurs during the
process. Long enough imports thus become statistically unlikely to ever
succeed.

My idea was to leverage the checkpoint feature of git fast-import.
I've included a patch which exposes a new option to the sync/clone
commands in the git-p4 tool. The option enables explict checkpoints on
a periodic basis (approximately every x seconds).

If the sync/clone command fails during processing of Perforce changes,
the user can craft a new git p4 sync command that will identify
changes that have already been imported and proceed with importing
only changes more recent than the last successful checkpoint.

In v2 of this patch series I've added some basic test scenarios,
documentation, and did some minor clean up of the implementation
based on feedback on v1.

Ori Rawlings (1):
  git-p4: Add --checkpoint-period option to sync/clone

 Documentation/git-p4.txt            | 12 ++++++-
 git-p4.py                           |  7 ++++-
 t/t9830-git-p4-checkpoint-period.sh | 59 ++++++++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100755 t/t9830-git-p4-checkpoint-period.sh

-- 
git-series 0.8.10
