Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16262141A
	for <e@80x24.org>; Tue, 15 Jan 2019 15:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfAOPmz (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 10:42:55 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:41795 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfAOPmy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 10:42:54 -0500
Received: by mail-ed1-f48.google.com with SMTP id a20so2881852edc.8
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 07:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5LmdtjSxlfBy03AbQW2hkLdzZnoNDz4/Qj4jgjwMQvU=;
        b=bKaKCudW9KNk3I9as6UVI9zhfI5PstuCaZUX8b4ixLyH5LDj5+xGMaAPj37+7RbIq5
         nHhUuwwWEj17OGp5M7XLxjfz1DTC8Y4ImI2A3VlO50xR5x0twcnYwEFZSMt2DyDtzIt3
         rmyk4g9sef1oph5nY/7inl31nGAXC2fBJLSLhrai9sDOq3ET0+Z8QbmOmA2hknLNzzsW
         ifD2m/mKPPUigEyUlvoLdPwPMHV1/xOcZpn2frx1xiIojWBkljgJo4XVd4dgmMVTDgpp
         qiyK5AsXKP7MxaJoepRw/x7OPoLb+ohYF3KE44XqLqyfUMsuq1cePMvfKoNdgUDoid/H
         AwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5LmdtjSxlfBy03AbQW2hkLdzZnoNDz4/Qj4jgjwMQvU=;
        b=V/W+Og1kVZHoOSyhcFuCzkt0C8dbWtphy/vrUgy5mdDtNniMdyl+CRvRXjwznr/WyU
         tmzdOResJUHs72zrtZnLrkXtUEecRwIQnW5LzwCz7L1IEjmBSBIWtU6kO6bd/YK/A6qy
         r8hetY9zJc19IHEazERJWla9MF/vOSyMWeUv7nmgQOkmjt5/mVi63hBZuBkbUbng1HQ8
         npwPCruQBM9s3I6NVPLzPf9OKRFrZ3fWXEUVVD05OYrSFNYjwuSC/rMgN2rnq8xFV7Na
         27DJPaIr+iRfM266U2+YM7G4Mov9W7X7uy3YcaNNFtf8yh+xVDbZJ/TXrMMTbLzu8aJT
         U5VA==
X-Gm-Message-State: AJcUukcgN99J9NmSmR9fAlczhnrAQ6yJCDmIY4RLqH6fdO/j1yePC41X
        JL9G9wkpxU1mvb0u4dCZjBylEDvt
X-Google-Smtp-Source: ALg8bN7vGQIzxuK6/Zb70CXCK771FYnpOlLkJxUCVZLwXT4PLsH03gLYRuY/XPYQrNw3ffc3kXBByw==
X-Received: by 2002:aa7:dace:: with SMTP id x14mr4020888eds.13.1547566973016;
        Tue, 15 Jan 2019 07:42:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm4955046edm.29.2019.01.15.07.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 07:42:52 -0800 (PST)
Date:   Tue, 15 Jan 2019 07:42:52 -0800 (PST)
X-Google-Original-Date: Tue, 15 Jan 2019 15:42:50 GMT
Message-Id: <52f74c5d356325660ca1b494e78fb99a3c6c3861.1547566970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.107.git.gitgitgadget@gmail.com>
References: <pull.107.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] add --edit: truncate the patch file
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

If there is already a .git/ADD_EDIT.patch file, we fail to truncate it
properly, which could result in very funny errors.

Of course, this file should not be left lying around. But at least in
one case, there was a stale copy, larger than the current diff. So the
result was a corrupt diff.

Let's just truncate the file when we write it and not worry about it too
much.

Reported by J Wyman.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index f65c172299..53c18ea429 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -239,7 +239,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 	rev.diffopt.use_color = 0;
 	rev.diffopt.flags.ignore_dirty_submodules = 1;
-	out = open(file, O_CREAT | O_WRONLY, 0666);
+	out = open(file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
 	if (out < 0)
 		die(_("Could not open '%s' for writing."), file);
 	rev.diffopt.file = xfdopen(out, "w");
-- 
gitgitgadget
