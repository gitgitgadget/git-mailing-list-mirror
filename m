Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6C71F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 06:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeJKNuD (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 09:50:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50816 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeJKNuD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 09:50:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id i8-v6so7665595wmg.0
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 23:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hobnQp6sCLMU6YQXei5IiwUNduLA3q4Krv8eWyrIpKI=;
        b=fI+nKlELrioGPJY44Ik2Fuma872e6IEupP2tYi0Pos0hgH7TJZ9dRsELz5NzhbqmbI
         IzXSvbR6G3l54zcxxZanPq78EVmxMcvqs7/x8V62foD4d939BT5mNgUew5jHPfIpzqr6
         er27YUz1kJVprWmQJv4CzepTqtuD/lAocAtjcZRuJbqnZDPQX499GzW4ltw1sTOyZ1kI
         AQ6+jdkTZT71bWwgujZPZK3c7yxuDPcI5bmKKD+mUqyFbgnmO15pERgONN9/fF+SZ2Yi
         zmOpIWoUZRTOAwT5DRbtprCymTRw+KXRV2loUWVD3LADeMVPeLP3gk1HYbOBZuyDC/Uq
         90eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hobnQp6sCLMU6YQXei5IiwUNduLA3q4Krv8eWyrIpKI=;
        b=mgDZeZ3AJx8U4HcwDAvRb4tJaXZ2nSk3AEeZioGM0wm0MTHegNTp8vryzs0x01AGxZ
         DWoRauivUZ4EIcwnnEp262mOtyePAZJPGWCx735VC4DjMJMeQldqumZ5XoHOyCNo7Eqn
         ltJTrnj58uNG2BDYH3+78HOVKh+uT5OZDnnOUTEYL5x4BeBX/o9CvhzHm8j6x3rwWRIf
         tAZW83d4uGQ0vZlkdrLBZu56Dbt0vDWVlifjItT0j+wUIzdH3rYZA9yFHimnqs1MFAeX
         ivHsJXznVLfZAGogxc9lmEK3vl5Q0B0SFrRQBhwWDNQXEaISNAob7E1xAns4VCswSdP9
         yJ2Q==
X-Gm-Message-State: ABuFfoizWY4w0y+zCMho+iSejSZN259POPoyMWmFZYGNO1sHfv9oPvSv
        eYxRhmsb3NYUVLLoYlfcIxY=
X-Google-Smtp-Source: ACcGV61AlqqM0qVEgvGa4Jhby62Cu2Za3KIersPkecVSMJY7sn20V7ufYSj7YZq87hyL/N0PJSilbA==
X-Received: by 2002:a1c:c683:: with SMTP id w125-v6mr449282wmf.117.1539239055069;
        Wed, 10 Oct 2018 23:24:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j46-v6sm41289483wre.91.2018.10.10.23.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 23:24:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] mingw: bump the minimum Windows version to Vista
References: <pull.44.git.gitgitgadget@gmail.com>
        <2b127d9669aa7b73ced7611b6e77044f5efed11d.1538595818.git.gitgitgadget@gmail.com>
        <87zhvlevxt.fsf@evledraar.gmail.com>
Date:   Thu, 11 Oct 2018 15:24:13 +0900
In-Reply-To: <87zhvlevxt.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 10 Oct 2018 16:08:14 +0200")
Message-ID: <xmqq8t35gfw2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> It also means that we no longer need the inet_pton() and inet_ntop()
>> emulation, which is nice.
>
> Earlier in this series you add a:
>
> #if defined(_WIN32_WINNT) && _WIN32_WINNT >= 0x600
> ...
> #endif
>
> Shouldn't that now be something like:
>
> #if defined(_WIN32_WINNT)
> #if _WIN32_WINNT >= 0x600
> ...
> #else
> #error "You need at least Windows Vista to build Git!"
> #endif
> #endif
>
> Or do we catch users building on non-supported versions earlier somehow
> (i.e. not just with a flood of compilation errors).

That sounds like a reasonable thing to be curious about.

> Both of the above are just questions I was curious about since I saw
> your <nycvar.QRO.7.76.6.1810101502220.2034@tvgsbejvaqbjf.bet>, and
> shouldn't bee seen as bumping this to "this needs a re-roll" or it
> should be delayed in getting to master.
