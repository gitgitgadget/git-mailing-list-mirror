Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82281FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 18:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbdFPSXy (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 14:23:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33596 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752976AbdFPSXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 14:23:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id f90so6423015wmh.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=b3VHzXBT/1ZlU6FrWFXfyv8Xz+VAbLU1un/hapTQokY=;
        b=bKZBR/2gOjkzauQkESQP/tRan5CgQmG4JR5VZKjFPYx8a7VqkTwvm+CNGfw6f3pOe3
         /NKhPKjaTx4rseRCfQ8OxqHoh7AHXytiGA+tiEZxkRzva0D8gTmxute2Gu2Je68u1sCv
         bUJuIfRoFMLqjYikEDjRTKcf4V5OriAcsmCGMNqE4OQNJ/plMSbWiMgR9Ygvcg5oRfun
         kHwJ5ALfFiinibcFshIkXV9uEt0vXEPz3o4l+GdDlCkopoiS2FKBUgpj2U3H2KRIvqSF
         oHtfmaipNntc9+VcnSEa68kC8HUS+GG14c58ns0gXpSg3L/IMafgAPPz/xN/bqaj4kdS
         Rh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=b3VHzXBT/1ZlU6FrWFXfyv8Xz+VAbLU1un/hapTQokY=;
        b=LjF3W+LIgHj/GZSGBHnXRKqD3kUKV9rom1alYf6eAyQMRhA1UJn2gO76f/ms2QIFho
         uEgNqSuXJR2uzZUrimy58Tp37wG0kl4TMn7ctOtBFJ30DgSBfnl7UEzzCw+c0CttgHxN
         oDcoZC4YAwWrwTULa/wGtsKhebHM7QMjX5YDd7733IoOOKDWq+XoLKQUYuCLRYFqfSfG
         dszM/joPnHrJBCfg+sGzjQTEeNQ6RN+5cz6jA/EQhsbgceXUc6kZYCuT4K9dq3JUyijA
         JhrPo0vQXrFNypv134tTnhkpj3E5kwIJI5P8xpevVZxzot52OxPfhEAIp5+3rS+dN6mA
         oYXQ==
X-Gm-Message-State: AKS2vOzDowD1yiESxiQaNBQ9zpoMZKJZH9cdCDc4JFjgN8yH6k9X1Unq
        4Wk9zxQmECsFgA==
X-Received: by 10.80.146.120 with SMTP id j53mr8332663eda.17.1497637430549;
        Fri, 16 Jun 2017 11:23:50 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id c23sm1201369edc.34.2017.06.16.11.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 11:23:49 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dLvuO-0003n8-Ft; Fri, 16 Jun 2017 20:23:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCHv5 2/2] Documentation/clone: document ignored configuration variables
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com> <20170616173849.8071-1-szeder.dev@gmail.com> <20170616173849.8071-3-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170616173849.8071-3-szeder.dev@gmail.com>
Date:   Fri, 16 Jun 2017 20:23:48 +0200
Message-ID: <87wp8b94gb.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 16 2017, SZEDER Gábor jotted:

> Due to limitations/bugs in the current implementation, some
> configuration variables specified via 'git clone -c var=val' (or 'git
> -c var=val clone') are ignored during the initial fetch and checkout.
>
> Let the users know which configuration variables are known to be
> ignored ('remote.origin.mirror' and 'remote.origin.tagOpt') under the
> documentation of 'git clone -c'.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  Documentation/git-clone.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index ec41d3d69..5ceccb258 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -186,6 +186,11 @@ objects from the source repository into a pack in the cloned repository.
>  	values are given for the same key, each value will be written to
>  	the config file. This makes it safe, for example, to add
>  	additional fetch refspecs to the origin remote.
> ++
> +Due to limitations if the current implementation, some configuration
> +variables do not take effect until after the initial fetch and checkout.
> +Configuration variables known to not take effect are:
> +`remote.<name>.mirror` and `remote.<name>.tagOpt`.
>
>  --depth <depth>::
>  	Create a 'shallow' clone with a history truncated to the

Just so we're all on the same page, in
CACBZZX740rcQKnfkRXgn0+fmeUDaWL-Kz5WzKeyUvBhXWPwPhg@mail.gmail.com I had
the feedback that this patch didn't make sense on top of 2.13.0 since we
have --no-tags now which should be documented here, but you replied in
CAM0VKjmz7MpVt3oPBuwHiXNoLkZmdmrZ66ggk+aY5-4oVkE35A@mail.gmail.com in an
answer I understood to mean that this was a patch not meant for master,
but for the main track.

But this is now cooking in pu, Junio: is it clear that this patchu
as-cooking ideally shouldn't land in next/master without the fix on top
which I mentioned in my mail above? I can just submit that as a patch on
top, but I'm confused about the current state with this cooking in pu,
so I thought I'd ask first how this should be handled.
