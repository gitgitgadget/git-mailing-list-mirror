Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856CBC433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 16:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiGPQ0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 12:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiGPQ0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 12:26:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FAC1D0D9
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 09:26:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w12so9870401edd.13
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D69X0+ZMYej4PlTC181r/EEIwycpHjuokPtsbKKWU/w=;
        b=Pi/jeI/ElTzJ8rk1Ix1iqaLJ983gTOWgfj03IFHhOlure0ynsGwNhTJRd2vihYDn3A
         pInYhfeq8vpbvlc5Sc4FznCtHJKIa4fBejta0+I9BB0Kp29p56d91NK+3SIgYk3aNLYu
         +n6jqHHhyOqxWv+lO76bPdN00+rYdGoU3l7cIEsxCYgRdPgTDXrjVsZXaTx5tuimltux
         SuhkVxYWXcHRLK6b5SagT3/kK0XW9WVOIhkKhxTpz6NhS09mETJn4Sm2EXLMIJmE7zFd
         Cha6k+rNCT8DRrtMhK21jL7SWgSCXZ7yXYkxIQe6RgK9UQAmVjkfE8lTfJJwHmizOcUC
         dvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D69X0+ZMYej4PlTC181r/EEIwycpHjuokPtsbKKWU/w=;
        b=FRq9AsbkKbPAxPtqCTFVMy5zJMTR8vM+FTMgyQv6QZicZbZFXkK1t8/dXtxn6kDuES
         rS/VqiowNkIfrzXZgX2oHfxaWtGPNzhMhE9ePjJLb28x8AoRyy0ITpVIQOFeVt1+/ZTT
         VGy6A2onbswDp5tewwiirzjgdraHwrQcoNLs8lRL5j1mzekctfKi4sPy3NuuiGWj64+W
         ORsym7sPHK7VljRUsErr7lY63/LGlRsS+tV+4gqtvMYn5Fs00msaXF4WLPbojg+ebG3d
         BDubmWdv3l/1pqd7mK/zwAIorHKW0t8jJa1qTaGLjPlDgW9iZiqUCNTNRgEMXcnhavd5
         Fk5Q==
X-Gm-Message-State: AJIora8O62a7pvrTjF4XYVhhklnSde4PIwNBG+UheeIhnScSAtcPo5JK
        kh7uN0oHD5ykRIZhmiBWCCk6SAmUeixFWYlPsZ4=
X-Google-Smtp-Source: AGRyM1vNrfJgCVM1UKIYsx1ofKnn5/C+8fP7KZzalEFw24aaC7scvHZm2AbBudEWCP7CwB6m96Z7itGfT55r6HTgRsQ=
X-Received: by 2002:a05:6402:1518:b0:43a:103f:eaab with SMTP id
 f24-20020a056402151800b0043a103feaabmr25641888edw.280.1657988772015; Sat, 16
 Jul 2022 09:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <220716.86y1wtxhok.gmgdl@evledraar.gmail.com>
In-Reply-To: <220716.86y1wtxhok.gmgdl@evledraar.gmail.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Sat, 16 Jul 2022 21:56:00 +0530
Message-ID: <CAPOJW5zNsETYwD=MXCFLn91qaemgooPN-JB1sx7KagkKxOXTnQ@mail.gmail.com>
Subject: Re: Can I use CRoaring library in Git?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 16, 2022 at 7:50 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> As a replacement for git's own bitmap implementation?

Yeah,it can replace EWAH bitmaps if it gives better performance.

> Another possibility is to get the library to dual-license itself,
> running "git shortlog -sn" on it it seems it's mainly written by one
> contributor, with a relatively short tail of others, perhaps they'd be
> willing to dual-license at the prospect of having git use it?

Kaartic suggested the same and it seems better than the previous one.

As a side note, the current EWAH implementation is also relicensed[1]
to make it compatible with Git. As these two are mainly written by the
same person, I think he will help us this time also.

Thanks!

[1]  https://github.blog/2015-09-22-counting-objects/#footnote-1
