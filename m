Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0BE81F404
	for <e@80x24.org>; Tue, 27 Feb 2018 18:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeB0SOc (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:14:32 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33133 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeB0SOb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:14:31 -0500
Received: by mail-pf0-f173.google.com with SMTP id q13so8282882pff.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wNNYUl9jk6xUK/yVdHw31hwgwoH8aVDtPRdvt2UmpC8=;
        b=IMbPXvErhAkNlyiD2nxT/CVECHQfHLP28b5iZ9vbIiY4QLyxzMeSKPuuXELqNn4LLk
         WeuTKo9nRi5LY6EtmFhobE1N6iQSAddbbCp0DCXH31BsHP7Tuj+aWOVof3pDIH51e67S
         r5LhcUFqL6Je8ISnBhSgztTl6V5Qpsdzj6JSuN3pCrO2N6hfFmGXrUXBrgf6d7UxFfDU
         N4z5vLitnYjCFxpPI3TyzcyS52Hzkdl8Mj3ZrJCmyPEd7SkX6aQd2z2HITJnBpUpZRPF
         RYp17+VukAdx/Fw1MmvTXnovu+G7hd1woZgvGiqlEotRq+7nxmaX5Pavo2yK7bKEE9fe
         0FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wNNYUl9jk6xUK/yVdHw31hwgwoH8aVDtPRdvt2UmpC8=;
        b=pA/V31RkPSyPK5Lc78Tl9ivnpY8hGoqffGwE45q0qI3uQNtypaZseeR/m6dPj+p68N
         8r6FhIgG9k6j6MxuilJFQgqSc5w3PUzkKezBl2FZTaVgcKIg9YVq9naob1f4Bz4eTUY3
         EYe1UfN686qNbxLUjEScEvLTJ0TCOkGjxVSIN0ZxoLmJ6sqLpjYr5WdhXW2bmUDDYpZh
         p8os15emmKdb2TDYpC8SJjVJHbWRyGNvL4UFL6J0ksk2TQjMWSPXSSN5VaK4ClqIitq0
         uSOA8cjmALF1WqWdNjMy5ZOzPL/EwJfrAEmJNmYvxmyESxn2GGWbTVacQgG3UgCi/7jw
         CZAA==
X-Gm-Message-State: APf1xPAwJRBy5WKCWl4xQziDvuQiCVJPvNMk8OiJWKsg1NRFP1eJRaoK
        mqzFIr330xZvLbD6Wz/MEcOb66Mt4oU=
X-Google-Smtp-Source: AH8x227U/toORA92156QnWYcJMPS8w+wCnFTAZoYIQ0vLFOmwGdMh60XOXSFNz3eTbp8I1qQDFtgsw==
X-Received: by 10.99.109.79 with SMTP id i76mr11571241pgc.402.1519755270844;
        Tue, 27 Feb 2018 10:14:30 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p9sm21814193pff.173.2018.02.27.10.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 10:14:29 -0800 (PST)
Date:   Tue, 27 Feb 2018 10:14:28 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 02/35] pkt-line: introduce struct packet_reader
Message-ID: <20180227181428.GB209668@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-3-bmwill@google.com>
 <20180213004937.GB42272@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213004937.GB42272@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/12, Jonathan Nieder wrote:
> [...]
> > --- a/pkt-line.h
> > +++ b/pkt-line.h
> > @@ -111,6 +111,64 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
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
> 
> Can or should this be a strbuf?
> 
> > +
> > +	/* buffer that pkt-lines are read into and its size */
> > +	char *buffer;
> > +	unsigned buffer_size;
> 
> Likewise.
> 

This struct is setup to be a drop in replacement for the existing
read_packet() family of functions.  Because of this I tried to make the
interface as similar as possible to make it easy to convert to using it
as well as having no need to clean anything up (because the struct is
really just a wrapper and doesn't own anything).

-- 
Brandon Williams
