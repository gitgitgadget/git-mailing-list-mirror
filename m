Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA301F461
	for <e@80x24.org>; Fri, 21 Jun 2019 13:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfFUNlo (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 09:41:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41377 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUNlo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 09:41:44 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so3085390ioc.8
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 06:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7qYx8a95tDxiBYqZQC5/6BGOX8W6/4Zkl5rcJHwB7rg=;
        b=hOUmHOOuNayMI3c1bW42UZaNQyZBPjM0daMCGz3T1Ti57Nw02IABQLpoRiGH0P8SFA
         XBZh73NQo0so91ci/hJWA9JXE09ry0U1hnthlPUoS3D6Ufadxj8vxfXCs+JdqDPYVbNl
         d1sBo2YhykXVHZwj2JH9XU4lxSVW+0lC7tzjcnNBSpHipboSyOHB6Pbb36jJEgA06XX4
         mkMk3QK/wldb/psOhFwPrb1HEaUldy3PTkaEXkSI9Y53dMoof9tiEYCmSrViubtxJwp+
         1o0FBiEC+6XJp88sZSBq2nF5yK3idB7CB8NQO/SlZiizRuu7oZkzoEJx2cZQozdQ3l+7
         wX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7qYx8a95tDxiBYqZQC5/6BGOX8W6/4Zkl5rcJHwB7rg=;
        b=iEYyEpk+9wgBHEuaRj+bLxTzIIanH6nDtBO9ZjJ10sgyOuDby5PjzgF+6QODsFJ3HH
         Sb+pVdxLoF3tqQBysKSPGU3dEq8sLjiBkMW5NpIhFTLVYlpLqgAgvynU56RfXqqznj9/
         MpLcnw0T5Lf0Cz82N4mhhPU+ry1HC2XTU5n4XjwlMrhNUPpuq/O6XfM07+ztsQfE3Yph
         yFlS/kCh6TeKixcADygpd30PZFDK7Cmtm5G1orB1bf/zDc6hRc/7HlHMFujvKYW432TD
         VOKWycbH0GSotZa2BC5jqCEOme417lJI5eLPpNn329U/jgvEWoeXAhal5YUHYf/l3Axt
         XaiQ==
X-Gm-Message-State: APjAAAVaE1/J+exqbH8emOg5wS6/QQIF+9tSpdXhqmwuDeOwe18OFqdW
        pFSGZxy+mzwdTVUxUxPnBevrzjiNhDx5Qk5s46B1WA==
X-Google-Smtp-Source: APXvYqwIk2EjHg2coAFQXTdNsz67d4m9dsuz9mkDunqRWpKGUmGJYOEkttMCAUv/YHK3iJ4PdcelIaNx/OjP3Fry/ag=
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr25983421jan.90.1561124503589;
 Fri, 21 Jun 2019 06:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190502144829.4394-1-matheus.bernardino@usp.br>
 <cover.1560898723.git.matheus.bernardino@usp.br> <xmqqef3om2nr.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef3om2nr.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 21 Jun 2019 10:41:32 -0300
Message-ID: <CAHd-oW5y0_2YVtKiMoSAy7f58Yj99baLsrnn=NrH_Fom+hRsVg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 00/10] clone: dir-iterator refactoring with tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 5:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > Daniel Ferreira (1):
> >   dir-iterator: add tests for dir-iterator API
> >
> > Matheus Tavares (8):
> >   clone: better handle symlinked files at .git/objects/
> >   dir-iterator: use warning_errno when possible
> >   dir-iterator: refactor state machine model
> >   dir-iterator: add flags parameter to dir_iterator_begin
> >   clone: copy hidden paths at local clone
> >   clone: extract function from copy_or_link_directory
> >   clone: use dir-iterator to avoid explicit dir traversal
> >   clone: replace strcmp by fspathcmp
> >
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
> >   clone: test for our behavior on odd objects/* content
> >
> >  Makefile                     |   1 +
> >  builtin/clone.c              |  75 +++++----
> >  dir-iterator.c               | 289 +++++++++++++++++++++--------------
> >  dir-iterator.h               |  60 ++++++--
> >  refs/files-backend.c         |  17 ++-
> >  t/helper/test-dir-iterator.c |  58 +++++++
> >  t/helper/test-tool.c         |   1 +
> >  t/helper/test-tool.h         |   1 +
> >  t/t0066-dir-iterator.sh      | 163 ++++++++++++++++++++
> >  t/t5604-clone-reference.sh   | 133 ++++++++++++++++
> >  10 files changed, 635 insertions(+), 163 deletions(-)
> >  create mode 100644 t/helper/test-dir-iterator.c
> >  create mode 100755 t/t0066-dir-iterator.sh
>
> A higher level question is what's the benefit of using dir-iterator
> API in the first place.  After subtracting 356 added lines to t/,
> it still adds 279 lines while removing only 163 lines, so it is not
> like "we have a perfect dir-iterator API that can be applied as-is
> but an older code that predates dir-iterator API was still using an
> old way, so let's make the latter use the former."
>

Yes, indeed the dir-iterator API didn't nicely fit in clone without
some tweaking. Yet I think most of those line additions were not only
to adjust the API, but also trying to improve both dir-iterator and
local clone (I should have maybe split those changes into other
patchsets, though). For example, these changes make local clone better
handle possible symlinks and hidden files at git dir. And the API
changes should make it easier to apply it as-is in other sections of
the codebase from now on.

As for the benefit of using the API here, I think it mainly resides in
the security it brings, avoiding recursive iteration (even though it
should be shallow in local clone) and more carefully handling
symlinks.
