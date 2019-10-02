Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AFA01F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 07:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfJBHOy (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 03:14:54 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:35850 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBHOx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 03:14:53 -0400
Received: by mail-lf1-f50.google.com with SMTP id x80so11904599lff.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 00:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzoJTgat/jspIWZT1W0eGqkga5Gq02NxjgBC5HitQzE=;
        b=TaDKhTMlMz/4Ueh3o+OQmyvPzFovFkZbXsrKQYvXIahLlX30g9qV07FD1FLOn8ubQn
         Inba3tjclk2PAmjOw73OO7256Nc3hH37tLMr4kVEe93dQfOkzdMFZEVsD1zadFkj5Ofv
         ULdFb7YVDSBtiIidZmL7qCDAzXeWFSCLgLsvX3QvYCGN89sFtXX0HqUPQ5wha3pPNFNj
         qWm+WuvcpPY6HF2YvsADfrOYGojmtY3dCeVriHFFF1kdmgwV/w9HUItxfDPvCfzj1e5B
         IOrZr+OOE3Mt6P6CFXOaSrFBcIUhlzgh+Puxahb5af8zhJfMdc341tVqjMCK7GvpOcwx
         NmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzoJTgat/jspIWZT1W0eGqkga5Gq02NxjgBC5HitQzE=;
        b=n3yrpzsUVaoF3lU5U2lCL+p1bP3ptRDYqXkMDOVoZVKg6XLxOLPaWrOJz6kjuuzlI2
         iWc+fBEZdRWfpDA6kGzkLgfQABJpUrnAY6G9rkgO9QDSqv2pF4e5PY8sucRcFkm2SuXW
         utjpxirXPtaQPCvve7+4Iks7nRWJm5BlCpw3wQihatfQH0XD/8ZfXkh0+8zOJ5r8JBGg
         VQqD6C5+s/unCfOESXno7w+5OX7T4kuTwrNoEyOCxIG9fpXuujf7ivuwgZoYkF1qgcnt
         WN0IDkSMUu2kOyYeZIYfmSXElaQeSxO/EHgQLqa5YOPtaRost8ZQaogfZN7v/IFfuUp3
         FQsg==
X-Gm-Message-State: APjAAAWVst23BiC45TpiTG6fNH+WJFuPN33e/6gRr1bao31G0lTXvGR9
        HeIJiVHzOps0xwfab1a6+YO/nrY5/HMUA38o77o8xh3i91E=
X-Google-Smtp-Source: APXvYqx+9oORUCvyjMWA1Gh7YaJceAIA9ao+76WmBFTRb7JLvVV23HA56bar/BnPdTYBWJHi7MTPkgoUMqCrRAtItyQ=
X-Received: by 2002:a19:f801:: with SMTP id a1mr1139559lff.166.1570000491703;
 Wed, 02 Oct 2019 00:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=K15nUcnsJWOP87uMMjeQmTgAeO_6hnr12k2zuNQjNyBw@mail.gmail.com>
 <91e5b3b0-08f9-66a8-ebdf-90effd34c888@kdbg.org> <20190926191545.ro7w6lbtlpbyxpk7@yadavpratyush.com>
 <9d77189d-a357-ab0a-6cb5-e87ecdeffb91@kdbg.org> <20191001180005.iemqmlbn7ncv3dav@yadavpratyush.com>
In-Reply-To: <20191001180005.iemqmlbn7ncv3dav@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 2 Oct 2019 09:12:03 +0200
Message-ID: <CAGr--=Jv2Zh7meg3V8Q5EyTZZF=4v465+wzBx2YNmrFbq3PAhA@mail.gmail.com>
Subject: Re: git-gui: disable the "loose objects popup" dialog?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 1, 2019 at 8:00 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> So here's what I propose: why don't we try to do something similar? What
> about running `git-gc --auto` in the background when the user makes a
> commit (which I assume is the most common operation in git-gui). This
> would be disabled when the user sets gc.auto to 0.
>
> This way, we keep a similar experience to the command line in case of
> auto-gc, and we get rid of the prompt. People who don't want
> auto-compression can just set gc.auto to 0, which they should do anyway.

FWIW that proposal sounds pretty good to me.

Birger
