Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8AD1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdJXSgC (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:36:02 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:53657 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdJXSgA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:36:00 -0400
Received: by mail-pf0-f178.google.com with SMTP id t188so20299825pfd.10
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xtrXrKh59Sv2AlezH8FTHpwoE/zCH3EOLQCCJKeYaS8=;
        b=F09EC9bi6VBzo8PDMcwLmGVXHZH6V1xFgxj0HJh9lQQeNEp7LZNHFOAkW8gGA+dNB8
         zbQo2AW56idlai7QBzMxw167TIx+mfZkcmuVD4lH7hTVTW4ALPeY+CDAV7NM+oz5sY4g
         nIjWH2fTuLML+YzuznLO3vZcbiJqATjAVgY6r4OggkD7JGpOwoKFrWodWgGYYC4jx/VE
         jk8Ll3Qu4kUyCLF2BZcBlJCEjNnlZwCJN1MFxc1LnCs1Pg7kG1ZHOdEC45WlDHQOpyiV
         v0UObwTqYYqx9A5qcBewDuzv5FRYa9ho/zrzzSLvYQqzreDcv/JdC4jhxtk1HV2dbcOQ
         xyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xtrXrKh59Sv2AlezH8FTHpwoE/zCH3EOLQCCJKeYaS8=;
        b=skBP38VS+daD7ODjIIusIwe+gDMEl8uNdOuAUsTfd8WWZ5JOFxF/1fHpdGF7glOeDb
         a90EpVfgptsonaigPYD/jhYvOphJ0HtqQopKFgGBWgF7fIHr/n+mrGb/u2CRPWJRPoW3
         iTTwq5pqfkNGufWzHqmwi2QLLy7PIqmK5BFYTC4Y2RDwa0/yQyjrBxsRMyR5qnBuq8y9
         IHOGW6r/TZJhDp9YXswa2mgkSLAx6W4LL8h+B53LFliliiyuTwstXqDsfyB4tY/eFjAf
         AeUDLHQ7Ewu9ohf5Rj3Ty0P/zbpQFQIEm/bSL3ACO3V8OcLnzkfTAyQDjSrgYC9LX7Wd
         eQug==
X-Gm-Message-State: AMCzsaV2wYb1yOH3UuVj8I+WQfxkBMOelvcnTSTgBJfBMcihOiAPyt1e
        CRZcWpnC5QOJRTOGG5ti82cHBQ==
X-Google-Smtp-Source: ABhQp+RIz4MMbCCwf+7yzSwgwSyk9xlfsOnnPQ3PSVoevTcLNpkqM+WWNNHT3FaGIHlho6PR/QBYqg==
X-Received: by 10.99.56.78 with SMTP id h14mr15539593pgn.192.1508870159802;
        Tue, 24 Oct 2017 11:35:59 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:89d4:9a95:7fcc:a26])
        by smtp.gmail.com with ESMTPSA id b16sm1677317pfe.58.2017.10.24.11.35.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Oct 2017 11:35:58 -0700 (PDT)
Date:   Tue, 24 Oct 2017 11:35:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [RFC] protocol version 2
Message-ID: <20171024183557.GB79163@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <xmqqbmkxkpn9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmkxkpn9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >   * Capabilities were implemented as a hack and are hidden behind a NUL
> >     byte after the first ref sent from the server during the ref
> >     advertisement:
> > ...
> >
> >   * Various other technical debt (e.g. abusing capabilities to
> >     communicate agent and symref data, service name set using a query
> >     parameter).
> 
> This sounds like a duplicate of the above.

You're right, it mostly is a duplication of that.

