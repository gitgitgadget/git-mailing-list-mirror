Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B24A201CF
	for <e@80x24.org>; Thu, 18 May 2017 20:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbdERUOR (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 16:14:17 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34103 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbdERUON (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 16:14:13 -0400
Received: by mail-qt0-f195.google.com with SMTP id l39so7164646qtb.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=msmGI6MzqXzRN4su2b3ESeqavtgdUqoSXYQXvPTxGKQ=;
        b=j2YOLtdyIvmKEmL9fWVtrV2c5MGZ9M0rMI9kirNTI71wqTaHVT7bbcszwVIMEeNvSc
         qexqHNCv+GSEkSHPYQzayomCZVRjUNy22myzAYYWUj71Ir7liT19ui6Zas6wkTkUS5RN
         4cFXLVR1KnVep1Bhq78UQ+5tF7vdFlJl85x1b+HQTZu68IUMolN5SI9H7+Tsfa+6ptNk
         pH9CbDKN9tAcgJCiysyuvg2Jo6pM4RcflgAkDulB+dtjqj7KNxTjtXNJ2wQ3vpA9zNnb
         EympBlry5qupdzEy+5gK46eB9H+62kYlMppmwvljLj4zFQUylS7bmoW7pnwYohLa49qp
         Mjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=msmGI6MzqXzRN4su2b3ESeqavtgdUqoSXYQXvPTxGKQ=;
        b=fiQeNH2iS7++7K29sYpKROFUCEL4NOsuGWbrtfjdNFvFwhPE7mElVYXjgydjox6kbj
         FYDHtXR1rHjMqKA0XekHx4PhZ+f4Oxxi68v87Z5KP0saLYrIpMwtMuGY7LdGLRPaH8sh
         M5R3XPqzoWex+6/91bOvjGN4ozpzGX4bhKaSvAm4QjTZ/73ENc6F+FC1IWpdDTl0L5dd
         +RY9B+RMuN4GasnUIMfrCvkCAy2c6luaWKPpqe+qs4yJW3LMcd1mJZNZmf5WRB+1Nrbu
         Al5t2OOBR6u4hwgVM82wuhwi9qv//FADhy8c1S1LOcTt7ybCa9YzodtJW3vSEpjIPcFi
         8eyg==
X-Gm-Message-State: AODbwcCfy09/0VF+d3FfRVWeZw8n8L5gCg0rYb41Jn751KXkLgENsJVw
        LIwUj4m5Si5GTA==
X-Received: by 10.200.3.79 with SMTP id w15mr5800156qtg.203.1495138452809;
        Thu, 18 May 2017 13:14:12 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id y17sm4369133qtc.29.2017.05.18.13.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 13:14:12 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v2 6/6] fsmonitor: add a sample query-fsmonitor hook script for Watchman
Date:   Thu, 18 May 2017 16:13:33 -0400
Message-Id: <20170518201333.13088-7-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.6.g4597375fc3
In-Reply-To: <20170518201333.13088-1-benpeart@microsoft.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This hook script integrates the new fsmonitor capabilities of git with
the cross platform Watchman file watching service. To use the script:

Download and install Watchman from https://facebook.github.io/watchman/
and instruct Watchman to watch your working directory for changes
('watchman watch-project /usr/src/git').

Rename the sample integration hook from query-fsmonitor.sample to
query-fsmonitor.

Configure git to use the extension ('git config core.fsmonitor true')
and optionally turn on the untracked cache for optimal performance
('git config core.untrackedcache true').

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 templates/hooks--query-fsmonitor.sample | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 templates/hooks--query-fsmonitor.sample

diff --git a/templates/hooks--query-fsmonitor.sample b/templates/hooks--query-fsmonitor.sample
new file mode 100644
index 0000000000..4bd22f21d8
--- /dev/null
+++ b/templates/hooks--query-fsmonitor.sample
@@ -0,0 +1,27 @@
+#!/bin/sh
+#
+# An example hook script to integrate Watchman
+# (https://facebook.github.io/watchman/) with git to provide fast
+# git status.
+#
+# The hook is passed a time_t formatted as a string and outputs to
+# stdout all files that have been modified since the given time.
+# Paths must be relative to the root of the working tree and
+# separated by a single NUL.
+#
+# To enable this hook, rename this file to "query-fsmonitor"
+
+# Convert unix style paths to escaped Windows style paths
+case "$(uname -s)" in
+MINGW*|MSYS_NT*)
+  GIT_WORK_TREE="$(cygpath -aw "$PWD" | sed 's,\\,\\\\,g')"
+  ;;
+*)
+  GIT_WORK_TREE="$PWD"
+  ;;
+esac
+
+# Query Watchman for all the changes since the requested time
+echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $1, \"fields\":[\"name\"]}]" | \
+watchman -j | \
+perl -e 'use JSON::PP; my $o = JSON::PP->new->utf8->decode(join("", <>)); die "Watchman: $o->{'error'}.\nFalling back to scanning...\n" if defined($o->{"error"}); print(join("\0", @{$o->{"files"}}));'
-- 
2.13.0.windows.1.6.g4597375fc3

