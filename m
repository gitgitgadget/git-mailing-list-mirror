Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4418D20248
	for <e@80x24.org>; Tue,  2 Apr 2019 05:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfDBFip (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 01:38:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43942 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBFio (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 01:38:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so5752374pfd.10
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 22:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CdGzzqhCOmcUH8PRQH5WqtxdUeCyBF1jd6Fva0omfM4=;
        b=PMnDd4w1PQLUdGHyiFHEw5+jyaAmFDVSgexz+eoBR2WfQTYS97iLFotqWH05tJaNYe
         JfkVqndI2cNvhsUYr/xAAKm9s79JC/aPWjlL6lk5JNjAsTuUOtOFnoiBst05CJQLz8bv
         asCgKqEXEp+owVvqr6NG6+OqzF8Y+yxrar3LYmwFsZrQ04aDnfMq01wPXI/MMzqaTwPU
         CB8+GwqilH1FNDkckyArsDGVUUq1NC0Ep/L1aZCeedZZ177wXrV9XOhtbB6+7294F1XZ
         ndPSt+7QMCzxbWfnILHfQi0+mCbFQlTBZYVpS9eGSwyVJKvCxCqQe2d6X8clXYF5oQmz
         Wc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CdGzzqhCOmcUH8PRQH5WqtxdUeCyBF1jd6Fva0omfM4=;
        b=JbsYeIVBYIEmRxPF7JW74AdQadl+kig0wN+VlCQ3KagLygIY9X6blkfRQk3IfnwDez
         FW7l7hVs8HokSnrTp4WAsFtiFYvhyskoi9kxwUFqrRfLLeatz4uKJnLI5LsT+jEHk45D
         3rQBTHxnQKWNe0xI73i0XNnQHE/epBchbK2D5TRlApptwfFTMBNAjWmdjcijlU0otCNX
         iB/MPVCDB028Vy5TCU8k1kRXvW42mP0jk+KVtl57ftmEaHEfNTHYSRv+cQx7FfriZdwl
         gwxDVotFKQMsz48ApRaXJSytEK80oE3x96yTt8N5/XuA4aT06l/HOpYV+zyrn6JHyOqj
         ID7Q==
X-Gm-Message-State: APjAAAWdlSfKvE87bR+ebIeVatoKxUO4R8qgv4q5VpGgcbrCesn7y7dR
        AQM8ZHYOhbtr77X8KT3VC/X2tbVk
X-Google-Smtp-Source: APXvYqwhTdjR0Px2E7cNcGUZkerDlcg9CS9BXIezofSLl02Sm5fMmVex4vF9apvs/uj7/5ThT1xp0Q==
X-Received: by 2002:a63:195:: with SMTP id 143mr65063912pgb.54.1554183523538;
        Mon, 01 Apr 2019 22:38:43 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id c1sm15585686pgk.44.2019.04.01.22.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 22:38:42 -0700 (PDT)
Date:   Mon, 1 Apr 2019 22:38:41 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/2] tag: fix formatting
Message-ID: <c0d39a2829a82e5735b34535cc37ff824ba3a445.1554183429.git.liu.denton@gmail.com>
References: <cover.1553586707.git.liu.denton@gmail.com>
 <cover.1554183429.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554183429.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap usage line at '<tagname>'. Also, wrap strings with '\n' at the end
of string fragments instead of at the beginning of the next string
fragment.

Convert a space-indent into a tab-indent for style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/tag.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 02f6bd1279..faae364e0f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -22,10 +22,11 @@
 #include "ref-filter.h"
 
 static const char * const git_tag_usage[] = {
-	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
+	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
+		"\t\t<tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
-	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]"
-		"\n\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
+	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]\n"
+		"\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
 	N_("git tag -v [--format=<format>] <tagname>..."),
 	NULL
 };
@@ -215,7 +216,7 @@ static void create_tag(const struct object_id *object, const char *tag,
 
 	type = oid_object_info(the_repository, object, NULL);
 	if (type <= OBJ_NONE)
-	    die(_("bad object type."));
+		die(_("bad object type."));
 
 	strbuf_addf(&header,
 		    "object %s\n"
-- 
2.21.0.741.g2c528c8f87

