Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE9F1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 04:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfFSEgw (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 00:36:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36600 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfFSEgw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 00:36:52 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so35169314ioh.3
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 21:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0zd4s4GN9jDRpXTyHgFtlYmwZJ0Hvwjezdfp6aM018=;
        b=turrwhWOIEZ1QbmdsBLXINS05+oSlmMvXhtDgdvBhSV515XgpGYov8cYnXh2mPUm53
         UWjVlRGApdjWk46IX5Tfbyjk1YT3vA7SwcVl+Eu08+orftIn4f+Z5LPw1UyvVKDgLrT4
         OrXl3CErowLciQr1FOAMjG9CmCGfmf4htnAwTqi9u6USOb3v5CkQ3Rq5qEwoW4Ma2HE9
         OqgSRDq4eIGe3DXoTnG/W1Lpav2MxxoI+XSU3X0dtRH5f/Xe0D7R2YKwAGw58GlyygX2
         8eRrvFVAhQNjt8iSZn0bVG6vxQkQTD9nPf1hAK6vD7wkUQtimlaTtUYHRk7aOar0udOf
         rbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0zd4s4GN9jDRpXTyHgFtlYmwZJ0Hvwjezdfp6aM018=;
        b=dLHCoAcn55pqOYtYznV9gKPHfoQuvgzF2s7/DWepPnWliyFohJ64/eU0QzOYJC4Ji6
         G0sZnbPe+tU2ErrvZBg9qDN2cylxWEnCZMcM/Ga3G+OqLojoftbdWezMa4XlN8jDnjK9
         QYoYoKYIN9DwEDb3AAwcxt2HZsLTOg/J1HAEcgqMlS4V2X+CsOQwsq2ZT54HDD+5+pmG
         Buu7Ko9LdlIiy69MG64mpdEyKIgyfeQj3awAPALL2sn2BlTye1CLxjpYFAPvc3XB+kJu
         Voy1gyVZo050nRB2e/rXTcIuL5VEEqO++TIPpMdgxDjiOm6LOP43IIkcMx0g70qvybfT
         lSBg==
X-Gm-Message-State: APjAAAXNHfvw9FefKnNBQLy1ztXaCwiV8Rb3d9hdRYbezgiSoQvLOVMC
        nohkN/Y7xHZSQd7YwFhPk0bYyIOgerOx/AQV8aFVduCwksU=
X-Google-Smtp-Source: APXvYqzPIaeCZ3KgnA2njHOXzlPwwAaBb3wlG69ahz2NHC8fp47D4HGxYa4oVj/hUvI8oTSKEZfgQJF5yiLQG19sMPo=
X-Received: by 2002:a5d:9613:: with SMTP id w19mr7995509iol.140.1560919011411;
 Tue, 18 Jun 2019 21:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190502144829.4394-1-matheus.bernardino@usp.br> <cover.1560898723.git.matheus.bernardino@usp.br>
In-Reply-To: <cover.1560898723.git.matheus.bernardino@usp.br>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 19 Jun 2019 01:36:40 -0300
Message-ID: <CAHd-oW65UE6prjSv-wBe5rON2aMtNDZFsuyJuZMef8KzKKdC0A@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 00/10] clone: dir-iterator refactoring with tests
To:     git <git@vger.kernel.org>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 8:28 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> This patchset contains:
> - tests to the dir-iterator API;
> - dir-iterator refactoring to make its state machine simpler
>   and feature adding with tests;
> - a replacement of explicit recursive dir iteration at
>   copy_or_link_directory for the dir-iterator API;
> - some refactoring and behavior changes at local clone, mainly to
>   take care of symlinks and hidden files at .git/objects, together
>   with tests for these types of files.
>
> Changes since v6:
> - Rebased with master;
> - Added to dir-iterator documentation that ENOENT errors and hence broken
>   symlinks are both ignored.
>
> With the changes brought by this patchset, dir_iterator_begin() may now
> return NULL (setting errno) when it finds an error. Also, it's possible
> to pass a pedantic flag to it so that dir_iterator_advance() return
> immediately on errors. But at refs/files-backend.c, the only user of
> the API so far, the flag wasn't used and an empty iterator is
> returned in case of errors at dir_iterator_begin(). These actions were
> taken in order to keep the files-backend's behavior as close as
> possible to the one it previously had. But since it already has guards
> for possible errors at dir_iterator_advance(), I'm wondering whether I
> should send a follow-up patch making it use the pedantic flag.
>
> Also, should I perhaps call die_errno() on dir_iterator_begin() errors
> at files-backend? I mean, we should continue returning an empty
> iterator on ENOENT errors since ".git/logs", the dir it iterates over,
> may not be present. But we could possibly abort on other errors, just
> to be sure...

I got ahead of myself in this last paragraph. ".git/logs" is one of the dirs
that files-backend.c is used to iterate over, but it doesn't mean it's the only
one. This dir, in particular, is iterated when we run 'git rev-list
--reflog', for
example. And upon ENOENTs, the iteration is expected to end
successfully but with no entries.

(also adding Michael and Daniel to CC, in case they have some input on
these ideas)
