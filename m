Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB1E20C3A
	for <e@80x24.org>; Fri,  8 Dec 2017 18:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbdLHSLt (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 13:11:49 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:34925 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752919AbdLHSLq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 13:11:46 -0500
Received: by mail-it0-f50.google.com with SMTP id f143so6576893itb.0
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 10:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0wr4j1XzfCpooUMcCzZErcvmoKo7cNG0KWFvGRmKtrE=;
        b=X6Wnz95zy6mvy1JKSMbzAK0VyGeLGOQ+5pko7Al4udPb1LSZqSGM2sl93BmiOAVjMQ
         z2KZ3FdR4QJxPlLEsejUnYNemRWGA0xGp6k+kUbzz5KxyBtFRMCuRshZd3z2os92JP7v
         hwVd62Y7egOYr3WF9J8N4+lTqxUONIE6r85hq9/piZpU3kpKdOuMUBj11wEGrAhEiZDO
         TglnxI4c9rI+6qeq40uu9KuO4wrLSR3jUVafuhNT3L5N7UPR0X0GOYqNWdjfZNVqvf5Y
         fR8jm0e/OLObzDtDzti/D0Kpq0LZ9VoV+Uvco/xONUA+UShA815r4PwPZcSDK89QrPzB
         1rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0wr4j1XzfCpooUMcCzZErcvmoKo7cNG0KWFvGRmKtrE=;
        b=nA8g3jgfM6mw1hqz5wNEmj3sY86B5N5NaG7NSrjW/0kQ0mBBp4ejDFSqloG+Cbw9kk
         P9LsCccdpyWZb+O1L1yiGHy8L/6CnxhZuzrgzXX578EwgEq8YOrOkobMricjgTrgwWpd
         qBhnIH2lJ8enanrYII0nscrBPQUIW7JCBWVwNl7FKbr9PSr6wo0FVUN5nQuQvHDd7N00
         5q+UQ9qZKv1zluaKDCQlEpv+HKtO09TiDMX/4dAVqg20vFLR3VNbFtChcvyVUWKAZN7H
         +UI7GUNl/+ikDg0nXvz9HdWJyuz+lp0IJ0m/FX54lg+vm1nECNHcHxMSeeD4UL+gcarb
         KzJQ==
X-Gm-Message-State: AKGB3mIO6Yav6R1CQaAb0OIJnJvAxeZIioOvPYeWqSAFCTg8p1BapMBR
        CVgoziDMDll40HmKkrLS3T1l5g==
X-Google-Smtp-Source: AGs4zMZJ9r5L3yNYsQN2WDvov8aRnUa1pc+gT16Klz6o1NTdAK07cOBTyutOBouYESRKbijZGcdGVg==
X-Received: by 10.36.89.73 with SMTP id p70mr6372620itb.23.1512756705503;
        Fri, 08 Dec 2017 10:11:45 -0800 (PST)
Received: from google.com ([2620:0:100e:422:949a:89bd:af08:7a9c])
        by smtp.gmail.com with ESMTPSA id f202sm1009651itc.40.2017.12.08.10.11.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Dec 2017 10:11:44 -0800 (PST)
Date:   Fri, 8 Dec 2017 10:11:43 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [WIP 02/15] pkt-line: introduce struct packet_reader
Message-ID: <20171208181143.GG152943@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
 <20171204235823.63299-3-bmwill@google.com>
 <CAGZ79kY5dCo1qO-4W=xdZQMjoJs1ZqJdywUsqX0CjyXHu80hCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY5dCo1qO-4W=xdZQMjoJs1ZqJdywUsqX0CjyXHu80hCw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Stefan Beller wrote:
> On Mon, Dec 4, 2017 at 3:58 PM, Brandon Williams <bmwill@google.com> wrote:
> > Sometimes it is advantageous to be able to peek the next packet line
> > without consuming it (e.g. to be able to determine the protocol version
> > a server is speaking).  In order to do that introduce 'struct
> > packet_reader' which is an abstraction around the normal packet reading
> > logic.  This enables a caller to be able to peek a single line at a time
> > using 'packet_reader_peek()' and having a caller consume a line by
> > calling 'packet_reader_read()'.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  pkt-line.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  pkt-line.h | 20 ++++++++++++++++++++
> >  2 files changed, 81 insertions(+)
> >
> > diff --git a/pkt-line.c b/pkt-line.c
> > index ac619f05b..518109bbe 100644
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -406,3 +406,64 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
> >         }
> >         return sb_out->len - orig_len;
> >  }
> > +
> > +/* Packet Reader Functions */
> > +void packet_reader_init(struct packet_reader *reader, int fd,
> > +                       char *src_buffer, size_t src_len)
> > +{
> > +       reader->fd = fd;
> > +       reader->src_buffer = src_buffer;
> > +       reader->src_len = src_len;
> > +       reader->buffer = packet_buffer;
> > +       reader->buffer_size = sizeof(packet_buffer);
> > +       reader->options = PACKET_READ_CHOMP_NEWLINE | PACKET_READ_GENTLE_ON_EOF;
> 
> I assume the future user of this packet reader will need exactly
> these options coincidentally. ;)
> 
> I think it might be ok for now and later we can extend the reader if needed
> to also take the flags as args. However given this set of args, this is a gentle
> packet reader, as it corresponds to the _gently version of reading
> packets AFAICT.
> 
> Unlike the pkt_read function this constructor of a packet reader doesn't need
> the arguments for its buffer (packet_buffer and sizeof thereof), which
> packet_read
> unfortunately needs. We pass in packet_buffer all the time except in
> builtin/receive-pack
> for obtaining the gpg cert. I think that's ok here.

Yeah, all of the callers I wanted to migrate all passed the same flags
and same buffer.  I figured there may be a point in the future where
we'd want to extend this so instead of hard coding the flags in the read
functions, I did so in the constructor.  That way if we wanted to extend
it in the future, it would be a little bit easier.

> 
> > +enum packet_read_status packet_reader_read(struct packet_reader *reader)
> > +{
> > +       if (reader->line_peeked) {
> > +               reader->line_peeked = 0;
> > +               return reader->status;
> > +       }
> > +
> > +       reader->status = packet_read_with_status(reader->fd,
> > +                                                &reader->src_buffer,
> > +                                                &reader->src_len,
> > +                                                reader->buffer,
> > +                                                reader->buffer_size,
> > +                                                &reader->pktlen,
> > +                                                reader->options);
> > +
> > +       switch (reader->status) {
> > +       case PACKET_READ_ERROR:
> > +               reader->pktlen = -1;
> 
> In case of error the read function might not
> have assigned the pktlen as requested, so we assign
> it to -1/NULL here. Though the caller ought to already know
> that they handle bogus, as the state is surely the first thing
> they'd inspect?

Exactly, I thought it would be easier to ensure that pktlen and line
were had consistent state no matter what the output of the read was.
But yes, callers should be looking at the status to determine what to
do.

> 
> > +               reader->line = NULL;
> > +               break;
> > +       case PACKET_READ_NORMAL:
> > +               reader->line = reader->buffer;
> > +               break;
> > +       case PACKET_READ_FLUSH:
> > +               reader->pktlen = 0;
> > +               reader->line = NULL;
> > +               break;
> > +       }
> 
> Oh, this gives an interesting interface for someone who is
> just inspecting the len/line instead of the state, so it might be
> worth keeping it this way.
> 
> Can we have an API documentation in the header file,
> explaining what to expect in each field given the state
> of the (read, peaked) packet?

Yep I can write some better API docs for these functions.

-- 
Brandon Williams
