Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FAD11F453
	for <e@80x24.org>; Tue, 19 Feb 2019 14:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfBSO2h (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 09:28:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39996 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfBSO2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 09:28:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id 10so16894812eds.7
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 06:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Fmv+3DKcBJhRA+hME8lRR0btDJ60hREXHAFtFriUYCQ=;
        b=HDu9gpYb8IM+g4Ud80/awcv+VoGe/7ZcChck2iEdEpiZfMC6Ryw9nDa5sdJN9kDQrc
         mx20G3zFEx8dh6OeCiCEThJkfcOWkxb+/5ydcyfepdu6plMYCQyGSuAsFIB4o2KifrnI
         jcgHfa6V54ulvmkNVjw2ZsPB9N7Q5GAWmxRKCdv9DBn5iiygl5VbfuMU1zfuNwYMKUR6
         7op39qodD5S9ybL7fkLxdB8pSB5fM/DOulB+TeJ09eP8XGhl7lEssbGpUYDObQaVz74/
         IVyb2mEB8Dp+R8sh5fxy42883/xgigVsVyxn39cD0vvfBR8qVlRb4EzmJN8n0ta29Ty3
         AfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Fmv+3DKcBJhRA+hME8lRR0btDJ60hREXHAFtFriUYCQ=;
        b=EkblNC12bkLkNiJ/dVlpShtJBJ0R6f7nwmprMoUdhATZit+os138++Gie/Qbk1CDgL
         xFJbeNGRH30JLD4R2w+hUB/bBbQFOHf0mSntGT/Usp1zMuiGXsEMrQJMSxQkm0hEuc4h
         36VxnCO3rL71O+tWcGvYfKW4kwgMOekGtLo0whz+ZYWR3mwCs/3vUVrJaTIZTIhtbofZ
         +tEA7hA6HmlHlCiWk6BXcZ6DAeLfN8bHpIaBkfFmlRdYaxYUI1l2SAbBOkwVkGYV1HZu
         lCn0MIWQQb5Jlbyj6GTyg1jdXJKkyquM75q60F4Xf5zEK6VjRtCYxjLVoL6kbOYVLzo/
         clHQ==
X-Gm-Message-State: AHQUAuY/QQrTPAzd8z1PPnzPa7Mz98XHIBXbGODJ9iScpiaOvnb5CU4m
        FfF+/G6XmoRc1bjIyw/fMhb79Gxf8so=
X-Google-Smtp-Source: AHgI3IbjhnW6HTUDKsmDryibpBWktzeMmdbutV/065CQ6gBTvt8OIBl+AR2w4vSG9jb0gIM4mKQeBQ==
X-Received: by 2002:a50:b7d5:: with SMTP id i21mr24182500ede.53.1550586515372;
        Tue, 19 Feb 2019 06:28:35 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id c15sm470643eda.27.2019.02.19.06.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 06:28:34 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
References: <cover.1543879256.git.jonathantanmy@google.com> <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com>
Date:   Tue, 19 Feb 2019 15:28:34 +0100
Message-ID: <87k1hv6eel.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 04 2018, Jonathan Tan wrote:

I meant to follow-up after Git Merge, but didn't remember until this
thread was bumped.

But some things I'd like to clarify / am concerned about...

> +when the server sends the packfile, it MAY send a `packfile-uris` section
> +directly before the `packfile` section (right after `wanted-refs` if it is
> +sent) containing HTTP(S) URIs. See protocol-v2.txt for the documentation of
> +this section.
> +
> +Clients then should understand that the returned packfile could be incomplete,
> +and that it needs to download all the given URIs before the fetch or clone is
> +complete. Each URI should point to a Git packfile (which may be a thin pack and
> +which may contain offset deltas).
> [...]
> +This is the implementation: a feature, marked experimental, that allows the
> +server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
> +<uri>` entries. Whenever the list of objects to be sent is assembled, a blob
> +with the given sha1 can be replaced by the given URI. This allows, for example,
> +servers to delegate serving of large blobs to CDNs.

Okey, so the server advertisement is not just "<urls>" but <oid><url>
pairs. More on this later...

> +While fetching, the client needs to remember the list of URIs and cannot
> +declare that the fetch is complete until all URIs have been downloaded as
> +packfiles.

And this. I don't quite understand this well enough, but maybe it helps
if I talk about what I'd expect out of CDN offloading. It comes down to
three things:

 * The server should be able to point to some "seed" packfiles *without*
   necessarily knowing what OIDs are in it, or have to tell the client.

 * The client should be able to just blindly get this data ("I guess
   this is where most of it is"), unpack it, see what OIDs it has, and
   *then* without initiating a new connection continue a want/have
   dialog.

   This effectively "bootstraps" a "clone" mid way into an arbitrary
   "fetch".

 * There should be no requirement that a client successfully downloads
   the advertised CDNs, for fault handling (also discussed in
   https://public-inbox.org/git/87lg2b6gg0.fsf@evledraar.gmail.com/)

More concretely, I'd like to have a setup where a server can just dumbly
point to some URL that probably has most of the data, without having any
idea what OIDs are in it. So that e.g. some machine entirely
disconnected from the server (and with just a regular clone) can
continually generating an up-to-date-enough packfile.

I don't see how this is compatible with the server needing to send a
bunch of "<oid> <url>" lines, or why a client "cannot declare that the
fetch is complete until all URIs have been downloaded as
packfiles". Can't it fall back on the normal dialog?

Other thoughts:

 * If there isn't such a close coordination between git server & CDN, is
   there a case for having pack *.idx files on the CDN, so clients can
   inspect them to see if they'd like to download the full referenced
   pack?

 * Without the server needing to know enough about the packs to
   advertise "<oid> <url>" is there a way to e.g. advertise 4x packs to
   clients:

       big.pack, last-month.pack, last-week.pack, last-day.pack

   Or some other optimistic negotiation where clients, even ones just
   doing regular fetches, can seek to get more up-to-date with one of
   the more recent packs before doing the first fetch in 3 days?

   In the past I'd toyed with creating a similar "not quite CDN" setup
   using git-bundle.
