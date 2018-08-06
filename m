Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05DF9208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 18:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbeHFUt1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 16:49:27 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40819 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeHFUt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 16:49:26 -0400
Received: by mail-yw1-f65.google.com with SMTP id z143-v6so3974845ywa.7
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 11:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0TKaya4OVsHFStHP7wOeltpqvBJ/f5633fUJZr4+Bc=;
        b=OenLECao9BwGt8j9PC1etCKV291QnTUu81/B6Z/mNiK99DdSA30IYM0X+hxt19+s3J
         GimN+yO5VPji3sXUtXgq33Xv33+MtaiFCUhE+bZQtwk7FQlfqBO6++zw/dKlvjVioW2Q
         IaSu+H1Kx00BzEpkQ4TrxydP4SB1hhYLHV3RRqJ52FN7VR27S4pQlpXBwnpz8BJ04dh2
         n0X89kibs3a1osOEZCfYWNrUPG2NHom/L1tMe9ANF4e2H1QkDlATCksrMN1JlMIo6WTo
         goevOrNdlwq5iP+MNHqCRKKJR5HXoLc1qaebXsqAQeJ0jS6dZ8bQG/79BhqXzCduvVcq
         hLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0TKaya4OVsHFStHP7wOeltpqvBJ/f5633fUJZr4+Bc=;
        b=ipJX+ZQxZUzU4feDgmHxC1KnA2ZbJVae9maEPHlFSCK36C8GsvZwWd7/Vl2xDCKMoX
         /s74jbeWJhyIipK629X6P9/ckVkEtclYIMeYWoGimQ7NQGtfDSySObwdv5tmEAv/UmPX
         FtkD7NfSAekg+/A19cpVEvMyMsvbnUJ8v5qwpjNS5g7o2wSXmlVtVn0yxEsySOitetmf
         yWiFyjGFw7YUCa9iP+O/LjDmYO1KqMdKgfhy0HSl7j6vRSaHMmqqGlA/UYMunfyiaqHL
         hLrk64O+YO6LG9cpj9A4e/lAjtw2ZmcznyiEnTeHJ7JXI2uCDqEdCg5/+SL50LuFTIdi
         kM9Q==
X-Gm-Message-State: AOUpUlGtupQs++ZE/ny1O5XWZK/OI3rk1yx/sk+0+5G5g5NZ9Y/NA6on
        JKkfVwVQEdeoSKVGw4zeYVe9CdA/Ano1P9Ab4uUMeg==
X-Google-Smtp-Source: AAOMgpeRIto3c6Qr1iUsBvM2JU7vCuwuQvWxLkPpaZplmwXCFtrLbNO6IjSg4SetCgDEaPMu0HKSm5T90Dhz2cR8GCQ=
X-Received: by 2002:a0d:c944:: with SMTP id l65-v6mr8442364ywd.414.1533580744260;
 Mon, 06 Aug 2018 11:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180804020009.224582-1-sbeller@google.com> <20180804020255.225573-1-sbeller@google.com>
 <20180804060928.GB55869@aiede.svl.corp.google.com> <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
 <xmqqo9eirqwp.fsf@gitster-ct.c.googlers.com> <87zhxzsb2p.fsf@evledraar.gmail.com>
 <20180806170211.GD19053@sigill.intra.peff.net>
In-Reply-To: <20180806170211.GD19053@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Aug 2018 11:38:53 -0700
Message-ID: <CAGZ79kYzPYg=MXdWij-voDwNg52srXZOACgK5OOKrquekU-5eg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I had the impression that DEVELOPER=1 was allowed to set flags that old
> versions might not even know about. Hence they might actually barf, even
> without -Werror. Maybe that's better since the introduction of the
> detect-compiler script, though.
>
> I do think we may have a skewed view of the population on this list.
> We're developers ourselves, and we interact with new developers that we
> want to help.  But there are masses of people[1] building Git who are
> _not_ developers, and want the default to be as robust as possible.
> They're probably not going to show up in this thread.

Good point about the skewed perception of people who compile Git
themselves.

At first I thought this could be mitigated by detecting if someone is
a developer by being more clever, for example if they have a commit
(at HEAD) that is not contained in any remote, it is a pretty good indicator
that fresh code was written. But this could also be the case for some
non mainstream platform, that needs fixing.

But then I entertained the thought that we actually do not care about
people committing non conforming code to their copy of git.git, but
actually only care about the code when we see it (i.e. upon review).

So I wonder if we want to "fork" git-send-email and provide a tool to
send emails with a pre-send compile&lint check specific to our code
base.

But then all these sound a lot more complicated than a simple knob
that we turn on and off. So I don't look any further into it.

Stefan
