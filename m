Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A2481F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 22:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754643AbcI1WL0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 18:11:26 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38629 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753890AbcI1WLY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 18:11:24 -0400
Received: by mail-it0-f53.google.com with SMTP id n143so49296830ita.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 15:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LEva8SJWjZzH+l8rPB7vgn6IwsTvR6uroYFAfIJhiro=;
        b=dBoYSFtOD1NqLRABd/elFQLOCd3YRdoeGMLLN8Kji7rWLiWC7iJnrXwzMS6Wo+x5ht
         YFrOuBvnuBLCHxAlHE7oXxPFfBgGi3utGZBHcFW3WrX8EvCVI6kRNHTcq0Ty7McpnG4R
         OcNRjF0XSGT46zBbnZlm3ArEz9YjZVXEOuyGB6nQGzT9X7r65nS7sSlmT7SZWMMaXcun
         c/2eFPir/5d2a8gUEB9igeyKy+kBm5Y+bKvPgB45lYOZRNYXolQKv5HPmJYKIbIcPvza
         3mB4+VStyxtSmYBBNllHQzxWGjKEJNzulLp24iBbw3n7KIZ4FA5FF4b2NkPEk7KfRx4e
         XdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LEva8SJWjZzH+l8rPB7vgn6IwsTvR6uroYFAfIJhiro=;
        b=ebJmdGOqNZlT7kHk1EFd2LQMct08R4+obUUvD2b0i1BmyV1kRr6CWWg7p0/9VQzBmt
         71Jre3bu5bzObbm0WMcVJw9dpzWUJj6BeUZvK/BCFou0BByDMOU/SjIUuRnrAkmI4CmY
         1KH6b5mUn4v9jk/w5itn/Nd03DKkZlaL0yJrAVHYmfLebnNcy+gxj2YL88Qno9++gKzJ
         tPweYXnyiR3RKVBHe2wRNClPx99627fOo5gbxWna8tFADHZLDD3mdLD6lYmGRLOnnDe4
         PXheRnBClfLMI8FjHGqsRtSeeEjl9ZIDXkYkbCqzb5sEUBaN7UxUiF6aEVNI6unxX6tB
         MoBw==
X-Gm-Message-State: AA6/9RmwttaFFXSz/f5GmzOF29qs2jXOJkScJM/ShDtiQHKaCERLs/ZC7dtFQYlLYmlhwCf0i6N7XhdKPZd6LBM8
X-Received: by 10.36.50.149 with SMTP id j143mr4547884ita.91.1475100683632;
 Wed, 28 Sep 2016 15:11:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Wed, 28 Sep 2016 15:11:23 -0700 (PDT)
In-Reply-To: <1475099443-145608-3-git-send-email-bmwill@google.com>
References: <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1475099443-145608-1-git-send-email-bmwill@google.com> <1475099443-145608-3-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Sep 2016 15:11:23 -0700
Message-ID: <CAGZ79kZy5LrXeq_w1oNzXnMsQdBaWqbqR0Dh6FHL39vmg7gZQQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] ls-files: optionally recurse into submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2016 at 2:50 PM, Brandon Williams <bmwill@google.com> wrote:
> Allow ls-files to recognize submodules in order to retrieve a list of
> files from a repository's submodules.  This is done by forking off a
> process to recursively call ls-files on all submodules. Use top-level
> --super-prefix option to pass a path to the submodule which it can
> use to prepend to output or pathspec matching logic.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/git-ls-files.txt         |   7 +-
>  builtin/ls-files.c                     | 139 ++++++++++++++++++++++++---------
>  git.c                                  |   2 +-
>  t/t3007-ls-files-recurse-submodules.sh | 100 ++++++++++++++++++++++++
>  4 files changed, 208 insertions(+), 40 deletions(-)
>  create mode 100755 t/t3007-ls-files-recurse-submodules.sh
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 0d933ac..446209e 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -18,7 +18,8 @@ SYNOPSIS
>                 [--exclude-per-directory=<file>]
>                 [--exclude-standard]
>                 [--error-unmatch] [--with-tree=<tree-ish>]
> -               [--full-name] [--abbrev] [--] [<file>...]
> +               [--full-name] [--recurse-submodules]
> +               [--abbrev] [--] [<file>...]
>
>  DESCRIPTION
>  -----------
> @@ -137,6 +138,10 @@ a space) at the start of each line:
>         option forces paths to be output relative to the project
>         top directory.
>
> +--recurse-submodules::
> +       Recursively calls ls-files on each submodule in the repository.
> +       Currently there is only support for the --cached mode.
> +
>  --abbrev[=<n>]::
>         Instead of showing the full 40-byte hexadecimal object
>         lines, show only a partial prefix.
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 00ea91a..e0e5cf5 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -14,6 +14,7 @@
>  #include "resolve-undo.h"
>  #include "string-list.h"
>  #include "pathspec.h"
> +#include "run-command.h"
>
>  static int abbrev;
>  static int show_deleted;
> @@ -28,8 +29,10 @@ static int show_valid_bit;
>  static int line_terminator = '\n';
>  static int debug_mode;
>  static int show_eol;
> +static int recurse_submodules;
>
>  static const char *prefix;
> +static const char *super_prefix;
>  static int max_prefix_len;
>  static int prefix_len;
>  static struct pathspec pathspec;
> @@ -68,6 +71,19 @@ static void write_eolinfo(const struct cache_entry *ce, const char *path)
>  static void write_name(const char *name)
>  {
>         /*
> +        * Prepend the super_prefix to name to construct the full_name to be
> +        * written.  'full_name' gets reused across output lines to minimize the
> +        * allocation churn.
> +        */

When doing these tricks with the allocation churn (i.e. we make it
hard to read and understand
for a reader, then we should do it completely, i.e. keep full_name in
the strbuf and
only do a strbuf_setlen to reset the buffer just a bit. With this
implementation we burden the
reader/user to understand how the memory is kept over multiple calls
to this function,
but we still do more work than expected). So either I'd not worry
about performance
and provide an 'obvious correct' implementation, with e.g. no static
here and we free the memory
correctly. Or you'd go the performance route, but then we'd usually
ask for numbers.
(How much faster is it; Does the trickyness trade off well to the
performance gain?)


> +       static struct strbuf full_name = STRBUF_INIT;
> +       if (super_prefix && *super_prefix) {

Why do we have to check twice here? Wouldn't just

    if (super_prefix) {
        ...

be enough?
