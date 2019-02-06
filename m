Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2AA51F453
	for <e@80x24.org>; Wed,  6 Feb 2019 09:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfBFJmu (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 04:42:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39422 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfBFJmu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 04:42:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id f132so548652pfa.6
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 01:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JcmoG1j346GBdpa+Tmw2qvdxkQ8NNBbT/+FtY20MUbE=;
        b=T/Ju3wtWZ/CEqR+8suhfEqCpsmc86kLg4rLzq6udZ/lbVb7rtTsLr7at+5Xqi/HeYc
         75xx60gjcH93qUcy+zUPaAuafGNl+5lSJnw9Iu2J59E2mvpMoZ7H+Y2501TGiFV8VrPk
         HXeDen+X135USKfTmQ0QIrlwua12NyOC294BHxGwvtqQP7MPfqnEsI2Y1ksO2ME+BAVQ
         pi+DLq0oMyn2ciG+lVy9vnCT1xpSmdVZg3agAhH9MLn/ts5BrfZL3+6M6jlC06HGS6YG
         U7HtlsGcqCusyJs0RptCTRImOxmJ/hZOhjevQ0kfDzpmkVF2Ww3AyXZ5U9ntnjFyXXru
         9JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JcmoG1j346GBdpa+Tmw2qvdxkQ8NNBbT/+FtY20MUbE=;
        b=UR3RZqoD1vfHOpB0G5VTR1QEqCZAn1W2eJ7oUGjIfgecmHbVGJ+kdJhHtmkA5UhVPe
         2xD6HB3d4vwY8VAIqnSOfG363MiwOqVwcbzzpo8hy2YjRSvNDGbDye+c8waOzvkiD7e/
         Zv+syNFXguFAF/YYpciFxHJfEUfAOeVxk3+YsltDr8/GxcjkreCVxeYwGBizZtOutrca
         PgzlJDo9dm+Y/tnJvjR6uNwucMYHwiiEpO//BP3OqUKd8oUx/mxY8+8ScCwFh2o6dog3
         O9UpIJHvqvDMP8Opqma8ftZwnK5r1fEYPReKsSZWfM3Bz5z7ulcZT9r4z8Wmew72tElQ
         mO2w==
X-Gm-Message-State: AHQUAuZe37nKkluDpq296Sgse8ND5UFYi8rVb5l9WF6qmTO2SQ3yMaJP
        Uoz3P9baIkZr4dSsTZcSUWDOrnK+
X-Google-Smtp-Source: AHgI3IZouGNtkk1QvrwEOU1rt6FjAXSQjZ8ubAwkIShv/aFRFlNgzxN8ZgmsxJGcojv8QcRtOaAUaA==
X-Received: by 2002:a62:9305:: with SMTP id b5mr9521936pfe.10.1549446169570;
        Wed, 06 Feb 2019 01:42:49 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id 134sm6752162pgb.78.2019.02.06.01.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 01:42:48 -0800 (PST)
Date:   Wed, 6 Feb 2019 01:42:46 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] completion: complete git submodule absorbgitdirs
Message-ID: <fdb618c323d3cde058e19dea1cd15044e34484e1.1549446118.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 499e56f83d..de56879960 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2573,7 +2573,7 @@ _git_submodule ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="add status init deinit update summary foreach sync"
+	local subcommands="add status init deinit update summary foreach sync absorbgitdirs"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
-- 
2.20.1.315.gc8c1ecef27

