Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745BD1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 19:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeCMTfq (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 15:35:46 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:36066 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbeCMTfn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 15:35:43 -0400
Received: by mail-pl0-f49.google.com with SMTP id 61-v6so400943plf.3
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 12:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNvMIF8FESqGg2UpssV8vq/tUBIhsTDKPioaHYVpxPU=;
        b=jNhAkleM6gfvbwyzf/Jb6vPCObyOW1lPhu1fQVcvGXrls+2vPuA5vZ6Hd8Cj3EB3VD
         Nyq39ZsJnl8rxMx6/4Oe0fjPMcbREdeavcVhNtJmovCWFiIXnOFifgBke1SBoJohQ0rh
         RJWAJawibhBkktVeyrEAW6Bd+X2dwnSC056vJtQA4yeB+NZx0FqDiBAZdOTNHMIwLAWH
         y0eegtBLxRrKUwKm++VoqB+5XTSrSRk1l40aH8rB6F12oz/dobBEy34QTTHZcSDqddXO
         2NWPyd0WHf1NS0o7G15UdIMdRATTdpsmjjf0mzPrjOTjqjV37RgNOC1CudIxFg1rxrZZ
         ZwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNvMIF8FESqGg2UpssV8vq/tUBIhsTDKPioaHYVpxPU=;
        b=b7K1a/jpkcBriy58dKj1N17V5bbopTqNm263kzQk9EP1+DxUYdS+fMjSXvHgwVhF62
         KT/HyQl6xTI/uWpW1iSwbpdXyI0CgmDxahiwPkEFjZb7qFPX+GL+SE+3PDEUYtQEgJIL
         wjTLcOfPSCEuT0OPajIOoqtesXmK4Cl6NRn6Tvao7C3Nbcl07jqsSwjzSCvXzB2hqO9y
         LPgneZp2xV+bKmgbX4nP1WNLSmTQiPhPxUwE6RJE7laz8qSrMH5s9XbdUVQYr/h2QRcr
         HF/YMGqong4dcHw5yidPbY5bbsFZ+l421MT4VNIEYfpn6OWyB9ykIOjd8O69j2w8Ffy5
         CRCg==
X-Gm-Message-State: AElRT7HgcpgNQsNfMyNsjEqhO92LiuY7E9UBO9WXeHB6m4WGPZrsJ8+I
        WYVJRonPDnsBdfp3HsO+2jQyNA==
X-Google-Smtp-Source: AG47ELuoYpXOlZ8TTcc8Z9EOdSl87pRX221wfPCTOjIPuw0Xv+ccTIQ0n+wacJyLNnkQUGBVJuFRdA==
X-Received: by 2002:a17:902:464:: with SMTP id 91-v6mr1581603ple.126.1520969742735;
        Tue, 13 Mar 2018 12:35:42 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id q76sm1655695pfj.149.2018.03.13.12.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 12:35:41 -0700 (PDT)
Date:   Tue, 13 Mar 2018 12:35:40 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 01/35] pkt-line: introduce packet_read_with_status
Message-Id: <20180313123540.d6e416220329bdc172472dc6@google.com>
In-Reply-To: <20180228232252.102167-2-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-2-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Feb 2018 15:22:18 -0800
Brandon Williams <bmwill@google.com> wrote:

> +	if (len < 0) {
>  		die("protocol error: bad line length character: %.4s", linelen);
> -	if (!len) {
> +	} else if (!len) {
>  		packet_trace("0000", 4, 0);
> -		return 0;
> +		return PACKET_READ_FLUSH;
> +	} else if (len < 4) {
> +		die("protocol error: bad line length %d", len);
>  	}
> +
>  	len -= 4;
> -	if (len >= size)
> +	if ((unsigned)len >= size)
>  		die("protocol error: bad line length %d", len);

The cast to unsigned is safe, since len was at least 4 before "len -=
4". I can't think of a better way to write this to make that more
obvious, though.

> +/*
> + * Read a packetized line into a buffer like the 'packet_read()' function but
> + * returns an 'enum packet_read_status' which indicates the status of the read.
> + * The number of bytes read will be assigined to *pktlen if the status of the
> + * read was 'PACKET_READ_NORMAL'.
> + */
> +enum packet_read_status {
> +	PACKET_READ_EOF = -1,
> +	PACKET_READ_NORMAL,
> +	PACKET_READ_FLUSH,
> +};
> +enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
> +						size_t *src_len, char *buffer,
> +						unsigned size, int *pktlen,
> +						int options);

jrnieder said in [1], referring to the definition of enum
packet_read_status:

> nit: do any callers treat the return value as a number?  It would be
> less magical if the numbering were left to the compiler (0, 1, 2).

I checked the result of the entire patch set and the only callers seem
to be packet_read() (modified in this patch) and the
soon-to-be-introduced packet_reader_read(). So not only can the
numbering be left to the compiler, this function can (and should) be
marked static as well (and the enum definition moved to .c), since I
think that future development should be encouraged to use packet_reader.

The commit message would also thus need to be rewritten, since this
becomes more of a refactoring into a function with a more precisely
specified return type, to be used both by the existing packet_read() and
a soon-to-be-introduced packet_reader_read().

[1] https://public-inbox.org/git/20180213002554.GA42272@aiede.svl.corp.google.com/
