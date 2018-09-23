Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315CF1F453
	for <e@80x24.org>; Sun, 23 Sep 2018 19:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeIXByN convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 23 Sep 2018 21:54:13 -0400
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21808 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIXByN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 21:54:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1537732531; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=huRoLlCVg3jpVqVnKZI/NznNto7LYXZCj8Pg5GU01FR9DMSddWQih9SzvJVR9XBRLNBGM0qxZPBCb9FyGLC1O6ViDtabKdlhK6I9IcReE+KonEkP1DwHfWp8GZCyvnpx+SQDIo1BxoJRfP9RQh+ZLyhLNNt/f9FMjWk+duZNKKY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1537732531; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=8h9fmsspLgCWLFG/YjfvYdt92bHssKOCx2iZKmnPH+Y=; 
        b=WCbozQPNK8jqABw5UbjOsYSKiRl8y2TDi0D1yKxMeuH6aKaniDEznzFvXQr1rqNd/qL6TloANdTyFh5+u0Qwx9RqDaLstmCKQKEBKuM/QJtFdmShME/mCIjl/rT7F7TU3m9geG04p2+rDs04OVKC9pttR9yiQQrbX/CU4ny6R94=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=astrangergravity.com;
        spf=pass  smtp.mailfrom=john@astrangergravity.com;
        dmarc=pass header.from=<john@astrangergravity.com> header.from=<john@astrangergravity.com>
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41]) by mx.zohomail.com
        with SMTPS id 1537732528873384.27917249487314; Sun, 23 Sep 2018 12:55:28 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id w21-v6so945686lff.6
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 12:55:28 -0700 (PDT)
X-Gm-Message-State: APzg51Bo1Z6b2/nbpAP8qEBCOOnzrlyw203ZorGTQztcKflaGa1IxG7M
        4jSf1+j0fBsKd7NIdhEl5+Owpk/m0C35j3akz3s=
X-Google-Smtp-Source: ANB0Vdam/EuV9k2DnTIpIr80KLtyJyZYQp5DpPFP6vFmAm5tmtg3kXXS4sPXvzd6TZypcQ/d/WPTjQpBLu3YaVQ8m3k=
X-Received: by 2002:a19:6381:: with SMTP id v1-v6mr4366207lfi.136.1537732527042;
 Sun, 23 Sep 2018 12:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <20180914190025.GJ55140@syl> <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
 <20180915164052.GA88932@syl> <878t41lcfi.fsf@evledraar.gmail.com>
 <20180917135525.GF71477@syl> <874leokw3p.fsf@evledraar.gmail.com>
 <20180917164705.GA28056@kitenet.net> <8736u8kpgu.fsf@evledraar.gmail.com>
 <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com>
 <000501d45366$cf437060$6dca5120$@nexbridge.com> <CA+AhR6c+D84sHhABRm4xf=5RWnpVEBXMXzdQxipYMS5bmkw9iQ@mail.gmail.com>
In-Reply-To: <CA+AhR6c+D84sHhABRm4xf=5RWnpVEBXMXzdQxipYMS5bmkw9iQ@mail.gmail.com>
From:   John Austin <john@astrangergravity.com>
Date:   Sun, 23 Sep 2018 12:55:00 -0700
X-Gmail-Original-Message-ID: <CA+AhR6cRZUKL9USL3=RR0xJvntLrsh_NMAZofwT9N0jzRuutsw@mail.gmail.com>
Message-ID: <CA+AhR6cRZUKL9USL3=RR0xJvntLrsh_NMAZofwT9N0jzRuutsw@mail.gmail.com>
Subject: Re: Git for games working group
To:     Randall Becker <rsbecker@nexbridge.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        id@joeyh.name, Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        pastelmobilesuit@github.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Regarding integration into LFS, I'd like to build the library in such
a way that it would easy to bundle with LFS (so they could share the
same git hooks), but also make it flexible enough to work for other
workflows.
On Sun, Sep 23, 2018 at 12:53 PM John Austin <john@astrangergravity.com> wrote:
>
> On Sun, Sep 23, 2018 at 10:57 AM Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> >  I would even like to help with your effort and have non-unixy platforms I'd like to do this on.
> > Having this separate from git LFS is an even better idea IMO, and I would suggest implementing this using the same set of build tools that git uses so that it is broadly portable, unlike git LFS. Glad to help there too.
>
> Great to hear -- once the code is in a bit better shape I can open it
> up on github. Cross platform is definitely one of my focuses. I'm
> currently implementing in Rust because it targets the same space as C
> and has great, near trivial, cross-platform support. What sorts of
> platforms are you interested in? Windows is my first target because
> that's where many game developers live.
>
> > I would suggest that a higher-level grouping mechanism of resource groups might be helpful - as in "In need this directory" rather than "I need this file". Better still, I could see "I need all objects in this commit-ish", which would allow a revert operation to succeed or fail atomically while adhering to a lock requirement.
> > One bit that traditional lock-brokering systems implement involve forcing security attribute changes - so an unlocked file is stored as chmod a-w to prevent accidental modification of lockables, when changing that to chmod ?+w when a lock is acquired. It's not perfect, but does catch a lot of errors.
>
> Agreed -- I think this is all up to how the query endpoint and client
> is designed. A couple of different types of clients could be
> implemented, depending on the policies you want in place. One could
> have strict security that stored unlocked files with a-w, as
> mentioned. Another could be a weaker client, and simply warn
> developers when their current branch is in conflict.

