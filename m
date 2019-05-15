Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B901F461
	for <e@80x24.org>; Wed, 15 May 2019 21:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfEOVPC (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 17:15:02 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:34397 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfEOVPC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 17:15:02 -0400
Received: by mail-qt1-f179.google.com with SMTP id h1so1507407qtp.1
        for <git@vger.kernel.org>; Wed, 15 May 2019 14:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vhwRfZt7aBL05QF6FlF0SmfCLDpvj2SFsL2H/4flRqc=;
        b=myxhtSUFXSImQDjKt4K4EvW3mVVG4DfTSdOPio4WfgcjBgq16pKFEvALIy6OBwpEhD
         dFql6Si3MFQX0LOrvDZaR0f1fSCghGLmYGAtaTJpwZJrET0GuDEl51szCDGOofG8q8uJ
         5CLGmbhHn/la02m9s1mJJYSQLUZAKzwMXzy55+xChgB9H+rX/diyjCoVv+Hq0KvVm+yF
         xT9vGZfwkRmACz7jRCEbHwBloAxdD+ItwRuBGM8YlbypZkB3wzx8z15fHSiiZvOHaEkn
         XtX387Z6Fg4r972XYrxRa4JbiEgDgsr9mM/9A414QAwBc4XbztJN0fhbX2KXxaeLY3d0
         Th0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vhwRfZt7aBL05QF6FlF0SmfCLDpvj2SFsL2H/4flRqc=;
        b=LdQ+vQTcV7Ov6ajDEa6jUYT14cPwC5qvlxsyGsD+ichQi9rE3OsuxwPIx6Lp8M0v+v
         C4DihEOtd0ydl5r9VJo19vai3QSxSR4/Fkmpn2j3tBWerv1YQNoigrFSH13ZSAaoODKH
         Mhb1qBQiEaqfHFS4EoNoWTVGzkKvP/SZDmQuFHdsBrh/eIGCJR6GbCBtB1ZB6XeffHTD
         1sM1Pshnn0vFJcN5Hny2QaNw8fAPW5jAUP2fqxmCjfP4xRqrxQw8hKNJdgGGS00yXIzB
         z0B+psMXcHfLqLlGjahJ+0Jdyw1lZgoT0T/OqA8alUiD+UcgsuRs3K6eFHz08DEqIfTq
         qx4g==
X-Gm-Message-State: APjAAAUnrRj3N4TveAB6qbEqyKDR6LE8Fy8I/FDbjGlUZpBOvISZH7SE
        qXmQVqLwkbTRK48gLCTIqng=
X-Google-Smtp-Source: APXvYqxhM3VqBk9Ovb7FUNYzDoH9l8yf9zeBO1g+pu8lkvhlzkX8nYTy9oi9Yao46uvNXh2A99LMyw==
X-Received: by 2002:ac8:332a:: with SMTP id t39mr38985940qta.245.1557954901212;
        Wed, 15 May 2019 14:15:01 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id g206sm1589093qkb.75.2019.05.15.14.15.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 14:15:00 -0700 (PDT)
Subject: Re: Finer timestamps and serialization in git
To:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Cc:     "'Eric S. Raymond'" <esr@thyrsus.com>
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <998895a9-cfbb-c458-cc88-fa1aabed4389@gmail.com>
Date:   Wed, 15 May 2019 17:14:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/15/2019 4:28 PM, Jason Pyeron wrote:
> (please don’t cc me)

Ok. I'll "To" you.

> and we follow the rule that:
> 
> 1. any trailing zero after the decimal point MUST be omitted
> 2. if there are no digits after the decimal point, it MUST be omitted
> 
> This would allow:
> 
> committer Name <user@domain> 1557948240 -0400
> committer Name <user@domain> 1557948240.12 -0400

This kind of change would probably break old clients trying to read
commits from new clients. Ævar's suggestion [1] of additional headers
should not create incompatibilities.

> By following these rules, all previous commits' hash are unchanged. Future commits made on the top of the second will look like old commit formats. Commits coming from "older" tools will produce valid and mergeable objects. The loss precision has frustrated us several times as well.

What problem are you trying to solve where commit date is important?
The only use I have for them is "how long has it been since someone
made this change?" A question like "when was this change introduced?"
is much less important than "in which version was this first released?"
This "in which version" is a graph reachability question, not a date
question.

I think any attempt to understand Git commits using commit date without
using the underling graph topology (commit->parent relationships) is
fundamentally broken and won't scale to even moderately-sized teams.
I don't even use "git log" without a "--topo-order" or "--graph" option
because using a date order puts unrelated changes next to each other.
--topo-order guarantees that a path of commits with only one parent
and only one child appears in consecutive order.

Thanks,
-Stolee

P.S. All of my (overly strong) opinions on using commit date are made
more valid when you realize anyone can set GIT_COMMITTER_DATE to get
an arbitrary commit date.

[1] https://public-inbox.org/git/871s0zwjv0.fsf@evledraar.gmail.com/T/#t
