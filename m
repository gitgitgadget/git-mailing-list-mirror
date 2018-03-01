Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 875CE1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 18:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033800AbeCASJK (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 13:09:10 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36150 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033196AbeCASJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 13:09:09 -0500
Received: by mail-qt0-f170.google.com with SMTP id c7so8708315qtn.3
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 10:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Rn4TMyYgrUqFL4WQ/LEe0Gr3AkdvFWxgJ1yKJgANU9M=;
        b=LSDE0W7tG0mi1S/z1fVjvZEUx4bFqZVfRpDw0rKmhzqJr4kCUrptdLp8boHa2TC1S8
         972jB69NBLoDjKJykJYFznKbNlztvDexNhCMOhqamWf+BpE9XSkA5+EhLQ5Zz2vGtF7R
         AylyaF1YPEIuY6iE8tX4KE7Dbp9cTA+xywrv8LCOzNENyRUdTlMT2SH6U74eZ+0xO0nb
         7KzFLXF2pX6hANV1vTVCdWvlS7cFg/UsB+PevS2zh3fYMqomxbg/qZtGu4v8cWmz3OLq
         Ozf3zR8VEg4WUHV+5MmhaFRyJW8n8d8bMDuYG0ghkS/k8+W12BoBGnY3ESUb/1oDAGEc
         2qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Rn4TMyYgrUqFL4WQ/LEe0Gr3AkdvFWxgJ1yKJgANU9M=;
        b=tDm//jSQkWfcNFLU60zUyvqFQVic6XeqauFZR9Rm2t2NyUfQutp9Hj0pHSbHtzCQJx
         mZx44OjwyMjpLyeG23yIRbCixTRM8LD5FhZDZhQU/z0CwTt0UjTtxaEigWLOM3m3iXd4
         J2a1KpgjmeaohnoZNBdgCJ8vwk61qnGu9gSQXK55J39TGWBEJ4jV6r8NYwIgLUrnevKJ
         325YIBA00JKeavTUBh45j6Q9jKJwXas+z3sGSToJSSOjei/ALbvWvgm8tVZ/wBKLd7dY
         8cJYoEarwJPUJ7aJWFIRwWWMxDM9Kvnx5x+yMFb8pGTMXi69KgceJpgroPtKDjPN2Ikw
         YHrA==
X-Gm-Message-State: AElRT7EiJ2D0C7aSKKahD7PU5jyj1nACm6yts6vne0TPDdnkYkvEzROs
        V/9fj7HMTCqE3Az6vRmYlWdPvOH+j2vpWlYhlV3sGA==
X-Google-Smtp-Source: AG47ELtMGPeFqvKsath1WW60MmsMRPnqprWeCXSVzA/QOBEOPNqeVTudf8knJD1lCsbXiicJX9jerXhWV/S8q+v5j+4=
X-Received: by 10.200.12.198 with SMTP id o6mr4157448qti.246.1519927748603;
 Thu, 01 Mar 2018 10:09:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Thu, 1 Mar 2018 10:09:08 -0800 (PST)
In-Reply-To: <aa98f187-4b1a-176d-2a1b-826c995776cd@aegee.org>
References: <aa98f187-4b1a-176d-2a1b-826c995776cd@aegee.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Mar 2018 13:09:08 -0500
X-Google-Sender-Auth: 1s0rcFOzuaHiWj7C6UbUkUrxXYg
Message-ID: <CAPig+cSGJhNR8dapLXN0TU8ZpTqi7m6OQf_cCGmHc9FLGcwNyg@mail.gmail.com>
Subject: Re: Worktree silently deleted on git fetch/gc/log
To:     =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 7:44 AM, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=
=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2
<dilyan.palauzov@aegee.org> wrote:
> A (branch master) and
> B (branch g) which is a worktree of the first.
>
> /git/B g>$ git fetch
> [...]
> From https://...
>    13e4c55a0..02655d5fb  g -> origin/g
>    c37a3ca25..bc7888511  master -> origin/master
> Auto packing the repository in background for optimum performance.
> See "git help gc" for manual housekeeping.
> /git/B g<>$ git log -p origin/g
> fatal: Not a git repository: /git/A/.git/worktrees/B
> /git/B$
>
> Please note that on the second last prompt there is <>, so that git-promp=
t
> has found the neccessary information and this was this was later deleted =
-
> by 'gc' or 'log'.
>
> What would be the procedure to restore the /git/A/.git/worktrees/B
> structure?

Can you show us (via 'cat') the content of the following files?

/git/B/.git
/git/A/.git/worktrees/b/HEAD
/git/A/.git/worktrees/b/commondir
/git/A/.git/worktrees/b/gitdir
