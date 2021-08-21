Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC51C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 14:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5E961101
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 14:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhHUOlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 10:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhHUOlu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 10:41:50 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406FDC061575
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 07:41:11 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so13614995otg.11
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eohqu7nrsWZ04FkovxhsXLW2xcPLdTYEtzD/w4Y2vA0=;
        b=EsQcsKk2lMuuAeWno/Aa/kqa3iEbgoB0TWbkk9NgjBBZx4DPgwVVTv5Cr1iq3/bXSg
         pGBH0uLLqAwSHcL1XCEnhyf7FEyvtYNDpt+Ag/XtfmEjVazVJ47CM3SgtobdAre90kes
         F5Qrah/MvXPJl9L/zIm1hecs9uTF0VTSlYX+GSimdZAvlnTaVTjzwNFRGGR4aSYMnOoV
         ZH4yYXS9R0PY96YnHRjQXU6l921tJOZ1WEfwNBs2XP768ZiSfnIaTjYbsZkdE7WjH/cX
         9CWTCH0RBaOPfDAPglCibEh/eqG9ETo8dHvJateVAtNn7dXXLBHjbICox/Zxjz1FU+P1
         UAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eohqu7nrsWZ04FkovxhsXLW2xcPLdTYEtzD/w4Y2vA0=;
        b=RLY8IDjGivWn/S/3h8CxKhUlYethBjw/tApxHEdf6+FaU7vhNqWwJoxfqHvAtImpa+
         h0aw+jPureWRNFZ0ZMSm30FMNPo1C/ljlZqg1KFc6Nrq+Q7nWKoANgZAyXVkULe8vM5R
         9B8cfd7b17z/c3gThcimKaCdyW5SP0ePKykQE3SAFoweFHLhkgRgAwHPN1uth3q4kBo0
         CkfproshO74dhWMTh51fwSzHBCDknBE07U+IJAQvYH/PsF/zITQ033r70eSo85Fmz3CJ
         D3NOfL/KzFOZEVm3UlrKVAbkFeb621TW5otFxp6sFbWEhu8vfiivb0DpdmVIV9YasTGu
         nu5g==
X-Gm-Message-State: AOAM532k7rYCCTQ2PeLdq6fSga8pgH0JXnHDu1BWfHggDoYusEY7hDus
        AYiHkz5N2VNblleY7q/jNjmivYfbRCPtReyl6wyeXcWML9NCQw==
X-Google-Smtp-Source: ABdhPJxBH9U5YMdwtauotiOoPemowG7TlEUcErS69WaghUcz3QRXBMNoZZZTDuTdppg+x0YwAqoEfWpEIeDNtBcmW8w=
X-Received: by 2002:a05:6808:f13:: with SMTP id m19mr6486835oiw.127.1629556870474;
 Sat, 21 Aug 2021 07:41:10 -0700 (PDT)
MIME-Version: 1.0
From:   TECOB270_Ganesh Pawar <pawarg256@gmail.com>
Date:   Sat, 21 Aug 2021 20:10:59 +0530
Message-ID: <CAAOR--EV5iixus=wY4ukO2VpE6Ktr=XtKB58FDCyUZ0OvqLuAQ@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not sure if this is a bug.

To reproduce:
1. Set the contents of .git/hooks/prepare-commit-msg to this:
```
#!/bin/sh

COMMIT_MSG_FILE=$1

echo "Initial Commit." > "$COMMIT_MSG_FILE"
echo "" >> "$COMMIT_MSG_FILE"
echo "# Some random comment." >> "$COMMIT_MSG_FILE"
```
Notice the comment being added to the file.

2. Append a commit with the --no-edit flag.
`git commit --amend --no-edit`

The comment ("Some random comment" in this case) is included in the
final commit message, but it shouldn't right?

If I don't pass the flag and just save the commit without changing
anything, the comment isn't included. Shouldn't this be the case with
the --no-edit flag too?
