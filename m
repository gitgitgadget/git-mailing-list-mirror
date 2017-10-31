Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CFBB20437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbdJaVbO (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:31:14 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:46349 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbdJaVbN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:31:13 -0400
Received: by mail-qt0-f170.google.com with SMTP id 1so530127qtn.3
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 14:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mNhKyFoKMCDjGLafLTyYz33XnTaeWr1brU790EuL4dA=;
        b=p9ah/AMz2Cnzuveq6VKNfSAZctMcHaJP7RevpCwNV2j2/ggC1AkWEAZWGGoIPWa/iN
         dBnLXM0vDhcDlVrBsp+HGrWjYoQqrfxObcyAhy6A8b4R7MlrBAdILsQT5VBifVPLcX8g
         Gbk7pRWiiULP0GtQx75cIIbpwfGcG9Qhhp3Vp0G7bIrj8dQmKFCmbK81MzQT6y8DFNpQ
         /u9bN21+4Vl2g0MuUZwvUHGsGFWf9fuVIjl4C+N7JlRFPHbOLW1ht7xb50XeApI57a3e
         9+gCzfXruyBfsRTzy4vLJm70n+fhsNJbSwqG3H7zd50KUDleNWEWBIsJorT9tAKVyzxA
         hRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mNhKyFoKMCDjGLafLTyYz33XnTaeWr1brU790EuL4dA=;
        b=nJcVuBcPMCMDk1ipJ6/oBHk3009VnYj7fSGgCEDQh+D69ytFq7NncvGN474zRV+EOi
         iUQ9lqaJWNP3XtHHEOkUlCwRZ6Ly+hhoG8Vcyptv1sbB8xqP8lHmnQRmEc8d+JP2NKP7
         o9DtlRoQVmORHvwT23FUw9CHEdqnOh+18oLpaZJg990WNsMFm1/UHnlbhFhi3PJAEtNn
         MuroieQmI1SY/qf5GDyu0U3l8MRon0Xa7vCoRl5U4pDTD/y2CrIqeK/Xnow4EVfRSeyf
         J+NufHJ2lV/CkH0813Y1VbFLxF/QaxjaR099Kwzpl93/3WZcr76h2DMDKIb4uJ2lrZNq
         2Trw==
X-Gm-Message-State: AMCzsaUz8aJg5OKew8glYqEe2JZ2mHwZURxry7Uq89Qfyrnq7HM3zc1H
        U6UjaGcdLbJPkKR4oZKZIoK/fdxPxay5nyaL9MU=
X-Google-Smtp-Source: ABhQp+RD1IAuMp85+5IYyxurluXZYZye+PYuxlil42FWJgZ7ST6aQpSaP/RRC4Dc0438//LyC6ss78OC8xtn5oQQHeM=
X-Received: by 10.200.53.12 with SMTP id y12mr5462246qtb.84.1509485473015;
 Tue, 31 Oct 2017 14:31:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Tue, 31 Oct 2017 14:31:12 -0700 (PDT)
In-Reply-To: <20171031211852.13001-5-sbeller@google.com>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-5-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Oct 2017 17:31:12 -0400
X-Google-Sender-Auth: H6_wEzMaLh7YioJ--NGjokSyOJ4
Message-ID: <CAPig+cRZhm-s7eAU_d29=pOPrKRA4DnCARyJ7JsyQ_wqKgPXVg@mail.gmail.com>
Subject: Re: [PATCHv2 4/7] builtin/describe.c: print debug statements earlier
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 5:18 PM, Stefan Beller <sbeller@google.com> wrote:
> For debuggers aid we'd want to print debug statements early, so
> introduce a new line in the debug output that describes the whole
> function, and the change the next debug output to describe why we need

s/and the/and/
...or...
s/and the/and then/

> to search. Conveniently drop the arg from the second line; which will
> be useful in a follow up commit, that refactors the describe function.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
