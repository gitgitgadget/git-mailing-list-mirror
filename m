Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFDB61F404
	for <e@80x24.org>; Wed,  5 Sep 2018 15:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeIET6U (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:58:20 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44001 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIET6T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:58:19 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so6269387ioa.10
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=we0krhThFoxzDMRhzQwrIaFX7CHlB5ypc264biRLrtQ=;
        b=RouDSJ3Uf4cpWCOo7oBgbKw3wuZv+flsftIilikW5vn9Z0v++qxlOotVopsfQ8sun9
         4J2mQM+AVSlCYKBEPfyoYn1TrOJZbih7u267smQmmZsw0bOLkpdMTpahIk0/4BMFTPWW
         56Re0Lnxq2tT5eIsuCLivQ8qnGNgkh5JlSPTwpkrgCwTSg2XZi4sJyu+4v/vT5qNbh+w
         SIrBZhboDxyd31WKBhKUHwA8kAjVOqI4XrudxVPGPCNEoBl8UwG8PSkkOKjoe7Qh+QgI
         AcuQiA6d+MMMveoW1R7laW6FjdhvNvwdEq8cOh4sVJWIVpthmCyv7Oeesn4UXBf+tn5O
         lljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=we0krhThFoxzDMRhzQwrIaFX7CHlB5ypc264biRLrtQ=;
        b=Vc26Qx+uXVwCBLLRVg+cp7P8FOPGL4yV2XNGlSNco9UPnoAcz+ApBKNOIvgRbnWNgT
         V5RIfQeMb/CBcghS9hngTjWkyli01MDcGf0HL+uxQ2iCAOCmaTl3k7XxDIjiXkbFAuYL
         z4QnIuCUG0+EMKj5WNPHNy8YmqNgTrosGme3HKov8me5YblwhAl1XMJ+Ek3OabqyQxpI
         oWGpK/y74yyQRjDWgUnX0WmZ2ujZD2Z6fA3FxsMhekmiHjLCJRBLxPn0fKM+NcXS8Wjq
         gIpc0aQKXBFv+sT4FPvlaHZpWFNQQfVcWndprSceVZkfQcazIWFlUuJIwuHS4CFuSzA1
         dFiw==
X-Gm-Message-State: APzg51DxisVmmoqdVYpW8R+GMHb0+r+PxETcI0K1sjhISfXJjVVdtmcP
        78HS8gyscJruoEbmV4IQS6DrkZ4dmgZW6BmFSg8=
X-Google-Smtp-Source: ANB0VdaDc77S0TdWhO8wojUNWM54Aq6vDhM/nS7k9J5wsy4MSae5kzaX1c3Vsw1Zgn0TKZEUYSZvPycF/TmIg2/vrPY=
X-Received: by 2002:a6b:8fd0:: with SMTP id r199-v6mr25961792iod.118.1536161258144;
 Wed, 05 Sep 2018 08:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local> <87tvn8c166.fsf@evledraar.gmail.com>
 <20180902050803.GA21324@sigill.intra.peff.net> <20180902071204.GA2868@duynguyen.home>
 <20180902072408.GA18787@sigill.intra.peff.net> <xmqq36upcl1s.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AuWKxAdETaqYmcSY2VeLeWFyjnSYrK4GJeyG5ecv3OcA@mail.gmail.com>
 <20180904163807.GA23572@sigill.intra.peff.net> <20180904233643.GA9156@sigill.intra.peff.net>
In-Reply-To: <20180904233643.GA9156@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Sep 2018 17:27:11 +0200
Message-ID: <CACsJy8Ax4S9Sms6TY1dMV8M9-=hakEW8TCqn8yxb73Vbrpy_MQ@mail.gmail.com>
Subject: Re: [PATCH] reopen_tempfile(): truncate opened file
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Van Oostenryck Luc <luc.vanoostenryck@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 1:36 AM Jeff King <peff@peff.net> wrote:
> It turned out not to be too bad to write a test. It feels a little like
> black magic, since I empirically determined a way in which the
> cache-tree happens to shrink with the current code.

Aha! I attempted to reproduce with a verylongpathname and failed, but
then I had the main index portion in mind, not cache-tree.

> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 7de40141ca..94fcb4a78e 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -161,6 +161,24 @@ test_expect_success PERL 'commit --interactive gives cache-tree on partial commi
>         test_cache_tree
>  '
>
> +test_expect_success PERL 'commit -p with shrinking cache-tree' '
> +       mkdir -p deep/subdir &&
> +       echo content >deep/subdir/file &&
> +       git add deep &&
> +       git commit -m add &&
> +       git rm -r deep &&

OK so I guess at this step, we invalidate some cache-tree blocks, but
we write the same blocks down (with "invalid" flag), so pretty much
the same size as before.

> +
> +       before=$(wc -c <.git/index) &&
> +       git commit -m delete -p &&

Then inside this command we recompute cache-tree and throw away the
invalidated cache-tree blocks for deep and deep/subdir, which shrinks
the index. Makes sense.

> +       after=$(wc -c <.git/index) &&
> +
> +       # double check that the index shrank
> +       test $before -gt $after &&
> +
> +       # and that our index was not corrupted
> +       git fsck

If the index is not shrunk, we parse remaining rubbish as extensions.
If by chance the rubbish extension name is in uppercase, then we
ignore (and not flag it as error). But then the chances of the next 4
bytes being the "right" extension size is so small that we would end
up flagging it as bad extension anyway. So it's good. But if you want
to be even stricter (not necessary in my opinion), make sure that
stderr is empty.

The rest of the patch is obviously correct.
-- 
Duy
