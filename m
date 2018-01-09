Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93EED1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 17:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934610AbeAIRzl (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 12:55:41 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:44423 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934606AbeAIRzh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 12:55:37 -0500
Received: by mail-pg0-f46.google.com with SMTP id i5so8477545pgq.11
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 09:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g4wfyI0JKAzD3gCe14N7sgMYr+US2mbZj9varmY1ELg=;
        b=DGFltsKLaWwRbST/N6eLxLdJvuE4eML0tzOrEyvP1iHMvYTyNeaPa6GTUp1wBTy9UM
         Fgvs2Bt4gjSfy6/03Os5irdZzc3KIsxwiG3Y+tzrN6qhRYimm6keox2wx/uJc0LvnKSy
         mOaWK+vHcteKIJ7dsv/RTZZ2cW1r9Y7qcFXs8JATah1zOoZ96hZZecWmEAlSYflB+Ec1
         SCeyROy5MPIpLJrseWvr/GoLPl+uND7GBrJg+mZv1or4AC6S2I/2xQ8ORCv3OqQK1+yF
         3/n2IpXiUFWew0pW6IAzUM7/PyGtzix4oH+4ZXa2Rgktf7+qdIRX+M9auwIVQUiQ0ocf
         jo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g4wfyI0JKAzD3gCe14N7sgMYr+US2mbZj9varmY1ELg=;
        b=dG1qDMvZwSwmYHhkYEl5iDxSfVyV35m0P1V4Pi7saD1meyzpeGFz6LfvjXSxOS/lw6
         xrwipIVn7asAsh522kVBFPfofRgBC7GSBU4VUM0O4ksnuzINPyf7k3ZDQQd6G0QaGi3u
         gf1xdBE9AEF5jFYpwdniFU/EgoTO7+mDyOq4UuJ4yUTIYJ6uHH0WgH6hjJEBf9mP92mD
         nXdPH+QkejiK4U4iEGS9s7gDVNaPv5SfCZPilNEU9lGCguBljszFUQpXb04cwWk8K1KZ
         SnmXQYH+gCqWNfhIGPAeaHxwFY58+KJBncBsStw7lbgn+j0nTbZN1NGYHJcxcATAYJtD
         j7jg==
X-Gm-Message-State: AKGB3mJpqeJKeJI2ag+xNjangx0X1dNbSnrMj6JQaovuwydixVV0JnNn
        7VUS463XYZmEdh/MUheYno2P/EYzucQ=
X-Google-Smtp-Source: ACJfBovje1fOF7P1N6OKp7HeGik2wX8jeMP2GWUZhr18LdnCEEK14eQDJZLg//6ft61Lm+/3hwIcQg==
X-Received: by 10.98.254.11 with SMTP id z11mr6025701pfh.48.1515520536613;
        Tue, 09 Jan 2018 09:55:36 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:592e:240e:24e2:56aa])
        by smtp.gmail.com with ESMTPSA id h13sm28611816pfi.40.2018.01.09.09.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 09:55:35 -0800 (PST)
Date:   Tue, 9 Jan 2018 09:55:34 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 00/26] protocol version 2
Message-Id: <20180109095534.c0c9b9ad3933d406c993c3ab@google.com>
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  2 Jan 2018 16:18:02 -0800
Brandon Williams <bmwill@google.com> wrote:

> The following patches extend what I sent out as an WIP
> (https://public-inbox.org/git/20171204235823.63299-1-bmwill@google.com/) and
> implement protocol version 2.

Summarizing (for myself) the rationale for protocol version 2:

The existing protocol has a few pain points: (a) limit on the length of
the capability line (the capability line can be used to include
additional parameters in a backwards-compatible way), (b) difficulty in
creating proxies because of inconsistent flush semantics, and (c) the
need to implement clients twice - once for HTTP and once for
connect-supporting transports. To which we can add another: (d) if we
want to support something entirely new (for example, a server-side "git
log"), we will need a new protocol anyway.

The new functionality introduced in this patch set is probably best done
using a new protocol. If it were done using the existing protocol (by
adding a parameter in the capabilities line), we would still run into
(a) and (c), so we might as well introduce the new protocol now.

Some of the above points are repeats from my previous e-mail:
https://public-inbox.org/git/20171110121347.1f7c184c543622b60164e9fb@google.com/

> Some changes from that series are as follows:
>  * Lots of various cleanup on the ls-refs and fetch command code, both server
>    and client.
>  * Fetch command now supports a stateless-rpc mode which enables communicating
>    with a half-duplex connection.

Good to hear about fetch support.

>  * Introduce a new remote-helper command 'connect-half-duplex' which is
>    implemented by remote-curl (the http remote-helper).  This allows for a
>    client to establish a half-duplex connection and use remote-curl as a proxy
>    to wrap requests in http before sending them to the remote end and
>    unwrapping the responses and sending them back to the client's stdin.

I'm not sure about the "half-duplex" name - it is half-duplex in that
each side must terminate their communications with a flush, but not
half-duplex in that request-response pairs can overlap each other (e.g.
during negotation during fetch - there is an optimization in which the
client tries to keep two requests pending at a time). I think that the
idea we want to communicate is that requests and responses are always
packetized, stateless, and always happen as a pair.

I wonder if "stateless-connect" is a better keyword - it makes sense to
me (once described) that "stateless" implies that the client sends
everything the server needs at once (thus, in a packet), the server
sends everything the client needs back at once (thus, in a packet), and
then the client must not assume any state-storing on the part of the
server or transport.

>  * The transport code is refactored for ls-remote, fetch, and push to provide a
>    list of ref-patterns (based on the refspec being used) when requesting refs
>    from the remote end.  This allows the ls-refs code to send this list of
>    patterns so the remote end and filter the refs it sends back.

Briefly looking at the implementation, the client seems to incur an
extra roundtrip when using ls-remote (and others) with a v2-supporting
server. I initially didn't like this, but upon further reflection, this
is probably fine for now. The client can be upgraded later, and I think
that clients will eventually want to query git-serve directly for
"ls-refs" first, and then fall back to v0 for ancient servers, instead
of checking git-upload-pack first (as in this patch set) - so, the
support for "ls-refs" here won't be carried forward merely for backwards
compatibility, but will eventually be actively used.

As for the decision to use a new endpoint "git-serve" instead of reusing
"git-upload-pack" (or "git-receive-pack"), reusing the existing one
might allow some sort of optimization later in which the first
"git-upload-pack" query immediately returns with the v2 answer (instead
of redirecting the client to "git-serve"), but this probably doesn't
matter in practice (as I stated above, I think that eventually clients
will query git-serve first).

> This series effectively implements protocol version 2 for listing a remotes
> refs (ls-remote) as well as for fetch for the builtin transports (ssh, git,
> file) and for the http/https transports.  Push is not implemented yet and
> doesn't need to be implemented at the same time as fetch since the
> receive-pack code can default to using protocol v0 when v2 is requested by the
> client.

Agreed - push can be done later.
