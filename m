Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF727C4332F
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 09:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiJCJel (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiJCJeA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 05:34:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D33557563
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 02:28:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id 13so20837152ejn.3
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=gpaGtV+RXVYuNDvjea1PDTtMiG4irUZ+y+MPu34PChw=;
        b=jFH5tJCrSDD59mCoeSjxBWFiD8RTJq4nb9eo8irNetMt/vkqVrMf7sRA5zRpbGzl9p
         T22gTSMLfvr1bKSJwqG9YwP6z7Pw9xf+l34p1jbsoPNPJwF3rl4cvir6iCCGztXr6xcT
         Or0sA3QUYnFMTcP1WXOcHLyuUARlTD+vy73Rq8KMmeYh9H0m4lGHcbJSLPdUfWGt5+oc
         1G5LzXqefUAg3bzDM64tYXhzEhiDPYKU8bVS0IfjUDtY4YRtvwt+szb1qBZCElEhE59O
         pwcf12Ng5tC7I1KKjTL6oKazRUj2tAwqJCCowdLEHtcbh2O17BRSQqjc3ckMUu8f3ZTR
         LXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gpaGtV+RXVYuNDvjea1PDTtMiG4irUZ+y+MPu34PChw=;
        b=mOSmz5vsfonQCNuEJ2k1ybbDSoQEHRVXMUHQWGHGS3dTTDETdnRf0vwUGOEVZ2VvAV
         agtCTfVxjzskpjq7sjzOrbtjLN+B2tOnDLix+mQWnq4MSY/8fdOmG4QRW9dzjEkWjHth
         7DXovRYXfYyrydYwxUgKKxmXPmKVnQGwZDaI+G5lWXWCtkX2Z+78YtmkeMu4tTsyZ+8H
         yR802seAVdkDeQC/K8aqJWTBaYZA1WFMwLc1P7D0Y3FHew36Kl52trEOr0RezABltvpb
         BbS6XMsncBq3fNiH002elkHGA1hRNLCn5i0Gg+xc8HWkKEDprccVLRc18nD4WP8i+QUU
         7eKg==
X-Gm-Message-State: ACrzQf1DGbth5vzxZEd+bYqhfNotrwfyaPb9r3uB3qoA0ld/bEXfk6HA
        opWi1TN7p6OtoBOoh8NE99xoxYVRuis=
X-Google-Smtp-Source: AMsMyM7eJIf8C9q8HgSjcRiPbyChCY0OhxPc5L1wP4PYuX0oEq75GtvaMbR15hajXtxPvxeT+k5nJA==
X-Received: by 2002:a17:906:dac3:b0:780:a242:2f14 with SMTP id xi3-20020a170906dac300b00780a2422f14mr14125751ejb.668.1664789277658;
        Mon, 03 Oct 2022 02:27:57 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w17-20020aa7d291000000b004580b26e32esm1007606edq.81.2022.10.03.02.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 02:27:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ofHjv-0021FR-31;
        Mon, 03 Oct 2022 11:27:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-reflog.txt: add an EXAMPLES section
Date:   Mon, 03 Oct 2022 11:20:05 +0200
References: <20221003084654.183966-1-gitter.spiros@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221003084654.183966-1-gitter.spiros@gmail.com>
Message-ID: <221003.86o7uttfxg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 03 2022, Elia Pinto wrote:

> This commit adds an "EXAMPLES" section to the git reflog man page.
> This new section currently provides examples of using git reflog
> with branches, for which doubts often exist. In this commit we also
> add a "SEE ALSO" section which refers to further information
> on git commands or documentation referenced in the git reflog man page.

I think it can be valuable to have an EXAMPLES section, but:

> +EXAMPLES
> +--------
> +
> +`git reflog`::
> +	Lists entries of reflog of HEAD, starting at `HEAD@{0}`.
> +
> +`git reflog HEAD`::
> +	The same.
> +
> +`git reflog show HEAD`::
> +	The same.
> +
> +`git reflog HEAD@{4}`::
> +	The same, starting at the 4th prior value of HEAD.
> +
> +`git reflog master`::
> +	Lists entries of reflog of `master`.
> +
> +`git reflog master@{0}`::
> +	The same.
> +
> +`git reflog master@{now}`::
> +	The same, show with timestamp.
> +
> +`git reflog master@{4.minutes}`::
> +	The same, starting at master, 4 minutes ago.
> +
> +For the branch that is currently checked out, you can omit the name
> +when you use any of the @{..} notation, so
> +
> +`git reflog @{0}`
> +
> +`git reflog @{now}`
> +
> +are often the easiest ways to view what you did on the current
> +branch

Most of this really just seems to be duplicating "SPECIFYING REVISIONS",
and some of it such as "show with timestamp" is ambiguous/misleading. If
I didn't know how it worked I'd think that it might affect the output
itself (maybe showing times "relative to now"), but it's just
gitrevisions syntax.

> +SEE ALSO
> +--------
> +linkgit:gitrevisions[7],
> +linkgit:git-log[1]

Likewise "SEE ALSO" sections can be really valuable, but they're really
for "now that you've read the above, maybe this is also useful". It's
not a "SEE STUFF YOU SAW BEFORE" :)

In this case we link to these in the first and third paragraphs of the
DESCRIPTION section (respectively), since explaining the revision syntax
etc. is really core to understanding how this command works.

The "SEE ALSO" section is really more for stuff like (in this case)
'git-fsck', 'git-filter-branch', 'git-rev-list' or 'git-stash'. All of
those commansd have some direct interaction with the 'reflog', but are
not mentioned in the main prose.





