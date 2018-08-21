Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFF791F954
	for <e@80x24.org>; Tue, 21 Aug 2018 04:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeHUIF6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 04:05:58 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43642 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeHUIF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 04:05:58 -0400
Received: by mail-pl0-f65.google.com with SMTP id x6-v6so8179087plv.10
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 21:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KUoMR41nBgTW0NwUUY14DtYh5lP2TCtzVJPFhEBS+Cg=;
        b=Id8Swo8MAEO5sPSkJTJDwKgQj71TvIh5WmYPtA+RVj8Pu5gjuXQkhzstqAgRztKaPF
         x+/XL1h1nXH4oosivlH9+EOd+IHgshtTgixOVmfwNWJYQ9UCyVlH3INzsmCW8dWugpwM
         xRzwPHIrK1OeQODldWiMkvwMX7PUFRQZrOPM5XLFNzD+9sLxOHuBJz0c1RVZ3Dsgpb/x
         zW4O1W/DRQoV0Wn7Ai0xRGUCryMwhstJMX0TiW33Z5JiENjcZngCRjAgcO+N1nMrfsDu
         xSsOVqzuKqh5INbbqNT62yUM7fLzBPNxtWAdzmpi9pKxGa3rcqeFVvUiRAkqaXioOH8T
         zMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KUoMR41nBgTW0NwUUY14DtYh5lP2TCtzVJPFhEBS+Cg=;
        b=d1V/nzLSC9jryQgO0H27k1aJ2oFC8s0Jh0vRBaR2BRQEoIzAzfHfhA4zuihgh6SxNb
         GocJJ9m6JI/Zmjy5W/8+Jcp070Nm54mB2GFoyh1TRwiRT4w8iOVuDPjUTIupDqiBBNx5
         7e6u8L533OcV4u7pijgyY1bcEUa5nYieDuDzSFS7RuihgXkbKp/h7q6FRoA83gBsiqF6
         tSibep/P/6/Yr4//fnmko4RHsK1oOpYpmwbhJaWvLC8W3B93SC27dHHVB1friZ7Nv/sh
         bruOtrDCXCpPuvC2fbnVz3itbEzbpQ+Du65vh3JdC7KtHVRfiNHEKpUB7FTI/qLuwnIa
         csRg==
X-Gm-Message-State: AOUpUlGFMGP6cdcISCwSuloNd8uvOMljY75Z0p7M5KibFTRKs5CPP1c9
        WslvEU7PbbNK/HriIF5OcF8=
X-Google-Smtp-Source: AA+uWPx/Hkg1oIWtK92IcvJR1Zc9jEeoO1TuOMz/c8c9wvIieYG5i0NVZQg+4a/FHvDAgDOUTH+2sQ==
X-Received: by 2002:a17:902:7587:: with SMTP id j7-v6mr48246998pll.256.1534826847182;
        Mon, 20 Aug 2018 21:47:27 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s75-v6sm1021363pfd.0.2018.08.20.21.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 21:47:26 -0700 (PDT)
Date:   Mon, 20 Aug 2018 21:47:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 01/25] structured-logging: design document
Message-ID: <20180821044724.GA219616@aiede.svl.corp.google.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
 <20180713165621.52017-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180713165621.52017-2-git@jeffhostetler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler wrote:

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Documentation/technical/structured-logging.txt | 816 +++++++++++++++++++++++++
>  1 file changed, 816 insertions(+)
>  create mode 100644 Documentation/technical/structured-logging.txt

Can you add this to Documentation/Makefile as well, so that an HTML
version will appear once this is merged?  See
https://public-inbox.org/git/20180814222846.GG142615@aiede.svl.corp.google.com/
for an example.

[...]
> +++ b/Documentation/technical/structured-logging.txt
> @@ -0,0 +1,816 @@
> +Structured Logging
> +==================
> +
> +Structured Logging (SLOG) is an optional feature to allow Git to
> +generate structured log data for executed commands.  This includes
> +command line arguments, command run times, error codes and messages,
> +child process information, time spent in various critical functions,
> +and repository data-shape information.  Data is written to a target
> +log file in JSON[1,2,3] format.

