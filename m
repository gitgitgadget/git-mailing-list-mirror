Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253151F597
	for <e@80x24.org>; Fri,  3 Aug 2018 00:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeHCC2O (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 22:28:14 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:37285 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeHCC2O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 22:28:14 -0400
Received: by mail-io0-f201.google.com with SMTP id l5-v6so2914999ioh.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 17:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/njajei5g0IbFs6bkyV+vrt97VR7R3e1lK84H6LIblQ=;
        b=q/cekBpF0MnEQQMYteUZ+akR45hRO7aEOmD+XMJNK+cTki1Fu7VYxMspGKQlx347yA
         KGaJrT1UXIiBQAULSkAMLzwhqWZTX614zBqRji/2JQdCmtNZEvCP7WfNssAAE0pJpq2y
         xOwphWrBo6qbHGvDF7/Pz7zIoa+p+lmxvgbhtd0q/tF8eyujaK3evsot0zXhaMbQpEpT
         /YaX7vz+B90NvlOFRgCJ3fJBbTvUkwRp68PfeAnOwur/rKXka6AlT7muKiHUV3K5VevB
         a0tuCizTsRErMFrs6LC0OCzFME6AVq+54I2TccNMH1evlXwzafVqVsMmXeKVALqghNSM
         /7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/njajei5g0IbFs6bkyV+vrt97VR7R3e1lK84H6LIblQ=;
        b=XA5FMQ9K5HfH0EhyYJyFq6ajJKjveeZhB/xQ2MCA4C8QdC3+E2ZDAZK5/i1vHiBNdZ
         z3CLSIJO+B0HpeAZU8i7/Ju4+CyJ0KsW3Ak4wd73Q4ebd80XQtF+3if2BkItbGmI1gHp
         buDzeNOkLZZcW14Uf6D0XaWCo0cTi9KIFh1xDCGwIuHxcrQDyLRTXaWtdWGHziOMLK/G
         j66hVd5Oa1KAk5N49mQASJp64UBIsWifnHu0AiiGVrm1MXKtCuvwtGSBOc7r7am25BiE
         Z8+QL43HOXQjrt0zf2jnGBpPiBiUBO+n0lHoOC/I7rgXkf9fZHw1L7eNfBpy/suzTzhP
         PCNQ==
X-Gm-Message-State: AOUpUlHKSy+ITEd8hM3hE9pcc6IoRzjl1a3zFuwX8Xc+2+Og/n9wTpcc
        P4i7hp27xO7pu3nKdxBOJIShnyn8lwfB
X-Google-Smtp-Source: AAOMgpcVR94Xhq8Yt0v0JNl4yTdplzXwmoiqeh6dALdKY3tb8A3f+OjvIClt8TlgcViUmxB15psQszYWlmOw
MIME-Version: 1.0
X-Received: by 2002:a5e:8c17:: with SMTP id n23-v6mr2004171ioj.132.1533256475524;
 Thu, 02 Aug 2018 17:34:35 -0700 (PDT)
Date:   Thu,  2 Aug 2018 17:34:17 -0700
In-Reply-To: <20180803003417.76153-1-sbeller@google.com>
Message-Id: <20180803003417.76153-4-sbeller@google.com>
References: <20180801193413.146994-1-sbeller@google.com> <20180803003417.76153-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 3/3] git-config: document accidental multi-line setting in
 deprecated syntax
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, peff@peff.net
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

