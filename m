Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B4620954
	for <e@80x24.org>; Thu,  7 Dec 2017 22:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbdLGWCB (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 17:02:01 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:44105 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbdLGWCA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 17:02:00 -0500
Received: by mail-qt0-f174.google.com with SMTP id m59so21495908qte.11
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 14:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tfs1qBYPQXC29s7Qmxc0WFIB7SQtHQy0bpTxKmhszTs=;
        b=fMboKzu8g26jfT6KHSQNlfC5a/6joQBzh/R9YnCiPPXi6K5b03y5e7nKmETcZvmKKT
         n8U42Lc47hvkZwi2QYhNlUOkvL5tKk7MzOIMQIVHpcB2owYj6XxBCa1hF3HNRLV7dDxQ
         XYLuUj9FjlY+y5q01VCfeCsMhMrsEMHoXb5quKAtaBw9zRUZ8XioK6oe4hFZ6lULUPbq
         CqrMfG1bJnJOSHZWkI3ayu1NamtO7lvwp18uD17X3htBF+68YL2KvUzzoG9zn39nCIKw
         Z/NjS7JB9X2XjnHt2B9SElut9oa64ZPrAz04dKrfOheVl8t4RUb1BtnEf7Ei3EgNG1yE
         3/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tfs1qBYPQXC29s7Qmxc0WFIB7SQtHQy0bpTxKmhszTs=;
        b=HZanVwMKXTpwhkh3p7gkbea0pU9BLKzIRBpzJWOCZpCy4VVplBSyxNZv7CgwGcNFY3
         OB4/0Ks1caKXHzgSSVz/VlCsBluEAmtnRU3xVVoqI1BkuwpydfRL63LummJVnazKUJ4y
         bXS3sQ9jk6+O+ugfH/VTzy1JblIwbCymd43DWIK2fAcjxOqIDGHhCyN4grKi+lwwnKvP
         gkPjqphRlcHXgjnTrhrTh5ObFZysjHZmvcSf0mvHqOMJqPVg1NHDyqPwMuMC5swU6dZ9
         or2L5jPnEzMilxC4Pnfxu3Rb41AEHTwDf/dlBSW+5a4MIpl85BOb52ZcRWxx1us9JVg3
         6eMw==
X-Gm-Message-State: AKGB3mLpH30ywGoIxJNnGf6iByhB+2Ik1f4QBJsfPpXOIL9ReETHAfVl
        OmvtPUnlVKbyjfw3b7MktdwGq8o5W2DWonF04g1lkWjr2vA=
X-Google-Smtp-Source: AGs4zMZhxE8ttqcm56pPgmF22VIoB4gtkBxbcukeQNbCFoIFDpAkUB5oYc3Zkl9cz/QyhpgfBCtitpWHzsrpS2x9XuE=
X-Received: by 10.200.36.105 with SMTP id d38mr12456120qtd.180.1512684119302;
 Thu, 07 Dec 2017 14:01:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 7 Dec 2017 14:01:58 -0800 (PST)
In-Reply-To: <20171204235823.63299-3-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com> <20171204235823.63299-1-bmwill@google.com>
 <20171204235823.63299-3-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 7 Dec 2017 14:01:58 -0800
Message-ID: <CAGZ79kY5dCo1qO-4W=xdZQMjoJs1ZqJdywUsqX0CjyXHu80hCw@mail.gmail.com>
Subject: Re: [WIP 02/15] pkt-line: introduce struct packet_reader
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 4, 2017 at 3:58 PM, Brandon Williams <bmwill@google.com> wrote:
> Sometimes it is advantageous to be able to peek the next packet line
> without consuming it (e.g. to be able to determine the protocol version
> a server is speaking).  In order to do that introduce 'struct
> packet_reader' which is an abstraction around the normal packet reading
> logic.  This enables a caller to be able to peek a single line at a time
> using 'packet_reader_peek()' and having a caller consume a line by
> calling 'packet_reader_read()'.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  pkt-line.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  pkt-line.h | 20 ++++++++++++++++++++
>  2 files changed, 81 insertions(+)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index ac619f05b..518109bbe 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -406,3 +406,64 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
>         }
>         return sb_out->len - orig_len;
>  }
> +
> +/* Packet Reader Functions */
> +void packet_reader_init(struct packet_reader *reader, int fd,
> +                       char *src_buffer, size_t src_len)
> +{
> +       reader->fd = fd;
> +       reader->src_buffer = src_buffer;
> +       reader->src_len = src_len;
> +       reader->buffer = packet_buffer;
> +       reader->buffer_size = sizeof(packet_buffer);
> +       reader->options = PACKET_READ_CHOMP_NEWLINE | PACKET_READ_GENTLE_ON_EOF;

I assume the future user of this packet reader will need exactly
these options coincidentally. ;)

I think it might be ok for now and later we can extend the reader if needed
to also take the flags as args. However given this set of args, this is a gentle
packet reader, as it corresponds to the _gently version of reading
packets AFAICT.

Unlike the pkt_read function this constructor of a packet reader doesn't need
the arguments for its buffer (packet_buffer and sizeof thereof), which
packet_read
unfortunately needs. We pass in packet_buffer all the time except in
builtin/receive-pack
for obtaining the gpg cert. I think that's ok here.

> +enum packet_read_status packet_reader_read(struct packet_reader *reader)
> +{
> +       if (reader->line_peeked) {
> +               reader->line_peeked = 0;
> +               return reader->status;
> +       }
> +
> +       reader->status = packet_read_with_status(reader->fd,
> +                                                &reader->src_buffer,
> +                                                &reader->src_len,
> +                                                reader->buffer,
> +                                                reader->buffer_size,
> +                                                &reader->pktlen,
> +                                                reader->options);
> +
> +       switch (reader->status) {
> +       case PACKET_READ_ERROR:
> +               reader->pktlen = -1;

In case of error the read function might not
have assigned the pktlen as requested, so we assign
it to -1/NULL here. Though the caller ought to already know
that they handle bogus, as the state is surely the first thing
they'd inspect?

> +               reader->line = NULL;
> +               break;
> +       case PACKET_READ_NORMAL:
> +               reader->line = reader->buffer;
> +               break;
> +       case PACKET_READ_FLUSH:
> +               reader->pktlen = 0;
> +               reader->line = NULL;
> +               break;
> +       }

Oh, this gives an interesting interface for someone who is
just inspecting the len/line instead of the state, so it might be
worth keeping it this way.

Can we have an API documentation in the header file,
explaining what to expect in each field given the state
of the (read, peaked) packet?
