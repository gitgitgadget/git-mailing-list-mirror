Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD76F1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 23:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfA1XFH (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 18:05:07 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36389 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfA1XFH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 18:05:07 -0500
Received: by mail-wm1-f53.google.com with SMTP id p6so15734671wmc.1
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 15:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LJBTDdIhqPlzZisRbMFHF9WlmDuUoYbhelxIUYOC0xU=;
        b=UKfQP3t8Jr5CfwCBTyrAsSQGNqqCBULBDJ5r56qNmygVx6Aiyb85pkIkSt/qpd0NVf
         CHksxGZpqLa6823R+RnV5mqCTfEDBETpMil+WaciHSf6aBaUmyBckjvzHfbRsHfLaH5P
         l+CAuvW1/s8EoxVZU2hwE5Ej60v6q8sb8IY6Tlcgr6lRvyr9uLtB0Fmg5nQk3xsFNMa1
         VsuL2xT7WjIp8RRBmcu4AOr1GnhlucPgWFO7wy4Dd6HNaloAYUiwtWzwKURVOxPuDkiG
         2DmkRec5qfq78Ir7m2ZIi3ATTK4N2prKrw5egaHyL1TpTpft6A+Daiqu8FDE589un4LY
         05LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LJBTDdIhqPlzZisRbMFHF9WlmDuUoYbhelxIUYOC0xU=;
        b=h2ngiY+9YgxcC+jKa4j7eZ9cbVQ9v+gKyF5np9JFV/hTp9xdE+sOG1c42tJptqGPWM
         LmJ6IvuxtDOPbxjctQLpqGs68uXaGLFJfOqvGNYruaLQ5yDEKCx0KASDVgLI2tD63Sze
         k5JUmiDkmndO1L+z7l+s3QMm0UZhzYwGTSusniD/8CEyP+KRTpaLZpae/jZcr3pQho5V
         zN/ZU4T1aiQ0yQXhAUgZthOminkcm2QJs9As1DfYNAA9EStB4ZIZ1csVGA7Hub1Ecu1q
         kDVxjC5cCQC1vMXWhND7QE27I54EbgkC+v4glVH6EL+MgSpCucaP2Dc1mRvSi/cEV/Vv
         XNsA==
X-Gm-Message-State: AJcUukdhpLkhW4b2NH8pR13/EUpnF1ux+0ZXvOgX6rcGdDGl3FQbfvbH
        3/bd4AwuFgo9VpGyLKgPeVU=
X-Google-Smtp-Source: ALg8bN6naCEk6xlfzfM7gf1atkbk2u/jHpbtIfI0nKYdaNrslKzy+5nC8gNh8elvu8+5zZDIc8w/QQ==
X-Received: by 2002:a1c:5dce:: with SMTP id r197mr17487435wmb.130.1548716704958;
        Mon, 28 Jan 2019 15:05:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t63sm832642wmt.8.2019.01.28.15.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 15:05:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 03/21] ci/lib.sh: encapsulate Travis-specific things
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <2d0b62f1862d5fce3ac0d7b813399f560600917d.1548254412.git.gitgitgadget@gmail.com>
        <xmqqzhrr54h0.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901261916340.45@tvgsbejvaqbjf.bet>
        <xmqqlg35elgv.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901282352470.41@tvgsbejvaqbjf.bet>
Date:   Mon, 28 Jan 2019 15:05:03 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901282352470.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 29 Jan 2019 00:01:06 +0100 (STD)")
Message-ID: <xmqqva288jts.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The big difference is that gettext is needed to build Git and run its test
> suite. While gnu-time is only needed if you want to run the perf tests,
> which is not a part of the CI configuration we have, neither Travis nor
> Azure Pipelines.
>
> So as long as we do not run the perf tests as part of the CI runs, that
> optional dependency should *not* be included in *CI_TYPE* specific
> sections of the code.

Ah, in that case, I do not think it makes much sense to even keep
that comment.  As you said, ci/ is about running tests under CI
platform, and the scripts are not designed to be run manually with
tweaks, and none of our CI integration runs the perf thing, there is
no point to even mention it.
