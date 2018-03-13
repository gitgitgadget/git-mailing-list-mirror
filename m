Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22FE91FAE3
	for <e@80x24.org>; Tue, 13 Mar 2018 16:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933550AbeCMQau (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 12:30:50 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34739 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbeCMQar (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 12:30:47 -0400
Received: by mail-pg0-f52.google.com with SMTP id m15so86825pgc.1
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Es5itXFrwK7IYlHD3O8CHwbgkAYsra1xjyLLOZKFhxc=;
        b=Y6s3IPVAHuc9RV1SusNDwEwj+JKDZ9ph66Cj++L6eblaDkeD9Uh90eI5Bi1Z2oISqD
         GGozjn+9lq4TNIIyzJXeCbadMs4ABeORypyNUAvBeJNZJw0j7FA03zYN2dEZpX+doSp1
         lyoji+ezlub6CAD7MB0JO65l3/WpCbq2jeo9e7HuL8UWyquaAy0WMVQhE/IwC7bt2VY1
         AbcQaTJSChd/7HE/9cQd+5LxdX0JzKMbV0mubV1rhBarTZOFjbi9HIWgF7a7HmljEwdV
         oQfdDEmpnndztvgSU9GfBOkZM2U7BFNb3KqUbNMMwx//K7k6f5LiFZWYulXfXQ+7bgTF
         m+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Es5itXFrwK7IYlHD3O8CHwbgkAYsra1xjyLLOZKFhxc=;
        b=Gk1Kf2xg5mylt8B8NBHvmP6SnvmC52Wi5Rs38H9HeDoS20AXaaagChog5rHrnPKQr0
         earSgtcHqrclrJ7bbB+ejTVi5JJlOLlO3xRT5dh8PI8uow3Caz9qe5noyYd38ilohb2g
         kiNHn63aYgkS7bkAJF/Shhi/ZIUqbSytXJ/PLQbAtjyQzWusW3trUNjv+6Mdjc8136lo
         caEuhelBGYD3vjk1iai5CH/6A4XJ1a3hatkglHJF/QtKf/2EymC/OfDbEZKjNb3C4c3g
         odpT/L+bvKT2lCkFXm0ZMXh5+PP5vTZsjLAW5lUYTltdnFMlMAVCDZ/4xgt7l4MKMT8I
         WUsw==
X-Gm-Message-State: AElRT7Giz527IK7M7ICcdyF9Ia6DhYYNvBU8d3Qqc8Xys7zra0d8rxPb
        dPII2ZSn58Fuf1Dhqws/eVAWcA==
X-Google-Smtp-Source: AG47ELs5cLBdOXDTiAEpJ6Xw9rvxVTkJ9yERvtDJHA5nYpiKbSoh4zdRdPFiG9+IymBQxNyES1t0dQ==
X-Received: by 10.98.204.69 with SMTP id a66mr1189176pfg.33.1520958646841;
        Tue, 13 Mar 2018 09:30:46 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id p23sm972223pgv.11.2018.03.13.09.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 09:30:45 -0700 (PDT)
Date:   Tue, 13 Mar 2018 09:30:44 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 27/35] transport-helper: introduce stateless-connect
Message-Id: <20180313093044.69af995505d0508f8a044bff@google.com>
In-Reply-To: <20180228232252.102167-28-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-28-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Feb 2018 15:22:44 -0800
Brandon Williams <bmwill@google.com> wrote:

> +'stateless-connect'::
> +	Experimental; for internal use only.
> +	Can attempt to connect to a remote server for communication
> +	using git's wire-protocol version 2.  This establishes a
> +	stateless, half-duplex connection.
> ++
> +Supported commands: 'stateless-connect'.
> +
>  'push'::
>  	Can discover remote refs and push local commits and the
>  	history leading up to them to new or existing remote refs.
> @@ -136,6 +144,14 @@ Capabilities for Fetching
>  +
>  Supported commands: 'connect'.
>  
> +'stateless-connect'::
> +	Experimental; for internal use only.
> +	Can attempt to connect to a remote server for communication
> +	using git's wire-protocol version 2.  This establishes a
> +	stateless, half-duplex connection.
> ++
> +Supported commands: 'stateless-connect'.

I don't think we should use the term "half-duplex" - from a search, it
means that both parties can use the wire but not simultaneously, which
is not strictly true. Might be better to just say "see the documentation
for the stateless-connect command for more information".

> +'stateless-connect' <service>::
> +	Experimental; for internal use only.
> +	Connects to the given remote service for communication using
> +	git's wire-protocol version 2.  This establishes a stateless,
> +	half-duplex connection.  Valid replies to this command are empty
> +	line (connection established), 'fallback' (no smart transport
> +	support, fall back to dumb transports) and just exiting with
> +	error message printed (can't connect, don't bother trying to
> +	fall back).  After line feed terminating the positive (empty)
> +	response, the output of the service starts.  Messages (both
> +	request and response) must be terminated with a single flush
> +	packet, allowing the remote helper to properly act as a proxy.
> +	After the connection ends, the remote helper exits.
> ++
> +Supported if the helper has the "stateless-connect" capability.

I'm not sure of the relevance of "allowing the remote helper to properly
act as a proxy" - this scheme does make it easier to implement proxies,
not for any party to start acting as one instead. I would write that
part as:

    Messages (both request and response) must consist of zero or more
    PKT-LINEs, terminating in a flush packet. The client must not expect
    the server to store any state in between request-response pairs.

(This covers the so-called "half-duplex" part and the "stateless" part.)
