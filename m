Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F0F208E9
	for <e@80x24.org>; Fri, 27 Jul 2018 22:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389750AbeG0XYQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 19:24:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45684 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389719AbeG0XYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 19:24:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so3947644pgq.12
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iZwGJg82erMf4UmY2+0aSog1kwuacp3Gzgk9P2Z96sc=;
        b=NDPcxTCd+B5SplkGiaJWbl2ilOJkD3sWEGeZ7guWehKyp+Y8qSFUwtpBs3HboAd9N4
         iO+0mzS2uP4Nlu1VqYh/llTprWXdQMyUvD3YS1ImfrcPNQQpGgMqZic7DbqcdGcBtZE7
         uenZZzafHKSLHIqOHn7GTr8SI0KPLEPKOYXTBWlt6ko+RzaA4fLFGIXzzM607VNcZj6/
         m1xKPsVQdg0fxQVpRDCZQ5wjyTKhb4rXbH1Rd7KQs+4kvMOzfao/MFQb2hiBja8kwx+j
         RzT42yYkwlhrYLDy7FRAdEBpdbp94wcQuE0gFe+8v4NGYEFHYOZSxpbXL5JXeVeNYe+b
         YWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iZwGJg82erMf4UmY2+0aSog1kwuacp3Gzgk9P2Z96sc=;
        b=bhyDizxGOn5MMraeJ58MUD/2BTFTYXmwYI6rg34M69D0cKD6sl/+cHX8vs6dNMucet
         e68tvt+Ba2UYhq61VPwRs4gEqyNsC3jVtHbPHlwXhuXwA8lpCdfDNto6tqIOkZGbClsc
         8TkA0kQdkpl0hdXukC++EQ4CpG8pghZ0ZB4A1Om/k06dfwAvq3cU/jPQDiFWxLhgWAiP
         p3VHaBlmvgeqzROa0G7yvGAgWXoWmZml2npdH/5hsHr5lz26yfpLi08+3sOuu95QW6NQ
         +LJOhmCaiielHZKCeEjLL/ZcHQU6WabzDWPG0ALBqL57bo1ykz9xHEBNIwm8l3NIPo8f
         BOsQ==
X-Gm-Message-State: AOUpUlF71dDqhUqcBREeOkKJ/GUVAeXcNPPtOgSjKqGoGXubYeUPLxrB
        77iabX2oWWK6yzbKYCRFRZyB67vD
X-Google-Smtp-Source: AAOMgpcNBvqdgyJiWGM/1ew2cYL6Nc7JZYB2adeI4CRRVITSUPrwnpR4cYuYBNkay8HNyCDCdLdjPw==
X-Received: by 2002:a63:4663:: with SMTP id v35-v6mr7402871pgk.178.1532728823857;
        Fri, 27 Jul 2018 15:00:23 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e126-v6sm10423162pfg.31.2018.07.27.15.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 15:00:23 -0700 (PDT)
Date:   Fri, 27 Jul 2018 15:00:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Frack Bui-Huu <fbui@suse.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Proposed approaches to supporting HTTP remotes in "git archive"
Message-ID: <20180727220021.GB223387@aiede.svl.corp.google.com>
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
to see how his creation is evolving.

Using the correct address for René this time. Sorry for the noise.)

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
