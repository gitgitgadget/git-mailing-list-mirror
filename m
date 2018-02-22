Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC0951F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBVABV (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:01:21 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45512 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBVABU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:01:20 -0500
Received: by mail-pl0-f66.google.com with SMTP id p5so1866913plo.12
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oz9JKQfytYihCsuOVE9GhtkRNTIqRPZC0ikTKS7emDQ=;
        b=rxR2IDoP0Gawspt70qQ3h33v8zWUZiWUxY0Y2OjNVL/OAOXxZ7ZIEvXFMxuWcNrq9D
         sXbB5H6vjj1sZV5Zx1rM2SwwWYuyVJlpGUgGoZHOCLtZDt4yPf6iUaNg8wRe5+WJmxlE
         Ko5vwhYfOhYMAFQItpeomAEbs2r3R4f9JgG3bk9SLoXZ/6DlZoqUV+8ox+QJu6Ktk/M8
         D35scRCkhlBNkYe5XXimsr9ronxvWZ9CqH1NoBa5pIPBh38otoYxo3u5oyxHrz5YNVAn
         0c371N45TTAqHeneSn6ZX/T6paG0fKGodlwXhekIWW4UZuM1LBc8GO7zGsUQqH/S+x+K
         +2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oz9JKQfytYihCsuOVE9GhtkRNTIqRPZC0ikTKS7emDQ=;
        b=g7qV+LbM6x1qoL3TR4KwW3bAkDEheKKDiGsSekhoYl96tt6h/b3Z5Sa+Bn7RyQMJMm
         xP+qGIXbvunRtw8o0TExtS4cSGVbLtH/d6r8AU+BMtyrJpkm+cJcUnv/eOkjI0dMWSg0
         os/cF0rLlkLg58c13/A6LCc2Z1LQS4trcuvRTSFWXSgAE5DKzkvEKbTnlgP9LxjVyRH8
         iKP8bmBgx1c1vqCB3/38uoa8bLTEcfqei+k8biDGR9nJ276rxf7rhh0HOHohTnwQGD/l
         zZyYpbXe0Xq6gJBYR31m2tEJEFeMfgwGoJxxYFmXTDi/CNgYgMewpOjoT5sx8/vN29dy
         YG4Q==
X-Gm-Message-State: APf1xPD0//L94TBHkuU3Jdai/kx5xvrnNfKfb02co8wWSXuRoszNmrtV
        Aldy24h9LtRbGsrbjd2zWlLFwo6VUDs=
X-Google-Smtp-Source: AH8x227+/1AWJ3PhpWLrQ4VNb0cXP7prfkrWJxLWipsCS1H4EyMgxswJHiraAFuxwOq8+EeXz+v7TA==
X-Received: by 2002:a17:902:8604:: with SMTP id f4-v6mr3862745plo.380.1519257678532;
        Wed, 21 Feb 2018 16:01:18 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id j126sm9642960pfc.166.2018.02.21.16.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:01:17 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:01:16 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 28/35] transport-helper: introduce stateless-connect
Message-Id: <20180221160116.1619fcc4ffa7e9c13a5ab9ba@google.com>
In-Reply-To: <20180207011312.189834-29-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-29-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:13:05 -0800
Brandon Williams <bmwill@google.com> wrote:

> Introduce the transport-helper capability 'stateless-connect'.  This
> capability indicates that the transport-helper can be requested to run
> the 'stateless-connect' command which should attempt to make a
> stateless connection with a remote end.  Once established, the
> connection can be used by the git client to communicate with
> the remote end natively in a stateless-rpc manner as supported by
> protocol v2.  This means that the client must send everything the server
> needs in a single request as the client must not assume any
> state-storing on the part of the server or transport.

Maybe it's worth mentioning that support in the actual remote helpers
will be added in a subsequent patch.

> If a stateless connection cannot be established then the remote-helper
> will respond in the same manner as the 'connect' command indicating that
> the client should fallback to using the dumb remote-helper commands.

This makes sense, but there doesn't seem to be any code in this patch
that implements this.

> @@ -612,6 +615,11 @@ static int process_connect_service(struct transport *transport,
>  	if (data->connect) {
>  		strbuf_addf(&cmdbuf, "connect %s\n", name);
>  		ret = run_connect(transport, &cmdbuf);
> +	} else if (data->stateless_connect) {
> +		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
> +		ret = run_connect(transport, &cmdbuf);
> +		if (ret)
> +			transport->stateless_rpc = 1;

Why is process_connect_service() falling back to stateless_connect if
connect doesn't work? I don't think this fallback would work, as a
client that needs "connect" might need its full capabilities.
