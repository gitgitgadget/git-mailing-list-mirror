Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06969200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeEDPfA (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:35:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:33401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbeEDPe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:34:58 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MGS9o-1fAAl11fpw-00DEdU; Fri, 04 May 2018 17:34:51 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/18] branch-diff: do not show "function names" in hunk headers
Date:   Fri,  4 May 2018 17:34:50 +0200
Message-Id: <2695a6abc46ce55057762f8d6bdae6ece54274ac.1525448066.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g71698f11835
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nVNIWpsYhQFhOc5o6NO09Em5YOtDiszDNb3wWVowTLtI9qIwukt
 EulS/CZH1b4+9Iy/hIEJ0AzEhCV01FfIoruJGq7z1ZcHXhgRPn5jTZ+LbK+vrEWQP0FPzID
 oK6tTvasFm3VAC34mSngDggLdAahe3mpGY09FPZEijv4ErfCwG54N30hsg2b2heI+y05jvt
 9y6cmYKdMo8kiyS4XiBaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aFcnfSj+wmI=:xU6idgGvd3pOQ66iVYTTR4
 pU4CfXwuBfzhBIh6omccbS8/u9q1BMtyllloAE53SPo1thNNX0mRy2MjRyW3CJgix5NVSiTw0
 E3dwbN9gNMJqHxzz6HdW+2XeV4u1J9cw7O0gfqI55aubyGJYuQl8K4HetmPIkt7IfNWXZl1q8
 ZI0JuGxaa6l3Z71drlSUox0S+SwuCrRx1V+xrBkiEKR0vA6RjjyfMHCTPwcJizGI4lNp2pPrZ
 1NBNoaU/CQnv7K1HgvKMUxgTvNrJVfeWYip6YY1T88tl4H0yPmWKIY38wG95jAQ3gSSn6YTb7
 tX8Q5c7DWyzdqfLrjFscgvOoceuwk3mp8NTeHgb0c6mWC3P4qgs3jL/PblMKPXiG6/yU7YN4F
 uE3M5kNbsjWec3xCz7WqJ+bb+PjVfu/MTQ1xtQhZvCpOu0vr+Kjv7f0dIiu1RnWjnH3D58V5g
 /1kI3bPFxyYy9BA5H0Ag3H/Cy6Uc3WSgw7Jsko1dftBZY9geJL7S+PkFi8/Nsmaxa0i+UVwNb
 UrDiuORDKRBn6nxWllUet8+gZ6gAu/5N1BPVZoD6nTva/FCSQU/YF75cjANenHEV4jywn4z3m
 hUQmFmvmSvotv4IqRz7W0PH9UompBsLu/nsC/+RB+2HDBG8SeAWkA8OptDkw5T6R9AntrOSTY
 6Ttp1MExh3nMVzhmd6gWaP5shDWNdFKDrw+q46Kk0NkLC+qqUQKp24de/JtWHGru66zyl0Zj6
 giGpHcX06jPEz9gdhE6eM5HBBoEl/JNV+QK4pDfN5ng8mwr4hJ2glplujk+W4LFbIeiRd3FWC
 RcJ/FOS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are comparing complete, formatted commit messages with patches. There
are no function names here, so stop looking for them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 5b187890bdf..89d75c93115 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -11,6 +11,7 @@
 #include "diffcore.h"
 #include "commit.h"
 #include "pretty.h"
+#include "userdiff.h"
 
 static const char * const builtin_branch_diff_usage[] = {
 N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
@@ -330,6 +331,10 @@ static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
 	return data;
 }
 
+static struct userdiff_driver no_func_name = {
+	.funcname = { "$^", 0 }
+};
+
 static struct diff_filespec *get_filespec(const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
@@ -339,6 +344,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
 	spec->is_stdin = 1;
+	spec->driver = &no_func_name;
 
 	return spec;
 }
-- 
2.17.0.409.g71698f11835


