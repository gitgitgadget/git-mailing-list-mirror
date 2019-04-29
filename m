Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08BAB1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 21:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfD2V47 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 17:56:59 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33369 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbfD2V46 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 17:56:58 -0400
Received: by mail-ed1-f54.google.com with SMTP id n17so1871530edb.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 14:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:to:cc;
        bh=1l5Is1PUHVyJUDucVk+tIchy3H7jvX1N5oD4FJp8IPM=;
        b=ERPSXv1BYp+kdhxVqD5m0ojLoFf3AV+FYlR+DBsXIa/gdn6jY1TCjmdoeeOK+hf6XR
         E/EorPZkrXEzcrgPLJnJWKNsKmmKOKW/jIAcyligRZuk9VqKNuFfNnYarkKd7U106Vuu
         1frwSOxgC1Kr4DvHMp4ACtGkTHYRze+3kqVc0vwFiGSVfVD8dY2wJPDcvDrGZqZASm8n
         lyO3Hd4zMbLeX0q5z8p/z1ERAD2xHffBHPYNmP/eTsSYdJZq+n5WRRL5aBXB1hkFqw15
         ccBGTX4uqM7KwFgHrKF/CG7suaDSspGtiVJQLRcQp+kXsHi8hh/fef6jIGFhWavDsJEy
         ARcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=1l5Is1PUHVyJUDucVk+tIchy3H7jvX1N5oD4FJp8IPM=;
        b=HWXOIHLfY/fsxkNnb/xDmGQF+B9FsFAt+ShWxY09wNGuUkS3X9rUVBweL4k3x82FWz
         U2YkRs+mLvBjcZxj2ci0p2CmfIBu2dLLE+Q7wskjeWf8waIoJm0RiUbiGyx9S23r7xfU
         u0osQ3pFwzwJnFWzJqfkToQtabNvYakeQwrv+7KI2UsErb1XV0gcfxfHLmnJN7/R3oW5
         WF8/VQJ86xN8/yG3raWDyeevNAVkWM123Wzc8IaaKI3BDW2BMchAMnTXES34CFyP6HXc
         qm++3DV3pr15c/V+sPNf0SB+Q9DcTJ6JSXyp9PKBNrNR4om+ogl4xFkvN4d8bwjLdyLK
         qyXQ==
X-Gm-Message-State: APjAAAWRb3mDSRizrizsecRPTzXSBL/7SKUVr1xKwImoeSzt+C5UMQVv
        3ZFFCLd06lJHVyA7dLqqJLGmbuZy
X-Google-Smtp-Source: APXvYqxkD7a4CQDqwvUd1YDI4/ih3mFsr4GCO7FLyCN6oB6luR+uX9jR1EG9WVxAh9tEa64trRwiWw==
X-Received: by 2002:a50:ce06:: with SMTP id y6mr8366872edi.160.1556575017000;
        Mon, 29 Apr 2019 14:56:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w14sm1843491eda.18.2019.04.29.14.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:56:56 -0700 (PDT)
Date:   Mon, 29 Apr 2019 14:56:56 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 21:56:53 GMT
Message-Id: <pull.134.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Enable Data Execution Protection and Address Space Layout Randomization on
 Windows
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two techniques make it harder to come up with exploits, by reducing
what is commonly called the "attack surface" in security circles: by making
the addresses less predictable, and by making it harder to inject data that
is then (mis-)interpreted as code, this hardens Git's executables on
Windows.

These patches have been carried in Git for Windows for over 3 years, and
should therefore be considered battle-tested.

İsmail Dönmez (2):
  mingw: do not let ld strip relocations
  mingw: enable DEP and ASLR

 config.mak.uname | 8 ++++++++
 1 file changed, 8 insertions(+)


base-commit: 39ffebd23b1ef6830bf86043ef0b5c069d9299a9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-134%2Fdscho%2Faslr-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-134/dscho/aslr-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/134
-- 
gitgitgadget
