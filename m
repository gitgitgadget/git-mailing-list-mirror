Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C792027B
	for <e@80x24.org>; Wed,  1 Mar 2017 22:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbdCAWQf (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 17:16:35 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:35467 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753049AbdCAWQe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 17:16:34 -0500
Received: by mail-it0-f52.google.com with SMTP id 203so107799186ith.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 14:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mPLBDYyo8EmbW7DuPVT2U8V3vCO5eVJLUSdUN2fM4U0=;
        b=GGl65lsZGtqnyTTlzz/FxjPptWO0UqRB1LaXOVTbYlsfLH713Vs7IoZcfklwxi2kFE
         fR0NC0o2HSittREFUDC4BPVp11j6XwexuME2eovYMnX+WLVi7bGRIjwTV9LpCa4lVX1V
         tpBaXYf7zzO186009vkeWSBqHM+WP+Thh2I8e2FiWVIa8q2wqaYZzRedAA8nWeBcXPOH
         fNumk7WvjZhgOK1LOahjS0QcWFi94EGEE/AJZq+BiXH1ilIk4FXPOh2xgjsigVYOEgx4
         75qIkOpVsIqzQX2dCBM9xIKyq2xnbrMOq+wyTQ9p/vCedW6GDha7XVcS7wePGRaszey2
         oWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mPLBDYyo8EmbW7DuPVT2U8V3vCO5eVJLUSdUN2fM4U0=;
        b=tVJgzlurRskQDKSY5k2Ld3KZ99iwD71gn4PIhrVC/ZetXLbNEXHVSjBSFr+NOB6fRT
         uDgzmT0vH4dxOt8yz/VZydU8SQh3OgQuutuOO+A/oxGt3I/GgQ3cMMC6WBH0oMLbe/XE
         I0f2gddwTpVwCHkbuuNM1s7U+LV/0zcRamq6BURYJWFoNE11sSAn276CDeDn0i1b9RaD
         U1NVGul30KRSp3k09Lm9ubBjPG0ZKcIBVsMXsF0ksuycTQOeHUBo97Rcs94kvjvCZs3t
         LJyk1DUWr+uVxvyZsqsGa3LQw4wbiPxjy/mZFCqieF/GWotciWjh6ZgKpipbCOLZ+sM5
         5YaQ==
X-Gm-Message-State: AMke39l4ZH1Tx8lYjAl0pJQecDR5Rjq+CDVJSiSXheiOSiOmgJoin+Mxc281/pgO4hmhHh8QUjopAaZG2mWBOw==
X-Received: by 10.36.204.137 with SMTP id x131mr6829414itf.35.1488406565881;
 Wed, 01 Mar 2017 14:16:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Wed, 1 Mar 2017 14:16:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1703012227010.3767@virtualbox>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703012227010.3767@virtualbox>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2017 14:16:05 -0800
X-Google-Sender-Auth: q2-t66aQ6KfT2lg3K_pMRbL2SXg
Message-ID: <CA+55aFys5oQ0RySQ+Xv0ZDussr-xZNh4_b3+Upx_d9VPWmpM8Q@mail.gmail.com>
Subject: Re: [PATCH] Put sha1dc on a diet
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 1:56 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Footnote *1*: I know, it is easy to forget that some developers cannot
> choose their tools, or even their hardware. In the past, we seemed to take
> appropriate care, though.

I don't think you need to worry about the Windows side. That can
continue to do something else.

When I advocated perhaps using  USE_SHA1DC by default, I definitely
did not mean it in a "everywhere, regardless of issues" manner.

For example, the conmfig.mak.uname script already explicitly asks for
"BLK_SHA1 = YesPlease" for Windows. Don't bother changing that, it's
an explicit choice.

But the Linux rules don't actually specify which SHA1 version to use,
so the main Makefile currently defaults to just using openssl.

So that's the "default" choice I think we might want to change. Not
the "we're windows, and explicitly want BLK_SHA1 because of
environment and build infrastructure".

             Linus
