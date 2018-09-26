Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42BF1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 15:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeIZVa1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 17:30:27 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35047 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeIZVa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 17:30:27 -0400
Received: by mail-it1-f196.google.com with SMTP id 139-v6so3366139itf.0
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzHm9WDCtv58FHCARjbHkTNzAziOB1omVUZSq+rmnMw=;
        b=L+Y7Hrd5t0tZqvXg53kW6/L0qh5frGL78tJW6sMGj/d1PO/hr/L9ZNR4v8XDuEnA4k
         wsHaklRV/+102dxTDPRq+pXQGRzz4uQLKZCFzEeeC5QZUFGIFiyjiH0K1SSAxWhNp2/g
         RNRIrbUlZXqP9zNRImantbyjjkKpsYiMQ0BUhmb0xhgHyY2qXTnEvGCBrKOpf4GEaNsW
         bG2cMPyHGr0/5tKYudzNPgEPVS9StQSo5CiPfDuktsVxr6KOmCzGvOSyDbrcBKaxCs53
         TJuOwDDLSVPafu0RZbZpi0o6cTPpOkMxKv+cMR01vzMduC1suA51SIvYfZNwOXoKA6WY
         3kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzHm9WDCtv58FHCARjbHkTNzAziOB1omVUZSq+rmnMw=;
        b=bgFjAI9QoFjopr1QGCbs49OKIWcddD/Q890nMPjiESdNbfTyL/GU2nPWZ2FHy8SCgw
         ghAy/aE0Pa3O4crZ1IP57dK1BxaYcYlirliqpyg+IwviAR9+S7bpoijsYTSawM/GQ0tL
         YpG8+rYsEsmpN3ARLmaXAJMuPb3dxl4uKCEO3H0R6l02Aem7gJNkRnN/ab0wPZdM9zzR
         CMG8LajqMiWywL2oyl+/pnMSQhxNRr01ksDnQRK59guJ4z86JQ7Gf/LPAjqunfHQTCJC
         +xfmKojg6MBzTiyIljTJIq3fhva88JTwX00RPs2aTe+k4D+Kc+dkkegGmnkEGi254rrf
         4vSw==
X-Gm-Message-State: ABuFfohcW5ARA89neJe1KI4k3rV507CI5NWU8Na2K040MzyBy7R04VG3
        oGRAfh5PJPZqa/I5azE1CYHrulNt3TTHuqxMXNHzlQ==
X-Google-Smtp-Source: ACcGV60hYXbOA1/l2x0SliRnNHhMJ5sCAhoDHGXRj0qGXdmSGlxJTr1bBcTN1EzgqPW7r6D4aKQKzpwromLNd6QcNDs=
X-Received: by 2002:a24:7605:: with SMTP id z5-v6mr5117642itb.62.1537975021608;
 Wed, 26 Sep 2018 08:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
In-Reply-To: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Sep 2018 17:16:34 +0200
Message-ID: <CACsJy8Ac0TEpfHK6-pS_CMzGrYjmkaT_bM0V4kXfNxqY0TONtg@mail.gmail.com>
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 12:29 PM Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
>
> I often use 'git <cmd> --help' as a quick way to get the documentation
> for a command. However, I've also trained my muscle memory to use my
> aliases (cp=cherry-pick, co=checkout etc.), which means that I often end
> up doing
>
>   git cp --help
>
> to which git correctly informs me that cp is an alias for
> cherry-pick. However, I already knew that, and what I really wanted was
> the man page for the cherry-pick command.
>
> This introduces a help.followAlias config option that transparently
> redirects to (the first word of) the alias text (provided of course it
> is not a shell command), similar to the option for autocorrect of
> misspelled commands.
>
> The documentation in config.txt could probably be improved.

While at there, maybe you could also mention the behavior of "git
help" when given an alias, in git-help.txt. And you could also add a
hint to suggest this new config help.followAlias there.
-- 
Duy
