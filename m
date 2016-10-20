Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9712B20987
	for <e@80x24.org>; Thu, 20 Oct 2016 11:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbcJTLDZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 07:03:25 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37648 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932548AbcJTLDY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 07:03:24 -0400
Received: by mail-it0-f44.google.com with SMTP id m138so86321344itm.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 04:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B4ojl/k0HGdZOqWsRL3R+xS5y+laM5UC8OHKr2LFqb4=;
        b=dg5dqHEJXaqF3IfJkGQ9fv/fQpzsiRcSQlAAY/hwc3pmuJ98a4GbHwTvM+V4I1P87z
         eJiMF86P+H0yOou+pqdXA1HbWhYNscWH8nHN/hzUkgUhTXTd9jA32/QQdnoRTz6g1w1h
         ulQ7XZtamii22tZMyeqo4GMrDYjq26jG0XDQTpF4v5+N3DbV+mOn8784n4cmbk4tXx0H
         QhwCWcQsy78nT9UC/zkSKAzDij+DFlzNPA5694ebekbapFAiAr0zIWzvHO/GP3fB2C53
         nx+DIQ8EoPbRTfgHd0pXqwQrMrHCY70m3LxZMUOe8V8slYjPAKdFLKWX2cZMg5RHEYgy
         5vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B4ojl/k0HGdZOqWsRL3R+xS5y+laM5UC8OHKr2LFqb4=;
        b=aIblHkEk4edx0BP9lNmMiPBQO7mX7vXCKbzDoUNoZrwve+tFyiYERSvjqQ1uZz8xWO
         Xl7+G9aDUvx6ajTL5iwQlT1zj/+elVmNv/zXe9X+9WR8zl21Brz0PPE+7i44gA+By7LU
         Z/EQAxgU4Nf3Y5cAeBhmRApygkzdLAg611qoGzd1vF7/Iy3G/994CIq9nQChGu1JUjk5
         qgD8/GUfPDyKgLswuuxWOJhAEUag2LFvsD/pGHqFWtFiPgS756YfFtiny0P2ADwsOZRz
         HCCHEmg5JfJ3WHOBTEdqxNMWrkOeiaM2LUjQj0cawUixa4NgCCSde4/vwBroK7pmdeIS
         N4UA==
X-Gm-Message-State: ABUngveBa6BlkhSD+j5E7Tj0RqbnCCcnwL3Uc0shxZp9xl3TArwIWhtWqqphx0LfHhqeriFaSSeKILgc13o+aQ==
X-Received: by 10.107.15.222 with SMTP id 91mr55588iop.19.1476961394761; Thu,
 20 Oct 2016 04:03:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Thu, 20 Oct 2016 04:02:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 20 Oct 2016 18:02:43 +0700
Message-ID: <CACsJy8ALRjnvgM6sW5ioFHtquSR6zgQHkQ6-LUnKFnqXV9eDCQ@mail.gmail.com>
Subject: Re: Drastic jump in the time required for the test suite
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 4:18 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> I know you are a fan of testing things thoroughly in the test suite, but I
> have to say that it is getting out of hand, in particular due to our
> over-use of shell script idioms (which really only run fast on Linux, not
> a good idea for a portable software).
>
> My builds of `pu` now time out, after running for 3h straight in the VM
> dedicated to perform the daily routine of building and testing the git.git
> branches in Git for Windows' SDK. For comparison, `next` passes build &
> tests in 2.6h. That is quite the jump.

I'm just curious, will running git.exe from WSL [1] help speed things
up a bit (or, hopefully, a lot)? I'm assuming that shell's speed in
WSL is quite fast.

I'm pretty sure the test suite would need some adaptation, but if the
speedup is significant, maybe it's worth spending time on.

[1] https://news.ycombinator.com/item?id=12748395
-- 
Duy
