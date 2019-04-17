Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6389120305
	for <e@80x24.org>; Wed, 17 Apr 2019 18:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbfDQSBb (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 14:01:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35842 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbfDQSBa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 14:01:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so12362748pgc.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 11:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c8lWj/k6hpVKUyKqXhPc38soSAt9paNJntaTWM/Fp4k=;
        b=lEtv7QV6rhrWFkEOUr6+a3RhO1Jdlw3ewBX2/qJBRbAKWsET5uZjEIGAfQx91wFVLy
         1g9CmJBZbPf8loTYUJToppQx5Duk9FVq7bVrm4WZxOmfesZRWqJxNCi02YYTWi1NqgiW
         9iHRpefHUZMkH3tGvKxeI5ntrCE3yZvRMf34IdtQ1KxI5Aus8zt/fxRPaE4TI5uRL/Ju
         xvquE4/B1AM89NnHVnqs2xLgYbXl+kzQBXVmKKFntGJf0bC75neDBurFkOu1VDIJIqFP
         8POzqvkdgSr5zrb5NEegZGlg+LBKHTbLjOZ1oNSCrgVPyzkrRLt8EUQKo2ll3S+Hd1Yk
         2Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c8lWj/k6hpVKUyKqXhPc38soSAt9paNJntaTWM/Fp4k=;
        b=Hp6/eRkgSzJBhPJl3pOLj5x7ML/MLDugJtEVIDLjdKors8KTui2zrR3OUKKAlFlKES
         oGMfd83uwV/qVdjl4GhAgo/dS+pY/oKGGVP4ax7GWdT7jJyqAhIsfQZzY3SXPQSSljgL
         dTJPdT0itqIsNH98YQirh5DLND1+Mi2eli+4KmXzE1/bjCf31P90D9SxIToGubZ1Bknh
         wuJorE03Uc7G7sgE2x/BNsPaWWB6kurBMARKOFMVPkD//gV9xnZ4lUUEpAA23ga+xfnM
         TQLA12ZEf2m+oVR3B2nxbtDbB1cnauh7ElnzErhudLINUeg6oWatlLrxGO+oA4nYFu+w
         wgNg==
X-Gm-Message-State: APjAAAX1CpKMoSeHo4tL5Dugyyhr0JrouWlPwDkpbAUOaSaiH6vFORuO
        sp6giNoTPADTmRwBqTKdA10DT/NXjNU=
X-Google-Smtp-Source: APXvYqwyAKmhpcYc2fYjb3DwRwb67dGt4CCUWYPnLC9h5UxJkOwYreDRHj50jPuYfFPb6BZRwnri3Q==
X-Received: by 2002:a63:6849:: with SMTP id d70mr83618246pgc.21.1555524089431;
        Wed, 17 Apr 2019 11:01:29 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id k1sm79946757pfc.83.2019.04.17.11.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:01:28 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:01:28 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6 3/6] rebase: refactor can_fast_forward into goto tower
Message-ID: <3d348d2c37751b8ecbbd244e03bd9fdd860290e2.1555523176.git.liu.denton@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
 <cover.1555523176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555523176.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
index 77deebc65c..de10b6f5ad 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -899,21 +899,27 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
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
2.21.0.944.gce45564dfd

