Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_MIXED_ES,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E107320A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 01:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeLMBRQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 20:17:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50190 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeLMBRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 20:17:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so699132wmd.0
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 17:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RzDNJxvHypQYU/QbTWgCg8bWWYF6yWOW5ws7fXNLh4w=;
        b=fm8Qz65q07GkLGXSRQKsVmXRo/fehODiVDZbapA2UNDGA6xcW2LGDd4+3k1yF+tnsD
         vJMk+5caEekGmCNV4ySli4oINjUNZFSw3pufsr3OVkLkaRczlpHvMtzuwlfUCMmARTJ8
         XJUJdX5faJmQELakJnZMf+X1mZa43aLyXB9v8K/puqqBTciLy/LkeGWipx4vpro4Ul5p
         bYiAnCeBbfZ3tMHtCPNoh+cTgeHSajJfB6rYtVg+blrTNRc5OIxpSlP5uFiBKKTt7frW
         rv10qGe5krK4SXYrT502vD36fig22RuoZxwhPrdbzdoPSM22FlMSonAnGi7FP4qpQ+dk
         b8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzDNJxvHypQYU/QbTWgCg8bWWYF6yWOW5ws7fXNLh4w=;
        b=ikmi3wSsPW9+aVxdyULCbP+Xlh/Y5Cj7Aro4aElc5mf8DYQ5ZI9cGtisCMbBNN8Mps
         +1g183GVRo/bT068PReMjOpaGAhwxLktt+5/z+3up8e6l0ZulADEs26obR8JyZiZLOIg
         wOLZK+Z8M9dqPGYnWV7bSM6H6BhhB1IiKbXTmp9aYgvrxQFk2xTP5zRwlNCdv/48f1UM
         1nN+TfaGE2OkClOk0or2NvjBKYTyWFfDP0b20hKEMpNTu3sCkOWFRZ+JCcL14jst9m0O
         6kxxUyghsiAfJOTkxKNykFzu6DP3mwL9yzyBE9b4l4RDeVrLh2rIRgBA5/ixMgrGvWAX
         WWbw==
X-Gm-Message-State: AA+aEWYFC0r2CCdIk53YhOOwRqxK1uU1es83aIZdprPmxSubcoZwow8m
        NuCyGyMAG2cnN3eqE3dvbo5kptP6SEECA49tnzqcXQ==
X-Google-Smtp-Source: AFSGD/XOYw77QuTcUxdlhut5pOKV4xH/Qk3PrPSJEqv8v5C6hbddAhTPhxDLXBmCW5flscZv+P0MSATL2D7oCtHBZQk=
X-Received: by 2002:a1c:8484:: with SMTP id g126mr8683323wmd.117.1544663833034;
 Wed, 12 Dec 2018 17:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20181116084427.GA31493@sigill.intra.peff.net> <cover.1544572142.git.steadmon@google.com>
 <df7d3659ae5f11d163f1e992f3b9403be709ddb7.1544572142.git.steadmon@google.com> <20181212110206.GA30673@sigill.intra.peff.net>
In-Reply-To: <20181212110206.GA30673@sigill.intra.peff.net>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Wed, 12 Dec 2018 17:17:01 -0800
Message-ID: <CAJB1erXRqQW0yQyZutJAJKC7WbdVhBAYUMWM+8ZutxA-W-7S8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] pack-protocol.txt: accept error packets in any context
To:     peff@peff.net
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 12, 2018 at 3:02 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Dec 11, 2018 at 04:25:15PM -0800, Josh Steadmon wrote:
>
> > From: Masaya Suzuki <masayasuzuki@google.com>
> >
> > In the Git pack protocol definition, an error packet may appear only in
> > a certain context. However, servers can face a runtime error (e.g. I/O
> > error) at an arbitrary timing. This patch changes the protocol to allow
> > an error packet to be sent instead of any packet.
> >
> > Following this protocol spec change, the error packet handling code is
> > moved to pkt-line.c.
>
> This is a change in the spec with an accompanying change in the code,
> which raises the question: what do other implementations do with this
> change (both older Git, and implementations like JGit, libgit2, etc)?

JGit is similar to Git. It parses "ERR " in limited places. When it sees an ERR
packet in an unexpected place, it'll fail somewhere in the parsing code.

https://github.com/eclipse/jgit/blob/30c6c7542190c149e2aee792f992a312a5fc5793/org.eclipse.jgit/src/org/eclipse/jgit/transport/PacketLineIn.java#L145-L147
https://github.com/eclipse/jgit/blob/f40b39345cd9b54473ee871bff401fe3d394ffe3/org.eclipse.jgit/src/org/eclipse/jgit/transport/BasePackConnection.java#L208

