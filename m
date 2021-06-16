Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB35C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 15:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECD561159
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 15:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhFPPv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 11:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbhFPPvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 11:51:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0806C08EC20
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 08:44:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m18so3235388wrv.2
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=l4Fz5YD9yo2Hsb2EwwpFWbEN9W/mFSCjy7hZoE815xE=;
        b=evUTMM+iG+GgxhmIIG/rvHhXVRnMeXfgEcGiNW1euKapY9QkMR00XfKlLfoQP9b6KO
         BObaF5XFBcZXRCZmiXuBsHfIwCmrcPn8GNC2fCFTGPyx+u7lGXo0klGBamj6R0w07PME
         9l38K1Sn22Z0BjoV6EcF8oTnvy6jCEoHr/ou0hXJ+1oZYVgZcLg1P7DcTqGW9rdgCYeS
         HCB8wGhfbrl25TZ/xYvCi/1IQR7JyO4IabIdI4Ti773OEOaIJRpjrIK9JibrYEoDPzOX
         S1tLAz/ZDc4G7S9snDT6ntsfDa3RARtan/3pGSJPa6Z5UnNfkwICiwfyR4zis69DkHW5
         cvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l4Fz5YD9yo2Hsb2EwwpFWbEN9W/mFSCjy7hZoE815xE=;
        b=DOHogj/EUek18Y607oOpj4ppWgmMDZi+3T89Gw56m4fcKo+wDgTryZuc5ZiuHr9jAF
         pFqACbgkZlIFg4MP6k/9nTNAbKdzRKW9j2YI/D8f0jEgLJMQ/UsibevounOm5dcLNJVf
         tNdfjxkcCERoX1JdsY7BWCGMqClto7KD4hJdXt8owgI2LfW/Yew9HVXFYGTjbDORtiWi
         +0Drpscv1GAd2usTyae1ig3NPR7c7cBnTKGqkY5QXvEcEmD8FSFN4BwMIN1TNDNeNoG7
         9n6Wvmtlt1eyIvOOzi7KP4Jm3YZVkDzzeEQ1pzaETEWZK6PWArjmQsw7DJwLWyLqAXi9
         WTng==
X-Gm-Message-State: AOAM533C089ZBHgKPk9L248azYFbFuxeBaq9py3vxv7uL3dnVMqpLfcf
        n4CT4pP4GrK9RaLvMrOhoHwvdcK+VFWEUIE9VymRx9U2sIs=
X-Google-Smtp-Source: ABdhPJzPa7o2fj6NNGpZ5GvCcKtg2AdEeEZp9w9BQ+emD+RGIzaWVihG1foQwEszqogEAyux25tBhT4lVZ4hPn8GjD4=
X-Received: by 2002:a05:6000:2ce:: with SMTP id o14mr31773wry.145.1623858289901;
 Wed, 16 Jun 2021 08:44:49 -0700 (PDT)
MIME-Version: 1.0
From:   Harrison McCullough <mccullough.harrison@gmail.com>
Date:   Wed, 16 Jun 2021 09:44:38 -0600
Message-ID: <CAHLeu+y3DxLv7M4SM2f5yVxtKXbpAWD7Ad2m+rVKpKfKiA6PVw@mail.gmail.com>
Subject: Error in bash completion
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

1. Create a Bash function, e.g. `ga() { git add "${@:-.}"; }`
2. Use the `__git_complete` function to add Bash tab completion for your custom
   Bash function, e.g. `__git_complete ga git_add`
3. Attempt to tab complete a file path, e.g. `ga my-incomplete-file-path<TAB>`


What did you expect to happen? (Expected behavior)

Bash tab-completes the file path.


What happened instead? (Actual behavior)

Bash tab-completes the file path but also displays an error:

$ ga fi-bash: [: -lt: unary operator expected
le3.txt

(This is when I was using tab completion to add a file called `file3.txt`).


What's different between what you expected and what actually happened?

I do not expect using tab completion to display an error.


Anything else you want to add:

I have tested this with a minial setup with Bash version 5.1.8(1)-release with
no other files sourced at startup except
/usr/local/Cellar/git/2.32.0/etc/bash_completion.d/git-completion.bash

[System Info]
git version:
git version 2.32.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.5.0 Darwin Kernel Version 20.5.0: Sat May  8 05:10:33
PDT 2021; root:xnu-7195.121.3~9/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.5 (clang-1205.0.22.9)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/bash


[Enabled Hooks]

-Harrison McCullough
