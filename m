Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CDFC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 09:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245483AbiBBJeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 04:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiBBJd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 04:33:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B447C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 01:33:59 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w25so39747534edt.7
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 01:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1baTQo2x5F/X6fZMaDJcdAkloBcO509bgoPDTHvfcYA=;
        b=UTYUTWgJXOG+Sx/39fdO4L4wF7RB0M3qVTYeInv2Q9brmqEcn/Hdva8/BW03Yvd/Ru
         PZchRwdlWX6oCyqbuDY019Csk0ZC9p7DWAiXcuT94yfjXH2dLUqyon3Xd5QuQp27qipR
         7vl5HbnrNCSd6ez1dJAfST5WkhI7iRFBh9PoEOeqv2RRMVvoIgCYctjvd7R2+ay7JeJI
         dOXWyrCBV9OTPF7E0kN907HKYEj7lf0ByW6AraFjQGgsJ0tFa54uKS486WAhlZAfMUA1
         49dNQk22zsmEZMzisWjM68C+xE5zb3acKisKUc3IRi+sHMlcrnl/v6H8liNYfEDisc8A
         mvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1baTQo2x5F/X6fZMaDJcdAkloBcO509bgoPDTHvfcYA=;
        b=OvhaexQ/k5Ceo6VrbSovcfpz7IfkG5tAFLY0cfm9OxJbd5qMBpZI1r2eUtmXAa4AiG
         xdi7vVJ4u+ad8tMiEj+SLQbWBlGF+OP839ZChPG6zPK6DSmv/lKYYyzVX5NR443orp2V
         QXxH21vJ+uNcwI1uBN62X17Lc8TiLQqBe2rZzG1MrPmMfb3RvL7ZZEaU1iJKkdhCkTxe
         iTpiFVlKVZs7TKnye30sOjM+NpfRp3BMMr8xbvW45XhdjOd7BicrJHlbwAGsdQlBx87v
         LtvVXB0io3ivnAmwRea3cjXjXghKedlmQei9WSvf/MJ3kluE5FCK80N0u4ubZcwUQQ0K
         2Z/A==
X-Gm-Message-State: AOAM533W8BbWRe1bDZYzr0RLWEXJjM2O/4gQrksCIU5Bzl0gDUjZbQDA
        XjFLUDcMAjPfZUHq4kWjeRbb1+UbXb6bbQ==
X-Google-Smtp-Source: ABdhPJx4icP5blJVpsX5oOPXTwpEmb0iQ8Q8Uq4dfnm/YCryIXNu5lEWRQlXqBnywpfFFH6DhvIFRg==
X-Received: by 2002:aa7:cb17:: with SMTP id s23mr29081555edt.282.1643794437523;
        Wed, 02 Feb 2022 01:33:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z19sm6151935eja.18.2022.02.02.01.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 01:33:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFC1U-004R7Q-EK;
        Wed, 02 Feb 2022 10:33:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     lgl via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, liginity <liginity@outlook.com>
Subject: Re: [PATCH] fix typo in git-mktree.txt
Date:   Wed, 02 Feb 2022 10:33:38 +0100
References: <pull.1207.git.git.1643792450866.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1207.git.git.1643792450866.gitgitgadget@gmail.com>
Message-ID: <220202.86sft18vej.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 02 2022, lgl via GitGitGadget wrote:

> From: liginity <liginity@outlook.com>
>
> fix a typo: change "as" to "a".

Looks good, for what it's worth that typo was introduced in f1cf2d8b146
(mktree --batch: build more than one tree object, 2009-05-14)! So a very
old one.
