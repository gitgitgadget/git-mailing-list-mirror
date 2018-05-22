Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7871C1F51C
	for <e@80x24.org>; Tue, 22 May 2018 18:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeEVSEX (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 14:04:23 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:42117 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeEVSEW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 14:04:22 -0400
Received: by mail-yw0-f196.google.com with SMTP id q7-v6so5828632ywd.9
        for <git@vger.kernel.org>; Tue, 22 May 2018 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vOulIJv42PQaYcnVSK3eLsdbfZDcxE7y0py0Rhl8z10=;
        b=DBjugXuNtz10Ktxqom3+Bss/H/kRphV7ZOr83e8jHo0rqn1XXl1AlidRJOVLVTl79o
         aEzxs0DwoWmgOXMyRnLWDWb1tJuZco3eyZGRdWE7BSW+K4Rge6gaQz01VCT+Nhbgzitj
         5BsUEx2vNWwVmVxY4Jv9TzMLX4VMmVc3Pi87Bmc2K+evMo/Igj/tsK4VlrvsI5GyDt+e
         BtjtG2WCPFwppkPiEOiOKexllpnQMKkZBX4JarvCL+EPKUPelPxyBYcBRoNMyoNH9fPV
         ZUlsFl6CAJtfuEhzSm+i/c4lcg4lGHZO2AWr0Kw1HUeffeIN4r9QEM/uPGF7B761jp/B
         TV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vOulIJv42PQaYcnVSK3eLsdbfZDcxE7y0py0Rhl8z10=;
        b=HYN7ej7DfFJ01zVz/+ogAwb1GD2L1Gmr6AVdJmc5KjV+ZNTlcMyfqLT1jmslDl+xwD
         KN74sjSn2pqdGL9d8IXmu+uvOyitRiNySUyydA13dNJII3T+R3qmTJiUmaTOozs9qoyt
         Nc/ybbl/TSRR10JI8RRjgcnRJKjCnA2gatz8LQeutl7k2/SON7NPhjtnigz/pGwmnkTE
         KZpxaUkudcYs4+cfFRQjzkw3VuK68XQR0pywNFENRLnTXgUXf1mP8jPnlda1CBPP1iV5
         I4jwXztIU4XHdepVnLZcyaeWSXzVDwWsVsinsOZDrJAx396zIdSeIDfz4yn9weuba9sX
         UoEA==
X-Gm-Message-State: ALKqPwdJ5FRUo7qRfYxPVLDz1vtjzCKQAPLEBi4e7KCMTL8KnCfO2Lig
        zTx1NYLnWiTTPCiMroSurNRuDpKWtSr/h9JazHPkEw==
X-Google-Smtp-Source: AB8JxZoiMDyqGiGkXnPTh2/BtU85RSdm9t+EKPLAECie/pYPUr7KsN2DH1+TImyk++m6Jv/hy0NloFdB7aYjRPsQLBo=
X-Received: by 2002:a0d:e28e:: with SMTP id l136-v6mr12817750ywe.500.1527012261390;
 Tue, 22 May 2018 11:04:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Tue, 22 May 2018 11:04:20 -0700 (PDT)
In-Reply-To: <874liz8tsi.fsf@evledraar.gmail.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com> <20180516222118.233868-3-sbeller@google.com>
 <874liz8tsi.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 May 2018 11:04:20 -0700
Message-ID: <CAGZ79kZs7aNXB2cn8p+m5gUOAv0OqhPW6b23y4cbm9d3Njwn=A@mail.gmail.com>
Subject: Re: Why do we have both x*() and *_or_die() for "do or die"?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Antonio Ospite <ao2@ao2.it>,
        Brandon Williams <bmwill@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 22, 2018 at 10:49 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, May 16 2018, Stefan Beller wrote:
>
>> A common pattern with the repo_read_index function is to die if the retu=
rn
>> of repo_read_index is negative.  Move this pattern into a function.

This was done organically, i.e. taking the smallest available step that yie=
lds
a better code base. There was definitely no stepping back or looking at the
big picture involved.

> Just a side-question unrelated to this patch per-se, why do we have both
> x*() and *_or_die() functions in the codebase?

Digging into the history, the x*() emerges from 112db553b0d (Shrink the
git binary a bit by avoiding unnecessary inline functions, 2008-06-22) and
is wrapping common patterns to reduce the size of the binary.

The or_die pattern comes from 7230e6d042a (Add write_or_die(),
a helper function, 2006-08-21). This was motivated as better code
("making additional error handling unnecessary", "replace two similar ones"=
)

None of them really hint at the _die() as a problem in the
libification efforts which came later IIUC.

> I can't find any pattern
> for one or the other, e.g. we have both xopen() and then write_or_die(),

hah! Up to now I assumed the x* is system calls with write_or_die as an
exception. There is also a xwrite and write_in_full, so they are slightly
different in the way that xwrite covers only the system call and copes
with some common error patterns, whereas write_or_die uses write_in_full
which itself uses xwrite.

> so it's not a matter of x*() just being for syscalls and *_or_die()
> being for our own functions (also as e.g. strbuf uses x*(), not
> *_or_die()).

I would tend to argue that way: x* are strictly to system calls (no die()
in there), and the _die() functions are "hands off *no* error handling
needed"

> I'm not trying to litigate the difference and understand it could have
> just emerged organically. I'm just wondering if that's the full story or
> if one is preferred, or we prefer one or the other in some
> circumstances.

I think we'd prefer the x() for lib code and the _or_die code in builtin/
due to the nature of effort needed to get it right.

Thanks,
Stefan
