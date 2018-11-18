Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40EC91F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 19:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbeKSFV0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 00:21:26 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:37524 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeKSFVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 00:21:25 -0500
Received: by mail-yb1-f182.google.com with SMTP id d18-v6so11768184yba.4
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 11:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sd5adkQVw7Voq5AqyERpH7d6C9d9qh67rKjE70OJfug=;
        b=VSQWn/f8aXwehz2xXEB2zxh5aozL/FEyXSWzgWjNKQ3oMDoWTGA6wNIjihRD0gzP7e
         GpwnqII2IjTi8/xvVnlfVipEZh1snE6eIGDrAtY1TCh0vwOs7nYSlUFoaYQfYRY+r3mF
         ikJtc2iowJmcHCwL0+5icrqPq+t0tGtS+Mk/aKGYJwwClYoAJ5eeSOw20viC3JHYhs3Q
         JmDTCDbLecx8xwWThlqLP5viOx45rz6arL9eE3wr+uDIiB9emUUufMq1IXlntQ4kMoVj
         I1wPG7alQBswmU7hdGB9HvBDj0m+E2fMLw+twxi35HXGpcwcb6N60MEdr+aHSZKh+TEy
         JSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sd5adkQVw7Voq5AqyERpH7d6C9d9qh67rKjE70OJfug=;
        b=K5ZGzhTvIh2SHqUnGQS3o/nE0M9oByExN6IcTEatU3ne4Q6yVa9ODxn6EbqDHkuoo5
         rhJQ+lMigf4tzskbQQrsDMZHGwg1h/0adQ1aBnCJ6X0bXyQccafJ/BRPh5B2FgL9Ib+5
         nGGapykz5Kt0Jg1IOCr5bn6HET7JS/CtaZJclPUlp5KcXVbWJxEqtFRq/S09OaGLsfh5
         t7vwGFFSTmTfm4m1RzWjFxPX+oPFGvDvSiU+E7FU7d35x6gruLvE+FzPRXzKWVNZIsYj
         iN8+pAAERL7FGu9OEsGHKFRZAHEQUtb7/5TpMVgzJgReN2KtYNTgnAsS4Tg7eUb7wYWQ
         N3wQ==
X-Gm-Message-State: AA+aEWacNPuZtv8I9kExXxT5jcaTDCwTN1iZCUZCB10fb1A9LQOG1SU5
        rlsVcshxd7wqPM7xQUfSnCLhtNIJJ9v8yc0lGXw=
X-Google-Smtp-Source: AFSGD/W8Pxwz4rliHX0yeWi23+ttbFB97hVJdwrJ+LDz2d1cE/BdFehnzGZGEyqw2e7oDwzK0sgSUtp4+hSm1rDDyIo=
X-Received: by 2002:a25:952:: with SMTP id u18-v6mr2615697ybm.464.1542567621641;
 Sun, 18 Nov 2018 11:00:21 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181118154124.GA21680@tor.lan>
 <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>
 <20181118171525.GA25854@tor.lan> <CAAXzdLXmJ1YKiTF17b=ZfkM3HtJCNkvVMQNU=riW8R42VLid_Q@mail.gmail.com>
 <20181118182847.GA31405@tor.lan>
In-Reply-To: <20181118182847.GA31405@tor.lan>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Sun, 18 Nov 2018 13:00:10 -0600
Message-ID: <CAAXzdLWByGC+B_XdDiJwounoPgMAsMq=EuOSx9bdV-f5vQUhnA@mail.gmail.com>
Subject: Re: Cygwin Git with Windows paths
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 12:28 PM Torsten B=C3=B6gershausen wrote:
> Thanks for testing.
> It looks as if there is more work to be done then just a simple patch.
>
> My last question for today:
> Does
>
> git clone <source> '/cgdrive/c/my/dir'
>
> work ?

yes - these all work and resolve to same path:

   git clone <source> /tmp/goawk
   git clone <source> /cygdrive/c/cygwin64/tmp/goawk
   git clone <source> /proc/cygdrive/c/cygwin64/tmp/goawk

however i would caution that any fix should not rely on "C:", as users are
allowed to install to other volumes such as "D:". Perhaps a better solution
would be for Git to just take the path as is, rather than converting it to =
an
absolute path?
