Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DA22023D
	for <e@80x24.org>; Thu,  3 May 2018 11:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeECLFC (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 07:05:02 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33398 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbeECLFA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 07:05:00 -0400
Received: by mail-qt0-f193.google.com with SMTP id e8-v6so17379285qth.0
        for <git@vger.kernel.org>; Thu, 03 May 2018 04:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tF7g5+T51XoaB3dhKDkHHMexVUYBIB0ZX5VqwCSFM80=;
        b=TsP7xQJQSg5kexpmIqZaAetRi0m3bNGvce74tEFMdmF7FOPhb2BmiXxfpc2wSBswtu
         WIWDWRaHLPYCWqTssQuTpoyq0FnIJ6L6SuqkLMO11c3CzqdmVb8J75sDhHNGtsCrQUV+
         7SO66IuIHTEs9ha8Aum5XEfdV4J6IkL+svJ1nR0lp+o/DlbWeds/qBIFNaw9gdQQr9nA
         zt6nuBMOha78INt49lfcMCFfG9rOD2dgtpGl7iY2vJggA3rtHMPcPzeeLZRfA98aG1ln
         zThgyifuz5ai2/KYFcbhjfohVIhPGIA91OCk/t4qiOIKfRbKRdAwdxNdGkQ0uMR2dcrx
         Gzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tF7g5+T51XoaB3dhKDkHHMexVUYBIB0ZX5VqwCSFM80=;
        b=NfhVh5Aw4isZLRpTd4n8N2GSPVVhx9mIkXB9p6m3uL4Zcp5wIPTk7jIcSIpL0pS06P
         4XRAdgB4fWjgtTPErV+geds/zVX5A1UZua7sWJjBmRyOs+BgN0Px0+h0obxqy+zJyteG
         DN7OQB6FOFPH5esG25xFnmr9nBHn2OYKZhu0GtD7Kbg+tC49AxQjYIKeUz4EE1IXw1es
         Ctg0ARpRjq4bGPieQ2x6ZG5/kxrZEmNCoG4gbSAsdodEU2/mbyCZ5c07ZtGYn6J6Z2B6
         Aj7iXGgaj2SUFL/9zBYdIxMJrNTF7SPmUzSOXB70AgZ2/h0FlONtuJeMm+Z2A5bqSdj5
         ksbg==
X-Gm-Message-State: ALQs6tBHv6XEnUiWol/Zqgh31gbyHrOmVdDcvgmMe52RBlau9J8SZGsK
        Pzf6mIZW3hNjdz+Wd9yECFI8CuIk
X-Google-Smtp-Source: AB8JxZr+wF/stCIWczOQMluQzKKBKy2+/ccrk/D5xBg6vHXkNJvK88uCjSVcRNpz6QliFMIqoD/HLQ==
X-Received: by 2002:a0c:87a3:: with SMTP id 32-v6mr3003337qvj.171.1525345499890;
        Thu, 03 May 2018 04:04:59 -0700 (PDT)
Received: from localhost.localdomain (64-121-142-251.s4089.c3-0.eas-cbr1.atw-eas.pa.cable.rcncustomer.com. [64.121.142.251])
        by smtp.gmail.com with ESMTPSA id o14-v6sm12840833qta.23.2018.05.03.04.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 May 2018 04:04:59 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
To:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com,
        gitster@pobox.com
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Subject: [PATCH v4 0/3] Add --progress and --dissociate to git submodule
Date:   Thu,  3 May 2018 06:53:43 -0400
Message-Id: <20180503105346.1758-1-kcghost@gmail.com>
X-Mailer: git-send-email 2.17.0.1.ge0414f29c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches add --progress and --dissociate options to git submodule.

The --progress option existed beforehand, but only for the update command and
it was left undocumented.

Both add and update submodule commands supported --reference, but not its pair
option --dissociate which allows for independent clones rather than depending
on the reference.

This is a resubmission with comments from Stefan Beller, Eric Sunshine, and
Junio C Hamano addressed.


Casey Fitzpatrick (3):
  submodule: clean up subsititions in script
  submodule: add --progress option to add command
  submodule: add --dissociate option to add/update commands

 Documentation/git-submodule.txt | 17 ++++++++++++++++-
 builtin/submodule--helper.c     | 16 +++++++++++++---
 git-submodule.sh                | 21 ++++++++++++++++-----
 t/t7400-submodule-basic.sh      | 16 ++++++++++++++++
 t/t7408-submodule-reference.sh  | 17 +++++++++++++++++
 5 files changed, 78 insertions(+), 9 deletions(-)

-- 
2.17.0.1.ge0414f29c.dirty

