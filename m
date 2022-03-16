Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C94C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 10:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355177AbiCPKny (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 06:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345091AbiCPKnx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 06:43:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A946540D
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 03:42:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so2952223wms.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fhK+eFo8Lz4gKK+xwU3sLVPXhtx/Z89lViUUqb0u4Hk=;
        b=fHCXUGm9nOCIM/1hKCGIDbjVHvIUrHVcf90xgqYC2uQh1fUDu0ihSva3AuHmzTZ3MY
         69IOofU3sPGgGECY9RkKc18DSGClINi8QItNCVbEHhPl/pY2oS+dVDwsDZhGnmrFhnSa
         rfgdpb4c6XmQSJ9sI7ZTBmQpeP6vx87I0/L1gaeoF1h8wnAhUahSuH8ZuKEo2eNPfNu0
         81+Pub+0wj1vJdtakWLSncN1yZe8VznSwJrgHhbwrapHiRnQ45yetHmMO1vaD9tb4QPI
         8NJPxna3Dfqk8YGSEQFhDJKBQZM8uT4WI5EsAPjW1/D20Qc0tcoJV/RuGTKx+ZDb3SJT
         mzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fhK+eFo8Lz4gKK+xwU3sLVPXhtx/Z89lViUUqb0u4Hk=;
        b=s53ZvPfVuPnTt+S/hEF+Sptn8GEykF7FN6YfKlZPOhMWK+4E9kJ3ejEY9innFFO2Wn
         fXhP6cHs/YyoawQcwunmAo2m6xtUiMPEm3E4jfrlPSSoKgynvpkETjjyVoUrExo4imFr
         JtELTolOGhiwaCdFEsj1KvwrXqkA6E+vohghDILLe/tXIT1nf+Y24pLyg0Bc7GPAnQiH
         IQcKTT0dSm2bLD3Aew65Hhocl58T9Iu2jHhlLhL2nph0o6nw4vs8+RRQu0eFXm80S5Jf
         WNtrWp1Ywv2/OcYybLJzbozZQ2LyK2giUg0/GpUTZh1uF5MyqZ8fEHUehLRvbwwVxaxP
         mH3w==
X-Gm-Message-State: AOAM533iQFjVppVBQ01jQWYYsnUeJlS5UOe0Yz0MhuqWbp1u+TwvDmBE
        hnxRvtfosx4FDNR2sHNe3eg1bZ3KYc4=
X-Google-Smtp-Source: ABdhPJwLl271CInlMj+GbFilJbLxRQ85B49jaLWFDsIud9YQPr8iQ1Wtnl8DXb5z9dsjbvQkCcipuw==
X-Received: by 2002:a05:600c:4c11:b0:383:fae4:41c2 with SMTP id d17-20020a05600c4c1100b00383fae441c2mr6896935wmp.104.1647427357827;
        Wed, 16 Mar 2022 03:42:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm4641774wmg.7.2022.03.16.03.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 03:42:37 -0700 (PDT)
Message-Id: <pull.1177.v2.git.1647427356490.gitgitgadget@gmail.com>
In-Reply-To: <pull.1177.git.1647373314457.gitgitgadget@gmail.com>
References: <pull.1177.git.1647373314457.gitgitgadget@gmail.com>
From:   "Jayati Shrivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Mar 2022 10:42:36 +0000
Subject: [PATCH v2] sequencer.c: use reverse_commit_list() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jayati Shrivastava <gaurijove@gmail.com>,
        Jayati Shrivastava <gaurijove@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jayati Shrivastava <gaurijove@gmail.com>

Instead of creating a new allocation, reverse the original
list in-place by calling the reverse_commit_list() helper.
The original code discards the list "bases" after storing
its reverse copy in a newly created list "reversed". If the
code that followed from here used both "bases" and "reversed",
the modification would not have worked, but since the original
list "bases" gets discarded, we can simply reverse "bases"
in-place with the reverse_commit_list() helper and reuse the
same variable in the code that follows.

Signed-off-by: Jayati Shrivastava <gaurijove@gmail.com>
---
    Use reverse_commit_list helper function for in-place list reversal
    
    This patch addresses https://github.com/gitgitgadget/git/issues/1156 . I
    have left builtin/merge.c unmodified since in its case, the original
    list is needed separately from the reverse copy.
    
    (Please excuse if you are receiving this patch again. I had previously
    sent it using git send-email but for some reason the patches are not
    getting delivered to the mailing list despite correctly passing the
    --to/--cc/--in-reply-to options.)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1177%2Fvictorphoenix3%2Freverse-list-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1177/victorphoenix3/reverse-list-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1177

Range-diff vs v1:

 1:  8c3c6c9ed4c ! 1:  f794bcd8bda Use reverse_commit_list helper function for in-place list reversal
     @@
       ## Metadata ##
     -Author: JAYATI SHRIVASTAVA <gaurijove@gmail.com>
     +Author: Jayati Shrivastava <gaurijove@gmail.com>
      
       ## Commit message ##
     -    Use reverse_commit_list helper function for in-place list reversal
     +    sequencer.c: use reverse_commit_list() helper
      
     -    Here, a reverse copy of a list is being created by iterating
     -    over the list after which the original list is discarded.
     -    Instead of creating a new allocation, we can reverse the
     -    original list in-place using the reverse_commit_list helper
     -    function.
     +    Instead of creating a new allocation, reverse the original
     +    list in-place by calling the reverse_commit_list() helper.
     +    The original code discards the list "bases" after storing
     +    its reverse copy in a newly created list "reversed". If the
     +    code that followed from here used both "bases" and "reversed",
     +    the modification would not have worked, but since the original
     +    list "bases" gets discarded, we can simply reverse "bases"
     +    in-place with the reverse_commit_list() helper and reuse the
     +    same variable in the code that follows.
      
          Signed-off-by: Jayati Shrivastava <gaurijove@gmail.com>
      


 sequencer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 35006c0cea6..bccbb9e3522 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3749,7 +3749,7 @@ static int do_merge(struct repository *r,
 	int run_commit_flags = 0;
 	struct strbuf ref_name = STRBUF_INIT;
 	struct commit *head_commit, *merge_commit, *i;
-	struct commit_list *bases, *j, *reversed = NULL;
+	struct commit_list *bases, *j;
 	struct commit_list *to_merge = NULL, **tail = &to_merge;
 	const char *strategy = !opts->xopts_nr &&
 		(!opts->strategy ||
@@ -3984,9 +3984,7 @@ static int do_merge(struct repository *r,
 		      git_path_merge_head(r), 0);
 	write_message("no-ff", 5, git_path_merge_mode(r), 0);
 
-	for (j = bases; j; j = j->next)
-		commit_list_insert(j->item, &reversed);
-	free_commit_list(bases);
+	bases = reverse_commit_list(bases);
 
 	repo_read_index(r);
 	init_merge_options(&o, r);
@@ -4002,10 +4000,10 @@ static int do_merge(struct repository *r,
 		 * update the index and working copy immediately.
 		 */
 		ret = merge_ort_recursive(&o,
-					  head_commit, merge_commit, reversed,
+					  head_commit, merge_commit, bases,
 					  &i);
 	} else {
-		ret = merge_recursive(&o, head_commit, merge_commit, reversed,
+		ret = merge_recursive(&o, head_commit, merge_commit, bases,
 				      &i);
 	}
 	if (ret <= 0)

base-commit: b896f729e240d250cf56899e6a0073f6aa469f5d
-- 
gitgitgadget
