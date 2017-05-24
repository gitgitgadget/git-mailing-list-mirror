Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154A120285
	for <e@80x24.org>; Wed, 24 May 2017 13:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030802AbdEXNM5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 09:12:57 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36773 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030200AbdEXNMz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 09:12:55 -0400
Received: by mail-qk0-f176.google.com with SMTP id u75so152727751qka.3
        for <git@vger.kernel.org>; Wed, 24 May 2017 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8/jTSjgKuM+3IeOZhMJfm8ZqDUuuR4DIRKWwAoKKGBs=;
        b=TjsdgbnwQiuJvu6W4kvVsdc7DsQBAwfd0aMT5cFQ6vYbabmltwlk5eVbrZu/A0gCw6
         hT9m/HYmkb/XSCpDdXhwzhafeJHIq/phcUkp5Il1VOGqmab3NmYzS2jN5wV5Vd/5XN4z
         1Zknb6v7kCrH4v54fXnkfZ7FaRCdXRe8/sHTIHl8hX1uSIzqpYJ0s7yTQA/GuzDHPCKP
         rVqI/Dlys5pGgcya/DHPS0vlEMQpy1l6S56oTj4QYcqjOJbHA6xS6zjvHM5hGdjp/mzN
         ySaTAhkK3+tqmbWeaAYbzvRMVVk7Jp3LGPbnEheNiz48uE50ptthoAgvAA+vq8JM1H3f
         /Ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8/jTSjgKuM+3IeOZhMJfm8ZqDUuuR4DIRKWwAoKKGBs=;
        b=HkEv2NUPMsbz0DWxG5AUq2qjxZ8j+iezPGjk+r/eGByVra+U77wiYwblKiuUL2aJjn
         E/0leKSA+TeFFae/kdsGw81QngCghqmXorT/TadbRdGq8sOdi/pfxYyWTv+k/OmjHXvi
         1aNvZyu/YNIKGqTKVy6Uq5v9h6sz+2HCkRqXXJO46rBZEIo+/ulaRtfRvmSMeehkJJYL
         tq1I+Aw7vsmQFaJiJg7iffYsub8EXaee1C9I4my2w6EAHpFbNaVWJNYUO08vUaDcgxWs
         LE3Gl2ZkDFaILCqMPqXoGSEOEYBAh56xRb2H9IKfD0aomsbN6EwKPc0TahnwJNsPaQ+O
         ayEQ==
X-Gm-Message-State: AODbwcDwTBcdqEGcNYbD2UawLvQKoZMr30qRwCUzuQ+10yb5yohrYRna
        EcjbGPIefu7I92cMSRNzRuZYCLUZqQ==
X-Received: by 10.55.140.65 with SMTP id o62mr30404762qkd.127.1495631574686;
 Wed, 24 May 2017 06:12:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Wed, 24 May 2017 06:12:54 -0700 (PDT)
In-Reply-To: <20170518201333.13088-7-benpeart@microsoft.com>
References: <20170518201333.13088-1-benpeart@microsoft.com> <20170518201333.13088-7-benpeart@microsoft.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 24 May 2017 15:12:54 +0200
Message-ID: <CAP8UFD340yndvkT8=F9zdzX9QtbuPspn8rfiK8q7f8c=kGeWQg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] fsmonitor: add a sample query-fsmonitor hook
 script for Watchman
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
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

Ok, it looks like the untracked cache can be used, but it could work without it.

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

Maybe put the above small perl script on multiple lines for improved
readability.

Is JSON::PP always available in Perl >= 5.8?
What happens if watchman is not installed or not in the PATH?
It seems to me that the git process will not die, and will just work
as if the hook does not exist, except that it will call the hook which
will probably output error messages.
