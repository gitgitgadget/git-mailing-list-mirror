Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E739A1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbfA3TvN (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:51:13 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34528 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbfA3TvL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:51:11 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so665040ede.1
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 11:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=Pi4rfOXv4KH1sapROw+HR3tFHzdTcXwTWi57a76wEbNLDcO4QsAQnAxu9j2jAR0Em7
         Ed0nB5agSPKrdKm822P/omOnNBxjkH6besUhtN3JEMYDov+j7PR4m5yIos+8zdYxBhg8
         k8mxuueqVV8uk6sRiM2mRNocxUsQVH31ACUXhPsDgpbH28K7Y+9ynWtXbTqRfRkUvdHt
         YpJ4L67aXy8BsmR6d3c1Jz9ui+C8x8M2MUpV7M5qoyz05ImPX5ZkI9+g65HiF6L2Taqh
         YGbqPAWOIqzPWgtZjqHRknLEr658ydD0420Tky89SdL+gJAlMNomK7qkvy5JGMn338eu
         Q/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=k/6tGemaATOciWXAuOdYHJP3JWCynBMoJEOj70bNBKyaIUXPqF+g3VjZdNhBQVPJpO
         OfFgQw0KbphyP1yXBLJeOaTuKneChyTcm8d2PvnkIYxBhYbRsLW5TVKSm1ZlPJrHaIAf
         qx7MNXUYCRB5A4E5cFlqKbkIyizeCOEJRxGmDMmRuSH4CCBhSMr9yD4DG5A299oBjhFk
         4ykg6dvZisP4gOf9e7aP4bAaRuRf8jxcH5pnhJzZgEVhSavMZPFknDLhkmw07GmHDXrZ
         0rpcUHj6ItSKdumIstRZMpzt2ixgrgROcy/EhUXl0b6Ztm7ZnOUx929UrlPGKA37EE5A
         HNmA==
X-Gm-Message-State: AJcUukftjiennX9QkpvSHysHXUp1z/SehNtu6IX77Qeu4c1l5kUHGjJi
        0qjMUOnQBacPdRNwMNHg6rCG9ZUY
X-Google-Smtp-Source: ALg8bN5fHCw6CCmo+LSxa/B1on97+N8f2EB9eLLPlrUkcsSm/Pg+F33ZtAQ6csy9mqKhf/REh6Qybw==
X-Received: by 2002:a17:906:258d:: with SMTP id m13mr13766483ejb.73.1548877869499;
        Wed, 30 Jan 2019 11:51:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm735411edn.14.2019.01.30.11.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:51:09 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:51:09 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 19:50:54 GMT
Message-Id: <2513091f779df302d3d86f21e51e97840654d45f.1548877863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v3.git.gitgitgadget@gmail.com>
References: <pull.108.v2.git.gitgitgadget@gmail.com>
        <pull.108.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 05/14] trace2:data: add editor/pager child classification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2 process classification for editor and pager
child processes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 editor.c | 1 +
 pager.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/editor.c b/editor.c
index c985eee1f9..71547674ab 100644
--- a/editor.c
+++ b/editor.c
@@ -78,6 +78,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		p.argv = args;
 		p.env = env;
 		p.use_shell = 1;
+		p.trace2_child_class = "editor";
 		if (start_command(&p) < 0)
 			return error("unable to start editor '%s'", editor);
 
diff --git a/pager.c b/pager.c
index a768797fcf..4168460ae9 100644
--- a/pager.c
+++ b/pager.c
@@ -100,6 +100,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 	argv_array_push(&pager_process->args, pager);
 	pager_process->use_shell = 1;
 	setup_pager_env(&pager_process->env_array);
+	pager_process->trace2_child_class = "pager";
 }
 
 void setup_pager(void)
-- 
gitgitgadget

