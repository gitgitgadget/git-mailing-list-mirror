Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627D7C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 17:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKXRGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 12:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiKXRGl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 12:06:41 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A258623A5
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 09:06:37 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id q13so1014889ild.3
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 09:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=KAN98DRcuqsOBX9rHwuU9J+IfQoz6gCjh/aN9GiBIi8=;
        b=aUAX6U9GXB6GJeDVYG4rKn52BphXN0mStm3Un47069u+moUG/9xy9JhwufxTwoBiPe
         CVqH0A0GGdWimE/3Qd3YDWNBld6q/KPDN8UgmD2zgMhCxpoeEzaUQCqYihg0kcKq5nPO
         s5Ddi+20OqN4vtPCIPCXavvwNekl0X61Y+OPBwUbxKTUaIBqliQo09VvNJtEUzCFYRWk
         s0lwwsKbmMCpg9YO5GbD81FuUoHEu9mqE8KETqa7PxO4Xj7YgdwbdIvhYicqJ1WGRZRj
         aCFhfSiWdgCkeecPU2EksjXXdwAu3SphqPosEFU+i28V6xgpcLRq/SevzOf90Cs52+jX
         bZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAN98DRcuqsOBX9rHwuU9J+IfQoz6gCjh/aN9GiBIi8=;
        b=zMySq+dBpqOrMOLt4RxjU46SK1TtghK/4vTtKryu0OjTg6hYetSibe7DA/Kkux09Id
         Sk6mhYhqqFfl0Yh9dfepDhklhOh/Qsi1NX4MegQYRjbPZb6eF8bNyieOCm36nPE8Z7mN
         ylQyXBSiuidcOrDRbroxOMmU4XilfYBhinn8ZTmQuJ9au6wTX8vM/lo+7hokaR2L1ZTg
         axswC5R8RZth7Jwe/6zxLbeB7EyMSQF2Db9FmHpLPWm8/MNHSATH+90GZ1q+vmYlfOtA
         /Kcz+d1dNQSqfKtcwfvXTSOd3s7g8dP5oHsa2wpbkjjDuHNiEuw3fRGwF7xb1GpBeJ9l
         uqsg==
X-Gm-Message-State: ANoB5pmCu7qcx4ooEYgvFScZKhD6RzR6vakEAXx1Lkx4DfiyrVbb4eh8
        +1GLSZbeMZbBSN3M9+/qChqccnm2tnE=
X-Google-Smtp-Source: AA0mqf4upAqBP6XeP3al+H4fzB0ljRrcx1y67AddcvGcveg/Yje2LR0N8kSEuNUatpoZKsuer+BwEQ==
X-Received: by 2002:a05:6e02:1d17:b0:302:9392:5a01 with SMTP id i23-20020a056e021d1700b0030293925a01mr6263819ila.268.1669309596129;
        Thu, 24 Nov 2022 09:06:36 -0800 (PST)
Received: from stargate ([2620:72:0:a40:b266:4a92:da4a:c772])
        by smtp.gmail.com with ESMTPSA id s27-20020a02b15b000000b0036ee761e2f4sm568605jah.159.2022.11.24.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:06:35 -0800 (PST)
References: <CACtGy4i7Jv+UyjwKOLsMOQwUO81=o98AA5SNwi+=xUB76ehD_g@mail.gmail.com>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Sean Allred <allred.sean@gmail.com>
To:     Vasilij Demyanov <qvasic@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git download
Date:   Thu, 24 Nov 2022 10:52:21 -0600
In-reply-to: <CACtGy4i7Jv+UyjwKOLsMOQwUO81=o98AA5SNwi+=xUB76ehD_g@mail.gmail.com>
Message-ID: <87zgcgs2ne.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Vasilij Demyanov <qvasic@gmail.com> writes:

> I have a need to get just one file from a repository, it would be
> useful to have a command something like this:
>
> git download repo_url branch_or_commit path/to/file

My immediate thought was git-archive[1], but depending the specifics of
your needs/setup, you could use curl/wget for this pretty simply. For
example, if you're using GitHub, you can

    curl https://raw.githubusercontent.com/git/git/master/README.md

to dump the content of the README to standard out. As another example,
to get the content of next:builtin/var.c,

    curl https://raw.githubusercontent.com/git/git/next/builtin/var.c

The general pattern:

    https://raw.githubusercontent.com/<repo>/<branch-or-commit>/<file-path>

GitLab's pattern is similar:

    https://gitlab.com/<repo>/-/raw/<branch-or-commit>/<file-path>

e.g.

    curl https://gitlab.com/gitlab-org/git/-/raw/main/README.md

This will be limited to getting a single file at a time. If you want
more, you can make more curl requests, but git-archive can give a whole
directory or even the entire repo at a specific commit. Since
git-archive outputs a tar/zip file, you'll want to combine it with your
favorite decompression tool to get your content.

[1]: https://git-scm.com/docs/git-archive

--
Sean Allred
