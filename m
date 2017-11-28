Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5787B20A40
	for <e@80x24.org>; Tue, 28 Nov 2017 11:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbdK1Lgf (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 06:36:35 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:43517 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbdK1Lgd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 06:36:33 -0500
Received: by mail-wm0-f44.google.com with SMTP id x63so1160945wmf.2
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 03:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jr7QhFC//NN5setPnIpRwNAURwzP7h1XRNh0JzhXfaQ=;
        b=sZ6Ht7LSLdEJAQF2esxKOX/YvSMB0t+DVsperR3roVeNZC/OHOwxIDQseeI8JbRsaf
         YV4O4yRsHWQi5VcBfCUK0GxwwfIEhU2QDZHbkSIL6VZ11ssxHjbdc72yDfJU/d9UkPUp
         Ia9qPlAZBnW/W7RkPhvztlYx2XLoNX+NlPCA00lS1aWHygKBM1E6NAElN3oi/b3/EV/9
         JS2oyI9Op2F7vzC5iqQoao1XgVZ91v0v2x00TL1piDnTHr8aJ2jXwZmAxlkZ8etCeFa2
         d3x7ZfXA5/kEUvctdPuL58271n8IRs5GX4OEHckbDCAOVuDAnmUxVEj6ZyGjukBGIDAE
         dJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jr7QhFC//NN5setPnIpRwNAURwzP7h1XRNh0JzhXfaQ=;
        b=mUZ0F/2Lj2GMWhYqdovuehhX6gFMinskkxjlZGpV5MxQE511+JFShirMbfw5UyY4s3
         bjzmg9X8mdibPYeRcMyop3yKDfPrUuttJA+C/TqeJvYvee/kalMf9nyqKd93jJIvp2Be
         ZtuorY/QG7NmmDqvwDkasleHsPle9AZYYjZeS1OgPco1o9tWvSCk4wfMixQM/iOxGE4L
         PWwGRNOUSW5j65cj0z9aK3icqI8jqVylHmvnzvu9wetuqzXGgLbvu4CywEYogWLDf8eh
         tXcviTXQotm5zXT39hF+eqp0P/O9J8L/q3N1AaAKgFqGuU6PnthyH7ukggMuc7ZJhiA2
         o5Ng==
X-Gm-Message-State: AJaThX5jzQNkQ4l2pOd5/xTjvsC6RrZdaQi4vRDt3i4fhq/ZCbaoHgq3
        tZCMtHdrQjJUJsk7si7NMql11fNqKtSGStE5S9AWWA==
X-Google-Smtp-Source: AGs4zMb9IVMYcOB0WKQ7ixSF2xChNnoTfhbnaVFHbl4kz+yJUIKFGsx1iVVKkrgcfcVbrUAo1ML/qSozHDt/AsL82L4=
X-Received: by 10.28.31.131 with SMTP id f125mr17967532wmf.18.1511868991444;
 Tue, 28 Nov 2017 03:36:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.203.140 with HTTP; Tue, 28 Nov 2017 03:35:50 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1.1711281226490.6482@virtualbox>
References: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com>
 <xmqqo9noe3u0.fsf@gitster.mtv.corp.google.com> <20171127043740.GA5994@sigill>
 <xmqqk1yce301.fsf@gitster.mtv.corp.google.com> <CALNjmMo3KH4QXY00ViVaiHdy=pSZ5j0BWRueO1T=sC_r0=3c3g@mail.gmail.com>
 <alpine.DEB.2.21.1.1711272222100.6482@virtualbox> <xmqqbmjn9t48.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711280132480.6482@virtualbox> <CALNjmMpc2F4OSrQPBtRGwu6RM=V81PXJxOrP2w9dLdtL1=F+kw@mail.gmail.com>
 <alpine.DEB.2.21.1.1711281226490.6482@virtualbox>
From:   Takuto Ikuta <tikuta@google.com>
Date:   Tue, 28 Nov 2017 20:35:50 +0900
Message-ID: <CALNjmMo2jVNXGGuP4t1LTgSLpSKRcYz=N_wiVwZotnnSvPFiTQ@mail.gmail.com>
Subject: Re: [PATCH] Use OBJECT_INFO_QUICK to speedup git fetch-pack
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thank you for merging!

Takuto

2017-11-28 20:27 GMT+09:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Tue, 28 Nov 2017, Takuto Ikuta wrote:
>
>> As long as this PR is included in next Git for Windows release, I
>> won't suffer from slow git fetch.
>> https://github.com/git-for-windows/git/pull/1372
>>
>> But I sent you 2 PRs to follow right way.
>> https://github.com/git-for-windows/git/pull/1379
>> https://github.com/git-for-windows/git/pull/1380
>> Feel free to merge these PRs.
>
> I amended them slightly, and merged them.
>
> Thank you,
> Dscho



-- 
Takuto Ikuta
Software Engineer in Tokyo
Chrome Infrastructure (goma team)
