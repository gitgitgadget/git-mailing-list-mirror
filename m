Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820791F404
	for <e@80x24.org>; Mon, 12 Feb 2018 14:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754506AbeBLOup (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 09:50:45 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33805 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754503AbeBLOun (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 09:50:43 -0500
Received: by mail-qt0-f182.google.com with SMTP id d14so19154239qtg.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 06:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xKeCr/xC+FdFMKuwI38AQheXUyFUjvbhHO7gAHyU3jM=;
        b=ZOEMadkLf3zzFIQbWCtt+bLLV1p1eDgTihRHZo8bB1oGrIbLWfQ4kk5Osn2hSGfqj7
         +P6HYdzAl5RuGBu+VuL4Yx8UqCcHqM9jkMWrAQICJuhHi6s2FDLKgBGY73oc3ghK2JNT
         0A/c7+hIo0z5+fAU8OCQYOrI2bHW1tPKsSTP9cUZDJKJ+Jctd/z2A85zGGkzcNukdeF6
         VWqvDIOCi8/RzFKFQXazxIFfn3IhMDwBKgAy1lSgcdkUUPzwX6obSlt1j6b5EoNYUjw5
         pe3vrUrvy5+7K2ExFp+d+6EQkgRRSrRSpe75J3sxlztxNeoXMVyb7+worXQlWUB3Xl4x
         xUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xKeCr/xC+FdFMKuwI38AQheXUyFUjvbhHO7gAHyU3jM=;
        b=rbRqHMci+UwKpPR3hqgLu5dAgH+9q09I4riQux2DJtkN9zG20StBYSASTutt7wgHvx
         C7xfErc2aJm70x8gQcNDI2Bu+R08m1x1oDAzFRYfUWSrUfrzNMaVdj4nr5seUzAlYwHx
         z21iBC/DAKqlpQzB2EI0B9Mw1rLvHwpXL5vew8YnfKX8Sh5qjYzBB+aNhZQhGrC3iHcM
         l3fvVNWfj9to/dUZnohaeTwqTwokZGfgwC0V68x1PYN/0gh+WgknJ3gZ7/pSBVl1yFUg
         cY3d7SitA7YQzVruguClJN55OUF9r21R3eEKxxPBEc+z1q/qZ3fSD3HokqNLvwplRkkB
         RYEw==
X-Gm-Message-State: APf1xPAEj0elfKnXRbxVC/GkpVFOjkTW2GisUyKXHQucivzQySmdWacq
        voI7a/BBmRTAI1e2X0ALB+A=
X-Google-Smtp-Source: AH8x22557aaqpK2hHw7xSNwMSMmdMGm5rMR9MdK85W3nMJK+UarGynvdY10MkOK1gyoLp5Ulxz8nMg==
X-Received: by 10.200.16.11 with SMTP id z11mr18256181qti.292.1518447043051;
        Mon, 12 Feb 2018 06:50:43 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id f125sm5915181qkd.58.2018.02.12.06.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 06:50:41 -0800 (PST)
Subject: Re: [PATCH v3 00/35] protocol version 2
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, git@jeffhostetler.com, pclouds@gmail.com
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <014a6a12-cf36-35c4-25e0-9e418aec3561@gmail.com>
Date:   Mon, 12 Feb 2018 09:50:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/6/2018 8:12 PM, Brandon Williams wrote:
> Changes in v3:
>   * There were some comments about how the protocol should be designed
>     stateless first.  I've made this change and instead of having to
>     supply the `stateless-rpc=true` capability to force stateless
>     behavior, the protocol just requires all commands to be stateless.
>   
>   * Added some patches towards the end of the series to force the client
>     to not request to use protocol v2 when pushing (even if configured to
>     use v2).  This is to ease the roll-out process of a push command in
>     protocol v2.  This way when servers gain the ability to accept
>     pushing in v2 (and they start responding using v2 when requests are
>     sent to the git-receive-pack endpoint) that clients who still don't
>     understand how to push using v2 won't request to use v2 and then die
>     when they recognize that the server does indeed know how to accept a
>     push under v2.
>
>   * I implemented the `shallow` feature for fetch.  This feature
>     encapsulates the existing functionality of all the shallow/deepen
>     capabilities in v0.  So now a server can process shallow requests.
>
>   * Various other small tweaks that I can't remember :)
>
> After all of that I think the series is in a pretty good state, baring
> any more critical reviewing feedback.
>
> Thanks!
>
> Brandon Williams (35):
>    pkt-line: introduce packet_read_with_status
>    pkt-line: introduce struct packet_reader
>    pkt-line: add delim packet support
>    upload-pack: convert to a builtin
>    upload-pack: factor out processing lines
>    transport: use get_refs_via_connect to get refs
>    connect: convert get_remote_heads to use struct packet_reader
>    connect: discover protocol version outside of get_remote_heads
>    transport: store protocol version
>    protocol: introduce enum protocol_version value protocol_v2
>    test-pkt-line: introduce a packet-line test helper
>    serve: introduce git-serve
>    ls-refs: introduce ls-refs server command
>    connect: request remote refs using v2
>    transport: convert get_refs_list to take a list of ref patterns
>    transport: convert transport_get_remote_refs to take a list of ref
>      patterns
>    ls-remote: pass ref patterns when requesting a remote's refs
>    fetch: pass ref patterns when fetching
>    push: pass ref patterns when pushing
>    upload-pack: introduce fetch server command
>    fetch-pack: perform a fetch using v2
>    upload-pack: support shallow requests
>    fetch-pack: support shallow requests
>    connect: refactor git_connect to only get the protocol version once
>    connect: don't request v2 when pushing
>    transport-helper: remove name parameter
>    transport-helper: refactor process_connect_service
>    transport-helper: introduce stateless-connect
>    pkt-line: add packet_buf_write_len function
>    remote-curl: create copy of the service name
>    remote-curl: store the protocol version the server responded with
>    http: allow providing extra headers for http requests
>    http: don't always add Git-Protocol header
>    remote-curl: implement stateless-connect command
>    remote-curl: don't request v2 when pushing
>
>   .gitignore                              |   1 +
>   Documentation/technical/protocol-v2.txt | 338 +++++++++++++++++
>   Makefile                                |   7 +-
>   builtin.h                               |   2 +
>   builtin/clone.c                         |   2 +-
>   builtin/fetch-pack.c                    |  21 +-
>   builtin/fetch.c                         |  14 +-
>   builtin/ls-remote.c                     |   7 +-
>   builtin/receive-pack.c                  |   6 +
>   builtin/remote.c                        |   2 +-
>   builtin/send-pack.c                     |  20 +-
>   builtin/serve.c                         |  30 ++
>   builtin/upload-pack.c                   |  74 ++++
>   connect.c                               | 352 +++++++++++++-----
>   connect.h                               |   7 +
>   fetch-pack.c                            | 319 +++++++++++++++-
>   fetch-pack.h                            |   4 +-
>   git.c                                   |   2 +
>   http.c                                  |  25 +-
>   http.h                                  |   2 +
>   ls-refs.c                               |  96 +++++
>   ls-refs.h                               |   9 +
>   pkt-line.c                              | 149 +++++++-
>   pkt-line.h                              |  77 ++++
>   protocol.c                              |   2 +
>   protocol.h                              |   1 +
>   remote-curl.c                           | 257 ++++++++++++-
>   remote.h                                |   9 +-
>   serve.c                                 | 260 +++++++++++++
>   serve.h                                 |  15 +
>   t/helper/test-pkt-line.c                |  64 ++++
>   t/t5701-git-serve.sh                    | 176 +++++++++
>   t/t5702-protocol-v2.sh                  | 239 ++++++++++++
>   transport-helper.c                      |  84 +++--
>   transport-internal.h                    |   4 +-
>   transport.c                             | 116 ++++--
>   transport.h                             |   9 +-
>   upload-pack.c                           | 625 ++++++++++++++++++++++++--------
>   upload-pack.h                           |  21 ++
>   39 files changed, 3088 insertions(+), 360 deletions(-)
>   create mode 100644 Documentation/technical/protocol-v2.txt
>   create mode 100644 builtin/serve.c
>   create mode 100644 builtin/upload-pack.c
>   create mode 100644 ls-refs.c
>   create mode 100644 ls-refs.h
>   create mode 100644 serve.c
>   create mode 100644 serve.h
>   create mode 100644 t/helper/test-pkt-line.c
>   create mode 100755 t/t5701-git-serve.sh
>   create mode 100755 t/t5702-protocol-v2.sh
>   create mode 100644 upload-pack.h
>

I inspected the diff between v2 and v3 and found the changes to be good.

Reviewed-By: Derrick Stolee <dstolee@microsoft.com>

Thanks,
-Stolee

