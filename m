Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC6911F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 17:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbeGLRkP (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 13:40:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36690 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeGLRkP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 13:40:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so22519014wro.3
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NR8MuuynIH36u8Jm3SuuVS1jdU/v/N1tyzY8ma3isjA=;
        b=VrBQRd6IBJ2gzUJXkHub9+hkp0EXd4dFx6UPk0fiuUi9M+w49h2V795HMC/d7u2lFE
         YWPbhW+VIGwdX1Yx78BXVB78xpio4mK6oNEcTuGmpltyM6vU/8ytbiVblwO71OqaPz8g
         0niQWPQn4uJgFB6rZIpX+raiEFhBmt53aPPw7FTHwOiq9dL+LtLbtJr34yIAoKMnqH2x
         PqANfZWTzFZtmZFNS5pShD7LTQXWn/iO1lZuBbjbMASNAaFNeN/fDoK8pVrAwu3SRAgL
         OwI1/UPIjpcDmuCxeo3banxZG3Po6aKbYCTAIQ/YmucDNdO/zNmBDKBlu9XrcdM1WS2U
         Snuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=NR8MuuynIH36u8Jm3SuuVS1jdU/v/N1tyzY8ma3isjA=;
        b=jRGcve8kjVbNnIKqnn/e7ukecASmb+yYylv7+TMNANzTfsRQwSpWTW7a4MmCvmQXBf
         ChEuWP3sijdip1YlxcXVcbbqqOxopUP7C/2pS/0ifoaMFcTp8r5dxdHuNixj7uX1OLES
         LUFTkM7UWUqlZatvDYeK6pvY+Ls/nTVWJR8Oc6kvemw5IQmn/xr8pJUM7ho4FhaXDGa7
         WoRVYBlW2PAXpSn1POWw8wJ5qWbkWbRgr061WkREbRVkQqkCv9HEaXbwDfqiYj0zGotc
         F7DM+K/07DGDUJ0GjogcL6m91ZHRXUyCzNA0yyElmcp0WaIijnwXq2x6vF7zDhSLzO83
         gFYQ==
X-Gm-Message-State: AOUpUlGPbBFBD0CYlE+YMo3q2crF7hY5lBoQJooxiyGvgoO8UBzAlnWY
        Gsku2b7BUaFXpYwE1chsGMA=
X-Google-Smtp-Source: AAOMgpe57nJXhWd0JTejbbe/qmEiOByOFRkSlrNmyM+vDobBD7FaeOtimQMjFyMK6kM5d5762O/xoQ==
X-Received: by 2002:adf:f485:: with SMTP id l5-v6mr2552599wro.259.1531416582315;
        Thu, 12 Jul 2018 10:29:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e12-v6sm16393754wrt.29.2018.07.12.10.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 10:29:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 16/24] config: create core.multiPackIndex setting
References: <20180625143434.89044-1-dstolee@microsoft.com>
        <20180706005321.124643-1-dstolee@microsoft.com>
        <20180706005321.124643-17-dstolee@microsoft.com>
        <20180711094858.3230-1-szeder.dev@gmail.com>
        <dd2f774d-a217-0273-efbe-d133ae23c5bc@gmail.com>
        <CAM0VKjkuC5Qc6HtQZP4dpHE4CcCvNkg1D8_AFw7+PQDU6bU5Wg@mail.gmail.com>
Date:   Thu, 12 Jul 2018 10:29:41 -0700
In-Reply-To: <CAM0VKjkuC5Qc6HtQZP4dpHE4CcCvNkg1D8_AFw7+PQDU6bU5Wg@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 12 Jul 2018 15:31:13
 +0200")
Message-ID: <xmqqsh4oxsze.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> Thanks for this point. It seems to work using
>> "link:technical/multi-pack-index[1]", which is what I'll use in the next
>> version.
>
> It doesn't work, it merely works around the build failure.

Sorry. I fell into the same trap X-<.

link:techincal/multi-pack-index.html[the technical documentation
for it]

or something like that, perhaps.
