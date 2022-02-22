Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2610FC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 18:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiBVSyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiBVSyH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 13:54:07 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5F611477A
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:53:40 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d17so345957wrc.9
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WixbW0OSoA7IdMQhhP0xT088HPSMGgfKzB5SsBiwsjs=;
        b=hk2Px5HhkjKnsP4pyoTbIMCzx4A8UPHWrfaepZKxo1eaBLE54DaueWLKVAZs+rMiBb
         5Sn4MBNOLp5FjuWVkVkY5xgG0VVN2sPx7Rz+MezfayP5kUEB7s/O1sYdVctMVHn44EVX
         S5m09c1pSNlNp9WmFQUALRJCdzZiQGSqE2XWw9Zc5rnc5mSyKpuae5Zjp4Mx114oZc/c
         +zzu0qEgf5as6Z8+HI7FljQy4PNVyiGv7se23+jAuZ2IIJe5hYMu8DpNUVbhQnok4Nn9
         V3P5i3MLlqr2PDmZftnhfCcLYJ6f1QXpdwbEWcXMrE4SRRKn4CPu+UXv1nnBJz5iWidx
         jLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WixbW0OSoA7IdMQhhP0xT088HPSMGgfKzB5SsBiwsjs=;
        b=5R9VASS0UYAYv4Z3yybLHfB5u9ZjeR3isLKRtOzJSfa95jDpKcKi0NJBWEAQve5tp0
         4ugTmZ11VtU7DLmXx7U+PuWq5//+YIqMrFBOoBbnYdhPVRQq++GzvXkCe78nkDrZxBUP
         lclSd/BSwZ0UWSDMbfTfjU4QSJzFzHMptDAiqa/q60XiGzJBPv0IkLImI2YPfADfZyfT
         BnpMonw+54cmQ5OK+9ZnP2oK4wTicAw7AqxvGQAZR6hgM5c/2oQ18yqV2zHHIXR5kKhw
         gGIcqs9zNGZJc5m9XOtkAMSRca4tyX0tvHZVv7B0QcWMBCH531ZYsTROWl0ZnRr/YhQ9
         FSsg==
X-Gm-Message-State: AOAM532FBh7yMTxTJ0ZHoKooS1mIg/ZL5oc2HfgoE1WV13zuYwGoZOmz
        koASMT95XIGTtLINHgzr1tW2FyCJ228=
X-Google-Smtp-Source: ABdhPJxcjHtZ2P2hZYbePFzBuIUJ22gObW/aYi42/Yv7CXsGNg9Q6DcXgfvbieNgBaJJxozVdX/eOQ==
X-Received: by 2002:adf:ef44:0:b0:1e4:99e8:a65e with SMTP id c4-20020adfef44000000b001e499e8a65emr21519819wrp.365.1645556019398;
        Tue, 22 Feb 2022 10:53:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12sm45306173wrx.47.2022.02.22.10.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:53:38 -0800 (PST)
Message-Id: <39b061a471bb6e5306f94b3a6d7e19be6ed6a92f.1645556015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
        <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 18:53:35 +0000
Subject: [PATCH v2 4/4] add -p: disable stdin buffering when
 interactive.singlekey is set
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The builtin "add -p" reads the key "F2" as three separate keys "^[",
"O" and "Q". The "Q" causes it to quit which is probably not what the
user was expecting. This is because it uses poll() to check for
pending input when reading escape sequences but reads the input with
getchar() which is buffered by default and so hoovers up all the
pending input leading poll() think there isn't anything pending. Fix
this by calling setbuf() to disable input buffering if
interactive.singlekey is set.

Looking at the comment above mingw_getchar() in terminal.c I wonder if
that function is papering over this bug and could be removed.
Unfortunately I don't have access to windows to test that.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 add-interactive.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index 6498ae196f1..ad78774ca26 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -70,6 +70,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 			      &s->interactive_diff_algorithm);
 
 	git_config_get_bool("interactive.singlekey", &s->use_single_key);
+	if (s->use_single_key)
+		setbuf(stdin, NULL);
 }
 
 void clear_add_i_state(struct add_i_state *s)
-- 
gitgitgadget
