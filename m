Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D695CC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 00:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8086B206F6
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 00:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="KiSByopF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgGIAXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:23:17 -0400
Received: from avasout07.plus.net ([84.93.230.235]:40894 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGIAXR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 20:23:17 -0400
Received: from [10.0.2.15] ([195.213.6.94])
        by smtp with ESMTPA
        id tKLIjrtpF0wwMtKLKjOR1c; Thu, 09 Jul 2020 01:23:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1594254195; bh=s5tcE28zi0m/+Nf85OeRjwg422/oovLJmrbfCQlY3nw=;
        h=To:Cc:From:Subject:Date;
        b=KiSByopFbjcyCsl53rAw/ifhcKECWnCX6va1JVY/QrYgBo57+JT4z+Y4fa5dbvo9J
         r5ygAi/+4IYWtoLh77EoyL9Fmv1GkMyoh7lzWxLaVxbc5NWXrlyZCGkHjBGTNIB1JV
         6WWLTsoD8bz764huRama+1ZPMvBl5qhxhirb8hhcO4wZ1v3IfN8a8P+rhNvEoZXsWh
         hMZ5gdy+m4BIESHsdQd0hrmzsGAwHmeNAHb/6oCGcMIu+uKwyW/69pmYjELl2dr7Ls
         S7Z7T4LSzi2uHrYdzgpRj+e1bKQV08nR9QWTzMkLNXWVLjhQ6c274MuiqbXg5/Nyub
         kN7Q3wry9BQQQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=b/4pHuOx c=1 sm=1 tr=0
 a=zLrGoXp437TtaqwGN82bxg==:117 a=zLrGoXp437TtaqwGN82bxg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=8WN4BljrgAConUcY_scA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=1QtKJMKzKSp2x_zT:21 a=X84ysr2xmpr_Pt1M:21
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] gc: fix some sparse 'symbol not declared' warnings
Message-ID: <9c9164e2-0fff-7211-a79a-f4c546d2cedd@ramsayjones.plus.com>
Date:   Thu, 9 Jul 2020 01:23:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOe7qrw/FPrvtTtFZ/Y9CW4thWUl/mp11W7SMWj8/YxHUWTwdNCGN2RlR4oqCfYAN2G7qeF8SDPbzZZDNze5q5rG4CJGUy8Hbu1Rrk/SQuwP+bi///0c
 Y1sHJutcu2hRXTZioKti2b70Ge6lcF/F/9R5/NYWl0XkHNPOKq3fktG3t4ZaQlai5dvHTrv41wtR8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Derrick,

If you need to re-roll your 'ds/maintenance' branch, could you please
squash this into the relevant patches. The first hunk should be squashed
into commit a138b8ff61 (maintenance: create basic maintenance runner,
2020-07-07) and the second hunk into commit aca963ff39 (maintenance:
initialize task array and hashmap, 2020-07-07).

Thanks!

ATB,
Ramsay Jones

 builtin/gc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c3531561c2..de029d687b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -716,7 +716,7 @@ static const char * const builtin_maintenance_usage[] = {
 	NULL
 };
 
-struct maintenance_opts {
+static struct maintenance_opts {
 	int auto_flag;
 	int quiet;
 	int tasks_selected;
@@ -1297,9 +1297,9 @@ static int task_entry_cmp(const void *unused_cmp_data,
 	return strcasecmp(e1->name, name ? name : e2->name);
 }
 
-struct maintenance_task *tasks[MAX_NUM_TASKS];
-int num_tasks;
-struct hashmap task_map;
+static struct maintenance_task *tasks[MAX_NUM_TASKS];
+static int num_tasks;
+static struct hashmap task_map;
 
 static int compare_tasks_by_selection(const void *a_, const void *b_)
 {
-- 
2.27.0
