Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044F51F597
	for <e@80x24.org>; Tue, 24 Jul 2018 21:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbeGXW6V (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 18:58:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33419 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388488AbeGXW6V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 18:58:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so5514762wrp.0
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qab+Kfm5b42PvWaDrucMqc1uErqKGj5JzPNZ97qz3GY=;
        b=jkg6V+PYVkZk62qSv3fqEJnnzzRKyHkgHxTvQEyfHdhRfUdL2Y/s/WavQ64eYO6y7u
         5gOnUCbdr00YBFdsaLg7bicH/N8tPvXUIqwpatfKPrsceOrmoqhLTvVFK1diWsRcJA78
         ngz04Qpr5FW+4wh4gXz0AnSJsbv6yHpauRruzvYAyUhbFOYx5xJmvH089+r4gkWH4l7T
         A7wRaRuZ3Hqzn2nHKezlAHQ0IA4S5zft8OoPddmawUw0Y/VoDdMYUmuPJrz/gaHnNo1d
         VNcSNhx/zjvSeybTkVvK51Z4R2QClbRqsUcQXxIuaPRdImRev/iH1VDaebTU4vRGx72S
         DIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qab+Kfm5b42PvWaDrucMqc1uErqKGj5JzPNZ97qz3GY=;
        b=MaGDOJl75D8Ba0zE24sAs/ZFdP1duAOCTTdADVznZxCC5xp+YvXMbqTeJuZPozS+fb
         hyFau5sL2WmcroT5uiI8LNXTGxgtG7HsvEBOqLx3M/2pxRYIrT+g2WDf3rQm2BktBUQs
         rwyNDfeBQ5iVQEUrHNhNyKEwRp/g97rC24BwnkjwDz4mwVRu4pmAMeXhEZG6i7RpVkl5
         S9lkGnAqMcAiFiJekvaTnXolygzVtFpmJ3zVKe5mreJfwITBSZ18yxI02FhrGbB1xNji
         H0lmDhbJVoyLmKdUiV8uKGnao/ezOTDSMD/Yh5+kibIINyINfXBCXZJJJgdixVHXjK4a
         5v4A==
X-Gm-Message-State: AOUpUlF45IbXJNxkbmqKiWjlTugR6NhGhreFdS3uMocHbLcSi18BucKH
        2Vywa+EkImrucU9j6UA7HEk=
X-Google-Smtp-Source: AAOMgpe7IGCsS73Be/025d0zjIpC6nnlgM4heXBXKl05lfYfVsPRQpQf+IlXfY5phoDW54Dd0NoUGQ==
X-Received: by 2002:adf:c383:: with SMTP id p3-v6mr12843358wrf.68.1532468991493;
        Tue, 24 Jul 2018 14:49:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w9-v6sm19836180wrk.28.2018.07.24.14.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 14:49:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2] Add 'human' date format
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan>
        <alpine.LFD.2.21.999.1807071502260.18818@i7.lan>
Date:   Tue, 24 Jul 2018 14:49:49 -0700
In-Reply-To: <alpine.LFD.2.21.999.1807071502260.18818@i7.lan> (Linus
        Torvalds's message of "Sat, 7 Jul 2018 15:02:35 -0700 (PDT)")
Message-ID: <xmqqtvoowbgi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> This adds --date=human, which skips the timezone if it matches the
> current time-zone, and doesn't print the whole date if that matches (ie
> skip printing year for dates that are "this year", but also skip the
> whole date itself if it's in the last few days and we can just say what
> weekday it was).

The behavior of the code does not quite match my intuition, though.

    $ date ;# to show that I am in -0700 zone
    Tue Jul 24 14:42:09 PDT 2018
    $ git show -s pk/rebase-in-c | head -n 3
    commit d18b5221ba98fe8254c3f9922ba31b21d7c954af
    Author: Pratik Karki <predatoramigo@gmail.com>
    Date:   Sun Jul 8 23:46:04 2018 +0545
    $ git show --date=human -s pk/rebase-in-c | head -n 3
    commit d18b5221ba98fe8254c3f9922ba31b21d7c954af
    Author: Pratik Karki <predatoramigo@gmail.com>
    Date:   Sun Jul 8 23:46

It is sensible to omit the seconds; I do not really care about that
level of precision for an event that happened two weeks ago in a
different continent.

But lack of TZ does not give me enough hint about which content it
happened.  The fact that this was done late at night on weekend is
indeed interesting, and I may not care what time it locally was for
me, so perhaps this is an intended behaviour.

