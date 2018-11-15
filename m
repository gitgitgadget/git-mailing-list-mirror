Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2F31F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 21:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbeKPIBf (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 03:01:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34059 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeKPIBe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 03:01:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id f12-v6so10115748plo.1
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 13:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xXuqs+lAs+KQJbidENYRHC9ngDtZUACiocCpnDtvV+o=;
        b=UvOjBeC4ZbJBFZRdiQi7a8eDvtNMFd5x+WazcmDwakPi6fg3peY8ldEQWt+0PT18xm
         S+14T51u5yjIkSqQM8Pcbl7sjiS+ORYU+PdPlmIINYzrHnG8MEmVLUH9TTgCdoWXltgN
         rzsyWOuqFra4T6TWE3dorXZY901JfkywL6bEJre4nHTJ0rdjEF0ZB7YQe4vMbRcRDxaW
         JCnN76oZDbutxY7Jp5iH++C47UyArFxlBY4GBu0o9dKvNhyso237mv+f/6WfdzN37N6J
         pFw8Myq4n5TJ8LV5klaens+iYIqR1/U/F+60be4TZB9MfN4/bdIrQjL2uELcFUzBRHh4
         p64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xXuqs+lAs+KQJbidENYRHC9ngDtZUACiocCpnDtvV+o=;
        b=oTNIDYgWpdxLP7RsbWBtTZi1iXgSetJxV9Ws/oegw56czpQgeJDVMYUlwrYnU7fMTY
         /jcUBd373n0zCC5ZOTST+YWS4udebLAHZ+sdkxDdTVDJlFEfBO6BehRyIkQ02ghGUTvK
         Jrbyt70ondPWssXsgUpaKJ8GyDUtpzPgL0NfVTiFWVq3Wxh7AskLF3I39CQhuPA3UNea
         Eejj+22rhBeiYkTiY72DnwZbDzge/GMHcn5NxHvI001v3BmVxy8TOmr8vx6ZmaeF+KII
         MeJ6X2PSPEsC3S8lvk8F6C9ODDxoaC1CbjK4sbjxzU03OT0maeYZS9vOXJALxfZ/rbkV
         maIw==
X-Gm-Message-State: AGRZ1gJK+NgX0vBNB1ILaZvbjcmg4dMXxe17g1BiMqYgiTOEJYPm4bIU
        ZDMlPKUESDobGLo1zZ5vv4LpVl3mIwcVUg==
X-Google-Smtp-Source: AJdET5e09HdOroC4l05h88zgG/CMpSd+lofem3epP5wC/Yo2ZdqNm8u9RbpKqLRxPKEgyVDDFd43Nw==
X-Received: by 2002:a17:902:3e3:: with SMTP id d90-v6mr8017204pld.118.1542318719121;
        Thu, 15 Nov 2018 13:51:59 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id d3sm38566002pgl.64.2018.11.15.13.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 13:51:57 -0800 (PST)
Date:   Thu, 15 Nov 2018 13:51:52 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: die on server-side errors
Message-ID: <20181115215152.GK126896@google.com>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
 <20181113142624.GA17128@sigill.intra.peff.net>
 <20181113222540.GE126896@google.com>
 <20181114004915.GA5059@sigill.intra.peff.net>
 <20181114070052.GA19904@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114070052.GA19904@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.14 02:00, Jeff King wrote:
> On Tue, Nov 13, 2018 at 07:49:15PM -0500, Jeff King wrote:
> 
> > Yes, the packet_read_line_buf() interface will both advance the buf
> > pointer and decrement the length.  So if we want to "peek", we have to
> > do so with a copy (there's a peek function if you use the packet_reader
> > interface, but that might be overkill here).
> > 
> > You can rewrite it like this, which is a pretty faithful conversion and
> > passes the tests (but see below).
> > [...]
> 
> Here's a version which is less faithful, but I think does sensible
> things in all cases, and is much easier to follow. I get a little
> nervous just because it tightens some cases, and one never knows if
> other implementations might be relying on the looseness. E.g.:
> 
>   - in the current code we'd still drop back to dumb http if the server
>     tells us "application/x-git-upload-pack" but the initial pktline
>     doesn't start with "#" (even though if it _does_ have "#" at
>     position 5 but isn't a valid pktline, we'd complain!)
> 
>   - right now the v2 protocol does not require the server to say
>     "application/x-git-upload-pack" for the content-type
> 
> This patch tightens both of those (I also made a few stylistic tweaks,
> and added the ERR condition to show where it would go). I dunno. Part of
> me sees this as a nice cleanup, but maybe it is better to just leave it
> alone. A lot of these behaviors are just how it happens to work now, and
> not part of the spec, but we don't know what might be relying on them.

At least according to the protocol-v2 and http-protocol docs, the
stricter behavior seems correct:

