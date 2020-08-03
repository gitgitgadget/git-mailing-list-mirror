Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DA2C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 23:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5745206F8
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 23:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgHCXyh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 3 Aug 2020 19:54:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45447 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHCXyh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 19:54:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id z18so32150822wrm.12
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 16:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qbq8HYui7qhnDMXxyVFNGvrtzI3lXklbAk0fb7GM9is=;
        b=HjT/AQ3hTSGR2Ic/xilrxSVOMm+OG/G5+E1kpTwYLwz8/EpOZ7F6XcZW/poh+W2gwl
         ARE8SIeyOeXvOYLCcUC3fl9akJyneOkLlyGZsLp57K6UdxJLwaxLMrMR6eEbWqiBnP0E
         TOAbOMn0GejSjYW0A9d+8kU/10lvrm3+4mOCag+Qap0byK6od/rcSXAN8PIgotn1BBJq
         j2BeGQJHZ891rWYY5v970YMBjmQ/7AUmFE8T7bMJOR5Im6JWumrm0+qHXay8T1a8F4Ww
         eZCSuD6fNUBdKUADhsTv647T/tSsWfktfD9oNtNgT3nO/W6W12CLILgtLZIo3g/K+ngQ
         XdQg==
X-Gm-Message-State: AOAM530fNTvsVQttNmxq7v8AdGbopDTj13FGGCL8zwu7rudtzsOw8bNg
        fCnK8UFaI1voDTeWRjBjO05brqcelLAB2M2v1rQ=
X-Google-Smtp-Source: ABdhPJw7mcc5co7hzW4AB+2WBAqHC6s8iMHcKJ5IqIBSok9XhLQp5XFLgAqUqIkVZzlMPBaWk0yidMmKPOTpO3XsK08=
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr17121662wrx.277.1596498875765;
 Mon, 03 Aug 2020 16:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200803053612.50095-1-sunshine@sunshineco.com> <20200803175717.7465-1-martin.agren@gmail.com>
In-Reply-To: <20200803175717.7465-1-martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Aug 2020 19:54:24 -0400
Message-ID: <CAPig+cQtcxqQDAQ5bO6ica+Z7dd2+r8B+kXm0RK7qhpsAiX_xg@mail.gmail.com>
Subject: Re: [PATCH 0/4] git-worktree documentation cleanups
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 3, 2020 at 1:57 PM Martin Ågren <martin.agren@gmail.com> wrote:
> I offer the following suggestions on top. If you agree with them, or
> some of them, you might want to squash them into the various patches.

Thanks for the review and suggestions for additional changes. See a
few minor comments below...

> -"linked working tree" as opposed to the "main working tree" prepared by "git
> -init" or "git clone".  A repository has one main working tree (if it's not a
> +"linked working tree" as opposed to the "main working tree" prepared by linkgit:git-init[1]
> +or linkgit:git-clone[1].  A repository has one main working tree (if it's not a

Good idea, though this could just go atop this series.

> -directory specific files such as HEAD, index, etc. As a convenience,
> +directory specific files such as `HEAD`, `index`, etc. As a convenience,

I intentionally left HEAD as-is because it consistently lacks quotes
in this document, and I didn't feel strongly about it being quoted or
not. Such a change could easily go atop this series.

I did see and consider adding backticks around "index" here but
likewise didn't feel strongly about it at the time. But upon
reconsideration, as a literal filename, you're right that it ought to
be typeset specially.

> @@ -166,7 +166,7 @@ This can also be set up as the default behaviour by using the
> -       "--track" in linkgit:git-branch[1] for details.
> +       `--track` in linkgit:git-branch[1] for details.

I missed this one.

> -       With 'add', suppress feedback messages.
> +       With `add`, suppress feedback messages.

And this.

> -       With `prune`, only expire unused working trees older than <time>.
> +       With `prune`, only expire unused working trees older than `<time>`.

Ditto.

> -on "worktreeConfig" extension, e.g.:
> +on the "worktreeConfig" extension, e.g.:

In addition to the grammo you spotted, the quotes around
worktreeConfig should be backticks.

I'll think go ahead and re-roll, adding a couple new patches,
respectively, for the linkgit:'s you pointed out and typesetting
`HEAD` specially.
