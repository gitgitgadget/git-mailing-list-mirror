Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0298D1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 16:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeILVvO (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 17:51:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46096 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbeILVvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 17:51:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so1333695pga.13
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hpzmVaxo7TYiPoNwG8o0j60CGIWDIbdC7tY5/Faia/I=;
        b=nwfme5UvuBz9jVR9JRCrws9ZazcSNka23hEWJ6vRKJ9uAM1wlrxct5bSpKStyCFMqj
         wkWJB1Moy9qchiYiCnfUe6/crc7h4/SKkqA+lsmLI2927MD1DBT1vMlcmQ7mVokJDAXY
         d+GYlQo/LEKIOJnPzOOBUr42DpuXY9tCyNZ62x7eam/hJploHUdexIW8UEtQhiWskT9w
         9WLl2XauOGmsgnrUGSb5WSEEIkDgCCPB/5aVYUV+68cjKXf2pEB0YNYs/4KD0ExFbrZU
         30QT+zM/LWpqMuMjeZQwgQbZ4Ta4CuhQFUq3ChnVAssqojwd04essix9UvrRQN5kx6dp
         xtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hpzmVaxo7TYiPoNwG8o0j60CGIWDIbdC7tY5/Faia/I=;
        b=r1q5qQ9C4p9uxhQOXYt+ipbaGPLBGZyySQwluIMUlzp/JPOahXzeB18JjA2adNvlBn
         wxxYVSm3qmBlugVRWr7d4L+Dfpw1byBcFeun9mjTkf8TCUsot/F+9Toc2vZ7tvtMofY2
         zazTiqZzPo4RPCydrDHcrGixw8KZFVTghg5A9EorISI6Dpv6ySgCmT6nFDpBIXfSJEGb
         tI5iiFUgDBw31tRuXfgZnQ0YnuzYXTnjKnvxW85YyF4CIF5eHzl2Rh0y1spTfetIHIha
         /zeZiSVGJErwCdS2Ewj0MwWHya0EIyTPGXfXLy1mpX2+SBhvE6vf3KECPvfuuoawHT42
         ZZMw==
X-Gm-Message-State: APzg51CyfTmbttOay/2dtvefVREsONEPz8PqywqSUydrAO4BOAkFYHiq
        ta/4StqtnX/rdTNj1VTH/UjWLHNZ
X-Google-Smtp-Source: ANB0VdYzVnlLIyPFUy5TXkoZUa3j9AqC5OcDJM4Dn8EMEwsISiazkNurA8lMApgUejrc5CXqV9NcVQ==
X-Received: by 2002:a62:3909:: with SMTP id g9-v6mr3365527pfa.176.1536770750571;
        Wed, 12 Sep 2018 09:45:50 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id k126-v6sm2751101pgk.26.2018.09.12.09.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 09:45:49 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:45:49 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Sep 2018 16:45:45 GMT
Message-Id: <e4124471e5494b737d99eceed25fb03e787d0b96.1536770746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.40.git.gitgitgadget@gmail.com>
References: <pull.40.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] contrib: add coverage-diff script
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We have coverage targets in our Makefile for using gcov to display line
coverage based on our test suite. The way I like to do it is to run:

    make coverage-test
    make coverage-report

This leaves the repo in a state where every X.c file that was covered has
an X.c.gcov file containing the coverage counts for every line, and "#####"
at every uncovered line.

There have been a few bugs in recent patches what would have been caught
if the test suite covered those blocks (including a few of mine). I want
to work towards a "sensible" amount of coverage on new topics. In my opinion,
this means that any logic should be covered, but the 'die()' blocks in error
cases do not need to be covered.

It is important to not measure the coverage of the codebase by what old code
is not covered. To help, I created the 'contrib/coverage-diff.sh' script.
After creating the coverage statistics at a version (say, 'topic') you can
then run

    contrib/coverage-diff.sh base topic

to see the lines added between 'base' and 'topic' that are not covered by the
test suite. The output uses 'git blame -c' format so you can find the commits
responsible and view the line numbers for quick access to the context.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 contrib/coverage-diff.sh | 70 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100755 contrib/coverage-diff.sh

diff --git a/contrib/coverage-diff.sh b/contrib/coverage-diff.sh
new file mode 100755
index 0000000000..22acb13d38
--- /dev/null
+++ b/contrib/coverage-diff.sh
@@ -0,0 +1,70 @@
+#!/bin/bash
+
+# Usage: 'contrib/coverage-diff.sh <version1> <version2>
+# Outputs a list of new lines in version2 compared to version1 that are
+# not covered by the test suite. Assumes you ran
+# 'make coverage-test coverage-report' from root first, so .gcov files exist.
+
+V1=$1
+V2=$2
+
+diff-lines() {
+    local path=
+    local line=
+    while read; do
+	esc=$'\033'
+	if [[ $REPLY =~ ---\ (a/)?.* ]]; then
+	    continue
+	elif [[ $REPLY =~ \+\+\+\ (b/)?([^[:blank:]$esc]+).* ]]; then
+	    path=${BASH_REMATCH[2]}
+	elif [[ $REPLY =~ @@\ -[0-9]+(,[0-9]+)?\ \+([0-9]+)(,[0-9]+)?\ @@.* ]]; then
+	    line=${BASH_REMATCH[2]}
+	elif [[ $REPLY =~ ^($esc\[[0-9;]+m)*([\ +-]) ]]; then
+	    echo "$path:$line:$REPLY"
+	    if [[ ${BASH_REMATCH[2]} != - ]]; then
+		((line++))
+	    fi
+	fi
+    done
+}
+
+git diff --raw $V1 $V2 | grep \.c$ | awk 'NF>1{print $NF}' >files.txt
+
+for file in $(cat files.txt)
+do
+	hash_file=${file//\//\#}
+
+	git diff $V1 $V2 -- $file \
+		| diff-lines \
+		| grep ":+" \
+		>"diff_file.txt"
+
+	cat diff_file.txt \
+		| sed -E 's/:/ /g' \
+		| awk '{print $2}' \
+		| sort \
+		>new_lines.txt
+
+	cat "$hash_file.gcov" \
+		| grep \#\#\#\#\# \
+		| sed 's/    #####: //g' \
+		| sed 's/\:/ /g' \
+		| awk '{print $1}' \
+		| sort \
+		>uncovered_lines.txt
+
+	comm -12 uncovered_lines.txt new_lines.txt \
+		| sed -e 's/$/\)/' \
+		| sed -e 's/^/\t/' \
+		>uncovered_new_lines.txt
+
+	grep -q '[^[:space:]]' < uncovered_new_lines.txt && \
+		echo $file && \
+		git blame -c $file \
+			| grep -f uncovered_new_lines.txt
+
+	rm -f diff_file.txt new_lines.txt \
+		uncovered_lines.txt uncovered_new_lines.txt
+done
+
+rm -rf files.txt
-- 
gitgitgadget
