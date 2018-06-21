Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E76F1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 20:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933361AbeFUUoN (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 16:44:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52864 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933274AbeFUUoM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 16:44:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id p126-v6so7128572wmb.2
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7I+Q1Xl6xFX1yGcm0ujkJF/H0+Cin9K5TS+3CEq7h2w=;
        b=saKWBAM5Ola7OSyiNugQXPDMoIr3xWM9S9Zkn5ZLzx2+h3lty4xZT7cW1rfGSPglO/
         h3yaNVKhhGsmtGFarCKqXnNHHUZhReXwKcJfab5ujkhguWuHXk66jX94zo48MfOKhdu5
         I8TAyZrJ5mJnJfjd90TDMoUMTtvw8vM5iS31ujY5ZHpA/3sq/5br28dZ1FcPzlnIV6OQ
         MyPuJOaZg7vCP4U3A+N9WF6qebtjzt0MAYZDiBYxTz/BfQbB8F1lIM4Kyei8Is8jyyFw
         QNIyaMrOrFXDocYm8vINYT9WPDIio3LA/mjxl0KyqDkvyPb7/1Jowb25w+upi88sFjoC
         pPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7I+Q1Xl6xFX1yGcm0ujkJF/H0+Cin9K5TS+3CEq7h2w=;
        b=feOf5sykVwnCp3uduVU+9c4JrLgDw/0F8PF/mCRQuc4FqV1qzcVGVTg0EcA58IMdD8
         /nwb36sjBieWr3JbmH1959G2WjwAAOhjKbd3/rugYPp0/MHdBU3zqhJR4oZHs42dusXh
         KnICsHWJn6dAwkGcXEU952B++RNqvF2BOnTnVGwcHAiH6hBmE1StvOMu/4I+IXXe6LFg
         vp9iRbDDo1AGAkSqNUzG4K9yqlJ3AWJMg/Z8v6TIHp1XMcoXc8FLcb4zSSfkB6mF1+O/
         kSFZ5dClgCINW4LmJ5cTxpVLQevVDY/mrUN/JpE5WEIzlFoXHpLH4SW+3+YZjJAEu5Jm
         O2hA==
X-Gm-Message-State: APt69E3DnH3/aLxvEbmm5AH+scjcI1VUf/dH7rQAujscD5gegDNz0WNm
        m8r0mQYGHCwveSeU+4g6cdk=
X-Google-Smtp-Source: ADUXVKKmQVzzJ1WK+StrmJt9DaDn0HLm8xWjSkkRmZa0u6ySPamRbOQ4cvihP6o0DXU1+aNwDbYnVA==
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr5959665wmh.116.1529613851232;
        Thu, 21 Jun 2018 13:44:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e13-v6sm8694227wrm.45.2018.06.21.13.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 13:44:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3 5/7] git-rebase.txt: document behavioral inconsistencies between modes
References: <20180617055856.22838-1-newren@gmail.com>
        <20180621150023.23533-1-newren@gmail.com>
        <20180621150023.23533-6-newren@gmail.com>
Date:   Thu, 21 Jun 2018 13:44:10 -0700
In-Reply-To: <20180621150023.23533-6-newren@gmail.com> (Elijah Newren's
        message of "Thu, 21 Jun 2018 08:00:21 -0700")
Message-ID: <xmqqfu1fswdh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +BEHAVIORAL INCONSISTENCIES
> +--------------------------
> +
> +  * --no-ff vs. --force-rebase

Do we want to `--quote` these?

> +    These options are actually identical, though their description
> +    leads people to believe they might not be.

Perhaps the same bandwidth can be spent on improving their
description, instead of adding this paragraph?

> + * empty commits:
> +
> +    am-based rebase will drop any "empty" commits, whether the
> +    commit started empty (had no changes relative to its parent to
> +    start with) or ended empty (all changes were already applied
> +    upstream in other commits).
> +
> +    merge-based rebase does the same.
> +
> +    interactive-based rebase will by default drop commits that
> +    started empty and halt if it hits a commit that ended up empty.

I think the description is accurate.

WRT a change that ends up being empty (as opposed to a change that
is empty from the beginning), I'd think that the current behaviour
is desireable one.  "am" based rebase is solely to transplant an
existing history and want to stop much less than "interactive" one
whose purpose is to polish a series before making it publishable,
and asking for confirmation ("this has become empty--do you want to
drop it?") is more appropriate from the workflow point of view; so
it may deserve s/inconsistencies/differences/.

> +    The --keep-empty option exists for interactive rebases to allow
> +    it to keep commits that started empty.

On the other hand, lack of --keep-empty on the "am" side is probably
a bug that wants to be fixed.

> +  * empty commit messages:
> +
> +    am-based rebase will silently apply commits with empty commit
> +    messages.
> +
> +    merge-based and interactive-based rebases will by default halt
> +    on any such commits.  The --allow-empty-message option exists to
> +    allow interactive-based rebases to apply such commits without
> +    halting.

Ditto for desirable difference coming from workflow point of view.

> +  * directory rename detection:
> +
> +    merge-based and interactive-based rebases work fine with
> +    directory rename detection.  am-based rebases sometimes do not.

I quite do not get what the big deal is with "directory rename"; it
is merely a degree of magic heuristics employed while detecting file
renames.  It is natural to expect that the less information you make
available to the machinery, the less amount of heuristics gets
exercised to make "magic" happen.  Is the internal implementation
detail described below (omitted) all that interesting to general
readers of "git rebase --help", I wonder?  I would understand it if
this were under Documentation/technical/, though.
