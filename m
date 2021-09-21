Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787D0C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5736B6112F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhIUFmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 01:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhIUFmp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 01:42:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB1C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:41:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id co2so23427121edb.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JTFxu2DHzlsGn84lGen7j6Y7xzdemDsBCBh6lPAXyJo=;
        b=QBJBTJ4VocBPYrIh5Qd4VG7OtNGHWcv8SxYRhdKNV+fyWMQ11IEjrpeykUtx8Kj3g+
         eJqxZxGwe0pjcPl9cCpJThHVHopAHJOKhHVDKKcYK/68LoxGe/mYuDpUoB10obBKZjOt
         DBCp6bCCYnvmR6YZO3KXlwm02+uIqlIY5Jfy0p6VX2QidndA8mgRu9zcfWo9ZlnKPzOA
         FIoq1LqQfysyEJcva31ZabURy+1ay0u/BE9Tj64BDbiHkhxE5cSrnlk0NsC/kmyKZkOq
         KV6BxJbP5u9BzruKgcoCfGa8x0pCzX/eBhvjZmXRbb9JNnzcXVC4GyUiC6zuDgmJ/4U8
         i74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JTFxu2DHzlsGn84lGen7j6Y7xzdemDsBCBh6lPAXyJo=;
        b=ZMiyQWok+T++JlcJGhaaqs0HUbpoh03FJ2PX+YPjZvUjjc4txwG83mQjDOq3yLa13Z
         45Psd+0q7j+UmSMUUZLU7FAN5vbfihRI9IXtkZ/VB2QSomiiFqwb6oeOXYDXb29hmR9I
         e/F8pbZpDcUDz+G9OyHqawIGsmMMP6x+olg4yxpyTKMbrtoYx4qixjrKHJIzXLW0Qcde
         IBaY43KsiuwPKTzHA4lV1lOSvVgp+FW56Ty5DensECMp2mEDdp4+a5bvbvRZ0kem45fh
         Bd7TnPUdIrxlDlRlt5no64DYbjKCgEQ4JTLp0+xBuaWik9CUHOfRPg1M6y35hP0CGWz1
         NYrQ==
X-Gm-Message-State: AOAM531OWbDamQH8yTe2c8GwCVFrWxxqsMJfUnCqwrS4RqYS7hUY5zmO
        C84WWgFALVzZJ9dKVLts1mxMsx8e++Ikd2ZqfCA=
X-Google-Smtp-Source: ABdhPJyXWwKaJzlEYjUmPJVa35ReQq8HHESSHPHlOKg3Jgw8w1N8tS1DA/Ek3IcvbkvESsZXGq0XCeZh9iU0mOi2xOg=
X-Received: by 2002:a17:906:7855:: with SMTP id p21mr32698635ejm.330.1632202876653;
 Mon, 20 Sep 2021 22:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <YUYPgF6tRQ5ERYWL@nand.local>
 <CAOLTT8SbS9-grLnn2TOL6XdR3yMkd=YrUnq=FLCo6r03Fqbg9A@mail.gmail.com>
 <CAP8UFD37tQdbcgsMJPYE7KaO1ajwznFRUrG=9=S1WNNM-YZsqw@mail.gmail.com> <CAP8UFD2SsZyckX0tpCN-16BJ_mX6iHgd+VNSvfr-kirq2knVyg@mail.gmail.com>
In-Reply-To: <CAP8UFD2SsZyckX0tpCN-16BJ_mX6iHgd+VNSvfr-kirq2knVyg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 21 Sep 2021 13:41:05 +0800
Message-ID: <CAOLTT8SACMz_Tct_W+_kh_cG2ELcg7c2sQ=S2si3zpiwDcZSLg@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <ttaylorr@github.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=
=8820=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:15=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Sep 20, 2021 at 4:52 PM Christian Couder
> <christian.couder@gmail.com> wrote:
>
> > I will also prepare soon a page with a few micro-projects. Of course
> > more micro-project and regular project ideas are very welcome!
>
> So here is the page:
>
> https://git.github.io/Outreachy-23-Microprojects/
>

s/Outreachy-23-Microprojects/Outreachy-22-Microprojects/

> It's very similar as last year's page
> (https://git.github.io/Outreachy-21-Microprojects/). The differences
> are:
>
> - added new "Replace a run_command*() call by direct calls to C functions=
" idea
> - removed "Unify the meaning of -dirty between diff and describe" idea
> as it looks a bit complex for a micro-project (though I can add it
> back if someone disagree with this opinion).
