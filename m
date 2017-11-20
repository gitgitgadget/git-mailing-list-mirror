Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F29A202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbdKTU1L (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:27:11 -0500
Received: from avasout04.plus.net ([212.159.14.19]:35881 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752499AbdKTU1K (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 15:27:10 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id GsepejQXXzbmWGseqeBvgH; Mon, 20 Nov 2017 20:27:09 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=FEwn8AxFsdz831qadf8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     vmiklos@suse.cz
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] sequencer: make sign_off_header a file local symbol
Message-ID: <cc945f53-9452-9165-96c2-ab7f5f46c146@ramsayjones.plus.com>
Date:   Mon, 20 Nov 2017 20:27:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIDs3YazANZd16sbJ/LcmUC1eUjuJRrJNZy9FalwdP2A6gLL8gz3O0aMgn5MTomHGW2G+YhSsTJiAOZIHXrwZL7A2xCH47RLvClUqt6pNNJvF3+28GFY
 3b8KcWbUta+S9dy/djOMcelyyTJ5r4uwKq9N1sAIFh3hcNh8sjGTh6XrNNbzDqFroV+PwQmVtIsUoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Miklos,

If you need to re-roll your 'mv/cherry-pick-s' branch, could you
please squash this into the relevant patch (commit 5ed75e2a3f,
"cherry-pick: don't forget -s on failure", 14-09-2017).

[noticed by sparse].

Thanks!

ATB,
Ramsay Jones

 sequencer.c | 2 +-
 sequencer.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 53b5100a7..b8c0ed170 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -26,7 +26,7 @@
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
-const char sign_off_header[] = "Signed-off-by: ";
+static const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
 GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
diff --git a/sequencer.h b/sequencer.h
index 77cb174b2..688b0276d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -53,8 +53,6 @@ int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
 
-extern const char sign_off_header[];
-
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
 void append_conflicts_hint(struct strbuf *msgbuf);
 int git_sequencer_config(const char *k, const char *v, void *cb);
-- 
2.15.0
