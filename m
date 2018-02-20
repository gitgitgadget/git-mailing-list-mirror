Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA57B1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 19:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbeBTTTE (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 14:19:04 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:45206 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeBTTTE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 14:19:04 -0500
Received: by mail-wr0-f174.google.com with SMTP id p104so16186095wrc.12
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 11:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=In0XuSK8XbRfvanv348DCiNrQ3ET/4rQG024wj09/Go=;
        b=NZ3TY2+NA0mzE0OSDflJLAmfuHJ2AZlt8/URL4xyIFS3A5nwQf4hYB4fTzOoSGRD9k
         DMw7LdezbHvs9QvbSCWfMqXMdku65EliCSv6GkYDrpmwLonrtitUh+QLAzglChaK1Sa2
         FCWGBcj8rySIwcFpTmYjXrH9Z6LfNzuQtr4QuX0Je5J+ds7AJMU6PgBTWRKbySwP24lR
         5Lv4t3jm8DXhpZi0pmftC6WWCDsDYhTShlBJstBAbJQcmK0XMpjzYDESI7g6YnsXibwr
         epPVIr2aMjsfzFQz8qBBFFogItRqfXVud3TadbIS6saQd6GxZ+YqA3nZkyVOQFMGZzDk
         fjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=In0XuSK8XbRfvanv348DCiNrQ3ET/4rQG024wj09/Go=;
        b=PXBGb3vLYg+2kJ03ExYouuc2/UZKBPRiTf1AKTs1wqv0ulXwVOs0+n3WLDBI1QXTKb
         UpUBCK02KtHtvFDFTW7VOZOdk1c9thRirz1FO5YC5uDxLPjnfIBzPFPGmi0m4vHGcogB
         csqICgO/RGWK4yDFPUvU0iftfsc+PGjqyTsJnGLwmg8cy0aOMbakcnAvj9mpyAQ5slmt
         cWbkR+wU3u0SmzVM5VsJ7GQkIIhFzAZQM01IBJ/1F/8As2asqIy0QdZzHD+CoDj/aBMS
         G+s2hXWWi+LWOEh5XlffzkHQYVdSacI488eFpu5MB1NBfFcLp22+eNW9c1KKMm/kN7Jx
         JK/A==
X-Gm-Message-State: APf1xPA+Vzd40w6RVOEgEzlBO8rDAlS9CJ9oM5Uq0VLAa+NtrkM/Opgv
        /xWg2s7Z60Fxp/d1HQs4bCc=
X-Google-Smtp-Source: AH8x227xyyW5dcbEGhJMvaK34HDseG+fCHEb9NRtYr4KjjfXUM0w76ZfJV1M2R4+YvJST92r9H1mSg==
X-Received: by 10.28.65.213 with SMTP id o204mr53054wma.97.1519154342418;
        Tue, 20 Feb 2018 11:19:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n49sm2980447wrn.90.2018.02.20.11.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 11:19:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Herv=C3=A9?= Beraud <herveberaud.pro@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] make hg-to-git compatible with python2.x and 3.x
References: <01020161992fe7ce-b41bf370-1480-4efe-8980-0c52fb9b9be5-000000@eu-west-1.amazonses.com>
        <01020161b421939a-4ad52aaa-dda8-4250-9bce-71f0ede1a199-000000@eu-west-1.amazonses.com>
        <xmqqwoz7324d.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 20 Feb 2018 11:19:01 -0800
In-Reply-To: <xmqqwoz7324d.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 20 Feb 2018 11:14:10 -0800")
Message-ID: <xmqqsh9v31wa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>     - map(lambda ..., collection) is not liked; use list comprehension.
> ...
> I am not sure about the change from map(lambda ...) to list
> comprehension, though.  Not that I have a preference for or against
> (I am not a Python person), but I do not know if this is a change
> necessary to run with Python 3 or if it is merely more preferred to
> use list comprehension.
> ...
>> -    prnts = map(lambda x: x[:x.find(':')], prnts)
>> +    prnts = [x[:x.find(':')] for x in prnts]

Well, I should have dug this myself a bit more [*1*] before hitting
[SEND].  This change is required because map() no longer returns a
list.  So the bullet item in the proposed commit log message in my
earlier message should be updated to say that instead--it was unclear
to me so I phrased as if it was a mere preference, but it actually
is a required change.


[Footnote]

*1* Well, it would have been ideal if the original patch had enough
    information from the beginning to make this kind of "digging"
    unnecessary ;-)




