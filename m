Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6971F404
	for <e@80x24.org>; Wed, 14 Feb 2018 12:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030235AbeBNMsn (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 07:48:43 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40158 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030215AbeBNMsh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 07:48:37 -0500
Received: by mail-wr0-f193.google.com with SMTP id o76so18904292wrb.7
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 04:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=nXI0nNy4MPYiqHw267dUpNm8641A0oTzEhDUj0OWILw=;
        b=KXy1lA8gmqaorBfyOz0P0xIulECaP7UJSrvmfR9aurXw+re+70zOoKRn5iNKazXGTA
         /4K6xodXRMsUo2WyWcJJP+ramuhb+3AnRl1ZCtj6eE+hZv1Ge3gpymhsj8PWsZgsaVxy
         FMyMSYB4Hm00yGgFfr+9pBqVlfDvZaMmsLPQiFCYioydiK1GWIyiO/9XxTVMKB24NqHh
         v4RqbWyRy87MGIbKOX62qPXl4aZbzkb07T+O8PFm1M1lKWVRhJuQqqHMkmWNYUl02rkR
         /WIoonOAJSwwuOEA27QfqFvAmQ/DOVowadeut6Z/NBSGrZ2g6r0697ZzuRpQMhYZNoY3
         rp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=nXI0nNy4MPYiqHw267dUpNm8641A0oTzEhDUj0OWILw=;
        b=ceRAHijc60+kKFZMdWKSfhnWMN3pgMq3pTtDRpbptbP6FiGca5SJGxSjTdvidGZq6j
         w+qDMX3QrSf9Gg905BzFsJpIA6Uyr80HMVvPv+L5l4RnIAq3ToUVtyMkSN08ZtEKxJ15
         uIHItBWu05wgdAvwnjUMgdIU/cd5C78VdKpZRtRlktfcbPJm+7P+X2d6RQhXqnnAaHMh
         yRLmpXl5q3P9wlrCfGuAa18foULMhYnF8idx7WXjLDp8ZuL/aJtAFszxmhpfD4HV7hyE
         GpgpVWD8mwYvUeXn9B6f+QCcuTjxEvkZoCdW54WEPaAvChMDPt5AphuTpxo/sBKvSl/r
         LDlQ==
X-Gm-Message-State: APf1xPAATYVkWTjI8KnOuXAb44R/FrDX8q1HHEe32DmMw2SFRK2Y8Zaq
        NJBUWHCqSl9zdr2e3wv7SiI=
X-Google-Smtp-Source: AH8x226MpJfoKQMRWVzdbuES3HEbngfZaPorIHV2+YYTGD+/wJoR/Ax2nuh+uR+CXX0fSKzRJiyU5w==
X-Received: by 10.223.199.6 with SMTP id k6mr4434483wrg.197.1518612515980;
        Wed, 14 Feb 2018 04:48:35 -0800 (PST)
Received: from localhost.localdomain (x4db2793a.dyn.telefonica.de. [77.178.121.58])
        by smtp.gmail.com with ESMTPSA id t14sm11277363wmc.23.2018.02.14.04.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Feb 2018 04:48:35 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?Q?Dominic_Sacr=c3=a9?= <dominic.sacre@gmx.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: Regression in memory consumption of git fsck
Date:   Wed, 14 Feb 2018 13:48:28 +0100
Message-Id: <20180214124828.27845-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.347.gd41f2872c6
In-Reply-To: <b1a4d7ed-79b6-1f6b-1f0f-85536e943cef@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I've noticed that recent versions of git consume a lot of memory during
> "git fsck", to the point where I've regularly had git fall victim to
> Linux's OOM killer.
> 
> For example, if I clone torvalds/linux.git, and then run "git fsck
> --connectivity-only" in the newly cloned repository, git will consume
> more than 6GB of physical memory, while older versions peak at about 2GB.
> 
> I've managed to bisect this down to this commit in v2.14:
> 
> ad2db4030e42890e569de529e3cd61a8d03de497
> fsck: remove redundant parse_tree() invocation
> 
> If I revert that commit (on top of current master) the memory
> consumption goes down to 2GB again. The change looks relatively harmless
> to me, so does anyone know what's going on here?

I could reproduce the increased memory usage even for much smaller
repositories.  The patch below seems to fix it for me.


 -- >8 --

Subject: [PATCH] fsck: plug tree buffer leak

Commit ad2db4030e (fsck: remove redundant parse_tree() invocation,
2017-07-18), along with that redundant call to parse_tree() in
traverse_one_object(), also removed a call to free_tree_buffer() from
that function.  This resulted in significantly increased memory usage
of 'git fsck' because of all the non-freed tree buffers; in case of
git.git and '--connectivity-only' it went from around 270MB to over
1.2GB.

Restore that free_tree_buffer() call to bring down memory usage to the
previous level.

Reported-by: Dominic Sacré <dominic.sacre@gmx.de>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

 builtin/fsck.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7a8a679d4f..8bc1b59daf 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -180,7 +180,10 @@ static void mark_object_reachable(struct object *obj)
 
 static int traverse_one_object(struct object *obj)
 {
-	return fsck_walk(obj, obj, &fsck_walk_options);
+	int result = fsck_walk(obj, obj, &fsck_walk_options);
+	if (obj->type == OBJ_TREE)
+		free_tree_buffer((struct tree *)obj);
+	return result;
 }
 
 static int traverse_reachable(void)
-- 
2.16.1.347.gd41f2872c6

