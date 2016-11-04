Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0534E2022D
	for <e@80x24.org>; Fri,  4 Nov 2016 22:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756888AbcKDWin (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 18:38:43 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35874 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754396AbcKDWim (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 18:38:42 -0400
Received: by mail-qt0-f182.google.com with SMTP id w33so57051999qtc.3
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 15:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/PjkDe3qqHLOf2QCanaZXWQOkDKsl6t4cXdtGMgoclQ=;
        b=THP5aZwuV//49pLNqVwivobSGFqShzJAoMV/ecTgjeA8DTfRmd5iOzSBGSljAVoHZ5
         ndwFCwjouukf5nHCtMCB0/g3AZEsTldPl0KJPDSyVdn4ABRyZ9tqoNShvjFXjqITokG1
         NrPhg4LT5cP69LDlqTs0eEgtr8sS2dYu0rfRUWh6jeMvXNIq3l0VlrilZBSPMEBhH9+I
         Yz5vQh80iCGgH32cbWR6sKIu1wqe4SzoI3GbqnTiwEoF3PDhClNG2CnkSSWPfr58ayaA
         9x3W3wdQCt3x+IbCR7Zw+8ncfaeelOEjzSGzTXU1Lkw0l8k9m9eBd9kxDtTe0N6U/nTU
         wmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/PjkDe3qqHLOf2QCanaZXWQOkDKsl6t4cXdtGMgoclQ=;
        b=X60Z/hBkupjMjXBhm7SKmFzha7pgPT/euJChQrcTmwCDTcCukO5G9FYaJoFccFNIpf
         50BxswPqC37URqg3WIRlXlr350fUwmVnJSHEnrJVum2yao8VW+xYIsCa/mQ1PG8/TnjF
         8ipii7boFhQNdgIYYftuDnW1LLExJ1gB6n3CG6pdpfuFwhvWQunnKZZXm5tuCTmEjJe7
         C5WHXmKhJSs4DQB7fYVqxLqX/rU95+8EVmQ0T+A5vPjdyJGXqyDbgQ4cKHaSLMEatShy
         F41pMAVPv1js9yU+HOBCfdMKFWaJLfWIqvGbvMJKvq3XHIc4DqjxwYD+jSjR1kP6VOtV
         uQlw==
X-Gm-Message-State: ABUngve8Xuco1kXTUIc6/3uX+2A+LsPYFgLqqPzQpSd2XtxW1CTz9plpX46IPUl1oJDfIxdrChT8mILVazWxh0kS
X-Received: by 10.200.51.171 with SMTP id c40mr8510711qtb.131.1478299121590;
 Fri, 04 Nov 2016 15:38:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Fri, 4 Nov 2016 15:38:41 -0700 (PDT)
In-Reply-To: <1478292933-7873-1-git-send-email-bmwill@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com> <1478292933-7873-1-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 4 Nov 2016 15:38:41 -0700
Message-ID: <CAGZ79ka18s3-nzkCog3+g70NCoAawoqO1t-qghKSZJxjK6jkmw@mail.gmail.com>
Subject: Re: [PATCH v3] transport: add protocol policy config option
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Blake Burkhart <bburky@bburky.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 4, 2016 at 1:55 PM, Brandon Williams <bmwill@google.com> wrote:
> Previously the `GIT_ALLOW_PROTOCOL` environment variable was used to
> specify a whitelist of protocols to be used in clone/fetch/pull
> commands.  This patch introduces new configuration options for more
> fine-grained control for allowing/disallowing protocols.  This also has
> the added benefit of allowing easier construction of a protocol
> whitelist on systems where setting an environment variable is
> non-trivial.
>
> Now users can specify a policy to be used for each type of protocol via
> the 'protocol.<name>.allow' config option.  A default policy for all
> unknown protocols can be set with the 'protocol.allow' config option.
> If no user configured default is made git, by default, will allow
> known-safe protocols (http, https, git, ssh, file), disallow
> known-dangerous protocols (ext), and have a default poliy of `user` for
> all other protocols.
>
> The supported policies are `always`, `never`, and `user`.  The `user`
> policy can be used to configure a protocol to be usable when explicitly
> used by a user, while disallowing it for commands which run
> clone/fetch/pull commands without direct user intervention (e.g.
> recursive initialization of submodules).  Commands which can potentially
> clone/fetch/pull from untrusted repositories without user intervention
> can export `GIT_PROTOCOL_FROM_USER` with a value of '0' to prevent
> protocols configured to the `user` policy from being used.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/config.txt         |  25 ++++++++
>  Documentation/git.txt            |  19 +++---
>  git-submodule.sh                 |  12 ++--
>  t/lib-proto-disable.sh           | 132 +++++++++++++++++++++++++++++++++++----
>  t/t5509-fetch-push-namespaces.sh |   1 +
>  t/t5802-connect-helper.sh        |   1 +
>  transport.c                      |  73 +++++++++++++++++++++-
>  7 files changed, 235 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 27069ac..5d845c4 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2308,6 +2308,31 @@ pretty.<name>::
>         Note that an alias with the same name as a built-in format
>         will be silently ignored.
>
> +protocol.allow::
> +       If set, provide a user defined default policy for all protocols which
> +       don't explicitly have a policy (protocol.<name>.allow).  By default,

Use hyphens (`protocol.<name>.allow`) to highlight the config option.

By default, if unset, ... have a default policy ...
sounds strange. How about just dropping the first 4 words here:

     Known-safe protocols (http, https, git, ssh, file) have a
     default policy of `always`, known-dangerous protocols (ext) have a
     default policy of `never`, and all other protocols have a default policy
     of `user`.  Supported policies:


What happens if protocol.allow is set to true?



> +       if unset, known-safe protocols (http, https, git, ssh, file) have a
> +       default policy of `always`, known-dangerous protocols (ext) have a
> +       default policy of `never`, and all other protocols have a default policy
> +       of `user`.  Supported policies:
> ++
> +--
> +
> +* `always` - protocol is always able to be used.
> +
> +* `never` - protocol is never able to be used.
> +
> +* `user` - protocol is only able to be used when `GIT_PROTOCOL_FROM_USER` is
> +  either unset or has a value of 1.  This policy should be used when you want a
> +  protocol to be usable by the user but don't want it used by commands which
> +  execute clone/fetch/pull commands without user input, e.g. recursive
> +  submodule initialization.
> +
> +--
> +
> +protocol.<name>.allow::
> +       Set a policy to be used by protocol <name> with clone/fetch/pull commands.

How does this interact with protocol.allow?

    When protocol.allow is set, this overrides the specific protocol.
    If protocol is not set, it overrides the specific protocol as well(?)


> +
>  pull.ff::
>         By default, Git does not create an extra merge commit when merging
>         a commit that is a descendant of the current commit. Instead, the
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index ab7215e..ab25580 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1150,13 +1150,13 @@ of clones and fetches.
>         cloning a repository to make a backup).
>
>  `GIT_ALLOW_PROTOCOL`::
> -       If set, provide a colon-separated list of protocols which are
> -       allowed to be used with fetch/push/clone. This is useful to
> -       restrict recursive submodule initialization from an untrusted
> -       repository. Any protocol not mentioned will be disallowed (i.e.,
> -       this is a whitelist, not a blacklist). If the variable is not
> -       set at all, all protocols are enabled.  The protocol names
> -       currently used by git are:
> +       The new way to configure allowed protocols is done through the config

This is not the right place to mention what is newer. ;)
However it is useful to know about the config interface, which is
 * (supposedly) easier to use
 * more fine grained
 * taking less priority than this env var.

> +       test_expect_success "clone $desc (disabled)" '
> +               rm -rf tmp.git &&
> +               test_must_fail git clone --bare "$url" tmp.git
> +       '


I could not spot a test for GIT_ALLOW_PROTOCOL overriding
any protocol*allow policy. Is that also worth testing? (for
backwards compatibility of tools that make use of GIT_ALLOW_PROTOCOL
but the user already setup a policy.

>
>  void transport_check_allowed(const char *type)
> --

Thanks!
Stefan
