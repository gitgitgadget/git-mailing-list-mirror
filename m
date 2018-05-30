Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F93A1F42D
	for <e@80x24.org>; Wed, 30 May 2018 02:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935127AbeE3Csh (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 22:48:37 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43089 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934562AbeE3Csg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 22:48:36 -0400
Received: by mail-wr0-f193.google.com with SMTP id d2-v6so12448988wrm.10
        for <git@vger.kernel.org>; Tue, 29 May 2018 19:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GchtEWUqBEqMvJqbi11kj3oi/cNm79wPmGsSR8jV208=;
        b=nLiezgdCZ3kxttcfRGppU+mATXWOuE2wbeuxLD0IZWaO7fg/Xuqyjv5d/b1jE9KZmi
         bMZmGBwaUdwfbglftgShy+C+CZ0oLzgpb4LmmQq3AXKeXZsGGLkzY4T8vgKSzlSNl+VE
         ce4GeT4RkcyvRmozO5cO22dNPCTzfbsnVySfCQ5BUKScFSCWu78CgijeoHRnO9fT1CfV
         MbjINWJjk5LPOEIFVszROPyNEPz7Z2VIMmhfs2NM16gKYTRtU1qwFn4RSOw+SVj1FjwA
         IFsscv2rwLHFbernoO2kbBIVO+eyh4JBxF7d0R+8fUnHW+H40x/KTdWfVqzNaIrtkctc
         MEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GchtEWUqBEqMvJqbi11kj3oi/cNm79wPmGsSR8jV208=;
        b=BzRw90Bs2un90XCOxwOuX7mNc+3pbamjA6O2ynCqNsp3/Aez/PNNzzvlF3uLPGxxVv
         3jkHDPKSja+mzwhEQRbxdoc9KcZDxHrJiBzjCgF/0APxa5pUR96XwcCk+jab1NAzM3g0
         dCBmzb9DmjLOTRMXd+8C4lMeX+1TXa+/MHjq8P5cPNcsMD2wa66NP5DrJPfN0V7SQdtZ
         qp82x2IoBkqtYKw4uYEquSD8ReP9kbttCOVbGPGq0vi+yWc15H2uG5C42p9f6EzoUsI3
         0LNFxctry3AzK+INLKk4lhoSpODm/hiarauYcWffYQE+1oKLZ1wTacokFw6qLXzy9Lyc
         ReoQ==
X-Gm-Message-State: ALKqPwdjpdS5q/CcpChKo75P34dEw0YOmnA4tAFq5Kx4WRtEuTtG0Mae
        r14dNBv4o7JQ1Z4JsE4QS9s=
X-Google-Smtp-Source: ADUXVKJZTWNFQ8C83YY/HSm8fyTEegNYgKRYyvgz5rvCIXtNZHam7BjOKi8fONWNIhzH4jbqwk8n5A==
X-Received: by 2002:adf:f5c8:: with SMTP id k8-v6mr128435wrp.219.1527648514220;
        Tue, 29 May 2018 19:48:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k16-v6sm22285363wrh.25.2018.05.29.19.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 19:48:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
References: <87fu2qbojy.fsf@evledraar.gmail.com>
        <20180517133601.GC17548@sigill.intra.peff.net>
        <1527174618.10589.4.camel@gmail.com>
        <20180524192214.GA21535@sigill.intra.peff.net>
        <20180524193105.GB21535@sigill.intra.peff.net>
        <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
        <20180525024002.GA1998@sigill.intra.peff.net>
        <xmqqd0xknmf1.fsf@gitster-ct.c.googlers.com>
        <xmqq1sdzno3g.fsf@gitster-ct.c.googlers.com>
        <20180529212029.GB7964@sigill.intra.peff.net>
        <20180529212142.GA8767@sigill.intra.peff.net>
Date:   Wed, 30 May 2018 11:48:32 +0900
In-Reply-To: <20180529212142.GA8767@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 29 May 2018 17:21:42 -0400")
Message-ID: <xmqq7enlg8ov.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> -		if (list) {
>> -			warning("the '-l' option is an alias for '--create-reflog' and");
>> -			warning("has no effect in list mode. This option will soon be");
>> -			warning("removed and you should omit it (or use '--list' instead).");
>> -		} else {
>> -			warning("the '-l' alias for '--create-reflog' is deprecated;");
>> -			warning("it will be removed in a future version of Git");
>> -		}
>> -	}
>> -
>
> Oh, and did we want to mark these for translation on the step 0 branch?
> Obviously that would impact this hunk.

I was hoping that we can settle the "multi-line message translation
that can potentially result in different number of lines" issue
before we have to mark the above for translation ;-)
