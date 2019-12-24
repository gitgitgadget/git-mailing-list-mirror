Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072FEC2D0CF
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDE320706
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HilZ36/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLXLHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:07:03 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41143 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLXLHD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:07:03 -0500
Received: by mail-ot1-f43.google.com with SMTP id r27so25976048otc.8
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CR7BVNV2dBADMRXtsAe1wcR1wllAMld+C8L7d6cZoaw=;
        b=HilZ36/GkRkuFDE+NRgDlNZo+/vDnAFplgolUqSaCNudRH8Tz2wAnQLB+VmsX8maSU
         Se7qQx6Ro1KGrc8NzuKjWFaSgMlFDyPVL/dFPxfpnncuSQetUEsFlg4+KDKgucNa5Bi3
         0TuYwin/buGZ+0RUbnNOlOTeyvGwfbuk+bEKUZbw8oAk1jhbQSwuVDfP00E79cmU4mgj
         DaEeTtn6OQaUiebShWHRDI2IbFHH/qEgJUlaot6fHfUY0rUZpnF04itaSv+MdY2H+FJd
         AhSH1tofiku2k0KGM0EP+EJ54i5IC6uqNNCe5lNaXBzCMat9nnA6seI2UGd4w2uAm6eo
         L3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CR7BVNV2dBADMRXtsAe1wcR1wllAMld+C8L7d6cZoaw=;
        b=ZidhcEqrjw48VZ9gSNeNZ77awe7eJ+kFpzr4sI7JwSAcqe0mH1E20L2bT0RRS26i8I
         29V5Q0kM6uEDbqUsT4PtAjOrIJrHRdeK/WPUmJDjn2bWAY3UZBYgDSQ4Ipv6GtS3BV1m
         470Tg5c177EeztcTcJwLEPnqRr6HPaAGmkl0/yTzOUE5E0/cRRE3SP2qGhZzEVYHtNHg
         NMALIkOcyhAPDo8d9ZKo76cNtGndXpToWE81deKOVjW2/AuuRq6W3UO6BMwkHvkIHrSU
         3SEgYJgiaK3E8y8bfAz88GP7mZieqXxMs9U2BKIWTAAJlM3r5Q2n9ww9HxXqMaX/M2nG
         uKgg==
X-Gm-Message-State: APjAAAUmRiuz08opu7sKFUtgu19Bb/lQ5mC4YfCveWzczC66PIqdPauL
        Q5k44xijvOT0OxR4KttkALXanpawv1AoQHt1WpLZygAO
X-Google-Smtp-Source: APXvYqwZw201Nkyn9AGFFOYVXcHecHYIifEyMG8vUZf4Rirh/bmFPW3/GdT+aj+cbl9eDcXzRz0K3rX7vXplWyFvPYU=
X-Received: by 2002:a05:6830:2102:: with SMTP id i2mr36120509otc.123.1577185622819;
 Tue, 24 Dec 2019 03:07:02 -0800 (PST)
MIME-Version: 1.0
From:   Gal Paikin <paiking@google.com>
Date:   Tue, 24 Dec 2019 12:06:51 +0100
Message-ID: <CAEsQYpNtgMgwjVSOYB9vn-YPvKyKPZ2yZ3NigAVe3PztTN4v8w@mail.gmail.com>
Subject: Updating the commit message for reverts
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I work on the Gerrit team and I would like to change the default
behavior for suggested commit messages for Reverts.
Currently, if the user is trying a change called '"Revert "change X"',
the suggested commit message would be 'Revert "Revert "Change X""'
which is silly, since sometimes users want to revert the same change
many times.

The suggestion is to change the behavior to "Revert^N" instead of
multiple Reverts one after another.

I'm happy to change those things in Gerrit, but it would also be nice
if it were changed inside of Git.

What do you think?

Thanks!
Gal Paikin
