Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11FDD1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 20:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfAXUf3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 15:35:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51307 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAXUf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 15:35:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so4625045wmj.1
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 12:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rFoLhzwub348SLREVKQamQlQ/eWZfq0WScmWjbHlxYQ=;
        b=sXaIPAqWtIvkbPhGVkWfv9/wECZuT+B5ZpBHXYVhhoV0a86WhigoMJTzIxEpJRWdQQ
         UEh9im8CdqyKcA6FbAiU3bwqJE+270Sz4rpB5vKf67JPtMniElwgUn6l2okTgN1Z3UVP
         uaW174hRjqAtA7+bWICGqdJc+dDt99DZg3tmTW3A+OAsqmhH9GKuz0DDhnVPWVfHIcJy
         GhYNeYctZJjou+VQ+gHB38GEmMLGtgNlLpXkZWwL5BzUXkHzHhlCQNqfdOHbAWMwNCBE
         4SytutHKurN13IiTrwxNKHv8fVM73PgQBYB63sgpWU/AjAqM00JOwUNylPdQ0gEYCkND
         OV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rFoLhzwub348SLREVKQamQlQ/eWZfq0WScmWjbHlxYQ=;
        b=EJlFL9K3eWHUF+J7KwHGJy2rKU+4ZEwgJe6IDvFgb/O9jynQEvb1KSt4fVPYLFPRSh
         PCueVBVUKnWhna7W2h1TuxA3bRoc5Q8RJOYI70sp/V9A6OqfbYjOmOu0IETKHKdIN35p
         zu4ie3t6kIJPX7mFyG9gtV2EoKe7BFO/62e8JlQpVLLcGX9Ouas9lSSDKjErNEe5yNVg
         xey5fMb0z+mvqyVvznJoxIvK9FDfWl+7g5sHY1qpkvi9n2FiAoRQV2yuR6jrkYpwaRXg
         6cwgSy/xp7ABG3zp6futVwLVafftgMPO+NAGGMle6Rm0zmFgYToLSHNXFbO7ztnje/Y9
         KkCg==
X-Gm-Message-State: AJcUukfMHNdQSl8Vt7RwnQDTiVPk6awvtfFpmgKGuQRXbZviJC5NYKFa
        iebTfiP9GZhbel8GCeKFxEw5zqgI
X-Google-Smtp-Source: ALg8bN5UQ63Q7LVpw9N5iBzRw7JOrUh5Ifug+o03SfHEgNcXN2bZxfLh1q5rLuOlFBpJ5QI1X3mGFQ==
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr3833665wmc.133.1548362126740;
        Thu, 24 Jan 2019 12:35:26 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l14sm203875785wrp.55.2019.01.24.12.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 12:35:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/9] drop some unused parameters
References: <20190124131104.GA24017@sigill.intra.peff.net>
Date:   Thu, 24 Jan 2019 12:35:25 -0800
In-Reply-To: <20190124131104.GA24017@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 24 Jan 2019 08:11:05 -0500")
Message-ID: <xmqqtvhxhjzm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The patches themselves are pretty much independent from each other. I
> based these on master. They're cleanup which _could_ go to maint, and I
> suspect they'd apply there, too (most of these are pretty old), but
> again, I don't think there's a particular urgency to this.

Thanks for being considerate.  One potential benefit that we might
gain by applying these clean-ups also to 'maint' is that it would
allow us to keep 'master' and 'maint' more in sync, so it would make
it more likely for unrelated bugfixes we may have in the future in
the vicinity to also apply cleanly to both.  By definition, the
variables removed are not used, so it would make an interesting
situation if such a future bugfix needs to look at them (sort of
turning the changes in this series into category 1 "we should have
been looking at them, but we didn't"), but at that point, we'd be
resurrecting these variables we drop here, so it won't be really
hurting us.  And if such a bugfix does not need to look at them,
then textual context that might be caused by not applying these to
'maint' but keeping them only to 'master' would not be a big deal,
either.

So I can go either way, but I am tempted to leave them outside
'maint' --- at least that is my current thinking.

Thanks.

>
>   [1/8]: match-trees: drop unused path parameter from score functions
>   [2/8]: apply: drop unused "def" parameter from find_name_gnu()
>   [3/8]: create_bundle(): drop unused "header" parameter
>   [4/8]: column: drop unused "opts" parameter in item_length()
>   [5/8]: show_date_relative(): drop unused "tz" parameter
>   [6/8]: config: drop unused parameter from maybe_remove_section()
>   [7/8]: convert: drop len parameter from conversion checks
>   [8/8]: convert: drop path parameter from actual conversion functions
>
>  apply.c              |  5 ++---
>  builtin/bundle.c     |  3 +--
>  bundle.c             |  4 ++--
>  bundle.h             |  4 ++--
>  cache.h              |  2 +-
>  column.c             |  4 ++--
>  config.c             |  3 +--
>  convert.c            | 28 ++++++++++++++--------------
>  date.c               |  8 ++++----
>  match-trees.c        | 16 +++++++---------
>  t/helper/test-date.c |  2 +-
>  11 files changed, 37 insertions(+), 42 deletions(-)
