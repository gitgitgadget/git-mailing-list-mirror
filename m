Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C1E1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 03:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfBUDsN (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 22:48:13 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55081 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfBUDsN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 22:48:13 -0500
Received: by mail-it1-f194.google.com with SMTP id f10so20438412ita.4
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 19:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OXbSSRi9DE+E0x6ApYB1okBHRcoOUgpoqX3ZcfQDkbo=;
        b=BcWu1QIIV5u0Ggzg13vM+jhikXdsq6faO438n/vBDHhVNDH/6mFZ5QKl2Mza3aKHIU
         lH4KE2kRw5hmMYsdt07ooQj6vEkg7ge6IZsyhh7waAjEeXhVvqtr5f/TsMOXNDNF2cTr
         F2UmCwJHWAt66S2VHgJg02H34ZJZmop/3LixkAktb2QHYuU2Hg6tHIBiQMRoZF0m+rzj
         PQUfNBhB/E/ULllDr1b5grZ7K+V76K7iYehX5whlwde43Xi/CwhnVo+z4gjUgbqWSnkG
         A5FfTHawQFAms3nkOEhNu3qMQFYkMX7MyGb5ThGdlwvwbwKtmh2Bh7++ZaBlKO+VRAto
         YGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=OXbSSRi9DE+E0x6ApYB1okBHRcoOUgpoqX3ZcfQDkbo=;
        b=AYsUFmWWpD+j/T2g5ePRbHDXwpoUcY/vF3G3WseIrkfZ+Uk+O1f23aiA+PCrN5TdLf
         4dQ9XGgRbwDJIWlnLQl/HekQKtJWoxbled7oTnj76o+F3eBDjZCoY/RIq7swQuh6fiQd
         3YZcd9JXHEuzuP9ieVCft2hA+y+5MQBqtOO0XM3gcIYLLZcF3yxCmyQkyEukHI3pgtuZ
         19jPzTR0a+t4zaRTqJVRI3ol73/8rERh6QfRXDti87T/fMMMY3MS+yCTuWeIBSQrWGpo
         fBz6igVp2SoS3bg2NcxXId+RqtaxuzM/W0Sj88yM1pXJg3EATjGMDf+VmoYEck+KTpsH
         zbxQ==
X-Gm-Message-State: AHQUAuY0Ldq+Z+1sWehI9vWZvzpV67pHJ/5ojXJjp5W5TEzawFJRRF8F
        npEq17EFDurr5oIiTh2W2O/9Qmx0ey2dtfN/Pkg=
X-Google-Smtp-Source: AHgI3IYsL9cgXXZUfdyTEwZlqhroIFId3VbfpcgOmJfL1D3Lzi9blE1TMQ11X+/u3dgdhfKk+iTfiywwbnfRpHMxYCk=
X-Received: by 2002:a02:568a:: with SMTP id u10mr21071317jad.130.1550720891912;
 Wed, 20 Feb 2019 19:48:11 -0800 (PST)
MIME-Version: 1.0
References: <CABUeae_N3NFXn-E1+LHORL3RDf5iTCFn=zyuOo3c2Aot2QF7pg@mail.gmail.com>
 <20190221021825.GB488342@genre.crustytoothpaste.net>
In-Reply-To: <20190221021825.GB488342@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 21 Feb 2019 10:47:45 +0700
Message-ID: <CACsJy8BKhroHhVWCj5fvwxk2z4XsdSK_pSQ=o8hxZcZsAn3R-w@mail.gmail.com>
Subject: Re: "Submodule registered for path" output with config aliases mixed in
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mateusz Loskot <mateusz@loskot.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 9:19 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Tue, Feb 19, 2019 at 05:51:05PM +0100, Mateusz Loskot wrote:
> > Hi,
> >
> > $ git version
> > git version 2.20.1.windows.1
> >
> > I'm running `git clone --recurse-submodules https://XXX`
> > The command seems to run well and completes with success.
> >
> > However, I noticed strange output from git:
> >
> > ```
> > Submodule 'Binary/A' (https://XXX) registered for path '!f() {
> > ~/AppData/Local/Fork/Fork.exe $PWD; }; fBinary/A'
> > Submodule 'Binary/B' (https://XXX) registered for path '=C3=80   =E2=99=
=82=E2=99=A6Binary/Intergraph'
> > Submodule 'Binary/C' (https://XXX) registered for path '!sh -c 'git
> > log $1@{1}..$1@{0} $@'Binary/C'
> > Submodule 'Binary/D' (https://XXX) registered for path 'ls-files -o -i
> > --exclude-standardBinary/D'
> > Submodule 'Binary/E' (https://XXX) registered for path
> > 'mergetool.TortoiseGitMerge.trustexitcodeBinary/E'
> > ```
> >
> > I managed to identify where that garbage injections come from:
> > from git aliases I've got configured [1]
> >
> > Could anyone explain what is happening here?
> > Is there anything wrong with my ~/.gitconfig [1] ?
>
> I see the right behavior on my system (Debian amd64/sid) with
> 2.21.0.rc0.258.g878e2cd30e and with master. I've built with ASan and
> don't see any memory warnings on my system.

I ran valgrind yesterday (gentoo amd64) and didn't find the problem
either even though it clearly looked like some dangling pointers. I
also audited this code and couldn't find anything obviously wrong. My
only suspicion is maybe some strange getenv() behavior on Windows
(_if_ the super prefix is used, but I can't see how...) and that's
just a dead end for me.
--=20
Duy
