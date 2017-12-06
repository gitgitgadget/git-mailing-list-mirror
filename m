Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0B3E20C11
	for <e@80x24.org>; Wed,  6 Dec 2017 18:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbdLFS4t (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 13:56:49 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:37431 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbdLFS4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 13:56:49 -0500
Received: by mail-oi0-f44.google.com with SMTP id y75so3252386oie.4
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 10:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HUhRKeAeibn+UyDGcQ4TKckTGubl0yYBKWcGf/oD8TU=;
        b=QuuU35AOTors3PEfXvG8JFubLW1uKFZPgI2luQxc8JSB2numrqa9nQdTvyaCDY/IKa
         w63TfHYk8/1DV+lnRWG+juZveIR3sa2SqI0DcvTyIDU0CA3wGtbT6ezGwGc+igSiOTEp
         x+Sey3hxx8Z4NCUKoshPyMcbwrhoq52BHNt90IJHwS259LXR0ZpTWwgOaR8P9mDB3OKX
         UA7FyRoQGNrxxgOPltg+AxGpKp4CPVbmQplr06cxaoxIaoeajRt3bsFhxVABsK3kZMmJ
         JzXIhyAKpuhjUKOybkXsjQY/QU6ogVfg6EhHrUtcmuNIpZqyvu4eTjfrVUMmlPXXMooK
         Sdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HUhRKeAeibn+UyDGcQ4TKckTGubl0yYBKWcGf/oD8TU=;
        b=DBt/6uouu125/bWqgAR/Ktdb0z0P1BsR//ClJZt2QKNuB6wVwdkZpIfNqQ3WpZa9VF
         QwrOknVgdq56YkvdLTLhIqWbXJKh6uohzgt3eRsYhh4xekw1Zsl2pNAdKCc0XQ/xBOVE
         QLAL6YmsgEYKQzL/NQcisQt8gk97S/UXcCqZrep9/wVYEIYLcN3yLe5PVC+o4hRxrDTn
         gA9vVgUr+WEPnV0AAANvgJBdgqQozqcjW9bSA3sfDV4g9xPPg9mIkYzYhXNp1ZvcUdIg
         +lQvCiYfSmcI4D+ghFPbg5gUfWnaSeiXdKfi+4WvgrCX0Q7M7VDCpqXsqq8MsQogtSUG
         XCLA==
X-Gm-Message-State: AJaThX4fXjyHiOlsnzG0niMQwqPNxE7mAMv58E0dCHLYUndxIiYYEisA
        YnFyl5SMaZfjoW1kH5N3hTKfQseb/bpfs7pDYZXq6Q==
X-Google-Smtp-Source: AGs4zMZGvHjFp3+QO+ZvrM6vM79VoR0EkLs71Kp97nce8fx5/QEcqomYZ20yAB+TkUb6GCsdXaei7bEocLA2Csn+3h0=
X-Received: by 10.202.69.137 with SMTP id s131mr21425126oia.325.1512586608053;
 Wed, 06 Dec 2017 10:56:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.56.113 with HTTP; Wed, 6 Dec 2017 10:56:27 -0800 (PST)
In-Reply-To: <xmqqd13rhewu.fsf@gitster.mtv.corp.google.com>
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
 <20171205212625.6616-1-dnj@google.com> <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
 <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org> <xmqqd13rhewu.fsf@gitster.mtv.corp.google.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Wed, 6 Dec 2017 13:56:27 -0500
Message-ID: <CAD1RUU8BO7J=rV6XgLZ0xN-ikLsanwqHVBnRE9468xVE5EEMvA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 1:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > The updated series works for me now. Nevertheless, I suggest to squash
> > in the following change to protect against IFS and globbing characters in
> > $INSTLIBDIR.
>
> Yeah, that is very sensible.
>
> > diff --git a/Makefile b/Makefile
> > index 7ac4458f11..08c78a1a63 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2072,7 +2072,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak Makefile
> >       INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
> >       INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
> >       sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
> > -         -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
> > +         -e 's=@@INSTLIBDIR@@='"$$INSTLIBDIR"'=g' \
> >           -e 's=@@GITEXECDIR@@=$(gitexecdir_relative_SQ)=g' \
> >           -e 's=@@PERLLIBDIR@@=$(perllibdir_relative_SQ)=g' \
> >           $< >$@+ && \

Sounds good; I'll apply that to my working patch and include it in my
next ("v5") submission, which is currently blocked pending avarab@'s Perl
Makefile changes:
https://public-inbox.org/git/20171129195430.10069-1-avarab@gmail.com/T/#t
