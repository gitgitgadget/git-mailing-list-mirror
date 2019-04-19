Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 752E420248
	for <e@80x24.org>; Fri, 19 Apr 2019 19:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfDSTTv (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 15:19:51 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:55882 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDSTTu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 15:19:50 -0400
Received: by mail-wm1-f46.google.com with SMTP id o25so7146333wmf.5
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XLoC0XQ/A+UTPnSmJniherRa7iIBBbiQJP/21twtqfk=;
        b=KurLAg5QaWq+6v9msOtEigM9F827R4uAfRdv9P3Mqrcl96n3mlwFZG7zq1wpJj574q
         hyRsNZ+wLzlVAKFzxU8ZaCj/l01fACoVCsKx+T6UPuP7RcRZW/ygTbhkvSllkXKYHSGc
         nZZBwX0e4XTbNPJvuOJYAKY1LmC5sOhzaVOCdwMlAuKNXZo+T76IbBmN4/YDs8508bxg
         ZRdH6Izn7bL6MhjiMfbT+1w0aCWB42PwR8O/aVWh35glRa8vML0MUGS1IcpRfKd6l6V/
         V001EG2gy5lEXShGl2LDSECVNON/n9s7ZnG1N674NVK3a3oBDd/zDqM7JsP3dkK1Y2y/
         WsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=XLoC0XQ/A+UTPnSmJniherRa7iIBBbiQJP/21twtqfk=;
        b=S22PQpXEM99rW9MVjZ3DeD2VgbmZcCSddjk7FDn4qrcll08nSWk97jLnV1Jpp96qmg
         3XLlf5KwslNy3CxftdpSEBqgT91HjdUpeErIoSfurqvxjaUih6XQ1U8Czj78el6i/jj9
         70/syUvAO7nWw1jCFMBYeHnORaMeadtLxrBhshqa/NjP67rEIKRxOuzbgNxpxAY76+ap
         EFmGAyfh82gRpcW3oAVaSBb6pKylsPe4YalsknXntLKFStXIELum0VNT+6CmOjeIIrXN
         IlLVXUVvrCaXQ4APkTCe+XYQ78o5RTgJHT/eNuVyI59AbdDuFvi7fMkFmAS7snVOWA8V
         8mLg==
X-Gm-Message-State: APjAAAVvWwEzIEWNTB8V1Fu7pAJuOe21R8Oc1hO7ZCpCKxKgm/ciEQvK
        OeOJOj5sW/h/+FAdp65cd334lvuYJeQ=
X-Google-Smtp-Source: APXvYqz97610RwiVq7bwlutaRfYzYk9MS57GYBXvr6OKRjMMRM9wFsxTTrJhvXFX2MGKYR2sNvq8xA==
X-Received: by 2002:a1c:9d8f:: with SMTP id g137mr2315492wme.26.1555670666285;
        Fri, 19 Apr 2019 03:44:26 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ejz242.neoplus.adsl.tpnet.pl. [83.21.167.242])
        by smtp.gmail.com with ESMTPSA id z23sm3355719wma.0.2019.04.19.03.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 03:44:25 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Giuseppe =?utf-8?Q?Crin=C3=B2?= <giuscri@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: Feature request: Allow to update commit ID in messages when rebasing
References: <CAGV3M54XhRMDXdhbfTon5nRV59VOjw8W4YrNP63TqPYm8pxd8Q@mail.gmail.com>
        <878sw8bbby.fsf@evledraar.gmail.com>
        <xmqqtvewgj4c.fsf@gitster-ct.c.googlers.com>
        <86o953z0b9.fsf@gmail.com>
        <CAGV3M55di4Nc_x25RoT0=dREkeCVc5_LpNabEjVDF+mSHK+0nQ@mail.gmail.com>
Date:   Fri, 19 Apr 2019 12:44:20 +0200
In-Reply-To: <CAGV3M55di4Nc_x25RoT0=dREkeCVc5_LpNabEjVDF+mSHK+0nQ@mail.gmail.com>
        ("Giuseppe \=\?utf-8\?Q\?Crin\=C3\=B2\=22's\?\= message of "Thu, 18 Apr 2019
 19:58:23 +0200")
Message-ID: <86imvaz33v.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Giuseppe Crin=C3=B2 <giuscri@gmail.com> writes:
> On Thu, Apr 18, 2019 at 7:32 PM Jakub Narebski <jnareb@gmail.com> wrote:

>> Well, what about limiting changes and rewriting only to the commits
>> being rewritten by [interactive] rebase?  I mean that we would rewrite
>> "revert 01a9fe8" only if:
>>
>> a.) the commit with this message is undergoing rewrite
>> b.) the commit 01a9fe8 is undergoing rewrite in the same command
>>
>> We could use the infrastructure from git-filter-branch for this.
>>
>> It is serious limitation, but that might be good enough for Giuseppe
>> Crin=C3=B2 use case.
>
> In which case you need to change the ID of "revert 01a9fe8" _even if_
> 01a9fe8 is not involved in the rebase? Wouldn't be a solution to my
> use-case an already complete solution?

What I meant by "serious limitation" is that the condition a.) might mot
hold true.  You might be rebasing / rewriting the commit 01a9fe8, but
there might be some commit not undergoing rewrite (for example one on a
separate branch) that refers to the commit being rewritten, e.g. by
including "revert 01a9fe8" in the commit message.

We also need to assume that the commit referred to (i.e. 01a9fe8) is
being rewritten earlier in sequence than referring commit (i.e. one with
"revert 01a9fe8").

Regards,
--
Jakub Nar=C4=99bski
