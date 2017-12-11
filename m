Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49921F404
	for <e@80x24.org>; Mon, 11 Dec 2017 18:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbdLKSiQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 13:38:16 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36593 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdLKSiP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 13:38:15 -0500
Received: by mail-it0-f67.google.com with SMTP id d16so18145301itj.1
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 10:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gAo0u3Z1jjEufLVgwCxrYlte3qUeWpUhcdaI/r1wnh0=;
        b=dxFBlIkyCV5fm38IxDiux8adhQh6jHKXgzOi/NMJJfNmfYCMv0mB1jMQc63IUvMmBo
         7OF59BcVPlHhku2gi3udExKIAYicxzgdyD/nhqpFMaj2+QaqCAdXXimhNviJN81JLe+R
         bXsxiukKhLAIIHMuR+0ymYcIQcPx9I3MvmPMTD5AI+LNr7jKlUFaM9kVNxTAvp2jwHRB
         WLU1v4FU66CHjzaLpRunhjc9kADQZyK7n4irwjo5t8PHKns9xgKOHii2qs88/JoHt4Cv
         +JsCKbbkN2wVboi//oFPF2YWiEB43ZIbGDOWDd+HpMbUlbB8qkOom5X+w9CJ+vpuGeAs
         4vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gAo0u3Z1jjEufLVgwCxrYlte3qUeWpUhcdaI/r1wnh0=;
        b=T8hzjAWHa3E7rXCmFc3LWI8pHwrajx7uOye7Lhm1gYjc7RCOMRTVKiagmTN2AF1obn
         462lFPir+M4DZ82pwrYpO9rJozavVncGSkRBSTq8BzE9ODsPIzM/2UNtVhyipZsYDwHX
         9s3bo4u3O0Q+A52rUegpY42k0sDwJD8sBS3zNrT/VtHan2RUDTZZ6WvyAxti/bXwCAS3
         /aAgX4X7qQkqo678kZ7iGYuD/rV4PqhFOLnFHfkFyLvG4cI+QL1OxV6jmWcq4JvW4nd4
         NoTGVFF/ZWCijqISjfyFgEkHJZFA3kNV+/zuhMCEotTQ9iHiDpCujVMFHGpyvY+WWiJv
         bPVQ==
X-Gm-Message-State: AKGB3mISxppHlPp3ZMJhIX5QdVj5tQwgwqX0M3jeVP9HZt/hEasUnLo6
        DUFpIt3TtbrbNiCokN3onT9deK6UuTnaPfk0ZY6/tQ==
X-Google-Smtp-Source: ACJfBovy+fZkcHQES8qOnMWcUL/lxrzso59dPuqI+LJrJCHuAQrYnKXIyjIoBdNHdxq16hSjal7wy+atvWceSECrEPE=
X-Received: by 10.107.7.169 with SMTP id g41mr1967731ioi.38.1513017494407;
 Mon, 11 Dec 2017 10:38:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.109.73 with HTTP; Mon, 11 Dec 2017 10:37:53 -0800 (PST)
In-Reply-To: <CACx-yZ1DGz2z6qqAX=pzeExT689y0sON+wVDaocdWk75a5SOxA@mail.gmail.com>
References: <CACx-yZ10GiDT=dDeF1EUtM_K4nGd414SDfxLRqGWyXt0ub02Gg@mail.gmail.com>
 <CACx-yZ1dJuUj5mD6WE8yqZCPMK8q-yaJ0GKUSppZ7uDkqvJ5UA@mail.gmail.com>
 <xmqqefocjrp2.fsf@gitster.mtv.corp.google.com> <CACx-yZ1DGz2z6qqAX=pzeExT689y0sON+wVDaocdWk75a5SOxA@mail.gmail.com>
From:   Daniel Knittl-Frank <knittl89@googlemail.com>
Date:   Mon, 11 Dec 2017 19:37:53 +0100
Message-ID: <CACx-yZ3FxqFvXgM-V0stODcyAdCoO83s=WwyZ2OLiJON6qqvkA@mail.gmail.com>
Subject: Re: "git describe" documentation and behavior mismatch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forget the above patch. I should compile my code after refactoring ...

Here is the fixed version.

-- >8 --

From 8203bd0ad5baab7024ebff597c9f35a0250d09ff Mon Sep 17 00:00:00 2001
From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
Date: Mon, 11 Dec 2017 19:24:54 +0100
Subject: [PATCH] Prepend "tags/" when describing tags with embedded name

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---
 builtin/describe.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index e14e162ef6..9da6d85ea3 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -271,10 +271,13 @@ static void display_name(struct commit_name *n)
         n->name_checked = 1;
     }

-    if (n->tag)
+    if (n->tag) {
+        if (all)
+            printf("tags/");
         printf("%s", n->tag->tag);
-    else
+    } else {
         printf("%s", n->path);
+    }
 }

 static void show_suffix(int depth, const struct object_id *oid)
-- 
2.15.GIT

-- 
typed with http://neo-layout.org
