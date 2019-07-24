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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0241F462
	for <e@80x24.org>; Wed, 24 Jul 2019 21:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfGXVPC (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 17:15:02 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45536 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfGXVPB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 17:15:01 -0400
Received: by mail-wr1-f48.google.com with SMTP id f9so48391275wre.12
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9/QhqfjyVFjEm4tyIE1riMFzAfqHqfme41NDsEDV9vo=;
        b=hQYJ5TbdsEBczjcEyt4XzkMQ5hap28zzUNb0JAT5umdSoCHgJHW+02Wgm5Ir5qCozq
         4km9J78yCWXaHWUJVXXi/txckJYigMpDa0Hulq314iOIA+aZ5e6QnAfqIked8kHPuXPB
         +DCgo+DXbzWkPuiWjbBy/TTMe94Kd7VqzwNpzvzP++AGui1vFlssJt5TwcJhkPe1vpP8
         ASP4qskGz04n8oeiRlJyr6QFUoc1zL849Epkds1X5OFmxMKiAw2ZdwcfFjZqgZx3ytvy
         E/OkJf9jhwzsgSVm6FzzYmZrwPajB5sWktj5op3AbOmf7l7rRAOx7CIEAi8UU27bQPNd
         v7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9/QhqfjyVFjEm4tyIE1riMFzAfqHqfme41NDsEDV9vo=;
        b=WHdE+valVpiqn6fcUPgZSZCc+cTVNio25LJxOh0E9+49DpHgOrH0aho8Gbn7ajg11j
         WJSry7pJkrx1/mk5dmkdDt7aEmIda9t1SNZnl055vmBqi+G7Gj7SriUOAlIRN0GDrsJM
         klgHJM7QbEJAlWIHErk0oiySqIDLOXkLF58Ee5YbXlCuhoiszNOHiVGWQ3QWpCM4U8xY
         bvqEm5tsLQuBVHxHPUWnu+IaQ6VE5h/a8FXqZ4FXT/p2QDfPg0t9iFDZl0ihjII2pfYp
         Vianj+hjfWwZcP14LMdX4cxAVHMMRz301f1d/yjIZ/LXagq4sgkp4rDUfRW1RzghIpep
         +Gzg==
X-Gm-Message-State: APjAAAWU6G5O3vujzptFPWOQcePeWU4cnU2TDKEiz7/lU971lMoucLyd
        QLpfFiFsEDY5DtTWKGZ2rJYMNRt0
X-Google-Smtp-Source: APXvYqybhHl/oAodhCi26V2eAmIZD5zthZMAjXX37N0d+PXdM1xWxK+SegPfWoZPULYGBzK6dMY3Vg==
X-Received: by 2002:adf:f646:: with SMTP id x6mr95194012wrp.18.1564002899842;
        Wed, 24 Jul 2019 14:14:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1sm43384297wml.14.2019.07.24.14.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 14:14:59 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:14:59 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Jul 2019 21:14:56 GMT
Message-Id: <3bcebf1eae3cad9c55d233f2271126a99e9e34cb.1564002897.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.293.git.gitgitgadget@gmail.com>
References: <pull.293.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] rebase: fix white-space
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This trailing space was inadvertently introduced in 9fbcc3d203 (Merge
branch 'js/rebase-orig-head-fix', 2019-03-20).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 9c52144fc4..798b9ae2d7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -2104,7 +2104,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL,
-		       RESET_HEAD_DETACH | RESET_ORIG_HEAD | 
+		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		       NULL, msg.buf))
 		die(_("Could not detach HEAD"));
-- 
gitgitgadget

