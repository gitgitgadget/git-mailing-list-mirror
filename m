Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1CF1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 22:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeK2JVa (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 04:21:30 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41395 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeK2JVa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 04:21:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id z28so209040edi.8
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 14:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=vXJGbGYx/TphaGpKaXX6keYlwq8yu99kfNNUJcR+wRU=;
        b=Ppy2etqb9VUIf046lwxPaq31b0SIdkPU+DweEcd7rektkLAxpefs7J6Z9oEK1tDBSJ
         RPcswAEY66qePYoILo3NoSC4NSPYFSiIr9RgMTnYgxddfas8QdjLcaMLa9iGEmTksysJ
         NzVhD+ggkmaN4c5SPr7WbL7RsiEOGP9KJOg3H88CJ8nXI5FSYUfbpta28WUJQjBgVKq3
         +AN92YdRBCsFTAWuSWoQlI4LvcqWXO7ixs1EWk1TEv8F5/iy8BELP+ltrqs7c/aH4e63
         HplRo23LbHec8zf1xKwFQ120nxx2flS3nOTkaNjkZ/zj8qT7qSAWTSZcUlQjJdndnc9U
         MCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=vXJGbGYx/TphaGpKaXX6keYlwq8yu99kfNNUJcR+wRU=;
        b=dJyE3wIdhnNkSPI7IFvhrzizVgottSi0NPhPeUnuMRimC6wbKiKHpsh2Ov8RaJF2ws
         0M6A4W7osFlN0XaDCVSVQtEYcAWUzdDyxPGsF6y81uP7/KaxyyOITSxlk9805FKaI54U
         IcLc4hJ32duoi2RPPoKYQ/CxrRLPrMuEtsg1cOaCt3jIElB+X5V8xYtM5ch/GPswSptZ
         u5BcxstbncidvyH85UtojfDKfyPypFB3qENweasrRrU8VHSLV63Kd1/eWHKVDeK7A1NA
         XWUoi75pK7G1t4p5OkTPq/NW3uwFJorP5RbNhRkcAmxEEsWXJSAmdk/lxE/SGersNQ55
         AJew==
X-Gm-Message-State: AGRZ1gL+Q43dSmV53iPuupmhK5HX7uINHcJ6+I+4Bla9FCdLEeYt4c4b
        VyvClWfZktsPfDNFLPBoe2MKlbSY
X-Google-Smtp-Source: AJdET5fJ7f9ytOM+5UoH8GhHZSuAoNF2vsf60SHRUx0EJ+/1kXpoLPMNrIhFP8NolgNHqQk0XWkhwA==
X-Received: by 2002:a17:906:1f99:: with SMTP id t25-v6mr28279400ejr.36.1543443500906;
        Wed, 28 Nov 2018 14:18:20 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id m14sm66201edc.27.2018.11.28.14.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 14:18:20 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Add a new "sparse" tree walk algorithm
References: <pull.89.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <pull.89.git.gitgitgadget@gmail.com>
Date:   Wed, 28 Nov 2018 23:18:14 +0100
Message-ID: <874lc0zw0p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 28 2018, Derrick Stolee via GitGitGadget wrote:

> One of the biggest remaining pain points for users of very large
> repositories is the time it takes to run 'git push'. We inspected some slow
> pushes by our developers and found that the "Enumerating Objects" phase of a
> push was very slow. This is unsurprising, because this is why reachability
> bitmaps exist. However, reachability bitmaps are not available to us because
> of the single pack-file requirement. The bitmap approach is intended for
> servers anyway, and clients have a much different behavior pattern.
>
> Specifically, clients are normally pushing a very small number of objects
> compared to the entire working directory. A typical user changes only a
> small cone of the working directory, so let's use that to our benefit.
>
> Create a new "sparse" mode for 'git pack-objects' that uses the paths that
> introduce new objects to direct our search into the reachable trees. By
> collecting trees at each path, we can then recurse into a path only when
> there are uninteresting and interesting trees at that path. This gains a
> significant performance boost for small topics while presenting a
> possibility of packing extra objects.
>
> The main algorithm change is in patch 4, but is set up a little bit in
> patches 1 and 2.
>
> As demonstrated in the included test script, we see that the existing
> algorithm can send extra objects due to the way we specify the "frontier".
> But we can send even more objects if a user copies objects from one folder
> to another. I say "copy" because a rename would (usually) change the
> original folder and trigger a walk into that path, discovering the objects.
>
> In order to benefit from this approach, the user can opt-in using the
> pack.useSparse config setting. This setting can be overridden using the
> '--no-sparse' option.

This is really interesting. I tested this with:

    diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
    index 124b1bafc4..5c7615f06c 100644
    --- a/builtin/pack-objects.c
    +++ b/builtin/pack-objects.c
    @@ -3143 +3143 @@ static void get_object_list(int ac, const char **av)
    -       mark_edges_uninteresting(&revs, show_edge, sparse);
    +       mark_edges_uninteresting(&revs, show_edge, 1);

To emulate having a GIT_TEST_* mode for this, which seems like a good
idea since it turned up a lot of segfaults in pack-objects. I wasn't
able to get a backtrace for that since it always happens indirectly, and
I didn't dig enough to see how to manually invoke it the right way.
