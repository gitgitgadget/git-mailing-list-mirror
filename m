Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160A220375
	for <e@80x24.org>; Thu,  5 Oct 2017 20:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbdJEUJp (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:09:45 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36226 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdJEUJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:09:44 -0400
Received: by mail-wr0-f195.google.com with SMTP id l10so1922056wre.3
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y4yW3uoNkPjeKa67VTf5V93guE/K7KDAXsNwHgXMcAI=;
        b=qi4njQGYyxq0qL2l+vTnIZMl8Tys9dMpO6dYe/fkH0xHOzpDMcHpiGhGTwE3UNLoI1
         cfl+xICH1kkmF/IjEkYjU6OGgvlu/83JMl/SgO/XMu0WiGeCVHAL+VqtEC03kZA39x+0
         XTFlBjWb+Eg6Th74/wp+5j5WtJqXVaz6u1NgLCGIs2y3wXRgmHaXoCwCklB+rWolkdin
         eRUH203U1M85OYR9dgzfGPiPF07JgiSTn1MeHcCccZYg3LD8NLkfK1cRGKym0VANPA+S
         6P9kUzJ9BRnVRMfmT3D4DvWbbRavQqwphxIZWtStgLkmOLKBmBR+/FogOcPvpZ/E5TVK
         ipqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y4yW3uoNkPjeKa67VTf5V93guE/K7KDAXsNwHgXMcAI=;
        b=Ql3kIUCrsuW0wx81cN+eDJZVjBeiViB3BGiXJMl/MT7+7IHhHTbgpulbQE4m/hR0Md
         K15q87Gd/raSARtycr+UfRD+jErerdNPMcbw7xen5lgoR+UAfz3DjXY174BhfwXb3v3C
         Puz3XBPuOzbKv6DFAkHXvhadw83Gw2hF9dCZK66Ha3Wpay4T3lYcCe3Bl0yxMA3SUBzq
         w/dWGW/uCg9rP3Km7v8HRtEAN9EqPhmPPSI7QGvEceJV17UK9DBSnjc4N20DrNwNy7qf
         /Zk7sDIte/HAsWuV3PiZW/9adrCBbQtTdgzjoi7ntgt64ota2bumN8OCuTiCFEyXkJ+h
         c/1w==
X-Gm-Message-State: AMCzsaUQAWWGidX/Yst2Ub7fLCORS74pV3EEWdxb3PATU8knc/jiVK3t
        BcVL0nFFLAmyXMwZI+e6vq4=
X-Google-Smtp-Source: AOwi7QBMSAlbc9p01i9XOGkSib7onXXA9iOrIbegkbzu3pQJcMHX3S1qYkaTP+CUN0UWtmjU4E/MTA==
X-Received: by 10.223.186.20 with SMTP id o20mr5256655wrg.3.1507234183546;
        Thu, 05 Oct 2017 13:09:43 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id k141sm138818wmg.15.2017.10.05.13.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 13:09:42 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/1] mention git stash push first in the man page
Date:   Thu,  5 Oct 2017 21:10:29 +0100
Message-Id: <20171005201029.4173-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
In-Reply-To: <20171005200049.GF30301@hank>
References: <20171005200049.GF30301@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because 'stash push' and 'stash save' are so closely related they share one
section in the man page.  Currently 'stash save' comes first, as that
was the command that people were historically using.  However this makes
the newer, more feature rich git stash push very easy to overlook.
Change the order to give the newer interface for creating a stash the
more prominent position.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 53b2e60aeb..a1ddfb8eae 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -48,8 +48,8 @@ stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 OPTIONS
 -------
 
-save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
+save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
 	Save your local modifications to a new 'stash entry' and roll them
 	back to HEAD (in the working tree and in the index).
-- 
2.14.1.480.gb18f417b89

