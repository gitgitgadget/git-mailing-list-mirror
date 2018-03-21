Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7DB71F404
	for <e@80x24.org>; Wed, 21 Mar 2018 15:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeCUP7v (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 11:59:51 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:35570 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeCUP7u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 11:59:50 -0400
Received: by mail-ot0-f169.google.com with SMTP id r30-v6so6123862otr.2
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IPHTSJnHE+Sily3gsXurLeSn2kWVVlXc9ahU6CbTDqE=;
        b=Nw0oKOpHcmQoiOKGki7FnVIDrdYo+vs6rAoDvETYCj87YIz6hdaUvp0qcgiwbmGojv
         4cpyA9XEPg81VEd6ITLI4YtVNOnED9ERSxIdbgsduHeuVKLg6uZ12ic8nY/bsHZTQyuP
         h0bbXQGVGk0GDqUEdROMlDLanWYcEbViCi3cNcI9EjT/auHTwkX9JNRE3hYrGg/3+jbY
         Ko8YVIR/yYjX2yt+/NQ6blviQf5qJzV+F+N7iFiC8ERHV1ySss3P6LpabozCeYpF2jzN
         ldlyDBQoeub5JZ8i5t9BY1/ZG/MY2rqqBL+FYL+0aNdqU76f9xP8hG6tfFyFwA4Gz4Jd
         DYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IPHTSJnHE+Sily3gsXurLeSn2kWVVlXc9ahU6CbTDqE=;
        b=YCtUhAgt1Q3berGsYodzvNK/a51zOsESE+dn5+Tj7mge/+XdJPt3WAX49ZQ2CVcu96
         kLd3nBJzJAxEK1EYh7SQSde9vTgLESeGjaEQkAJXNz/ZdwM3e1H9Y4m1Pus8cRyEaiH5
         tFrY/LuXfNcxadUZqsAbZiyAxGO1arpcrYFcAPXvZ+PKdIdoCm8PPP4xOyAru/9cgNyh
         hPKFBkwONxZa+UL0wk10hx3oz4UNwrE6RJeIMUGZsDV8aQKiFhrO6cngS7DlNvzRVFQF
         EG9tWAYmYl1UdRD0QzsTBfwPQtHttfDwSEHEIhNVuJlDLIhB9lM4+OziJmz7c6TlFaGA
         pssw==
X-Gm-Message-State: AElRT7EQKlcV1xZrgzA8ZAvjg97S8U/Yh9R4HIeokyyV42h3oda4G6Vc
        ZfFLlZFKvDdsyJTYVKc7IxY+tGPJEQfDvOxkoas=
X-Google-Smtp-Source: AG47ELspmWhBdDM/ttGt7SdTtFDnVs24MCgUw+TZveEO7IYFjfA2dULPMCfpdRcaUFUz50EIDy9n6dO5I8WvGmda/00=
X-Received: by 2002:a9d:ec5:: with SMTP id 63-v6mr10805032otj.14.1521647990152;
 Wed, 21 Mar 2018 08:59:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Wed, 21 Mar 2018 08:59:19 -0700 (PDT)
In-Reply-To: <20180321082441.GB25537@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 21 Mar 2018 16:59:19 +0100
Message-ID: <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 9:24 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 18, 2018 at 03:25:15PM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> v6 fixes the one optimization that I just couldn't get right, fixes
>> two off-by-one error messages and a couple commit message update
>> (biggest change is in 11/11 to record some numbers from AEvar)
>
> I was traveling during some of the earlier rounds, so I finally got a
> chance to take a look at this.
>
> I hate to be a wet blanket, but am I the only one who is wondering
> whether the tradeoffs is worth it? 8% memory reduction doesn't seem
> mind-bogglingly good,

AEvar measured RSS. If we count objects[] array alone, the saving is
40% (136 bytes per entry down to 80). Some is probably eaten up by
mmap in rss.

> and I'm concerned about two things:
>
>   1. The resulting code is harder to read and reason about (things like
>      the DELTA() macros), and seems a lot more brittle (things like the
>      new size_valid checks).
>
>   2. There are lots of new limits. Some of these are probably fine
>      (e.g., the cacheable delta size), but things like the
>      number-of-packs limit don't have very good user-facing behavior.
>      Yes, having that many packs is insane, but that's going to be small
>      consolation to somebody whose automated maintenance program now
>      craps out at 16k packs, when it previously would have just worked
>      to fix the situation.
>
> Saving 8% is nice, but the number of objects in linux.git grew over 12%
> in the last year. So you've bought yourself 8 months before the problem
> is back. Is it worth making these changes that we'll have to deal with
> for many years to buy 8 months of memory savings?

Well, with 40% it buys us a couple more months. The object growth
affects rev-list --all too so the actual "good months" is probably not
super far from 8 months.

Is it worth saving? I don't know. I raised the readability point from
the very first patch and if people believe it makes it much harder to
read, then no it's not worth it.

While pack-objects is simple from the functionality point of view, it
has received lots of optimizations and to me is quite fragile.
Readability does count in this code. Fortunately it still looks quite
ok to me with this series applied (but then it's subjective)

About the 16k limit (and some other limits as well), I'm making these
patches with the assumption that large scale deployment probably will
go with custom builds anyway. Adjusting the limits back should be
quite easy while we can still provide reasonable defaults for most
people.

> I think ultimately to work on low-memory machines we'll need a
> fundamentally different approach that scales with the objects since the
> last pack, and not with the complete history.

Absolutely. Which is covered in a separate "gc --auto" series. Some
memory reduction here may be still nice to have though. Even on beefy
machine, memory can still be reused somewhere other than wasted in
unused bits.
--=20
Duy
