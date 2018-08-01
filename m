Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCEFC1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 19:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbeHAVVp (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 17:21:45 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:53983 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387396AbeHAVVo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 17:21:44 -0400
Received: by mail-it0-f73.google.com with SMTP id e5-v6so219631itf.3
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 12:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/njajei5g0IbFs6bkyV+vrt97VR7R3e1lK84H6LIblQ=;
        b=qs1mFHv9Ir00on8seb2JkJ2F0hFo4OMytteOXRonxsfq/C23lfo/j/wgmMS/ixCI8J
         Uh0b4U1fFpxnJj4p7pYaOdH84oUqi6CSfm95CHR9ikO4+4y8iouS522R3ZYqhKQuyk0V
         sMkrCF/EsgqBXcHRjfWClNRLpxAZSVEs6V0lD2D3kOB96mqohpUa9e9sBo2HIaLoEHfc
         5ACLGkrLOYTcZPq3qLML70HVl/yt2+DyE9vXln0YDwyk1hKPb1Tzbr1hi+Wryk+Mguwl
         /M2azJ7K4OMuy/I5ZxEeM50GM78DAU5PbOPsbgd+FnkubwbndNSnEmBrsqJGACGPK6XW
         8klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/njajei5g0IbFs6bkyV+vrt97VR7R3e1lK84H6LIblQ=;
        b=ny3rjABnF/5WbFfXrzTL3ufRd7MCIUJvpvcV4IxmlCoJnQ5BhsGT9ygCJUvePCUfQ4
         OMkvIOoPr8OaHbrHNH+9hkkZJ+Ur6uof9IcgYzRctluZ8RdC8l4GRPzKRmzsbB4zH8gK
         ciXi4ErbDl4hTZyXGha3q4E7u8rTa8wFJGMYJFiDILxwVH0JMRwyHNJTITCBCNugodLg
         Lf986HbPHg+kcSg/VtizidB6ua4iiHeLh8nFdC/nIgSba9T9uFn6XuZ3nyip8GKxY75O
         DrVyy/5ix8/PElo4M1CWk0oJEF6Tpwqrrn9+NEvt0+xyVrgdPhhm3vh/1RYWuXaMl194
         BtKg==
X-Gm-Message-State: AOUpUlHD0kOloi8AyLaxhqirMx9Y+IBWC1vdzm1/u6jsLJp86UDWEMTB
        qdvAu5fxIL8+UkXM0Re5fYZ2LcZBzlYf
X-Google-Smtp-Source: AAOMgpfXb9wFG+zCJJsNPTtFzhS7Zjalot3VdcKncQ12mxN7q1p4G7A5obkCnuq4p4bpX5MqhE4d+J0lDh93
MIME-Version: 1.0
X-Received: by 2002:a24:2b82:: with SMTP id h124-v6mr117005ita.46.1533152065640;
 Wed, 01 Aug 2018 12:34:25 -0700 (PDT)
Date:   Wed,  1 Aug 2018 12:34:13 -0700
In-Reply-To: <20180801193413.146994-1-sbeller@google.com>
Message-Id: <20180801193413.146994-4-sbeller@google.com>
References: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com> <20180801193413.146994-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 3/3] git-config: document accidental multi-line setting in
 deprecated syntax
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
        peff@google.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bug was noticed when writing the previous patch; a fix for this bug
is not easy though: If we choose to ignore the case of the subsection
(and revert most of the code of the previous patch, just keeping
s/strncasecmp/strcmp/), then we'd introduce new sections using the
new syntax, such that

 --------
   [section.subsection]
     key = value1
 --------

  git config section.Subsection.key value2

would result in

 --------
   [section.subsection]
     key = value1
   [section.Subsection]
     key = value2
 --------

which is even more confusing. A proper fix would replace the first
occurrence of 'key'. As the syntax is deprecated, let's prefer to not
spend time on fixing the behavior and just document it instead.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-config.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 18ddc78f42d..8e240435bee 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -453,6 +453,27 @@ http.sslverify false
 
 include::config.txt[]
 
+BUGS
+----
+When using the deprecated `[section.subsection]` syntax, changing a value
+will result in adding a multi-line key instead of a change, if the subsection
+is given with at least one uppercase character. For example when the config
+looks like
+
+--------
+  [section.subsection]
+    key = value1
+--------
+
+and running `git config section.Subsection.key value2` will result in
+
+--------
+  [section.subsection]
+    key = value1
+    key = value2
+--------
+
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.18.0.132.g195c49a2227

