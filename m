Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5BA21F463
	for <e@80x24.org>; Sat, 21 Sep 2019 00:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407306AbfIUADx (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 20:03:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34223 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407272AbfIUADw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 20:03:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so5626215pfa.1
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 17:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bKgDbbt+/Da5mtk/0Y7wQuo0fY8uRCgwD2WPAR/wh+o=;
        b=jSSoZFT1kVB07HCKSgAsUDriRDau3jI0QhHMYQPxX6pT4U9E/5w0E6rFFFPrcY8lhs
         tICHOHT0BELGG9s5VKIcv54Hd3vtzQGglWHFTEjUnHUfJa/PvPePeo5MVQl8nAYJdIaA
         A/0wp/vyIozkJE7zcyqa44VMthFiZAh0A6GKqFlMTG463jQ3ZxczcPDgPUJSwVCbZfDE
         yHvy4OFbyNqiJB+xPA4cocYrsVcJTLqWhKoQTvT35z/kOX7M42OCYynVudLbWeQezpYB
         aSy0vqC5vAtGns9gD4FNIo4Dcfmnc9lrS0QYWqjUqR3oxQ0VKmmdXD4nC8X6pqVvtIZs
         D3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bKgDbbt+/Da5mtk/0Y7wQuo0fY8uRCgwD2WPAR/wh+o=;
        b=JS5Ypz42eD6XRrG4rg4VHm73QESrBHdJ7ltCFZ3IdVSdqAR3cw5SxHkN1yFLKMl+aM
         dlL4DKWm4xjvdXHzTzNE+aqICglLRC7DAux/jjvYyFS2gJuyCVMPgvq3I8F4Zxd77AB3
         9PjX6IdhJC+6+iHrWjsc0PqETFf4h3hsehwU95g2xz5E70bY2rUqTM7h1hHuNM9QOs+P
         g2qrjwBbKItOEK8kkP3wmRX0/toea3mpY51MAx8u9ataMQRQD6GYMPhj80sqrzPs9cJ4
         o/qwpRWjM1NP9ePGZAF6iSvMPFsfA2SvOa5AigSmEmA4tXP0b6dkjvLLlWLvI+U52cLp
         4+SA==
X-Gm-Message-State: APjAAAWTN+dzT+6cK0lg+AonHoSKprB75Jel6KKkWig8TQNia20jsWyJ
        0jTzX8M7xdi7tEW7g7VixHfI9sCH
X-Google-Smtp-Source: APXvYqzrds2+TVXlFbrhvAXNepaD0tsNGYmj2i9JynB2MH82AyY3yOTG6Al68iea4+XiBTKkB4wtwQ==
X-Received: by 2002:a63:ec03:: with SMTP id j3mr18419736pgh.325.1569024231325;
        Fri, 20 Sep 2019 17:03:51 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id q2sm4286129pfg.144.2019.09.20.17.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 17:03:50 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:03:48 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] promisor-remote.h: drop extern from function declaration
Message-ID: <96a3cee1dd4700a9e033f545db5891e4fa8c073d.1569024025.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the creation of this file, each time a new function declaration
was introduced, it included an `extern`. However, starting from
554544276a (*.[ch]: remove extern from function declarations using
spatch, 2019-04-29), we've been actively trying to prevent externs from
being used in function declarations because they're unnecessary.

Remove these spurious `extern`s.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

This patch should be placed on the tip of cc/multi-promisor.

I wonder if there's any way we can automate this check...

 promisor-remote.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/promisor-remote.h b/promisor-remote.h
index 8200dfc940..c60aaa5cce 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -15,17 +15,17 @@ struct promisor_remote {
 	const char name[FLEX_ARRAY];
 };
 
-extern void promisor_remote_reinit(void);
-extern struct promisor_remote *promisor_remote_find(const char *remote_name);
-extern int has_promisor_remote(void);
-extern int promisor_remote_get_direct(struct repository *repo,
-				      const struct object_id *oids,
-				      int oid_nr);
+void promisor_remote_reinit(void);
+struct promisor_remote *promisor_remote_find(const char *remote_name);
+int has_promisor_remote(void);
+int promisor_remote_get_direct(struct repository *repo,
+			       const struct object_id *oids,
+			       int oid_nr);
 
 /*
  * This should be used only once from setup.c to set the value we got
  * from the extensions.partialclone config option.
  */
-extern void set_repository_format_partial_clone(char *partial_clone);
+void set_repository_format_partial_clone(char *partial_clone);
 
 #endif /* PROMISOR_REMOTE_H */
-- 
2.23.0.565.g1cc52d20df

