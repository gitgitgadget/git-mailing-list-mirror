Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4FBF1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 16:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeHCSGf (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 14:06:35 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39323 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeHCSGf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 14:06:35 -0400
Received: by mail-wm0-f48.google.com with SMTP id q8-v6so7003517wmq.4
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MoRNkOOhiQ4ljBRyb2jpoUaXf+NfP46dH3Rr9kFB+Bk=;
        b=DLBSsMoQ9GGUXOo6YhTjfN9lzQaecPgq0ldbTVHlO5u4dVj10MIE4IP9wxGyTvXWlx
         YIFfhj4SEb/3uF/mIYjPeoXQ19mQILNZOW+DWlkHl/Nv97FfGAUPb/cLCctFIRDbgXz6
         y7mogV2cZQtcIrFdhXMHSgBMkiGNUNP+QcdgdYqnSVmtwyghw8Q8jFy5OTDYxgU8BDmU
         PDUBwO14efXx22qrtPYe8lJtqM69wWVykh7wdZCNKCTx4jkAjsTyc4RZCp8VLmnTDzKM
         ewyM2lxvpY6tx5Oa5maCkRzMOtJmpRHPdUkcnsHyNd2i6S43p5zf0ipjkftMh18gIZKz
         iZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MoRNkOOhiQ4ljBRyb2jpoUaXf+NfP46dH3Rr9kFB+Bk=;
        b=DxVMuZU6tqtCKYpVqDZt2Q2lO72gsAttUt5prbNsGOStIXuH8qTewkIhvuJTfs3mQK
         WBNPVcY7nrMmfRgL9m/q8xVxlRhjDuanpF4GL5/3FkunNt+eGVVr+Ms3o59xH77844Q8
         Z5thpaJhN0VbjP56Jem1/8D1SEZ9cyqjq54GHQiw6SD+OquRUO41O4cvNb+3tPlTXXaI
         JA5H1kFXmLoQdzL0+SWk5ZE1sZSpyEiLGy7IzyREa2fLQTw2c3RErIDHv35kozeI4YVX
         Iv+5OV3Pu/kJE3sbsJed3uE+yfDFNwqXGh454T6BkeaCYc0I+9rEN8GQegPieIoiFVfN
         gLVQ==
X-Gm-Message-State: AOUpUlHizanDXoqXBjbm/XjoTonguo2T9eTxQhU8yi6MdjeOE9iuICs+
        H6aOR8mCEpOmjEzj16tniLf4CbJv
X-Google-Smtp-Source: AAOMgpcSTVVnG0R/0veQtUbttnDggkqpdsNYg/bpVFPdCkGjtZegiykK737aa74auf5lUazMJ6Njcw==
X-Received: by 2002:a1c:7908:: with SMTP id l8-v6mr5150330wme.80.1533312577105;
        Fri, 03 Aug 2018 09:09:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e7-v6sm4990526wrm.14.2018.08.03.09.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 09:09:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
        <CAOZc8M-AqmcbM=Z47SoPpQNaGwFWEbQ=BctXHaYBVeUf9V+j=Q@mail.gmail.com>
Date:   Fri, 03 Aug 2018 09:09:35 -0700
In-Reply-To: <CAOZc8M-AqmcbM=Z47SoPpQNaGwFWEbQ=BctXHaYBVeUf9V+j=Q@mail.gmail.com>
        (Pratik Karki's message of "Fri, 3 Aug 2018 08:45:51 +0545")
Message-ID: <xmqqftzvzb28.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratik Karki <predatoramigo@gmail.com> writes:

> Hi Junio,
>
> On Fri, Aug 3, 2018 at 4:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * pk/rebase-in-c (2018-07-30) 3 commits
>>  - builtin/rebase: support running "git rebase <upstream>"
>>  - rebase: refactor common shell functions into their own file
>>  - rebase: start implementing it as a builtin
>>
>>  Rewrite of the "rebase" machinery in C.
>>
>>  Will merge to 'next'.
>
> On a recent mail[1], I had suggested stalling this iteration in `pu`
> and wait for another iteration to merge in `next`.
>
> [1]: https://public-inbox.org/git/CAOZc8M_FJmMCEB1MkJrBRpLiFjy8OTEg_MxoNQTh5-brHxR-=A@mail.gmail.com/

Thanks for a prompt response and correction.  Very much appreciated.

