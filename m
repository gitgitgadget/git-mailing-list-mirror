Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2961F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934735AbeAISIR (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:08:17 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42150 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934729AbeAISIP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:08:15 -0500
Received: by mail-pg0-f66.google.com with SMTP id q67so8503502pga.9
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9zF7fxZX8xxhNeNlWYcHzlZ/gk/5vPwhe57YIwNQ87E=;
        b=YZM6rpPecFxGN7N2U+/NfFca9XBG+CLrmTdztf5IIOkOZlRNeVEMfs71MJ3vuhw91O
         QzSHt+7tjJMMGZJzexHxdx/xYDBOtkx0hMtPWWRb4uSksQUnNhW62fsBQzY7ggbN4zf+
         bHh7G+8GkvEDcEGt8d6qa0Wt4w1VuPPKLF6a7hm3+yRlxY9OOywjvZoAunuvYNw1OB9L
         oNlwkeZ6FZRyawzFISiteLHq95jEgwFkMCnrSfSgdIpPuKVeHWMTbT+QgbehOK+UEFdo
         5Ptq+GXlVF4aYhLQ5wom4HpSg+bgOwC7cymoJe3MCb+iITcVntaOEIRk5rbiwNOhFz8C
         CJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zF7fxZX8xxhNeNlWYcHzlZ/gk/5vPwhe57YIwNQ87E=;
        b=RIgTC/R0qCXVZZEXhz0JjRvEaSM/OOjlC9ZPEPYooFHMdi46G0U/2tDnrHZTvHVQKm
         UdVgnfW7rjLZyZ8uVag1/I4aS9jfcWqjke5rtbNuueLWq5K+grPMSn5GVRQxmKHvkmBK
         Ksu/WdqgH+uI8bnRKjBjsm2k5furmjKxVejgX/rbNeqry7wjyiSTaOVJ9vn8tuI6/RsZ
         +70p/ZiVJ7xc4Txd9gx6R9qH9sVT1jopOZCtwuPgdvc5n89Wf+xrWVmimnzLb1k09CF7
         QHtNFDyEJ8muYoy6ib1eZowKc2Ay7BPGc2S2LA5qcS8D/E43G8hUigsuoUCCoQKWrP5f
         ZN6Q==
X-Gm-Message-State: AKGB3mJt6lgAPqqPcPmDDS05QUXpYfVaGrEXQd9aVxY06cSUVbsWj4xJ
        p0v9R47J9eMgbJdfZHCfL9wehuZdQAU=
X-Google-Smtp-Source: ACJfBosYy+8XmUMwDuaE1OUv+glJBMiVNoYwFJZzLL7KX6SEDmTIdBarl9dcdGj324A2F0ebSMLRtQ==
X-Received: by 10.101.66.134 with SMTP id j6mr12522086pgp.56.1515521294337;
        Tue, 09 Jan 2018 10:08:14 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:592e:240e:24e2:56aa])
        by smtp.gmail.com with ESMTPSA id i186sm29502482pfg.178.2018.01.09.10.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 10:08:13 -0800 (PST)
Date:   Tue, 9 Jan 2018 10:08:13 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 02/26] pkt-line: introduce struct packet_reader
Message-Id: <20180109100813.054a6681900174ba73e30da5@google.com>
In-Reply-To: <20180103001828.205012-3-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
        <20180103001828.205012-3-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  2 Jan 2018 16:18:04 -0800
Brandon Williams <bmwill@google.com> wrote:

> diff --git a/pkt-line.h b/pkt-line.h
> index 06c468927..c446e886a 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -111,6 +111,63 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
>   */
>  ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
>  
> +struct packet_reader {
> +	/* source file descriptor */
> +	int fd;
> +
> +	/* source buffer and its size */
> +	char *src_buffer;
> +	size_t src_len;
> +
> +	/* buffer that pkt-lines are read into and its size */
> +	char *buffer;
> +	unsigned buffer_size;

Is the intention to support different buffers in the future?

[snip]

> +/*
> + * Peek the next packet line without consuming it and return the status.
> + * The next call to 'packet_reader_read()' will perform a read of the same line
> + * that was peeked, consuming the line.
> + *
> + * Only a single line can be peeked at a time.

It is logical to me that if you peeked at a line, and then peeked at it
again, you will get the same line - I would phrase this not as a
restriction ("only a single line") but just as a statement of fact (e.g.
"Peeking at the same line multiple times without an intervening
packet_reader_read will return the same result").

> + */
> +extern enum packet_read_status packet_reader_peek(struct packet_reader *reader);
> +
>  #define DEFAULT_PACKET_MAX 1000
>  #define LARGE_PACKET_MAX 65520
>  #define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
