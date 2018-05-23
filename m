Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54C891F42D
	for <e@80x24.org>; Wed, 23 May 2018 08:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932185AbeEWI64 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 04:58:56 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:41284 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeEWI6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 04:58:48 -0400
Received: by mail-wr0-f179.google.com with SMTP id u12-v6so5982211wrn.8
        for <git@vger.kernel.org>; Wed, 23 May 2018 01:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Uk/xcfuVq2TB78WEHJ34o00vl5pM0QHxuabT4vkBros=;
        b=aqA9bmmnRoeiE32PYwZP4vWx/+rJeOmi92tzoLTt+3hjOrLlDBK/bM2hJ3rMLY8BjJ
         SDy6XcUfjFJf+Nt2NPdcA2KQN0BitSzDD8GSTjH5Dp3VYDLWptxqqBW0K/e3bmFHBfOT
         xXZIj5W01K9pJQkKAVR216iBKyTczMNxeoKqv0GChLzP9PMqt8Y7QU1xMDAT2VaWsllY
         hKUYC9qAlpZfkF7fpNsoI324xIfvcQES8drRkbUfwDu+SJDlnnh6wQu7Ekquhv3lcODR
         E9KzPawDlchP/9ixoZB1lQUC6MOOQ2+jDi1r/eBqq0gxPepUEU0U/AeOgovv+73fqQg7
         BKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Uk/xcfuVq2TB78WEHJ34o00vl5pM0QHxuabT4vkBros=;
        b=FG4YpLBOmMYa8quwu4mfAeFzZ/67zwCzsBXAxUWW2pPzTEnELYGR9iMsDonZOd1hEO
         CBWO9iJfFmrKjQcwuGT1Dslph+qHWg2L9c5HqGj0CowqCW2RB5LbRTRGx5gK+QSfSreC
         aDoVHwx6a/o+IcPhmNrrlxxALhEhqofatFjqT1Ek7hOxesRGY6ipLik8sM1ZNxTsxu8+
         6ul3YYkjLxoA/QkwNlRRHviePUVqvyvW7mBbzHaghkTce6SzL0JN785MFUv5c4vFtbSG
         1I7QoufD2EoSr0YmBGAwHqY//d+8Ira3XY6T1SyUuMWRJQYeBpM0aamnZ3bCh+cbX7XV
         BFxA==
X-Gm-Message-State: ALKqPwfxM2lNkESVPqV97sBksjMJ6MohH/scqH3XeYHEAwoIyTD1k7NT
        hE0fWil+buI/XyzHOxZHkhZj0C4e
X-Google-Smtp-Source: AB8JxZqg6dbK+HvYh5YOmTZAP0+GWLIFAdezg2eOEMtpVX/Ns/VJauxNe40dzfYz+8guVLRtDR90/A==
X-Received: by 2002:adf:ac64:: with SMTP id v91-v6mr1435583wrc.80.1527065926747;
        Wed, 23 May 2018 01:58:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v12-v6sm1294936wmc.35.2018.05.23.01.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 May 2018 01:58:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: should config options be treated as case-sensitive?
References: <alpine.LFD.2.21.1805220353370.989@localhost.localdomain>
        <87h8mz99d2.fsf@evledraar.gmail.com>
        <xmqqo9h7w2y2.fsf@gitster-ct.c.googlers.com>
        <alpine.LFD.2.21.1805230354270.16358@localhost.localdomain>
Date:   Wed, 23 May 2018 17:58:45 +0900
In-Reply-To: <alpine.LFD.2.21.1805230354270.16358@localhost.localdomain>
        (Robert P. J. Day's message of "Wed, 23 May 2018 03:59:01 -0400
        (EDT)")
Message-ID: <xmqqd0xmvjcq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>> If the documention does not make it clear, then we have
>> documentation bug ...
>
>   personally, i would add a short, really emphatic note at the top of
> "man git-config" pointing this out -- i wouldn't require people to
> read all the way down to "Syntax" to learn this. an example just like
> the one you provide above would be perfect, with an extra line
> pointing out that the documentation uses "camel case" for nothing more
> than readability.

Unfortunately, that line of thinking leads us to madness, as you are
exhibiting the typical symptom of "my today's immediate itch is the
most important one in the world"-itis.  Tomorrow you would start
saying that we must have a short, really emphatic note at the top
that says that the second level name can even have spaces, and on
the day after that, you would instead have a note that says that you
cannot use an underscore in the name, and continuing that line of
thought will lead us to fill the top part of the documentation with
47 different short and emphatic sentences.  Let's not go there.


