Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6221F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 20:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfDWUiI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 16:38:08 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:35603 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDWUiH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 16:38:07 -0400
Received: by mail-oi1-f202.google.com with SMTP id y126so1453108oia.2
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Mc+/l0CuY4rEfrl17WhIxAdTc2jb/r6jt0ytYMZUzCE=;
        b=Yxw51EHr4c6Q75ZfsCxFTg97SO2e1zJVyL9GBe3ZDUNSA0eaju9phEP4an5ZuzwViM
         mpGf0vk93M58tvmj4wBnRDLvCAC02iqLdPprsgmieCAN4HFbFC4gn8UlGJcIBOGK1x7z
         tHwgtHD8IrRwi1i8Nqe7VsZZEblOJktIB1zuSU5+pv7vYesrJNeN9MoiQ0ur0h+glLkF
         lgTEHpT3sygIvFh9Cem5501Fjf5+rvpQMOMeza/vClE4jcmYugkWKeAktsAeEmeEO4SB
         BG+6hXurLVjhhB85QdbQa8YDbIqbg2MMCfulvw0e4X4nro5qwBqbEPKQg/fSzGlMAV9R
         j0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mc+/l0CuY4rEfrl17WhIxAdTc2jb/r6jt0ytYMZUzCE=;
        b=gBtGUDHWW/GNgOF7lDb7rGORvL9zocfSe1trbzSlS/Nu0gWjs7dO3jNQbNeT/AKx22
         H6rz6qo7qmWK9ov3kzrra9aMt8C5GzzegWO++gm+rafmEQLiP9Y32JizhZCZJK94CkuD
         7DS7dfozgvqKAqpQzN2iaU1HYhgnsvkUNTEK12ANBlpKDP00nPAdaVzFZmuayoImoucC
         8QkItt6b9Jis4R6zb6baeEIgvbenA/7Nia2HD9YLozYbHoIS24XHqlZco5X8LR/QltB6
         Gr0FfcTBJHTOyzIAmX/cy3kPiwhaOczSc2DD3M/uwvrf6j6ukdjDtYzrCWg8ib0gFRlA
         8TFQ==
X-Gm-Message-State: APjAAAVY1Np2soOWIFXLVb97bLqbWkSffHcs1IOPA4IRuFF60K/xdgbT
        FQ1+obzoe8De08JGTRH1317aKHJZzhPAMB0t25kS
X-Google-Smtp-Source: APXvYqxVXzcYrltUcdmx6iEqo+0aUCVCoeDndIjj9Ut+XpBGlQuM4FzQyG3qAnsJ1Nz4ko9kxZ71vWZ08A1O539ttKG3
X-Received: by 2002:aca:b706:: with SMTP id h6mr2936374oif.7.1556051885600;
 Tue, 23 Apr 2019 13:38:05 -0700 (PDT)
Date:   Tue, 23 Apr 2019 13:38:01 -0700
In-Reply-To: <20190423053130.GA13162@sigill.intra.peff.net>
Message-Id: <20190423203801.29156-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190423053130.GA13162@sigill.intra.peff.net>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: Re: [PATCH v2 5/8] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The problem I see is that the client doesn't get to vet the list of
> URIs; it only gets to specify a protocol match. But there are many other
> reasons it might want to reject a URI: we don't like the protocol, the
> domain name is on a blacklist (or not on a whitelist), the domain name
> can't resolve, we can't make a TCP connection to the server, we can't
> successfully fetch the pack.
> 
> You'll note that those rise in complexity and time as you go down the
> list. I'm not sure where on that spectrum we'd want our clients to stop
> vetting (and it may even depend on config). But I think we ought to
> design the protocol to put the decision in the hands of the client so
> that it _can_ make those choices itself.
> 
> I.e., I think the conversation ought to be more like:
> 
>   Server: I support packfile-uris X, Y, Z.
> 
>   Client: Great. I'll use URIs X and Z.
> 
>   Server: OK, here's your pack, minus any objects I know are in X and Z.
>           I'll send you the objects from Y as normal.
> 
> And then the client is free to pick and choose.

One drawback I see is that the server needs to compute objects to be
sent twice - once to generate the URIs and once after the client has
informed the server which URIs it wants.

If we expect some packfile-uris to not be usable sometimes (for any of
the reasons you listed), this would be nice. The protocol in my patches
support a rudimentary version of this (if any of the URIs don't work for
any reason, just fetch again without advertising that we support
packfile URIs) but the packfile received during the first patch is
wasted.

So the tradeoff is: in the good case, your suggestion means that we make
another fetch request, increasing the load on the server and taking more
time. In the bad case, your suggestions means that we avoid sending a
useless packfile upon the first patch, and if the server is smart
enough, even the second packfile will be smaller. It depends on how
often we think the bad case occurs, if servers will typically send more
than one packfile-uri, and how smart we think servers will typically be.

> The initial server uri
> list can come in the capabilities list, or it can be a separate request
> once the client sees the server supports packfile-uris and wants to ask
> about them.

I don't think this is possible - the URI list is dependent on the wants
and haves.

> We may need some way for the server to group the uris so
> that the client knows which ones are alternates of each other (and which
> ones are needed to make a complete set).

My initial design didn't have this feature (in fact, it seems to me that
each thing should have one canonical URL, which means that there is no
need for an alternate) - do you think we should be thinking about this
at this stage?
