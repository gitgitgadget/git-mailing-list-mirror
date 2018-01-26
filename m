Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DFBF1F576
	for <e@80x24.org>; Fri, 26 Jan 2018 10:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeAZKkZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 05:40:25 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36896 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeAZKkW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 05:40:22 -0500
Received: by mail-oi0-f51.google.com with SMTP id t78so40240oih.4
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 02:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RsweXR40thgX+VynI9czlpSVt8teMCSC1H178KIVQjE=;
        b=Hl2PQwRhtC/T7dUlD5nZxkRNnK3Xy9jMd/pkGcagnHzALg8s4o9R9RgTKGg9u7YXek
         ivmPlVX2tSOL2ljPXQUB0fvKhtiDzHceK13qscq8cW2BKuASeP82A34d3pLoEzdKAJ5t
         YpFBQkHq8+HHddSt8ZvOC8x4yLEtoOzqBc+/MmhC1QAOY5ypjD6EaU3fseLD1c89+QeO
         oAqfkIlXGHORmorRrepvNp9gu8g4rz4CMhcSttu2riClJUX3fWleIIxIaYmaHyKq3mxI
         IwIQMIoTLB8LLUxHtIdMJq4vEkC0EQ+vmYGWew4vCepJvHBmL50vXnzANaqoLhmSlv5N
         89aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RsweXR40thgX+VynI9czlpSVt8teMCSC1H178KIVQjE=;
        b=XHo38Caa4LKKimrD1K7k6O8ZjgioowTj7UAfk7qk2SifAxPBd44PCQIAcOqKa6y3YZ
         ZKnCv3MPr1Y09cZoFKciDtZPQACZWs3x7MjS7IalBMTIBIBQyykSwclLH2fS8EZfNanf
         IgTM9DcFFEgb+JKlxFxTAwGvUZZ7RMPGpknga/VgjywwD5g3t0NOyEEevGfpdCP+n7ll
         y66guvuQfH+qtt0jXm1K5fpCssh117y1/8hbuncQVtgjlEQb+q6RH9BzSx6gyWw8w3mk
         O0vcJIeK9U0MTtZlMziQ8hk87fnH0RZmfN00VIWvWOq7lEzq+dJdSSH45kOF6kQIsund
         H5xA==
X-Gm-Message-State: AKwxytemANzqEchPe1doh1CnczQLGpWxPUHe1Fbn9FFXNsakJB1Eift4
        WAzpOnJFhaPiiuvuVyRGeYY/ytlD0rM03BPc8Vg=
X-Google-Smtp-Source: AH8x224/ZbCYvA2upKT17rVYYk3MzYFjnA/HOLsMPqdlKoAD2YGykhACdy1NKJA0hErMaKujNjdW0OdejfTEyIikRro=
X-Received: by 10.202.171.207 with SMTP id u198mr1808517oie.253.1516963222221;
 Fri, 26 Jan 2018 02:40:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.144.218 with HTTP; Fri, 26 Jan 2018 02:39:51 -0800 (PST)
In-Reply-To: <20180125235838.138135-13-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-13-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 26 Jan 2018 17:39:51 +0700
Message-ID: <CACsJy8BHh+Kv=om+rc6=TM60E1j9=wq4rRBvKB8HLfNTMa51Rg@mail.gmail.com>
Subject: Re: [PATCH v2 12/27] serve: introduce git-serve
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>, stolee@gmail.com,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 6:58 AM, Brandon Williams <bmwill@google.com> wrote:
> + Detailed Design
> +=================
> +
> +A client can request to speak protocol v2 by sending `version=2` in the
> +side-channel `GIT_PROTOCOL` in the initial request to the server.
> +
> +In protocol v2 communication is command oriented.  When first contacting a
> +server a list of capabilities will advertised.  Some of these capabilities

s/will advertised/will be advertised/

> + Capability Advertisement
> +--------------------------
> +
> +A server which decides to communicate (based on a request from a client)
> +using protocol version 2, notifies the client by sending a version string
> +in its initial response followed by an advertisement of its capabilities.
> +Each capability is a key with an optional value.  Clients must ignore all
> +unknown keys.

