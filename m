Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A411F404
	for <e@80x24.org>; Tue,  6 Mar 2018 16:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753932AbeCFQ4s (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 11:56:48 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34462 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753927AbeCFQ4o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 11:56:44 -0500
Received: by mail-wr0-f195.google.com with SMTP id o8so10158263wra.1
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 08:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7G55P4Qk/7vlyP8mvECfVzzwhags6YyajQNt6K8rCQU=;
        b=NBLRhBNRwJuuM3IWTXdak1kZ4UgXH4yAWoTpzfHRZhBlrHGgwDdhObMNXuTd5+eVz7
         3gBeElwS+VqJPA/zm1/w4Sn1u7f2VuDVThpImbqLiC+g1iHK1BRmBkQG5rS0sAv+uHwG
         zpykxoF1igGcLcEDaxiMa/o5uXNlkOx8tOzSFVva1ofSeJPnwluhWdb1r6DrBQHUz++C
         kgcPUquMerxbHsMcdkk7XDI9oUrq1KwezmyS8u1Jl/Ihj2AaV2DeF9uNP0YFjtPoEwul
         dETbJA04l1ecAd7aDMTA2a32elJANMJGpohd/A1eazMcDotxiNWquqvtqViXwaFxiuyY
         xDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7G55P4Qk/7vlyP8mvECfVzzwhags6YyajQNt6K8rCQU=;
        b=tgdzXl1hwiE5ioyM/96uMxUiF0j6vH+7Q/3sXDQ2uA26XsthcT9GaYvB/avzyCFOq2
         nj/6pcvTu6uaWVhHkmMG+1dY7cNdZOT5WnaovsHuHDfiCeQ+tdcuLzwiHEj1Kyl95n30
         b0nMXPEXHYBHidQ/qzosjpbbUtELakkG7VWKtzt88126xI/YBtx02T+oa4uf/U2vx2wH
         aUAN9KjLCJkgllUHoKG3nkRcB1znOKl8RXzV0RowlytCLkfUcIWEOLhE7eKAo23/uIlN
         kQ9HQJKOwXB/3SktIxxQ+MELULVUpAR+R7+gbvbYz5TfWQ8CITxlMH+RjIlcsFRIWqz7
         KF8w==
X-Gm-Message-State: APf1xPAYwcuTDd8Jrg1lBcFmGP+ZRlAxrsYnLerE7NY5MgCYv1LkibqX
        ZKiFgBevAYejRvc3MIWKrhs=
X-Google-Smtp-Source: AG47ELufbMsxrNdZZsUiv/DO56MDLCrcWagB6xxnoB110iCrl3sfg5F6GqCOKctDiRgUCNGnDmCKwQ==
X-Received: by 10.223.190.17 with SMTP id n17mr15510728wrh.189.1520355402793;
        Tue, 06 Mar 2018 08:56:42 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m129sm9812345wma.44.2018.03.06.08.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 08:56:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
        <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
        <87h8pvm7zz.fsf@javad.com>
        <ebc73962-8dff-520c-e19d-8fcc1ef63ab0@talktalk.net>
Date:   Tue, 06 Mar 2018 08:56:39 -0800
In-Reply-To: <ebc73962-8dff-520c-e19d-8fcc1ef63ab0@talktalk.net> (Phillip
        Wood's message of "Tue, 6 Mar 2018 10:52:36 +0000")
Message-ID: <xmqqwoyp5eig.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> I wonder if just having a predicable result rather than forcing the
> rebase to stop if the user just squashes a fixup commit into a topic
> branch that is the parent of a merge might be more convenient in practice.

Unless I am misunderstanding what you are saying, that is pretty
much what I have automated for my daily rebuild of the 'pu' branch

Non-textual semantic conflicts are made (in the best case just once)
as a separate commit on top of mechanical auto-merge whose focus is
predictability (rather than cleverness) done by Git, and then that
separate commit is kept outside the history.  When replaying these
merges to rebuild the 'pu' branch, after resetting the tip to
'master', each topic is merged mechanically, and if such a fix-up
commit is present, "cherry-pick --no-commit" applies it and then
"commit --amend --no-edit" to adjust the merge.  I find it quite
valuable to have a separate record of what "evil" non-mechanical
adjustment was done, which I know won't be lost in the noise when
these merges need to be redone daily or more often.

The Appendix in Documentation/howto/maintain-git.txt talks about
this process.  You can see what topics have such merge-fix defined
by peeking https://github.com/gitster/git/ repository.