I'm not familiar with libgit2 code, but it seems it handles this at a
lower level. An error type packet is parsed out at a low level, and
the error handling is done by the callers of the packet parser.

https://github.com/libgit2/libgit2/blob/bea65980c7a42e34edfafbdc40b199ba7b2a564e/src/transports/smart_pkt.c#L482-L483

I cannot find an ERR packet handling in go-git. It seems to me that if
an ERR packet appears it treats it as a parsing error.

https://github.com/src-d/go-git/blob/master/plumbing/protocol/packp/common.go#L60-L62

>
> I think the answer for older Git is "hang up unceremoniously", which is
> probably OK given the semantics of the change. And I'd suspect most
> other implementations would do the same. I just wonder if anybody tested
> it with other implementations.

I'm thinking aloud here. There would be two aspects of the protocol
compatibility: (1) new clients speak to old servers (2) old clients
speak to a new server that speaks the updated protocol.

For (1), I assume that in the Git pack protocol, a packet starting
from "ERR " does not appear naturally except for a very special case
that the server doesn't support sideband, but using the updated
protocol. As you mentioned, at first it looks like this can mistakenly
parse the pack file of git-receive-pack as an ERR packet, assuming
that git-receive-pack's pack file is packetized. Actually
git-receive-pack's pack file is not packetized in the Git pack
protocol (https://github.com/git/git/blob/master/builtin/receive-pack.c#L1695).
I recently wrote a Git protocol parser
(https://github.com/google/gitprotocolio), and I confirmed that this
is the case at least for the HTTP transport. git-upload-pack's pack
file is indeed packetized, but packetized with sideband. Except for
the case where sideband is not used, the packfiles wouldn't be
considered as an ERR packet accidentally.

For (2), if the old clients see an unexpected ERR packet, they cannot
parse it. They would handle this unparsable data as if the server is
not speaking Git protocol correctly. Even if the old clients just
ignore the packet, due to the nature of the ERR packet, the server
won't send further data. The client won't be able to proceed. Overall,
the clients anyway face an error, and the only difference would be
whether the clients can show an error nicely or not. The new clients
will show the errors nicely to users. Old clients will not.

>
> > +An error packet is a special pkt-line that contains an error string.
> > +
> > +----
> > +  error-line     =  PKT-LINE("ERR" SP explanation-text)
> > +----
> > +
> > +Throughout the protocol, where `PKT-LINE(...)` is expected, an error packet MAY
> > +be sent. Once this packet is sent by a client or a server, the data transfer
> > +process defined in this protocol is terminated.
>
> The packfile data is typically packetized, too, and contains arbitrary
> data (that could have "ERR" in it). It looks like we don't specifically
> say PKT-LINE() in that part of the protocol spec, though, so I think
> this is OK.

As I described above, as far as I can see, the packfile in
git-upload-pack is not packetized. The packfile in git-receive-pack is
packetized but typically with sideband. At least at the Git pack
protocol level, this should be OK.

>
> Likewise, in the implementation:
>
> > diff --git a/pkt-line.c b/pkt-line.c
> > index 04d10bbd03..ce9e42d10e 100644
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -346,6 +346,10 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
> >               return PACKET_READ_EOF;
> >       }
> >
> > +     if (starts_with(buffer, "ERR ")) {
> > +             die(_("remote error: %s"), buffer + 4);
> > +     }
> > +
> >       if ((options & PACKET_READ_CHOMP_NEWLINE) &&
> >           len && buffer[len-1] == '\n')
> >               len--;
>
> This ERR handling has been moved to a very low level. What happens if
> we're passing arbitrary data via the packet_read() code? Could we
> erroneously trigger an error if a packfile happens to have the bytes
> "ERR " at a packet boundary?
>
> For packfiles via upload-pack, I _think_ we're OK, because we only
> packetize it when a sideband is in use. In which case this would never
> match, because we'd have "\1" in the first byte slot.
>
> But are there are other cases we need to worry about? Just
> brainstorming, I can think of:
>
>   1. We also pass packetized packfiles between git-remote-https and
>      the stateless-rpc mode of fetch-pack/send-pack. And I don't think
>      we use sidebands there.
>
>   2. The packet code is used for long-lived clean/smudge filters these
>      days, which also pass arbitrary data.
>
> So I think it's probably not a good idea to unconditionally have callers
> of packet_read_with_status() handle this. We'd need a flag like
> PACKET_READ_RESPECT_ERR, and to trigger it from the appropriate callers.

This is outside of the Git pack protocol so having a separate parsing
mode makes sense to me.

>
> -Peff
