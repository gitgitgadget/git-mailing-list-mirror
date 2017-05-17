Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF95F201A7
	for <e@80x24.org>; Wed, 17 May 2017 23:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbdEQX4a (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 19:56:30 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36084 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdEQX43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 19:56:29 -0400
Received: by mail-pg0-f44.google.com with SMTP id x64so14053251pgd.3
        for <git@vger.kernel.org>; Wed, 17 May 2017 16:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UVztYd7TWwNcdbQC24g/s4jKQkeTj8JlLhItcZP8wgw=;
        b=M3hWTaesFX4mPlAi8tJoAE20HOGZLrWepvLImvIuCbg9Ab7G8qmKU2Sta1DFx8cSqI
         78I1QecO6XzKWnp2KLO7f6E4qeP4R+7wpA7k2vJqa8BknY4MDxXuRxmZkoHFJY/Rfip6
         q3KrzKGluDbafMcGIbTEqTR97Oz/xmMlQxLDvvycFIcjinwAsPgJwD8IwdmoUcd9wZC0
         o9DW6mqiYkZQazzY3wwSamOxeXhc2HFMGz5QOj4KcrULjG+duPPzxY0/oqOxlyUCiIqb
         97O5J9M3Nn6x5n4hVl+h9rolY9u+C1Zx+HS0IIwP6tyik446dVdCIVtUORDvzNCQvoww
         yrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UVztYd7TWwNcdbQC24g/s4jKQkeTj8JlLhItcZP8wgw=;
        b=ZQUIhoJ8WO9lw8moZshULxOjFqndd50i6Qpd0GcsfLSlkivmzZ/cWCjlWx7M15RYN3
         I2/81wkji6G5MIhgG1Ev3H3CESR2+wUHp5z3TFzF/S1T5mNHNeGr3TfYT28gQsr/rUsK
         ay3Rs55zWiPacs1m/UWMFcXszk0Ype+ZMBOLOWOUXGFzYa9P3LYqqBW4x1iHp4tn7KN3
         6Kvu1/B1fTfbhXpqJ7UY8QjwFOSfj+VXssysrR2aaytcBTLPFf3aj3MMmOg3qSE3uY8U
         j8mwUmVJ+JYKorQt1Qtx1/5g7xThqwFvVvYUMc4X5+Z2bjyYmCvWtyzRBFQDdBi4NQ9B
         W9LQ==
X-Gm-Message-State: AODbwcBEX3ua3Evz6vdjJD85eN+KVs5/KsFPysRLWQKwbAv9zIT8bfHe
        s6VM/wJxufpHDkw/k9F7BQ==
X-Received: by 10.99.100.129 with SMTP id y123mr1025017pgb.217.1495065388803;
        Wed, 17 May 2017 16:56:28 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1838:1185:c4dc:8c8d])
        by smtp.gmail.com with ESMTPSA id d123sm5604499pga.61.2017.05.17.16.56.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 16:56:27 -0700 (PDT)
Date:   Wed, 17 May 2017 16:56:26 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Joey Hess <id@joeyh.name>
Subject: Re: [PATCH] tests: add an optional test to test git-annex
Message-ID: <20170517235626.GB185461@google.com>
References: <20170516175906.hdwn4x5md7dj7fo3@kitenet.net>
 <20170516203712.15921-1-avarab@gmail.com>
 <xmqq7f1gyzep.fsf@gitster.mtv.corp.google.com>
 <CACBZZX4Jppr7ht7m444EjW4CDYX5CMvnxtStH4bF=A19TYKcZg@mail.gmail.com>
 <xmqqbmqrwzu1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbmqrwzu1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> >> Well, it is one thing to place git-annex under CI to make sure its
> >> latest and greatest works together well with our latest and greatest
> >> (and it may be something we want to see happen), but driving its
> >> tests from our testsuite sounds like a tail wagging the dog, at
> >> least to me.
> >
> > To me this is just a question of:
> >
> > * Is it the case that git-annex tests for a lot of edge cases we don't
> > test for: Yes, probably. As evidenced by them spotting this
> > regression, and not us.
> 
> And I'd encourage them to keep doing so.
> 
> > * We can (and should) add a test for the specific breakage we caused
> > in 2.13.0, but that's no replacement for other things annex may be
> > covering & we may be missing which'll catch future breakages.
> >
> > * It's a pretty established practice to test a library (git) along
> > with its consumers (e.g. annex) before a major release.
> 
> I am not so sure about the division of labor.  What you are
> advocating would work _ONLY_ if we test with a perfect & bug-free
> version of the consumers.  If they are also a moving target, then
> I do not think it is worth it.  After all, we are *not* in the
> business of testing these consumers.

I agree with this. It makes no sense to test consumers of git, its
downstream's job to do that.  Though I do think that its perfectly
reasonable to test that our API works as advertised such that consumer's
can rely on git.

> 
> Unless I misunderstood you and you were saying that we freeze a
> version, or a set of versions, of customer that is/are known to pass
> their own tests, and test the combination of that frozen version of
> the customer with our daily development.  If that is the case, then
> I would agree that we are using their test to test us, not them.
> But I somehow didn't get that impression, hence my reaction.

-- 
Brandon Williams
