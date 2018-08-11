Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4031F404
	for <e@80x24.org>; Sat, 11 Aug 2018 21:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeHLA2e (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 20:28:34 -0400
Received: from avasout06.plus.net ([212.159.14.18]:43485 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeHLA2d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 20:28:33 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id obogfyBg9WLW2obohfN4Lu; Sat, 11 Aug 2018 22:53:00 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=62fa1_XlVMzNNcvuC2oA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     predatoramigo@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] rebase: fix a sparse 'plain integer as NULL pointer' warning
Message-ID: <d5d0f6c3-748b-b83f-f9d4-2812f4509313@ramsayjones.plus.com>
Date:   Sat, 11 Aug 2018 22:52:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGUufEwhgQyZPhE2Z+2DCN7tHTsNcaHiNzO5aVA3lU0cyQP5HBisGqzl0PiRZWv9VXDlrkwB5vKABR9Nh1vkZKgq02zr7zqWPxTQwFRmSvxchPRr+aTX
 yLFFkH5FhSUVliW5ropHsrGqvgM/YPaEsuJNzOMnqkBlDk20v1GGQ94uGPZ5Gvrt1t2K6NVAP7zf/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Pratik,

If you need to re-roll your 'pk/rebase-in-c-4-opts' branch, could
you please squash this into the relevant patch (commit b0721e7b48,
"builtin rebase: support `-C` and `--whitespace=<type>`", 2018-08-08).

Thanks!

ATB,
Ramsay Jones

 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 42f5884ce9..fa7c5582f8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -776,7 +776,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			   N_("gpg-sign?"), N_("GPG-sign commits")),
 		OPT_STRING_LIST(0, "whitespace", &whitespace,
 				N_("whitespace"), N_("passed to 'git apply'")),
-		OPT_SET_INT('C', 0, &opt_c, N_("passed to 'git apply'"),
+		OPT_SET_INT('C', NULL, &opt_c, N_("passed to 'git apply'"),
 			    REBASE_AM),
 		OPT_BOOL(0, "autostash", &options.autostash,
 			 N_("automatically stash/stash pop before and after")),
-- 
2.18.0
