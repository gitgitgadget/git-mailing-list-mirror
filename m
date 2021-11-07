Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BC8C433F5
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 16:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EB860EE0
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 16:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhKGQWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 11:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhKGQWE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 11:22:04 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC8C061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 08:19:21 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g17so12836073ybe.13
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 08:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=MA7mpLG7ixCUK2NYDqm4ef7Qo20sGoCQp+9hzpiJ8bk=;
        b=WkHgvNTxYevRhKB2JBORTKmAJQL7qh7cWdl/sFLVLonBZed47+HgshYo8COu7Lf13r
         5MUbwBk0NweYwntVhH7s5FyCZ8OlF2Qtu7e9UUGDsvXPG0weS3xO8WAIPGndK4EJfRHi
         96QPw+w0gT4xXpwiIxOJAY8YiIeEDI+uaEThSTHzoCqLOd7VaptNZ1X4GfXE1ODfF7jj
         sHX1jM+9iFPHeCcgf0+nKbeYngzf/PQwKJcvj6fqrtRvFurTChaEZKmrIUw3qZzH6fCO
         6SY5Xj0SZawwZ0w5UvNld1oNLq8U7yOo3l+mFC9GTzK11doQigW4CQp84z0b5BQ2M0yK
         Sqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MA7mpLG7ixCUK2NYDqm4ef7Qo20sGoCQp+9hzpiJ8bk=;
        b=F78J2jeCDifA5yGmrWdCLWionP5bTHuCdzG493PVs0lzExxK0rThdgyR82T89bQC/F
         uPrNMZa9qvPjXR3XRQfIR63Rqlgm91EeQiNsYFFAXzuyCok7Y9kzl0Ez0P16qaqbAKkL
         NSgl/Z9bpQywyBjrlAh2Gwbo7rf625bBI+I0Ve78Z3mHeYpV3Q8EDrXSn0bKRSyXWFQl
         ZIFEjQN51fQuKP1nCOk+jfA+nJOmCQ8gtWsWWzf6nL6U/C7u6igDheb19ppVTvEAN77Q
         fBd6SDaiUkNnPhQNBVHwwFfl5DiKk5oIqiMzSFc4qrWlCYU0X+xlRxusJHTy63dO3yxD
         hgMg==
X-Gm-Message-State: AOAM532txGBzfD/ohy/siIjZt+y8wc0gicB0xHk0k0WEWKrdDXS6u076
        tSOPIOAlkjK6nMvlsvk8qiptwJ81n+L8EQanOaFQLzykCjk=
X-Google-Smtp-Source: ABdhPJyZydqgnYNTBNque1pYgnPRoISTmX/ztfjKq7A2WJY/TojD4GTLiJOw+XWT0zCepjsqZxjEPJCkNa0pSnJZgC4=
X-Received: by 2002:a25:3853:: with SMTP id f80mr16378800yba.147.1636301960505;
 Sun, 07 Nov 2021 08:19:20 -0800 (PST)
MIME-Version: 1.0
From:   php fan <php4fan@gmail.com>
Date:   Sun, 7 Nov 2021 17:19:09 +0100
Message-ID: <CAPxO=juWu9xU8UCW1B4L6vGeXHQ=ef9Q4cEAPgkGqdpyHPyAYA@mail.gmail.com>
Subject: gitk bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Oh gosh, using a mailing list for bug reports...)

I just installed gitk on OpenSUSE Tumbleweed with zypper and found this bug.

Here's the report generated with git bugreport:

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. cd into the directory of a git repository
2. Run "gitk" (this opens the repository in gitk)
3. Click on a commit

What did you expect to happen? (Expected behavior)

Should select the commit I clicked on

What happened instead? (Actual behavior)

Selects the commit just below it

What's different between what you expected and what actually happened?

See above

Anything else you want to add:

no

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.14.14-1-default #1 SMP Thu Oct 21 05:05:03 UTC 2021
(2b5383f) x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.34
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
