Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B720C20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 07:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeLGHht (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 02:37:49 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:35446 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLGHht (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 02:37:49 -0500
Received: by mail-it1-f182.google.com with SMTP id p197so5755821itp.0
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 23:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgttvb/f9a6F5Z1kRSOY0RXNz8zTgs0sHn3kBzSnVjI=;
        b=KE5AdLmb+ia3o/EzqRTyPkiHatiG/m10qOKnUzwxwGW0slH3Qh/lJch9vKjm7949N+
         xjCckz+1TBT8jChZ1r4ZBHR2afGeFWLxD98jz2FkcExYRVjW5DMxoM6PIFXIJvddcJ6x
         YwWY4nBdF7+FLeK7r+84h36j9f0gLt8630wcvSOgNUrull+6JWFBI54MVpw0XQJLgVG3
         pFEeJDZr93npE8PagQ9jkr6i8vJ9weqGvvlfc84d1iRjqB+wCmTpPpj/0E1PazjUkqu2
         321TXMeaK6GpovcOg1FaKAOcwmvM/UJhWlCcP+vA6Fa8JQ7b+oVkFtFzs+HzMRPg0YB0
         cOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgttvb/f9a6F5Z1kRSOY0RXNz8zTgs0sHn3kBzSnVjI=;
        b=fOnjDu3GZf1z5dxJdET9dZYOEMeDJPJorr4HimGLehZ52QBCN1UZsWqZrHMJpgbMRZ
         xhQce3IDALB7uJDTpeVcuEv0dVogSruSHERehLxwaZnlnpx54H89zxB3qOJ1E1gN6Gbd
         9Qu/Cy5Pwl2kbRobmxMa5tpnvq6o0TXALlOToN60hvmrhVnw6eD9ua9iUeGWXuYibdT1
         mXPne9Fz8kjdv72ploXD/4Y2ShY0KNajEamPoGeJddqizs7t5IXhqmGM5t2CedLldxCc
         x6YfRrge6mz8MSCGCHLJrm38DHCQoaKOxdYSIdDJmud/i8psA5NkrxGlwBTSH2I3WUiM
         bxew==
X-Gm-Message-State: AA+aEWav59OLE/VqvhjB/IAuIsS5N3PdPb0+5SeSPI7cpSuchB59kyhr
        SC//VrhtVR0ywkEDAVflbs48NF4ZV7Kx/bHbNu6V8Jv+dR5HwA==
X-Google-Smtp-Source: AFSGD/XoH7Ch1lJ86eiAcgz6Vc1/Q/qefWZXmLE+obyuYSCCZ5ASd+IX3zrrlulKtC0cEvofbDnVQxKloD79xiP1XnU=
X-Received: by 2002:a24:5e05:: with SMTP id h5mr1284466itb.103.1544168268101;
 Thu, 06 Dec 2018 23:37:48 -0800 (PST)
MIME-Version: 1.0
References: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
 <CAGyf7-FUHMEq_FfPNrH6uT2b-nCd_wi=Aww+OUuoDem11DROGA@mail.gmail.com>
 <CADHAf1Y8or_frf=Ecu-82z-jo06NKe7oqo1cxtsZsOxhKKxjAw@mail.gmail.com> <20181207072004.GA32603@sigill.intra.peff.net>
In-Reply-To: <20181207072004.GA32603@sigill.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 6 Dec 2018 23:37:36 -0800
Message-ID: <CAGyf7-EkyGOi02fqMcCPBzj-=wpsH4zCgvP5VhOoKMdG+wfoLw@mail.gmail.com>
Subject: Re: Retrieving a file in git that was deleted and committed
To:     Jeff King <peff@peff.net>
Cc:     biswaranjan.nitrkl@gmail.com, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 6, 2018 at 11:26 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Dec 06, 2018 at 11:07:00PM -0800, biswaranjan panda wrote:
>
> > Thanks! Strangely git log --follow does work.
>
> I suspect it would work even without --follow. When you limit a log
> traversal with a pathspec, like:
>
>   git log foo
>
> that is not about following some continuous stream of content, but
> rather just applying that pathspec to the diff of each commit, and
> pruning ones where it did not change. So even if there are gaps where
> the file did not exist, we continue to apply the pathspec to the older
> commits.

Ah, of course. Thanks for the clarification, Jeff. And my apologies to
Biswaranjan Panda for the incorrect information.

>
> Tools like git-blame will _not_ work, though, as they really are trying
> to track the content as they walk back through history. And Once all of
> the content seems to appear from nowhere in your new commit, that seems
> like a dead end.
>
> In theory there could be some machine-readable annotation in the commit
> object (or in a note created after the fact) to say "even though 'foo'
> is a new file here, it came from $commit:foo".  And then git-blame could
> keep following the content there. But such a feature does not yet exist.
>
> -Peff
