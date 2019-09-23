Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C2D1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 18:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfIWSe7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 14:34:59 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:38537 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfIWSe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 14:34:58 -0400
Received: by mail-pl1-f170.google.com with SMTP id w10so6868285plq.5
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=juU8Gzw/vWl+eNGZhIx3cG9ZZXl9mYcnrF7qxclh4QY=;
        b=mxAt8isMed6EmgKqVBtZE02PvcLz+OV/ThB39aN2p7d/4glhXtDbG5yTsGP7ig4LhJ
         yBCUxzhnhvy7U65hCIrMc+xOp/AzPAZGVv0f4RGvRdr/iVPCp5T4MEDZBZ6iTJjvjhJ5
         N0jkenoXEUHGuGVJx7yod5Qfh5ME3N7lImIpXS1YvZ1ioI39BS4FFJLXqsGrTbOzYrm8
         By8MZx0MkfbuSb2UrwprqvLTfTPVqVs2XmJk7jYjq6jgjxYnfhUVU8x/gPrMeC3yfXw9
         QRFMeoW0WozDS4tUrPQcHYHg2rm28KSqwWH7QIiG6l7pD69isTKlAZgXqEaK8F7J7Y2O
         /cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=juU8Gzw/vWl+eNGZhIx3cG9ZZXl9mYcnrF7qxclh4QY=;
        b=Zd3ZJKx6axmq4ERbd80Th9TBquiAJjpOEmvasJm4M5hkpdy5GspGco35Uc5gtZCvJc
         IQGtrHgiqFtbEDKXIBxWpJcz56+A7q+ElK1k9dj/w2d5rumZ6Kjo5/Nsns1jeI/gyVqd
         dSN+nESawC3Py4A3y9UeNKHf/LbtVY/hFal+4Br8N+iSbApgYK2BqM7PzeQ0zh5j739t
         BoWZCf2FANmJCl97PVD/YAiKkVdJLmJxI9OlRZZidhCyd4L4yegK5hVeZLueqHKGyZOm
         jej/R6CxefyRZCOg58gf2l6UgkNbBxpylsLg+ao9Sb3E7jaBVAH6nnIlIuNefn8BAkf9
         XXdg==
X-Gm-Message-State: APjAAAUhHDe3FIuNa/1DEyyQ71B2IkoyFLPrVqUgdcwhsMZ2U2uOo8g1
        kuOxdZhY6HnKGWgzI5C6EBk0OLJF
X-Google-Smtp-Source: APXvYqwj3vo8JYkF9SWa6Zxnm43jjDF1Xium39gqw2kspPk227bwX84AKSTdFqE2ZMZk+Jv2+ogseQ==
X-Received: by 2002:a17:902:d206:: with SMTP id t6mr1208801ply.8.1569263697942;
        Mon, 23 Sep 2019 11:34:57 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id 196sm18408208pfz.99.2019.09.23.11.34.57
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:34:57 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:34:55 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] apply.h: include missing header
Message-ID: <1fc6dfc5fa45eec6ed20a06efb445c344b8a64af.1569263631.git.liu.denton@gmail.com>
References: <cover.1569263631.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569263631.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running `make hdr-check`, we got the following error messages:

	apply.h:146:22: error: use of undeclared identifier 'GIT_MAX_HEXSZ'
		char old_oid_prefix[GIT_MAX_HEXSZ + 1];
				    ^
	apply.h:147:22: error: use of undeclared identifier 'GIT_MAX_HEXSZ'
		char new_oid_prefix[GIT_MAX_HEXSZ + 1];
				    ^
	apply.h:151:33: error: array has incomplete element type 'struct object_id'
		struct object_id threeway_stage[3];
					       ^
	./strbuf.h:79:8: note: forward declaration of 'struct object_id'
	struct object_id;
	       ^
	3 errors generated.
	make: *** [apply.hco] Error 1

Include the missing "hash.h" header to fix these errors.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 apply.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/apply.h b/apply.h
index a795193435..da3d95fa50 100644
--- a/apply.h
+++ b/apply.h
@@ -1,6 +1,7 @@
 #ifndef APPLY_H
 #define APPLY_H
 
+#include "hash.h"
 #include "lockfile.h"
 #include "string-list.h"
 
-- 
2.23.0.565.g1cc52d20df

