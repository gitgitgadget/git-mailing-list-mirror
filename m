Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23CD91F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 20:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeJODzV (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 23:55:21 -0400
Received: from avasout03.plus.net ([84.93.230.244]:46607 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeJODzV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Oct 2018 23:55:21 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id BmlCgvpOpO2g2BmlDgZhqj; Sun, 14 Oct 2018 21:13:11 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DKChHRFb c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=oaufkx1e1nLygn9rHOIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC/PATCH] headers: normalize the spelling of some header guards
Message-ID: <2804aa4e-c078-c981-be93-27e6e58b2042@ramsayjones.plus.com>
Date:   Sun, 14 Oct 2018 21:13:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE6m7UDUU8W2fJYvadlj+INZfiO3cxWnQFIq+ZWdg2WsYFRU4tz9n4ZLq+sZFcZD8pVTA379dlpoOGtTNZzBUAe4iYN4wHgkMbZRXkYXy3zWw1v0rWFk
 RWVmoDAYKxxcy2qI5bxTG/GjPwBwUQFbbdVrnH5f127G/Sxz+rT/2MfnsR28w4L2KwP96Ee9qQn4zw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

This patch is marked RFC because I am not aware of any policy with
regard to header guard spelling. Having said that, apart from the
fetch-negotiator.h header, all of these headers are using a reserved
identifier (see C99 Standard 7.1.3).

These headers were found, thus:

  $ git grep -n -E '^#ifn?def ' -- '*.h' | grep 'h\:1\:' | grep -v '^compat' | grep -v -E '[A-Z_]*_H$'
  alias.h:1:#ifndef __ALIAS_H__
  commit-reach.h:1:#ifndef __COMMIT_REACH_H__
  fetch-negotiator.h:1:#ifndef FETCH_NEGOTIATOR
  midx.h:1:#ifndef __MIDX_H__
  t/helper/test-tool.h:1:#ifndef __TEST_TOOL_H__
  vcs-svn/fast_export.h:1:#ifndef FAST_EXPORT_H_
  vcs-svn/line_buffer.h:1:#ifndef LINE_BUFFER_H_
  vcs-svn/sliding_window.h:1:#ifndef SLIDING_WINDOW_H_
  vcs-svn/svndiff.h:1:#ifndef SVNDIFF_H_
  vcs-svn/svndump.h:1:#ifndef SVNDUMP_H_
  $ 

Note that I haven't included the headers in vcs-svn because there is
a patch being discussed which would move that directory to contrib.

ATB,
Ramsay Jones

 alias.h              | 4 ++--
 commit-reach.h       | 4 ++--
 fetch-negotiator.h   | 4 ++--
 midx.h               | 4 ++--
 t/helper/test-tool.h | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/alias.h b/alias.h
index 79933f2457..aef4843bb7 100644
--- a/alias.h
+++ b/alias.h
@@ -1,5 +1,5 @@
-#ifndef __ALIAS_H__
-#define __ALIAS_H__
+#ifndef ALIAS_H
+#define ALIAS_H
 
 struct string_list;
 
diff --git a/commit-reach.h b/commit-reach.h
index 7d313e2975..122a23a24d 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -1,5 +1,5 @@
-#ifndef __COMMIT_REACH_H__
-#define __COMMIT_REACH_H__
+#ifndef COMMIT_REACH_H
+#define COMMIT_REACH_H
 
 #include "commit-slab.h"
 
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index ddb44a22dc..9e3967ce66 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -1,5 +1,5 @@
-#ifndef FETCH_NEGOTIATOR
-#define FETCH_NEGOTIATOR
+#ifndef FETCH_NEGOTIATOR_H
+#define FETCH_NEGOTIATOR_H
 
 struct commit;
 
diff --git a/midx.h b/midx.h
index ce80b91c68..ee83702309 100644
--- a/midx.h
+++ b/midx.h
@@ -1,5 +1,5 @@
-#ifndef __MIDX_H__
-#define __MIDX_H__
+#ifndef MIDX_H
+#define MIDX_H
 
 #include "repository.h"
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e4890566da..71f470b871 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -1,5 +1,5 @@
-#ifndef __TEST_TOOL_H__
-#define __TEST_TOOL_H__
+#ifndef TEST_TOOL_H
+#define TEST_TOOL_H
 
 #include "git-compat-util.h"
 
-- 
2.19.0
