Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44FEF2027B
	for <e@80x24.org>; Thu, 18 May 2017 08:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754202AbdERIWM (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 04:22:12 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33428 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753712AbdERIWH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 04:22:07 -0400
Received: by mail-qk0-f196.google.com with SMTP id o85so5043543qkh.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qGcBnbbrZduzzcdC//HBMAS+8TdfLTchPVfA+eozPcw=;
        b=jHeXIO/Nkp6iPFTYaCtj7ev9MGYl0IVUwEIzQEh4jG8tEYaPaq5GFrw8tYZ9JrsMWg
         oP4ER+h284NM/yqpuDjOX1knBlDu3aWSEkU/29w4y9wq916yMeekOq3HC7zPoO/n+zwX
         s8zfbpkofe2mgRYfFJQHSsk7QyQ1PBwK+qUMjd6wyV/z0K9FXdp1rb6ylJpBNUSfvWvy
         OeJ5h9vRQjkjns+GKU/PJP+prmQMAUuiaKqQMIAhaAeBuOSozqfi3UNjjO2/d5nP0Y7E
         erjsPf0iNa0h2+8QS137+TUgQY8hKXtAksGnZkXzO7nrnxf5eI+62+5+MVV0inkiYas/
         UHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qGcBnbbrZduzzcdC//HBMAS+8TdfLTchPVfA+eozPcw=;
        b=QC6Q7TtjxlatW5piiwQE0B8SJVnlO8k0YTz6oDn9NWRSSlvxxwf8JZjaX9hz/c0rCE
         WHWqjf1NCkbUf+MLJ1OsR+zA1ymXrl6FF69R3Z9OrOk+4GhWKPeMTJyoeoZhB16E2V2J
         4GaXjJwnLIyvMzu+DqgFsWD2Q5U5zchEpu9S4ncuR3FBFDLPcAjkFNMCmMl1/iTrg6zD
         6njPkUwbVUoHapqoF/2Tq1bpo+KsLB4EzYg6Fes/O9Pp/Z8f7UuZrLslFO0TcXFVEap3
         gg0sgCMHvfpUplrZ+s5JCGNMAui5KugdN+eeRebqnRGlDg3B3H9c7loM4kNr1XENag9n
         JLdQ==
X-Gm-Message-State: AODbwcCgfZz/jzIcWCG998HbdmW6gtZDCr1rhFuyGx7USF+GXv4D59yt
        cUDklBWIh47OTA==
X-Received: by 10.55.111.198 with SMTP id k189mr2901109qkc.160.1495095726993;
        Thu, 18 May 2017 01:22:06 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id k36sm2999604qte.65.2017.05.18.01.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 01:22:05 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v4 0/6] Fix clean -d and status --ignored
Date:   Thu, 18 May 2017 04:21:48 -0400
Message-Id: <20170518082154.28643-1-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Incorporates all of Junio's feedback on v4:

* squashes test expect_failure -> expect_success flips into the commits that
  fix them
* the O(n^2) pruning loop added for DIR_KEEP_UNTRACKED_CONTENTS is now O(n)
* the logic in cmd_clean() that keeps the contents of an untracked dir from the
  del_list is now hoisted into a separate loop

Also includes the following:

* expands the test I add in t7300 to check clean -d, for better coverage of the
  pruning logic in cmd_clean() (the logic that tells clean -d to not remove a/b
  and a/c if it's already removing a/)
* documents DIR_KEEP_UNTRACKED_CONTENTS in the corresponding technical API doc

Samuel Lijin (6):
  t7300: clean -d should skip dirs with ignored files
  t7061: status --ignored should search untracked dirs
  dir: recurse into untracked dirs for ignored files
  dir: hide untracked contents of untracked dirs
  dir: expose cmp_name() and check_contains()
  clean: teach clean -d to skip dirs containing ignored files

 Documentation/technical/api-directory-listing.txt |  6 ++++
 builtin/clean.c                                   | 38 +++++++++++++++++++-
 dir.c                                             | 42 ++++++++++++++++++++---
 dir.h                                             |  6 +++-
 t/t7061-wtstatus-ignore.sh                        |  1 +
 t/t7300-clean.sh                                  | 16 +++++++++
 6 files changed, 103 insertions(+), 6 deletions(-)

-- 
2.13.0