For the first point above, dumb servers should never use an
"application/x-git-*" content type (http-protocol.txt line 163-167).

For the second point, the docs require v2 servers to use
"application/x-git-*" content types. protocol-v2.txt lines 63-65 state
that v2 clients should make a smart http request, while
http-protocol.txt lines 247-252 state that a smart server's response
type must be "application/x-git-*".

Of course we don't know if other implementations follow the spec, but
ISTM that this patch at least doesn't contradict how we've promised the
protocols should work.

If no one has any objections, I'll include the diff below in v2. Thanks
for the help Jeff!

> diff --git a/remote-curl.c b/remote-curl.c
> index 762a55a75f..1adb96311b 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -330,9 +330,61 @@ static int get_protocol_http_header(enum protocol_version version,
>  	return 0;
>  }
>  
> +static void check_smart_http(struct discovery *d, const char *service,
> +			     struct strbuf *type)
> +{
> +	char *src_buf;
> +	size_t src_len;
> +	char *line;
> +	const char *p;
> +
> +	if (!skip_prefix(type->buf, "application/x-", &p) ||
> +	    !skip_prefix(p, service, &p) ||
> +	    strcmp(p, "-advertisement"))
> +		return;
> +
> +	/*
> +	 * We speculatively try to read a packet, which means we must preserve
> +	 * the original buf/len pair in some cases.
> +	 */
> +	src_buf = d->buf;
> +	src_len = d->len;
> +	line = packet_read_line_buf(&src_buf, &src_len, NULL);
> +	if (!line)
> +		die("invalid server response; expected service, got flush packet");
> +
> +	if (skip_prefix(line, "# service=", &p) && !strcmp(p, service)) {
> +		/*
> +		 * The header can include additional metadata lines, up
> +		 * until a packet flush marker.  Ignore these now, but
> +		 * in the future we might start to scan them.
> +		 */
> +		while (packet_read_line_buf(&src_buf, &src_len, NULL))
> +			;
> +
> +		/*
> +		 * v0 smart http; callers expect us to soak up the
> +		 * service and header packets
> +		 */
> +		d->buf = src_buf;
> +		d->len = src_len;
> +		d->proto_git = 1;
> +
> +	} else if (starts_with(line, "version 2")) { /* should be strcmp()? */
> +		/*
> +		 * v2 smart http; do not consume version packet, which will
> +		 * be handled elsewhere.
> +		 */
> +		d->proto_git = 1;
> +	} else if (skip_prefix(line, "ERR ", &p)) {
> +		die(_("remote error: %s"), p);
> +	} else {
> +		die("invalid server response; got '%s'", line);
> +	}
> +}
> +
>  static struct discovery *discover_refs(const char *service, int for_push)
>  {
> -	struct strbuf exp = STRBUF_INIT;
>  	struct strbuf type = STRBUF_INIT;
>  	struct strbuf charset = STRBUF_INIT;
>  	struct strbuf buffer = STRBUF_INIT;
> @@ -405,38 +457,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  	last->buf_alloc = strbuf_detach(&buffer, &last->len);
>  	last->buf = last->buf_alloc;
>  
> -	strbuf_addf(&exp, "application/x-%s-advertisement", service);
> -	if (maybe_smart &&
> -	    (5 <= last->len && last->buf[4] == '#') &&
> -	    !strbuf_cmp(&exp, &type)) {
> -		char *line;
> -
> -		/*
> -		 * smart HTTP response; validate that the service
> -		 * pkt-line matches our request.
> -		 */
> -		line = packet_read_line_buf(&last->buf, &last->len, NULL);
> -		if (!line)
> -			die("invalid server response; expected service, got flush packet");
> -
> -		strbuf_reset(&exp);
> -		strbuf_addf(&exp, "# service=%s", service);
> -		if (strcmp(line, exp.buf))
> -			die("invalid server response; got '%s'", line);
> -		strbuf_release(&exp);
> -
> -		/* The header can include additional metadata lines, up
> -		 * until a packet flush marker.  Ignore these now, but
> -		 * in the future we might start to scan them.
> -		 */
> -		while (packet_read_line_buf(&last->buf, &last->len, NULL))
> -			;
> -
> -		last->proto_git = 1;
> -	} else if (maybe_smart &&
> -		   last->len > 5 && starts_with(last->buf + 4, "version 2")) {
> -		last->proto_git = 1;
> -	}
> +	if (maybe_smart)
> +		check_smart_http(last, service, &type);
>  
>  	if (last->proto_git)
>  		last->refs = parse_git_refs(last, for_push);
> @@ -444,7 +466,6 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  		last->refs = parse_info_refs(last);
>  
>  	strbuf_release(&refs_url);
> -	strbuf_release(&exp);
>  	strbuf_release(&type);
>  	strbuf_release(&charset);
>  	strbuf_release(&effective_url);
