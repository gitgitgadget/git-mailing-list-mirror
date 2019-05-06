Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4386A1F45F
	for <e@80x24.org>; Mon,  6 May 2019 13:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfEFNr6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 09:47:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41244 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFNr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 09:47:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id c13so14701704qtn.8
        for <git@vger.kernel.org>; Mon, 06 May 2019 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tM9a3dcXaOxXjo6xeTNWwTQBBIOgfCye3xndLvm6GaU=;
        b=F/GsUT5sV8V8IVJxJ9q2OTw9eGOaJylsqcP5NOPWuKlPLNEC9250r8RkBq80qIl95P
         d849fKwRBi5Ejzt7Ob885wDtgrJRUH0Urjf1fqqnI9xuEzLKOqs4K7/gQrEt2bmU1hMM
         rQ2NKtYoYyrF0oFca6C/TuFK97+6Zli2cryIZnbhVSQrCgdD0/F3GzRwfl7vGEjDH0Ux
         O2i9g4bX0r09NGDXs/4G57uYGindvpN0so6aERr6lhcfd1bS9VwQqDP+bGBBECMuoYPV
         N6NZqdCLqe2d/t5RWUjHE3MJm9BgwAQ36W1VjKKHpZceg9EB5Z5mSs4neTFZP+GyJcCO
         /Z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tM9a3dcXaOxXjo6xeTNWwTQBBIOgfCye3xndLvm6GaU=;
        b=Wkg4lA7HQwvj8kPDRUErF6BybkErSlw6qxzC9mIOPXORI2Ozt79W20LbmdZDlcNYxr
         YW7mZbyb50JoGA04OWcxAezlUJVaWWojZVdi+348oviHDOok5+ICPbaOk9pEg6f5Kr4Z
         FUgr7rZqPFeX2UIPwX2Lo7ZIhcMkyjSrMtIyGMBSBzPf3d6mwpTcSWp17eG//j6RvEou
         oK4U39VQS9VMjCuOozsCfwGQlNWy043tDBSit1DUYwWA5c+G+tuSffjwUPCxB+OCOnp/
         pq5rmOE67zWZJPG1qBlefXkCezdWll+ecz7PsZHQaKBHBc7KDmAC3jc1A4u4toSoTp4h
         ykVA==
X-Gm-Message-State: APjAAAXXxbzmhLd30Bv0IQ41mhjJS5BefCWlCe/mztfrmTzUSVgb5A9Y
        4FNHwlTLX0JWoHtv4daAjEM=
X-Google-Smtp-Source: APXvYqxHg3k3WWt8q7pez/rWOWiRQSoct/jps13CLJTi2BB3ZDojFzPCSwaQmn914HlOM487/GAClQ==
X-Received: by 2002:ac8:2392:: with SMTP id q18mr21001859qtq.299.1557150476597;
        Mon, 06 May 2019 06:47:56 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:ca3:f1b0:e81c:4f11? ([2001:4898:8010:0:f5d8:f1b0:e81c:4f11])
        by smtp.gmail.com with ESMTPSA id z11sm780244qki.95.2019.05.06.06.47.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 06:47:55 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Create commit-graph file format v2
To:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <pull.112.v2.git.gitgitgadget@gmail.com>
 <pull.112.v3.git.gitgitgadget@gmail.com> <87lfzprkfc.fsf@evledraar.gmail.com>
 <bb0c22f9-9d0b-0fa6-e826-8e2ac146c6f9@gmail.com>
 <87h8acivkh.fsf@evledraar.gmail.com>
 <04ac97c5-ab2b-2b23-4c84-8ed8aab0e2f5@gmail.com>
 <87bm0jirjj.fsf@evledraar.gmail.com>
 <CAP8UFD2tnkNfgjm=H__=YPG-+BuOHwHs9=OoXnL9wnj_eOtbQg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c827ccb9-4278-0630-ac38-6cf597437678@gmail.com>
Date:   Mon, 6 May 2019 09:47:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2tnkNfgjm=H__=YPG-+BuOHwHs9=OoXnL9wnj_eOtbQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/6/2019 4:27 AM, Christian Couder wrote:
> On Fri, May 3, 2019 at 3:44 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> 1) We can stat() the "commit-graphs" directory to see if there's any
>>    new/deleted ones (dir mtime changed), similar to what we do for the
>>    untracked cache, and can (but I don't think we do...) do for packs/*
>>    and objects/??/.
>>
>>    As opposed to ".git/objects/info" itself which e.g. has the "packs",
>>    "alternates" etc. files (can still do it, but more false positives)
> 
> About incremental commit-graph files and alternates, I wonder if they
> could work well together. The main use case would be for servers that
> use a common repo for all the forks.

We use a "shared object cache" in VFS for Git, implemented as an alternate,
so all enlistments share prefetch packs, multi-pack-indexes, and commit-graph
files.  This is something we are very focused on.

Thanks,
-Stolee

