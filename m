Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F39F1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbeHBUhO (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:37:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50724 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731501AbeHBUhO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:37:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so3652476wmc.0
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6KRssq0NnDBvfnxzsOtcVwIiW2uUQjmLqsbTYn6zWoo=;
        b=NC94us8B5c2+BCOVe3cediMqhLw0CYv0u6di8NLNDrOrk9nHkYpzxBFPScOvjEqgR2
         +4OSzGrN+UiC1Di166NCAG8BTEflMZTX4cpKc3JhYNPFVj6rA+piwJaTh3ZiV1fzLe3d
         eugnsFSDRU2kAmJA508a8ZaErkPK6/cis3F1N5OM2S6StkWn8VO/JYQOZ7YLQAafMCOs
         8jUYpJVr1Y+qJS2V67bkBhniLmH9S/3svxPo2iyrLXbqkJyRTAVlovPd4SEqDkY36Jl/
         HzlmGMfsEm071LSHLJxsAPr+ymyqQo9lcl1sGhhkHIgw0NMPXpfN6pKtmRqsy28hvFep
         5SAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6KRssq0NnDBvfnxzsOtcVwIiW2uUQjmLqsbTYn6zWoo=;
        b=CfMRvU6bK0JoIT2X4nsaW1tz8LB11oRNUwV3oFtrNswRRIe6FWNuQ2WeD6YSFgWg8P
         ww26//Oa6+NFSQKsXRZsk+hwQ/61dc4RKsuoULDpKUj0/kdLdeIDh1fcORWOuL1uY7vl
         WlnVYvbg2OxWVnCAmke+reTPgQQGVIwhKvGVjdyrRlmj9RQWavLm9ntIfnDxzl83BHu4
         5uO4b+pVRuzC1Cth1FkMTYuuXZrX4xzjM5lXOePaJ7417BhKYlR34RfdmcArnjZa6BAm
         KV9u9bGVXOchkXZb5gAjsj+5dhejzujmagY5O7BaQvCZ8UrrCuZH03hVGTCavgY8GxQG
         SgAQ==
X-Gm-Message-State: AOUpUlHJjuzjdMLWA+pKTSuLALaoqShVxODvXCjxjTt6c+LD9JdY1mvw
        3nouFCosbE1XXSdNEoY/VFdQROvX
X-Google-Smtp-Source: AAOMgpdqF/y1Jjx6+LCOWk6Gez6vi5XZD++U6HwDmOf1glw/kR1pbQZDCrJTUVF1BoIEKCUSpCRf2A==
X-Received: by 2002:a1c:e70b:: with SMTP id e11-v6mr2708537wmh.22.1533235491773;
        Thu, 02 Aug 2018 11:44:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c124-v6sm3319359wma.47.2018.08.02.11.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 11:44:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Antonio Ospite <ao2@ao2.it>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH v2 03/12] t7411: be nicer to future tests and really clean things up
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-4-ao2@ao2.it>
        <20180802164042.28026-1-szeder.dev@gmail.com>
Date:   Thu, 02 Aug 2018 11:44:50 -0700
In-Reply-To: <20180802164042.28026-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 2 Aug 2018 18:40:42 +0200")
Message-ID: <xmqqh8kc1ucd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> Tests 5 and 8 in t/t7411-submodule-config.sh add two commits with
>> invalid lines in .gitmodules but then only the second commit is removed.
>> 
>> This may affect future subsequent tests if they assume that the
>> .gitmodules file has no errors.
>> 
>> Since those commits are not needed anymore remove both of them.
>> 
>> The modified line is in the last test of the file, so this does not
>> change the current behavior, it only affects future tests.
>> 
>> Signed-off-by: Antonio Ospite <ao2@ao2.it>
>> ---
>> 
>> Note that test_when_finished is not used here, both to keep the current style
>> and also because it does not work in sub-shells.
>
> That's true, but I think that this:
>
>   test_when_finished git -C super reset --hard HEAD~2
>
> at the very beginning of the test should work.

Assuming that the operations to create these two extra commits
always succeed, yes, that would be a more robust and preferrable
option.

I don't know if that assumption hold true offhand, though.  Don't we
have a more stable point to anchor that going-back-to commit to?
