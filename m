Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B44B81F407
	for <e@80x24.org>; Wed, 13 Dec 2017 23:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdLMX0g (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 18:26:36 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41569 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbdLMX0e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 18:26:34 -0500
Received: by mail-wr0-f193.google.com with SMTP id z18so3592745wrb.8
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 15:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o3l8doOK5TOrrkYORWlqtRTPmH3YF+obS4REbO29huk=;
        b=hOiXS9gXPL8aR6235HJbqGM9133cNWbE3DokMNi4mREnR7Mgj/7A75wu1qAiflHnSO
         fyEzG8gnNx+BMRlk0qoKxISzaIFMmYPjfXXkFIhfE76CKq3cs3xc+trnJJQjsH+9NkS/
         bLbzGMX99HOs3Z41IH7AKo1xv0WwUHPEOH+BJ4Zdwm2udfHZTpwQe7soPYWjLzzTw5s/
         orGUg0YH/26BrQoucFdpE/eirxWKaPrwvJmWm56nYr+n+1E1DAxiI+Dx5wv/TbpP7H6j
         c97ZDB6Ss0RYW7cVKngEbmFU5LtWqXp5iPZqd+VsJnw2X92fSGlto42VaScg/BBVkgKi
         y9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o3l8doOK5TOrrkYORWlqtRTPmH3YF+obS4REbO29huk=;
        b=bA5PI4ARtHJHI4+M+T/+3AV2N2dBkun1l9riUAbFtN1dMYV8NofkVV4oYxLxFfpfyC
         BRu0TefYKKSsY4NhTWmfJEWQ3aFvq3duCzYsMCHMo/aZkSL7earuYdomJt9QrgMvo0zb
         x31zc69HbvqPNbO3AkXMfr0JZw4BFb7jyDUn8j3+EYRsjglxRPLKzFsIQqV0K6iGaDJ3
         6afBOAsH8kqZ6/5QI4wyhp1aFghWBzX7RELAcTdUnqYYWwq37AF4l9YYxnqD3dNSGXbv
         7OxZjC8JALpOlRBWegoZnaa093CrdSB1QVorRN+rpRO32Ee6aHWuqg3fLCURGvKZbRbv
         eeKQ==
X-Gm-Message-State: AKGB3mKaeX218S+69yvI5Lw31u3rj87FXjhg9YX7X7VjLylwpmT0P9rP
        4HYWYKsYdFq9mf/unQmiF7I=
X-Google-Smtp-Source: ACJfBouB15oYF1rtnEpe7wd9L1yvv8G9L4NZ003/oygBYuIfcuXcGQtCKp4YJTH4/h1U7jSI2yeAOg==
X-Received: by 10.223.199.70 with SMTP id b6mr4050876wrh.25.1513207593557;
        Wed, 13 Dec 2017 15:26:33 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id b45sm1556018wrb.1.2017.12.13.15.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Dec 2017 15:26:32 -0800 (PST)
Date:   Wed, 13 Dec 2017 23:28:19 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
Message-ID: <20171213232819.GF24597@hank>
References: <20171210212202.28231-4-t.gummerer@gmail.com>
 <20171211210948.6867-1-szeder.dev@gmail.com>
 <20171211214255.GA24597@hank>
 <C5F93DFF-D3DF-4507-8546-941BFA768705@gmail.com>
 <xmqq609b3gi3.fsf@gitster.mtv.corp.google.com>
 <09E575DE-ED7A-40FA-9A47-0ABB61452C28@gmail.com>
 <xmqq4louy1d9.fsf@gitster.mtv.corp.google.com>
 <8BB646FF-A95A-434D-95E2-FC143B847AE0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8BB646FF-A95A-434D-95E2-FC143B847AE0@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13, Lars Schneider wrote:
> 
> > On 13 Dec 2017, at 18:38, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > Lars Schneider <larsxschneider@gmail.com> writes:
> > 
> >> I think your solution points into the right direction.
> >> Right now we have the following test matrix:
> >> 
> >> 1. Linux - clang
> >> 2. Linux - gcc
> >> 3. Mac - clang
> >> 4. Mac - gcc
> >> 5. Linux - gcc - GET_TEXT_POISION
> >> 6. Linux - gcc - 32bit
> >> 7. Windows
> >> 
> >> AFAIK your solution would run the split index test for 
> >> 1, 2, 3, and 4. I think that is too much.
> > 
> > Not that it matters too much, but I meant to add it to 1. and
> > 6. when I said "only one of 64-bit build plus 32-bit one".  
> 
> Ah. Sorry, I didn't get that.
> 
> 
> >> 1 runs the fastest and I would like to keep it that way
> >> to get a quick "general" result. I think only 2 should be
> >> extended in the way you are suggesting. We could run
> >> the tests with different env variables there. What else
> >> do we have besides GIT_TEST_SPLIT_INDEX?
> >> 
> >> Would that work for everyone?
> > 
> > I am OK to make 2. use split-index (which unfortunately would mean
> > we lose tests without split-index under gcc), or add 2.5 that is a
> > copy of 2. plus split-index.
> 
> 
> I think I experessed myself poorly. As far as I understand it,
> GIT_TEST_SPLIT_INDEX is an environment variable that only needs
> to be set at test time and not at compile time. Is this right?

Yes, that's correct.

> If yes, my idea for 2. is as follows:
> - build Git with gcc
> - run tests with "make --quiet test"
> - run tests with "GIT_TEST_SPLIT_INDEX=YesPlease make --quiet test"
> 
> This should be quicker than a new 2.5 target because we don't need to
> spin up the machine and build Git. Plus, we could run the tests
> a few more times with other test flags.

I'd be happy with that.  Thanks for the discussion on this, will
change this in my re-roll.

> - Lars
