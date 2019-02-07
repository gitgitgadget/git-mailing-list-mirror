Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBE41F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBGKS7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:18:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33668 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGKS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:18:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so4314928pgu.0
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DFZENMtGuzmAV7kZTBr2oM8uubuin3VxWAc/z4Tw6UM=;
        b=Y75Qel+hbL1oYOssxpanGmXsXXaPtquuswkvRgiyawwfd4TMhmOCahoriPO98TQwV2
         jJtL9sSNl130iNNcJyuhFFDfjiS3V2a8uV5sKPdlR4Lj5oMHeXOXn/6A3d/FGPN7QdDK
         HHD7FP1RHwREGM3BcSKfeugtHbgNcmtbp7CuP+vf6g9kKgbAq9peWGTb+GuFe0eprD5d
         IeaPPfO0PhjdhxwMi+ebf2cebAMw1gfTnREJkLzXApEzL1vpskB+uCNzhGgAlppVKWmc
         X1JKqbBpRVXRtqGZcHrGrgJL0J89HKgC/RUp6aeo2ziFPQ/KS9RgcEPmok/7tq2niwxv
         ma4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DFZENMtGuzmAV7kZTBr2oM8uubuin3VxWAc/z4Tw6UM=;
        b=JB+bWJ+ac4XIIsI43KLU1XBeQD/07e41v8CSd4Tv1wl0vyIe0rHAsaL0YA860Vkf8z
         uZZLQ7c2izjP0JbcUrsyrio57Suw9SPEY3Nov6KIrBBppu9wq1+axya61M3AuPsNVnPC
         qEyvoF+VmURBSzhMrdWJASoPhR8YODcljjkRl3d1H3eqiAHB4I67yrvCd3Ug7c7e/CQx
         bKGr7W23fwZyLYOxb7SoNAaOzAucj68nbz3R30XPPbqOdF6qNp0ZPh9LhWB3FLLuWj0o
         qferAYnK63NqJQPccsRPNL2byzMeQTuZgdhjytsbvJ78nV/r1n/UvS7oaBS257rpr9cq
         DABQ==
X-Gm-Message-State: AHQUAuZVeb3Ef2Snd4mWPpvtCfR4YFGatZytBiOSdAktJrXnNOGZ9QhB
        pP/bc6X5dil/8hdwE8UfRxNNAsaZ
X-Google-Smtp-Source: AHgI3IazUQu77bp4NkAFZdDE050KI8pKlp1i5Hgk/ayFN8rVvIdNN93uTvreO9voCUFJqoe5K5PBiA==
X-Received: by 2002:a63:e950:: with SMTP id q16mr14201482pgj.138.1549534737456;
        Thu, 07 Feb 2019 02:18:57 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id 86sm15048127pfk.157.2019.02.07.02.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 02:18:56 -0800 (PST)
Date:   Thu, 7 Feb 2019 02:18:55 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v3 1/3] git-submodule.txt: "--branch <branch>" option
 defaults to 'master'
Message-ID: <b7c65622eb1dd64a4252e441910809d3c66ed49f.1549534460.git.liu.denton@gmail.com>
References: <cover.1549521103.git.liu.denton@gmail.com>
 <cover.1549534460.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549534460.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This behavior is mentioned in gitmodules.txt but not in
git-submodule.txt so we copy the information over so that it is not
missed.

Also, add the missed argument to the -b/--branch option.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-submodule.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ba3c4df550..4150148fa3 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -255,13 +255,14 @@ OPTIONS
 	This option is only valid for the deinit command. Unregister all
 	submodules in the working tree.
 
--b::
---branch::
+-b <branch>::
+--branch <branch>::
 	Branch of repository to add as submodule.
 	The name of the branch is recorded as `submodule.<name>.branch` in
 	`.gitmodules` for `update --remote`.  A special value of `.` is used to
 	indicate that the name of the branch in the submodule should be the
-	same name as the current branch in the current repository.
+	same name as the current branch in the current repository.  If the
+	option is not specified, it defaults to 'master'.
 
 -f::
 --force::
-- 
2.20.1.522.g5f42c252e9

