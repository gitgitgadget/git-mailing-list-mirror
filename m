Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3387D1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 18:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbeBBSXq (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 13:23:46 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:38652 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754564AbeBBSXa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 13:23:30 -0500
Received: by mail-yw0-f179.google.com with SMTP id m84so13854757ywd.5
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gB3lr545oDWbV1XD9gDDglnGE4/N7v0Xq7KYjNjNGUY=;
        b=dp64g9NF4wj21PgYL7AvChx8U/Ceo+upRff2ZXsGOU4Lad4mElcqm8UuaFbP7PWzt6
         790lmy7voORHMzT2wo6d9xR+Eixo10tGGzEJyTqmuIng9ZUnqlRgkQZ+SlcfB+y2VTeZ
         K2akq3HzzVeYLRPRCbvZY4bsjTilZW9iyvgVAT4kSA/GfIYxgqIrkUJtQH19TKzoIMON
         AxsabgxhgJFoTkmyvHGjSuXFTDGl/hGu+E42XcVZmE8/jxrTWQsX2Tre8DKU22+pvqUu
         MgJXDddB5eHU/szncxPFH0iysmuLM/NdB4ERuQJQMUySYsuUB7Dtp2tAwn4uc5hhl1g+
         Podg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gB3lr545oDWbV1XD9gDDglnGE4/N7v0Xq7KYjNjNGUY=;
        b=phkhd1lbuIZrsIGmzbxXH6+/t2O0f5GkLndnOMGwWEcOFraCS6JZIimyD9eFCg5bAC
         8jtVHHkWCdKy63O90w2qMpziKuYauRiA9ZBd6xIDnycI1aCFdzMtPepw8uRiOXrmN+DX
         NOKsrtLlzP7D7BEcYWXnk7BLttlfrrnhaUMlM1qtQLIUhqm8+gb/xJwN4I0WIrS7uCbR
         /S8d1l+t++e93GIkErTmjIT/n9tRsSFyLxy7RZRVSck0QKtagwbgeYhim9qJsULCgwQA
         R/B2KmDnX01chIuCCNIOfhHM8uWknywh6mmmy+pZm4iBo2gPBpEC/Rr0yYz0IP/WtT10
         RulA==
X-Gm-Message-State: AKwxytfOx0guTJx0De4mkrkEQaLjKWFaXRrMiu+15GOEkEJXRn+8PCra
        AqJPsclogBnRFS2goBgXheyAZft+++pkqBZnm3Zv4A==
X-Google-Smtp-Source: AH8x227yPbZ/iQ1nV5vvhF1HagKUpBUMfWIRhXAZ5AWGm/yYXbC/8jR3dAH+X4OW15fAa/f0MK3ngZNWWDqQWwU5AVk=
X-Received: by 10.37.37.87 with SMTP id l84mr6595718ybl.386.1517595808796;
 Fri, 02 Feb 2018 10:23:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 2 Feb 2018 10:23:28 -0800 (PST)
In-Reply-To: <CANri+EwfsgS-s0TeeX0E6XoCnmCeq=CB0UDQ9=gjSXbe8C_5GQ@mail.gmail.com>
References: <CANri+EwfsgS-s0TeeX0E6XoCnmCeq=CB0UDQ9=gjSXbe8C_5GQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Feb 2018 10:23:28 -0800
Message-ID: <CAGZ79kZX2FsEjD04zr5-oufU6dLhiOhBkxv4u8VEwL0OPRFtiA@mail.gmail.com>
Subject: Re: how to ignore whitespace changes with --color-moved (git diff
 move detection)?
To:     timothee.cour2@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 6:13 PM, Timothee Cour <thelastmammoth@gmail.com> wrote:
> this PR from october 2017 was discussing a patch that'd introduce
> `--color-moved-[no-]ignore-space-change`
> https://public-inbox.org/git/20171025224620.27657-3-sbeller@google.com/
>
> however not sure what happened since then as I can't find in `git help
> diff` options even after `brew install --HEAD git`

I proposed it, but it wasn't going anywhere, because we seemed to have
a little disagreement over how a reasonable UX looks like.

The previous patch[1] in the series you link to, proposed 6 new
command line flags (3 flags + their negatives), which was deemed
inappropriate for the user ("which combination of these flags do you
need to give to get a good result?"), but I cannot find a reference for
that, I just vaguely recall that discussion.

[1] https://public-inbox.org/git/20171025224620.27657-2-sbeller@google.com/


> it's a really useful feature as it's a common use case (ppl move
> blocks and reformat in same PR)

Thanks for the encouraging words. For now you can
use '--color-moved -w' as Jeff King suggests, but that may
not be exactly what you want, because this
* creates the diff ignoring whitespaces
* and then colors the moved lines (also ignoring white spaces)
but when you want to
* obtain a real diff (no trickery with whitespaces)
* and then have some coloring aid ignoring white spaces
you are out of luck for now. Maybe you have a good idea for
the UX design? (What do we need there? Maybe an option
equivalent of `--color-moved-[no]-ignore-all-space` is sufficient
for all practical purposes?)

> If it's not merged in git repo yet is there an easy way to try out
> this feature? (even if experimental)

Can you compile Git yourself instead of installing it from homebrew?
(See "Build Git from source on OS X" on
https://www.atlassian.com/git/tutorials/install-git for example)
In that case, you can just patch your local version of Git with the
patches that you found. Download them as raw, and "git am"
them before running make.

Stefan
