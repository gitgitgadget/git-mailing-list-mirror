Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB511F461
	for <e@80x24.org>; Sat, 13 Jul 2019 22:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfGMWWR (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jul 2019 18:22:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46163 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfGMWWR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jul 2019 18:22:17 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so27885697iol.13
        for <git@vger.kernel.org>; Sat, 13 Jul 2019 15:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynRlx9phW0ITcJS+U9gMXhm6fL2et/Qo15nC5VnSMLs=;
        b=Qg/ZQmhY2D8gIwpi0bzRk/01giFskn51shk/dSbAXetWafpAjzwPtMR26yehGW7Bvo
         VFN5caz6I3xw99PtnIn3WIAYIAKeLEUqWGb0+r6xMAzmWdoKuBwz9A35dI/TFcD8e5lI
         A+WXuArVw1+zOU99tAk8gOwRa9bWY/ujZ5tI1UdSPaX45+AeNUKV7t1ROVPaFHWMdR2o
         f3eeIwXKTnwK0ryHc1Z8uH13knylWwYm6qIdaZ0Hz9kuxcJ9w3ng5CFtc2/YDXstOGai
         5bsugaNLpv1cKz/3K6OBELOBPFkIYWQUtn84S6HFJbXQC38RiGMvy4p2y0/M/RvQ7Ppy
         ET1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynRlx9phW0ITcJS+U9gMXhm6fL2et/Qo15nC5VnSMLs=;
        b=HVFBHpK5W0lwJu8bigtq5nkVmB6eRvx0GMnsN7xBGYQM5lx71t65VAAJMjHeJeuDDt
         jWPutb9u9oBuiLMGR62Bps6cOWB2V2/gdVLfycGtc9RKa6ONDl1hPOtnQmU6q5EY+Y8p
         HjBsUrXu95YT1tfxv+2qbtr0c/z9dhxCM0U63pYwOI0Bbao72w7223AFkNJMeI/hFErj
         e9AabYofzjT7SL4Ca0QZ7jomv3NMguASzy6qI28UUeQhom0rfIAsV2Z2U/ywA/1HcDgV
         q+mKPPGybRYYe3mG1b0a0QfL8lrejlpCIeiMvEXT3TXZl/JGB79nnMiQIhJv6Osk6b26
         e9dA==
X-Gm-Message-State: APjAAAXd/KlQ1iONcwQI4x0EbcCwZOB+9X8NOw2hmEzIjepfclLBw0XV
        8GZYAOAf1v9ehh04pXHAkvp+WgGtA6dDLqDEIyY=
X-Google-Smtp-Source: APXvYqwwjJecTb0nqlK4JVyV04F6IgHD2x2ZikuFthSaA7+U3wnXUCxC44Xn9Eu+wKp8CyHNJW8TXbQgKKZXcZOBSOQ=
X-Received: by 2002:a05:6602:2413:: with SMTP id s19mr18043783ioa.161.1563056535930;
 Sat, 13 Jul 2019 15:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
 <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org> <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
 <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org> <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 13 Jul 2019 15:22:03 -0700
Message-ID: <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 13, 2019 at 2:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> I wish if we could say
>
>         struct patch patch = {};

that is actually a GNU extension that is supported by gcc and clang (at least)
and that sparse also recognizes as valid; it is also valid C++ so it might be
even supported by MSVC.

it will obviously trigger warnings if using pedantic mode and is IMHO not worth
the hassle to maintain in a portable codebase like git, but also wish could be
added to C2X

Carlo
