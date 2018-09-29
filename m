Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E1031F453
	for <e@80x24.org>; Sat, 29 Sep 2018 15:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeI2WDG (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 18:03:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40569 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeI2WDF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 18:03:05 -0400
Received: by mail-io1-f67.google.com with SMTP id w16-v6so6315943iom.7
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c8sceYvjyLV2BbLRxYBu3P4QhKGRP0ET293dYhLxxCQ=;
        b=rIW1G9L/fY4LzXFcwCgLzTCR9jsHUHEUtyoTIS+AorN1WE9F6+c/5w8NvifikYGzia
         SDcHH5Psr1vW17qLAzW/u4NzPc/cFounJ50Tzv6fRtxfPpRe/jFuSYHYI1WNbi/vfCrY
         CvtztfDIIm1ZrkBomGwa85H0P1g14zv/KjTFSs+gCJjk0KqoxCfcVGNn3qwO70qCB+xT
         OqyxeNgRLpchY75f/vjFchTrCApE++NApbXxouoBcQZ+TEoDRkvDoqQt+5cKjIkJNL9m
         tvffWevSXNJHXTKr09PJ9W29SOXYkhKMk87+xfnHX5ewu9+I37XkAx86p2HapTC8wSIY
         gkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c8sceYvjyLV2BbLRxYBu3P4QhKGRP0ET293dYhLxxCQ=;
        b=tWsYpgL51qg4j5iFkhOoB+doFvsnecAYgv2kr42SgXpFmywVbOLDVw+RNfyRgkB5BZ
         yZ/KMlF0kkOxfCoxam526rfPYOryIgc8CgIoWpqA5dlar1Ml8Zihnt/lnfSWZ8X5wGtG
         9tRcAyndbWlWubSWMlQb4BeE79OEOYiPqjdzUvrBvaiJrhtBm12scY0ruqn+aNiGQEe+
         r6fBk93+f2ZIvyxTtzgQa8Z9oy1o9aoQ4/wKovkBFqfeZeGOpBgSwG/lXTUvy+UTNJ2p
         m44ciTV+yvSZjtSZ5Km1Z0PB7Cm1U8Nn6M6dyuhnkyDrpfRVi7JyQngnoskYtRP9c4dt
         H/hQ==
X-Gm-Message-State: ABuFfoj/x2YFCzTjoGInI1BFe0arejBK8KkkNgRwZfs5oyBeB1/8z0ck
        xOavstAK1VKMJDk0AeHL0pNX3u17aYZH06IHfGk=
X-Google-Smtp-Source: ACcGV63Ol2BSakgcgnk1yrirZgfbckFgmp8D/1rY1IVSbPYd9hZ4CrBWiDsEqXEW0y8TfQqRR0zxIfq5uJlsVtl8juQ=
X-Received: by 2002:a6b:8f93:: with SMTP id r141-v6mr2248700iod.118.1538235254870;
 Sat, 29 Sep 2018 08:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGDaZ_oBpLxD0cutrsNsFBEtH+-Fn2eT40gDsnGZhhU0qm2Ofw@mail.gmail.com>
 <87bm8giapu.fsf@evledraar.gmail.com>
In-Reply-To: <87bm8giapu.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 29 Sep 2018 17:33:48 +0200
Message-ID: <CACsJy8BYr6cVtAcDO9w-tfgEiWnbvQCgSR7p3OFKbqVkPA1Gaw@mail.gmail.com>
Subject: Re: [BUG] Segfault in "git submodule"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     shentino@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 5:31 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > #1  refs_resolve_ref_unsafe (refs=3D0x0,
> > refname=3Drefname@entry=3D0x55e863062253 "HEAD",
> > resolve_flags=3Dresolve_flags@entry=3D1, oid=3Doid@entry=3D0x7ffdc834b1=
c0,
> > flags=3Dflags@entry=3D0x7ffdc834b1bc) at refs.c:1493

refs is NULL. It looks like somebody fails to get the right submodule
ref store (or tries to get it but fails to check if it may return
NULL)
--=20
Duy
