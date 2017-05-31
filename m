Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970C51FD09
	for <e@80x24.org>; Wed, 31 May 2017 13:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750965AbdEaNuo (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 09:50:44 -0400
Received: from avasout07.plus.net ([84.93.230.235]:38437 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbdEaNun (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 09:50:43 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id T1qg1v0091keHif011qhdn; Wed, 31 May 2017 14:50:42 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=e1UXdVqf8rYVHs6MP_4A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] submodule: mark some file-local symbols as static
Message-ID: <a13cb454-f363-6f7e-46b8-c618d2c54fff@ramsayjones.plus.com>
Date:   Wed, 31 May 2017 14:50:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Stefan,

If you need to re-roll your 'sb/submodule-blanket-recursive' branch,
could you please squash this into the relevant patch (commit 0e5bca302a
"Introduce 'submodule.recurse' option for worktree manipulators",
26-05-2017).

Thanks!

ATB,
Ramsay Jones

 builtin/read-tree.c | 2 +-
 builtin/reset.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index ad317c736..5bfd4c9f7 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -98,7 +98,7 @@ static int debug_merge(const struct cache_entry * const *stages,
 	return 0;
 }
 
-int git_read_tree_config(const char *var, const char *value, void *cb)
+static int git_read_tree_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "submodule.recurse"))
 		return git_default_submodule_config(var, value, cb);
diff --git a/builtin/reset.c b/builtin/reset.c
index 48bc58cc7..45001e520 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -265,7 +265,7 @@ static int reset_refs(const char *rev, const struct object_id *oid)
 	return update_ref_status;
 }
 
-int git_reset_config(const char *var, const char *value, void *cb)
+static int git_reset_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "submodule.recurse"))
 		return git_default_submodule_config(var, value, cb);
-- 
2.13.0
