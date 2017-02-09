Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B701FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 15:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753445AbdBIPQx (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 10:16:53 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36769 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbdBIPQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 10:16:52 -0500
Received: by mail-lf0-f52.google.com with SMTP id z134so4161287lff.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 07:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5GrXZ2WdNVytRokcXoKaWT0iqplWYVIzNrObVJPUS+Q=;
        b=SkydRwpnz732zpLsR5DmTUkfIc3NQh0EcEzFVawHrNjIZC9TD4bjzK1kncp9hZtR8C
         9hVegIEEB9co4wzkfe253l4f0WbYLarS2BIBmRCxDZcJX8eBS1VRxBfgfkhLZRk2KQvb
         mDgVLFWcaUmmIokgCdQqj+oedK2ZHaLXlxYnF8L0nMLll0R7k8IIAQ6Vyzj+vTaLsCQZ
         Dtq1bE+oY/3ET1jfj9cVFCIVt8H4odlW+JAwSWGsE840WU+CymI7h/HHyKD1hs3knSC6
         n0fQn/WkcyVIMpZzxBTprUqjdbktnDPT4zhm4h5ignJLxPFBkdSWQG8++UQPeqc0ewqs
         e9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5GrXZ2WdNVytRokcXoKaWT0iqplWYVIzNrObVJPUS+Q=;
        b=Vvv02nO6ve+6fMZhgfq9nNrduPnZ1+OMxIn0fV8u+HS7xtU3bQJiTneuikpMLTrQbc
         53Cirg1XF93mYUGJUn1jWMcK0/xQxabYUuOMtBe9frYmT5FXnPigwTRtc4HmLnBDwDha
         6TXAu2F1i91J5WKX/09cXceNdnBMEl0/y5l+PZwezO3ZNSow3FjVK9OnVUj4NgTbgE49
         6oMd+VAKC+tC57qtodXC1EaAYnwUG1BBFNRIeHy270oJSxhhRyzhCZb6o7biLZ3JKguJ
         LEuk5bvvqSQCxPOOAxJmtKnFvg8D3arr4bopRIZ8VdT6qcLwghSpjKyQLPCWfWw0Z32v
         JGxg==
X-Gm-Message-State: AMke39ke/fXPcxSDDKNFQhSRHTtYAYV9dWHI/3VmUpkMYj5Yx3FuBWe4bzJWcpxsP1TXlUHt7amzN+NbCgAZ4A==
X-Received: by 10.25.67.83 with SMTP id m19mr972633lfj.24.1486646257316; Thu,
 09 Feb 2017 05:17:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Thu, 9 Feb 2017 05:17:36 -0800 (PST)
In-Reply-To: <vpq7f4zmu3j.fsf@anie.imag.fr>
References: <vpq1svtstud.fsf@anie.imag.fr> <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net>
 <vpq37fowx5q.fsf@anie.imag.fr> <CAP8UFD3aygSf5U2abnpCfRzEf-hH5fSNuzFBBtgCjSQC3F8c5A@mail.gmail.com>
 <vpqzihvpt41.fsf@anie.imag.fr> <CAP8UFD1V=WD-EHkBkAVET9ztvsHZr_S5GVBWrQ6F1e0LwJoksQ@mail.gmail.com>
 <vpqlgtfmun0.fsf@anie.imag.fr> <vpq7f4zmu3j.fsf@anie.imag.fr>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Feb 2017 14:17:36 +0100
Message-ID: <CAP8UFD0LAp0o_8oY-a5ZRx8Eg4ZV=8N46oVu+vy7CGxXmRzy1A@mail.gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 1:22 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> I created a Git organization and invited you + Peff as admins.

Great thanks!
I accepted the invite.

> I'll
>> start cut-and-pasting to show my good faith ;-).
>
> I created this page based on last year's:
>
> https://git.github.io/SoC-2017-Org-Application/
>
> I filled-in the "org profile". "Org application" is still TODO.

I copy pasted the Org application from last year, so I think we are good.
