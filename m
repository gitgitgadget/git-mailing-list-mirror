Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DAF620248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfCCBV7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:21:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38053 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCCBV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:21:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id g12so1707808wrm.5
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=SlgfUuhUze+MiM8lwVLWHWsZeK7t0lsgknM0JVlrQZc=;
        b=oDrlWl99kJQYp34p7xXby5Kn2EYLXpwXXNUsnM5eN6k5fn3icZS924vGG2NbBE504C
         pfilB45jqIO1bb788EGa/yCr9QMD5QtkFHqjFDLwIfuxsOS5qbJ3+xsgsrqpL/ZDX3BL
         /O+fO1JlsQXLQTNQsHr5tAR/y0qwpjC5WCe3VfOQEhb8Wdq/T1Vav/bw46uUuIE0NdZ5
         H4VYi282Op1gtG7PH/bNpDez/r6RwnNte8G3eTVSR6zAuBVFt9QJOpGURxqaE8tU9FK/
         /bidH5p4n+mV39Xef49E2iwBULuW7KW+9QfwMVPLjJAp5DOQkXZvLCTMwAWixSPm7L6K
         zOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=SlgfUuhUze+MiM8lwVLWHWsZeK7t0lsgknM0JVlrQZc=;
        b=dPK7fheus7kLnR4EDXnVMa3i5LP6nFf2eahoyPLzHn+727pDt36jFqZkYEutcUpv2P
         BCn36hQOSa3uZIRGN4mh20zX6tCrTwTdn/Wvzux2z2e80mSt3qrVkeHPlnk7DRjmev5z
         v87ag0OyzYGPEYaDGr975W3bjW+39C6yjoBa/z5nc5TQeekypViQuWVnzeMrb1O4blRh
         wNoWijX4yhFKvDX0nd4EjFxpD/BWLZkEU00Ro3LgYGlPAvuHe4wXllmibutwMFbVrC8l
         FuChJFgmXQ9F/KeLLwN90AAlzUOzQyPwrbSqdhLp1xUX/edG9w+m6V71RHMzHhpmOCcx
         4mcQ==
X-Gm-Message-State: APjAAAWG4HnDP4kbyuhxbRWnIUdovGuaieFTgrTMP2udj+lB1Z7l6tpU
        llzOMgRsYcKYzWo6ODGhg8s=
X-Google-Smtp-Source: APXvYqxMx03SvBsS4nzOpZmXU+/jkIfzXnr3l8As8ca1PEwcUVcmYBG5l5esM1uKaclgMvOnYEMdNA==
X-Received: by 2002:adf:dd12:: with SMTP id a18mr7580167wrm.4.1551576117224;
        Sat, 02 Mar 2019 17:21:57 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a22sm1778098wmj.35.2019.03.02.17.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:21:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH RFC 0/20] cat-file: start using formatting logic from ref-filter
References: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
        <20190228214314.GL12723@sigill.intra.peff.net>
Date:   Sun, 03 Mar 2019 10:21:56 +0900
Message-ID: <xmqqtvgk4urv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Feb 22, 2019 at 06:50:06PM +0300, Olga Telezhnaya wrote:
>
>> In my opinion, it still has some issues. I mentioned all of them in
>> TODOs in comments. All of them considered to be separate tasks for
>> other patches. Some of them sound easy and could be great tasks for
>> newbies.
>
> One other thing I forgot to mention: your patches ended up on the list
> in jumbled order. How do you send them? Usually `send-email` would add 1
> second to the timestamp of each, so that threading mail readers sort
> them as you'd expect (even if they arrive out of order due to the
> vagaries of SMTP servers).

Yes, the 1 second increment has served us so well in the entire life
of this project, and I am finding a bit irritating that we seem to
be seeing topics that are shown in jumbled order more often.  I'd love
to see why and get them fixed at the source eventually.