> 
> >  Special Packets
> > -----------------
> >
> > In protocol v2 these special packets will have the following semantics:
> >
> >   * '0000' Flush Packet (flush-pkt) - indicates the end of a message
> >   * '0001' End-of-List delimiter (delim-pkt) - indicates the end of a list
> 
> After reading the remainder of the document twice, I do not think
> the reason why we want to introduce a new type delim-pkt is
> explained and justified well enough.  If a command request takes a
> command packet, zero or more capability packets, a mandatory
> delimiter packet, zero or more parameter packets and a mandatory
> flush packet, then you can use the same "flush" as delimiter in the
> middle.  The delimiter will of course become useful if you can omit
> it when not necessary (e.g. after seeing capabilities, you may see a
> flush and you will know there is no parameters and save the need to
> send one "delim").
> 
> I actually have a reasonable guess why you want to have a separate
> delimiter (which has nothing to do with "optional delim can be
> omitted"), but I want to see it explained in this document clearly
> by its designer(s).

Jonathan Tan suggested that we tighten flush semantics in a newer
protocol so that proxies are easier to work with.  Currently proxies
need to understand the protocol instead of simply waiting for a flush.

Also I've been told the smart http code is more complex because of the
current semantics of flush packets.

> 
> >     command-request = command
> >                       capability-list
> >                       delim-pkt
> >                       (command specific parameters)
> >                       flush-pkt
> >     command = PKT-LINE("command=" key LF)
> >
> > The server will then acknowledge the command and requested capabilities
> > by echoing them back to the client and then launch into the command.
> >
> >     acknowledge-request = command
> >                           capability-list
> >                           delim-pkt
> >                           execute-command
> >     execute-command = <defined by each command>
> 
> It is not quite clear what the value of "echoing them back" is,
> especially if that is done by always echoing verbatim.  A reader may
> naturally expect, when capabilities are exchanged between two
> parties, these are negotiated so that the only ones that are
> commonly supported by both ends would be used, or something like
> that.

The echoing back of the command and requested capabilities may or may
not be needed.  A client should only ever issue a command-request using
advertised capabilities and commands so there really isn't much
negotiation happening, just the server saying "here's what's on the
menu" and the client picking only from that menu.

Where the echoing back may be useful is if we wanted to (at some point)
eliminate this initial round trip of doing the capability advertisement
and then subsequent selection of capabilities and instead stuff that
information into the GIT_PROTOCOL side channel in the initial request.
That way the client could optimistically send capabilities that it
doesn't yet know if the server supports.  I thought this might be an
interesting idea if we really really didn't want to live with the extra
round trip.

> 
> > A particular command can last for as many rounds as are required to
> > complete the service (multiple for negotiation during fetch and push or
> > no additional trips in the case of ls-refs).
> 
> OK.
> 
> >  Commands in v2
> > ~~~~~~~~~~~~~~~~
> >
> > Services are the core actions that a client wants to perform (fetch,
> > push, etc).  Each service has its own set of capabilities and its own
> > language of commands (think 'want' lines in fetch).  Optionally a
> > service can take in initial parameters or data when a client sends it
> > service request.
> 
> So a service (like "fetch") employ a set of "command"s (like "want",
> "have, etc)?  In the earlier part of the document, we did not see
> any mention of "service" and instead saw only "command" mentioned.
> Is the state machine on both ends and the transition between states
> implicit?  E.g. when one side throws "want" command and the other
> side acknowledges, they understand implicitly that they are now in a
> "fetch" service session, even though there is nothing that said over
> the wire that they are doing so?  One reason I am wondering about
> this is what we should do if a command verb may be applicable in
> multiple services.

Looks like I missed changing the word "services" to "commands" here.  I
originally was using the term 'services' for things like 'fetch', 'push',
'ls-refs', etc. and decided for some reason to change to using the word
'commands'.  Naming things is hard, especially when you couldn't decide
on a name and end up with two! ;) 

> After reading the earlier protocol exchange explanation, I was sort
> of expecting that "fetch" would be the command and "want", "have",
> and "ack" lines would be exchanged as "command specific parameters",
> so a sudden introduction of "services" here was a bit of impedance
> mismatch to me.

You are absolutely correct in that i intended 'fetch' to be the command
and 'want', 'have', and 'ack' lines would be parameters.

> 
> >  Ls-refs
> > ---------
> >
> > Ls-refs can be looked at as the equivalent of the current ls-remote as
> > it is a way to query a remote for the references that it has.  Unlike
> > the current ls-remote, the filtering of the output is done on the server
> > side by passing a number of parameters to the server-side command
> > instead of the filtering occurring on the client.
> >
> > Ls-ref takes in the following parameters:
> >
> >   --head, --tags: Limit to only refs/heads or refs/tags
> 
> I see no need for the above two as long as "refs/heads/*", etc. are
> understood.
> 
> >   --refs: Do not show peeled tags or pseudorefs like HEAD
> 
> So showing peeled tags is the default?  Then I can sort-of see why
> "I am not interested in peeled result".  
> 
> I do not see why "do not show HEAD, MERGE_HEAD, etc." is needed,
> though.  It should be sufficient to just ask for refs/* if you are
> interested only in other things, no?
> 
> >   --symref: In addition to the object pointed by it, show the underlying
> >             ref pointed by it when showing a symbolic ref
> 
> Sort of OK--it probably is easier to always send this, as symbolic
> refs are minority anyway, though.
> 
> >   <refspec>: When specified, only references matching the given patterns
> >              are displayed.
> 
> I do not think you meant <refspec> here.
> 
> The side that is listing what it has has no reason to know what the
> recipient plans to do with the result, so you must be only sending
> the LHS of a refspec.  If your explanation says "given patterns",
> then replace <refspec> with <pattern>.  Do not abuse a term that has
> specific and established meaning for something else.

Yes, you're right i intended that to mean <pattern> instead so that the
client could send "refs/heads/*" or some other such pattern and have the
server limit its output.

All of these parameters I just pulled from the current ls-remote command
thinking that whatever filtering the client currently does can end up
being done on the server.  You've illustrated that most of them could
simply be done with apattern so maybe i was overthinking it :)

> 
> > The output of ls-refs is as follows:
> >
> >     output = (no-refs / list-of-refs)
> > 	     *symref
> >              *shallow
> >              flush-pkt
> >
> >     no-refs = PKT-LINE(zero-id SP no-refs LF)
> 
> Can't your list-of-refs have 0 element?  I do not see why you need
> no-refs here.  It's not like you need a dummy line, to the end of
> which you need to append NUL plus hidden capabilities ;-)

Haha! good point.  Yes a list-of-refs can certainly have 0 elements.
One less thing that can be borrowed from the old protocol :)

> 
> >     list-of-refs = *ref
> >     ref = PKT-LINE((tip / peeled) LF)
> >     tip = obj-id SP refname
> >     peeled = obj-id SP refname "^{}"
> >
> >     symref = PKT-LINE("symref" SP symbolic-ref SP resolved-ref LF)
> >     shallow = PKT-LINE("shallow" SP obj-id LF)
> 
> Thanks.

-- 
Brandon Williams
