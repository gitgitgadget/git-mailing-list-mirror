Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE11C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 18:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiGZSRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 14:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZSRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 14:17:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAC42A955
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 11:17:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id os14so27677034ejb.4
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AGT9PBQDKczEwJXBDqoaTj6k8IhwgYpjYlLplQQuk2A=;
        b=HAf6GOKkjhiG8+5JpIfv5D84tLHpUpQ9rLdDlHkMYToYKWSzASuR7JK23/cQtyO7hv
         WXrvo8QoQAA9or4p1DY0ijLOCXPx5ZeQH1xCrEtEXQ5uixPq/Cl/6uxEEmg78LrJL5Up
         PFRnbkYMmwuBL+2mfeRAoKOMUb3z3Lg0wAO3qIOcftI9IYJCwpWYQ1Rh1fAQAwgsYXuV
         ZW8bHIENjmzjXfSbUyqrY4a0JNT7wmLSkNmJoi17IlaiKwJ5A9daDX1grGy6Kq6H9AcG
         XkJCpoKfvoRjVQiEtJCMLwJ74dx7687H65o2ppXurPdavCFrqFAPNjnruHvi9biyiV8e
         bm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AGT9PBQDKczEwJXBDqoaTj6k8IhwgYpjYlLplQQuk2A=;
        b=Sm3B608oTZmZ7a21KJ1lk8WJiIXv5w879RX+g0CegnERXEe9lYOwvqqme1KcrljILp
         DYq8W1NCwLQxpnwGZiujbRQSE9I+5QUCq4M57NQgJ8fn40rzMyk3uzrsQzPyy/F3/eyL
         CItzhZaVadYN80scXjGtL6tujgFXJ58oEiLgIymOGxQ9bt69MBx42LGqPbb2oS43CpIw
         Ht/lC/X0xqk1AL8VLbXdNPerzVdScB2ymZ8gD6kqRvP3ORMRcjuwKghuIL0fc1uLKSXn
         w8dT0z73vRMPXSaJqf08API6HMaDDbXWJgbfGV2OkzgX1Ze64to0s8Q1orlsKp+Nunrz
         fGeQ==
X-Gm-Message-State: AJIora+UGNI1CsF6snGzjFtAP1R6CGJfu4swkQgzseCWVCy0cCETCPaB
        pqkzSVh6NINeVunm8wKw2D4RUdjIO3Nxz/tsZtE=
X-Google-Smtp-Source: AGRyM1ty4aWIBNf0+B3ozMFI3LZ7cajkqdPKIX31RMWLtbp3G9NQP05dGKMV4Tjx01ZNGioefVMbZhbjbPAqfd1dSeI=
X-Received: by 2002:a17:907:7fa9:b0:72f:36fd:ef89 with SMTP id
 qk41-20020a1709077fa900b0072f36fdef89mr15186483ejc.433.1658859437876; Tue, 26
 Jul 2022 11:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <e7ef420f321b3936185b2729460b1c28f5384438.1658342304.git.gitgitgadget@gmail.com>
 <Yt9A4Lh5MzHigeVe@nand.local> <220726.86bktcny14.gmgdl@evledraar.gmail.com>
 <733f2432-00ab-f0c2-269f-90af02b2105c@github.com> <220726.8635eonfjp.gmgdl@evledraar.gmail.com>
In-Reply-To: <220726.8635eonfjp.gmgdl@evledraar.gmail.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Tue, 26 Jul 2022 23:47:06 +0530
Message-ID: <CAPOJW5zS2yhbmmfZXR3yz=CqzgccTQHEV5A2bjj52ZLcQCWfsQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] p5310-pack-bitmaps.sh: enable `pack.writeReverseIndex`
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 26, 2022 at 7:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> But then we're losing the perf test coverage for the case where we don't
> have the *.rev files. Isn't it better to run both with & without *.rev,
> perhaps by splitting up the test file? We could make it a function in
> perf/lib-bitmap.sh that we call both with & without the wanted *.rev
> repack config.

Ok.

> I suspect that's also subtly broken, in that t/perf assumes that it can
> re-use the repo for a given <rev>, but this is modifying that repo, so
> if you run e.g. test Y after this Y, that Y will unexpectedly get a
> repack'd repo ...

Thanks =C3=86var! This is the problem that I informed Taylor off-list. Will
update it.

> But we could just start the test with a git clone . "$TEST_NAME" or
> whatever, then repack that with whatever options we want...

Thanks :)
