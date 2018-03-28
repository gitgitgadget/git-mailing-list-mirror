Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 115A41F404
	for <e@80x24.org>; Wed, 28 Mar 2018 20:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeC1UVi (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 16:21:38 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32813 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeC1UVi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 16:21:38 -0400
Received: by mail-qt0-f196.google.com with SMTP id i8so4004604qtj.0
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 13:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=iCOmhyYNQx5cGoSNPpjkPg/2ekOfe8JTn44eR585wA4=;
        b=JB8rp9xDPXiXfE5tMGOAvKCbbXK1TNcfvN96hHEv0nqtr71+XETnoH5UBH7oRIZNs6
         HMkv6UYvlS8Stle5yot3xbHsp0QTxMgx0UPQ15bJFzJ3fiJwLKnJyJLjM3AcZLbDEHiY
         l0cVQbcmMIVBUMhsLOSLvpP4qvyzrOWKURQZ75nEFxjTR1HIa0gTdJ62pV3xGyT1BL86
         pW4/83TKvHdZbS2fP9oJ1gLmNcBOSqyIz8vQV5zm2SwrhncjrpBg18SU8VRpfi4LdYiY
         tympPavtSpAAQ+8oBcPhqiG4vX6ntmVsFbKhGvb0Lho8V60UYtsbCc9XZFvN+lesibgw
         rWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=iCOmhyYNQx5cGoSNPpjkPg/2ekOfe8JTn44eR585wA4=;
        b=QnIXqktUpKpEmX3IVCJo/3td4l3l1cxL7QvMqEOT02DrFbOXDtZOf8YlCKjsMMaIxr
         wgCVdLwu7nG+PicWf331S6yG5qlpWyk938uXlWboNKTx8BuSkqmPTt/wRM7JxYX3sSx0
         wuwz0kM5JOX+S8yxmScp0fvcAIoNVvFjSJ46UPWgUVrjuivrGGcbizkxcLjLKBgKaVWL
         0vMMtp9NjKqkbURAUXLLWenGHnEGf6PjaR273so7FsxL8bOHy1YYE9uq6th3KDJ+Xp1A
         5vlEBloujqCAYFjL4GS5Hv5yBGiIIQ759Tija/CKcFnDg0ZHlq6vMLx4C4oQRduUt/D6
         LcpA==
X-Gm-Message-State: AElRT7Gpi8lzPCL0Gpaa98GQ792trosai7PlB2VLm5gJ2lr2I5p1bhAi
        fnTNruzx3Sd48NFvMt4t2kg7S5OnG5ZudjqLeUA=
X-Google-Smtp-Source: AIpwx4+fVU3MC/CbQGZRRnpFKPGG1LQLMl6NiH0p7QcbaXaVRZrTovZXYkQKJ9cBg4ZRBHHioIRlrcHT0z3XGjEnXZc=
X-Received: by 10.200.80.78 with SMTP id h14mr7683832qtm.154.1522268497365;
 Wed, 28 Mar 2018 13:21:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 28 Mar 2018 13:21:36 -0700 (PDT)
In-Reply-To: <CAGZ79kYD+RC_Z7AH_uH9tZSDHhkikML4HkxUNGxkW8voHJ1i3A@mail.gmail.com>
References: <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de> <20180328183832.243036-1-sbeller@google.com>
 <CAPig+cT1Yp8J8E0VDKdxvPdVD-UBsyDfQS+a83zOAW11ayfhnA@mail.gmail.com> <CAGZ79kYD+RC_Z7AH_uH9tZSDHhkikML4HkxUNGxkW8voHJ1i3A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Mar 2018 16:21:36 -0400
X-Google-Sender-Auth: 7ZEkeP4A_KFWyeB54tB1cFbiGtU
Message-ID: <CAPig+cQ_j4OyBjsZHE8ZPBojqD7HhSEb14-CFY9qYfXX+dafpQ@mail.gmail.com>
Subject: Re: [PATCH] submodule: check for NULL return of get_submodule_ref_store()
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, jeremy@feusi.co,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 4:08 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Mar 28, 2018 at 11:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +test_expect_success 'moving the submodule does not break the superproject' '
>>> +       (
>>> +               cd addtest2 &&
>>> +
>>> +               mv repo repo.bak &&
>>> +               git submodule status >actual &&
>>> +               grep -e "^-" -e repo actual &&
>>> +
>>> +               mv repo.bak repo
>>
>> Should this "move back" be encapsulated in a test_when_finished?
>
> I thought about that, but decided against it for some reason as I was debating
> where to put the test_when_finished. I mostly saw those at the very beginning
> of a test and wondered if it can be called from within a subshell.
> (I'd not want to put it at the beginning but rather adjacent to the move.)

It looks like test_when_finished() shouldn't be used in a subshell.
However, wouldn't the following be reasonable?

    mv addtest2/repo addtest2/repo.bak &&
    test_when_finished "mv addtest2/repo.bak addtest2/repo" &&
    (
        cd addtest2 &&
        git submodule status >actual &&
        grep -e "^-" -e repo actual
    )

Or, even simpler:

    mv addtest2/repo addtest2/repo.bak &&
    test_when_finished "mv addtest2/repo.bak addtest2/repo" &&
    git -C addtest2 submodule status >actual &&
    grep -e "^-" -e repo actual
