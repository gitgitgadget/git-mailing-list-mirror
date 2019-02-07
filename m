Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088971F453
	for <e@80x24.org>; Thu,  7 Feb 2019 23:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfBGXbc (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 18:31:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38716 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGXbc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 18:31:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so1636100wmh.3
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=La45iX4XanUnl5oGacKAXZ691AxOj9Cj3gpQpM7Dsbk=;
        b=QG+QxBeu5yDXXUzyf3izDQtQRoSD4GSoGzxovpjr6DZuR8UoNoWfuApGOt6pp6qVm8
         fJCzhsajO4PAx1WRLwQ4/eUKtn9GDOAEOy2cnw2B/D3HFeO2C2/AJdJVzbA+JwUla5eF
         OgOn4vTOeFvoJZVsmmYEgRkaT78ZzLzZKVKepg8jzP9us1RLeBgDv89Z2lJ/74p52jkc
         Cq/NgZGsYRqPA6vIX4dga4Fxq/OgcxKJ7WLn770FwpBc4LhF4H/YFW67P5YTojOlEzp7
         DZVDnWRaR8DfCqgBC+MuZIusjSgLSV2a9wX0pByKY8qFE3qMUebJhbvEv7uLau/L00Gy
         BFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=La45iX4XanUnl5oGacKAXZ691AxOj9Cj3gpQpM7Dsbk=;
        b=aeMuHSSdprrwtaxnBb7w5LUp1AqxH1kx/nNh4OLQKLkOxssr2yJKDCygVxTMlcVbAm
         6OgnBg9Y1KRMqqpT26p6m9OhA7Do7vKKy+2NpM7LgtIbiHipj8voKYMzxntecxU/rIwn
         ZqlDZgOuNgoF+BObZbbWtsB/JunnIAns5GLm+fpztSimfLPas1IXqs9ND+vmSQvVqRda
         AmgmZHHYIp7qVdIcIhXIUE55eA8zdR33QVdM/aB2g2a4pCSc6ruH6pfYPJgEQdQKx7pe
         uJf5iFUAco+dDUQmLWt8Om2a1L3sjNzufE+hXbhCPM/fnI3GQI/mCfGWIv4IEuY6aORv
         3wsQ==
X-Gm-Message-State: AHQUAub/lslYTRl1v/NQngsm5NqCRXaA8rba36+WRURfc1OO7T8y7RlN
        T9oBZ5Kz7jysk9xPdQZgX/g=
X-Google-Smtp-Source: AHgI3IakiQt8S8jn6/fmpTQ5GTk5IoU9xOIWTgmjolu93SpTjtHN7zKG9PKPHflGrOhPg5pFeIjzUg==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr9045711wmf.105.1549582289558;
        Thu, 07 Feb 2019 15:31:29 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d9sm371699wrn.72.2019.02.07.15.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 15:31:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
References: <20190126221811.20241-1-newren@gmail.com>
        <20190204200754.16413-1-newren@gmail.com>
        <xmqqlg2vtfmo.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGyL5BAejK-P-EdscFdH3C6uR7e6CbgNe-9doy-mkw-vg@mail.gmail.com>
        <xmqqa7jarmvo.fsf@gitster-ct.c.googlers.com>
        <CABPp-BG4WftXZgbzN48zSo1Z5BcWYjdbz+8hGSGBNJbSsYUzAA@mail.gmail.com>
        <xmqqimxvny6s.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHyLFNcdh+=hf=R5xhUoNAQHPophxgc5e2HRqgeTU4e8Q@mail.gmail.com>
Date:   Thu, 07 Feb 2019 15:31:28 -0800
In-Reply-To: <CABPp-BHyLFNcdh+=hf=R5xhUoNAQHPophxgc5e2HRqgeTU4e8Q@mail.gmail.com>
        (Elijah Newren's message of "Thu, 7 Feb 2019 14:10:26 -0800")
Message-ID: <xmqqlg2rmazz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Now, the question: In addition to the two "from" headers, how many
> "to" headers do we emit?  In particular, do we emit both a "copied to
> F" and a "renamed to F" header, or just a combined "renamed/copied to
> F" header?

There is only a single path that can be on the "to", as there is
only one final result, but _how_ the contents got to that path would
be different, so to be technically truly correct, you would end up
showing N "to" lines for a N-way merge, each of which gives the same
path in the postimage, but some may say renamed, another may say
copioed and some others may need to say in-place edited.

That would increase the number of necessary lines from N (from) + 1
(to) to N*2 (N for each of from and to), which makes it even less
economical.

And showing a single "renamed/copied" feels more like a cop-out to
avoid being techincally incorrect, than giving a useful piece of
information to the users.

I am inclined to say that we should do _without_ any "to" line.  And
if we can do without any "to", perhaps we do not need "from", either.

