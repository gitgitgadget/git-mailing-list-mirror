Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1306F1F731
	for <e@80x24.org>; Sat,  3 Aug 2019 18:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfHCSWU (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 14:22:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40356 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfHCSWU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 14:22:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id m8so42184959lji.7
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AnIZlL+jkbLT2mHohgUbnH1ikveTHzcrIsnbZhho7ZQ=;
        b=hbvfSu+YY4j3Yg2V/EtMfcswpMpO7+8S9gohzFhzkGaR3lLfHB0HidTgrxP4x2dI5r
         7Ltn7m09nY4wjZ9N9ZU7LdcFGE8Al+aPGvh1PujxYdEfWYjSxE3xgiI7gByZ/p24Cgym
         xC2abzhjblgPsMLUJrbicfBoifwJ+c0VzuxaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AnIZlL+jkbLT2mHohgUbnH1ikveTHzcrIsnbZhho7ZQ=;
        b=mMJoxXeBn2fmpzI2/NFl/o7V+GPtFb+U2oYNNnR7v8QML92SrC9Sd4hAEmvY0d0vEd
         yQp2IDUwYNGHoTtp0lIU04HzWmffo/3BxZuJvtN0oyQSUL1e6jtH9wloy8MQQfOKR25M
         PTJQFsiyPiUywVgqnae6F1I9DrNeKSwWVCglpF1IZ/Qlafwg3iO/y+FYvw1TY111m1fW
         IiKsgYYbd1AMDD9QCuVGKt/4UYUXxDrJCfdf7VcdPYsyNZEf08TxQga7Cv25Tooe3T+x
         /5jEvaSZ11FpnEeLFv2zxZKXiJjaSEHVlnl9VrYoJ3nveaTYnawtNkd49O2YYBi3SHEq
         6kIw==
X-Gm-Message-State: APjAAAV11bGLTE++uqxl04RXU0rbuGBTLR3Elj2Gg5G5T/qKGvpvD6tN
        UgvbiYOZioytcchAkXpMhdIgWuCDQOo=
X-Google-Smtp-Source: APXvYqz/tYJVqIgR5mu0p5AizjEZ06yD1di2ylaRS0YTidajO7j1H4I/d2MDizNLzf4Go+LYea52Lw==
X-Received: by 2002:a2e:2d12:: with SMTP id t18mr57977096ljt.175.1564856537160;
        Sat, 03 Aug 2019 11:22:17 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id b17sm15880318ljf.34.2019.08.03.11.22.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 11:22:16 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id r9so75788039ljg.5
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 11:22:15 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr44522666ljg.52.1564856535717;
 Sat, 03 Aug 2019 11:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190803044926.WdcoA%akpm@linux-foundation.org>
 <CAHk-=wgS4D2fRCW7fDQqjL5Jm=j-3WUErK2PvTV522_mATrmEw@mail.gmail.com> <20190803102425.49d5810179e06590ab14c748@linux-foundation.org>
In-Reply-To: <20190803102425.49d5810179e06590ab14c748@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Aug 2019 11:21:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUHq7NGM6e7pCkMOaqKhzv9mqE8+JGJPbY=PPATV9mbA@mail.gmail.com>
Message-ID: <CAHk-=whUHq7NGM6e7pCkMOaqKhzv9mqE8+JGJPbY=PPATV9mbA@mail.gmail.com>
Subject: Re: [patch 16/17] memremap: move from kernel/ to mm/
To:     Andrew Morton <akpm@linux-foundation.org>,
        Junio Hamano C <gitster@pobox.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, anshuman.khandual@arm.com,
        Christoph Hellwig <hch@lst.de>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ Adding git people due to

On Sat, Aug 3, 2019 at 10:24 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Aside.  I guess renames are just a wee bit dangerous.  There's no
> guarantee that the file which you rename is exactly the same as the one
> which I renamed, which could result in breakage.  Such as, ummm, if
> some intervening patch had added a #include "foo.h".  Maybe the rename
> instructions should include a hash.

It turns out that renames that have changes _do_ include the object ID
for both sides, but exact renames do not. I guess that's technically a
deficiency in git.

A pure rename with no changes looks like this:

  diff --git a/kernel/memremap.c b/mm/memremap.c
  similarity index 100%
  rename from kernel/memremap.c
  rename to mm/memremap.c

so you see that it's a rename, but there's no way to actually see what
the *contents* at the point of the rename were.

In contrast, a rename with changes might look like this:

  diff --git a/.../intel,ixp4xx-queue-manager.yaml
b/.../intel,ixp4xx-ahb-queue-manager.yaml
  similarity index 95%
  rename from .../intel,ixp4xx-queue-manager.yaml
  rename to .../intel,ixp4xx-ahb-queue-manager.yaml
  index d2313b1d9405..0ea21a6f70b4 100644
  --- a/.../intel,ixp4xx-queue-manager.yaml
  +++ b/.../intel,ixp4xx-ahb-queue-manager.yaml
  @@ -2,7 +2,7 @@
   # Copyright 2019 Linaro Ltd.
   %YAML 1.2
   ---
  -$id: "http://devicetree.org/schemas/misc/intel-ixp4xx-ahb-queue-manager.yaml#"
  +$id: "http://devicetree.org/schemas/misc/intel,ixp4xx-ahb-queue-manager.yaml#"
   $schema: "http://devicetree.org/meta-schemas/core.yaml#"

   title: Intel IXP4xx AHB Queue Manager

so when the rename wasn't exact, we do show the index line so that you
can verify the exact content of the file as it was renamed.

Of course, I doubt your quilt scripts look at the index anyway, and
this is (I think) the first time this has come up as a potential
issue.

But you are correct that it would probably be a good idea to have an
index line for the identical file case too.

Adding Junio and the git list to the cc, in case anybody has ideas and
cares.. I don't think this is a big issue, this is more of a "let's cc
people so that they know it got mentioned".

>     But I can see that the present
> "rename it while ignoring other stuff which happened" is kinda neat.

It's very convenient indeed. That said, in an all-git environment, a
rename is basically never really treated as a patch, so when you do
*merges* with renames, it does take changes into account and give you
a "conflict".

Although generally it will then resolve those conflicts for you
automatically (and if the renaming side made no changes that will be
visible as the same object ID, the end result of the automatic merge
resolution is that the rename is just done with the change from the
other side in place).

Honestly, I very seldom see any issues with pure renames. The issues
we _do_ see is when somebody renames a file and then does a lot of
changes (often because they also then rename the variables in the file
because the rename was some bigger "coneptual" rename) and then any
conflicts with other changes can be very nasty indeed to sort out.

Plain "just move a file" situations tend to be very simple. Yes, it
_can_ cause subtle issues, but in practice it never really does. No
more than any other "two people change a file differently", at least.

The big advantage of renames in diffs is that it makes it _so_ much
easier for humans to see what is going on. It's almost impossible for
a human to see that it's a pure rename when you see multiple hundreds
of lines being deleted and added, while a rename patch is really easy
for humans to understand when they look at a patch like this.

             Linus
