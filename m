Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43C41F403
	for <e@80x24.org>; Wed, 20 Jun 2018 16:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754563AbeFTQWS (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 12:22:18 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:38309 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754480AbeFTQWR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 12:22:17 -0400
Received: by mail-lf0-f53.google.com with SMTP id i83-v6so206284lfh.5
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+ZcEBQyumH8d4uxfRh4XX/fqG+K3pd01iEh2GZanFA=;
        b=QW1Yim9dbB7ZZ6zrr5VP1684BQArUbDnnnAi1vZ6DC2N5KIT2q2zoVVmX59LsW03M5
         Ko1jbh7cqA+JlImDGFCwiVkeOywaSciHbPIvjIKwAfJPbrTAgzKr+SndkHTWP7QDQNBG
         pa2JujPdM6qcvbcieUgPwigDaAKV9mOH5+GZEbTFCZwdDUdNDpIA4+OTM+QpnydyNk3z
         DubNsz8+d0UDB8b5MaO833qdeDrvIdZfsSiLtoyVeiPrl3krnnqe/GvInaCfv7q9muzu
         PW9yWX5eSl8mpoLbjZu9NjRb/8O4Htnyc7O4ub8K42Pq9/HvwU0AQo3pWpfXVe7RV9oH
         kHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+ZcEBQyumH8d4uxfRh4XX/fqG+K3pd01iEh2GZanFA=;
        b=mckT4eyuSUUx2z7dA8z0sEiXXvRgOku6fZIRefAaKGhUjNNYAs2vni8r93oKgu5SV5
         hWpsK825vjaE0S8MeMaGc/zWDEyx7WR5kpcDaHYyEbur8cjQ92BF9DNq7TBQ22RnaSmC
         5h5TZ4aCT8o/8AuFAiTpyo5t49kJUeVVuuBMVAYIq/kziVwfi/BbBptyqHWQcYJ9VtwH
         Vkg41JIAK1BFA+WAVja0nBu439W/QMt2afodCrMkJ0OObEzUYBHPKYbpNnbnqhc1L/qM
         l7gFIHLd+7ssDx26AWAQa1gMYrcVCl3duDocF5YcPTBSL+XjjVU+BgSP6RZaH2ZI9mi1
         hwLQ==
X-Gm-Message-State: APt69E2hA7nBa8T830H7aHHnB5bi1qPbn8Ww9E28WTCbORubD0HR6eJx
        e1cBp4Y0oUIeR29A3nd4Z5dTfBQQEKC+z4RQ6pQ=
X-Google-Smtp-Source: ADUXVKIOGzexDFms8V8HMITzd/mhmoi261NEn9eijWfBcJUtRGZM8zb+ioGMWdJHePZvWsdi1geQgGvdMYd9WAttK40=
X-Received: by 2002:a19:ce87:: with SMTP id e129-v6mr14107771lfg.57.1529511735866;
 Wed, 20 Jun 2018 09:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180618111919.GA10085@book.hvoigt.net> <20180618155544.GB6958@alpha>
 <20180619102717.GB10085@book.hvoigt.net> <CACUQV5884fs2wp+R5a-99BbJGdEbujzu2iBny+PjPeL9JeOm8Q@mail.gmail.com>
 <20180620043956.GC6958@alpha> <CACUQV5-ynAv0p9MCRt0Yv9E6x+UN5z4uuaPOt1GpsK6A6MF2wQ@mail.gmail.com>
 <CACsJy8CW1=Ea984s8J0Y6y4B6qJKZMdsXVFRQc8YcuoQNfXEqw@mail.gmail.com>
In-Reply-To: <CACsJy8CW1=Ea984s8J0Y6y4B6qJKZMdsXVFRQc8YcuoQNfXEqw@mail.gmail.com>
From:   =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Date:   Wed, 20 Jun 2018 17:21:38 +0100
Message-ID: <CACUQV5-BXQ3PLZ6aiZEqHS39yv4ZJbg_cKwMDCZvHBD6Op_g2A@mail.gmail.com>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>, hvoigt@hvoigt.net,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 11:28 AM Heiko Voigt <hvoigt@hvoigt.net> wrote:
>
> Interesting and nobody complained to the mailinglist?
>

On Wed, Jun 20, 2018 at 3:57 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> Abusing a long standing bug does not make it a feature.
>

To make things clear, I wasn't defending if this should be considered a
bug or a feature. Was just clarifying that this isn't a newly discovered
thing and was reported/discussed in the past.

--
Cheers,
Rafael
