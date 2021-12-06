Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAD8C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhLFRHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242347AbhLFQ4E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:56:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA213C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 08:52:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y13so45498068edd.13
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 08:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ezy5oQMB3jP1YdzmT64hEFZiJKckzdiHvxBcuLqFr7U=;
        b=ajnNWsOobHZgbeotbcbvXlLBR4m+foL35zPOgFq26bnsopWDqXXGYwf06CpWQVFShJ
         QOcFaQ3v9plO4Lmp6JM2cE1GbWDEiA3c6f/RARRkzdZJ2Ji0HC0Xj1koqpxJUsD5OEbs
         Y3Bvc1AEIfwXtKQJvAzEizGemu5oMWDg3It0CTq+ki59Hnfgp0GclLaGo4BCBQ740C9R
         eXD1vsaB6x99LFbVaMH3RUbMx2APm5R5uMyVZbNbVYTkXkEs5JLxA7eZOKYBmugSaxqH
         MJ598HaCWd7qwduF7slzAj5qhylfH0npH3hmKVg+Df4vPF+kgS53MH2EPP8bZRRRNX6K
         tfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ezy5oQMB3jP1YdzmT64hEFZiJKckzdiHvxBcuLqFr7U=;
        b=0BW96tXxCMUxXfhYoLafchWCDcwo/27HM9iQOcCZDe5rdET2hzk6Yt7vmuoSuymeZU
         idJMPsTO6zHsVRNJ7qM5DXN3PwefGqqi4na/SrStdNxakdmx0zUu/MOphwnQLbfKc/ZK
         QDWlXHFzUCdToBUg9hAPtsPiBq3J567C7rbxnsM1gez6LjGpgiJKZWnp2WXd7Jj5g7jG
         k2XjRN1e8v3ILiUBYTZDr2U+5qgp2mp0Ov3gfBJ0bgzI4oRXHiZQXVmkC2DU/mtPnj1B
         tt0eXRi5WONyg++NQf4T/nHZZcdMoF8wbAXa2xd3RcwPNIG5hKM9QUITps7+qXcdHXiE
         1WGA==
X-Gm-Message-State: AOAM532l309kiU4V1jwUQqyHpXzyTzEK5RzfnrjutpxtV2AGGx5mMioz
        gvKzjtLLw532nbowxCpoZ/shOf4N8pCh73lVkV/mW9Is1quOeg==
X-Google-Smtp-Source: ABdhPJzAlmrT92xvM9uFdEHcXNwLjsL9DTWbdv+8AX20YwxfWG50bmvgauu9U8VUHx3CbrW69xfPHi9SAbq7zqVq6aA=
X-Received: by 2002:a17:907:728c:: with SMTP id dt12mr45055484ejc.375.1638809553950;
 Mon, 06 Dec 2021 08:52:33 -0800 (PST)
MIME-Version: 1.0
From:   Will Beason <willbeason@google.com>
Date:   Mon, 6 Dec 2021 10:52:20 -0600
Message-ID: <CAO6o7kKXZg37ydC145yf5uZt+tsKdYADnVfinO0sHAN=cHo-FA@mail.gmail.com>
Subject: =?UTF-8?Q?Checkout_previous_branch_command_not_working_on_=E2=80=8B2?=
        =?UTF-8?Q?=2E34=2E1=2E400?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I typed "git checkout -"

What did you expect to happen? (Expected behavior)

I expected the previous branch to be checked out

What happened instead? (Actual behavior)

error: pathspec '-' did not match any file(s) known to git

What's different between what you expected and what actually happened?

I expected the previously-working behavior of switching to previous branch to
work, but it didn't.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1.400.ga245620fadb-goog
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.46-5rodete1-amd64 #1 SMP Debian 5.10.46-5rodete1
(2021-09-28) x86_64
compiler info: gnuc: 10.3
libc info: glibc: 2.32
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
commit-msg
post-checkout
post-commit
post-merge
pre-commit
pre-push
prepare-commit-msg


- Will Beason
