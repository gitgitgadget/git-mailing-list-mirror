Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78B920248
	for <e@80x24.org>; Thu, 28 Mar 2019 13:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfC1NbG (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 09:31:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39468 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC1NbF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 09:31:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id p20so16733162eds.6
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vs307d+a1gx3jEA8oGCR7mKO5fqlVqvJOB3q3lxhDhc=;
        b=NkGBMhRVbyo5tOgIllQFTowsgNGxheFJ6nALgVG0LyoRt41x9LzBuBW2p/msqnBP4T
         HEVjIWmb8HlVjX/3/jlMOjI5IzcIM3tCcWDTQ2M31fKbVgjMYNHbcM4Vry3EoKt435n2
         1JBzux1zUiVc251VqxJD41mCsj/Mw45E19FC8fhsJV1msKIozM0scN5qMdbxUawSKPOL
         sgLHp5oSwj8EgPZsNs5CtjBAZtKvUCaBL5JH0t7rg+tnIM7yCIB92ggIqNLXgwEt39xF
         wyzG0XbK/va+LPi96K4Lm78xszL0IKd/ORS7HtH7PM/Zt6gwPTXG13OJ84Po7ghRpeOG
         ZXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vs307d+a1gx3jEA8oGCR7mKO5fqlVqvJOB3q3lxhDhc=;
        b=Jk50mPfdjMjCnVz1Mlq13FI24up/AP/OXqmi5E4lWzwl5laeAukZaHgr9vilTh22ge
         CtBJeTSxT9mYwYs9xyRKBF0tanuFUgEGf0ZqRwm9MQmh7XZQ+hDWS5YMjsxScXJKoQzq
         fSBQobgGJIOl3yu5C5Bqr6MVLRgsH/TlugjJ+U8jTyHYGb0bDaIcdY0Iwf42XQGJ5jco
         zbfQkzwzw2Ml0jHA1AJpYMeeoj9yhYXM0RI1cRHdHI7naJre/lId0wQkW43IX8w1IilD
         xBhUfPA7LVyGojZPRQNBeQgxPrGK7JztV1xiZprfbpUBIHZ5KrEpPY769yA0bR9xs10B
         t5Fw==
X-Gm-Message-State: APjAAAU0VnTgXtagyooeGp2wFwI5qrX+0LW1KtKa3lIWjEgrW/VTdN53
        Q4LASue/zzUlziNRJyBE49s/4Axs
X-Google-Smtp-Source: APXvYqxciyOK651xcnk7bZR9Z8EmoN/SCymzp4XQFlBXw+DoGRQ/XM6iw6ATA5sYo4+WfZUmvxBtBw==
X-Received: by 2002:a50:d591:: with SMTP id v17mr20339212edi.180.1553779863767;
        Thu, 28 Mar 2019 06:31:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z35sm6805502edd.81.2019.03.28.06.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 06:31:02 -0700 (PDT)
Date:   Thu, 28 Mar 2019 06:31:02 -0700 (PDT)
X-Google-Original-Date: Thu, 28 Mar 2019 13:30:50 GMT
Message-Id: <d4023acde7172089615ea5abd4e91ef90c1791a7.1553779851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.git.gitgitgadget@gmail.com>
References: <pull.169.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/4] trace2: find exec-dir before trace2 initialization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach Git to resolve the executable directory before initializing
Trace2.  This allows the system configuration directory to be
discovered earlier (because it is sometimes relative to the prefix
or runtime-prefix).

This will be used by the next commit to allow trace2 settings to
be loaded from the system config.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 common-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common-main.c b/common-main.c
index 6137af0e63..299ca62a72 100644
--- a/common-main.c
+++ b/common-main.c
@@ -37,12 +37,12 @@ int main(int argc, const char **argv)
 	sanitize_stdfds();
 	restore_sigpipe_to_default();
 
+	git_resolve_executable_dir(argv[0]);
+
 	trace2_initialize();
 	trace2_cmd_start(argv);
 	trace2_collect_process_info();
 
-	git_resolve_executable_dir(argv[0]);
-
 	git_setup_gettext();
 
 	initialize_the_repository();
-- 
gitgitgadget

