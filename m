Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63C4B1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 22:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeJKFyA (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:54:00 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35695 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKFx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:53:59 -0400
Received: by mail-yb1-f195.google.com with SMTP id o63-v6so2872934yba.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SrYr8DrUGI+jnQnnxzWnfSlz9MBCu42Tn9RqkaVhF0M=;
        b=Mm9Ejj8CKxxr649xU0V5Zvmkr/QcnA9lS9lRVJT7j8qTKbNhgs/YiCzC0ncEQila4n
         wWvLfV3GdhVvmo8b62RZhzAwRAAEMUn7T1YyJ6ShtTs23TIqDdo+unsI7823lxyLJ39M
         4sDcneGltQPG8uWXWinJwtgPKCj65NW6dr3HyXo7QhQASo3QQgdqgPBrAUprrJMfw71l
         ijBau/orD3wzFaRfW2MCJS1NGJl+3hAs8f34nMhDihBSY0uoTMw8Tgi9ydbYxqK+5veX
         eFSYiDwfsijQv00YZoLp1BL3oAi+nvrM3zH/6dhzdj8tgrI0RQaajcaqTrul0dqBTYSb
         +IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SrYr8DrUGI+jnQnnxzWnfSlz9MBCu42Tn9RqkaVhF0M=;
        b=Ws7511M/XqMtcPpsM+7vB8lS+e5mIP8MYezc+zVlHEdAjMJkSU+dDz/bWW2ZS1pvTj
         s8rsBAqmbfJEytrLD/D5QvkoshkAPeFxxx1DdVMzFSBvELwGHfAJYvGEpzg1q0oqxrsh
         tfbMnX2b0E11CeJPDDFfk7TE1g1b9IhxW/3UzDueFPHwWGQEgUbmthGFNFLPFZQs86lX
         tuGUPTVRbO+99gdhm0Ap3ncyk4O2usATIsVzNmUZgeP1nIussNlfVSu85hJykXCQA0ds
         4DWUfxfn2X02U7uy7oQrNTOlCJGEO/7nrsmTeUUyIFHStOjNPyhEhMFe6Xc+1uqG2EwD
         s1qA==
X-Gm-Message-State: ABuFfoic0huu33q5jADJ0L/Q2m1tRbGZASYMwOZygXMNeIpbJdtj/UuD
        fPjqlz7jPuhEnivC9KnCgVs/nX9t0uN8HhRsAQmvfQ==
X-Google-Smtp-Source: ACcGV61KHm+NotLb4rev/zqW7HJTocnfjMwmal0gR6LN9tZfZmjNjgq4wTzbX+xCOvtVUoQs0PLkEnZC9gjpCT6awoQ=
X-Received: by 2002:a25:a509:: with SMTP id h9-v6mr5145593ybi.312.1539210587013;
 Wed, 10 Oct 2018 15:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181010193235.17359-1-avarab@gmail.com>
In-Reply-To: <20181010193235.17359-1-avarab@gmail.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 10 Oct 2018 15:29:35 -0700
Message-ID: <CA+sFfMeOpj4V+KszboVVQSoaW2yDgpfDNGwK9ZrNfGmOOAhPtQ@mail.gmail.com>
Subject: Re: [PATCH] gc: remove redundant check for gc_auto_threshold
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 12:32 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Checking gc_auto_threshold in too_many_loose_objects() was added in
> 17815501a8 ("git-gc --auto: run "repack -A -d -l" as necessary.",
> 2007-09-17) when need_to_gc() itself was also reliant on
> gc_auto_pack_limit before its early return:
>
>     gc_auto_threshold <=3D 0 && gc_auto_pack_limit <=3D 0
>
> When that check was simplified to just checking "gc_auto_threshold <=3D
> 0" in b14d255ba8 ("builtin-gc.c: allow disabling all auto-gc'ing by
> assigning 0 to gc.auto", 2008-03-19) this unreachable code should have
> been removed. We only call too_many_loose_objects() from within
> need_to_gc() itself, which will return if this condition holds, and in
> cmd_gc() which will return before ever getting to "auto_gc &&
> too_many_loose_objects()" if "auto_gc && !need_to_gc()" is true
> earlier in the function.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> I had this in my tree as part of some general gc cleanups I was
> working on, but since it's trivially considered as a stand-alone topic
> and unlikely to conflict with anything I or anyone else has planned
> I'm sending it as a one-off.

Hmm, yeah you're right that the check seems to be redundant for the
current uses of too_many_loose_objects().  I don't feel strongly about
it, but I think an argument could be made that it makes sense for
too_many_loose_object() and too_many_packs() to each inspect the
configuration variable that controls them and detect when they're
disabled, rather than having one of them require that the check be
done beforehand.  Again, I don't feel strongly about it, but I'm not
sure this change actually improves the code.

-Brandon
