Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 504421F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 20:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeKNGjM (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 01:39:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34641 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeKNGjM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 01:39:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id w19-v6so11733163eds.1
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 12:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQPnPYPxERypVA3fuA6PjTlQySGFh06iMS3OAwQcVKE=;
        b=eReeYWcpRwUnnOCUSpB7GVW4Oho63igmUJnpVf5Qo4KHbFF1dCKgD5ctUHgC5vp+C6
         LdrEthI+k0huEyBjfA8NjelBvp4GtqoigXpuyoKHDLyYw5jfuDctA80R9feuFIooWmaT
         n6Y+L9olbi0zDM8z4xN2TsCkLVYPAEWO4pjgl98K117gc32PDaDgWRea+DBfmr/OeC7R
         ZRe8Ne2X2KBtJPzT/nTCfoFpC8lUwh4APmRMvaAFZikFqMl/TJMa1qC+cMDzlriv3DAf
         YGBLbHf1EdLz4csovBIH+P1v1igUpPAlawGd/101WgVp5hVY4Q1yME6B7IP+NKJuDMAu
         9zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQPnPYPxERypVA3fuA6PjTlQySGFh06iMS3OAwQcVKE=;
        b=qMZnab06Faf5qxSbTAWZO0nlgWyCaBg65QbM/qCM4OYTULKdrdjBTb3M+hnIGgD1cP
         KK08cL9cPMuklwMbfcSPFYi6BgpTPM4LzlHygxV7UYcb5IhtAj4V8YrNFuCJcGGZKAO2
         SMLnSnhLEmWh8neOIwS3agceQ7QUVY5t6cMiLcQI6chHPNBXSY1WzFJ2NpIIygjjPPVK
         sZ7KiU3pn4Q/zvOyl/eOXqFb0jWPFnBjcSLpykYbqNcM3Lwp8EmWJiyZA/fzxUpKM2Z+
         QRknTX7Vmjq0QttTnJYcBW4O7gx5wQpkiMVr2HkrffNkIPcV/1OxMrKjGg1+GluHOukO
         k4MQ==
X-Gm-Message-State: AGRZ1gKv63GZUVkOoJS5WfBp/Y++0XJtjJ134d94OemTozxsBJbFbbaU
        wXeePqwRh+LRG+VFi7QUPg2R5SL0JGc=
X-Google-Smtp-Source: AJdET5cRzOB5234Kfzo/bDXGXR6UsOmILmo01lg4fYn5a3WChhewzrCmjvH6x3bnKyPay8GW7sx/mw==
X-Received: by 2002:a50:a844:: with SMTP id j62-v6mr17774936edc.71.1542141559741;
        Tue, 13 Nov 2018 12:39:19 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t29-v6sm6065397edd.53.2018.11.13.12.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 12:39:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] push: change needlessly ambiguous example in error
Date:   Tue, 13 Nov 2018 20:39:09 +0000
Message-Id: <20181113203909.30740-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an example push added in b55e677522 ("push: introduce new
push.default mode "simple"", 2012-04-24) to always mean the same thing
whether the current setting happens to be "simple" or not.

This error is only emitted under "simple", but message is explaining
to the user that they can get two sorts of different behaviors by
these two invocations.

Let's use "git push <remote> HEAD" which always means push the current
branch name to that remote, instead of "git push <remote>
<current-branch-name>" which will do that under "simple", but is not
guaranteed to do under "upstream".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/push.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index d09a42062c..8bb8a0849b 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -173,10 +173,10 @@ static NORETURN int die_push_simple(struct branch *branch, struct remote *remote
 	      "\n"
 	      "To push to the branch of the same name on the remote, use\n"
 	      "\n"
-	      "    git push %s %s\n"
+	      "    git push %s HEAD\n"
 	      "%s"),
 	    remote->name, short_upstream,
-	    remote->name, branch->name, advice_maybe);
+	    remote->name, advice_maybe);
 }
 
 static const char message_detached_head_die[] =
-- 
2.19.1.1182.g4ecb1133ce

