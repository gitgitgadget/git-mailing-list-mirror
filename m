Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3571B1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 08:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfF0IoY (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 04:44:24 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42658 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfF0IoX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 04:44:23 -0400
Received: by mail-ed1-f50.google.com with SMTP id z25so6264897edq.9
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 01:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ItjxU6egcL7o7zpzgb5qhp8DYr07bUNHBU8kA1lqmas=;
        b=vHXt+PT/59rVv9LGZBRMG03pcgQeMpY645XPexBpOykMXXFboM8k5bkUtY6SPkhVVA
         FtDzJLaKG8hmbKqyzEnKv9B6YDa5r96GlqiQfkugVUu4zptEKgjrTmMCMOrcQzWKdBBY
         3LrHZsIeau0Im/OaKt24j54pncAQQuCQ1wrCUC6PpiE9wwnBc44eL8tdc2hyND9VXDWz
         R+h+MzqAVReu0NQNtPeJETtrt2u0+mMh5GT/9gdlfFVZs0rcD0cRYEQWEMj385ivB3Ch
         jJe24jdSJm0RJBeNOca83qliOk1GXzrPisM97aEYXMRMpg/OgWc2w1zagb1U8GG+1OSr
         VImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ItjxU6egcL7o7zpzgb5qhp8DYr07bUNHBU8kA1lqmas=;
        b=VVFCbjR/ZzmLr/ymLiAubzIvx4UMz+3YGnoWp6FbufQQNv53obBxbrmOuYmXVI6yRi
         q/KOf2i+b8vsy1WvwanOF5oDg2ezeMWh0oNY5njeoLOAPtLN0WqqESY/ntCmJMjoDHkV
         2N3eN6LIpLG2l/7iTyyCLoCHl67GR2MhfXagR5kARSKJB5C2JqggKZIDaKdANdF35Yq3
         Ui0SHu9zFNEQKdIqNJtMAOj8r2/GX81FSN374AwukD1uYntlGV6XbAD2kJ8MrFbgCBRe
         31nQR3krWo5+AMvW5VOznVpI2TY0j2nZI2kh8SPBK40ThpCnQmjC2SlTzWdvwnwVmWWV
         NnTQ==
X-Gm-Message-State: APjAAAXJzHEzMmmUwYVUy3VXJf7S5YNcYUgFRp/8dcUKKVwITlqsQpkm
        ZC+X1yc29e58tjVxMhvbKHwIzsRP
X-Google-Smtp-Source: APXvYqyGPzUpDWzSM7exVkBtzuptPl1aV+LOfQ5m9XXdZDmIiIYjbp+v7BoadfxVFCBzkaaXyKqJ+w==
X-Received: by 2002:aa7:c3d8:: with SMTP id l24mr2742605edr.58.1561625061846;
        Thu, 27 Jun 2019 01:44:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm297082ejj.88.2019.06.27.01.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 01:44:21 -0700 (PDT)
Date:   Thu, 27 Jun 2019 01:44:21 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 08:44:19 GMT
Message-Id: <pull.217.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] gettext(windows): always use UTF-8
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main issue we work around here is that Windows does not have a UTF-8
"code page".

Side note: there is actually a code page for UTF-8: 65001 (see 
https://docs.microsoft.com/en-us/windows/desktop/Intl/code-page-identifiers
). However, when experimenting with it, we ran into a multitude of issues in
the Git for Windows project, ranging from various problems with Windows'
default console to miscounted file writes. While these issues may have been
mitigated in recent Windows 10 versions, older ones (in particular, Windows
7) still seem to have most of them, and Git for Windows specifically still
supports even Windows Vista. So from a practical point of view, there is no
UTF-8 code page.

Karsten Blees (1):
  gettext: always use UTF-8 on native Windows

 gettext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-217%2Fdscho%2Fgettext-force-utf-8-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-217/dscho/gettext-force-utf-8-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/217
-- 
gitgitgadget
