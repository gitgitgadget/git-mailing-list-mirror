Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B877200B9
	for <e@80x24.org>; Tue,  8 May 2018 04:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeEHEaX (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 00:30:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50410 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeEHEaV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 00:30:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id t11so16577973wmt.0
        for <git@vger.kernel.org>; Mon, 07 May 2018 21:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=755MFC22SzEmX/4xWUnwRFOj0qHVvVrYgCeLxo/e3yQ=;
        b=Ob1J02IGmRdd9XOU0V0rMiDKq49PPiHHO1cVisMwvH0KELN6FoaW49Ufp3OmUFdxDs
         Ovx4T4p2Yw/7iFpuc1Xnu4fhjrqvwh4ZIgQZy+ytgcEKyBLmSOB9YZityN3FE/tvUtI0
         yzVLFOT9a2BBb+/Q9/4sajS0i60Ua0WybTM1XcDTyWFhzZxb82YNToBEjX0k9Vspc32N
         0RGMK3X7iIrIHi1jZA41zumvstiTgYdM2bIVbWWgGm/CBAncG/XBm+TPhaTE9qVkpHot
         qu7J9jDO5dekukWpugjiN5R1ZCwL3VTI0xXmoXXuOclvCJNPJIbGkN+21a4rivFlCZtZ
         zVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=755MFC22SzEmX/4xWUnwRFOj0qHVvVrYgCeLxo/e3yQ=;
        b=Ey06ndQrIE3ps6X6I63P18KLejySa+nLdZBdup7WLAoW1GzzrGP4Gt7AxCg9wnrQg9
         B52zYoiPq+gOdwzGD3AOsk3/OBAb+19y4E8yln3XXyHKlUCIRlOzEASyuW5l1UDa9ImR
         ZnVsdvlDpaW+MoC0SpTewLttbI7rBPeM3D6D7ReP9Tj0YprwigvhQmNpUbV1NbxcE5e8
         gp6b6TkY1nx/nBxTkLG1E1NNSJOGJLNOKPWLuM/LXa3rw3kAAS1MD47l271zhvmGGITc
         nxYSNrE5p/F6wfSi0aAj/cCo0dxwWpZKUr9CKbVs4cDsuXY4i1m5Ls0RS5vxPZwH1QQJ
         TwnQ==
X-Gm-Message-State: ALKqPweDf/XmQPQsarL1qCcZz4w5LogeOnoeEo6RMWxVlcQ8waCB1hax
        xa6vi9/PjSv2Z9YARp3pTRc=
X-Google-Smtp-Source: AB8JxZoEyUNP0xMxNO0WbRJTRjjSxWOwhNV66nA0zjiI1ueXIsLhHauE5qw/flmzJCTDyZ3ZPVXNvQ==
X-Received: by 10.28.157.198 with SMTP id g189mr2428677wme.50.1525753820370;
        Mon, 07 May 2018 21:30:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g105-v6sm40755224wrd.45.2018.05.07.21.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 21:30:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] push tests: assert re-pushing annotated tags
References: <20180429202100.32353-1-avarab@gmail.com>
        <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
        <20180429202100.32353-5-avarab@gmail.com>
Date:   Tue, 08 May 2018 13:30:18 +0900
In-Reply-To: <20180429202100.32353-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 29 Apr 2018 20:20:56 +0000")
Message-ID: <xmqq603yn50l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change the test that asserts that lightweight tags can only be
> clobbered by a force-push to check do the same tests for annotated
> tags.
>
> There used to be less exhaustive tests for this with the code added in
> 40eff17999 ("push: require force for annotated tags", 2012-11-29), but
> Junio removed them in 256b9d70a4 ("push: fix "refs/tags/ hierarchy
> cannot be updated without --force"", 2013-01-16) while fixing some of
> the behavior around tag pushing.
>
> That change left us without any coverage asserting that pushing and
> clobbering annotated tags worked as intended.  There was no reason to
> suspect that the receive machinery wouldn't behave the same way with
> annotated tags, but now we know for sure.

Hmm, I am not sure if annotated tag T1 on commit C1 should be called
to "fast-forward to annotated tag T2 on commit C2" when C2 is a
descendant of C1.  Tag is meant to be a non-moving anchor point, so
it may make sense not to allow "fast-forwarding hence it is OK to
replace" that is typical for branch heads, which are meant to move
"forward".

But let's move on and keep reading, at least temporarily assuming
that "fast-forwarding" annotated tags makes sense.  Under that
assumption, this patch makes perfect sense to ensure lightweight and
annotated tags behave the same.

Thanks.


