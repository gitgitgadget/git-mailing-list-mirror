Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EEEC43334
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 00:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiFZA2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jun 2022 20:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbiFZA2N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jun 2022 20:28:13 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE861D106
        for <git@vger.kernel.org>; Sat, 25 Jun 2022 17:28:10 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id d14so6051806pjs.3
        for <git@vger.kernel.org>; Sat, 25 Jun 2022 17:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYciC5Gb2GB9+leRwg5+bz64DOgIIDz+v2odpegMCR4=;
        b=HSZQyYOFmo7olZ0cBN/Kac5umbXwB0ZDRuECHWhqT3jIoMsU3Q4yFjxWIybDcHnTMK
         EE+6CMl9oM2FV/1hQOwe4g+WOI0mdmsvSMs2E2DB6Fq+6yEEiJDzt1DvAJt/RF5L0fP8
         nwvaLCVoivpkVO8CguYImx0nIFkZR1gDE7XY23CxqWTDibhRXIEuhZ88rT8lj/qUWJZy
         KpkXl8KukeOPR3Fk7PsuH25bqly6CJmOof78HeFxnA1chh8aZ3HMf/IdbPto5Ck5EY1k
         9wzSu7WgAhROn8ddhgE8tGlmiCAq3jzQhsaBSSUD2zsLkX4rzjuU0JReS1Cv+UbUTY46
         gouQ==
X-Gm-Message-State: AJIora9ubNUfMG5L3Tbi5sWSEBf04WH36E6vCohhZwphYULJjz2/sflG
        qPfaZWSVqlTrNQ9sN6U9UeXS6AjbUN8VjWGiUPc=
X-Google-Smtp-Source: AGRyM1sxdcp25TgZhhvKLafqE4OgtysgvjhBmJCjt99p5qAgoN28P+klnRHHfEwUiCgu1s8TWM2RTmCN/8xuYZTTHZk=
X-Received: by 2002:a17:902:da82:b0:16a:7ca5:36df with SMTP id
 j2-20020a170902da8200b0016a7ca536dfmr3863855plx.91.1656203289521; Sat, 25 Jun
 2022 17:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <12011256.O9o76ZdvQC@thunderbird> <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
 <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net> <YrWXdNGZGN7gXL40@coredump.intra.peff.net>
 <YrbNIUnftj+Ooumo@tapette.crustytoothpaste.net> <87czewxp2u.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87czewxp2u.fsf_-_@email.froward.int.ebiederm.org>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Sat, 25 Jun 2022 17:27:57 -0700
Message-ID: <CAPc5daVtRZ-Str_yCqRXZKT5+KKcXdnptFaer27XneUwj76KjQ@mail.gmail.com>
Subject: Re: Plan for SHA-256 repos to support SHA-1?
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 25, 2022 at 5:10 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Is there at this point a solid plan for how SHA-256 repos will support
> access SHA-1 only clients?
>
> I remember reading a discussion of having a table somewhere that would
> translate SHA-256 to SHA-1 when needed.

Documentation/technical/hash-function-transition.txt has flushed out
the necessary details?
