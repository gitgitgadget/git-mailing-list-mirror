Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F6520179
	for <e@80x24.org>; Sun, 26 Jun 2016 23:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbcFZXAZ (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 19:00:25 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35670 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbcFZXAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 19:00:25 -0400
Received: by mail-io0-f179.google.com with SMTP id f30so139113706ioj.2
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 16:00:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FZmrs18SfEOB00PilaqASUIepy0Nwvgu7Ltjt0FXMHg=;
        b=z+kAUtYseFmYsrTwV/dh3lnrU8sTQ+U5NWkXCGStMAX3y/iy9RM9CCGQqBhS7DffQB
         G80poLN2UyEVMhNhbtHPygwvdumVQ77glKzdV2RHBa31noOervtG9x59Wq4/X/MfTnbz
         v8t1nc5/t/OHOrmI1TYQeWNpuwjM10e2seZqQooqkb3/UTh81/afM7wS4iCtPZKw9JAK
         yHrmVTXyMVCl0Z2Md+Kihyw8Ymf03A7U2DExlV28Ql70h6wDU3gHFncJR3+Rv8yIzHSJ
         1PnU0JLY+YQlwx82cZRYJXKUPBPpsF4OVZtUdFO2PGtVh6RSzDXlUqPr2t0S/q96Gf+3
         nJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FZmrs18SfEOB00PilaqASUIepy0Nwvgu7Ltjt0FXMHg=;
        b=k0/JXs7i+5Q6LR5CA0Ccsx/hIz0b87lXBcF3enbcutzmcZZepbv3gZd6SKnrZGDPki
         cetvWNJgp0/FqQOjOEANY1W7/9eh6dWTUpVfkBg/fJYE3KJ4nDBJdEI4POIfZPK+1BsY
         bde5Snd8/3su3Y2v/KMLAuJsM5i1kcE95ldUDzKRfVG9wpQmBGcH/Ggy8xjiOipRsC76
         ++BJQbwmcAksySIpL2H5BndCx8flQUoEtBfxV2LkYvJnBKbsLJnFxrNRWE5d+dNcIMrk
         0XRwlYKoWOuWXKX/K1z6HlYtOvahXqMyizhaGfxXWIhDV81EcZ8mMviZ7LNls1LZ/cdU
         LxGw==
X-Gm-Message-State: ALyK8tJC888Ur86sfV9UUGRixHI0iLOrSfCedESY+zmsKEDb3IV1KqrLpaH7m1AHgfowL/BA5AIthgTW3my7BA==
X-Received: by 10.107.25.7 with SMTP id 7mr14126796ioz.104.1466982024183; Sun,
 26 Jun 2016 16:00:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Sun, 26 Jun 2016 16:00:23 -0700 (PDT)
In-Reply-To: <xmqq1t3ldpdl.fsf@gitster.mtv.corp.google.com>
References: <20160625051548.95564-1-barret@brennie.ca> <576E2FA9.7070008@kdbg.org>
 <1FEF5F90-6534-4D91-B27C-16FE6D16EC3F@brennie.ca> <xmqq1t3ldpdl.fsf@gitster.mtv.corp.google.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Sun, 26 Jun 2016 19:00:23 -0400
X-Google-Sender-Auth: C0IchVEpn0w-AEF39CeALKh27Nc
Message-ID: <CAPig+cRNUZZBw=F-Q2f3Ehc-8T2iBp4kvDusNRGv4ea5nihQVQ@mail.gmail.com>
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Barret Rennie <barret@brennie.ca>, Johannes Sixt <j6t@kdbg.org>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Michael Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 25, 2016 at 3:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [...snip...]
> And explained that way, it becomes clearer that you would want to
> name $HOME/xyzzy-1/frotz worktree after "topic-1", not the default
> name you would get "frotz" (because the default gives you the leaf
> level name of the newly created worktree).
>
> After the discussion above (which may or may not match what you
> raised this topic for), I think a feature to let you override the
> default name makes sense.

One thing which hasn't been explained, and about which I'm still
confused even after reading this thread in its entirety, is what
Barret means when he says that he "breaks" his worktrees. What is the
nature of this breakage? Depending upon that answer, would "git
rev-parse --git-dir" be sufficient for your needs? Or, would "git
worktree list" be able to give you the desired information? (As
envisioned, "git worktree list" was intended to provide much more
information than it currently does, such as the .git/worktree dir
name, and such an enhancement might be welcome.)
