Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A52C1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 16:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeHCSh1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 14:37:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32790 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCSh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 14:37:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id r24-v6so5424103wmh.0
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sQcop+bfD1JVDPgh4xGFWu9TindJ/NqTHMxpXnbAJQg=;
        b=cMPtfb4PNZq/rthrBZCpShDJv9XABDCXd8JN3GcpJ70hJ/BtTfeDymVbtiiEXRGyyJ
         SICFR52cbFORY6bAxwPyKhMonyZVv+ehCWB+dqalc9wK6Nx/o/SSQK/v+6vTjdo70znt
         vz+4Y/zx1tputrvhUoRYPLNF10IX0JJf/2BANp+4/vZntBvS2AcAp+MkeTmFMbe25PMk
         ZXLIo05YTM5kyFMi4gpmh/IntCFx4O1K7f8aQGvU9dfPJ+gKhzs/mGchP6CjtCNjIpUA
         gD5y7OcCLZfWh/ynGgLORwr02vTgYAaozJ+13GVAUPw9DklTmK9j6mjarT5WxJMhutUn
         JBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sQcop+bfD1JVDPgh4xGFWu9TindJ/NqTHMxpXnbAJQg=;
        b=pLXJnMo+VqIhloKkXmGop46v5E3KKt/uuIE3tMA5ynhxR6cOeG4Py+iOG8rPrYl8Fc
         jJcvfmGknDC6IAUZCxaCIgWiMgSnJHasIiPoUgUIfB3EwLX1Uiahlun+Yjm5haJVLppe
         BeWA/qKgRnp4OhTBRy1aH6hjXIqGH/S99j9NRQEYWkFNreY2RGOwre8sx6V+rrqpIs37
         yGpakamMQQp3vJnGdXS90GZ/1kkBmZeBsusgHqmGFBwYS9LaOUwXPl4QspKmZoAVPRaC
         cDYA28oz2XBFlwQWbyCvzZa0DHO7sedHvrDdPROH/p7N6nyPr9csrkqEnOiIquzK7V0Q
         I81Q==
X-Gm-Message-State: AOUpUlEPq8KdubMxracZS5I5Hg0OmKQKGXO0bLxl+q3c3+V9LXV4Hu7+
        TVRFr8vfqqsav+x086LEStE=
X-Google-Smtp-Source: AAOMgpdkACXtvX9+fQotZpitdZxs3MzXktitoyRM9dUAi58ieGILM9kEtS0TF19ey76j/aSBpCc+lw==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11-v6mr5379181wmc.107.1533314422864;
        Fri, 03 Aug 2018 09:40:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 200-v6sm5008573wmv.6.2018.08.03.09.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 09:40:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Subject: Re: [PATCH v2 2/2] doc hash-function-transition: pick SHA-256 as NewHash
References: <xmqqin53t30d.fsf@gitster-ct.c.googlers.com>
        <20180726134111.17623-1-avarab@gmail.com>
        <20180803072014.GA256410@aiede.svl.corp.google.com>
Date:   Fri, 03 Aug 2018 09:40:21 -0700
In-Reply-To: <20180803072014.GA256410@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 3 Aug 2018 00:20:14 -0700")
Message-ID: <xmqq600rz9my.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sorry for the slow review.  I finally got a chance to look this over
> again.
>
> My main nits are about the commit message: I think it still focuses
> too much on the process instead of the usual "knowing what I know now,
> here's the clearest explanation for why we need this patch" approach.
> I can send a patch illustrating what I mean tomorrow morning.

I'll turn 'Will merge to next' to 'Hold' for now.

>>  Object format
>>  ~~~~~~~~~~~~~
>>  The content as a byte sequence of a tag, commit, or tree object named
>> -by sha1 and newhash differ because an object named by newhash-name refers to
>> +by sha1 and sha256 differ because an object named by sha256-name refers to
>
> Not about this patch: this should say SHA-1 and SHA-256, I think.
> Leaving it as is in this patch as you did is the right thing.

Perhaps deserves a "NEEDSWORK" comment, though.

> [...]
>> @@ -255,10 +252,10 @@ network byte order):
>>    up to and not including the table of CRC32 values.
>>  - Zero or more NUL bytes.
>>  - The trailer consists of the following:
>> -  - A copy of the 20-byte NewHash checksum at the end of the
>> +  - A copy of the 20-byte SHA-256 checksum at the end of the
>
> Not about this patch: a SHA-256 is 32 bytes.  Leaving that for a
> separate patch as you did is the right thing, though.
>
> [...]
>> -  - 20-byte NewHash checksum of all of the above.
>> +  - 20-byte SHA-256 checksum of all of the above.
>
> Likewise.

Hmph, I've always assumed since NewHash plan was written that this
part was not about tamper resistance but was about bit-flipping
detection and it was deliberate to stick to 20-byte sum, truncating
as necessary.

It definitely is a good idea to leave it for a separate patch to
update this part.

Thanks.
