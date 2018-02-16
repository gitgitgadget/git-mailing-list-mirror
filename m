Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE441F404
	for <e@80x24.org>; Fri, 16 Feb 2018 21:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750788AbeBPV2V (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 16:28:21 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37168 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeBPV2U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 16:28:20 -0500
Received: by mail-wr0-f193.google.com with SMTP id k32so4210047wrk.4
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 13:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=msyjoPD1gnWkPmU9hSLIXM+lY++ZzEsNZda/2ZifMIQ=;
        b=OC2hzEpYLKyrxOAFzZGZhMQOMmQUVHAgqNQLKEK8/VwwqTOzZw+ILMtlR/UP7Bx6sB
         ho33BVuJjfxovLDw7FKmVvjTpW7HSL7vKtxrSCeaa8fKxV9lzC7gdcFzwRbhx1M3csQt
         FtUp0qBW+9JQpfusKJITrMYlByVZd/1+jH4QfTBQni5Z9BRv3+Crza5ts/ZgVigP9e3g
         PSLXOdDm2FE7mvT4/e/T6n3CooRzyu3xayAJ3uYAtqwoIb2Ci9+NRZhGjGvuaJT6ux65
         +kIKNW+okhPnqUHG6078YqQyEPxUzBp1z091+fEwltS7TlB6YVhXzA/7Lt6XRZva/0Ir
         qUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=msyjoPD1gnWkPmU9hSLIXM+lY++ZzEsNZda/2ZifMIQ=;
        b=iLr3lPrX5+0bkhDkFZXeGQfBvBcCKSluEGlD4uU4B9xxaMM323y8hYRuEz70JQDhl2
         xiBrzvUN7A05IStaEwIkamz+5HkfPfVK12o4MRcjofL0mprL9rEVbz4dU1ioYwGn9YpV
         xvyDybn09Qk430uNXcSbuZMXO392P3J453YrqP4s+wJuujlMrl0fC9uMqWhtj72kVyVy
         yCcucwCthDq1kpSXKQPUI0bR4vV3dgvjC4r3v0NZj43T7dHi5vVPpTYFIfcDc0Z34VGd
         3Y5HS7eFbvXOzYLqUv5zhKGSYP7/KBNUW9x+3bBkQC6cm4T0S/TvJ5cCVo0yLfO6Vhf4
         qFrQ==
X-Gm-Message-State: APf1xPCbAhcPbO9LcYgUa1VJ5PecQ9v4NhM5yJuocIGguWTdlOFoPbiT
        A/xgTWjy/A64WjktNvXzLns=
X-Google-Smtp-Source: AH8x2266K4Ydf27dBEaSLv+xy6lVpP0/MbQCWIE1yBMzUXIYg451/qjpvLFSezdqn2hQf80eZrMODA==
X-Received: by 10.223.159.9 with SMTP id l9mr7312016wrf.30.1518816499280;
        Fri, 16 Feb 2018 13:28:19 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f9sm13619078wmf.12.2018.02.16.13.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 13:28:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Mike Nordell <tamlin.thefirst@gmail.com>
Subject: Re: [PATCH 0/2] fix minor git-worktree.txt botches
References: <20180216204452.2153-1-sunshine@sunshineco.com>
Date:   Fri, 16 Feb 2018 13:28:17 -0800
In-Reply-To: <20180216204452.2153-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Fri, 16 Feb 2018 15:44:50 -0500")
Message-ID: <xmqq372062vi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This patch series fixes a couple git-worktree.txt botches from
> 4e85333197 (worktree: make add <path> <branch> dwim, 2017-11-26).
>
> Eric Sunshine (2):
>   git-worktree.txt: fix missing ")" typo
>   git-worktree.txt: fix indentation of example and text of 'add' command
>
>  Documentation/git-worktree.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Both patches looked trivially correct; thanks.
