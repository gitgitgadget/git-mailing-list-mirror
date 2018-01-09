Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E711F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933782AbeAITTI (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:19:08 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41681 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933255AbeAITTH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:19:07 -0500
Received: by mail-pf0-f196.google.com with SMTP id j3so5413171pfh.8
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P3WFsYaufvxOM/4Q2kYGnaCqR/2uEu7SPXi7PVFJMHQ=;
        b=bfHzOOO18QXcaw3PAyqVzpYeJvKiP0pcy6td5oYaIX1BkLTnENvNdc5D5QVYl8up5G
         CrdzdIVCreoNt5wb7uHttxfedkIGBYZD547Bs0ZenivLlpVK4/n8jRxYlhy6DbBqRAnE
         a9rFPDj0CpFDMRKZRjXEMNF95XzybKpRhMOVMJWxGUoaLjQ97e2Z2rX/o20n9bob/nPN
         K1STMH+nbFCm8b/ShlwQS+4MW4REKKgKKMDnAvwxnX8bV6q3luyXaF8dCj1ho49RCq8E
         6rHIGERIMyrE2XkxH3Rr51CHVG4L09VPSBnaTOSwEJRtBceeEu+EmcSY2r0rv439S9hv
         UZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P3WFsYaufvxOM/4Q2kYGnaCqR/2uEu7SPXi7PVFJMHQ=;
        b=CBy6V3CU7+EJW0wyABF48cPRItcJs5hF1jdSGWhNB7JP8mTApdMogJVdQJTJ3oHXa9
         jbJwGCoW4B2jTCUuBwBiUOhGIpCfVe86HxqjVLXyPFN55QzGhenXxdexqkjPzwfah02E
         6btjwD206EOf4wAH8amyt5nWRRgn5oorVbWo3whT15M88NXP+y5arv9AOgM2Vf/WRYOy
         fqK0bHNw3zKVPqef3cuTTxev2qEsFY+5WU6p4d/nXY66WwyzymHN/Knijv+23LgNxAVM
         bkyhWlSx5j7cJY7GEwJ1In1pzVqWf5RckGGi6BCsNQwYM5QRl6gccjJ7Fa6V7zad8t2q
         gpsQ==
X-Gm-Message-State: AKwxytd7DJE7aMjg3WygI4ZWQ2ds6okA62kgfMQbZinmflgnltJDwITC
        pPqI41OyJC4o5RY7iQ9yXNd/9DLu3Rg=
X-Google-Smtp-Source: ACJfBosEksIdIbF2mKSuRfWoIjC4w+ycTAH7QYdbXpl+ogFNnBbikxoXf5fLgqcN4zmiYcdF27wXwQ==
X-Received: by 10.98.224.205 with SMTP id d74mr2491944pfm.56.1515525546423;
        Tue, 09 Jan 2018 11:19:06 -0800 (PST)
Received: from google.com ([2620:0:100e:422:5de7:5b51:7854:d1a5])
        by smtp.gmail.com with ESMTPSA id e26sm29338353pfi.10.2018.01.09.11.19.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Jan 2018 11:19:05 -0800 (PST)
Date:   Tue, 9 Jan 2018 11:19:04 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 02/26] pkt-line: introduce struct packet_reader
Message-ID: <20180109191904.GC151395@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-3-bmwill@google.com>
 <20180109100813.054a6681900174ba73e30da5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109100813.054a6681900174ba73e30da5@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09, Jonathan Tan wrote:
> On Tue,  2 Jan 2018 16:18:04 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > diff --git a/pkt-line.h b/pkt-line.h
> > index 06c468927..c446e886a 100644
> > --- a/pkt-line.h
> > +++ b/pkt-line.h
> > @@ -111,6 +111,63 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
> >   */
> >  ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
> >  
> > +struct packet_reader {
> > +	/* source file descriptor */
> > +	int fd;
> > +
> > +	/* source buffer and its size */
> > +	char *src_buffer;
> > +	size_t src_len;
> > +
> > +	/* buffer that pkt-lines are read into and its size */
> > +	char *buffer;
> > +	unsigned buffer_size;
> 
> Is the intention to support different buffers in the future?

Potentially at some point.

> 
> [snip]
> 
> > +/*
> > + * Peek the next packet line without consuming it and return the status.
> > + * The next call to 'packet_reader_read()' will perform a read of the same line
> > + * that was peeked, consuming the line.
> > + *
> > + * Only a single line can be peeked at a time.
> 
> It is logical to me that if you peeked at a line, and then peeked at it
> again, you will get the same line - I would phrase this not as a
> restriction ("only a single line") but just as a statement of fact (e.g.
> "Peeking at the same line multiple times without an intervening
> packet_reader_read will return the same result").

Fair enough, i'll change the wording.

> 
> > + */
> > +extern enum packet_read_status packet_reader_peek(struct packet_reader *reader);
> > +
> >  #define DEFAULT_PACKET_MAX 1000
> >  #define LARGE_PACKET_MAX 65520
> >  #define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)

-- 
Brandon Williams
