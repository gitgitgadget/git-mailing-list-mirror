Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB5011FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755764AbcK3Uvg (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 15:51:36 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35976 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756686AbcK3Uts (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 15:49:48 -0500
Received: by mail-qk0-f173.google.com with SMTP id n21so223292387qka.3
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 12:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9P/EKIknVJGSvqfOUXTrM63H++pbVvBaiMLsQp9FZpQ=;
        b=exFAMcU+P3PkEIn8nBgzMNcDQVX0EUGGAQSlNVOgdJbtMMi8A3Q6QxXGX1J8iawDjr
         VrDBI2b5fA7GMVuTEBLST4GUaGxfCDl984i8Qt5kk1NmhXmqEpgEMplg8YY+a39xEtze
         gc+TlODZG78Y1TlxWaqRTL6zbff95K2YyEzhOX4rFSuKuJbySHNWp3z7pxsHp6M7GTZz
         +Dv1yhxr1hj1xOMoIQ9nYnyDhGUoaLi9GZn3EaKKtegI9f/P47sdxIRFzAVc/2qSTW6F
         FKtNAqnOYS0Zfilm1tDbHk0Uc9DYkfr3nRZz+BBQC38PEysOGaWF8yo5S+pEBkaLIqxL
         vEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9P/EKIknVJGSvqfOUXTrM63H++pbVvBaiMLsQp9FZpQ=;
        b=evEEEJOwRf+xCk9gKX4p0yMVLPDp/gjQJi1Av+Mn/4qvoU8dO0+mEYeOQhod9NZEGl
         8hsbSc9CMkaY374g+p5/ugYAu+R84mJkKaVF7/MpaTAntd2jTTRkC2liIVlSXE7iaCe4
         mtLrQqFRAsWJ220ZeJjSf6UOwm6ROpbwSW+l7VV6ObKOT/WCuubpFxy+2s62Gzxqt89o
         +7Xzwcz7wfo+ctAl2BQSZfJmxCPStAwnMKiLdof7p0+yT154SbUHbOLYudqqDkzLunYu
         D2xqsGQGR36ACWLDT9ZCMrsQHnN+iX/H/x2g+v1H6BrtgWE7Rj0owyARdXYUOSjWuk9B
         CxXA==
X-Gm-Message-State: AKaTC022aPNTGbMbw3+QW51hfVq5757wGP6GvycLvPnemtRaJNeSNFK3CYuLWQEj2B/KY7aEgS2rkeaYmDhaeQR6
X-Received: by 10.55.191.134 with SMTP id p128mr29184767qkf.58.1480538898594;
 Wed, 30 Nov 2016 12:48:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 30 Nov 2016 12:48:18 -0800 (PST)
In-Reply-To: <CAGZ79kbvey_f8+R16yYT_qsF0RErOh8own8n-RRApTM0dS-+ag@mail.gmail.com>
References: <20161122192235.6055-1-sbeller@google.com> <20161122192235.6055-5-sbeller@google.com>
 <CACsJy8Ce3Oa-xJ4BwgRRy6neM=Jxkfqq7yboHZDXLDG2tu9GzQ@mail.gmail.com> <CAGZ79kbvey_f8+R16yYT_qsF0RErOh8own8n-RRApTM0dS-+ag@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 Nov 2016 12:48:18 -0800
Message-ID: <CAGZ79kYS=GHUvSxDEMLBWZR82j09=Ti4piJu_mJcP7DuBuQZwA@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] submodule: add embed-git-dir function
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 10:04 AM, Stefan Beller <sbeller@google.com> wrote:

>> Submodules and worktrees seem to have many things in common.
>
> Yes. :)

I moved the code to dir.{c,h} and renamed it to a more generic "move_gitdir",
but then I am thinking further about how to align worktrees and submodules here,
specifically the recursive part.

Whenever submodules and recursion is involved so far we spawned off a child
process to take care of the issue in the submodule itself. Here we followed
the same pattern and called the submodule--helper to embed the git dirs
in the submodule recursively.

As this function is not supposed to be submodule specific anymore, I'd
rather not want to have the recursive childrens code live inside the submodule
helper, so we also need a neutral helper for moving git directories?

So there are a couple ways forward:
* We declare the "recursive" flag to be submodule specific and keep
the recursion
  in the submodule helper
* the recursive flag is generic enough and we invent a plumbing helper.
  Analogous to the submodule--helper, that was originally invented as a C aid
  for the git-submodule shell script, we could have a "git--helper" or just
  "git plumbing <subcmd>", though that sounds like reinventing the wheel as
  traditionally we'd just have a top level command to do a specific thing.
  (side note: Some parts of git-rev-parse could go into such a plumbing
  command)

For now I'd think to declare recursion in this function to be
submodule specific.

Stefan
