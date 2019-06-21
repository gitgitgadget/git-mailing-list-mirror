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
	by dcvr.yhbt.net (Postfix) with ESMTP id F279F1F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfFUWbO (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:14 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:47078 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfFUWbN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:13 -0400
Received: by mail-ot1-f51.google.com with SMTP id z23so7754577ote.13
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJdJ+cVBt2NPC+R8OslmiCr4boUthgsYe1wDirGtLvc=;
        b=H6ol2eCSjqxwcCYZK4Bcdx62GQtMq0/Ujt0pEXQmhbszY1RsLWAgAIJMOQO1RWeqAu
         Y2hyeeZSF6Fi7Dpbg8UYkeqwTcvAkzdFKawKsGs3ZhOXe1I2ncTE4fWBkvpa80RJ2Yu5
         eNuEWF8MqD1SRu1qEHZDwqxAOtfXoVmJNbKKrdh0Gc4C+QHAYRvz79W8xK/7NR3GLxQY
         RaAEWa+JIJ015PkkMY97SpfteuSHLi/RJa7/cgOkEiwlZZoGyJOXntm7ooWpSRjc66f5
         39ESXR7BK5fHYNJDLNFzKOk2yZ9tCxnxMoXT17cGcIFck/BAGzeC7hluPpqJcbwFvvLr
         Mr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJdJ+cVBt2NPC+R8OslmiCr4boUthgsYe1wDirGtLvc=;
        b=HSPcSlwOZO7GAB1ftC1Rk1Hm5NbbR2/hGmA0IVMezl89tmXBCH91aLRnPzY4BWNWFm
         tktFK2c9sNZpmkWzxZMuN9HGTyp+VKHct1U++Y/+4aje4lIXfMACBguH6GIZYhH1zeHi
         gFU1S8k0e8VP/56cccpctr5ko4zFzKwLNsX0xHVCjiwmQZorloAOaQ/Ghe5Z9PdW4I3y
         4jbyvHWQcgxEVt7EkbIEy8yQeLSqxK9H95IKPj2QMjUUkDxuDdNHMvgC8vHGVxFQ1DUB
         UGRnEI5W4VO8d11eC7wocDBgvsSYcilQ+YsQv53eb9H26BD3v9UNKFxOgQkGA9DPRXVG
         eIIQ==
X-Gm-Message-State: APjAAAXvheUTcFDb7lMqo7aRMubLNUrfFjO7efYI2fBvt6TJL9v41cBv
        OnfA6VLNAbY0k4+u66PQy1QHWk7hag4=
X-Google-Smtp-Source: APXvYqyQqVPfov8ozYFGXs9StW2bse1OJWwisIF+UsTdz6LtrsAss3I4NmPrLwvXc7QkbAateprfQA==
X-Received: by 2002:a9d:7d92:: with SMTP id j18mr58867107otn.339.1561156272261;
        Fri, 21 Jun 2019 15:31:12 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id y7sm1488273oix.47.2019.06.21.15.31.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/14] completion: zsh: fix for directories with spaces
Date:   Fri, 21 Jun 2019 17:30:55 -0500
Message-Id: <20190621223107.8022-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 0d66c27366..034cfa9e8f 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -30,7 +30,7 @@ if [ -z "$script" ]; then
 	local -a locations
 	local e
 	locations=(
-		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
+		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
 		'/etc/bash_completion.d/git' # fedora, old debian
 		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
 		'/usr/share/bash-completion/git' # gentoo
-- 
2.22.0

