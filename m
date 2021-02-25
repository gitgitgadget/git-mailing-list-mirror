Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301B7C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 22:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD12E64ED3
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 22:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhBYWlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 17:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhBYWk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 17:40:58 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F68C061786
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 14:40:18 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id u20so11544947ejb.7
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 14:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xdQQoG33phJCPgBz0N3Vszx+N41PndLFCkiUyVYoNT0=;
        b=M8H+Rye6Ky7bk6VLXyPD+9t77J9kiHjbyK3h1m4LmrjGi9VT6Yso6VVKapbSivFogw
         og9qrCNS3ajRF+sfnGzK2sr5mxaL4Fr/KHezeveLROM4baXo0SO7QNcoyuWB/vzXk3hj
         4oLojmq/c0PDJyelCEmqYDHsakPpixPpZEcaMegPccz8bCMr3+r9kKy0+bEiD51NUaOs
         4OzgioFjQzKrgnjBLv3ry2+cyw19WNEXy7m9J+7P8mzrbtCMudSx06/LoXIVKCM8OdSO
         RreniGjaBS3Uehm/lOi4PsVMV7Wbo560KE+vO6nsy2V/7Jr5Ij+wcYINVB/O2M5aeoit
         Ynjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xdQQoG33phJCPgBz0N3Vszx+N41PndLFCkiUyVYoNT0=;
        b=A690QovV3V78r9Rm+eJTzZdLhVdWv9J1zF6BXvS32YkTbqn3jgmQsfqp1g9GpQvQ//
         DeDKvuPpiXgqeipeiLe4gsNKnIIPaqhc1QVlNMDilVurLCqV8OpAFiU5IDGAHW4lIBUf
         9ocmjaNRvaCthzH1YjmV+wTFRtymouR6Vo9iyK5lHI5+Y50m3yeHpGIQMwMovg5NuyBH
         LzK9O5V0ub2JT36MPiBTq2GpCiWpyTqXvWLxrTp7V6r3xz6MkkMl6jbexrv+zOccGX33
         cuL9d2XNa3ryULom8uFRv52nXL7hJuUh/tcB+JbPpDcdR4c4VOQB6jZjKSTykbqX7xJu
         cjGw==
X-Gm-Message-State: AOAM532kvyBHPArmSFENOSbFG8uopc6f/cjR6WyM7MBrmtx7Bm5T/miJ
        OI9nOjZIV0Ms109KxTsRLL/ZCZBN1NlRcbLjf7I0qakRslUytg==
X-Google-Smtp-Source: ABdhPJy2fnVH4rQkl2HCkHIbiISkWnf1rYhJppkiH9xdEUI4+AGJNZWebSU+fEf/+EA9HOcY7SuzADTF/K+SMxp9sjg=
X-Received: by 2002:a17:906:3883:: with SMTP id q3mr4956015ejd.160.1614292816827;
 Thu, 25 Feb 2021 14:40:16 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 25 Feb 2021 23:40:05 +0100
Message-ID: <CAP8UFD2Z9aiS==Y==N-=LgbnBL6Kn1LnT0=Dy9YMvFXae=RC_g@mail.gmail.com>
Subject: Draft of Git Rev News edition 72
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-72.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/477

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Saturday
February 27th.

Thanks,
Christian.
