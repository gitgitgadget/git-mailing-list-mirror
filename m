Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75971F404
	for <e@80x24.org>; Thu, 15 Feb 2018 00:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032369AbeBOAg6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 19:36:58 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:38867 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032189AbeBOAgp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 19:36:45 -0500
Received: by mail-io0-f169.google.com with SMTP id d13so27117135iog.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 16:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c8HbLouVdXkw+/aApj4G1FtUBxDHdSULAdIfneuMLTk=;
        b=Y5JyeQcEVEa9QM+GvMkv728zlPPKqJoMLR7AdwPntxfSPmHrjrwfId0KHVHU69UVJR
         m9/S2o4/63auCawMB97cSEICOm2d6sHJxyGo7+RwTgpCCN1qVJP2xk5QfTv63id7U/dO
         0R629K82hvStVK1wFP3BScLmLX4jYfcnoEQAQkz+WU5RJ2JWlmLVZ6TQ4GRrL2up16/N
         NxuWKq5HB3TPzMFiB/YQjT5kn0fGNDDZcumR60B1r2z0yeOcVh1pkPxUDlUWHXiiH5+g
         EkHKwnoly9gPxiCBu8MNikjqprLckLt6st+/oJXTpusOh4C3sKIP3XHzgBGsSuW4QmEe
         0UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c8HbLouVdXkw+/aApj4G1FtUBxDHdSULAdIfneuMLTk=;
        b=NVLNqN6zvxzKH4+3NM4H3ol+Jyqik0V/WwHGV9YyvaoEdZw8TP0a8KCbOsbg5PR42C
         LFMTjxpYVUqWsIMj1BXdbw6/oOgVb/IUMXJs1tug0UaVomqpiiZWJwTxgneJ6uu5sJdc
         EfMtQ0chYxvg9ZMokUI7hTaZCL1qA3eljlc3jXcjhfns5FxD10zkVsoYQrWAGuqyPsDG
         UBOdCIKNhHckh/3Hkr+sKeoi3bKMVf6i/1tisc4F5/39VngM5HG+jYNZjh70IE7HoHPt
         /yCj/P2LRIv2pGAFP+cRZLDJ7PV/yHj9d41xdHIwLLuNA9MoQEHpC0XU4XKzf0aNawdN
         wj+A==
X-Gm-Message-State: APf1xPAo9Z4VKRayOUmSsilOfRdPBcivZ2htWjj5pQ8zvfDKAKhVZfPe
        PYIIWGbqTpMSVDpTNOTyoCBVGDjwquftp2WmjGs=
X-Google-Smtp-Source: AH8x226k++sjAVacJFvJF96IVb+Prjg4iFgGfjl2qqDFiphY43zS3+3lnuqg3G7w/Me9l0GozrHlKBPcBcqfluug/6M=
X-Received: by 10.107.28.66 with SMTP id c63mr1452074ioc.247.1518655005152;
 Wed, 14 Feb 2018 16:36:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.5.147 with HTTP; Wed, 14 Feb 2018 16:36:44 -0800 (PST)
In-Reply-To: <CAGZ79kZf1UKsBEJXuwAH+EWr+ZKj-FE8DuBvcM2nJeNhLEA4CQ@mail.gmail.com>
References: <CAEWZXo7KiRWK7ddyZgQKs=F+sHY7TtFsXTMXyE-57=FRr6kf6w@mail.gmail.com>
 <CAGZ79kZf1UKsBEJXuwAH+EWr+ZKj-FE8DuBvcM2nJeNhLEA4CQ@mail.gmail.com>
From:   Psidium Guajava <psiidium@gmail.com>
Date:   Wed, 14 Feb 2018 22:36:44 -0200
Message-ID: <CAEWZXo6ws5q-73AP6+Ru39a+drO88fRO49_QGJbQXfOYRpqKwg@mail.gmail.com>
Subject: Re: git-rebase --undo-skip proposal
To:     Stefan Beller <sbeller@google.com>
Cc:     Paul Tan <pyokagan@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-02-13 18:42 GMT-02:00 Stefan Beller <sbeller@google.com> wrote:
> On Tue, Feb 13, 2018 at 12:22 PM, Psidium Guajava <psiidium@gmail.com> wrote:
> I think this could also be done with "git rebase --edit-todo", which brings
> up the right file in your editor.

Yeah that'd would only work if one started a rebase as a interactive
one, not am or merge.

> cc'd Paul Tan, maybe he recalls the situation.

From what I've found on the archive, he didn't recently answer mails
that come from the mail list, I could be wrong tho.
