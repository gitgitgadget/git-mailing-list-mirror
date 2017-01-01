Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3191FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 17:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932176AbdAARKk (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 12:10:40 -0500
Received: from avasout05.plus.net ([84.93.230.250]:58525 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbdAARKj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 12:10:39 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout05 with smtp
        id T5Ab1u0010srQBz015AczX; Sun, 01 Jan 2017 17:10:37 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Z4ScJDZA c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=PG22EKeWCnBeRtwNYkMA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] read-cache: mark a file-local symbol with static
Message-ID: <a1a44640-ff6c-2294-72ac-46322eff8505@ramsayjones.plus.com>
Date:   Sun, 1 Jan 2017 17:10:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Christian,

If you need to re-roll your 'cc/split-index-config' branch, could
you please squash this into the relevant patch (commit 8a7e3ef9a6,
"read-cache: touch shared index files when used", 26-12-2016).

Thanks!

ATB,
Ramsay Jones

 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 119701bf0..17b9f2461 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1682,7 +1682,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
  * for some time. It's ok to fail to update the mtime if we are on a
  * read only file system.
  */
-void freshen_shared_index(char *base_sha1_hex)
+static void freshen_shared_index(char *base_sha1_hex)
 {
 	const char *shared_index = git_path("sharedindex.%s", base_sha1_hex);
 	check_and_freshen_file(shared_index, 1);
-- 
2.11.0
