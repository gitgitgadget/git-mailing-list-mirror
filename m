Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D16D41F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 14:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbeKNAf2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 19:35:28 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:36506 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731321AbeKNAf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 19:35:27 -0500
Received: by mail-pf1-f179.google.com with SMTP id d13-v6so6160482pfo.3
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 06:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=io8lT52FjEZbVY2PDkiWVrgwwcD0nG7bCBuLJ2yN8UA=;
        b=XWlbPEqk4VeZjFPZU05zv5pixBok0hplxasZ4C8ij5qCmX2NfQs1nsNxkYMGnYcR+T
         tpr6wR+3SJHZCSS9Vo0/Vrmi1hf8ybL7nF19G/eWjv6lL8BmyC06x8JN4dcyBu2SDd+4
         ur4wCz1qeUH+Y9i5jFTsNSdmXWGUD/w3QNJUHURMRKRnRDN1F3PkSheebg5Ni4X5m6w2
         f0LLeXWre6CN4vDLwMU6LsdoT6V1+FXq3SatdQfk8Gfj8osxHPDvckyKVV1EVRF9jTAg
         fVOYTyEzGppeRgUE3XwhvUeM+DShm5nWTkhkpqfqlZl+Mo03jWP0Cfoweo8L46IL8gBI
         E9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=io8lT52FjEZbVY2PDkiWVrgwwcD0nG7bCBuLJ2yN8UA=;
        b=OO+9j8VKplfYIKVMij4JdZdl0VTpVXVOEm4WMa87ul/r1vntdFF2agPuHB/G0VhXgs
         wQAFSXE54AC8hzjJPgSqt+nnxmQcZhBDOKnyFqMRIgHqamQ2/nXIEMxiOl2l47byJuuQ
         QJjkaZ5vrkAZu/8HQpuVC3Xcq600sBRugmkOu37F1B3CWA0a6x+GqcD8eDRdLkiK9JoX
         RCRgnqRHtIgl97MZ6fmTbJps5zSvpen2pcOYdgnA6kA9uU2n5ZMXU+1nBU4xMq7WGMxl
         1jAaEDybL0Fk7mMdSRSxfxfi3rwzChlt5JSJdgfJGM2VTLzdkBUm8mt3nRCMh5ww3cRD
         qE2g==
X-Gm-Message-State: AGRZ1gKc2GDuTbSXhcBOqin5PUSse62/l3IwcdGiGlyENtzZaoD/sFBD
        Hh8fl8Wiq94HExa5mBD1YLFpXKYd
X-Google-Smtp-Source: AJdET5cQ0WAPvXCblBjsVb+RQvxulV1LFKZXR4BFfeiw80DdzY+mLAHTmL5/JFSuy9vJZWmb2m6mYg==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr4802461pgb.357.1542119821875;
        Tue, 13 Nov 2018 06:37:01 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id o81-v6sm32409530pfa.170.2018.11.13.06.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:37:01 -0800 (PST)
Date:   Tue, 13 Nov 2018 06:37:01 -0800 (PST)
X-Google-Original-Date: Tue, 13 Nov 2018 14:36:58 GMT
Message-Id: <pull.77.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] mingw: use CreateHardLink() directly
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

This is another tidbit from the stash of Git for Windows' patches: it avoids
loading the function address of CreateHardLink() at runtime. This was done
in case we were running on a Windows version that does not support that
function, but we no longer support any of these Windows versions.

Johannes Schindelin (1):
  mingw: use `CreateHardLink()` directly

 compat/mingw.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-77%2Fdscho%2Fmingw-CreateHardLink-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-77/dscho/mingw-CreateHardLink-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/77
-- 
gitgitgadget
