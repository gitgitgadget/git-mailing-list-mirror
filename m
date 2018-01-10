Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9517E1F406
	for <e@80x24.org>; Wed, 10 Jan 2018 00:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755511AbeAJAFQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 19:05:16 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:39680 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbeAJAFP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 19:05:15 -0500
Received: by mail-pg0-f53.google.com with SMTP id z20so7019411pgv.6
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 16:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ErJuRBydo5R4bUmHBaA+tD3c0ZaounOBNqjBVn4VK+0=;
        b=Qu58HmBw5hQkA4+tQFg0DqCIIIRf9nQ7Xz+Pou0XI1DVJmlpKrjPr8e/Mxke2QqUQb
         PUMe9TALqfJG6GfzJ6Ane/fy3Nw54lbTv54i9yY+Jm/Ns7enGAh2NvvMNIGWz17rkIMj
         v37J5a1/fQyi1j0HZSLkBHyGdQYrk2s5iV0w/fTe5Rbs4zUvUm6l2M0LcUzoSGPNDcPa
         6cSQHKf+5OPrBH7s5INgHoHKpg+8fawydh74AxrFOWSfnEXVU8M/E/zLs4fTCXozDpi8
         hpwV41TcF5R8NzN/8f3RXk7bOOfSbMRE7DvvFZ4vcmhgJMB5iZI3r9G5ce5/xcl7mWc7
         UBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ErJuRBydo5R4bUmHBaA+tD3c0ZaounOBNqjBVn4VK+0=;
        b=iOd4pcNrUAxErCTDAsu6qvNgHp5295K9ucXYTTEeZjJj1IeG2495z0O1n0PykPviYE
         WmurXzCCWHhpvhMMWX3ZPcbyaNT0A+Lz0tOnjRIY8UW87r63pY7HncjXxkcdoLZDrX1h
         ++6+elq7h8Td6X9vp9SPZZILazXWCu3OnjSFKhx6udbKWLnZqwFh37GjisQwaeS8HZxh
         k5ShirHtqkmqDYd5HN26w35koagwmPdopcYZBq6DLsGsm0ghKl/1zQd5Y81vTi9KQ4VQ
         /cOgLHDYnOBJSKB1Coriy6pRazLUwD9/GfChiKZUwj8ac3lH9YVcq8UmxVL2o+n2E6Sr
         NAag==
X-Gm-Message-State: AKGB3mK1A4vHF1oZwYWBZi6ns7cUSG0zkxtfB05UOO5mt4sXMQ86qPqE
        62flAu4ku9ic/ZXY9yROrpaPwg==
X-Google-Smtp-Source: ACJfBourkx3pmk7hKEh82F6jPIT87HXZ5/XEUdSYsPIA9ZnvLBEfcc1pBCs6xwQVounHomYupj7raA==
X-Received: by 10.84.234.200 with SMTP id i8mr17645072plt.161.1515542714507;
        Tue, 09 Jan 2018 16:05:14 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:592e:240e:24e2:56aa])
        by smtp.gmail.com with ESMTPSA id r8sm28109383pgt.43.2018.01.09.16.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 16:05:13 -0800 (PST)
Date:   Tue, 9 Jan 2018 16:05:12 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 20/26] fetch-pack: perform a fetch using v2
Message-Id: <20180109160512.b3f12f45afd7121d25cf5fa4@google.com>
In-Reply-To: <20180103001828.205012-21-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
        <20180103001828.205012-21-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  2 Jan 2018 16:18:22 -0800
Brandon Williams <bmwill@google.com> wrote:

> +static enum ack_type process_ack(const char *line, struct object_id *oid)
> +{
> +	const char *arg;
> +
> +	if (!strcmp(line, "NAK"))
> +		return NAK;
> +	if (skip_prefix(line, "ACK ", &arg)) {
> +		if (!parse_oid_hex(arg, oid, &arg)) {
> +			if (strstr(arg, "continue"))
> +				return ACK_continue;

This function seems to be only used for v2, so I don't think we need to
parse "continue".

Also, maybe describe the plan for supporting functionality not supported
yet (e.g. server-side declaration of shallows and client-side "deepen").

It may be possible to delay support for server-side shallows on the
server (that is, only implement support for it in the client) since the
server can just declare that it doesn't support protocol v2 when serving
such repos (although it might just be easier to implement server-side
support in this case).

For "deepen", we need support for it both on the client and the server
now unless we plan to declare a "deepen" capability in the future (then,
as of these patches, clients that require "deepen" will use protocol v1;
when a new server declares "deepen", old clients will ignore it and keep
the status quo, and new clients can then use "deepen").

There may be others that I've missed.
