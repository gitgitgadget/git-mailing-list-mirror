Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94F201F404
	for <e@80x24.org>; Fri,  9 Feb 2018 22:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeBIWul (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 17:50:41 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36135 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbeBIWuk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 17:50:40 -0500
Received: by mail-wm0-f66.google.com with SMTP id f3so183421wmc.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 14:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CiIwnE1nvD7aKih8nmqWWH9kEyKgP6Lx2pD3H2VaguU=;
        b=W7fGRlAN4SijZXz1ozWSu6fLMhcPA3kEEWaYHkhCdUJdVxj3ZwPc26aHKjHLUOPcD2
         QzlZCeBuD6LU+Dqhz4Jw6+dQsQmmQU33QaC8xuHbf4XmuTxGLV4m1GhInBzk89sVY6b8
         spFMQGKkaZ2GHlPnO5UTwT5Yosdqr9Z3ZLKNEI59miH9sDGSh/6zjw7Os7gqEWNW3/+3
         kf2+rPhJUMG6x10W0Z+sn1eW88gNd+k8QWc8V87RCypOx3lTRWA9Nul9HwO2+THNI67N
         z49xSg9Idqa9za+N2CTJ7n9fo9JYGwo2a42g9ET/n3uPjTEGM9fJwsdpznZvQxF31NGA
         yZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CiIwnE1nvD7aKih8nmqWWH9kEyKgP6Lx2pD3H2VaguU=;
        b=McNQdkmlpC3wSamwzZUpOmDhtofa3OBr2KbeL54LaQQ5/huNdCFljCSm7fH2OSkMqD
         Mdd7vMGhn2euVq6miDhsYHVmMJvk5czdshfd94lE5M8650YiK6F4zU5lFLcLFZDRq6o6
         +Xp5wL3f2WcrPoM8Mq+0oDKZyNGE/6o0UkOec3Xfrk/jKkz45O/CaR3/TG3VlHs2yN+s
         ZKxuNg1o6tu/K37wxUeNdNCuTQjscDBoK5zlpb1H8cPnr7qTgYfFzCmdgt/DxWJCE8oq
         mHVAZylxQm3Oi7V6BqOnyB+aHllPl/hvaElmBM4DYV63O4XGJmro+/rUFMkFOxKTZYhA
         NE0g==
X-Gm-Message-State: APf1xPB3vn2LvAQhgmmUKBFMR91beFmK/tT3jb81b3MvcLudGAfw+00W
        XkUnPYz8Bp6MdcvVH3xJuD8=
X-Google-Smtp-Source: AH8x224UID6oxYYK+ovtg9X7SGxMdRzGdtnJS2k2W/St3szuvB8zHmwgO7A1UjcevY5rDkQatEg3bQ==
X-Received: by 10.28.112.15 with SMTP id l15mr3222114wmc.119.1518216639114;
        Fri, 09 Feb 2018 14:50:39 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 1sm4525197wru.19.2018.02.09.14.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 14:50:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] update-index doc: note a fixed bug in the untracked cache
References: <20180209210431.409-1-avarab@gmail.com>
        <xmqq6076xabo.fsf@gitster-ct.c.googlers.com>
        <20180209210431.409-2-avarab@gmail.com>
        <xmqqwozlvnij.fsf@gitster-ct.c.googlers.com>
        <87mv0hbykc.fsf@evledraar.gmail.com>
Date:   Fri, 09 Feb 2018 14:50:37 -0800
In-Reply-To: <87mv0hbykc.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 09 Feb 2018 23:14:27 +0100")
Message-ID: <xmqq8tc1vkua.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> Will queue with the above typofix, together with the other one.  I
>> am not sure if we want to say "Before 2.17", though.
>
> I'm just keeping in mind the user who later on upgrades git from say
> 2.14 to 2.18 or something, and is able to find in the docs when/why this
> new warning got added, which helps diagnose it.

Ah, no, that is not what I meant.  I just didn't think '2.17' in
that sentence may not be understood as "Git version 2.17" by most
readers.
