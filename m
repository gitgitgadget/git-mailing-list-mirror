Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6861F453
	for <e@80x24.org>; Thu, 27 Sep 2018 06:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeI0Muq (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 08:50:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44443 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeI0Muq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 08:50:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so1134987pgu.11
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 23:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NwaAi3CHtXDQlYXjC9iy3p3U4XujORyYBKto7IC5eHc=;
        b=dC3j7PtaxiaDREPOrSUVMEAbsOZOBgBiipg8oRcRd/2NNmhDvimpVRs7UTJqarCPpD
         ARlKhFGAlS7ZQHAXeETXzvCmz4sYRfwFlJoZ9/IxDJ44tzRtylewXoi2jU6Nf0wjJOym
         ZmC6v/3qZ0HBvwDCV9Tr5oH+XFMgN2eYQrwXaMLsG+K/XVSKnBS7u6vhcobNU1oaHA3s
         IDv9/hTHhHnl+LYSJuwHr7nfPkap3M2Ip2mDANIUV7R2aoSAt9S0GIVpRgK9ht3/2ll0
         8EqdLXoLNiTP5W6bL8xn0IX4q2STSlfjDODy5xi2UyX/GFqG4TVCDwbw4lEuKFJjspmU
         CNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NwaAi3CHtXDQlYXjC9iy3p3U4XujORyYBKto7IC5eHc=;
        b=YseUxPGr0JOQItznzjbMX39IGcEYMMCmxXh8GNDDxGg9sc4acOI9CL7IgNLChoS62j
         3QRWgeBWZAS1zcgOlZpoV/FA+WfZLNwdXvKr/slSV4iyllSKx/+0mvSpLiuNF+J+uGZk
         3RQLCuPhvRQo2P9Z9KiMnGrllOaLue5curw022MSYAafe3ZthCExzMLOILRrGfSVMQC3
         4+dEdkpd1U1QYGKiXwQ0e0jVXHIi6ZB+Jkz8xojGIKrZ93nt7wyRTAxiVAc8tIszZ96V
         FOVqWseVfFJ2mtv/GdYww2mrJ/5BASjKKv4C4OgRgMMeok73wOOCPxkm3RfyitMv3nw4
         6pvA==
X-Gm-Message-State: ABuFfohtWyR9I4oiCHzHLMfuDjE0rXruZt6oTM6ZzkwV6X7meCio3NAc
        HeCxsHBd6nR2IvTdx3WEtFU=
X-Google-Smtp-Source: ACcGV631GjzcJ1bkf4CTshvZ3RYYYx22Bj5fca4VAOoiUnr0NK5FxSrgiDYBomFUL2nDbWDpB+gx2Q==
X-Received: by 2002:a63:b409:: with SMTP id s9-v6mr8572382pgf.437.1538030047151;
        Wed, 26 Sep 2018 23:34:07 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t85-v6sm1856246pfi.73.2018.09.26.23.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 23:34:06 -0700 (PDT)
Date:   Wed, 26 Sep 2018 23:34:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: On shipping more of our technical docs as manpages
Message-ID: <20180927063404.GB220288@aiede.svl.corp.google.com>
References: <87h8ihk7sl.fsf@evledraar.gmail.com>
 <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
 <20180926041517.GA2140@sigill.intra.peff.net>
 <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
 <87d0t0jghm.fsf@evledraar.gmail.com>
 <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
 <87a7o4je0t.fsf@evledraar.gmail.com>
 <20180926185812.GD30680@sigill.intra.peff.net>
 <878t3oj8em.fsf@evledraar.gmail.com>
 <20180927062011.GA1318@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927062011.GA1318@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Wed, Sep 26, 2018 at 10:44:33PM +0200, Ævar Arnfjörð Bjarmason wrote:

>> In terms of getting an overview it's indistinguishable from
>> comments. I.e. there's nothing like an index of:
>>
>>     man git-api-strbuf     ==> working with strings
>>     man git-api-sha1-array ==> list, iterate and binary lookup SHA1s
>
> I agree that is a problem, especially for contributors less familiar
> with the code base. But I think generating an index is a separate (and
> much easier) problem than formatting all of the documentation.
>
> We already have the /** convention I mentioned above. Could we have
> another micro-format like:
>
>   /** API:strbuf - working with strings */
>
> in each header file? That would make generating such an index pretty
> trivial.

Can you spell out the problem for me a little more?  E.g. if we had a
convention that the first comment in strbuf.h should say

	/* strbuf - Git's standard string type */

or even just

	/* Git's standard string type */

would that do the trick?

>> I'm also not in the habit of opening the *.h file for something, I
>> usually just start reading the *.c and only later discover there's some
>> API docs in the relevant *.h (or not).
>
> Interesting. I'm not totally opposed to putting the documentation
> alongside the actual code. It does feel a bit cluttered to me, but I
> think you're right that it keeps everything as close together as
> possible.

I've experienced projects following both conventions.  One thing I like
a lot about documentation in the header file is that it encourages
people to make the API documentation self-contained.  That is, you
describe the contract in a way that doesn't require reading the
implementation for details.

It took me a while to get used to this kind of convention but now I
really like it.  So I really do prefer to keep putting API
documentation in the header files in Git.  (Implementation
documentation in the source files is of course also very welcome.)

>> It means you can't avoid seeing it or updating it when source
>> spelunking, and it leaves header files short, which is useful when you'd
>> like to get a general API overview without all the docs. Our documented
>> headers are quite fat, e.g. strbuf.h is 60% of the size of strbuf.c, but
>> less than 20% when you strip the docs.
>
> I don't use folds in my editor, and I guess nobody else in this thread
> does, either. But they may be a reasonable tool for "wow, there are
> comments, declarations, and definitions all together and I just want to
> view one of them". In vim, try "set foldmethod=syntax" and then "zc" to
> close the folds.

I use kythe to get an outline view of the header files.

[...]
>> E.g. on Debian you can "apt install git-doc" and browse stuff like
>> file:///usr/share/doc/git-doc/technical/api-argv-array.html which is the
>> HTML formatted version, same for all the other api-*.txt docs.
>
> IMHO this is just silly. What am I as an end user going to do with
> api-argv-array.html?

In Debian we just ship all the docs.  For something like
technical/pack-heuristics, it's quite nice.  For the API docs, I think
they belong in the headers.

Thanks,
Jonathan
