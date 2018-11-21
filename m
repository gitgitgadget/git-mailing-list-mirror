Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A16D1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 05:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeKUPhy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 10:37:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40668 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeKUPhw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 10:37:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22-v6so3663160pls.7
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 21:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p8TLOh/Uh+T51qfCVcio6Cn1ntpcOfkDySu0rYg0VrA=;
        b=B/Vsv1C7Jn+8lNfkhQF/5oYaeAFrJamwRr5wejjA/Mq5YqKc34RvREC+I2IZBu+wLc
         p5Ers4wWD8F30SkRhre1yS8nuMlMZPAgwGcuvRSbRiQ4aQ1yuvQjjOW+oCNud/uWwoWG
         VgXfLqTLkcQ/ujjm4KrWxBLZgK/7l5pHwNFWLxG2LA8nYZQhLkQX+uxkaObsp3UwI4C3
         hZvqH0QWm66XYLPSXcu3VxMvZgZPFSrAuKBIiax5yhjGcpaVI0ZyQAnAjCNzUdS7etcm
         FVFP5gC5hcc8yANv1OtA82NeK6nKQud53f4bKSXPqwGw08zZ8uhcOzDuxRh0EDOaFBVv
         ns8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p8TLOh/Uh+T51qfCVcio6Cn1ntpcOfkDySu0rYg0VrA=;
        b=e70mOJf2DWDRPlg11vUP0LdumoxLxjFlPRA8HW0RFqKFcxi1rAbrvflAW76++n2D9D
         T542187ltGFIxOKU2tUUwX7WolvOazVHh2K2GVX3Ge5TwisN/SIjleJKV6kHJPRdT8Ed
         ksVlct2oQCAMupVGStFEFus19lN6J9Uw24KoUmHDOk3bNYqtQVK3WoVC0gmf7qV0trUO
         QUwZy/3aYn6yKQm4ApE+9212UH0Vq5T3V3nAWXckQx3P/2ZXxsj2HZMvjoN0w6gaD4KO
         YQJ2YEIm/NzyW55RhGebbwOo/gV7yHUh4PZlfT2JWW15bCWz0UknDjCTd71DjJ2pPy4/
         1isg==
X-Gm-Message-State: AGRZ1gIiDxl6TfXl5iNgodvcxFdqiNy9phtBfh4zMbjtau8BXpc9smQd
        X35h7wHsqeL/T2xus5xdVrM=
X-Google-Smtp-Source: AJdET5dYeenAAhU0mXP73mMqmRkBFHk6f9EWBfuQhkZTt2S2bC5IgAiI7fbclqy4941DSwGdJQ2mSA==
X-Received: by 2002:a62:4587:: with SMTP id n7mr5240840pfi.118.1542776700664;
        Tue, 20 Nov 2018 21:05:00 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id h69sm3220608pge.4.2018.11.20.21.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 21:05:00 -0800 (PST)
Date:   Tue, 20 Nov 2018 21:04:58 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] index: offer advice for unknown index extensions
Message-ID: <20181121050458.GD245855@google.com>
References: <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com>
 <20181120061544.GF144753@google.com>
 <87sgzwyu94.fsf@evledraar.gmail.com>
 <cabd2e37-7389-ac74-6626-629eab7da53f@gmail.com>
 <xmqqefbf9t4j.fsf@gitster-ct.c.googlers.com>
 <20181121003912.GC149929@google.com>
 <xmqq36rv81nr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36rv81nr.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I don't *think* you intend to say "sure, you got user reports, but
>> (those users are wrong | those users are not real | you are not
>> interpreting those users correctly)", but that is what I am hearing.
>
> What I have been saying is "we are sending a wrong message to those
> users by not clearly saying 'optional' (i.e. it is OK for your Git
> not to understand this optional bits of information---you do not
> have to get alarmed immediately) and also not hinting where that
> optional thing comes from (i.e. if users realized they come from the
> future, the coalmine canary message will serve its purpose of
> reminding them that a newer Git is not just available but has been
> used already in their repository and help them to rectify the
> situation sooner)".
>
> As the deployed versions of Git will keep sending the wrong message,
> I do not mind applying 1/5 and 2/5, given especially that Ben seems
> to be OK with the plan.  I however do not think 3 thru 5 is ready
> yet with this round---there were some discussions on phrasing in
> this thread.

Thanks much --- that helps a lot.

Would you mind taking patch 4/5 as well?  (It's a tweak to the
configuration introduced in patches 1 and 2 that addresses a concern
Ben Peart had.)

As for patches 3 and 5, I agree.  In particular, patch 5 needs an
s/performance//, and it seems that the commit messages need some work
as well.

Sorry for getting the conversation in the wrong direction, and I'm
glad to hear we have a good way forward.

Sincerely,
Jonathan
