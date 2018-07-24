Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874491F597
	for <e@80x24.org>; Tue, 24 Jul 2018 21:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388560AbeGXWVb (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 18:21:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42159 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388494AbeGXWVb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 18:21:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so5423746wrs.9
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Lc4AtqcuV8eoUhFKf+2UD665DBhl0coQXxqL6EYKs8s=;
        b=GithagpRyZSvwK8xuSLXYfkEAwhg23wy3oTiENXNzimxu50gknFWAmu7zmTmq1QGJp
         lmzWsKYZOSfkosPHB+BthMS5Ldobn0JRBSDpoYrvhSqyaijiX6CoPqkgYTRut1n46URm
         5Mnoj6CD55hw2xtOq9uxs0b3AlggJ2t3WfWfwQwuMxOuweKxkTm1HTU8/YaVk1GH0xUx
         JsyT4VNuoGdoNXS5uSVtIe930LoDl5j8k3bLZYTiCJKvAhcfqmNyVIhODLx9Ue7O54CR
         3BthFm2UlVzm9rHWXsafblIv7gD8KO+8k3YUUPalXA0XW2wWn3ifsdsOYYvZ7W6sxpnj
         K4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Lc4AtqcuV8eoUhFKf+2UD665DBhl0coQXxqL6EYKs8s=;
        b=I6TPEG3Wp2MZuiE+1GD/uR9aYhcBypLa1AwO+DWG+/K8N90Fl3wJOJBWXsVPvsAq9u
         9pNbNSWE5D0egkUHoaz8PM99VnTkHIUEFiS19YmiHw/WmdwOHwM8PWXHfggw2MPfL6CX
         +tPi2DEH8PJcuYe/7IbPHLkG4E6//9jpCEjXZtR24IpsfKFabY4lZdoaGEo9065D8EDg
         9ogwU+OB3/JwDcIKvieZvU0KJn3j/VVu0eq7G3+0qLbJQXFw5f/9m5tX3tkqlfTLuPgl
         7rhRworQnwopER6a6YaFd9b8ltE1hlaksGyPvGu4IrZza/QsgAFo7chIp6nN+3/CpWye
         PEzQ==
X-Gm-Message-State: AOUpUlEJyUh/5Sz5TBNLnadl2lU+Kqqu8ofG3BJarNOy/lRTAixvwL8U
        mxVEeS7ziISUBDKVTzX947I=
X-Google-Smtp-Source: AAOMgpc5TFvPVdYN71ondghT+ckAk4PCv6mklVidqB1GE68Q8kSSQS/YyuGbf/UiNlpqAlc7by9MZA==
X-Received: by 2002:adf:df07:: with SMTP id y7-v6mr11853068wrl.117.1532466788957;
        Tue, 24 Jul 2018 14:13:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z7-v6sm8927793wrh.85.2018.07.24.14.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 14:13:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Subject: Re: Hash algorithm analysis
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
        <20180609224913.GC38834@genre.crustytoothpaste.net>
        <20180611192942.GC20665@aiede.svl.corp.google.com>
        <20180720215220.GB18502@genre.crustytoothpaste.net>
        <20180724190136.GA5@0f3cdde9c159>
        <CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com>
Date:   Tue, 24 Jul 2018 14:13:07 -0700
In-Reply-To: <CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 24 Jul 2018 13:31:00 -0700")
Message-ID: <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jul 24, 2018 at 12:01 PM Edward Thomson
> <ethomson@edwardthomson.com> wrote:
>>
>> Switching gears, if I look at this from the perspective of the libgit2
>> project, I would also prefer SHA-256 or SHA3 over blake2b.  To support
>> blake2b, we'd have to include - and support - that code ourselves.  But
>> to support SHA-256, we would simply use the system's crypto libraries
>> that we already take a dependecy on (OpenSSL, mbedTLS, CryptoNG, or
>> SecureTransport).
>
> I think this is probably the single strongest argument for sha256.
> "It's just there".

Yup.  I actually was leaning toward saying "all of them are OK in
practice, so the person who is actually spear-heading the work gets
to choose", but if we picked SHA-256 now, that would not be a choice
that Brian has to later justify for choosing against everybody
else's wishes, which makes it the best choice ;-)

