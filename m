Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E079C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227DD20835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfK0Rsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:48:31 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42336 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0Rsa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 12:48:30 -0500
Received: by mail-io1-f68.google.com with SMTP id k13so25805269ioa.9
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 09:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7mOY3IBS/yVuIserPQ8aSHuAzIgSg11dl570+RMWkv0=;
        b=liU92r4ANjjOxd7OfvQbdJSLq5jmE+szuriC4fgHdj6KqNkEQy0o90m/NDVVaP3llc
         Naq3E+y8VPj6cI1E1bDXuX1aqY3zcgp9S2X31EgT482iQh/2ZeuyvKJf75FRg0nFeFkk
         gl0gvBZUX2OqHqC5i4j9qa6EYl23lWK1w4l/1C4POTna/eI6y3LlGu/WV73nella7nQC
         Sg1s0MP19aBVfqlNBngYdEYYMlpm7H9EjUtjPStOKKN9eSunt5wbYiQrj8oO8148//VO
         YACAcVvTN1Kdbij8Hg9fd0UTBVokWFXjFigqiHwzQKiwCsTWLEUzEADk0vBUlDAD2CcY
         bfMg==
X-Gm-Message-State: APjAAAVIlTGhbeg0dvcnbSQ7QRp0qxaEUL3GJnQo/7CW8nHwrr3jhc62
        YanC2TNzzmWT91kahUp8pB0dbSdZTfsgpG6pV8DETb4abJs=
X-Google-Smtp-Source: APXvYqwoheLWg0ORpaE1dL/i0WjDQBg77ybCXwDZgUgs6l3mYn/DWOZ0bwqdc5yfYBvtEpg347qhIikYInFa2Ns4vn4=
X-Received: by 2002:a6b:3b06:: with SMTP id i6mr19668031ioa.185.1574876910108;
 Wed, 27 Nov 2019 09:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20191125203740.72249-1-emaste@freefall.freebsd.org> <20191126004419.GE2404748@camp.crustytoothpaste.net>
In-Reply-To: <20191126004419.GE2404748@camp.crustytoothpaste.net>
From:   Ed Maste <emaste@freebsd.org>
Date:   Wed, 27 Nov 2019 09:01:56 -0500
Message-ID: <CAPyFy2DLYHZnzrwA27JQRxGkpf=+Z8ND-6AX3+oepAL+RNwQGg@mail.gmail.com>
Subject: Re: [PATCH] ci: add Cirrus-CI config for FreeBSD CI
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 25 Nov 2019 at 19:44, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> I'm all for automated testing on FreeBSD, but we would need someone to
> triage and address any failures reasonably quickly.  Is that something
> you'd be okay with doing, or is there someone else who would be okay
> with doing that?

Renato Botelho <garga@freebsd.org> is the maintainer of the devel/git
port/package on FreeBSD and has now also joined this list and offered
to help triage and address issues.

> Could we fix these issues first so we don't have CI suddenly start
> failing?

After some further investigation I believe these tests are technically
invalid but work with glibc because of its looser requirements. I've
sent a patch (t4210: skip i18n tests that don't work on FreeBSD) to
address the failures.
