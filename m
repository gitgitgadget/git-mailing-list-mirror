Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B041F404
	for <e@80x24.org>; Mon, 11 Dec 2017 18:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbdLKSfE (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 13:35:04 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:33146 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdLKSfD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 13:35:03 -0500
Received: by mail-it0-f65.google.com with SMTP id o130so13865946itg.0
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 10:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pwD1OclVNPXNsF3EWVkGcon8dOdBOWPEoU2P5156veU=;
        b=BOQmWEUCQaq+ZfvZ3EyDZmEELHGwcDbldrsKpQvs5m+wjNeFIkozh48M+6J+qRwzhs
         kt9QerD8u7pL7sY+RbUGF4aOc5UZT1pZ970Ull7M1EqAtyCQEl0AW/8mFkrGZYVkfeJg
         XLGpyhDFVAWnvTJ2RhmiQlwuh39UZgD0GwgESnIXKvkYL8kkgVqziFtFwTnHzMulpdM4
         MmOseIe+KCwPKdeTXATIbJg78rCnkaRtghRbz5euuaAiV3BVJ+dL6zmeBpWfksJ8Zr11
         a+tatZ4MBPhdeBNbGoMQgZLANrLysfrTIwMDwhxZp7PfaiJSmq6gWcJVjpoeedYByouN
         i0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pwD1OclVNPXNsF3EWVkGcon8dOdBOWPEoU2P5156veU=;
        b=lTGOfSesdSZ44C24/apbeT6KzdRXwvVGOo/QjLc9m3K2bSaGUNfsePDYHPt5/mqfJk
         pxP4/C69fgXqntVvAO0bVgZmug4lmGcSC04L7nLEVrOyRYup0/blj4bp6QBK6p51ImtL
         4N9rbfeeO+fqEeb5XPvzc7dc7JopsXsHKIX10ifnWWTu2RmjaVjMT0hobVnHewRk0kDk
         sXlVkeOjj4SYlq9HkLJvfIBwb9hqRcCbCqK04OxoDpN07snXPyCJxOEi65b87ww2co5o
         41CuszbYysSGFHHjaldsKYdbD9wusY6MzVUPJ/EAcOHWvkcSHaxtDe/HOr4/TrbLAcub
         RuCA==
X-Gm-Message-State: AKGB3mL8vvebHrRQIhRyHZe9U0fj0PKPicI5mIPqUHcp+Fvq7vnNCgOf
        PVz5dkp1f/woSxHTmJTLgpTYVRia1EUZJ25KhuA=
X-Google-Smtp-Source: ACJfBos+oSMz0l5PgAj5UviX1AOguwBqToKW/Z7Gknh598wZC4GcqvsQwa97qHeljDx5X3K83h1e3gLtIKvHueCE1Uk=
X-Received: by 10.107.136.167 with SMTP id s39mr1654146ioi.169.1513017303089;
 Mon, 11 Dec 2017 10:35:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.109.73 with HTTP; Mon, 11 Dec 2017 10:34:42 -0800 (PST)
In-Reply-To: <xmqqefocjrp2.fsf@gitster.mtv.corp.google.com>
References: <CACx-yZ10GiDT=dDeF1EUtM_K4nGd414SDfxLRqGWyXt0ub02Gg@mail.gmail.com>
 <CACx-yZ1dJuUj5mD6WE8yqZCPMK8q-yaJ0GKUSppZ7uDkqvJ5UA@mail.gmail.com> <xmqqefocjrp2.fsf@gitster.mtv.corp.google.com>
From:   Daniel Knittl-Frank <knittl89@googlemail.com>
Date:   Mon, 11 Dec 2017 19:34:42 +0100
Message-ID: <CACx-yZ1DGz2z6qqAX=pzeExT689y0sON+wVDaocdWk75a5SOxA@mail.gmail.com>
Subject: Re: "git describe" documentation and behavior mismatch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 3, 2017 at 6:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I suspect that "see if the name recorded in the tag object matches
> the name of the ref that stores the tag after refs/tags/" code *is*
> not just verifying what it claims to (which may be good) but also
> unintentionally affecting the output (i.e. "--all" promises that the
> prefix tags/ should be shown).  Perhaps the code needs to be fixed
> if that is the case.

What is the course of action then? I wrote up a really dumb 2-line
patch which simply checks if --all was specified and prepends the
output with "tags/".

Good enough? Should we instead update the documentation? Still not
sure, what the behavior _should_ be in the case of annotated tags with
embedded names.

-- >8 --

From 7243d700aad280b11e647e04ade027c412dde54c Mon Sep 17 00:00:00 2001
From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
Date: Mon, 11 Dec 2017 19:24:54 +0100
Subject: [PATCH] Prepend "tags/" when describing tags with embedded name

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---
 builtin/describe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index e14e162ef6..54aaf30562 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -272,6 +272,8 @@ static void display_name(struct commit_name *n)
     }

     if (n->tag)
+        if (all)
+            printf("tags/");
         printf("%s", n->tag->tag);
     else
         printf("%s", n->path);
-- 
2.15.GIT



-- 
typed with http://neo-layout.org
