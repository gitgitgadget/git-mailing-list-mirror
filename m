Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_50,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B0E1FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 20:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbcFXUbJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 16:31:09 -0400
Received: from avasout01.plus.net ([84.93.230.227]:34719 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbcFXUbI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 16:31:08 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id AkX31t0065VX2mk01kX4VB; Fri, 24 Jun 2016 21:31:06 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=QfYkhYTv c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=__w_UVEJxDyIERQoo_cA:9
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH:	ramsayjones@:2500
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] refs/files-backend: mark a file-local symbol static
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
Message-ID: <576D9885.2020901@ramsayjones.plus.com>
Date:	Fri, 24 Jun 2016 21:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Commit 6d41edc6 ("refs: add methods for reflog", 24-02-2016), moved the
reflog handling into the ref-storage backend. In particular, the
files_reflog_iterator_begin() API was removed from internal refs API
header, resulting in sparse warnings.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Michael,

If you need to re-roll your 'mh/ref-store' branch, could you please
squash this into the relevant patch. (or something like it - if you
think this function should be public, then re-introduce the declaration
to the header).

Thanks!

ATB,
Ramsay Jones

 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b6ce19f..426e439 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3331,7 +3331,7 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	files_reflog_iterator_abort
 };
 
-struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
+static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
 {
 	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
-- 
2.9.0
