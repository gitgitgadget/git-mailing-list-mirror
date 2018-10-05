Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74501F453
	for <e@80x24.org>; Fri,  5 Oct 2018 00:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeJEHO1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 03:14:27 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:45717 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeJEHO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 03:14:26 -0400
Received: by mail-pl1-f172.google.com with SMTP id y15-v6so5943685plr.12
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 17:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SJrcTuu5aYOBb6NimJC/u09Nhr09myGIVE/hg9oeTEk=;
        b=Azi8YTOyIju3E7FQisd5bqxnVHwDYJ/YLX2vhz8JgYNDtHmAxiqXR5XewnlobylrAS
         VV7llz6gq1foABQd6tNv3Nn9qvu75li0yogUMNGfo68qItqKcqnBAHpq/xxUeu0A1RjI
         hT2jiT1J8AQ3YMM9wyp81I+4oMzOAE0Hhz1bUbfGKnfCpTZzqZnYA8HRJ0UyLosyhkXq
         3zUysv4VI0R53GVlI4Dcquiho/6yF9azsLoBShh9JGDL1WxDikSUpo3BSwLUad05aNwX
         /oRRuQlubBn19I3LI/VZukJmNUVFpVKDocu7Uf1iVJJ9Ehi1yp8VB+WpWqi0K0I+A9OP
         ZJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SJrcTuu5aYOBb6NimJC/u09Nhr09myGIVE/hg9oeTEk=;
        b=Vc8h+kEM8ev4C24HlL+jtxQIUU03wfWSCNR7FWjfVuoCC8TVWHxHhiWHugKgqsfXlk
         XceLZXRJTTqXF35p/ShVyJZ+3V67WYpBO8mskVP+rzoOeWdYMPLYzcqHJkYgVPGBtH6v
         tnI/a6GodXolSvQavfq/FlqnXIuOZ47axWWI/UypYbDTyvFacthuETgov5A0/4Ep3DYV
         urw9NjIriawtY9ar8MCEk4M7ltL4xahemvVvZ0ud9Yveilvp1MxLv4V2jIkOA7VemxiQ
         1i8y5cUHXZs6bHDyMNHAbTSmglxGG6kXVCA5HLu91ZCTlK1ZXt1jHFf41WvXX7RyXhGK
         pfXw==
X-Gm-Message-State: ABuFfoiDHPVN8anvNoDXliNGRsRwHNCEuBgps6+6XRru9JUrMIYgsmEo
        1PqEBhyVvbJMxVy+xe61dwfcA/jiXGgRIw==
X-Google-Smtp-Source: ACcGV61Z9TFG8zIHh8acc8rMPJTvun/AWR2psq+s5k8MpqrsDl/UYZSxS0703zt7wI62YM6amw3XRA==
X-Received: by 2002:a17:902:aa02:: with SMTP id be2-v6mr8959627plb.294.1538698704162;
        Thu, 04 Oct 2018 17:18:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:79fb:7d7a:4d6b:acb7])
        by smtp.gmail.com with ESMTPSA id e19-v6sm11365188pfb.153.2018.10.04.17.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 17:18:22 -0700 (PDT)
Date:   Thu, 4 Oct 2018 17:18:17 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] protocol: limit max protocol version per service
Message-ID: <20181005001817.GB32105@google.com>
References: <cover.1538516853.git.steadmon@google.com>
 <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
 <CAGZ79kbD=P__8GU9rV87wREF_MbQA9i2ij6C2qXyaJfqHD3Szg@mail.gmail.com>
 <20181003213349.GA32105@google.com>
 <CAGZ79kZP7y3v8hrhKKP_FT7+uyUSWO5s8w13-c67QWdzme1-Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZP7y3v8hrhKKP_FT7+uyUSWO5s8w13-c67QWdzme1-Qw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.03 15:47, Stefan Beller wrote:
