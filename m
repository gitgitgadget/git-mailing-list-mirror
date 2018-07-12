Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6EC11F914
	for <e@80x24.org>; Thu, 12 Jul 2018 18:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeGLSmX (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 14:42:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43305 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeGLSmX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 14:42:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so22703701wrv.10
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=R9FsNELna1g9jIZXly+aPC/PJwhODH/hxe3Kn9w6iMM=;
        b=V0BREWcaGDWV0+CKVwZyQn0lO1fogUJhniOMN4drbEwLt35oWvPTXzJ1UOlleLqQev
         Tllk9jWkOdF65yMlxm3z7BejlYUA8HYGtJ7uCtYKOpQCyPnk/e6Ld5fNXKFYRwV4Bhr+
         hDypF3TdtabHl0BRdMc14YZCdpkbgVjhzooAvemTtqCTtVx8CkLzdlMLdZLvYhjq61sV
         BCjcpCqUCxIXVDQyMFGgfe4Rk7DUQk6XacEXfBxx3dEKhIl1WiqNQ+a/byIkouNPKJDr
         z0Y69Nlfr/JeutnWraPvhme6QetQdPqYyKE0IVe4VHqRcFyGz6hEIFL3Z0CUVRR2AjB+
         QvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=R9FsNELna1g9jIZXly+aPC/PJwhODH/hxe3Kn9w6iMM=;
        b=tcfN1JkakKGGpCzF3YFe8hRVKgSFzMuKUQHXGP7OcqpGc3PKf3ytyZAsfofEe62/lE
         i3cgBRY6iNHLhLI5zBjYBcImJtvS4IRleT85THVUbt6wBb0TzBfXs7hyB7460VFdqqaZ
         TDxaZn0DdBKF6FDfjP+7nk30wRSq4bvOY90FPaOxvnTqp1r406hq6sJnHJD9J/H8c6JO
         XEwfuku2NiP0oC6kLB4P/N9/Oz2P6VDM1SKDVIr9afFVtEGoBGAPPDooONF4+EosWveA
         WmZZs3UV/LqzybcdccTmQuC+wbC3ENvOfQqlZqvCoxjxE3oqSh88WXF+S5ub/ed8j77x
         bFkg==
X-Gm-Message-State: AOUpUlE/VsUFWagha6HRI9du1Qf0AktGD0RT/uD5ElNFcYgBv6hX4LrE
        TEvTIQLCUh6/Cx52GYzQfN8bHzns
X-Google-Smtp-Source: AAOMgpe/WgjX6byHOTrqk5oYefp3x9pakcd+y911k+zAOEAoSH4TFvi08ABaYoVb7gZTtKONVMy8jQ==
X-Received: by 2002:adf:c44c:: with SMTP id a12-v6mr2744086wrg.20.1531420297345;
        Thu, 12 Jul 2018 11:31:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 5-v6sm9349711wmv.48.2018.07.12.11.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:31:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 21/25] t5000-t5999: fix broken &&-chains
References: <20180702002405.3042-1-sunshine@sunshineco.com>
        <20180702002405.3042-22-sunshine@sunshineco.com>
        <20180712123729.17861-1-szeder.dev@gmail.com>
        <CAPig+cRYNo_KL02LN1LOa79Zm2oYZqbnBHJ=KDA3oaF4pVfjcA@mail.gmail.com>
Date:   Thu, 12 Jul 2018 11:31:36 -0700
In-Reply-To: <CAPig+cRYNo_KL02LN1LOa79Zm2oYZqbnBHJ=KDA3oaF4pVfjcA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 12 Jul 2018 13:44:49 -0400")
Message-ID: <xmqqd0vsxq47.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jul 12, 2018 at 8:37 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
>> The change below should be squashed into this patch to fix a
>> previously unnoticed broken &&-chain.  I think you missed it, because
>> this test script is rather expensive and you didn't run it with
>> GIT_TEST_CLONE_2GB=YesPlease.
>>
>> diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
>> @@ -23,7 +23,7 @@ test_expect_success CLONE_2GB 'setup' '
>> -               echo "M 100644 :$i $i" >> commit
>> +               echo "M 100644 :$i $i" >> commit &&
>
> Thanks for finding this. I tried to get as much coverage as possible
> by installing packages I don't normally have installed (Apache, cvs,
> cvsps, Subversion, Perforce, etc.) and even temporarily modified a
> script or two to force it run ...

Thanks, both.  I think the &&-chain fix series is already large and
also otherwise seem to be pretty solid, so let's not reroll but
queue this addition on top.
