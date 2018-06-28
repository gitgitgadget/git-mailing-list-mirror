Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4F81F516
	for <e@80x24.org>; Thu, 28 Jun 2018 07:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964998AbeF1HsI (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 03:48:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32903 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964960AbeF1HsH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 03:48:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so2369634plb.0
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 00:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Waf/jKXlDU1YXT4Z5vLy6IGAkPxZG02xPAEgHARkIQ8=;
        b=rM0RlKrPoJQz4NeF+q2uupqxtfhvhdBZ92ZWzs3epFGrbCIVrPFrPZHqYURNLvyR2+
         6gOZ/Qj8neMUj/t0uO6FtsoCksjlu/xiuT9/j5tZnCXN4n9gAgwIbrqoqS0na8Aez/ET
         fssEuw2XFSiXR7RB5Ni8NdC97Q2wzEapFYfmX5hw+xy+/mj9vretaEoQItCoiZNnhrbQ
         bjg6qhopMk/vkoOYzXEfZ2QxG3MQr6g3d3YWrsZ3pameQlDlQaK7tmkYtVXDxY0jnqBX
         deacZxnGZZgLzvaok6K+WwQwnr8zJ0g12iqQ+hJhlSFpG8yHu7pQrxbJ6UxyrdP7bbDj
         jjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Waf/jKXlDU1YXT4Z5vLy6IGAkPxZG02xPAEgHARkIQ8=;
        b=Nm35hfdWYRL/+wCll0CLkoy2w8wObpBluySHfusgSR+I5d4OSclhjHHKytcTJUtoHh
         4tjPefWOiTdRyUE8Su/9fbaKwTCsQQ4QprAIp7qBn2NbgJ0knj+OcitNBIabz2Y7a5NH
         DKx88sIScEEIdVOSqAoUmXeS7E/UPsRvJUWiAsVM6kk23qiAQd6MOTnSxA2pGvSIc5ru
         vaSgfYGXGQST07IqEfCCgDGn3JAxrVeI3Y115ymEpM8BbqhEPb2B209xFIkOVjFNGqlF
         iHQIRxtRt9ACW1Z95QG9cBFqr6NROwrxjW9cNTloicI4nas5OBkl2qDmr/iFV8/NsFTI
         0ElA==
X-Gm-Message-State: APt69E291XCIHS085Ku/wTZokQ264WhG9AmBBGp0eFhCEHoFEgvd4PTp
        11zrH4wCizq2OTTyplOZG7BdzKh7RqY=
X-Google-Smtp-Source: ADUXVKK0pPJ93JhWTP70NhVSQ/0dzsK9c/UESiOB/ABl+qfhBoUYxfll+X7gbXnsOUPfirBH9OfWsA==
X-Received: by 2002:a17:902:b585:: with SMTP id a5-v6mr9326532pls.325.1530172086506;
        Thu, 28 Jun 2018 00:48:06 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.160])
        by smtp.gmail.com with ESMTPSA id x90-v6sm23416168pfk.151.2018.06.28.00.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 00:48:05 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH 0/5] rebase: rewrite rebase in C
Date:   Thu, 28 Jun 2018 13:31:50 +0545
Message-Id: <20180628074655.5756-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a GSoC project, I have been working on the builtin rebase.

The motivation behind the rewrite of rebase i.e. from shell script to C
are for following reasons:

1.  Writing shell scripts and getting it to production is much faster
    than doing the equivalent in C but lacks in performance and extra
    workarounds are needed for non-POSIX platforms.

2.  Git for Windows is at loss as the installer size increases due to
    addition of extra dependencies for the shell scripts which are usually
    available in POSIX compliant platforms.

This series of patches serves to demonstrate a minimal builtin rebase
which supports running `git rebase <upstream>` and also serves to ask for
reviews.


Pratik Karki (5):
  Start TODO-rebase.sh
  rebase: start implementing it as a builtin
  rebase: refactor common shell functions into their own file
  sequencer: refactor the code to detach HEAD to checkout.c
  builtin/rebase: support running "git rebase <upstream>"

 .gitignore                      |   2 +
 Makefile                        |   4 +-
 git-rebase.sh => TODO-rebase.sh |   0
 builtin.h                       |   1 +
 builtin/rebase.c                | 282 +++++++++++++
 checkout.c                      |  64 +++
 checkout.h                      |   3 +
 git-legacy-rebase.sh            | 678 ++++++++++++++++++++++++++++++++
 git-rebase--common.sh           |  61 +++
 git.c                           |   6 +
 sequencer.c                     |  58 +--
 11 files changed, 1105 insertions(+), 54 deletions(-)
 rename git-rebase.sh => TODO-rebase.sh (100%)
 create mode 100644 builtin/rebase.c
 create mode 100755 git-legacy-rebase.sh
 create mode 100644 git-rebase--common.sh

-- 
2.18.0