> On Wed, Oct 3, 2018 at 2:34 PM Josh Steadmon <steadmon@google.com> wrote:
> >
> > Is there a method or design for advertising multiple acceptable versions
> > from the client?
> 
> I think the client can send multiple versions, looking through protocol.c
> (and not the documentation as I should for this:)
> 
>   /*
>    * Determine which protocol version the client has requested.  Since
>    * multiple 'version' keys can be sent by the client, indicating that
>    * the client is okay to speak any of them, select the greatest version
>    * that the client has requested.  This is due to the assumption that
>    * the most recent protocol version will be the most state-of-the-art.
>    */
>     ...
>     const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
>     string_list_split(&list, git_protocol, ':', -1);
>     ...
>     for_each_string_list_item(item, &list) {
>         ...
>         if (skip_prefix(item->string, "version=", &value))
>             ...
> 
> in determine_protocol_version_server which already had the client
> speak to it, so I think at least the server can deal with multiple versions.
> 
> But given that we transport the version in env variables, we'd
> need to be extra careful if we just did not see the version
> in the --remote=. above?

Sorry, I'm not sure I understand this. What about env variables requires
caution?


> > From my understanding, we can only add a single
> > version=X field in the advertisement, but IIUC we can extend this fairly
> > easily? Perhaps we can have "version=X" to mean the preferred version,
> > and then a repeatable "acceptable_version=Y" field or similar?
> 
> Just re-use "version X", separated by colons as above.
> 
> > > From a maintenance perspective, do we want to keep
> > > this part of the code central, as it ties protocol (as proxied
> > > by service name) to the max version number?
> > > I would think that we'd rather have the decision local to the
> > > code, i.e. builtin/fetch would need to tell protocol.c that it
> > > can do (0,1,2) and builtin/push can do (0,1), and then the
> > > networking layers of code would figure out by the input
> > > from the caller and the input from the user (configured
> > > protocol.version) what is the best to go forward from
> > > then on.
> >
> > I like having it centralized, because enforcing this in git_connect()
> > and discover_refs() catches all the outgoing version advertisements, but
> > there's lots of code paths that lead to those two functions that would
> > all have to have the acceptable version numbers plumbed through.
> 
> Makes sense.
> 
> > I suppose we could also have a registry of services to version numbers,
> > but I tend to dislike non-local sources of data. But if the list likes
> > that approach better, I'll be happy to implement it.
> 
> > > But I guess having the central place here is not to
> > > bad either. How will it cope with the desire of protocol v2
> > > to have only one end point (c.f. serve.{c,h} via builtin/serve
> > > as "git serve") ?
> >
> > I'm not sure about this. In my series to add a v2 archive command, I
> > added support for a new endpoint for proto v2 and I don't recall seeing
> > any complaints, but that is still open for review.
> 
> Ah I guess new end points would imply that you can speak at least
> a given version N.
> 
> > I suppose if we are strict about serving from a single endpoint, the
> > version registry makes more sense, and individual operations can declare
> > acceptable version numbers before calling any network code?
> 
> Ah yeah, that makes sense!

Thinking out loud here. Please let me know if I say something stupid :)

So we'll have (up to) three pieces of version information we'll care
about for version negotiation:

1. (maybe) a client-side protocol.version config entry
2. a list of acceptable proto versions for the currently running
   operation on the client
3. a list of acceptable proto versions for the server endpoint that
   handles the request

According to the doc on protocol.version: "If set, clients will attempt
to communicate with a server using the specified protocol version. If
unset, no attempt will be made by the client to communicate using a
particular protocol version, this results in protocol version 0 being
used."

So, if protocol.version is not set, or set to 0, the client should not
attempt any sort of version negotiation. Otherwise, the client prefers a
particular version, but we don't guarantee that they will actually use
that version after the (unspecified) version negotiation procedure.

If protocol.version is set to something other than 0, we construct a
list of acceptable versions for the given operation. If the
protocol.version entry is present in that list, we move it to the front
of the list to note that it is the preferred version. We send all of
these, in order, in the request.

When the server endpoint begins to handle a request, it first constructs
a list of acceptable versions. If the client specifies a list of
versions, we check them one-by-one to see if they are acceptable. If we
find a match, we use that version. If we don't find any matches or if
the client did not send a version list, we default to v0.

Seem reasonable?


Thanks,
Josh
