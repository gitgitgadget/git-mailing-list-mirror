Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CAB71F597
	for <e@80x24.org>; Thu, 26 Jul 2018 09:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbeGZKYf (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 06:24:35 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:44942 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeGZKYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 06:24:35 -0400
Received: by mail-lj1-f174.google.com with SMTP id q127-v6so850744ljq.11
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 02:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+rvsYFWRArSpCmpkkm38GRCU28lKUdeuvQ53C19hz+8=;
        b=XbsH5PzMBpC7sC0ryTdsFI4CDI2kyLct+rwb8iHbgdlTJxg2IWAKu5idaIkaYGACX4
         vG/lSQwZAeSC+p7NCNFZ5/5OAZ/eGXFiCb/9jED+cuZZ8ndGKIaIXbQVwmy1gsnTYrlr
         E58ao3A+2/Ni75/voLpy6VoKzr0q3iV8L+eMHtpxu6dhXk4giikVxIu48XkDFU7i4nh+
         xrp8BABeQyuUHBjkLC22FeyKdTD8YiYKawJ6vTge9N0BZyj0JxZ6FVngz9QofHXd4gf1
         CIjzAHj37divhEzteyac8D4IF4S26FaJYeOT6p4eoL1ilGiJHxLwFjvHlIcGTx2Vg0C8
         V8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+rvsYFWRArSpCmpkkm38GRCU28lKUdeuvQ53C19hz+8=;
        b=U35nUikani9wTLefta3Sev2AbCYcba+3BMjBZ5H+R9nKg+mcOewexJwBqAIWYw0gxI
         xmpwNE9rO9WrHhka/9xY3OwkIhUTqNjzsRoivTD38yAe9gPTHXKp1IiwbS52hFItgGVq
         JHf0vQRvffszL5xpoaf2JUBqxNCh1HCQc8JIZSMmqLgBfpTwcHG9VuvEtHIhcP9TB4sV
         bMqIiD8h/K3aD8oLOsCXTsjJEWZXwsYyaTdnFHQwaJsOPD/k2ePDvr6A34KKJhrjypf1
         yOiVnTJ6E5VRyPLKsKxyBPr5PUIS2Oi6KFZmTwDAvhsIQrJ/ac13WJEROj/6JDHuXbMx
         /GQg==
X-Gm-Message-State: AOUpUlFnxUacM/0dtbvozzxDaOJRgzouxi2MFpjuxZfsfu89vy7LxrP0
        ZXS7uKCX3Hzasws4IKPnbkGEWvngTk4mXn7Wl9t48iBP
X-Google-Smtp-Source: AAOMgpcTruuEP5+CwVBQ3vdvPcWvY0dCct47+uPQPABKvzuK9DDw0YKYHb1VGmF+kJ6ygxUBhdE9A6gVo8o9W6JTOwA=
X-Received: by 2002:a2e:8616:: with SMTP id a22-v6mr1027093lji.43.1532596120014;
 Thu, 26 Jul 2018 02:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180723130230.22491-1-szeder.dev@gmail.com> <20180723130230.22491-3-szeder.dev@gmail.com>
In-Reply-To: <20180723130230.22491-3-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 26 Jul 2018 11:08:28 +0200
Message-ID: <CAM0VKjmqwByERhPZLqZfg6JNEEeMkKQU1XuD93aW+3yfc2gucA@mail.gmail.com>
Subject: Re: [PATCH 2/2] travis-ci: fail if Coccinelle static analysis found
 something to transform
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 3:02 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:

> The only way to draw attention in such an automated setting is to fail
> the build job.  Therefore, modify the 'ci/run-static-analysis.sh'
> build script to check all the resulting '*.cocci.patch' files, and
> fail the build job if any of them turns out to be not empty.  Include
> those files' contents, i.e. Coccinelle's suggested transformations, in
> the build job's trace log, so we'll know why it failed.

And this is how it looks like "in action":

  https://travis-ci.org/git/git/jobs/408269979#L570
