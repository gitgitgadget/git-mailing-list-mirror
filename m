Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2309720958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932131AbdCTSYk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:24:40 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35098 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756001AbdCTSYe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:24:34 -0400
Received: by mail-it0-f50.google.com with SMTP id y18so45189124itc.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qnQWE+0Q3jfSUGTGUlfujXgLSR+95EX6a8KsBRgRHjw=;
        b=NObLjnfAuRPml5uLPtIo6eGZiGEdkEb2O3J8nx4l808hl08AGIoro8byL3ElXhxvUG
         NbffDBXai8QJ9vfn49B83ovOQmuNnw0iezLFgKp2pzlAVTDRfGof64g0hT6sCLPovRQ8
         zfBvcuapqvdQfd76ZX6mdbco6iXXT/HhG5KcZq0rD8hbJ13qQh1AbMXrZUauFyUed6+g
         C+93o2T6is4NCvgg36yiqB52s+2fqmnfxeXSQMzRUOfrEhWxqCX6nJM1MFLKu1AJHKXQ
         9nqK581j1FztqaZhZFNTw2BZ7s96TS3VjHvUlcBHx56UdG/JolqvkqALOM085AcCqmdi
         2Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qnQWE+0Q3jfSUGTGUlfujXgLSR+95EX6a8KsBRgRHjw=;
        b=tJ+pYCvI+XHlF168Qm8O5eqWobY+ERGlgQMU+Pa7oh+jZNq7Jr7+r74YV/kuJl4Re9
         FVyx0Q/oJAvIM4IklKoyHGQkEvC9uHjlD2MZENYkKzIVYKMHmbudg2HysTR7tNACjguH
         JQTgmLPGaU5bEFz9B/2/WDhOBtQdk13SJ2OTIQXUDSpG7MlRfTNmsetUVmrHu5VFIMph
         Lez3KfggaqovCuVFgJoQy+5H7FxWf66z/AfRieWR19p7rF01wRKag4beTEflg5o9MH4w
         Yy9RekRWH3VoFUwJFXJukAW8Gg5CPx969aX/SwuGsx7zK7iaLhNpowfCNi6LqWWtsIeN
         n4WA==
X-Gm-Message-State: AFeK/H2x2ynL8nau7CZQddmkNzukCpYobdCd8VmHaGSxDstzDF/6dl3P1uLik07y0uflT9Sq6czLXCBjNXCWNg==
X-Received: by 10.107.200.139 with SMTP id y133mr2365020iof.147.1490034272706;
 Mon, 20 Mar 2017 11:24:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 20 Mar 2017 11:24:12 -0700 (PDT)
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 20 Mar 2017 19:24:12 +0100
Message-ID: <CACBZZX7Kqo=w-c2LOH9a4xf6WpnhE5tsvNHa1O2-4dvYTKZxEA@mail.gmail.com>
Subject: Re: [PATCH 00/20] Separate `ref_cache` into a separate module
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 5:33 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

> I've completed a draft of an epic 48-patch series implementing all of
> the above points on my GitHub fork [1] as branch
> `wip/mmap-packed-refs`. It dramatically speeds up performance and
> reduces memory usage for some tasks in repositories with very many
> packed references.

Just curious, what sort of performance numbers on mainly what sort of
operations? I'd expect the fixed cost of e.g. `git log -1 >/dev/null`
to go down, which can take as long as a second on some repos with a
huge amount of refs, but anything else?
