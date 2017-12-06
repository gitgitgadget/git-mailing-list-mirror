Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA2F20C11
	for <e@80x24.org>; Wed,  6 Dec 2017 19:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbdLFTBh (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 14:01:37 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:36057 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbdLFTBg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 14:01:36 -0500
Received: by mail-it0-f53.google.com with SMTP id d16so8686987itj.1
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 11:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yJBPaFCdWJqMQ4r6mkRA1LXM9+Nv+Eyy8jSqVMoNyfY=;
        b=MgKM1XoB04BAwkJIJVEz9Eo5qXkP/GAvaSCFigX8IE8TeYlf0As/QN24OrLr/Ro4cq
         uS28qHB4bTY8NjpjdJpx5Lq149KzbV7Mkx9Yz+TC41do7XajQIwxct6h1xz54iMqIHec
         17nERiENCF0g3QMhJBn6iuzkhqQpr53mtIOal8THxckLUAMn8pJ9Ohowx/5bSk0FjxRW
         WpQUPTjE8JrNExZneRySZg4NKyMfYF+PfDBBRmgn+jbyoaeOphqOX13A5c9yDEjJAN3e
         UfK3ayXqRubV3vapqVRFF+lt6tHWBCtUIKatQfWIgEYRbbjSdLRCyIZ5+l9glsDd7wEb
         WeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yJBPaFCdWJqMQ4r6mkRA1LXM9+Nv+Eyy8jSqVMoNyfY=;
        b=keb7QoUjOqNBmqlog999b1PXhrjBayvlIfiblkK3DLq1CSWbqH2blJhlKKS5BfuE4L
         mwZUBvmNH+ynwsRnEI9nNp5x5FJVx1CFzLsVaB5/vBIbCGCsXSKsScIAA8v1i0Q90T1z
         GCS83IeWQOZYK4/eKVymotxv59Cz+5JLUPHTdsX78RboCrUS5CbLFXzii24va2wNalRs
         tBbdkiBGBIwoSdiuGEOWjCnP7G396kOn6jpMRcuBzb1ODijrt7cSCzX6sxymUvh5Ie4g
         UJKM6HhbWc5jKNDOhZzilXHGoNLTfS9uHZUbgi/dRlNxmUMqiUZB8juBWVH5dhG/Wx3C
         Y6xw==
X-Gm-Message-State: AJaThX5oCimHUTrwkysV0tSHG1mh3xsSuATRZdOEXxZwWh2qI0YsSxDK
        0Ztzojd9WYVeS43yMLVJas/OJtDm1qVVkRNulgU=
X-Google-Smtp-Source: AGs4zMYRvq5RFF/GD7Y1eUzwELIQ1CAS8EIdH74YZXqqGkzmsKS14Is9tYs26hZ6doVc7leen1zqr77bok0UuACmfC8=
X-Received: by 10.107.6.81 with SMTP id 78mr34547875iog.204.1512586895693;
 Wed, 06 Dec 2017 11:01:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.19.167 with HTTP; Wed, 6 Dec 2017 11:01:14 -0800 (PST)
In-Reply-To: <CAD1RUU8BO7J=rV6XgLZ0xN-ikLsanwqHVBnRE9468xVE5EEMvA@mail.gmail.com>
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
 <20171205212625.6616-1-dnj@google.com> <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
 <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org> <xmqqd13rhewu.fsf@gitster.mtv.corp.google.com>
 <CAD1RUU8BO7J=rV6XgLZ0xN-ikLsanwqHVBnRE9468xVE5EEMvA@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 6 Dec 2017 20:01:14 +0100
Message-ID: <CACBZZX4JKhprF-3L3===XOBJ3Gp7W2xbeJshZFAmnjwevs0JoQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
To:     Daniel Jacques <dnj@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 7:56 PM, Daniel Jacques <dnj@google.com> wrote:
> On Wed, Dec 6, 2017 at 1:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>> > The updated series works for me now. Nevertheless, I suggest to squash
>> > in the following change to protect against IFS and globbing characters in
>> > $INSTLIBDIR.
>>
>> Yeah, that is very sensible.
>>
>> > diff --git a/Makefile b/Makefile
>> > index 7ac4458f11..08c78a1a63 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -2072,7 +2072,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak Makefile
>> >       INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>> >       INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
>> >       sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
>> > -         -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
>> > +         -e 's=@@INSTLIBDIR@@='"$$INSTLIBDIR"'=g' \
>> >           -e 's=@@GITEXECDIR@@=$(gitexecdir_relative_SQ)=g' \
>> >           -e 's=@@PERLLIBDIR@@=$(perllibdir_relative_SQ)=g' \
>> >           $< >$@+ && \
>
> Sounds good; I'll apply that to my working patch and include it in my
> next ("v5") submission, which is currently blocked pending avarab@'s Perl
> Makefile changes:
> https://public-inbox.org/git/20171129195430.10069-1-avarab@gmail.com/T/#t

Thanks, FWIW I'll send another version of that at the end of the week
or so, I'm waiting to see if there's any more comments on it to reduce
list churn.
