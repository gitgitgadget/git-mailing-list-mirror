Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB851F597
	for <e@80x24.org>; Fri, 27 Jul 2018 21:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389879AbeG0XVU (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 19:21:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44464 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389770AbeG0XVU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 19:21:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so3948595pgp.11
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 14:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e62zQrQ1jPf50CSQMlRngXgGBTmyLHCLkDMPtQoeOxE=;
        b=DnV119z7G3ooWjZCFHaeg1ft1k1pNjAJLALLWhFs+sZASG2ZQM+uX9Jqw/BsxJIkxH
         g4dnWJ4zOPAdGJwMOMdpbCusrZB+IOYTzlBA4PAUVGIR8kyC2RMoOotDvqXAXFYg+NyA
         /yY3ZoFPAU5xzHBBzHS1ycxIXJvEBRhNyo7E/jgNzu4/zupNSBFpECv29nMrxd0Pk1mz
         NyMe6Ka1rtwaA9SLieU4B5MU+ZFCaPoSbLi/X8DNY4p7I3wWgZvBdcvyPQsYHjLNxPNX
         AbD26tWmWMS059bcVWTwkHhcDyb4ekjy+OoLO9eepLPNCBb7Ve66Uss2qM4mmaIkEm4i
         5Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e62zQrQ1jPf50CSQMlRngXgGBTmyLHCLkDMPtQoeOxE=;
        b=QIa5/43St2se6tCxEq7M4EJeh+WcCBghq7jDCCKofgOoDLBCokkQzLBBktPtm2b9oF
         NOhEuD2eJY4GlTEC+DFpw0f2w7tebW7yp61SZZ4kgt/zmRg0KcRpjkP9XMIOI8bt28U4
         Nsmxw0M+iUFj3WNUCUcE1wPt00nGx4MSaVkkPzzHjgBjIOcAQNSy0irnL2P1uYJhNMnH
         gEz7K55li9FmKD119G+dAvT703wdkAhQ9X6GCLhx7cCEvE8Ndk7fGVhRlXm15V04lESZ
         JpV0GtLcuHL3PX5oYpUjElc6aOocsuTj2qCWV+mC5gwlI4BPaTHGy+oUjAvJfkYri2Rr
         9YMQ==
X-Gm-Message-State: AOUpUlF9XQTPmBvQ7b/caU1OzdRS93V5Oi1nL3Q2vlE5ktIbHKArPSC7
        ekMsQ+Vyv7h7zw2+BKC8EXo=
X-Google-Smtp-Source: AAOMgpdLy5EOeTUgqQL2wC2XwPd89hO7v7CJZP/qqgTVx9DrxU+o3J2S6IXWnPfyKbXOtPdbgbXiNA==
X-Received: by 2002:a62:3e1a:: with SMTP id l26-v6mr8296676pfa.214.1532728648466;
        Fri, 27 Jul 2018 14:57:28 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j27-v6sm7607181pfe.48.2018.07.27.14.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 14:57:27 -0700 (PDT)
Date:   Fri, 27 Jul 2018 14:56:44 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
        Jeff King <peff@peff.net>, Frack Bui-Huu <fbui@suse.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Proposed approaches to supporting HTTP remotes in "git archive"
Message-ID: <20180727215644.GA223387@aiede.svl.corp.google.com>
References: <CANq=j3tK7QeBJOC7VNWkh4+WBNibMJJp5YUkd9te5NaYwukAow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANq=j3tK7QeBJOC7VNWkh4+WBNibMJJp5YUkd9te5NaYwukAow@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(just cc-ing René Scharfe, archive expert; Peff; Dscho; Franck Bui-Huu
to see how his creation is evolving)
Josh Steadmon wrote:

> # Supporting HTTP remotes in "git archive"
>
> We would like to allow remote archiving from HTTP servers. There are a
> few possible implementations to be discussed:
>
> ## Shallow clone to temporary repo
>
> This approach builds on existing endpoints. Clients will connect to the
> remote server's git-upload-pack service and fetch a shallow clone of the
> requested commit into a temporary local repo. The write_archive()
> function is then called on the local clone to write out the requested
> archive.
>
> ### Benefits
>
> * This can be implemented entirely in builtin/archive.c. No new service
>   endpoints or server code are required.
>
> * The archive is generated and compressed on the client side. This
>   reduces CPU load on the server (for compressed archives) which would
>    otherwise be a potential DoS vector.
>
> * This provides a git-native way to archive any HTTP servers that
>   support the git-upload-pack service; some providers (including GitHub)
>   do not currently allow the git-upload-archive service.
>
> ### Drawbacks
>
> * Archives generated remotely may not be bit-for-bit identical compared
>   to those generated locally, if the versions of git used on the client
>   and on the server differ.
>
> * This requires higher bandwidth compared to transferring a compressed
>   archive generated on the server.
>
>
> ## Use git-upload-archive
>
> This approach requires adding support for the git-upload-archive
> endpoint to the HTTP backend. Clients will connect to the remote
> server's git-upload-archive service and the server will generate the
> archive which is then delivered to the client.
>
> ### Benefits
>
> * Matches existing "git archive" behavior for other remotes.
>
> * Requires less bandwidth to send a compressed archive than a shallow
>   clone.
>
> * Resulting archive does not depend in any way on the client
>   implementation.
>
> ### Drawbacks
>
> * Implementation is more complicated; it will require changes to (at
>   least) builtin/archive.c, http-backend.c, and
>   builtin/upload-archive.c.
>
> * Generates more CPU load on the server when compressing archives. This
>   is potentially a DoS vector.
>
> * Does not allow archiving from servers that don't support the
>   git-upload-archive service.
>
>
> ## Add a new protocol v2 "archive" command
>
> I am still a bit hazy on the exact details of this approach, please
> forgive any inaccuracies (I'm a new contributor and haven't examined
> custom v2 commands in much detail yet).
>
> This approach builds off the existing v2 upload-pack endpoint. The
> client will issue an archive command (with options to select particular
> paths or a tree-ish). The server will generate the archive and deliver
> it to the client.
>
> ### Benefits
>
> * Requires less bandwidth to send a compressed archive than a shallow
>   clone.
>
> * Resulting archive does not depend in any way on the client
>   implementation.
>
> ### Drawbacks
>
> * Generates more CPU load on the server when compressing archives. This
>   is potentially a DoS vector.
>
> * Servers must support the v2 protocol (although the client could
>   potentially fallback to some other supported remote archive
>    functionality).
>
> ### Unknowns
>
> * I am not clear on the relative complexity of this approach compared to
>   the others, and would appreciate any guidance offered.
>
>
> ## Summary
>
> Personally, I lean towards the first approach. It could give us an
> opportunity to remove server-side complexity; there is no reason that
> the shallow-clone approach must be restricted to the HTTP transport, and
> we could re-implement other transports using this method.  Additionally,
> it would allow clients to pull archives from remotes that would not
> otherwise support it.
>
> That said, I am happy to work on whichever approach the community deems
> most worthwhile.
