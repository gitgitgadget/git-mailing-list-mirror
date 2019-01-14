Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE75211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 20:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfANUHm (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 15:07:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42976 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfANUHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 15:07:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so321675wrx.9
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 12:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=c4WYkSO/QxEBZUY12hSswg5BPYE9ljMpHKo+zpD7CAM=;
        b=rJx4O/FnLyP6L+xUHpDsdv7MVYdoyE1IlAk+aFGm7q7WuaX/l5h+2dWqWc6SPJKnyX
         oYrGJaEMRZnCu0OA1UrdmKtL7qLdAEyykZGUdgkhwWhlDsIwWnT81iK/P2nTzcBYqA7S
         DbUhoEE1l1Y138oQOLtHiHlEeBkVe8y93aZtCZlsE3yf5lbG/sPeZ0WuM8NL0sQP4tdd
         kxm0NhEmRNTntKAx0/mQf5LTtlekvAYmGqWd5LA4SaO0W6J7ovF1UFcMzZG0XxuC5Hdn
         HnFPNuQuKmISUD1cOVEMKoLiWEb+OXFkmlXR/CES75gd+q1qki5P+xI405u+Aa+oYH3m
         HKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=c4WYkSO/QxEBZUY12hSswg5BPYE9ljMpHKo+zpD7CAM=;
        b=OEYZ9lxShqZblPo5YeDeh7AimBVUHnGb1GrIPeFGK24DtRTNCgLDrv8irwZIbDa6Kh
         KHm0jLuZ0ffhcHV8X8WTkT1WwhKDwfcIE1ap+jzu+nNCCSUHpiMPnqBlsccbhxgVjRel
         v5AJOxtI1hl8qZNk+/f2lLKYIERGv90dvn4w53V+pZnN/enAOWXH/0X0myn6qlHvFGao
         t/jst8WPmf1ih1YX9BQ6EGAMSaaiX3bfw/vGY8FuLKS53yZnzbSmjdC8Kgic1lsUzsbo
         Wlyt/tzKxBuD9hE3MuelqG10PXNbEGBQyP2YrxD5jotLjYTryxCmCsyDog9O3Sb6dEiN
         PjIg==
X-Gm-Message-State: AJcUukceVF2tTUBUV3JSlsVYPKylPpygxdVAn8/Se0h4AOaV4gDmNkIk
        onLMnMUwyw+XM2JnsaKtPDh4kh1L
X-Google-Smtp-Source: ALg8bN5W/J017bAWUq2uI7MfJJTeN8Zzxj3qdubIc2LnTG2HW+raU7boGNmDUQS2QFa0MSOEhf5ppA==
X-Received: by 2002:adf:fd50:: with SMTP id h16mr127177wrs.231.1547496459134;
        Mon, 14 Jan 2019 12:07:39 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f130sm27931813wme.41.2019.01.14.12.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:07:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] sideband: reverse its dependency on pkt-line
References: <cover.1547244620.git.jonathantanmy@google.com>
        <4079a1f110086bd412fb4f56bc8b7f8a6a7a8f9f.1547244620.git.jonathantanmy@google.com>
