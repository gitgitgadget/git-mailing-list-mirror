Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66E220286
	for <e@80x24.org>; Wed, 13 Sep 2017 16:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbdIMQb0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 12:31:26 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:43994 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdIMQbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 12:31:25 -0400
Received: by mail-pg0-f51.google.com with SMTP id u18so1356321pgo.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wfBZzjw9WkX1qbCAhRQT5ggwr/5BtQYSiob0au93tds=;
        b=U+Fcr8s+upak2k1vqisyc9qf+q8lb/WROTwhxO2omJPKS0WiaPR5O8Zpk7eO91LRnb
         zllnuRXMaiIQH+DkRdmZwsq1GHaoNlmpjGe1uzmfbAEXDc1uglBLF2xyEGpVWYpxjTMG
         +BrmOqCcjOfBOqZGdJyXj/iPSANfeB8BUiVPUEVdVyZN5mZO5lp95wJFCdgi7kjHL5hJ
         rUG6A0H/QG+UglZPYms4kWKdXrogNkxRKHVSvAl4FrdxHeXBQ6TXrw7d7yL92q6WEiu3
         NeSknoDCW3VyXI6X3k+uO5oI6DxjzZu6MhMTfC/OvFG4xCpFlaXyscaCF/lXZfAJkszV
         V9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wfBZzjw9WkX1qbCAhRQT5ggwr/5BtQYSiob0au93tds=;
        b=RyfgaFd/OpWGLTHzju6vrkyHrzDNOLGiqS8tXwMWC3gLwMWdIZ8lzhsPgWKpM9cYhh
         f07kNo6R6/pS2Ye078BAWI+w1PoJtHH+RWjiiXcvE76dyC2mcpit9h2eGbmbgRtwa3WI
         V1RsOnLKWsqi0bncUgq1gzlya0/7+N8Y7wO33bSkQ+uVSSZp9JK8oWXfMq/ru6d8GiHR
         eaaa9hwJW1HWtrfji02KzrrwAyqjKseGPzKP7frTnI204dDrjFeB9NUcs8m9z/f2elha
         heYeYAJteXgLhAV6Jbu8Yz0V5vEgWjm7A4sjk1MbvwIAPjyWoZaTlrVSjQ2AI0dsE/kN
         mQKQ==
X-Gm-Message-State: AHPjjUieslCaKWitXsBsP/E8F4bv5F8fs063+gWJHf9vtbXyhyoSqzl7
        94M83dT3kqxz3Q==
X-Google-Smtp-Source: ADKCNb6ukjXyhxqbl2bFqFXNRBL4G39ZT432MrU/rbQ8p/tQEWS0jjxgDdqSznkQYG7exfIM+zUM1g==
X-Received: by 10.98.152.76 with SMTP id q73mr17882346pfd.247.1505320284324;
        Wed, 13 Sep 2017 09:31:24 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:513d:47d2:882:8efc])
        by smtp.gmail.com with ESMTPSA id q77sm24804303pfa.173.2017.09.13.09.31.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 09:31:22 -0700 (PDT)
Date:   Wed, 13 Sep 2017 09:30:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170913163052.GA27425@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Johannes Schindelin wrote:

> So even if the code to generate a bidirectional old <-> new hash mapping
> might be with us forever, it *definitely* should be optional ("optional"
> at least as in "config setting"), allowing developers who only work with
> new-hash repositories to save the time and electrons.

Agreed.  This is a good reason not to store the sha1 inside the
sha256-encoded objects.  I think that is exactly what Brandon was saying
in response to Junio --- did you read it differently?

[...]
> ... or Git would simply handle the absence of the generation number header
> gracefully, so that sha1-content == sha3-content...

Part of the sha1-content is references to other objects using their
sha1-name, so it is not possible to have sha1-content == sha3-content.

That said, I am also leaning against including generation numbers as
part of this design.

There is an argument for including generation numbers.  It is much
simpler to have generation numbers in *all* commit objects than only in
some, since it means the slop-based heuristics for faking generation
numbers using commit timestamp can be completely avoided for a
repository using such a format.  Including generation numbers in all
commit objects is a painless thing to do during a format change, since
it can happen without harming round-tripping.

Treating generation numbers as derived data (as in Jeff King's
preferred design, if I have understood his replies correctly) would
also be possible but it does not interact well with shallow clone or
narrow clone.

All that said, for simplicity I still lean against including
generation numbers as part of a hash function transition.  Nothing
stops us from having another format change later.

This is a particularly hard decision because I don't have a strong
preference.  That leads me to err on the side of simplicity.

I will make sure to discuss this issue in my patch to
Documentation/technical/, so we don't have to repeat the same
conversations again and again.

[...]
> Taking a step back, though, it may be a good idea to leave the generation
> number business for later, as much fun as it is to get side tracked and
> focus on relatively trivial stuff instead of the far more difficult and
> complex task to get the transition plan to a new hash ironed out.
>
> For example, I am still in favor of SHA-256 over SHA3-256, after learning
> some background details from in-house cryptographers: it provides
> essentially the same level of security, according to my sources, while
> hardware support seems to be coming to SHA-256 a lot sooner than to
> SHA3-256.
>
> Which hash algorithm to choose is a tough question to answer, and
> discussing generation numbers will sadly not help us answer it any quicker.

This is unrelated to Brandon's message, except for his use of SHA3 as
a placeholder for "the next hash function".

My assumption based on previous conversations (and other external
conversations like [1]) is that we are going to use SHA2-256 and have
a pretty strong consensus for that.  Don't worry!

As a side note, I am probably misreading, but I found this set of
paragraphs a bit condescending.  It sounds to me like you are saying
"You are making the wrong choice of hash function and everything else
you are describing is irrelevant when compared to that monumental
mistake.  Please stop working on things I don't consider important".
With that reading it is quite demotivating to read.

An alternative reading is that you are saying that the transition plan
described in this thread is not ironed out.  Can you spell that out
more?  What particular aspect of the transition plan (which is of
course orthogonal to the choice of hash function) are you discontent
with?

Thanks and hope that helps,
Jonathan

[1] https://www.imperialviolet.org/2017/05/31/skipsha3.html
