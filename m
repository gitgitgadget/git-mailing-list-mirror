Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB9C1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfFGBJP (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:09:15 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:35185 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBJP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:09:15 -0400
Received: by mail-qk1-f201.google.com with SMTP id u128so271308qka.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UJylFcBhyWRhWp1/F3JaKHpmPKsqEpF5jeiskTNBO0I=;
        b=MasofLBAAhAunA4MGUandSdL73ZNdDIwkDEnGGDxXhM9kTfWQy5acUNaWUTWAh5Wab
         xuuSqqtJvvBncyQ7DcV9SOw2LsC6N9JqSfWg1q6xoL/MEsuxAqpsQNLwPNqHoCUY/o+C
         ONJLmua7X+r0XwJqlMigpdm3rrk7G7+wSwk7ZTC/PxTm6uDs10fAjltdDH0+UfuaBtlv
         D9wcvofaXK8H2TsVW56kI7QqO9fSqSzzzoYoZvmyxWcubgF3KdWKqXGc7vz0jHQQskDO
         kBen/D131spSqHkPb4geAonSL2+YVmUslyBH2UeiMHvz3Q/MYc/Y1paH8fm4uiDoXY6H
         g+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UJylFcBhyWRhWp1/F3JaKHpmPKsqEpF5jeiskTNBO0I=;
        b=Fr2GQYgFIe8ZAFB9MkcwoUzo51W5CRfNhbyddeNvUHNASbV9xhV51tzfN+kuRLnmK7
         vyCsTtUEX7nooCtTp1c7k6YVnZ9vAIYLC7Zn7DBv5pl544n70u3IxLpd+IzsC+oFAgJz
         jkm60iuUqOXvOAay/DpwR4BXOhQhQ+CSJDEsv+ANnDElXM/4mM8Wc1eH1hQ0xUKjPPem
         kwYbmxTY4tzATEhTaR/0n7Vva4B8zIplAaD4U7YuhbrlJC1w9FdtBYQirEHxPP16IkyO
         rSyuMJvfmEAQK11b4E8Fkkkh+NFVWw8ZAlV/amzv40ixz4DM67EkcujlqlSM+2jG1QE2
         S47g==
X-Gm-Message-State: APjAAAV5pklh0+JuRvL5gflsSHBP5gSsRxAMzfv7U3OebUCexQO/E9w8
        eayhMvZ/ZjEl0GUmQwOgS4oAgO5X5rOD6iv6wdUEWnWQXe+nQNSsBn4yTiqnWPGi0hwBOr3ycBo
        GYCgiart3Vxoan/Z4xEgIZ7/OIqPF0abVsyoHMeyycGMzbJw3k9fHs8WaxcgeZz9xhKOtNGxmtQ
        ==
X-Google-Smtp-Source: APXvYqzt+VuBb0HUsAun0gmGCrxrQP7X7sKRm+M0Dgt/+f+5u3l6tC0M1ydQJp69Mm+xcn/rvBe0vfQzHm+5P3NIfWo=
X-Received: by 2002:a37:5d44:: with SMTP id r65mr34681387qkb.73.1559869754043;
 Thu, 06 Jun 2019 18:09:14 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:08:06 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 08/13] walken: demonstrate various topographical sorts
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Order the revision walk by author or commit dates, to demonstrate how to
apply topo_sort to a revision walk.

While following the tutorial, new contributors are guided to run a walk
with each sort and compare the results.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index 6c0f4e7b7a..716d31f04e 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -61,6 +61,11 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
 	
 	/* add the HEAD to pending so we can start */
 	add_head_to_pending(rev);
+	
+	/* Let's play with the sort order. */
+	rev->topo_order = 1;
+	rev->sort_order = REV_SORT_BY_COMMIT_DATE;
+	/* rev->sort_order = REV_SORT_BY_AUTHOR_DATE; */
 }
 
 /*
-- 
2.22.0.rc1.311.g5d7573a151-goog