Date:   Mon, 14 Jan 2019 12:07:38 -0800
Message-ID: <xmqq4labuho5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +int recv_sideband(const char *me, int in_stream, int out)
> +{
> +	char buf[LARGE_PACKET_MAX + 1];
> +	int retval = 0;
> +	int len;
> +
> +	while (1) {
> +		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
> +		retval = diagnose_sideband(me, buf, len);

This name of the helper does not convey much useful information.
Let's think about it more later.

> +		switch (retval) {
> +			case SIDEBAND_PRIMARY:

Dedent; case/default arms align with 's' in switch in our codebase.

> +				write_or_die(out, buf + 1, len - 1);
> +				break;

OK, so PRIMARY return (band#1) gives us the payload unwrapped back
in "out" and we are responsible for writing it out here.

> +			case SIDEBAND_PROGRESS:
> +				/* already written by diagnose_sideband() */

True, that happens in "switch(band) { case 2: }" in the other helper.

> +				break;
> +			default: /* flush or error */
> +				return retval;

Lack of corresponding comment bothers readers.  In all of
REMOTE_ERROR, PROGRESS and PROTOCOL_ERROR cases, the other helper
stuffs the message in outbuf in "switch (band) { ... }" and writes
it out with xwrite(2, outbuf.buf, outbuf.len) [*1*], so I can see
there is no need for us to write anything out here.  Perhaps

		case SIDEBAND_FLUSH:
		default: /* errors: message already written */
			return retval;

or something to clarify?


> +/*
> + * Receive multiplexed output stream over git native protocol.
> + * in_stream is the input stream from the remote, which carries data
> + * in pkt_line format with band designator.  Demultiplex it into out
> + * and err and return error appropriately.  Band #1 carries the
> + * primary payload.  Things coming over band #2 is not necessarily
> + * error; they are usually informative message on the standard error
> + * stream, aka "verbose").  A message over band #3 is a signal that
> + * the remote died unexpectedly.  A flush() concludes the stream.
> + *
> + * Returns SIDEBAND_FLUSH upon a normal conclusion, and SIDEBAND_PROTOCOL_ERROR
> + * or SIDEBAND_REMOTE_ERROR if an error occurred.
> + */
> +int recv_sideband(const char *me, int in_stream, int out);

This is well described.

> diff --git a/sideband.c b/sideband.c
> index 368647acf8..842a92e975 100644
> --- a/sideband.c
> +++ b/sideband.c
> ...
> +int diagnose_sideband(const char *me, char *buf, int len)
>  {
> +	static const char *suffix;
>  	struct strbuf outbuf = STRBUF_INIT;
>  	int retval = 0;
> +	const char *b, *brk;
> +	int band;
> +
> +	if (!suffix) {
> +		if (isatty(2) && !is_terminal_dumb())
> +			suffix = ANSI_SUFFIX;
> +		else
> +			suffix = DUMB_SUFFIX;
> +	}

It may be worth considering a further clean-up for the progress
code, that consumes lines in the "switch(band)" below that are
disproportionate to what it does in this function by introducing
another helper function that is called from here.  When it happens,
the above "suffix" thing should move to the helper function, too.

> +	if (len == 0) {
> +		retval = SIDEBAND_FLUSH;
> +		goto cleanup;
> +	}
> +	if (len < 1) {
> +		strbuf_addf(&outbuf,
> +			    "%s%s: protocol error: no band designator",
> +			    outbuf.len ? "\n" : "", me);
> +		retval = SIDEBAND_PROTOCOL_ERROR;
> +		goto cleanup;
> +	}
> +	band = buf[0] & 0xff;
> +	buf[len] = '\0';
> +	len--;
> +	switch (band) {
> +	case 3:
> +...
> +	case 2:
> +...
> +	case 1:
> +		retval = SIDEBAND_PRIMARY;
> +		break;
> +	default:
> +		strbuf_addf(&outbuf, "%s%s: protocol error: bad band #%d",
> +			    outbuf.len ? "\n" : "", me, band);
> +		retval = SIDEBAND_PROTOCOL_ERROR;
> +		break;

So, the point of this helper is to inspect a single packet-line data
and dispatch the payload of the packet based on which band it is
sent to.  Perhaps call it with a name with demultiplex or dispatch
in it?  "diagnose" is a bit unclear in that what trait you are
diagnosing and for what purpose.

> diff --git a/sideband.h b/sideband.h
> index 7a8146f161..a56cd86287 100644
> --- a/sideband.h
> +++ b/sideband.h
> @@ -3,8 +3,21 @@
>  
>  #define SIDEBAND_PROTOCOL_ERROR -2
>  #define SIDEBAND_REMOTE_ERROR -1
> +#define SIDEBAND_FLUSH 0
> +#define SIDEBAND_PRIMARY 1
> +#define SIDEBAND_PROGRESS 2
> +
> +/*
> + * buf and len should be the result of reading a line from a remote sending
> + * multiplexed data.
> + *
> + * Determines the nature of the result and returns it. If

"the result" may be from the point of view of the implementor or the
"recv_sideband()" function who called packet_read(), but a casual
reader would perceive it more natural if you referred it as "a
packet read from a remote".  "Inspect a packet read from the remote
and returns which sideband it is for", perhaps?


> + * SIDEBAND_PROTOCOL_ERROR, SIDEBAND_REMOTE_ERROR, or SIDEBAND_PROGRESS, also
> + * prints a message (or the formatted contents of the notice in the case of
> + * SIDEBAND_PROGRESS) to stderr.
> + */
> +int diagnose_sideband(const char *me, char *buf, int len);
>  
> -int recv_sideband(const char *me, int in_stream, int out);
>  void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
>  
>  #endif
