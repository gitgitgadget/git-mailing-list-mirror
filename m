Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3235C1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 18:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeCUSdv (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 14:33:51 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:51570 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbeCUSdu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 14:33:50 -0400
Received: by mail-wm0-f41.google.com with SMTP id v21so317329wmc.1
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HaKh9bjidrTllE4Wq2BaNvHOd9zAWtT/DIzX0w/3SCs=;
        b=IuOyssqtX89nvfgPWMvqoQ81bfD9Q5X9vB9ofe3S6hcKqEHptU3MfNLZATw5fOSEA6
         TM9HUMpU4plEdrlowd+y1UlkMh6JJW7OOO70r3+3KwGW1YgJeewtZ97jVM32hkyJBQkJ
         zVUcFYCHmWEqF0O4hqQ9jdqiWDMq8ghRtlpZiGoooLPp3z4sbfpzdE2ZWZ5U8lmsNlm/
         x7QIXsIrXQPND+TBbIyJvjYkgjUSXdCCAqzitfr2tvoKV5NQ3Blw20YhoEYCovJZPncT
         6/g8OR9xODJFdAAJNvbZDKsgIg7nD5QH1ZY1u2L7Jt8ZmKf4ZxF9W1NRjzJPB2dbi4wR
         VY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HaKh9bjidrTllE4Wq2BaNvHOd9zAWtT/DIzX0w/3SCs=;
        b=sQkj2EB4DM9o01Y8fO+BRRKli8taxljbWEbf6GcWFcdLq02YBSWsQcb6amx9IXEl5a
         30rY2dCnsYHaUQnCuthk7oIO66fMh2xX4fhneq4CcuXOdQody64l7yElFoU3xQU24643
         YJnaMY1/CwnKgeynbHhQ7yqHDe+EjL4nGtWklqsjJ/lFpEiz020nzNeiNtnXPwqGUrB0
         aaUWssQSDLPKpLmedYK45vP+13YhBok7zzioCM6i7xoHBLscwGGpnp2tKWgE28qsB9hl
         FIpuEz7kKeOUWcTq4bGgEj91X5CGmXjpG+f62/HhV0EzLURWWMSIiwl4wOWpazkRjeCA
         jyrQ==
X-Gm-Message-State: AElRT7GviPqItlquWvaR1Kz9paRcbdIcFqLo/MJ462oXMdOrWUekvvkj
        qP1TfAeqj86Qr2cOHy4LPbBaIO0Sqhl73v7bPHc=
X-Google-Smtp-Source: AG47ELsCLu/5MyqdKjKPo/jX4tj052dOXY0qhKhPFGe71Dd5l9l6F/IUBnFm5EcvqoC0BFhQVWXqKgViz4ixsGUCdY4=
X-Received: by 10.28.85.193 with SMTP id j184mr3386420wmb.109.1521657228978;
 Wed, 21 Mar 2018 11:33:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.157.205 with HTTP; Wed, 21 Mar 2018 11:33:48 -0700 (PDT)
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Wed, 21 Mar 2018 21:33:48 +0300
Message-ID: <CAL21Bm=H-t=nkbEXMQdcEXj8h=6o9s=LJ7gC88sA1PPB4v0A=Q@mail.gmail.com>
Subject: [PATCH v5 0/6] ref-filter: remove die() calls from formatting logic
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add strbuf_error() as a first commit and use it in all other commits.
Good line reduction, -67 lines compare to previous version.
Eric, thanks a lot, new code looks much better!

Thank all of you,
Olga
