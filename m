Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82BAB1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 18:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeIUAUY (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 20:20:24 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42539 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeIUAUY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 20:20:24 -0400
Received: by mail-yb1-f195.google.com with SMTP id p74-v6so3767476ybc.9
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 11:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7IURib/5ot6dxNFqw5AcE1Mmf0LhsdXVjBP7aBkbbQ=;
        b=cvfrSysJ1Ti/EsRNM6fX4u3vUnVo5pBypwkcELNfkvrBOHw9tm7uQ7vcM8wyI5RT87
         RNt7TN1O0gAMVArbSFAHlWdR/iyjOGM52ii3sHJAtQtvcQXdgb2Bi8EgdZuvSy9OJvxr
         GIVlEknjxA3p1zZg8Txq2y8R/2WKlMrmSKiJHtUHOjdBGKYElU61AU8tXGVM52iWgbv6
         q9TT+JdJeU1uD2tgy7ytNBweevSmkITE173XE1iZZmFP2fG2SaurTizJ2sRcUtzaXJj6
         f7Cu8UTHlLc2SL72B4oDdRwQBCJiDuDhxM8H6GXH0OM6pWUNgY0vbKmad2krGII7Zdq9
         75pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7IURib/5ot6dxNFqw5AcE1Mmf0LhsdXVjBP7aBkbbQ=;
        b=KkAHTyPQDpIMibXSfwR40UtIoXRzAmxNBIzgeh8sEtU9KMuanynkB+ytE2lcwI94pT
         xvbF5sEY9QpkHQWG5ZxGQ0x1z85lPyukXg1PMe+FGabjpmXXJUwIRrWGYxewzsj+FVSo
         fSuyXdH0d316kYgK/Ij9XsnNEuLKyR7b2KCL8BQZP2o6MqowHM6UKdg9ZwjBkhuVdZpM
         1nFAAysEGBkEaKhY2yWlW6YRi9kQWWlTYlMJ2LwgL09nWIYNmEIg1opURWzVan910Du1
         ESFhyvcIr3jSgbMYZch/paJqWmDavx8Mi5SVTnj0iUHjDb39jPYBIPfBCPbYVTMYnuVb
         95Qg==
X-Gm-Message-State: APzg51ALo4StQ8oVsTuzZq8PY+Oe+puVvbepR3wyyKroA/5TXPRYlUW0
        +MB93rsIW7rkDoWaQCPlcLlfSYI6ycwKr6nQoxa+9gId5pJJDA==
X-Google-Smtp-Source: ANB0VdY6khIc3Z+XszXoS08FhLzJm9ayLAcqhW/GjwuS5JsLi2THPDNhEmhfvfRRFQA2/DLgx6eRebIZBuhGiWZK2i0=
X-Received: by 2002:a25:8892:: with SMTP id d18-v6mr5560762ybl.521.1537468534963;
 Thu, 20 Sep 2018 11:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537466087.git.me@ttaylorr.com>
In-Reply-To: <cover.1537466087.git.me@ttaylorr.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Sep 2018 11:35:23 -0700
Message-ID: <CAGZ79kYv-n_x_Z3K=zsiTAQ9RCFMVE=6ZYCWRQMgioGRPnhVOQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Filter alternate references
To:     ttaylorr@github.com
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 11:04 AM Taylor Blau <ttaylorr@github.com> wrote:
>
> Hi,
>
> This is a series to customize Git's behavior when listing references
> from an alternate repository. It is motivated by the following example:
>
> Consider an upstream repository, a fork of it, and a local copy of that
> fork. Ideally, running "git pull upstream" from the local copy followed
> by a "git push fork" should be a lightweight operation, ideally because
> the fork already "knows" about the new objects introduced upstream.
>
> Today, we do this by means of the special ".have" references advertised
> by 'git receive-pack'. This special part of the advertisement is
> designed to tell the pusher about tips that it might want to know about,
> to avoid sending them again.
>
> This optimization is a good one and works well, particularly when the
> upstream repository has a relatively normal number of references. When
> the upstream has a pathologically _large_ number of references, the
> advertisement alone can be so time consuming, that it's faster to send
> redundant objects to the fork.

(tangent:)
The current fetch protocol consists of 2 parts:
negotiation + sending the packfile, and the negotiation only tries
to trim down the size of the packfile to send, without taking its own
cost (in terms of time and band width) into account, just to produce
a perfect pack to send to the client.

When talking about designing protocol v2 for push (which has not
landed yet[1]), we had some in-office discussions whether we
want to have a proper negotiation on push, as it would help
pushing to remotes that have non-ff pushes, but not necessarily
regular pushes, as they should be fine with just the refs advertisement.

[1] https://github.com/bmwill/git/commit/57a4e6e5d18a2d4d806fc8dec644b89affd50853
bmwill@ no longer works on it though.


>
> To make the reference advertisement manageable even with a large number
> of references, let's allow the fork to select which ones it thinks might
> be "interesting", and only advertise those. This makes the advertisement
> much smaller, and lets us take advantage of the ".have" references, even
> when the upstream contains more references than we're advertising.
>
> This series implements the above functionality by means of
> "core.alternateRefsCommand", and "core.alternateRefsPrefixes", either a
> command to run in place of "git for-each-ref", or arguments to be
> appended to "git for-each-ref".
>
> The order of precedence when listing references from an alternate is as
> follows:
>
>   1. If the fork configures "core.alternateRefsCommand", run that.
>
>   2. If the fork configures "core.alternateRefsPrefixes", run 'git
>      for-each-ref', limiting results to references that have any of the
>      given values as a prefix.
>
>   3. Otherwise, run 'git for-each-ref' in the alternate.
>
> In a previous version of this series, I taught the configuration
> property to the alternate, as in "these are the references that _I_
> think _you_ will find interesting," rather than the other way around. I
> ultimately decided on what is attached here so that the fork does not
> have to trust the upstream to run arbitrary shell commands.

Would it make sense to estimate the value of each .have before
advertising them and then advertise only the <n> most valuable
.haves ?
(e.g. if a .have is only one small commit ahead of origin/master,
it may not bring a lot of value as the potential savings are small,
but if that .have contains history between master..TIP that has lots
of big blobs or objects in general, this may be valuable to know)

Stefan
