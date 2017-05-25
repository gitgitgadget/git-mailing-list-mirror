Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78EE3209FD
	for <e@80x24.org>; Thu, 25 May 2017 18:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424884AbdEYSgt (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 14:36:49 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34197 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424876AbdEYSgr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 14:36:47 -0400
Received: by mail-qk0-f195.google.com with SMTP id u75so31081127qka.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hieLCPB1f629iMrL8EmKpZ9XNNPmFN/uIBfGEn6o6k0=;
        b=oNm95SvNXHzP77846kDmew4EJ8O9EwPRoE1bnCPnIxqm/DGAVD3CtwtQLM3y+OWE7J
         IachZzGYCUNcJ6ukpr4ZTpYYbZ4nPxQgiq13KhP4CRrTQVpcelxHWmquNRXlpTNO9l2Y
         5dMCUmCT8R0/Sipg3RHbGBNxnO6V/CoKq9IcMCc07IPFOJJXWSQ3554O6xkjZZpi5VxR
         7hFEGkfmleoeZyBTfTty9dMeWBSvy3REcIMmG1DXiimBLSW8yXCBRnwFJFWN7iRGT043
         TDALUPRD6Hcf3cEI9WMZyWOwVbtpKAIHSmqdQCqdYGuLZ/37O3Cfpx0Spmu+aJsYthij
         xV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hieLCPB1f629iMrL8EmKpZ9XNNPmFN/uIBfGEn6o6k0=;
        b=NpiRAMwzpGE6/UcDZsKO5u21JYtMEsUK7do4VYO06x5zURUY2FVBpZWvPxzuJnUrSd
         mzHgE/qIRVgUfz7fGzRs6bCkbNuyiQWYyF9EYTEx7UpLNBbHZDh+VoJxFQgTW7eLnnkv
         T6HnG8vVCcgwjS8a2cNQqUIJcIQKp1tnVWNFXGHj3PWKKouQ0/kWkDoHE7vpufpUXhFk
         cqYh9mWw+Lk4RQUqEpIQzcH+G0Qfr2g9j+cjCe5EqpTTrgdMyw/sv84oFTOPgA6QNDGs
         zDq7FmZiFXYAEm4Lc2oEZV+VdiZF3tcY5PF8oCdpO51yoKTzB0sPY9WZ9noNnaEUTkz4
         4HhQ==
X-Gm-Message-State: AODbwcAn5pymmEr8LJrIGOUg7kENL9CYVWxh2AUFDE70p0xCBuMNtO0l
        7kGE0na8GWRwCA==
X-Received: by 10.55.123.2 with SMTP id w2mr37996021qkc.13.1495737406788;
        Thu, 25 May 2017 11:36:46 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id j66sm5089231qte.26.2017.05.25.11.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 May 2017 11:36:46 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v3 6/6] fsmonitor: add a sample query-fsmonitor hook script for Watchman
Date:   Thu, 25 May 2017 14:36:12 -0400
Message-Id: <20170525183612.3128-7-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.9.gc201c67b71
In-Reply-To: <20170525183612.3128-1-benpeart@microsoft.com>
References: <20170525183612.3128-1-benpeart@microsoft.com>
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
 templates/hooks--query-fsmonitor.sample | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 templates/hooks--query-fsmonitor.sample

diff --git a/templates/hooks--query-fsmonitor.sample b/templates/hooks--query-fsmonitor.sample
new file mode 100644
index 0000000000..615f3332fa
--- /dev/null
+++ b/templates/hooks--query-fsmonitor.sample
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# An example hook script to integrate Watchman
+# (https://facebook.github.io/watchman/) with git to provide fast
+# git status.
+#
+# The hook is passed a time in nanoseconds formatted as a string and
+# outputs to stdout all files that have been modified since the given
+# time. Paths must be relative to the root of the working tree and
+# separated by a single NUL.
+#
+# To enable this hook, rename this file to "query-fsmonitor"
+
+# check the hook interface version
+if [ $1 -eq 1 ]
+then
+	# convert nanoseconds to seconds
+	time_t=$(($2/1000000000))
+else
+	echo -e "Unsupported query-fsmonitor hook version.\nFalling back to scanning...\n" >&2
+	exit 1;
+fi
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
+echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $time_t, \"fields\":[\"name\"]}]" | \
+watchman -j | \
+perl -e 'use JSON::PP; my $o = JSON::PP->new->utf8->decode(join("", <>)); die "Watchman: $o->{'error'}.\nFalling back to scanning...\n" if defined($o->{"error"}); print(join("\0", @{$o->{"files"}}));'
-- 
2.13.0.windows.1.9.gc201c67b71

