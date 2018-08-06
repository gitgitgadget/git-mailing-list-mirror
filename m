Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B25208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbeHFUBu (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 16:01:50 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40814 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732511AbeHFUBu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 16:01:50 -0400
Received: by mail-wr1-f54.google.com with SMTP id h15-v6so13181572wrs.7
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jJAbbxvIrS2nIQLZGIbWGdaDFDw1TNfQ/u22KDTdU68=;
        b=FGjxDsr4TQoVkxFH4K4WgSlVO3eTIgCCta8oUPhdQ6zVvgRlWPjfFCfR2GvtG086ZF
         UEUfbdtg0hZtlD923zidPzNHgz2eD0KAZ6/Hf8JMINUPFvWXae5uSDkbsubHtxk5WaVd
         ubO8uoeNqmIjHANzuP1oCA93Ow/CgXgKdI9TnN16FMPQ3J0D+Sju7aa+S52hm2f4n+Hm
         amLU5eaPAj1qkmmLv6Li//aPcwiu9DA9bONjjcE+4w+4q6NoyDNrwk95OILx0LV5jZGq
         iqNvPtWyKrzSFKYDIlmnIqCDD1Dj/bYxz0zBlUHuIOI+QxqChG4BFcq9GbmrdC/jcd7U
         ZYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jJAbbxvIrS2nIQLZGIbWGdaDFDw1TNfQ/u22KDTdU68=;
        b=h6xcHJqn/alkUyyO6niyfaL0VwPughvrK0zg/a7zV9pnbVS3ynWMJeYbMgXRdQcQAb
         3ouXpywUtzQZHtXvHEP2F6tW4rYWbrhSsij2HAfBHAlJu0EZoidbA8xvg7J2B/VUB2Yp
         iP60bGZ5qQ0QSu7+WCxkThHTuDUdjGWulqw/eCu/qv+7yjQs/ToCTWx27q7ZLtvOJTkG
         uqUcGidTVTqCESyZneonmzQuovn1ciber8SiYESuMdZJlQyZxszjI3JolgDst7mTF1wU
         uSWK/JPuZOu1YYcQZ+UfBwLy5zQjBqVr/MuTzToPfTOvSC0od79Uz7/Qq4y9p231BdgX
         QfwA==
X-Gm-Message-State: AOUpUlEAsrW54V4/HZpDnAzawMgqHszildBbbyjE0QJTSSnb/y6mrElN
        ni+dwd8uRL8bDoHA7PFpCpId+jvO
X-Google-Smtp-Source: AAOMgpfnjhJvZGOlBmvzd2Cz9UmKz4732BxvXwc2BJ3BvNbL0ghellYNhgp5ohQbB3GVkbfemwdyNQ==
X-Received: by 2002:a5d:5349:: with SMTP id t9-v6mr10010132wrv.186.1533577898686;
        Mon, 06 Aug 2018 10:51:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 200-v6sm14956896wmv.6.2018.08.06.10.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 10:51:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrn@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] sideband: highlight keywords in remote sideband output
References: <20180806143313.104495-1-hanwen@google.com>
        <20180806143313.104495-3-hanwen@google.com>
        <xmqqbmafpg14.fsf@gitster-ct.c.googlers.com>
        <CAFQ2z_Nrj5WhzYsxr6P5qLJ3pDVFzB4UDb9g4P-5U99wrAuB0w@mail.gmail.com>
Date:   Mon, 06 Aug 2018 10:51:37 -0700
In-Reply-To: <CAFQ2z_Nrj5WhzYsxr6P5qLJ3pDVFzB4UDb9g4P-5U99wrAuB0w@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 6 Aug 2018 19:42:05 +0200")
Message-ID: <xmqq36vrpemu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> I think the code is OK without any assert() or BUG(), and that is
>> because the design is "we just paint the keyword at the beginning of
>> what the other side of the sideband wants us to show as a single
>> unit".  If the other side sends a payload with an embedded LF in a
>> single packet, that's their choice and we are free not to paint the
>> beginning of the second line after that LF.  So from that point of
>> view, perhaps we shouldn't even talk about "a single line only".
>
> I don't understand this remark. Isn't the call to strpbrk() meant to
> split the input on line endings?

Yes, but that happens only for band #2 and not band #3, to which
this coloring also applies if I am reading your changes correctly.

And I still think not splitting band #3 packet into lines and
painting only the beginning of the first line is perfectly OK.

>> >  #define ANSI_SUFFIX "\033[K"
>> > -#define DUMB_SUFFIX "        "
>> > +#define DUMB_SUFFIX "             "
>> >
>>
>> Was this change intended and if so for what purpose?  I can drop
>> this hunk if this is a mere finger-slip without proofreading, but I
>> do not want to do so without making sure I am not missing anything
>> and not discarding a meaningful change.
>
> This was my poor use of the tabify function.

OK, so I can drop this hunk---eh, perhaps v6 won't have it so I
won't have to worry about it ;-)

Thanks.
