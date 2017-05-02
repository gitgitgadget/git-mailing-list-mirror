Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B65F1F829
	for <e@80x24.org>; Tue,  2 May 2017 09:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbdEBJfi (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 05:35:38 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36497 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdEBJfh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 05:35:37 -0400
Received: by mail-pg0-f44.google.com with SMTP id t7so58287050pgt.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nooyqwNQrDnIwt0opoG2P0dYmFP5ofh/tP2V04DQYaE=;
        b=GMfOyNFTlRkrzCHlxiNGDf80UNPB75b7tD9VHrv88z9rl6qJb7gxeck57KcDyawolG
         MkHzoobTCP8NyLxGLMo0M9JtplncdSY00TCiIvlswXPCSUoH8w1GLdAU6zgS4O3x3MB7
         c8R8mkSraEZ4TbL4Og8s7rP/0f2ueMoRvvRUQrfc8SHnVRd3IEy3RCoPVVTs/heCKjor
         yVcHvwjBb+xdYI/z4byM2qzs0tWW9AuLhW9uGmGmThxFBBTsk/AFAtHCp9fj897nhDRM
         +L2Y55gm25WyiB9Q8uaJj2eDrdeGi/bsF4GXYiXV5ZFhh2mg72SymSg5YUdWT8RIGLb8
         2SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nooyqwNQrDnIwt0opoG2P0dYmFP5ofh/tP2V04DQYaE=;
        b=OtKJb20OiijinVPApC+hi2wWbwssmhvF0MZBv+u65ADKC9y+mHz/RQBNUh9ROckHTz
         4WgPVLLRw9MVnIQdgWcv8uTlwttOTNoIJnk5aagxMvnFNP0PrCXAIooiaeJuoSJVT4eT
         x5WLpYuW2jvSWFniZYPMlQ20tbn24QmWUiWCcWdudwRSVE9paEF0/QF7KOo7vSFhkbNF
         GhXOvgp6KQxrVH9mEQ8DRvyKT0HISA6iXwGyvhPM5lvUPFa03EQwjIyhJLGLPuUyav7I
         rSAoqRKW3j2mbRXi9r9eVxgLERmFdcndKo/4wQSVHWA3SqBN3E2Bo5GLA7l9cvEPoiBO
         I9+w==
X-Gm-Message-State: AN3rC/70OVH0MLV/QJPvtc6i0RMGqqc2iHbm9OkkU6kRd62CTCyANXpj
        p8vvMtPxA2sVzA==
X-Received: by 10.98.9.68 with SMTP id e65mr22594483pfd.177.1493717736836;
        Tue, 02 May 2017 02:35:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id o23sm29664150pfi.100.2017.05.02.02.35.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 02:35:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (May 2017, #01; Mon, 1)
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4ty91vh=ykMtpF0pV8Ru3BKWBXyQYsFRdPkKkxMd8pzw@mail.gmail.com>
        <xmqqa86wgo33.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5N0L_M9b4RTRLSvcA2u69H=s=S-VEc-Nr71wW6Scyjvw@mail.gmail.com>
Date:   Tue, 02 May 2017 02:35:35 -0700
In-Reply-To: <CACBZZX5N0L_M9b4RTRLSvcA2u69H=s=S-VEc-Nr71wW6Scyjvw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 May
 2017 10:23:46
        +0200")
Message-ID: <xmqqr307d2jc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>> That squash looks good to me.
>>
>> Thanks.
>>
>> That is not a particulary helpful comment, by the way.  I can help
>> topics by contributors by queuing emergency fix at the tip to make
>> ones that do not build correctly buildable and testable (which is
>> what the "SQUASH???" commits are about), but I'd rather not see me
>> forced to find among 19 commits which one is broken and needs the
>> hotfix squashed in myself.
>
> I'm happy to change what I'm doing to be more helpful, but it's not
> clear to me from this & the context what that would be.
>
> * I sent a v4 that had this bug in <20170425210548.24612-6-avarab@gmail.com>
> * You pointed out that initialization bug in response
> * I sent a v5 of just that patch (not the rest of the series) in
> response to that in <20170426074856.29903-1-avarab@gmail.com>
> * You replied in <xmqq1sser7ty.fsf@gitster.mtv.corp.google.com> in a
> reply I (probably mis-)read as "no worries, I'll just squash the fix
> in"

Sorry, I completely forgot about our exchange around your v5.  If
your comment were "squash is good but you've seen a replacement sent
as v5 that is not there yet", I wouldn't have made such a silly
comment, but given that I've already responded to your v5 saying
I'll handle it, that is asking too much from you.

What I pushed out a few hours ago should already have the fix in.
Thanks for clarifying the situation, and sorry again.



