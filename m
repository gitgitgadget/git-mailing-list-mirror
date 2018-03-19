Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83E91F404
	for <e@80x24.org>; Mon, 19 Mar 2018 22:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934410AbeCSWHS (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 18:07:18 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:44257 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934215AbeCSWHN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 18:07:13 -0400
Received: by mail-ot0-f170.google.com with SMTP id 79-v6so19011883oth.11
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a8SCIfHS3kEQTaoD0aMgXld8sqaevhjVLBFmUkCPFV8=;
        b=NWHsxwQ9/vWxyoPuP/o6dvi3fDt0NvTb8y+Vmqg4bRGg0FmMOGq2secCRmY4uFnG7a
         kKHxd7SgAODVdcHwz1lFiae3zr0xj0+y7Wqak6t2snu/jsRT6WeHl87Ay7d0iwmlD2vx
         veziLn3p+s4iTiKTt5OcR3WDSNCS+YTInWXMRlPkNMAnqdGZW7My9VBeY+rvc4xSFGYe
         Cx5ORiiIqjNbQxMnNhKEkKLz+gbAviHKzMY7mbLVdo7rvseDsjx0dyKKn/Vmbc9l0N99
         KKRl9xv3F8p7sLuvYQ7NUPOZjJzufmMtHtxf2BoGRnE1GiBiu5CfzC/8krLogcEGT9Ih
         q5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a8SCIfHS3kEQTaoD0aMgXld8sqaevhjVLBFmUkCPFV8=;
        b=LhA1wsFUVw870zl+hyTFiINydTJOTuuzgUNi7qTx2exrDrvKJern6Vis6gK5w3qYA2
         Snd8PrLZptSV9VQarXNBYeH/FVd5+YGVMMjphB+2O/ZxgjbDxH3u8bvN/Yo+wCRoowlY
         5RXHIMKok7dyrN/pPwp+1snWopQIcZGq4qJDHtHui12lsQxMtjy3NKoR5cNhSBbt2Ib0
         YdWtLqN8ma5i0ZDSgxe4kVTvPtCP3O1AjSAW0UZ3by+FwCFYMwfI14d/BQb47rdvlCJE
         8BHHRGFt6J8ZEKaQuSPouXtWlZgFqKMPSRLfh47fasFz8oSQ1spNCAjXt8DO+QgA82//
         1ozA==
X-Gm-Message-State: AElRT7F+1ruxHQVVEkbuk0/Q0hKDYrvUpzJmja9VAcmqwOOXxI9aXCoR
        w89JRIv95+uvxCTEniBAcnKyD0uuHjYDIvjhucrIuQ==
X-Google-Smtp-Source: AG47ELtzpwK85p4QQCxMTrlll2Ez/UZTWS787yUtvF2c2tUypO+iDF1lf1K+zTkgT/xxGpvG0VQ1nVydyo5bsh/FYN4=
X-Received: by 2002:a9d:37e6:: with SMTP id x93-v6mr9350541otb.256.1521497232810;
 Mon, 19 Mar 2018 15:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180319025046.58052-1-dnj@google.com> <20180319025046.58052-3-dnj@google.com>
 <CAN0heSpu4Lv9P+zzKPgJe3nx+J20Yex9is8SCztKobLc5ZfWCA@mail.gmail.com>
In-Reply-To: <CAN0heSpu4Lv9P+zzKPgJe3nx+J20Yex9is8SCztKobLc5ZfWCA@mail.gmail.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Mon, 19 Mar 2018 22:07:02 +0000
Message-ID: <CAD1RUU-emF0n2Qwvs_A4GqZ=CVZmfoRWoSAkr7J6yeov7zfp4Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] Makefile: add Perl runtime prefix support
To:     martin.agren@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 5:32 PM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:

> This commit message mentions RUNTIME_PREFIX_PERL twice, but there is no
> use of RUNTIME_PREFIX_PERL in the actual diffs (patches 1-3/3). Should
> it be s/_PERL//? Your cover letter hints as much under "Changes in v6
> from v5". And "Add a new Makefile flag ..." would need some more
> rewriting since this patch rather expands the scope of the existing
> flag?

Thanks for pointing this out - the two were separate flags in my original
patch set because I
wanted to minimize the scope of impact; however, I have since received
advice and buy-in
on converging them and RUNTIME_PREFIX_PERL functionality was merged
underneath
of RUNTIME_PREFIX in this latest patch set.

I'll update the commit message!
