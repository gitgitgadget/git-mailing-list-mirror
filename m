Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E36B1FC44
	for <e@80x24.org>; Sat, 11 Feb 2017 03:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbdBKDNN (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 22:13:13 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34723 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbdBKDNM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 22:13:12 -0500
Received: by mail-pf0-f196.google.com with SMTP id o64so2469847pfb.1
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 19:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PGOWFq5XXJ5Z9ayLwfHav7/NPxTBJgR/RywP0v5ZhKY=;
        b=Kx2w5daX62jhT95pMCfViEUIxPOr9bz8BZluHJcaT2N28woiIvkMvpqlHa0kbZdPoA
         eUbkGUDMX8JLqRIwtAXCq6/7x9LMnJQ9hshJ3yFwxz0CgXiMY41FylpyYNBLvgFNhuWD
         f/wu32ySg0fFSWXTjtZmmZLHIl+Nep/i6T/NTCjJHaiQcqeQcZfyx5bP5kwvJmDTxYJ5
         nBIFxc6k/ZjcCevesHgK/zzyrpCKpEzoV4pEYeigBi6THNpPH6QYcdZoWjHMaAAV3ZxU
         mx2GR8B29mv30xxgXcxt2xauNdKi20OjotH2lMeeu+eXo4ourYUwmogwI//uLVBAHItF
         B8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PGOWFq5XXJ5Z9ayLwfHav7/NPxTBJgR/RywP0v5ZhKY=;
        b=Dh+ZJzs5WIDU3MbJ0Rm8M8EL8xlqCa+GA7IX/0T6k4rilT2Eof/AZah4Y9dv35Zr55
         MlNSc67amM3lEAekvATgvoi+UOwpGHFfOKWHEEwEha2iyy2WIVh/JaAkoRpTjgPicXEn
         vIUOHtfavSfspiWV016KGZHMn0mxpBscknqhN1xbg2wTCKPSA0BipZiqL2VS6TOml4xV
         f+CB39MYoy3lo97wsbSrvdqFQA+nXNuymrTnNZKae7ixdYzDJgQ4V1K3goYnlo3TQa80
         xFyOUKo78/TTK2n0FM/MhPL/JmtByLgFD2txIfB0kRGqL9QAQ7Ro7ZryP85FeBe8FMow
         mxbQ==
X-Gm-Message-State: AMke39n4S42lQ//1elfzKMIZHLUy/TONfyAX5F6DbdXCNjAPDps5R9XF+83yv63OjMhUDQ==
X-Received: by 10.98.159.141 with SMTP id v13mr14201335pfk.50.1486782759345;
        Fri, 10 Feb 2017 19:12:39 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id h14sm8002550pgn.41.2017.02.10.19.12.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 19:12:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: What's cooking in git.git (Feb 2017, #03; Fri, 10)
References: <xmqq37flk7l4.fsf@gitster.mtv.corp.google.com>
        <77af28f3-7a8e-fc6a-40ae-c4203d1a3a67@web.de>
Date:   Fri, 10 Feb 2017 19:12:37 -0800
In-Reply-To: <77af28f3-7a8e-fc6a-40ae-c4203d1a3a67@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 11 Feb 2017 00:05:24 +0100")
Message-ID: <xmqq8tpdifoa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 10.02.2017 um 23:24 schrieb Junio C Hamano:
>> * vn/xdiff-func-context (2017-01-15) 1 commit
>>  - xdiff -W: relax end-of-file function detection
>>
>>  "git diff -W" has been taught to handle the case where a new
>>  function is added at the end of the file better.
>>
>>  Will hold.
>>  Discussion on an follow-up change to go back from the line that
>>  matches the funcline to show comments before the function
>>  definition has not resulted in an actionable conclusion.
>
> This one is a bug fix and can be merged already IMHO.

Absolutely.  I was just waiting if the follow-up discussion would
easily and quickly lead to another patch, forgot about what exactly
I was waiting for (i.e. the gravity of not having the follow-up),
and have left it in "Will hold" status forever.

Let's merge it to 'next' and then decide if we want to also merge it
to 'master' before the final.  The above step alone is a lot less
contriversial and tricky bugfix.

Thanks.
