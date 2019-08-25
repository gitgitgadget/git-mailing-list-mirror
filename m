Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842261F461
	for <e@80x24.org>; Sun, 25 Aug 2019 09:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfHYJMM (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 05:12:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46378 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfHYJMK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 05:12:10 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so30087991iog.13
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EC1lRO9VCiZafpGaH+G7DJnqK6yip1C50RJZJcalzKo=;
        b=qXC+HCI5vzR8hFAH4PkF4QeCDydbAVT8N5w+1VenZuzt2o4g7USrQIYjJvQuCgBxC1
         C2J+pJOMUVSaqf6WaG2xuYfrUlT74ovLjjzHxBsHFn4cf1XDdBWI87LrtErml+XKCd50
         k2IoRaZ3kgkgMUq9hbwxhSQqUUg2+grzKPW61VDL7s2Al5PfeD5n7fdXmLQvPbNITQxx
         iGcu0U+HfvDXL2wCcPlApBRDL5K282Obt6m+g2y8xLcIFN/ZSzRPgfOqIdbL10QkTu2H
         wmqyPs3ltFLU3321viMLN9W45zDSGgI7cmoRU0akhYDGsVmkBD+SqDly+9ZKKSK8WQUD
         iPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EC1lRO9VCiZafpGaH+G7DJnqK6yip1C50RJZJcalzKo=;
        b=K8USMJpM+1vgIWsh3h8/04JXQUhr3EfA73sB34hiFLEwB5Pc9+24ORo9x/geo2M1Xt
         qLmv4PfjAY1oFPvxNyVzSj4y3EsyFxTSLgIh8hIn5Dprv1Z5q+i1Ze+JffCJYHP0ZlYi
         C2Rk8awMawkPp8IgSV3CEb2JHYnkPa4mhTupfVOqqcJM48hV7HbXJey+DdM2s4fSdf87
         k3WSdrTkCfOwmitlgLzmDNm5kbMKkPGgtS3b+SCQy1+fPf1UiFLk7ZvYEYOQG2Z/lF/o
         Epw7dLkSvG3x5bzvYrE/2x2D35UjCW3g5pY1B4LRA7bHTngaFjQlY/+oUauU0O1O6FGO
         XNbg==
X-Gm-Message-State: APjAAAUro8P8qoXoHCRrqWr4Z/+x7YZw9Wus0747QQErco7Q1JBFwjSA
        cBMmUxr/OX6yDpOWq11Pe6a0W5lr
X-Google-Smtp-Source: APXvYqyWGWxRoBOD9BIpJBvc86hEcny6VraLkrJ8YrxoVV6+0O2tBSNVswgqaCOcP6USdcVkOdCDwA==
X-Received: by 2002:a5d:9696:: with SMTP id m22mr4075437ion.14.1566724329838;
        Sun, 25 Aug 2019 02:12:09 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id b17sm7100852ion.55.2019.08.25.02.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 02:12:09 -0700 (PDT)
Date:   Sun, 25 Aug 2019 05:12:07 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v9 5/9] rebase: refactor can_fast_forward into goto tower
Message-ID: <9bd34b4a404136c974b71975c7a3d809a874cc3d.1566724236.git.liu.denton@gmail.com>
References: <20190508001252.15752-1-avarab@gmail.com>
 <cover.1566724236.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566724236.git.liu.denton@gmail.com>
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
 builtin/rebase.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 670096c065..22c4f1ff93 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1264,21 +1264,27 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
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
-	free_commit_list(merge_bases);
+
+	oidcpy(merge_base, &merge_bases->item->object.oid);
+	if (!oideq(merge_base, &onto->object.oid))
+		goto done;
+
+	res = 1;
+
+done:
+	if (merge_bases)
+		free_commit_list(merge_bases);
 	return res && is_linear_history(onto, head);
 }
 
-- 
2.23.0.248.g3a9dd8fb08

