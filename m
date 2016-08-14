Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ACE41FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 20:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbcHNUEK (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 16:04:10 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36496 "EHLO
	mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbcHNUEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 16:04:09 -0400
Received: by mail-qt0-f178.google.com with SMTP id 52so14351751qtq.3
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 13:04:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9CC/cjwDs2tvsU8jGA7z2LwUlJMOWJprsPhQafSdKdo=;
        b=UYzVOHXKPiR1Ufs02X9/BVJiJjYLdYF2zcnv6QESEcRQyzqTAHkaYMeRnR2wTKvl2Q
         sBv0DjYUpKdZjXODK8ORsdEpxLLMEce8xKvv9NAWxs6446XL9cmVuZ/v+bnZKNVlTL3F
         V4hY6jmBdQwSdIa/4wBjgxhz/htcf0vAFcF3YwTzDwZQ1YSRGX4rWT3VaEakhoXMQ7Ec
         Ph7Z5WlsoMH7Zt2k4VLN5B2z6syESbKnT2trq/i5/9xobkt72YXuC0sqc+UjlYzi4lVt
         XNnMJ6Tbxm0AxMXXlynp3cOQ4aMNsK1iDBmRFbRkM+pakhQRnbMruDQm5/1TWvsmF4cZ
         UWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9CC/cjwDs2tvsU8jGA7z2LwUlJMOWJprsPhQafSdKdo=;
        b=R5ppECnm7Z+aeWD07wdMXhT+5+4Oem0DOCsEGUoJzBLg8q+pdtWai/SVmdiXOzoJj7
         ZYHXQYWCW4mra/RsOrbdmpFpokSkF3uO7jtKM7xrz4eWDg1LvMg/bBcxPxgAps1969c4
         qAiweDPO40xjhSoeRRgzmuXnjij+tQApfwlulhiERdXkULvtMHZkbcc7zQBDIgDJyFgx
         Zts3/7XSr1lxA8+HNYMeDaSTcSsuWryrc1iZCLxQ4qf6XMejwxkSd/1bxpMOH+R16yGR
         4WJBo0XlvJMp4WYdlSaVF+IzvEr40qlMfEvvoUtYiJ5LxmCbmaxXXfLH7yI7kBaTvwKL
         NPxg==
X-Gm-Message-State: AEkoouvmnRMCPePcCFUfFVGxRWIf+R95OqzqEvAh+rTo5X06+Np+G/n/uUpIpIb4bcdijTaVtJOqboieDvBfVA==
X-Received: by 10.200.45.181 with SMTP id p50mr27390243qta.31.1471205048343;
 Sun, 14 Aug 2016 13:04:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.51.205 with HTTP; Sun, 14 Aug 2016 13:03:48 -0700 (PDT)
In-Reply-To: <CAKkAvazV8umqbs+rTEG2399Ox0pGL1YAXsgLqHusb15RhzyH7Q@mail.gmail.com>
References: <CAKkAvaxWk6SK4EYPaWXHQoVBh9qLgHoEqAh9+dgOrjncsi5QyA@mail.gmail.com>
 <CAKkAvazV8umqbs+rTEG2399Ox0pGL1YAXsgLqHusb15RhzyH7Q@mail.gmail.com>
From:	Mike Rappazzo <rappazzo@gmail.com>
Date:	Sun, 14 Aug 2016 16:03:48 -0400
Message-ID: <CANoM8SWutGQaHJa6VCSJbRrFc9Dap0pKNUj74hhjm6hyHtYXtg@mail.gmail.com>
Subject: Re: [PATCH] make rebase respect core.hooksPath if set
To:	ryenus <ryenus@gmail.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 14, 2016 at 12:29 PM, ryenus <ryenus@gmail.com> wrote:
> Patch attached.
>
> It seems gmail ruined the white spaces.
> Not sure how to stop gmail from doing that.
> Sorry for me, and for Gmail.

Did you use git-send-email?  I don't think that the gmail ui works.
If you have 2-factor authentication, there are instructions on how to
set that up in the docs in Documentation/git-format-patch.txt
