Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 968471F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbeIVEOf (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:14:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37031 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeIVEOf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:14:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id n11-v6so4753580wmc.2
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V+y+GTse0Xn2K/43CaBfBoIJMzHvDBe1QwUZuGiTuNU=;
        b=WUed73hWyMHQry4Vr3PSAed/INCYWXoJefUdzBDGyI2BAL9MHAFxIRcOEgjEfnf9tw
         UTT4PSBm3yls+SxYGVY+UgQI2NG42zHul2u1xbtREm3f3F+xcMUJq1W1NBsjato6Lv3W
         tdBT1Wh9cMB9Zhbvmud8z4/xrELmh8IP/Y6bY2+gX3YWMAKsU9xJ2e+szAC+9YWT/VGa
         1SYTRGTC6aT8SXuD4VkZLwTzLkI1XboGtrceuhLWOliYr26Ssck5yRHc5HfvCSmqxr8+
         w1nj9RohJYoSklgnQAnp2k+tSmvMg0HohJKZKVTM5EWgw31wM5jxZc7N2DilQI8QgXNZ
         fqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V+y+GTse0Xn2K/43CaBfBoIJMzHvDBe1QwUZuGiTuNU=;
        b=VpXC3yuy8U1EpkYlliYahx04ccZswxRSOvuAjOgFMJdxf8+l6CMKHxHlCbAadLjx4+
         T2O++Ymopd75IOkwQXSjK7IV/9AR1yXMFuuSxcILSjysN2mYOq0t/N23SUTTDzwvmlsV
         nNNQsYvSkWmcpbkWnAwdEdE7kZF/FwRlTEhl7HnPJ5LqjkFxbNO7TenDjpEcrosxKqf/
         TcukqhG2Oz3XX4byC+J1uP3HK8WOYlrx4q6u/C1tHcLNeWBBl8jZ+FPT07O8y7dMgQgP
         ojnX6pB9Bokn6YiIRYU5ywZAVRme8zA+SOjvhsHQpSqzvjmLQoqowiK3J5LDh3OVPpiG
         Ou4Q==
X-Gm-Message-State: ABuFfojI0LiMd4Ob3IQOYTlIdfJqT38FFzJJ9oJxF1R+dmFU0lUg0X/j
        3CRD0jbiiDJ7WLCfnJZBKHU=
X-Google-Smtp-Source: ACcGV61pEN+EgG684MMYTH+tLUnTuG+ctsFmuqS3xtS4rQj8mayQO8pXpTel2hoAf9HaPS+CWbaq2Q==
X-Received: by 2002:a1c:7212:: with SMTP id n18-v6mr1050460wmc.33.1537568621161;
        Fri, 21 Sep 2018 15:23:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x16-v6sm20817645wro.84.2018.09.21.15.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 15:23:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
References: <cover.1537466087.git.me@ttaylorr.com>
        <cover.1537555544.git.me@ttaylorr.com>
        <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
        <xmqqfty2v9qj.fsf@gitster-ct.c.googlers.com>
        <20180921221317.GB11177@sigill.intra.peff.net>
Date:   Fri, 21 Sep 2018 15:23:40 -0700
In-Reply-To: <20180921221317.GB11177@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 21 Sep 2018 18:13:18 -0400")
Message-ID: <xmqqpnx6trpv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Sep 21, 2018 at 02:09:08PM -0700, Junio C Hamano wrote:
>
>> > +test_expect_success 'setup' '
>> > +	test_commit one &&
>> > +	git update-ref refs/heads/a HEAD &&
>> > +	test_commit two &&
>> > +	git update-ref refs/heads/b HEAD &&
>> > +	test_commit three &&
>> > +	git update-ref refs/heads/c HEAD &&
>> > +	git clone --bare . fork &&
>> > +	git clone fork pusher &&
>> > +	(
>> > +		cd fork &&
>> > +		git config receive.advertisealternates true &&
>> 
>> Hmph.  Do we have code to support this configuration variable?
>
> Sorry, I should have caught that. Our existing solution is to disable
> alternates in the advertisement entirely (since the optimization
> backfires for us). So this line is a leftover from testing it against
> our fork, and should be dropped.
>
> If anybody is interested, we can share those patches, though they're
> unsurprisingly trivial.

Heh, I guessed correctly what is going on ;-)

Even though there may not be much interest in the "all-or-none"
boolean configuration, in order to upstream this custom thing, it
may be the cleanest to upstream that all-or-none thing as well.
Otherwise, you'd need to keep a patch to this test script that is
private for your "all-or-none" feature.  That's your maintenance
burden so it ultimately is your call ;-)
> Also, useless-use-of-cat in the original, which could be:
>
>   git update-ref --stdin <<-\EOF

Yup.

Thanks.
