Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E1E1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 18:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfKKShR (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 13:37:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45756 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbfKKShR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 13:37:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id w11so9936358pga.12
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 10:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0yxrybcNRJvIaxgw+gxHl5NDm21FlcNz8z43rqJBknk=;
        b=tfvgRbvYq81KRf73RtukrxPMOvIjz9xe61XADWeX7tsAOphfEjk1kfzbwEw0X9FaEp
         Iw3wqPGvgbhLDxd1VDppTM8e8v2cnbA2bGCGWPjydV19rnBAjmCY2KYruvebxqkd66Rw
         lEdemdRNdGaVEi9AoNnCh5XxYSjg2ZqtGmUCAIw794haOcYj5yxlTV7ovEKbPVbajfaJ
         0NblfCjNSB8suyr6sc8zIlEu2pTnDXai8JSeqPv8yqTHY1iCwZy2IYFUQeZkZEPuAuFU
         ePxLuflalrIbR4iCir14uHEMDH0uFJcMTqHJ8gDsYfToC3b0rcaaUVuu9wsEPd6niz8p
         bi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0yxrybcNRJvIaxgw+gxHl5NDm21FlcNz8z43rqJBknk=;
        b=hwReyAIA2qNDojnc6qtHY3NX9TuWIDrWRE28vcliDrtQP9usQI4fUxipdIm+l/aKCc
         PaeQOjMsR69hvLWCMCBquoJHkvLECXvvoqv0Lr51cMjvYhJIsI6C5JMM0aHfAQ5ol802
         V97wIXvDEpiurp0C+BEuTpgqHTVoF/tgeBdIOGAG3IEHapjFsW9gReaoRADT5EllMuM3
         dF5yMLV9cSeo2LpYiWqCsFXjpBQ3mw06lguZMVlBUikSYRo1VAExvY8ESWxTxTKfRuwV
         hpWfQSpe4arQg9XJ9xKhoODGhV6wYba8zCaGSrMDShJm0WWs30z+7ADP4OvffyimU8FR
         ekPQ==
X-Gm-Message-State: APjAAAW/F+YsCEchwHXbxa1lKktPcvUFyAToAEs9Mk3dYPQ3M8ac06Fs
        5Jr3FD7k14zB9nBVZPH/R4a9SGZHmBPWhLHxj1M=
X-Google-Smtp-Source: APXvYqxH2Hq7EKIrRGW26jGWUVTI4tijUgslxtv7tjcilnvBC5bOreMX3nvXGF6lN6jWb+W8LfPvOqssSHq1ipOvfXk=
X-Received: by 2002:aa7:9314:: with SMTP id 20mr30671082pfj.231.1573497435536;
 Mon, 11 Nov 2019 10:37:15 -0800 (PST)
MIME-Version: 1.0
References: <CAE0unxyojHVWP4aM3C+DdMYORmcoCuq-0wwLGjE8ok6dLj_E8w@mail.gmail.com>
 <xmqqpni0jioq.fsf@gitster-ct.c.googlers.com> <xmqqtv7bi22j.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtv7bi22j.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?R=C3=A9da_Housni_Alaoui?= <reda.housnialaoui@gmail.com>
Date:   Mon, 11 Nov 2019 19:37:04 +0100
Message-ID: <CAE0unxzP07XsF7e3ZPZacBaotkzocc1mr6_2HyDfGT6s8VJaMg@mail.gmail.com>
Subject: Re: Sometimes unable to lock the index during pre-commit hook
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?R=C3=A9da_Housni_Alaoui?= <reda.housnialaoui@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thanks again for your answers.

I kept looking at the code and found out that the index path
(temporary or not) is passed as an environment variable named
GIT_INDEX_FILE to pre-commit hooks
(https://github.com/git/git/blob/v2.24.0/builtin/commit.c#L1472).
Making jGit lock/alter the file pointed by GIT_INDEX_FILE (instead of
always locking .git/index) work with or without git commit 'all'
option.

I guess this is the workflow that the GIT team imagined to allow
pre-commit hooks to alter the index.

Thanks a lot !

Le lun. 11 nov. 2019 =C3=A0 03:23, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > R=C3=A9da Housni Alaoui <reda.housnialaoui@gmail.com> writes:
> >
> >> Are pre-commit hooks expected to be able to manipulate the index?
> >
> > Hooks are described in githooks(5) manual pages; we may want to
> > clarify what is not allowed, but back when most of the entries were
> > written, the stance was that anything that is not explicitly allowed
> > there is forbidden.
> >
> > In general, a pre-<something> hook is a way to inspect (i.e. look
> > but not touch) what is proposed to be done and veto it by exiting
> > with non-zero.  It is not expected to change the state of the
> > repository in any way.
> >
> > The code does not necessarily enforce it, because it is costly to
> > take a snapshot of everything (including the index, the working tree
> > files, the files that are untracked, the objects in the object
> > database, etc.) before calling a hook and ensure that the hook did
> > not touch anything.
>
> Actually, we do accomodate for the possibility that pre-commit hook
> may muck with the on-disk index there days, even though the original
> design intention was not to allow random changes there (see ll 960-
> in the same file).
>
> So it seems that if we hold the lock necessary to refresh the index
> for too long, it may be an option to move the code that unlocks to
> somewhere earlier in the callchain.  prepare_index() however returns
> different on-disk index file (the real thing when making an as-is
> commit, and a temporary one otherwise), and the unlocking rule may
> be different, so some restructuring of the code might become
> necessary before that can be done.  I dunno.
