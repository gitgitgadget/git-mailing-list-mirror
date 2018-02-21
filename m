Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222F31F404
	for <e@80x24.org>; Wed, 21 Feb 2018 20:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeBUUBq (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 15:01:46 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:44852 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeBUUBp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 15:01:45 -0500
Received: by mail-pg0-f42.google.com with SMTP id l4so1064606pgp.11
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 12:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c8+Cke6g+9u1fKBfX1utyUIv1dwxwHhupO3a18mDJoc=;
        b=hpgXsjztHZlWNf6+TfbvjCaPjuR1XB8UFwajTXyLBEG42JijWcP2edqcxTWnNDaKUx
         zhFxlo10kUmz4vZDb7XdmCl8lqgW7CMlpEvLjH/t0cn1HH3VZlLZSYgF8oJLntn0vVHp
         lSdyCUxyqrFfdhoNYK6ags+nrNEwxEzm9y5IKyq+gwQ8vXvmFR3DqMXChLpJfrIgyh2t
         RtESrrz7cyMgJsEB5PE6SgScH0hj1G5eqO4Qg5F0VVLwVOFPA2zVaWuOn/DI2ihXPa27
         uqfQDB8ioTaTnIkQfkh4gj7pM+PnaxBGlXzSD15TV2r2ega68GEIcgZDyIy1zNMsKjNt
         vNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c8+Cke6g+9u1fKBfX1utyUIv1dwxwHhupO3a18mDJoc=;
        b=r6wA0L9ok9fZMrayJCUdjNzV2OEE2btzYIPeQ/5fxwFsk1LwFit8MV+dgpuoNkG+et
         7kEuni4iJON/RC6Gu9hQamSfHv4FtSHUhzgz2qEizKMd36asMramlbQp4Fdo+CK0IXhx
         0nkq0mKbTX3UetDHuNUXWqeNs8F1u19gwpd00ut1ObhYAZoXKyU1lgnnTnGTeujsjoQC
         Dl/k8JVel0dLX8zkcoSPoKiGBjLTSndK0R9zdBMrwZj3sFZlqKHSkOqMAhl0+4eAxLj0
         5kus1P/x51mIA8upwvtpTObKaHz8x9DmCsA9zg/eiK0agIOhWCgsi7/UKQgSYxSCObfq
         UUZQ==
X-Gm-Message-State: APf1xPDCpRJgUrBOxgXWHFhEz54VfKpFClzmmhmaLf+U/F3o9FFFgTcu
        VSYEO4qUCHcUmd5bTAuRXnel1ePwlok=
X-Google-Smtp-Source: AH8x224DzH5WNacy7xSsq1a/ijbBIQW/FeX3/fdgQmYpLeWv6n0ptVz+qu+pO3hBOOztzUZaA/I3ww==
X-Received: by 10.101.72.198 with SMTP id o6mr3560070pgs.279.1519243303673;
        Wed, 21 Feb 2018 12:01:43 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id w71sm57155110pfd.184.2018.02.21.12.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 12:01:42 -0800 (PST)
Date:   Wed, 21 Feb 2018 12:01:41 -0800
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 00/35] protocol version 2
Message-ID: <20180221200141.GA127348@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/06, Brandon Williams wrote:
> Changes in v3:
>  * There were some comments about how the protocol should be designed
>    stateless first.  I've made this change and instead of having to
>    supply the `stateless-rpc=true` capability to force stateless
>    behavior, the protocol just requires all commands to be stateless.
>  
>  * Added some patches towards the end of the series to force the client
>    to not request to use protocol v2 when pushing (even if configured to
>    use v2).  This is to ease the roll-out process of a push command in
>    protocol v2.  This way when servers gain the ability to accept
>    pushing in v2 (and they start responding using v2 when requests are
>    sent to the git-receive-pack endpoint) that clients who still don't
>    understand how to push using v2 won't request to use v2 and then die
>    when they recognize that the server does indeed know how to accept a
>    push under v2.
> 
>  * I implemented the `shallow` feature for fetch.  This feature
>    encapsulates the existing functionality of all the shallow/deepen
>    capabilities in v0.  So now a server can process shallow requests.
> 
>  * Various other small tweaks that I can't remember :)
> 
> After all of that I think the series is in a pretty good state, baring
> any more critical reviewing feedback.
> 
> Thanks!

I'm hoping to get some more in depth review before I do any more
re-rolls, but for those interested I will need to do a re-roll to
eliminate the prelude from the http transport.  This is the prelude
which includes the service line followed by any number of packet lines
culminating in a flush-pkt like so:

  # service=git-upload-pack
  some
  other
  optional
  lines
  0000