I like the idea of more structured logs for tracing, monitoring, and
diagnosis (see also
https://research.google.com/archive/papers/dapper-2010-1.pdf on the
subject of tracing).  My main focus in looking over this initial
contribution is

 1. Is this something that could eventually merge with our other
    tracing APIs (e.g. trace_printf), or will they remain separate?

 2. Is the API introduced here one that will be easy to work with
    and adapt?  What will calling code that makes use of it look like?

[...]
> +Background (Git Merge 2018 Barcelona)
> +=====================================
> +
> +Performance and/or error logging was discussed during the contributor's
> +summit in Barcelona.  Here are the relevant notes from the meeting
> +minutes[6].
> +
> +> Performance misc (Ævar)
> +> -----------------------
> +> [...]
> +>  - central error reporting for git
> +>    - `git status` logging
> +>    - git config that collects data, pushes to known endpoint with `git push`
> +>    - pre_command and post_command hooks, for logs
> +>    - `gvfs diagnose` that looks at packfiles, etc
[etc]

I'm not sure what to make of this section.  Is it a historical
artifact, or should I consider it part of the design?

[...]
> +A Quick Example
> +===============
> +
> +Note: JSON pretty-printing is enabled in all of the examples shown in
> +this document.  When pretty-printing is turned off, each event is
> +written on a single line.  Pretty-printing is intended for debugging.
> +It should be turned off in production to make post-processing easier.
> +
> +    $ git config slog.pretty <bool>
> +
> +Here is a quick example showing SLOG data for "git status".  This
> +example has all optional features turned off.  It contains 2 events.

Thanks for the example!  I'd also be interested in what the tracing
code looks like, since the API is the 'deepest' change involved (the
tracing format can easily change later based on experience).

My initial reaction to the example trace is that it feels like an odd
compromise: on one hand it uses text (JSON) to be human-readable, and
on the other hand it is structured to be machine-readable.  The JSON
writer isn't using a standard JSON serialization library so parsing
difficulties seem likely, and the output is noisy enough that reading
it by hand is hard, too.  That leads me to wish for a different
format, like protobuf (where the binary form is very concise and
parseable, and the textual form is IMHO more readable than JSON).

All that said, this is just the first tracing output format and it's
easy to make new ones later.  It seems fine for that purpose.

[...]
> +Target Log File
> +===============
> +
> +SLOG writes events to a log file.  File logging works much like
> +GIT_TRACE where events are appended to a file on disk.

Does it write with O_APPEND?  Does it do anything to guard against
interleaved events --- e.g. are messages buffered and then written
with a single write() call?

[...]
> +Comparison with GIT_TRACE
> +=========================
> +
> +SLOG is very similar to the existing GIT_TRACE[4] API because both
> +write event messages at various points during a command.  However,
> +there are some fundamental differences that warrant it being
> +considered a separate feature rather than just another
> +GIT_TRACE_<key>:

The natural question would be in the opposite direction: can and
should trace_printf be reimplemented on top of this feature?

[...]
> +    
> +    

nit: trailing whitespace (you can find these with "git show --check").

[...]
> +A session id (SID) is a cheap, unique-enough string to associate all
> +of the events generated by a single process.  A child git process inherits
> +the SID of their parent git process and incorporates it into their SID.

I wonder if we can structure events in a more hierarchical way to
avoid having to special-case the toplevel command in this way.

[...]
> +    # The "cmd_exit" event includes the command result and elapsed
> +    # time and the various configuration settings.  During the run
> +    # "index" category timers were placed around the do_read_index()
> +    # and "preload()" calls and various "status" category timers were
> +    # placed around the 3 major parts of the status computation.
> +    # Lastly, an "index" category "aux" data item was added to report
> +    # the size of the index.

Especially for tracing and monitoring applications, it would be
helpful if more of the information were emitted earlier instead of
waiting for exit.  Especially if I am trying to trace the cause of a
hanging command, information that is only printed at exit does not
help me.

The main missing bit in this doc is a sketch of the API.  Looking
forward to finding that in the header. ;-)

Sorry for the slow review, and thanks for your thoughtful work.

Sincerely,
Jonathan
