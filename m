Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29534209FD
	for <e@80x24.org>; Thu, 25 May 2017 21:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939284AbdEYVFf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 17:05:35 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:34252 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933798AbdEYVFd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 17:05:33 -0400
Received: by mail-it0-f48.google.com with SMTP id a10so636149itg.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 14:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2Y8evJ1+TrrGZGCSgglIm+9YTGRqXhV08PBTOReuQGQ=;
        b=Pq9bWS/z7yde3nL0Xo7CejZltW/h5ihttW/g6j9tvBTcD4Mvd1jQuALD8yt2NMQeMe
         9Ji2GGEUNLuJC9eWKmaghTVtQr1jgTz75LlBdKZL/+hB3+QMCGTbql2dcMCofqXh1BFk
         j/+NjL6Xb+ISxrdgswfTwYRFoJHib075/eXK9fvJIWQ2xgRYea1Gw/9iBolYn9ySeSmg
         8fK1VkKfN9+IcT5PeHjw4U568okKOYP8fpgEwpwFc7QUlk9ICtgwIF9iytRYI6wTGznj
         qiPkGjv0tm/ANsvvy3kSdO2ZGA44COpDxCH2VC1QAw6Z2BRE/F3I5BwMSITP/AxHnoS7
         395A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2Y8evJ1+TrrGZGCSgglIm+9YTGRqXhV08PBTOReuQGQ=;
        b=Sk3cIn2ryNj3Bnl5Ab8KmDeoDaEjmL32KhCTjiXq3e2RlUoc2COEOxgROdPdBIA8XV
         h/mYv+3ICNsTfKwqcC14S8nCcxx45cvpDBmHPW1uQmX233hbCLwcHCJIgv+gvQgN8xiO
         B59mRanGJY8yNWHgxxfBQqk8i+xPz7xHU+7E/lKoRkIdUo9dIefxOsazHKjxOdRhHXvI
         igOcVfKWrYZy9H4gMWzfZZTHqy7Ugoe6IIeCfcX0MrVFWz6rrUhaCk1AygNz2EIZMUSA
         Z0XxOYjKW1WH1DqvTSQOF4F1vcM3IuCubg/Na0MAzTXSa+6rISCdvxQoT0TprE7+UKnr
         va+w==
X-Gm-Message-State: AODbwcAeHhYnWX88eb4ao8heVAynwOI7ps2wVgClcMOqX2Lf3ipgFYX0
        wGKRhs9Tb3Cv1TgVYgOSyklDsnG5Uw==
X-Received: by 10.36.53.79 with SMTP id k76mr15460297ita.71.1495746332661;
 Thu, 25 May 2017 14:05:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 25 May 2017 14:05:11 -0700 (PDT)
In-Reply-To: <20170518201333.13088-7-benpeart@microsoft.com>
References: <20170518201333.13088-1-benpeart@microsoft.com> <20170518201333.13088-7-benpeart@microsoft.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 25 May 2017 23:05:11 +0200
Message-ID: <CACBZZX7AA5sbdqhY+W2v3HRSudkWv4cHM+EQUr-X34FGvLH2hw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] fsmonitor: add a sample query-fsmonitor hook
 script for Watchman
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, benpeart@microsoft.com,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David.Turner@twosigma.com, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 10:13 PM, Ben Peart <peartben@gmail.com> wrote:
> This hook script integrates the new fsmonitor capabilities of git with
> the cross platform Watchman file watching service. To use the script:
>
> Download and install Watchman from https://facebook.github.io/watchman/
> and instruct Watchman to watch your working directory for changes
> ('watchman watch-project /usr/src/git').
>
> Rename the sample integration hook from query-fsmonitor.sample to
> query-fsmonitor.
>
> Configure git to use the extension ('git config core.fsmonitor true')
> and optionally turn on the untracked cache for optimal performance
> ('git config core.untrackedcache true').
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  templates/hooks--query-fsmonitor.sample | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 templates/hooks--query-fsmonitor.sample
>
> diff --git a/templates/hooks--query-fsmonitor.sample b/templates/hooks--query-fsmonitor.sample
> new file mode 100644
> index 0000000000..4bd22f21d8
> --- /dev/null
> +++ b/templates/hooks--query-fsmonitor.sample
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +#
> +# An example hook script to integrate Watchman
> +# (https://facebook.github.io/watchman/) with git to provide fast
> +# git status.
> +#
> +# The hook is passed a time_t formatted as a string and outputs to
> +# stdout all files that have been modified since the given time.
> +# Paths must be relative to the root of the working tree and
> +# separated by a single NUL.
> +#
> +# To enable this hook, rename this file to "query-fsmonitor"
> +
> +# Convert unix style paths to escaped Windows style paths
> +case "$(uname -s)" in
> +MINGW*|MSYS_NT*)
> +  GIT_WORK_TREE="$(cygpath -aw "$PWD" | sed 's,\\,\\\\,g')"
> +  ;;
> +*)
> +  GIT_WORK_TREE="$PWD"
> +  ;;
> +esac
> +
> +# Query Watchman for all the changes since the requested time
> +echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $1, \"fields\":[\"name\"]}]" | \
> +watchman -j | \
> +perl -e 'use JSON::PP; my $o = JSON::PP->new->utf8->decode(join("", <>)); die "Watchman: $o->{'error'}.\nFalling back to scanning...\n" if defined($o->{"error"}); print(join("\0", @{$o->{"files"}}));'

I couldn't get watchman to work for me (built from source, keep
getting [1]), but I hacked up something you can hopefully test &
squash on top of this:

 # Query Watchman for all the changes since the requested time
-echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $time_t,
\"fields\":[\"name\"]}]" | \
-watchman -j | \
-perl -e 'use JSON::PP; my $o = JSON::PP->new->utf8->decode(join("",
<>)); die "Watchman: $o->{'error'}.\nFalling back to scanning...\n" if
defined($o-
+echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $time_t,
\"fields\":[\"name\"]}]" |
+       watchman -j |
+       perl -0666 -e '
+               use strict;
+               use warnings;
+
+               my $stdin = <>;
+               die "Watchman: The watchman command returned no
output, error above?\n" if $stdin eq "";
+               die "Watchman: Invalid input: $stdin\n" unless $stdin =~ /^\{/;
+
+               my $json_pkg;
+               eval {
+                       require JSON::XS;
+                       $json_pkg = "JSON::XS";
+                       1;
+               } or do {
+                       require JSON::PP;
+                       $json_pkg = "JSON::PP";
+               };
+
+               my $o = $json_pkg->new->utf8->decode($stdin);
+               die "Watchman: $o->{error}.\nFalling back to scanning...\n"
+                       if $o->{error};
+
+               local $, = "\0";
+               print @{$o->{files}};
+       '

Rationale:

 * We use the much faster JSON::XS if it's installed.
 * We use strict/warnings
 * Micro optimization: Replace joining stdin with an equivalent -0666
   invocation. See "perldoc perlrun".
 * Micro optimization: No need to join up the possibly large list of
   files into one big string, just set $, to \0 and stream out the
   array.
 * Error handling: My watchman is broken (so actually this isn't
   tested), it only spews to stderr and exits. Handle that by checking
   whether stdin is "".

Those changes are available at
https://github.com/avar/git/commits/avar/fsmonitor



1. watchman: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version
`CXXABI_1.3.11' not found (required by watchman)
