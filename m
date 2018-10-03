Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A911F453
	for <e@80x24.org>; Wed,  3 Oct 2018 22:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJDFhm (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 01:37:42 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:37809 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeJDFhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 01:37:42 -0400
Received: by mail-ed1-f44.google.com with SMTP id c22-v6so6832720edc.4
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 15:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKeq2rInHdNpqVWb/Ni4OHbHTbH/RUTNtOWkNE1sXm4=;
        b=tyS+Q5TDBPsYBar2iCLPJsynOtHxoc8HRGobbgBZCPYEgEDxIi/YtC5J4igI+GHct/
         tYN/0rJ1Dfq9Li98+xYC/zEKssI4fd7g0gvJ46/A9FwCs5zNU0ILUGOX3K5vOI8zM7iP
         /AaHOEDl+Vso1GejuUvfGVHzAuMrngaslt5pI23bzb3/wxtIVz61UUiKi+AfJ8bP//St
         QxuKsNhOKvbLGa7zWYkWQs8RggQS0JiRkjn1y0uhc6wDKlG0/GZ+QJn/FKblVwY+6kj4
         Bvo4r2hVWCLwx4IsSLT3BRZmoP382N8RH19UBjjo7VWtz81RzqnLnu0NaY3hW9OeltVK
         urWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKeq2rInHdNpqVWb/Ni4OHbHTbH/RUTNtOWkNE1sXm4=;
        b=mukruWxt8PuvTawwfwx1PXHSkx6vZnVluevjvobMqo6XuLrgNk9gMY2zND7ZKsfLXy
         SXmHdC1NO6T7Cbvtc0ZgERZd2oNPbZf3tn1Pnnrt78HMpWomiyCH8KU44iwX5XQ1mgNf
         nLp1d1oKh6hOXZBpWka/DgIvxIuRsamUA1rBcde9RwVfxwvzfDwqaUD+W+jdPL/+bHJQ
         LezALPJ30RVl5nSt7PpgZ1A9fCXLBQNGarXCYQL/fFdU7a80CJduDTt/QKJecG9oT1sr
         Yjq3dgMznQkEGp/0MsXBWL6vHA11uA8ksh1wd9lL843a8iNkmnExrgjdfylHYvf7vPCK
         dF5w==
X-Gm-Message-State: ABuFfoj8kzjY89UrqQvEI8lNzGLWccKQo/gQaBZ+ECBw2bmXNQNDglR0
        dEzk+NFzbbbxQ8psHyhwQLCql4uwZTm/okHZZIdWKg==
X-Google-Smtp-Source: ACcGV60YqvLfahMR4rGNVBWIAiaYGIfmMGDOcc6/2bnuw9NcVtVri18MMReoFNCNssb3jKgmNz3+G8etWpM5C8z9Ayc=
X-Received: by 2002:aa7:c742:: with SMTP id c2-v6mr284226eds.231.1538606837079;
 Wed, 03 Oct 2018 15:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538516853.git.steadmon@google.com> <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
 <CAGZ79kbD=P__8GU9rV87wREF_MbQA9i2ij6C2qXyaJfqHD3Szg@mail.gmail.com> <20181003213349.GA32105@google.com>
In-Reply-To: <20181003213349.GA32105@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Oct 2018 15:47:05 -0700
Message-ID: <CAGZ79kZP7y3v8hrhKKP_FT7+uyUSWO5s8w13-c67QWdzme1-Qw@mail.gmail.com>
Subject: Re: [PATCH 1/1] protocol: limit max protocol version per service
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 3, 2018 at 2:34 PM Josh Steadmon <steadmon@google.com> wrote:

>
> I believe that git-upload-archive can still speak version 1 without any
> trouble, but it at least doesn't break anything in the test suite to
> limit this to v0 either.

ok, let me just play around with archive to follow along:

Running the excerpt that I found in one of the tests in t5000

    GIT_TRACE_PACKET=1 git archive --remote=. HEAD >b5.tar

(whoooa ... that spews a lot of text into my terminal, which makes
sense as transported tar files unlike packets starting with PACK are
not cut short; so onwards:)

    $ git init test && cd test
    $ GIT_TRACE_PACKET=1 git archive --remote=. HEAD >b5.tar
    ...
    git< \2fatal: no such ref: HEAD
    ...
    fatal: sent error to the client: git upload-archive: archiver died
with error
    remote: git upload-archive: archiver died with error

This sounds similar to a bug that I have on my todo list for
clone recursing into submodules. Maybe we need to talk
about HEAD-less repositories and how to solve handling them
in general. Usually it doesn't happen except for corner cases like
now, so:

    $ git commit --allow-empty -m "commit"
    [master (root-commit) 24d7967] commit
    $ GIT_TRACE_PACKET=1 git archive --remote=. HEAD >b5.tar
15:28:00.762615 pkt-line.c:80           packet:          git> argument HEAD
15:28:00.762704 pkt-line.c:80           packet:          git> 0000
15:28:00.766336 pkt-line.c:80           packet:          git> ACK
15:28:00.766428 pkt-line.c:80           packet:          git> 0000
15:28:00.766483 pkt-line.c:80           packet:          git< ACK
15:28:00.766508 pkt-line.c:80           packet:          git< 0000
15:28:00.767694 pkt-line.c:80           packet:          git< \2
15:28:00.767524 pkt-line.c:80           packet:          git< argument HEAD
15:28:00.767583 pkt-line.c:80           packet:          git< 0000
remote: 15:28:00.767524 pkt-line.c:80           packet:          git<
argument HEAD
remote: 15:28:00.767583 pkt-line.c:80           packet:          git< 0000
15:28:00.768758 pkt-line.c:80           packet:          git> 0000
15:28:00.770475 pkt-line.c:80           packet:          git<
\1pax_global_header
    ... \0\0\0\0\0\0\0\0\0\0\0\0\ ...
 # not too bad but the tar file contains a lot of zeros
    $

Ah I forgot the crucial part, so

    $ GIT_TRACE_PACKET=1 git -c protocol.version=1 archive --remote=.
HEAD >b5.tar
15:33:10.030508 pkt-line.c:80           packet:          git> argument HEAD
...

This pretty much looks like v0 as v1 would send a "version 1", c.f.

    $ GIT_TRACE_PACKET=1 git -c protocol.version=1 fetch .
15:34:26.111013 pkt-line.c:80           packet:  upload-pack> version 1
15:34:26.111140 pkt-line.c:80           packet:        fetch< version 1
....


>
> Is there a method or design for advertising multiple acceptable versions
> from the client?

I think the client can send multiple versions, looking through protocol.c
(and not the documentation as I should for this:)

  /*
   * Determine which protocol version the client has requested.  Since
   * multiple 'version' keys can be sent by the client, indicating that
   * the client is okay to speak any of them, select the greatest version
   * that the client has requested.  This is due to the assumption that
   * the most recent protocol version will be the most state-of-the-art.
   */
    ...
    const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
    string_list_split(&list, git_protocol, ':', -1);
    ...
    for_each_string_list_item(item, &list) {
        ...
        if (skip_prefix(item->string, "version=", &value))
            ...

in determine_protocol_version_server which already had the client
speak to it, so I think at least the server can deal with multiple versions.

But given that we transport the version in env variables, we'd
need to be extra careful if we just did not see the version
in the --remote=. above?

> From my understanding, we can only add a single
> version=X field in the advertisement, but IIUC we can extend this fairly
> easily? Perhaps we can have "version=X" to mean the preferred version,
> and then a repeatable "acceptable_version=Y" field or similar?

Just re-use "version X", separated by colons as above.

> > From a maintenance perspective, do we want to keep
> > this part of the code central, as it ties protocol (as proxied
> > by service name) to the max version number?
> > I would think that we'd rather have the decision local to the
> > code, i.e. builtin/fetch would need to tell protocol.c that it
> > can do (0,1,2) and builtin/push can do (0,1), and then the
> > networking layers of code would figure out by the input
> > from the caller and the input from the user (configured
> > protocol.version) what is the best to go forward from
> > then on.
>
> I like having it centralized, because enforcing this in git_connect()
> and discover_refs() catches all the outgoing version advertisements, but
> there's lots of code paths that lead to those two functions that would
> all have to have the acceptable version numbers plumbed through.

Makes sense.

> I suppose we could also have a registry of services to version numbers,
> but I tend to dislike non-local sources of data. But if the list likes
> that approach better, I'll be happy to implement it.

> > But I guess having the central place here is not to
> > bad either. How will it cope with the desire of protocol v2
> > to have only one end point (c.f. serve.{c,h} via builtin/serve
> > as "git serve") ?
>
> I'm not sure about this. In my series to add a v2 archive command, I
> added support for a new endpoint for proto v2 and I don't recall seeing
> any complaints, but that is still open for review.

Ah I guess new end points would imply that you can speak at least
a given version N.

> I suppose if we are strict about serving from a single endpoint, the
> version registry makes more sense, and individual operations can declare
> acceptable version numbers before calling any network code?

Ah yeah, that makes sense!

Thanks for your explanations and prodding,
Stefan
