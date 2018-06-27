Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5644C1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 00:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933795AbeF0AXA (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 20:23:00 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38884 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbeF0AW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 20:22:59 -0400
Received: by mail-pg0-f66.google.com with SMTP id c9-v6so120674pgf.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x/UfmkTadcyL8dCIvaQ8ZmA188qPdNpfc8LZepcIvN4=;
        b=eFOkAJQqykU8s1TrPf97+04vSNGNrhdVLW60kyjz6fUxAA7RYI7z9gZvkZ0bH08cv7
         QTLZoF/fHC1m7oJOK3ZVQnphuynuXV6jxfZdEkZsC3HwQX1zoIiAXJUDPFoXuZhYyEC9
         oXGytJ34gn/V6KsJG9sMo3maNQOUMFWieZV3GC5HoFou51Z9vLtBBs0g0wewGtS8oUKY
         bt1Cp8scemGf621yZZEq2oxZ7+HSihdM3jm05HZ/wfJzME/uyrhyyY0Tl7zvkGno/TC+
         dQm8w018f0GlJo0Lr4G3hU0EE55zfaipRe738geWpJzCAr+z1xvDINtelS8U7UAnXiSL
         9s5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x/UfmkTadcyL8dCIvaQ8ZmA188qPdNpfc8LZepcIvN4=;
        b=leTQyF+3Ebj7F01lmHJ2vosp/8p5It1hdQTubXnc41CbeeJk1DB6v7BCFxWQFQhRI5
         32bOZ/BpftFAjW/B4aki0shN9Y9/9/Uknkacj76ol9TdFOj4SI/WhMDKPlKV8hnuN5bk
         LiiLYF3Ep6T1mH0CfCpAdbA0OUzvyzitX/Cjda+3IwPlfblKbKzICYO5G0CcGe0Jj4et
         X1EBY4GDfkG5KRyFxcHu4UMu9gqQuCf+oFkje5WYSW+1Jbm3fePw9Rfbjmlj9KP2aaoa
         hJA/QMGdvWG5PzCbmniFPcywrn32UFhUJUnjGrkDS882Vgftuy4cxS0dptykcD2ihXYL
         FosQ==
X-Gm-Message-State: APt69E0GLSxOj/MtCoYyMtZ5EKsAgDTv8sgh9a8aXenDRhVhaxWIhScj
        TxUr6B4G5VeD1U9GgVyGN9zhv/uu
X-Google-Smtp-Source: ADUXVKJ0CdNSPg9re5qt6gV0fbNJffoH6r+QzSVgP954hOEIqNHXIQVMv/s57i/U716uL9OVZYwYnA==
X-Received: by 2002:a65:4aca:: with SMTP id c10-v6mr3143244pgu.327.1530058978560;
        Tue, 26 Jun 2018 17:22:58 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 14-v6sm4947124pft.10.2018.06.26.17.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 17:22:57 -0700 (PDT)
Date:   Tue, 26 Jun 2018 17:22:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/29] t: detect and fix broken &&-chains in subshells
Message-ID: <20180627002255.GC12488@aiede.svl.corp.google.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <xmqqo9fxjq39.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSW6jP3FtYpwf5bB4SM=qw6A3K9H3JPranJ_KMqH-AwZw@mail.gmail.com>
 <xmqq6025i3io.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq6025i3io.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jun 26, 2018 at 03:31:11PM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Tue, Jun 26, 2018 at 3:38 PM Junio C Hamano <gitster@pobox.com> wrote:

>>> I like these earlier changes that fix existing breakage, of course.
>>> I also like many of the changes that simplify and/or modernise the
>>> test scripts very much, but they are unusable as-is as long as their
>>> justification is "chain-lint will start barfing on these constructs".
>>
>> Sorry, I'm having difficulty understanding.
>>
>> Are you saying that you don't want patches which exist merely to
>> pacify --chain-lint? (For instance, 2/29 "t0001: use "{...}" block
>> around "||" expression rather than subshell".)
>
> Yes.
>
>> Or are you saying that you don't like how the commit messages are
>> worded, and that they should instead emphasize that the change is good
>> for its own sake, without mentioning --chain-lint?
>
> Yes, too.
>
> For example, 03/29 is a good clean-up, and its value is not
> diminished even if we reject the subprocess munging --chain-lint in
> 29/29.
>
> As opposed to 02/29 which mostly is about appeasing the "shell
> parser" in 29/29 (or you could justify it saying "one less fork and
> process" if that gives us a measurable benefit).

This is a lighter-weight example of the practice described at
https://lkml.kernel.org/r/alpine.LFD.2.00.1001251002430.3574@localhost.localdomain/.
In my opinion it's good advice, often worth repeating.

Thanks,
Jonathan
