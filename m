Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2251F461
	for <e@80x24.org>; Tue, 14 May 2019 11:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfENLWi (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:22:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33074 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfENLWf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:22:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so22361166edb.0
        for <git@vger.kernel.org>; Tue, 14 May 2019 04:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=StPMQp9wAQvFFe9mSh5sKKFRNe/vibnPRHdyAIzq4/s=;
        b=HkN8N3LJxbgPTpcucYgUPA+6ts4w9V7JF7oOenRHBPgsO4h90x3dBu1PY7R8BJvkGI
         q8FZNtt7rojtB8BicJovaRviD9fNsxi1/RI1hnRtVIePQ67gdrJS76n+INOh03ZbvfU+
         GUgyfNNtYUinVQghFMhIWOOcac8TaO1HxciqLHOYP3K9XGS065E0a6MY61yQP4BrYaeg
         2ofJYRedVB3q0UNDYArBfEA9tf1KaBpyjgzzhSEKhGLcLJ/pqskUJF24Ztu+cPjaCH/z
         bt5+MoshMMUfgHI/Ei7CXIaLzwduRuQSZiJHfkKwzXrHltyzuBL56rf3770/C8FvRAPx
         sRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=StPMQp9wAQvFFe9mSh5sKKFRNe/vibnPRHdyAIzq4/s=;
        b=NBjpbf/kLTZUcbF8Nnm2+yBHWjrnbjOwhUmDAvVCDMssskchxMAhJFshlK8qbkAtID
         iQnUMqWdcweIBnPYi0uHdIgO/sZIWsH+Md0F/EpQT2iAo54/VApGZYnys5w3dLzryI9T
         EXBFdhXYd74LrQBJuIGydd39UBCcRBcpNRS+fomNtu94R4D8AHipQQdarRd74DhO0TDO
         RXRaq3Gi7RFjvPdXR4mYAecAmXpr/+QJjSt64/CqT00D309teTAMqc6ILoSP7fl7xThS
         84gA+IR2D+MIgRDWCZeScOPwCPxq1wQVfRQWAhW/1Hy6RKqd18vrFIxUiDnf2S4Qq4gf
         GElA==
X-Gm-Message-State: APjAAAVmzWTrNJawejqKNJs/g68a+VK4CAeNpmJ6Y60lZ4LRhnyPw47L
        3gOKObzJllL+ZzTRLAupuNzEwhUN
X-Google-Smtp-Source: APXvYqxCVXVvbJV+2t4gP/79wpSaCdcTaHwhMXHYFl4NgJKKXQJkrPYfYo/QgtTiD35Y+WUynJdVcQ==
X-Received: by 2002:a17:906:1481:: with SMTP id x1mr26961934ejc.226.1557832953866;
        Tue, 14 May 2019 04:22:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z32sm4443988edz.85.2019.05.14.04.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 04:22:33 -0700 (PDT)
Date:   Tue, 14 May 2019 04:22:33 -0700 (PDT)
X-Google-Original-Date: Tue, 14 May 2019 11:22:28 GMT
Message-Id: <158ddcc54e17bef25869a742483a6c3c8a6398ed.1557832949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.194.git.gitgitgadget@gmail.com>
References: <pull.194.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/5] sequencer: the `am` and `rebase--interactive` scripts are
 gone
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

Update a code comment that referred to those files as if they were still
there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..334de14542 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -767,7 +767,7 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
  *	GIT_AUTHOR_DATE='$author_date'
  *
  * where $author_name, $author_email and $author_date are quoted. We are strict
- * with our parsing, as the file was meant to be eval'd in the old
+ * with our parsing, as the file was meant to be eval'd in the now-removed
  * git-am.sh/git-rebase--interactive.sh scripts, and thus if the file differs
  * from what this function expects, it is better to bail out than to do
  * something that the user does not expect.
-- 
gitgitgadget

