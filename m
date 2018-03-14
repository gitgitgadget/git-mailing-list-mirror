Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93ECA1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 17:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeCNRVw (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 13:21:52 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43526 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCNRVt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 13:21:49 -0400
Received: by mail-io0-f193.google.com with SMTP id l12so5244548ioc.10
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 10:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=JGBID16XF/1gPgi98bA6/ax9C036uDSNhP7e6ftQ+x4=;
        b=UBtWpm72iPcntQX+pVATGluN1B7AHPnOkIm8XGil8KaD3cu0oH8jK3j24RjgHHRcXZ
         0Z5pA7R1NsdAsVCbMyaJDAez2gnQC/epszXZzQFHjEGDJhyXU7XSc7W4Zm1X3niHyT/j
         f0ykU9LfNxlKae9a0uitmKVkuS7DvTpMDykCKC0pRZHkYV/FNE/sagDouSYhs7GaIgiU
         auQkCgA8NuxQky9fQ8iXQ4IlxW1/RVo1OP0k86jmB6J0KIbNTTQlH/+38Jijt6t/UYcu
         8fLk5yOaIsgS8vgN67oseoGqsYIn2MzspCBGXUyxXlu1VBt7Cf6f43kdRVDBwaftKjOP
         DxMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=JGBID16XF/1gPgi98bA6/ax9C036uDSNhP7e6ftQ+x4=;
        b=WHMiAs0QPRTdx7DsrlfNjWE55R7veknlg0rClR+6ywQICyqqgspkcuCg3T9BSLuoAn
         EtF+jBGDe+65CtWef5rO95pZU9pUZauu5OmKLDGG3EXV1Tz6qYN46uZI2hR/JjoZWnFC
         ProMlNAWap12cKp5k+EBc2YidFt/6kQtHglI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=JGBID16XF/1gPgi98bA6/ax9C036uDSNhP7e6ftQ+x4=;
        b=BWpL5Wt7YEXa1qkQIocUvGbjtjjLRiGoHiwd9T9vqV3sDFcsCun0Wf/+oa9wJdAOGq
         dh3rY7WJPCEZim/LuEDt+Nw/Xil9KvmrZGEMDi/S5JPTPkIZJInYvqQia7n40Y254tRB
         y623vMbieGTkiPnz63h55mEuHIjMIXYwYLzTbfiozeeGLNDwasM/at8ljRnjlU+kq5Ru
         Gtka4AX598belCi3yikFxK/sHQTTyR0FRM6XhmHuWzccDIaKmLqHYPw0SWYVgPhN0qOc
         Ks8qazuFmVO85pzCCRgwKVmVGZL02tANnfucGc5xu/7E4aC50RdhsGT/cMkbRQlkhnAE
         BBjg==
X-Gm-Message-State: AElRT7G4kotw7MWKKRxOKi4899MAQBQlUTVxsVUnO3IqyeWZEszTm5/q
        oqLfRfmcB9+3bumeH4M55vcFdiwmLf3w55bApdrlJQ==
X-Google-Smtp-Source: AG47ELuJgvnDw9chBf9QIemZwVoQDCa+smau7IC5oq/V/QgbFeEUdtOG4qAuEydwTu24LWWEbaTkekZvyIek0TNUQJw=
X-Received: by 10.107.213.65 with SMTP id x1mr2254220ioc.203.1521048108630;
 Wed, 14 Mar 2018 10:21:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.132.21 with HTTP; Wed, 14 Mar 2018 10:21:48 -0700 (PDT)
In-Reply-To: <87y3ivdkvp.fsf@evledraar.gmail.com>
References: <20180313203935.5084-1-avarab@gmail.com> <20180313203935.5084-4-avarab@gmail.com>
 <1cabf9c0-674e-c2b3-9977-9c74b929a86d@kdbg.org> <87y3ivdkvp.fsf@evledraar.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Mar 2018 10:21:48 -0700
X-Google-Sender-Auth: tpmPx9U1tpdFVrxrLmce1lUal04
Message-ID: <CA+55aFwU5fwWx2+DdBp=XCpG2Orx+rA8KxPVtGHxpgHAZs=h2Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] Makefile: optionally symlink libexec/git-core
 binaries to bin/git
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 14, 2018 at 3:14 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Mar 14 2018, Johannes Sixt jotted:
>>
>> It is important to leave the default at hard-linking the binaries,
>> because on Windows symbolic links are second class citizens (they
>> require special privileges and there is a distinction between link
>> targets being files or directories). Hard links work well.
>
> Yeah makes sense. I just want to add this as an option, and think if
> it's proven to be un-buggy we could probably turn it on by default on
> the *nix's if people prefer that, but yeah, we'll definitely need the
> uname detection.

I definitely would prefer to make symlinks the default on unix.

It's what we used to do (long long ago), and as you pointed out, it's
a lot clearer what's going on too when you don't have to look at inode
numbers and link counts.

Forcing hardlinking everywhere by default just because Windows
filesystems suck donkey ass through a straw is not the right thing
either.

                Linus
