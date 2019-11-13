Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5021F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 00:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKMAsH (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 19:48:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34159 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKMAsH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 19:48:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so342136wrw.1
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 16:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ctp2w8PZQaG0illOb47tRec1P9DJ9PRJe3aJNMqZ3Io=;
        b=BRz7twD4Yh5BPhKRcjNcbGLHbSy998gjpLUVIQ6NF5o04t1wJj6FhTJ/AKBXv+Wdt6
         Nnp0iEkBjSHZBRROGvgsQpft8u8f8WaF4wAXfQnB6Ik/YbSQHQzpBeVws5VFDp1UFHgV
         cxsxIfFypZOxrjlqEl/ox9xcTtwAswUBbXa1QXkUtH4rumV8OmTX+Gq4MZp+TjNCfSBa
         0MioE7J46f8bHdhDfqn/jGwNosflzU2eRCKGPHAAZj0ZF68gsPIHzNGZCg7Iq6ujRUrO
         MxR22VoZKpDL09UCw6LCbnbdiwHslQlNf7OtR5EpyytiAzL5su84paE4SJOtA6+ko8c0
         YApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ctp2w8PZQaG0illOb47tRec1P9DJ9PRJe3aJNMqZ3Io=;
        b=H+xFSHDRecsBOG2nNlr5Mw/s73LHui5MKFL/tE8kR2uxzpvfRNLCVCI/HK6umU3oHR
         89L0CvBboj3ZZq5j6GS84mzhozQTzH+vXEy5fwuQg11jWMRV35CjMtgHXmkYeIh+6QAR
         D6ThJ4fZqa9hxA3E8DNsFbi42lLt+JsY7Z4Oga1FNswi78ARZsRDaaS+Frja8VvxWLJQ
         0bmK4O2gmo92fB3PJArZx1XuMDcGHI8LlPGlNXSDTsbZWAzk1c87uAiYNYVRPxvNeNII
         6XEzB55dDKRhduth7GBSfkitrK9aIkVOYlkHTIeSWhx2URMZ9S/674Pp21S4lmWu3k4Z
         Rcbg==
X-Gm-Message-State: APjAAAWn2rnovxVueWjYpMhBh28mbpR4vPuugANB1sVrt9MTMjuOpKon
        mB+qPSCmd6uEwmZDBlUTQhSIFPov
X-Google-Smtp-Source: APXvYqyN6FA0hjsvZcQEGrSHvpq+bg/ijPPJNXYdoYzafY+RZnAiBfmvsIVWLP7O+ydvglTDVk+pIQ==
X-Received: by 2002:adf:fd84:: with SMTP id d4mr139007wrr.152.1573606086121;
        Tue, 12 Nov 2019 16:48:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12sm603567wrx.93.2019.11.12.16.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 16:48:05 -0800 (PST)
Message-Id: <ac8cb233ecea69d46ba5a0af0e63bc7c03963cbf.1573606072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.461.git.1573606072.gitgitgadget@gmail.com>
References: <pull.461.git.1573606072.gitgitgadget@gmail.com>
From:   "James Shubin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 00:47:52 +0000
Subject: [PATCH 1/1] contrib: Add --recursive flag for bash completion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, James Shubin <james@shubin.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: James Shubin <james@shubin.ca>

This flag was missing from the list, and I use it quite often :)

Signed-off-by: James Shubin <james@shubin.ca>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 00fbe6c03d..79fe29ef03 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2843,6 +2843,7 @@ _git_svn ()
 			--log-window-size= --no-checkout --quiet
 			--repack-flags --use-log-author --localtime
 			--add-author-from
+			--recursive
 			--ignore-paths= --include-paths= $remote_opts
 			"
 		local init_opts="
-- 
gitgitgadget
