Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823261F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 22:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfHLWA2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 18:00:28 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:39064 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfHLWA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 18:00:28 -0400
Received: by mail-lf1-f43.google.com with SMTP id x3so21548416lfn.6
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 15:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JR0iH9+5QiLyxpHpxHxqVzFtrxBk5RAZHYxrKyfPxio=;
        b=mScYJWN2lnFLvZxQU3XS0rlFvkADyXMtRWpP89rpgfjsSNN6sflvAiM62Bu06KKoF/
         GmRyf1RVh4n7bdUFpSUhDz/UNnAllr4TyhCjH+22Z6khaTYiNatRcj4fs2AUD14nGpiD
         6sXnuaXFS7iIcS4v5gzu9CMUyMvHdyXKqmnTo3iU5gRf50Pr43vkZk2b2Lke5Hlu8Sk8
         9ttRsUb/H0xIv/HWvmY9kdw3IM7u0c3IqHcSBwO0MgqALWpDn0hDujxpEPLNyUpyFf32
         fqYP8X/2cg22eFibHU3v7Rd2910qCvFJU09np9YbPkrjz3cMLco5aDRrBXYGTrgT/IcE
         SmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JR0iH9+5QiLyxpHpxHxqVzFtrxBk5RAZHYxrKyfPxio=;
        b=ON7/43aTs/1qiBZrkZD9+meDzU+5vRF73T4BQgivNqKu8XwtxejZv9WG39ZSm6+ibV
         dxotLQNum//M+Cxs8rpm2NnQs+gnAd2lChVilEfMCNO0Yi1DIw0YN3vtPeYrL7Htw5gn
         epblQN7qN5rZPOPQKPqhYyBN0WZecUrOYh6e/21miROOLLa7J0f1h1lKjSJXLJHqxtDv
         KCQnf+F7lQfjr7PgT3vk8ju5whbFNBslbVpO/b1ym2QrTnGQfuABxCbVudmNsYa9cJrf
         h0qvJci5yi30AA9540nOMp5jv5zrwJg9pRvWYDnJ8Mgfm4UO+juya8Ccl9HtRfANuHYe
         xYgA==
X-Gm-Message-State: APjAAAWREQ8D+QsDv8c2R4qGMB1M81CH5svufsPyv+vnbn9fbmLTDYJK
        vhJAp7W15NPoUh7Nm3/kF4wZtuQMWagRvxAbifahIC76yzo=
X-Google-Smtp-Source: APXvYqwvHy8FpXh3vCH88B4IVD4x3WyYiMV20qp6MXOM6IUbiynVZmSLvuCQjISHe6mrCUoAtVXgH80BQ6bLcKtM6Pw=
X-Received: by 2002:ac2:5a01:: with SMTP id q1mr1368956lfn.20.1565647225977;
 Mon, 12 Aug 2019 15:00:25 -0700 (PDT)
MIME-Version: 1.0
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Mon, 12 Aug 2019 18:00:14 -0400
Message-ID: <CALnO6CDFQA_QmR_2tczPNJiymfUxt8LUiF0HOvKJKreB_HmNuQ@mail.gmail.com>
Subject: send-email and credential
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I spent a frustrating hour today hoping to setup git-send-email with
my gmail account. I've been able to confirm the following:

1. git credential works

    # git config credential.helper
    osxkeychain
    # git credential fill <<EOF
    protocol=smtp
    host=smtp.gmail.com
    EOF

outputs the correct username and password for my gmail account.

2. I (believe) I setup gitconfig properly:

    # git config --get-regexp sendemail
    sendemail.smtpserver smtp.gmail.com
    sendemail.smtpuser ben.knoble@gmail.com
    sendemail.smtpencryption tls
    sendemail.smtpserverport 587
    sendemail.multiedit true
    sendemail.annotate true

The strange behavior I'm seeing is that git-send-email

- prompted me via macOS for keychain access (expected). This happened
twice in a row, during one command invocation.
- prompted me at the terminal for my gmail password (shudders)
- stopped prompting me for messages send after that (all within the 15
minutes of the first two)

Can anyone confirm/explain what's going on? I've never tried to use
git-credential or git-send-email before, so I'm new to those (but
experienced in git).

D. Ben Knoble
