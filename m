Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147891F461
	for <e@80x24.org>; Tue, 27 Aug 2019 05:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfH0FiA (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 01:38:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34310 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0FiA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 01:38:00 -0400
Received: by mail-io1-f66.google.com with SMTP id s21so43513514ioa.1
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 22:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QW0NShJ7fDoQCwK8HRFHmEXY/arqlqKQTi2BvHMo4Pc=;
        b=NDeXaZxMbC5bPG2QOhHRkscYSwlltspLX1xWqOnFr33sL6t3qwug+6DxrQX1be7jvU
         kvM5KK96yQooYgB14l63AwoAGdvkW0//TvTr55daUJSqdKDZd4fSB/zoo1/xoU0A7Gev
         yLwQUvf0SPmIg8T3gbX4TRpooLNhz7AScff13CjO8TBdj62phXFRAKKKK/0DpbOjP/Iq
         kfMhbzlR5Q3hYan5aqBqxWQoLmyWqtIl6KIL7JuIdLVMRxzw9FrMeKiKRLhj5oTxI2Hw
         5FTwUnaFWjuEyRE7c9z2souShHiZIKiBfqikYrLNeZIyFe3preOpx+Kfe3Qt2I7TZY0U
         Hi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QW0NShJ7fDoQCwK8HRFHmEXY/arqlqKQTi2BvHMo4Pc=;
        b=t4hZIQ6T89gnGmW4jb1z72zKf+M3VRD2k13bwjwaBLVaxpl/lfDSoszS/mrLVdRN0F
         qG2psb9LdOWVrsgoZ/M2wyfHESMIAegkz/sTaESkESeeS+ArvG+UEfpoDGNnc7NGWONV
         Z9cAlSzjrV3WerPlANCY6bV94Cyw81hVkcByfQRHhFFYsJs0vvBoX4FA4MudocwuKIgD
         W9bCtb2KjS1rPzuxwz0zcIYSywBp8wS7HrCT3fWgIGg8T4J7xXbUECh5QPq5tA/4egSW
         9kBIN7/W58jUli73ySiPdLoQWfqfNXzWaSnnjw54eI4QPQPVV4XRF+cXpa5Qt/++Y0ha
         BCWA==
X-Gm-Message-State: APjAAAWuXCFisOBDl6kmzX0UM49ngZh5g8Y4DVm9Cy8uvzaVI+sVrZVO
        H8KIj4pm+aht5T5VdO1t1VbGX8y3
X-Google-Smtp-Source: APXvYqxKSXjzUBh3T5tP7yiWe0tIQFSM+4lji5oOfXyLQzypcK1oOJoBIeK/9Aa3vLFZwBqM99CQGw==
X-Received: by 2002:a6b:6b02:: with SMTP id g2mr5184211ioc.13.1566884279064;
        Mon, 26 Aug 2019 22:37:59 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id t2sm27484253iod.81.2019.08.26.22.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 22:37:58 -0700 (PDT)
Date:   Tue, 27 Aug 2019 01:37:56 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v10 5/9] rebase: refactor can_fast_forward into goto tower
Message-ID: <9acce7c911f11dbaa385f924ec8728160f990504.1566884063.git.liu.denton@gmail.com>
References: <cover.1566724236.git.liu.denton@gmail.com>
 <cover.1566884063.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566884063.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, can_fast_forward was written with an if-else statement. However,
in the future, we may be adding more termination cases which would lead
to deeply nested if statements.

Refactor to use a goto tower so that future cases can be easily
inserted.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 670096c065..1ddad46126 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1264,20 +1264,25 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
 			    struct object_id *merge_base)
 {
 	struct commit *head = lookup_commit(the_repository, head_oid);
-	struct commit_list *merge_bases;
-	int res;
+	struct commit_list *merge_bases = NULL;
+	int res = 0;
 
 	if (!head)
-		return 0;
+		goto done;
 
 	merge_bases = get_merge_bases(onto, head);
-	if (merge_bases && !merge_bases->next) {
-		oidcpy(merge_base, &merge_bases->item->object.oid);
-		res = oideq(merge_base, &onto->object.oid);
-	} else {
+	if (!merge_bases || merge_bases->next) {
 		oidcpy(merge_base, &null_oid);
-		res = 0;
+		goto done;
 	}
+
+	oidcpy(merge_base, &merge_bases->item->object.oid);
+	if (!oideq(merge_base, &onto->object.oid))
+		goto done;
+
+	res = 1;
+
+done:
 	free_commit_list(merge_bases);
 	return res && is_linear_history(onto, head);
 }
-- 
2.23.0.248.g3a9dd8fb08

