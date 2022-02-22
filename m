Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C1AC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiBVSyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiBVSyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 13:54:04 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5EF11477A
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:53:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so2706899wml.0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qHuemM/PFisCj8yqpuSjuckS/yudqWVqBqBZ+hi0ISM=;
        b=QFSJyLFaQjaRaxbPubax7K528SKUF+tQFiOzSm5j2VtNBC0C7Nu4CZS6WfjbAA0Sno
         fLnqNpKu4C0wTyDzPu1OsgpL4dXHt2pePFUOqPjpz6c5X8rimVPWnvzSuQvxRh0Qxtqy
         DTdDtqZO6YhAolVnDeemqDaxb2MtqzFDeRVAELpdYmn9+8r/o3LqP61cZPfBsVq4YkLm
         Dd6iP6nnFvgFux1lua0xJFpKkFViLiaPJPChr2/VU0zSBdq7QLE6c7U4+Y1s9Isdkwho
         ajnRe0S1NS6fykqhyRk4mko8Ch5Dz5a1V2iEze1naZBiUZ/Ztdo+WWybGW25uTymqJ6q
         kuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qHuemM/PFisCj8yqpuSjuckS/yudqWVqBqBZ+hi0ISM=;
        b=qvQTwhc2Fan8hOEM9yFB16PzTGrygVLa4U1dJZrlC5gW0/gaKtNo6RMqUbn/N2T6B0
         bmRDeCOwBeeV/8ii624vHUI65WxGeJ7nbGPO0ou1kMmr3VlHpC/HK0TCCKpdimEiInMQ
         jGey3YKMoGduEr9oxijYUf2ghMY5l2QBd5xhaw18YJFdbWirN9CWiaQPspfD6WF7OYbd
         Ygp8sxE15I5U2jB+Um+m6YVTk2Bc0YS9x3kXZPlPkmTb1v7UxfSXtXcpxb7H4l9+EF7U
         sV7xE6Lt5VDCd+G0TolDkhdxDPfZNfd0o5kVS5Duzr9d3IL32knjTknr3OgbwwybLKbD
         n76A==
X-Gm-Message-State: AOAM532fXd2teJWmsiYa6auh0fzRG3ccixUpiHT8mqoYi5YKiScXR4/P
        eaSdRGD7ENEvjkjj8FOcs0GeU0PAwbU=
X-Google-Smtp-Source: ABdhPJxokXC8JAmhRaHfaqYBslWc9CHyA0HweVXnIUKGAOZF5ajr48Q7Ba7+w6TE+VL1ZYjwZ7hOAQ==
X-Received: by 2002:a05:600c:25a:b0:380:55e:fa39 with SMTP id 26-20020a05600c025a00b00380055efa39mr4483683wmj.40.1645556017138;
        Tue, 22 Feb 2022 10:53:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v3sm1815274wrv.114.2022.02.22.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:53:36 -0800 (PST)
Message-Id: <45609d61afc647de3afafc4203d904676837ffe3.1645556015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
        <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 18:53:32 +0000
Subject: [PATCH v2 1/4] terminal: always reset terminal when reading without
 echo
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

Break out of the loop to ensure restore_term() is called before
returning.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 5b903e7c7e3..fb8c70a6251 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -385,7 +385,7 @@ int read_key_without_echo(struct strbuf *buf)
 
 			ch = getchar();
 			if (ch == EOF)
-				return 0;
+				break;
 			strbuf_addch(buf, ch);
 		}
 	}
-- 
gitgitgadget

