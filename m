Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D1B1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 09:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeJYRrU (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 13:47:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38363 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeJYRrU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 13:47:20 -0400
Received: by mail-io1-f68.google.com with SMTP id q18-v6so5012723iod.5
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfmP8dVW5gRu5UlcDnHUIdck5sa3EHpChbXWd7nTKKU=;
        b=U8dYRBvoGviFVfzKv6hPNt7C9ezBY+wLI/NKoLjRokbtpIbTrbkm+ltRt/yU0qhKr7
         N4nXCU2e64UV4rDecdui88ZYtlnOxIXsOrquKqQgajDz9C7B6MmUG+FVHi5v19/yEkQq
         8stLX+bQzFV8d92xWMGZ7ZyBjYY5ImZIhpr2vU909m6UkzBl9xam7nLY6qgNbY1Pd0HC
         0b4nOjYOgOb1iG+f3/gkt+tR62dLR6zV78tdNiu6DVA7fGS2Fi5drOsYCAxWS6V+xL9A
         a2TZQjiexFCAH3VIueV+oS3me8Pz1vUSYiT2boD2ltqNqVto5VW8zarJDo76fbnWQCwT
         LS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfmP8dVW5gRu5UlcDnHUIdck5sa3EHpChbXWd7nTKKU=;
        b=WdcBlHEurroXYyJqfmG5zz6cgNBBVuyGXIq5d/vYNlzvvPqXh4HM2Fvp1GZzYMFD35
         /m/MmL65WpeHGZ5bGaYGGOG5Geiu+AjCrERqq8x5uhECbQg+GCjhmQ2x6n8/KqOc7W5R
         CjYD3crLRV3Jxb70R55PodM/bsEc3S2EOz4kFE2TAfd+ll9SxaR9BxFaV4R7CjbizPWD
         NA/Ud127tNwo1USXR1l3Vr9v907ZtV/fvxkJEAiZEtV88pLrKZO7p5DzTZsl/JHd27lC
         4auQdCrxj4mULjyWrYb7kRmQTTJpW7egbxXnRoz9Jb8bVg67K1sYcKeyQ2Y1ZSnwcO5S
         IAxg==
X-Gm-Message-State: AGRZ1gK6EFVav307E+NpPMkvO//cjcgr7XR6ppk4PdZbyvvIrq76R7iv
        ATf8sLnlYwOzqFz3yIrepXcgRT3jYxYJGpPmFJE=
X-Google-Smtp-Source: AJdET5ej8OyXlzXixMSHllILXUU4C17QybDrNL+FmG7ttkMY3HkELetfwXnVauAz2wtqYyU9vfffXIakLMamq50m5Fg=
X-Received: by 2002:a6b:3e87:: with SMTP id l129-v6mr367852ioa.269.1540458928285;
 Thu, 25 Oct 2018 02:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181025001406.6729-1-carenas@gmail.com> <xmqqlg6mk2pd.fsf@gitster-ct.c.googlers.com>
 <xmqq8t2mk0jo.fsf@gitster-ct.c.googlers.com> <CAPUEsphHsWVzdGXBB0EOSNuUb5gNgjyJ+i7PnDJx7LBqejQrNQ@mail.gmail.com>
 <xmqqwoq6ih34.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwoq6ih34.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 25 Oct 2018 02:15:17 -0700
Message-ID: <CAPUEsphFSs3gmo2N6Oi7rhhsgU2BC3ijZH4yxbcF1R8SKQLjhg@mail.gmail.com>
Subject: Re: [PATCH] sequencer: cleanup for gcc 8.2.1 warning
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, alban.gruin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 1:08 AM Junio C Hamano <gitster@pobox.com> wrote:
> For a single-use, not using the macro and just using "%s", "" should
> suffice.

OK, will send it as v2 then but would think it will be better if
applied as a "fixup" on top of the original branch:
34b47315d9 ("rebase -i: move rebase--helper modes to
rebase--interactive", 2018-09-27)

would be a good idea to include also enabling this warning in
developer mode so it doesn't sneak back?, presume as the last patch of
the refactor below?, FWIW this is the only case in current pu, and I
suspect the sooner we add it to next the less likely we will find
more.

> If we want to hide the "%s", "" trickery from distracting
> the readers (which is what you are trying to address with your
> touch_file() proposal, I think, and I also suspect that it may be a
> legitimate one), I tend to think that it may be a better solution to
> introduce the EMPTY_PRINTF_ARG macro and use it everywhere, in
> builtin/commit.c, builtin/difftool.c and wt-status.c and not not
> just here.

will work on this in a different feature branch, but I had to admit I
don't like it for status_printf case where it was IMHO a hack to get
the new lines to begin with.

I would think it would make more sense to call a function that says
"write_ttycolor_ln" instead for those cases.

Carlo
