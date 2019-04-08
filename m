Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BFEB20248
	for <e@80x24.org>; Mon,  8 Apr 2019 05:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfDHFNV (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 01:13:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43973 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfDHFNU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 01:13:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so14618927wrx.10
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 22:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uw5DdwGxw3jbJG0KlQAeWM6Sxpm0MGr8FFQ7UEfoiWM=;
        b=WWjFzIjBj8cSdIOS20xZwdoZ7R/nzr1kSQZ9BybJRGizukO8xOkYrlqA0FYQDTs8wN
         B0tqdTou51flhZYh2fTcf3btbSb4/Z3seHFZFPS05221pp1/PTbphRUgpWLghvNWA9iX
         3LYfLOaRih1dy6aqQS/K3jxeSe6opQyYtihCXwbwZo9Wc3u+2liQ5roeVbCTSvjXptxi
         ZUnyhHBvKiW8pYrzU4F2HGX0lA8mK3mwdN6DplWyOior/EdxCDPDSy44DikAb9TYhOPs
         V0H8LyPHyEhug0YdZhEPtG3tzaCSLD9L/C/xeAqSKBE3e61xj8PkJk6nsoqQL4eEKecK
         n3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uw5DdwGxw3jbJG0KlQAeWM6Sxpm0MGr8FFQ7UEfoiWM=;
        b=t+TQMfmTdIhOEL3q2QW4nAjYur6LTY57a1JSvzA+IOHAaiZe/Lg332Y0q+36taqUv4
         bPrUzg5FyOlS3zLRekYHPXDpwQTBJcdp6vEHZTeKSVM/ejghf1FcTRFLK/afjB+Xjt8F
         sczYWHyTT67xDLwrMes/xtiDGThSW1aOobIKbJNWiemTmRwfgjXMHrZ+Jtvasc1SFw9v
         8OSlZyEFf/tDWZd/Zv6WpxtK5WJ7m4JsYv91QyaiBtHvzz0Fg15IOMYT6DmFzILe9E6z
         y9voHyDww7YHhUx4Km25TzDZ8UT6CL8luEg+lQ8wuuWvm2DA/8DZXfOMxGwssBpaD4pi
         S8ag==
X-Gm-Message-State: APjAAAWKZavNciHkg+BxRetrg+L43K5fjgH245YeVmMQm5JnK0XNtJti
        LgOidJwhtLmqvj1g25TXcv8=
X-Google-Smtp-Source: APXvYqzwuWI1+yE01UrdNSZiKH7M6bDwkSJZLr2V9bk++rV9CRrZKLvt35VfWz4aUn8WKVgwmwZUUg==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr13744934wrw.62.1554700398964;
        Sun, 07 Apr 2019 22:13:18 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j3sm68969479wre.51.2019.04.07.22.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 22:13:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 01/13] packfile.h: drop extern from function declarations
References: <20190405180306.GA21113@sigill.intra.peff.net>
        <20190405180340.GA32243@sigill.intra.peff.net>
        <c21b923f-54aa-defa-ecfd-11ecd6f8a664@ramsayjones.plus.com>
        <20190405192534.GA4496@sigill.intra.peff.net>
Date:   Mon, 08 Apr 2019 14:13:17 +0900
In-Reply-To: <20190405192534.GA4496@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 5 Apr 2019 15:25:35 -0400")
Message-ID: <xmqqzhp19j0y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Apr 05, 2019 at 08:19:30PM +0100, Ramsay Jones wrote:
>
>> >  /* global flag to enable extra checks when accessing packed objects */
>> > -extern int do_check_packed_object_crc;
>> > +int do_check_packed_object_crc;
>> 
>> ... removing this 'extern' on an int variable sends 'sparse'
>> into a frenzy of warnings! :-D
>> 
>> [You didn't use a global s/extern// by any chance?]
>
> Oh my. I did look at each one, but probably via replace-and-confirm in
> vim. I don't know how I managed to botch that one so badly.

Perhaps we should keep 'extern' even when declaring (not defining) a
public function in the header file to avoid a gotcha like this?

What was the reasoning behind the insn in CodingGuidelines?  "As it
is already the default" does qualify as a reasonable justification
for telling "extern is not needed for functions" to our readers, but
not quite enough for "extern should not be used for functions".

