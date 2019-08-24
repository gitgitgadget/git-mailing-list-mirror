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
	by dcvr.yhbt.net (Postfix) with ESMTP id 51CA91F461
	for <e@80x24.org>; Sat, 24 Aug 2019 09:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfHXJEy (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 05:04:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46729 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfHXJEy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 05:04:54 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so25634500iog.13
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 02:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5aGTgTJDDAQZBIm7fmYVi4BPAV0Hs8Ct4tdeyCpmDGM=;
        b=MLgD2c3SBwLpvI4T7Rx5vbXoW69d+SJOfg9K9eGedvY+74Z1OMPr2a2rNwX5Ts+5X1
         J+xVSVteSti/OToomFctzUOzPdx4NIT8iImQDt4OHZpfXg3RFngZaaB5ojoYgBeX5R7T
         jy/zSiW1DW/J0M2rV3c5TRmgjxuxD7FNazI3wJnzDjUnjCOf+CZT3NY3HtY5U1i7U/DE
         Aco+sBu8AZG2oa2xYA1ol0sOja8Q+fnj+ztmIfZfYhCMEUUZh/Bj+v5Cdoc781ACp0Gk
         GSZcvh2IzUJO4c9uGV4G9hidN2WVgAHo19Nt6XHJkG8eB87BahYduPbldkjGKHIU0vGI
         /o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5aGTgTJDDAQZBIm7fmYVi4BPAV0Hs8Ct4tdeyCpmDGM=;
        b=VjmWJMivWiDfuyM1su6TtFHa7MyoCwnEpiQSF2BjtC77rVuTJa90G1kBMOk61scEsa
         c9uqNFYMEjo5lBQlWeSwVfMQpojdQ31rV2o1G9Q9om8wVUceBqeIcYGmAmcKBR4W+26q
         anrKZMntfDd25T9Zu5Abxs08NNpaCNcisfJzUjN38ILl99gj91rGqf62ntNridnCELhB
         DUFWx/bc+PBmGjDdGH4MJs8PZBYdPenRIp7PkJ1wxcMpY7OqHOMVshk8NZKX7ecI9G5o
         0CFxUz5VUKpsvG/CItffufxt4TZX8UZKYccv2P/FMHm9oPBzP11PMhRFf0tlZR3pITQz
         v70g==
X-Gm-Message-State: APjAAAXAaKSDxyto9nOnEUs1087GwUGCgKGLlVCMeHy/NsuBDApO33p+
        +se5oW4vx2SXdszNNacRB5N5Uucb
X-Google-Smtp-Source: APXvYqyg3+OXnXZAsvaqfP7fijt719D5EwcQIVzuS7DXpp3Vm+xulB0p+pvKEHqFVtVpNcJ3tijdqA==
X-Received: by 2002:a02:1981:: with SMTP id b123mr5862888jab.72.1566637493349;
        Sat, 24 Aug 2019 02:04:53 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id q8sm4476072ion.82.2019.08.24.02.04.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 02:04:52 -0700 (PDT)
Date:   Sat, 24 Aug 2019 05:04:51 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/2] completion: add --skip for cherry-pick and revert
Message-ID: <75adf581589dcce1a679d63977b1c82d333b0f77.1566637431.git.liu.denton@gmail.com>
References: <cover.1566637431.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566637431.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though `--skip` is a valid command-line option for cherry-pick and
revert while they are in progress, it is not completed. Add this missing
option to the completion script.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 62f8ef600d..ebcfb5a5af 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1361,7 +1361,7 @@ _git_checkout ()
 	esac
 }
 
-__git_cherry_pick_revert_inprogress_options="--continue --quit --abort"
+__git_cherry_pick_revert_inprogress_options="--continue --quit --abort --skip"
 
 _git_cherry_pick ()
 {
-- 
2.23.0.248.g3a9dd8fb08

