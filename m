Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 059871F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 22:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932323AbcI1WBc (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 18:01:32 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35691 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754386AbcI1WBb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 18:01:31 -0400
Received: by mail-it0-f49.google.com with SMTP id r192so139657665ita.0
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=59rDVhnAGLYiETqW/QcEujFfaAd6FpQ/sBdSIF0rx3U=;
        b=QXCb+oujymsOPZPb7LUrvOjgMyxzjA7VBes9Z61Wa2C8vnvIJOc6+199vKy07Uf87J
         2xIQLw5TtlC6k/2u6lEzrIV8B98wUWmVaao60sK5JbhmH9TO6QTITrHkwmNuk9HsWrAI
         G5iUlow3M/q7T/Zeh2xnCLsY5JxzjNZeLq1xy+HrV8zvSITQxLCyho1oGWY6hTZC47sc
         nywSKdTaCklKWFXYTELx/TGTUEIiPELz51Gr8QwW6UruTxxsuZ46+Se6L8gwp+gNAdMA
         IGT8OMLpZtYpcN2GKC5EBTrUOF9MPHAqnFDGCqDL1tvrA9FnxQmNEAWlKL6vqjCvgngm
         GBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=59rDVhnAGLYiETqW/QcEujFfaAd6FpQ/sBdSIF0rx3U=;
        b=OMadNDuFZxKoQmo+1B0fmpIaJ8AMdBaKwqsy3pHJ80i1N7jS2c9yclbVa/PTgKw2xy
         xHFel9D8ddX1ED1EsHZK9Z5KK7xjkEhi6HpXJTL+UcSKOW03nWegy3xn0LpSeI/JU/Wu
         McCShmgDQ88+hEB0SRtYlM2c0tB/WOyzGTuxpLpJaUGbXGjMTEOaU+XHzlZ9aws4dQZT
         Kd17XBK5ESS22055lex8p3CCvQjWJp9VxAMGKpWC7dZaG5gPRrMQ8L4UN0DGjV+Qnp1Q
         BRQgIpu7L6XG+7WFIH9chKZBBVtiEsGfV27fhTO9QvcFAzZvQrk1t27ZrPX4KpdntgZO
         ZrkA==
X-Gm-Message-State: AA6/9RmrPxbYUNEGDre6wQSizRSRxHPGXUWw4gZu01e46HvOXmqRS3uT2chLwFKHCA/kPiFgaKasW+asrDIAksZ0
X-Received: by 10.36.105.210 with SMTP id e201mr4550634itc.21.1475100090274;
 Wed, 28 Sep 2016 15:01:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Wed, 28 Sep 2016 15:01:29 -0700 (PDT)
In-Reply-To: <1475099443-145608-2-git-send-email-bmwill@google.com>
References: <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1475099443-145608-1-git-send-email-bmwill@google.com> <1475099443-145608-2-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Sep 2016 15:01:29 -0700
Message-ID: <CAGZ79kZRg34pG2+NUU4qz=Jxxe=6+fdPD+szGv-QTC4vs4DuMg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] git: make super-prefix option
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2016 at 2:50 PM, Brandon Williams <bmwill@google.com> wrote:

>
>  DESCRIPTION
> @@ -601,6 +602,11 @@ foo.bar= ...`) sets `foo.bar` to the empty string.
>         details.  Equivalent to setting the `GIT_NAMESPACE` environment
>         variable.
>
> +--super-prefix=<path>::
> +       Set a prefix which gives a path from above a repository down to its
> +       root.  One use is to give submodules context about the superproject that
> +       invoked it.  Currently for internal use only.

I would put the "Currently for internal use only." at the beginning, so end
users don't have to bother reading though the description, when they want to
only use kosher flags. (Well, checking `man git fetch` and searching
for 'internal',
there doesn't seem to be a consistent way how to document internal flags :(.
It doesn't however advertise the flag in the SYNOPSIS. Ok it doesn't advertise
a lot of flags in its SYNOPSIS)

> +const char *get_super_prefix()
> +{
> +       if (!super_prefix)
> +               super_prefix = getenv(GIT_SUPER_PREFIX_ENVIRONMENT);

The getenv() function returns a pointer to the value in the
environment, or NULL if there is no match.

So in case this is not set (when e.g. the user did not specify the
super prefix),
we would probe it a couple of times.

The caching effect only occurs when the string is set. So this looks
like we save repetitive
calls, but we do not always do that.
