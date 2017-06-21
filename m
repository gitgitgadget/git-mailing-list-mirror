Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9899920282
	for <e@80x24.org>; Wed, 21 Jun 2017 00:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbdFUAVV (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 20:21:21 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34065 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbdFUAVU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 20:21:20 -0400
Received: by mail-ua0-f172.google.com with SMTP id z22so2677591uah.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 17:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gc6TkV44yXXzA0+AGuu3KhXx1nros3OOX7lnDx2U6pg=;
        b=Jna8qYont0IxTaJAAJ1rbUX6GbxbEWscoCH8HLRnt115Nbf+37uV8+8tFbb3Xv/Bzc
         TDrrf5k0a13Sdvzk6axEKSITSZHQgj/fOfBoIoANSGuuGZkN4RYibk4xGG8cRNTI8pio
         T9Y8QI5sfDpg4md43gMCdsDpkn4zzEhYJJple9BjR6+HMrITmhqTry3baI5tov9VxDY4
         aCM8tPe5Qffct+/Jz4oN6fBMdTf9boaRSzGY7pM0dL3TIwDum3CpR6H5+Jqv2iuH+cDo
         2bKLSn8Ta5tDxzaYKEPCinLWOOaYBwrBkRHZqdw6JGi6mbUxyKs+yZ9mn05t4hvN5ni1
         psyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gc6TkV44yXXzA0+AGuu3KhXx1nros3OOX7lnDx2U6pg=;
        b=I8hok7OHMIDX5WfthMqKG5H2nrp4IiP7YLARWSNkHaCh4DSfyMLyicQRtwdLB24yz3
         ImE4sWnS9pdLccnbzbJKTIbnPIxa98CVAVV7gs6Yta5et98+XqnrWcLRQyZbwBeBcQ0L
         ZZmhyRHVpm4X1k+T4ST/4+qkGoP4rwjYMCLGLMpnVfHlOkKVNASeW2OFyzFz/fhxh+eK
         P//4HU0Mc7aMtF6nuWWtvT7Mv9QEmPvhu5WlTtkDqtGZmoF8rLMGaoDrqLc2pguJ6/9L
         qodg1odXzxa1d27Std5CXx/dMuoyqljnFo0vtUkr3JNKKvV34krNY/+7/f99zFa7FQA6
         XmFQ==
X-Gm-Message-State: AKS2vOxTvW+uovGBlo4JuM0AQQL9jZe6KO3guODWKextALD+e4a+4eF4
        eilZoMz+n9HNzfL09xD0KmW5DilCVg==
X-Received: by 10.176.80.19 with SMTP id b19mr15659315uaa.139.1498004479595;
 Tue, 20 Jun 2017 17:21:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.80.214 with HTTP; Tue, 20 Jun 2017 17:21:19 -0700 (PDT)
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 21 Jun 2017 02:21:19 +0200
Message-ID: <CAM0VKjnfVuVnUfnfCceD-QfUdj=6sWTdBDXkj9jZujqMJqdAQA@mail.gmail.com>
Subject: Why 10k remotes? Was: Re: [RFC/PATCH 0/5] remote: eliminate
 remote->{fetch,push}_refspec and lazy parsing of refspecs
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2017 at 2:33 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 17, 2017 at 02:25:39PM +0200, SZEDER G=C3=A1bor wrote:
>> Indeed.  Even in my repos with close to 10k remotes the amount of
>> memory wasted by the duplicated refspecs is not an problem, there are
>> more pressing issues there.
>
> This is sort of a side note, but I'm curious why you need 10k remotes.

For fun! :o)

I have a couple of repos containing all branches from all forks (and
forks of forks, recursively) of a few interesting repos on GitHub,
where each fork is a remote.

  (Why on earth would I want to do that?
  Sometimes it's good to see what others are up to.  Apparently a lot
  of people fork projects, push their changes, but then never upstream
  them.
  Such an all-forks-in-one repo allows me to run e.g. 'git log --all
  -p master.. relevant.c' and then search its output for changes in
  interesting functions (thankfully function names are included in
  hunk headers; alas line log doesn't work with --all).  Occasionally
  this unearths some treasures: other people's commits and branches
  scratching the same itch that I was about to scratch, or at least
  solving part of my problem and I can build on top of them.)

> We used to do this at GitHub as part of our fork storage (the shared
> repository had each fork as a remote). We fixed the quadratic issues
> like d0da003d5 (use a hashmap to make remotes faster, 2014-07-29). But
> even the linear work to read the config is noticeable (and hits you on
> every command, even ones that don't care about remotes).

Indeed, that's one of those "more pressing issues".
I worked it around by storing the remotes in a separate config file
which is not included from .git/config, because they're not needed for
local operations.  And when I occasionally do want to fetch, then I
run 'git -c include.path=3D..../.git/config.forks fetch ...'.

> Now instead we
> pass the refspecs directly to fetch whenever move objects between the
> storage repos. They were the same for every remote anyway (and I'd guess
> that is true, too, of your 10k remotes).

I do have different fetch refspecs for every remote, i.e. the repo
'github.com/user/repo' has '+refs/heads/*:refs/forks/user/repo/*'.

Incidentally, this was what triggered
sg/clone-refspec-from-command-line-config back then, because 'git
clone' didn't grab 'refs/forks/*', and the means advertised in the
docs to do so didn't work.


G=C3=A1bor