With this eliminated all transports will be exactly the same, the only
difference will be how the protocol is tunneled.

> 
> Brandon Williams (35):
>   pkt-line: introduce packet_read_with_status
>   pkt-line: introduce struct packet_reader
>   pkt-line: add delim packet support
>   upload-pack: convert to a builtin
>   upload-pack: factor out processing lines
>   transport: use get_refs_via_connect to get refs
>   connect: convert get_remote_heads to use struct packet_reader
>   connect: discover protocol version outside of get_remote_heads
>   transport: store protocol version
>   protocol: introduce enum protocol_version value protocol_v2
>   test-pkt-line: introduce a packet-line test helper
>   serve: introduce git-serve
>   ls-refs: introduce ls-refs server command
>   connect: request remote refs using v2
>   transport: convert get_refs_list to take a list of ref patterns
>   transport: convert transport_get_remote_refs to take a list of ref
>     patterns
>   ls-remote: pass ref patterns when requesting a remote's refs
>   fetch: pass ref patterns when fetching
>   push: pass ref patterns when pushing
>   upload-pack: introduce fetch server command
>   fetch-pack: perform a fetch using v2
>   upload-pack: support shallow requests
>   fetch-pack: support shallow requests
>   connect: refactor git_connect to only get the protocol version once
>   connect: don't request v2 when pushing
>   transport-helper: remove name parameter
>   transport-helper: refactor process_connect_service
>   transport-helper: introduce stateless-connect
>   pkt-line: add packet_buf_write_len function
>   remote-curl: create copy of the service name
>   remote-curl: store the protocol version the server responded with
>   http: allow providing extra headers for http requests
>   http: don't always add Git-Protocol header
>   remote-curl: implement stateless-connect command
>   remote-curl: don't request v2 when pushing
> 
>  .gitignore                              |   1 +
>  Documentation/technical/protocol-v2.txt | 338 +++++++++++++++++
>  Makefile                                |   7 +-
>  builtin.h                               |   2 +
>  builtin/clone.c                         |   2 +-
>  builtin/fetch-pack.c                    |  21 +-
>  builtin/fetch.c                         |  14 +-
>  builtin/ls-remote.c                     |   7 +-
>  builtin/receive-pack.c                  |   6 +
>  builtin/remote.c                        |   2 +-
>  builtin/send-pack.c                     |  20 +-
>  builtin/serve.c                         |  30 ++
>  builtin/upload-pack.c                   |  74 ++++
>  connect.c                               | 352 +++++++++++++-----
>  connect.h                               |   7 +
>  fetch-pack.c                            | 319 +++++++++++++++-
>  fetch-pack.h                            |   4 +-
>  git.c                                   |   2 +
>  http.c                                  |  25 +-
>  http.h                                  |   2 +
>  ls-refs.c                               |  96 +++++
>  ls-refs.h                               |   9 +
>  pkt-line.c                              | 149 +++++++-
>  pkt-line.h                              |  77 ++++
>  protocol.c                              |   2 +
>  protocol.h                              |   1 +
>  remote-curl.c                           | 257 ++++++++++++-
>  remote.h                                |   9 +-
>  serve.c                                 | 260 +++++++++++++
>  serve.h                                 |  15 +
>  t/helper/test-pkt-line.c                |  64 ++++
>  t/t5701-git-serve.sh                    | 176 +++++++++
>  t/t5702-protocol-v2.sh                  | 239 ++++++++++++
>  transport-helper.c                      |  84 +++--
>  transport-internal.h                    |   4 +-
>  transport.c                             | 116 ++++--
>  transport.h                             |   9 +-
>  upload-pack.c                           | 625 ++++++++++++++++++++++++--------
>  upload-pack.h                           |  21 ++
>  39 files changed, 3088 insertions(+), 360 deletions(-)
>  create mode 100644 Documentation/technical/protocol-v2.txt
>  create mode 100644 builtin/serve.c
>  create mode 100644 builtin/upload-pack.c
>  create mode 100644 ls-refs.c
>  create mode 100644 ls-refs.h
>  create mode 100644 serve.c
>  create mode 100644 serve.h
>  create mode 100644 t/helper/test-pkt-line.c
>  create mode 100755 t/t5701-git-serve.sh
>  create mode 100755 t/t5702-protocol-v2.sh
>  create mode 100644 upload-pack.h
> 
> -- 
> 2.16.0.rc1.238.g530d649a79-goog
> 

-- 
Brandon Williams
