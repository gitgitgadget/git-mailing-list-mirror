Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C0D1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 09:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfIZJr3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 05:47:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50721 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfIZJr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 05:47:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so1960613wmg.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wQ+fc7IAr54XoP6jJyAp1d2JySSNEy+U0j74CW1hSVE=;
        b=UWOXMPQi7/7QeAkno9oDr/pewhvzJ5x57setoT+s5txrUgLpgi51eoMh+SIlx14Y2i
         M6+tsJsqQYyskLvHMYR4CsxquZx0G3UUxCN5dRpHd01eTUiz9U1Em6JNW5zMzsKe5Kim
         TJVCSzUfksvhKihKEy8TKXbvvo7yQqvBfl0ekF0LI1vUj4clCpBDiaJ+SGO8e1EbXgXU
         MYuGNnrIjqCVnJdJCseROLzTvQL8hb0rgS0WAkFmMnw1avs2L2lQnKmybzaZxuPqdG7X
         ypJlv+wcgnpdNXLZuvI6N2kYpITXl37hs/HjTVrk3CxzqLIqT32Aa+h5/2GKXO2sf2iW
         m/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wQ+fc7IAr54XoP6jJyAp1d2JySSNEy+U0j74CW1hSVE=;
        b=eEcMp1eRLPZCIW37ABaan+1IQCpXkBrRF7UNNH1C8KCNVYUQBE0r+MViMJE6SLHfRc
         phlATRDEihYGmPoHiAIf6by745PajklVJbWvyAy+ncsPEEcrysYsH9gYtzzYhDENy2OG
         KIdrQSNVOc9bfBG+P+jHg8rtIcxCEbnLqQ5LH8R9H5Yvtvt3aJzBzxyunnwitnbmalkZ
         1GXKBZWvFF4aT43MzPcZEiWSYFRfDWgWQ7u0IZ8XU8ZQ45s2eS49um6cpNHC+RfzetuD
         c+BZCLrKCklMNj9HNbel9q4KDOMbsYgyOzo/lvzcmd4PJM+hlG6H/yqYtsUwHOXH6AGg
         NGpQ==
X-Gm-Message-State: APjAAAWB9KrqWGcsc/y4b3DZCJ9GzQfta6a7I+P3i7eb4e4Nz8bB0DP6
        BAXys0luDM8HXWWw124W0OH2zkyV
X-Google-Smtp-Source: APXvYqz9LqT8XALN87wcd8vVUolqhnRomUB3wDbZC5NeRwTlyfrmSn/+/IHJDHTlb6IT2zAvu5HSug==
X-Received: by 2002:a1c:ed02:: with SMTP id l2mr2135542wmh.155.1569491246898;
        Thu, 26 Sep 2019 02:47:26 -0700 (PDT)
Received: from szeder.dev (x4db9381f.dyn.telefonica.de. [77.185.56.31])
        by smtp.gmail.com with ESMTPSA id x16sm1851313wrl.32.2019.09.26.02.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 02:47:25 -0700 (PDT)
Date:   Thu, 26 Sep 2019 11:47:23 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190926094723.GE2637@szeder.dev>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190904194114.GA31398@sigill.intra.peff.net>
 <20190923180649.GA2886@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190923180649.GA2886@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 08:07:09PM +0200, SZEDER Gábor wrote:
> Here is one more idea for microprojects:
> 
>   Find a group of related preprocessor constants and turn them into an
>   enum.  Also find where those constants are stored in variables and
>   in structs and passed around as function parameters, and change the
>   type of those variables, fields and parameters to the new enum.

Peff thought elsewhere in the thread that this is a good idea, so I
wanted to try out how this microproject would work in practice, and to 
add a commit that we can show as a good example, and therefore set out 
to convert 'cache_entry->ce_flags' to an enum...  and will soon send
out a RFH patch, because I hit a snag, and am not sure what to do
about it :)  Anyway:

  - Finding a group of related preprocessor constants is trivial: the
    common prefixes and vertically aligned values of related constants
    stand out in output of 'git grep #define'.  Converting them to an
    enum is fairly trivial as well.

  - Converting various integer types of variables, struct fields, and
    function parameters to the new enum is... well, I wouldn't say
    that it's hard, but it's tedious (but 'ce_flags' with about 20
    related constants is perhaps the biggest we have).  OTOH, it's all 
    fairly mechanical, and doesn't require any understanding of Git
    internals.  Overall I think that this is indeed a micro-sized
    microproject, but...

  - The bad news is that I expect that reviewing the variable, etc.
    type conversions will be just as tedious, and it's quite easy to
    miss a conversion or three, so I'm afraid that several rerolls
    will be necessary.

