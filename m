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
	by dcvr.yhbt.net (Postfix) with ESMTP id 70DE21F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 04:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeKUP3x (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 10:29:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38175 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKUP3x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 10:29:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so3640844plb.5
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 20:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c7XUUBlOVMg1Oun76lr7mzf04ifONsCpnU6brOLYgHg=;
        b=ORW4xX45ydo+g1bGey4hM9gw+tiMOn5nwriQJ5LolkeEAxG5R1TXIKPLQWf8Onimkp
         /mzjc4ddK6uIXFfGSbDSq3mbdrjtRzmz/7v54hcbmEwvLTnIodqXxOwJI1OMeZMWjy8k
         IctGSSIxyS0nvmYVIPiRLXap7R+8rfEhcIvED+0bBJNLhvZke7Sr9OIijLhAsNKu9bIR
         K5M0CB2Ny+l/XJJ0pgqLiqo6hbNVumZvUZR+wZiQ2MEoOTLLWJoc0mUFDgapVv+HaUO5
         8LYSEauy1iUkBmcu7II19eTfhJMhZmxSJLoOfbGzgMiYbncC9ZJ4a1dC5HhmsTC4ZOST
         5Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c7XUUBlOVMg1Oun76lr7mzf04ifONsCpnU6brOLYgHg=;
        b=S+oer28yVhrooqIOqN96cnTvDGKm+paKt9lsRRTL1IryfdS+RRaVyL7rbL/R3gLG/R
         75PMwSj+cb701zU0XxH6vA61DPYjvzHUVZU8IlJMq3N9m6/XxKFqvqslnmtMom7ertKK
         bbIlDSlB+Qg39WwjexsYaIDG1O2go+zkbErIHo8p57hED5uJrtB2B2txrLOmbEmuDkSz
         mENb+pi+qt57DdXaiX+xuk/DqUVvjBzu2LONlWARIrxEwzFhEwnp1D9Ja+VVIarajUsg
         ygi7VwKZ+BYwvgKMqISbCqY+qG12l7VVP6lVQcd6KuqlWPw3LbCtC94mr0OHfR9RzD+c
         YonA==
X-Gm-Message-State: AA+aEWZW8DKRsIgf9No7fQfkadK4vrgDyyBLD54neV94xjhV3R8u0kKC
        ynnud2zURWEQy85evQRu9J8=
X-Google-Smtp-Source: AFSGD/WEvp7LY5zqrwQcwGfOk9vDZECkv9XLbuAh6uO4NBGLVK+y1NvrynVlb+e8HyL3Lt86QJe0Mg==
X-Received: by 2002:a17:902:b701:: with SMTP id d1-v6mr4985383pls.29.1542776223155;
        Tue, 20 Nov 2018 20:57:03 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id r4sm54949845pgn.54.2018.11.20.20.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 20:57:02 -0800 (PST)
Date:   Tue, 20 Nov 2018 20:57:00 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] index: offer advice for unknown index extensions
Message-ID: <20181121045700.GC245855@google.com>
References: <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com>
 <20181120061544.GF144753@google.com>
 <87sgzwyu94.fsf@evledraar.gmail.com>
 <cabd2e37-7389-ac74-6626-629eab7da53f@gmail.com>
 <xmqqefbf9t4j.fsf@gitster-ct.c.googlers.com>
 <20181121010309.GE149929@google.com>
 <xmqqpnuz83f9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnuz83f9.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Now, a meta point.  Throughout this discussion, I have been hoping for
>> some acknowledgement of the problem --- e.g. an "I am sympathetic to
>> what you are trying to do, but <X>".  I wasn't able to find that, and
>> that is part of what contributed to the feeling of not being heard.
[...]
> And seeing the same "let's not enable the new extension" patch again
> without much improved justification contributed greatly to the
> feeling of not being heard.

Thanks for the pointer.  I had not understood before that you were
unhappy with those commit messages.

The commit message describes symptoms and the motivation for the
change.  I was confused at the original replies to patch 1 and 2 that
seemed to be more about patch 3; patch 1 and 2 are meaningful without
patch 3, so it would be odd to include a justification for patch 3 in
their commit message.

That said, it sounds like their commit messages are not adequate.  I'd
appreciate help from someone else to improve them.

>                              The feeling is mutual.

I was trying to diagnose what was going wrong with the conversation so
as to move things forward on a better footing.  It seems I only
escalated things more. :(

Sorry about that, and I hope there's some way to move forward.

What is the best way to handle this?  I am feeling somewhat burnt by
this review process.  If Ben and I, working together, are able to come
up with a series that we both like, will you consider it for 2.20?  Is
there some other trusted contributor, such as Peff or Duy, that you
would trust to represent your wishes so I can pursue their Reviewed-by
without risking getting burnt in the same way again?

Jonathan
