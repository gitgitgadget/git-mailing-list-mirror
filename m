Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7ED1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeBUWpU (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:45:20 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34540 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeBUWpS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:45:18 -0500
Received: by mail-pg0-f44.google.com with SMTP id m19so1243366pgn.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 14:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ee9spvbZ9/tKbKo7jkxNqi4jgAxcHU2qH3BtkxRYUi0=;
        b=jFxRPwdaiJk2X+kFLBL0ug1o3TedKoBldcCn+pgk3YIw4utfOihLoN6JkoN4jLO/kh
         rC+Wmu7rQ8CEEXuWu3PqrHXkgnZKa69+uaunlTlQv/edYB6iZAUnnR9yzJQavZEMRC9O
         EAordslovg9OuP/T2xtRBuSHG9PhktMFbaCu3igvo+esx73xC9NZAZlL/noEn2G1pxIM
         2qM9yJJ/ddHxEvikfUxkBtYnZw2UJli+0/EoMRQw/4WB5ianKufup+bhvPvHMRTeWJRN
         wY5RjIvCBhOZn9tS05GnhuAlDJ4H+yQOIG07Y7rifUXXYznaLeZHqqT3TZIkp7WgqfPp
         9CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ee9spvbZ9/tKbKo7jkxNqi4jgAxcHU2qH3BtkxRYUi0=;
        b=nsCmywWu9XYSOa3S+rLe/Z9Eg9USQ0BJ9LCb7csfGwegkTUY8EswT/RIEFhQXaBsGm
         H8u+MP0rnYX+VfeDZJsWjdFvSQBGdvRD9p6gxVg+TV1czfSTiSsfvslAnzX92csWMsAu
         TRREcql0mhIO1sagZMFz7p41pzEBq7HO5+QdAV0nykMvZF8Rexjq+zWMoIwtE2RK5Xyy
         jUkNayDb9bzw2eaATzmIP/CzkRusL6KHlWtFbYSKk7Q444M7zHv2jV89bnFq2EJwwPrc
         1i9Y4GGIlceFivh3XpLmUhXTZ1dZ7n3U2t0e41/mAKD3hL6KIzi2C7i0f43BcqnzMA1j
         Ndng==
X-Gm-Message-State: APf1xPD5gSyhiRHIaCbn+ni2bDO5gZjRE6PRsqt93rpcT5d3rgshlDYv
        ivRnCglT6FXJiZSpuoUHwVT5qMgJE+k=
X-Google-Smtp-Source: AH8x227e6jRmcKNDfiZ6OGi5echtM7uhtzWZWLflna6O3O45JREudF3AgI/5LNGw+b+7+Y/kLBT7zA==
X-Received: by 10.98.204.69 with SMTP id a66mr4753513pfg.33.1519253118155;
        Wed, 21 Feb 2018 14:45:18 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id b84sm66640962pfj.11.2018.02.21.14.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 14:45:16 -0800 (PST)
Date:   Wed, 21 Feb 2018 14:45:15 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 12/35] serve: introduce git-serve
Message-Id: <20180221144515.d180a26627a33168b19e0a4f@google.com>
In-Reply-To: <20180207011312.189834-13-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-13-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:12:49 -0800
Brandon Williams <bmwill@google.com> wrote:

>  .gitignore                              |   1 +
>  Documentation/technical/protocol-v2.txt | 114 +++++++++++++++
>  Makefile                                |   2 +
>  builtin.h                               |   1 +
>  builtin/serve.c                         |  30 ++++
>  git.c                                   |   1 +
>  serve.c                                 | 250 ++++++++++++++++++++++++++++++++
>  serve.h                                 |  15 ++
>  t/t5701-git-serve.sh                    |  60 ++++++++
>  9 files changed, 474 insertions(+)
>  create mode 100644 Documentation/technical/protocol-v2.txt
>  create mode 100644 builtin/serve.c
>  create mode 100644 serve.c
>  create mode 100644 serve.h
>  create mode 100755 t/t5701-git-serve.sh

As someone who is implementing the server side of protocol V2 in JGit, I
now have a bit more insight into this :-)

First of all, I used to not have a strong opinion on the existence of a
new endpoint, but now I think that it's better to *not* have git-serve.
As it is, as far as I can tell, upload-pack also needs to support (and
does support, as of the end of this patch set) protocol v2 anyway, so it
might be better to merely upgrade upload-pack.

> +A client then responds to select the command it wants with any particular
> +capabilities or arguments.  There is then an optional section where the
> +client can provide any command specific parameters or queries.
> +
> +    command-request = command
> +		      capability-list
> +		      (command-args)

If you are stating that this is optional, write "*1command-args". (RFC
5234 also supports square brackets, but "*1" is already used in
pack-protocol.txt and http-protocol.txt.)

> +		      flush-pkt
> +    command = PKT-LINE("command=" key LF)
> +    command-args = delim-pkt
> +		   *arg
> +    arg = 1*CHAR

arg should be wrapped in PKT-LINE, I think, and terminated by an LF.
