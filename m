Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6BD91F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933615AbeFYQrE (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:47:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54794 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933192AbeFYQqx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:46:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so3076245wmf.4
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0wjXEsX95vhzVPt5PUVmrkW4ocbtOrvUuXIvn8IJxVY=;
        b=QR9cvdygl6000qdiS0gy8cNbv1Gsa7YDdinWMKfjLqRGuhrjg4mnRNgGR13bJoFJZL
         tkOMu5M5f0tKPlq9ke2wPu7jFrI0WKL1+KsoEz4zLLQQA8gJNQRb0SjAF9lh0d/3lDbp
         Mu6WQBoUri1PKoKzJNKbCpMSkCWkMaL00x+f/MdMbW+3SC/Q7wAP7/dqpQhdXkmRT4Wm
         yl3T2LFmoDKNvzOsURueSwZl+PEb6thfFQsEXKSdj4QNfclx9ARHbErpW7v8E3R7iDYL
         vDtLx3cqtI60meQmmp27GT7+DTMOcfQ9PnzHJc59qik+9wTZdMv/r0RHgH+LtXduXILD
         6sZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0wjXEsX95vhzVPt5PUVmrkW4ocbtOrvUuXIvn8IJxVY=;
        b=CkS6J2mRkbhvwSjRuTUZK0/ALHMKisDYy3dEjBlqpaWDREN2wsb0cyaTPTgLY6wZlj
         imFuDX/s5GLOBOJZDtEKwnNxQGM6rK0A0zNqWNjsSwptyk1e2ik/GexXvpj+WQJcl1ib
         R9kETPFhAvi4YtGRRHpv7kxpH7hDTkM8qTtOGPIKWQW+3cTfLQFIAfY+Jf7JRjxOEkxm
         ReKLqKzmaa9d5q+k8++CJwOjC5nDPrhxBneQUh8G4YUqgvRgnRSLRArx0fAliyu9XQFF
         +FFhfjU2S65+Yl5v7Pwx6w70KqV8Yb+xAIWZUo2Rlv6x2U+kz+8WOGYmeUZYmlvkFBJW
         nH/Q==
X-Gm-Message-State: APt69E2YOkAVxjPKqUsoXp6SE1vhjBhqSiXtTVAgMafGiU6OwHiAqdtZ
        zclt/QE+FN1NMcrSOmWCh2laVGr9
X-Google-Smtp-Source: ADUXVKIYIK5jzidmB6/AVsS1fjxeaj6iMarx1FDMjpeIWdRZ5LfVWp0e6bMbMHr3M1XXunR0put3lw==
X-Received: by 2002:a1c:850c:: with SMTP id h12-v6mr1581095wmd.116.1529945212019;
        Mon, 25 Jun 2018 09:46:52 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id v10-v6sm26419997wrn.97.2018.06.25.09.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:46:51 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 5/6] stash: update `git stash show` documentation
Date:   Mon, 25 Jun 2018 19:46:38 +0300
Message-Id: <dcd10e941418cbf4bbc50719f1f567f4025fe123.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add in documentation about the change of behavior regarding
the `--quiet` option, which was introduced in the last commit.
(the `--quiet` option does not exit anymore with erorr if it
is given an empty stash as argument)

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 Documentation/git-stash.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index e31ea7d30..d60ebdb96 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -117,6 +117,9 @@ show [<options>] [<stash>]::
 	You can use stash.showStat and/or stash.showPatch config variables
 	to change the default behavior.
 
+	It accepts any option known to `git diff`, but acts different on
+	`--quiet` option and exit with zero regardless of differences.
+
 pop [--index] [-q|--quiet] [<stash>]::
 
 	Remove a single stashed state from the stash list and apply it
-- 
2.18.0.rc2.13.g506fc12fb

