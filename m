Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F601FF30
	for <e@80x24.org>; Tue, 23 May 2017 09:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965612AbdEWJza (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 05:55:30 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35685 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933487AbdEWJz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 05:55:29 -0400
Received: by mail-it0-f48.google.com with SMTP id c15so16089242ith.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 02:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ybTy/20r6zyFYcpuiw+0xGrMuRixMWfEQH6nJmjp+zg=;
        b=BluAeob4kF4bFoil3HlnAGVdHAgNnClcCYKpUO0hWXSn5Athy9uVNKboEy8xFQ1+ev
         BQ46s9YkTawB9ltorTs4S5dqzHtxB3A9f6CaCmC9cX5rZJHJIeWEtP98/MnmB8T2EFTV
         sd9hF7tKcOpaVumPI0OKNkuFC9qFCXEXOIHM0icmaOqOqCPNf3mA7XvIBwQF2pwobRoC
         QtnsHEiFlBcgaHkJgKYYomB+EBCIHeMHmHuvwcf2g8GvlKfYEkl9yagQaJ5kktRIkjvv
         76c3bUb9JUzsA7fdNlljkRwLWurTZeodM2IwEYmPesB00nL9hevFbIV7sVXo3TsCIT64
         ys7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ybTy/20r6zyFYcpuiw+0xGrMuRixMWfEQH6nJmjp+zg=;
        b=qFpDh56KEK8z9avwAC3IkaWOo31w1k6SaqyHoLlXqJ1yp9ul8iNmDH8HaIYZ/1SL/Q
         hVN+v9XDojZS71qtsdXn+/rfHl0sObgVfywLyl34ygM/sthZ9W0kSCLueibvDxl9KKwp
         +9Gl8VaHSE9kb8ne8GpJEAOgNXhBFm2goxMxIKbRYx4cs061ohdBJk0d0HwYo/7t8szQ
         0bAOgbKDfVHN2DA33EQ2i7lJjPx3MuKnrmYHllaWj8jEbwrYBo0uSNaTjjBaBiWqT5mO
         k5ImTLx0kZ9K2e22uySZqfF0hDmy6/xdTMkH5r0hXDJ1eeY6fk36ZuMnMEkSCmHeVuZA
         KgIA==
X-Gm-Message-State: AODbwcDGqrapklDzu4JSjkCiPBF2iw4BHA7llTVxgi0nqeIx9OQqELGY
        3GHD4I4KkLurC3snv3owyr9SKdsZTA==
X-Received: by 10.36.89.207 with SMTP id p198mr1742992itb.71.1495533328416;
 Tue, 23 May 2017 02:55:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 23 May 2017 02:55:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705231103220.3610@virtualbox>
References: <CACBZZX41yrAtBvkVeL9Q=2_TxcwrDXh55gu3qLN54P_go318OA@mail.gmail.com>
 <alpine.DEB.2.21.1.1705231103220.3610@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 23 May 2017 11:55:07 +0200
Message-ID: <CACBZZX5EQhoEBvj2e6ogXU5Y=EfwSPCx+jFvTJ1P2KbYNpADyw@mail.gmail.com>
Subject: Re: BUG: The .gitignore rules can't be made to cross submodule boundaries
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 11:17 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi =C3=86var,
>
> On Mon, 22 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> When I was adding the sha1collisiondetection submodule to git.git I
>> noticed that building git would dirty the submodule.
>>
>> This is because our own Makefile adds .depend/ directories. I hacked
>> around it by just getting the upstream project accept carrying an ignore
>> rule for that around:
>> https://github.com/cr-marcstevens/sha1collisiondetection/commit/e8397b26
>>
>> A workaround for this is to have the Makefile add such a rule to
>> .git/modules/sha1collisiondetection/info/exclude, but that's less
>> convenient than being able to distribute it as a normal .gitignore rule.
>>
>> The submodule.<name>.ignore config provides an overly big hammer to
>> solve this, it would be better if we had something like
>> submodule.<name>.gitignore=3D<path>. Then we could have e.g.
>> .gitignore.sha1collisiondetection which would be added to whatever rules
>> the repo's own .gitignore provides.
>
> While I have nothing but the utmost respect for Stefan and Brandon for
> trying to improve submodules, maybe it would be a wiser idea to imitate
> the same strategy with sha1dc as we use with git-gui and gitk, i.e.
> perform a subtree merge instead of adding it as a submodule. It's not lik=
e
> 570kB will kill us.

The submodule/.gitignore bug/feature-request being reported here isn't
something that impacts the ab/sha1dc series in practice.

It was something I noticed while working with an earlier commit in
that repo, but that's a commit that'll never be pinned by the
git.git:sha1collisiondetection submodule.
