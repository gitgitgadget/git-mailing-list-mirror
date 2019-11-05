Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33851F454
	for <e@80x24.org>; Tue,  5 Nov 2019 19:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390404AbfKETWN (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 14:22:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40437 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389691AbfKETWM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 14:22:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id f3so563816wmc.5
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 11:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3tr7Hv2r9mzti6k0qnphLFpO6kDf7O0zOwoYlplBR48=;
        b=s7hNbJ2bde2e943T00OC9TZOEOBL5MMm1dmTGBlvkcX/KzohPHSizK9upT4eG2jSqk
         nfT0rXpYbbPTf1HFYbDCfrBKjXkS4rOVxfQPE5fWe9+OlC/rRBY15MM+lh95R4cxBhUi
         yqQUY3uFhAmWWsz9uJONQdoDm9BD1NWUvwoIyZ1VqbPBwlVEz/8QkUebmMFsEuZbbSYy
         4BrqUDWLQYnpxU9pnyUon9iIAIW4eFDgMRvwGMBtz6gucwwLV5ksazYEN9JyjNDC1Tp4
         d2uRDJZUdLKAZCbcm0oiETzaKyNMRAoVxyadlu0wVnwaghTv1MZdMgCK/MrRkDq5Rvig
         1qTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3tr7Hv2r9mzti6k0qnphLFpO6kDf7O0zOwoYlplBR48=;
        b=HYhliyDAIrfvR2yOm2YpScF0t7APMbG0KbE34DcPvuTfm12ZnGBDs4CF6qRwx8Zp5L
         PGV9ojVBjR7Q+AVMofvq+RZfdsR+974j2jGDwyHuDGjCMbkh96v17BezPeDhhhNQk1iu
         Xd3OxVQ2BRV6omB4PezhqpiaKxoWtCKyZ4pvgTpXcmJC+zXFRcnhroGOzTWmxAubNUzC
         X6+2ENf3wcgK/djqwSQ8TaFmPLpkwyuGflY1R1UfZ3ptnYWMD2sIVSeGY9ZBUh9cX6VZ
         +aaG0ZQLzrqv59ZNu10T2rXymL+78mEqIIxIaqQuUvXFGRZdJRzX/4saunY0nTUplpj+
         +D2A==
X-Gm-Message-State: APjAAAXlQjW+STOMiAKZB+zGZH9LfNK74Gb490MQx70dacH2nCWBTnSt
        osFlv7Yj+6eM36YjsR6v4+E=
X-Google-Smtp-Source: APXvYqyWZVBxL2Cvm78AHNZ7pxGEinQMKSZ/QEo//JK5pAA4l7qqhg+cufSPUg6hZGl2q7gun1s5jQ==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr483028wmg.117.1572981730582;
        Tue, 05 Nov 2019 11:22:10 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-7-224.as13285.net. [92.22.7.224])
        by smtp.gmail.com with ESMTPSA id l4sm37262142wrf.46.2019.11.05.11.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 11:22:09 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/5] reset: support the --pathspec-from-file option
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <8d9f1fbc18346144a0c866a59891b652dcfe9b7f.1572895605.git.gitgitgadget@gmail.com>
 <b93592df-561f-36d4-09ce-e02d570c60da@gmail.com>
Message-ID: <af4ecf54-6353-2307-5905-624919e78683@gmail.com>
Date:   Tue, 5 Nov 2019 19:22:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <b93592df-561f-36d4-09ce-e02d570c60da@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr

On 05/11/2019 15:03, Phillip Wood wrote:
> [...]
>> +test_expect_success 'quotes' '
>> +    restore_checkpoint &&
>> +
>> +    git rm fileA.t &&
>> +    printf "\"file\\101.t\"" | git reset --pathspec-from-file=- &&
>> +
>> +    verify_state expect.a
> 
> If I've understood correctly this doesn't test if a path is correctly 
> unquoted, only that it is accepted.

Oh I think I've misunderstood. The '\\' in unquoted by printf, so git 
sees '\101' which is A so that is a real file.

Sorry for the confusion

Phillip

> 
>> +'
>> +
>> +test_expect_success 'quotes not compatible with --pathspec-file-null' '
>> +    restore_checkpoint &&
>> +
>> +    git rm fileA.t &&
>> +    printf "\"file\\101.t\"" >list &&
>> +    # Note: "git reset" has not yet learned to fail on wrong pathspecs
>> +    git reset --pathspec-from-file=list --pathspec-file-null &&
>> +
>> +    test_must_fail verify_state expect.a
>> +'
>> +
>> +test_expect_success '--pathspec-from-file is not compatible with 
>> --soft --hard' '
> 
> s/--soft --hard/--soft or --hard/
> 
>> +    restore_checkpoint &&
>> +
>> +    git rm fileA.t &&
>> +    echo fileA.t >list &&
>> +    test_must_fail git reset --soft --pathspec-from-file=list &&
>> +    test_must_fail git reset --hard --pathspec-from-file=list
>> +'
>> +
>> +test_expect_success 'only touches what was listed' '
> 
> s/^/--pathspec-from-file / ?
> 
> Best Wishes
> 
> Phillip
> 
>> +    restore_checkpoint &&
>> +
>> +    git rm fileA.t fileB.t fileC.t fileD.t &&
>> +    printf "fileB.t\nfileC.t" | git reset --pathspec-from-file=- &&
>> +
>> +    verify_state expect.a_bc_d
>> +'
>> +
>> +test_done
>>
