Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1723B20D12
	for <e@80x24.org>; Thu,  1 Jun 2017 04:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdFAEKw (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 00:10:52 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34026 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbdFAEKv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 00:10:51 -0400
Received: by mail-io0-f193.google.com with SMTP id 12so3687829iol.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 21:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HOwSQDvxz11Ta0xIR/jPKJmO2BYBnI5X0KVzDy52iFs=;
        b=HozATM3tjOdZDjE05YLhkot5wOvnf7y+OW8cNffOM7HpzfDP1tzzE/6JkDOSYww6Tw
         c3qzGwtHfVhmTMI3Wy5AJAHKSx3GtKN80z4SHJmB809IHdKu0zeIMxIgKa3PkZbwkFfQ
         1/3CKiNku6+tQtmhklXnQldYa+RDpy50sqXufFUNQu/3afeMqbU9CMtDfW52PxIsfvD8
         ycv4HTve2Bp2FUssnv37s0fwYBghIgp9jSvKEoKMbUjsCc3E/0s7on8rQttM0WaIfP1A
         OpBDScJLpS+CYc2GM1rkDyH4m/T5jovm2GauJi362db/9AP9lTvzMRyT0CbLRIodn+yL
         n4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HOwSQDvxz11Ta0xIR/jPKJmO2BYBnI5X0KVzDy52iFs=;
        b=YVatKv9bE1Bnquu7IU0AKv+dmxihSa4E2EZmLSz7sgeHi0LyLY3/UdQh6IVwLtUjXK
         +7Z1lzPcVp8zZJfIeP5/i6YxGtu2ubDM+80fVjv3T8h6l/YIKcOjZnSCS7VQZVqqj0Fk
         P3Chk8fsH6YJo6w0bPKKhWgiQyTzmFunl/rls1IIy4cI6oWIFm+a8d1Grzh5CEPK4Uxp
         rsU9Bt451MHJhktnhj5LpWIN+dL0pCrlaChIimvBQ7+w3yMGmrHyUQp1ugjTXXsVlPAt
         C2/enMfmmLc1JRG0rsEEam3p15tREKosNxG+uMLxk4SsL92hALfXUOvh8Ue+U0d3ZMmI
         StUA==
X-Gm-Message-State: AODbwcAH6x0FO2zGUKX7Mf0QP3eHbltmsTWT6ctkKNSq1jehwVp6iQr8
        8V3By0vsYnPf4Q==
X-Received: by 10.107.84.1 with SMTP id i1mr23977315iob.72.1496290250113;
        Wed, 31 May 2017 21:10:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id 93sm7924327iod.17.2017.05.31.21.10.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 21:10:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 1/2] format-patch: have progress option while generating patches
References: <20170531150427.7820-1-kewillf@microsoft.com>
        <20170531150427.7820-2-kewillf@microsoft.com>
        <20170531220100.t27w3w642sn33h7s@sigill.intra.peff.net>
Date:   Thu, 01 Jun 2017 13:10:48 +0900
In-Reply-To: <20170531220100.t27w3w642sn33h7s@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 31 May 2017 18:01:01 -0400")
Message-ID: <xmqqpoeo73g7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As I said above, I think I'd prefer it to require "--progress", as
> format-patch is quite often used as plumbing.

Yes, that sounds sensible.

Initially, my reaction was "Why do we even need --progress for
format-patch, when it gives one-line per patch output to show the
progress anyway?", but if that output is redirected to a file, of
course you'd need --progress independently.


> Should this use start_progress_delay()? In most cases the command will
> complete very quickly, and the progress report is just noise. For many
> commands (e.g., checkout) we wait 1-2 seconds before bothering to show
> progress output.

It is better to use the "delay" version for progress meters for
commands that may or may not last very long, and this may be a good
candidate to heed that principle.

The subcommands that use start_progress() tend to be older and more
batch oriented operations, e.g. fsck, pack-objects, etc., that are
expected to last longer.  It may be a good idea to convert them to
the "delay" variant, but obviously that is outside the scope of this
patch.

> I would have expected this to say "Generating patches"; most of our
> other progress messages are pluralized. You could use Q_() to handle the
> mono/plural case, but I think it's fine to just always say "patches"
> (that's what other messages do).
>
> One final thought is whether callers would want to customize this
> message, since it will often be used as plumbing. E.g., would rebase
> want to say something besides "Generating patches". I'm not sure.
> Anyway, if you're interested in that direction, there's prior art in
> the way rev-list handles "--progress" (and its sole caller,
> check_connected()).

These are all good suggestions.