With have a convention in $GIT_DIR/index file format that's probably a
good thing to follow here: lowercase keys are optional, such unknown
keys can (and must) be ignored. Uppercase keys are mandatory. If a
client can't understand one of those keys, abort. This gives the
server a way to "select" clients and introduce incompatible changes if
we ever have to.

> Semantics of unknown values are left to the definition of
> +each key.  Some capabilities will describe commands which can be requested
> +to be executed by the client.
> +
> +    capability-advertisement = protocol-version
> +                              capability-list
> +                              flush-pkt
> +
> +    protocol-version = PKT-LINE("version 2" LF)
> +    capability-list = *capability
> +    capability = PKT-LINE(key[=value] LF)
> +
> +    key = 1*CHAR
> +    value = 1*CHAR
> +    CHAR = 1*(ALPHA / DIGIT / "-" / "_")

Is this a bit too restricted for "value"? Something like "." (e.g.
version) or "@" (I wonder if anybody will add an capability that
contains an email address). Unless there's a good reason to limit it,
should we just go full ascii (without control codes)?

> +A client then responds to select the command it wants with any particular
> +capabilities or arguments.  There is then an optional section where the
> +client can provide any command specific parameters or queries.
> +
> +    command-request = command
> +                     capability-list
> +                     (command-args)
> +                     flush-pkt
> +    command = PKT-LINE("command=" key LF)
> +    command-args = delim-pkt
> +                  *arg
> +    arg = 1*CHAR
> +
> +The server will then check to ensure that the client's request is
> +comprised of a valid command as well as valid capabilities which were
> +advertised.  If the request is valid the server will then execute the
> +command.

What happens when the request is not valid? Or..

> +When a command has finished

How does the client know a command has finished? Is it up to each
command design?

More or less related it bugs me that I have a translated git client,
but I still receive remote error messages in English. It's a hard
problem, but I'm hoping that we won't need to change the core protocol
to support that someday. Although we could make rule now that side
channel message could be sent in "printf"-like form, where the client
can translate the format string and substitutes placeholders with real
values afterward...

> a client can either request that another
> +command be executed or can terminate the connection by sending an empty
> +request consisting of just a flush-pkt.
> +
> + Capabilities
> +~~~~~~~~~~~~~~
> +
> +There are two different types of capabilities: normal capabilities,
> +which can be used to to convey information or alter the behavior of a
> +request, and command capabilities, which are the core actions that a
> +client wants to perform (fetch, push, etc).
> +
> + agent
> +-------
> +
> +The server can advertise the `agent` capability with a value `X` (in the
> +form `agent=X`) to notify the client that the server is running version
> +`X`.  The client may optionally send its own agent string by including
> +the `agent` capability with a value `Y` (in the form `agent=Y`) in its
> +request to the server (but it MUST NOT do so if the server did not
> +advertise the agent capability). The `X` and `Y` strings may contain any
> +printable ASCII characters except space (i.e., the byte range 32 < x <
> +127), and are typically of the form "package/version" (e.g.,
> +"git/1.8.3.1"). The agent strings are purely informative for statistics
> +and debugging purposes, and MUST NOT be used to programmatically assume
> +the presence or absence of particular features.
> +
> + stateless-rpc
> +---------------
> +
> +If advertised, the `stateless-rpc` capability indicates that the server
> +supports running commands in a stateless-rpc mode, which means that a
> +command lasts for only a single request-response round.
> +
> +Normally a command can last for as many rounds as are required to
> +complete it (multiple for negotiation during fetch or no additional
> +trips in the case of ls-refs).  If the client sends the `stateless-rpc`
> +capability with a value of `true` (in the form `stateless-rpc=true`)
> +then the invoked command must only last a single round.

Speaking of stateless-rpc, I remember last time this topic was brought
up, there was some discussion to kind of optimize it for http as well,
to fit the "client sends request, server responds data" model and
avoid too many round trips (ideally everything happens in one round
trip). Does it evolve to anything real? All the cool stuff happened
while I was away, sorry if this was discussed and settled.
-- 
Duy
