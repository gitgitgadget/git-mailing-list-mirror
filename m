Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0473C1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 02:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeHXGX7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 02:23:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36987 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeHXGX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 02:23:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id c6-v6so442322pls.4
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 19:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rykpVaHEdBUoPvcIWS/O780fELqyvrModjrO+erO//E=;
        b=pUre2OsrzVEClWFZ2zd8wSSmYcW5emTVwUxADnKDnJ/GWAxmB3yqdeAvO5Ky5rK2Vc
         ADYuoau3bu+cXaz6gCXrH1yngMWz+qngdjxoeX4r+yI9/DQPB4uHJt6JctUulCLVtJVj
         zQ1xvQtZNUNzCT6T47TPgCFm4dzQT4Vw+loO0pMAei95Hv4IKngtMgbhHEdnDf71gtZx
         nXjuHmvXvgmayOgjgSzc/Yx8JmuaCAg+bQ1J+5MgEqJ6hIUv5qL8ylBLH6dGsOAvKA94
         uZRfvv7NLEptlS6ZUAtJFuCsINvoSb+xF2d3VVvXx7HgZFjNaHDhvpBSrKxd02h9VkdM
         f48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rykpVaHEdBUoPvcIWS/O780fELqyvrModjrO+erO//E=;
        b=f2ZB1Q/dCYW30U7unMbpnxHRfPjnRpLAA0gC3a+4McxRaaMwe6Awh5hrm+leIzixVr
         +VBPMpVScqUPxSZpF0+lDlKA2DqlucDXvbp1kDSqbLH2B2Wbtu+MD8uTntzHjcrO9L1j
         i5BSjyYbZ+jKV3Kpni3nkvq/+xRollHdFD3QHYb3TVvwlDAt+LOuLlGJer2/jWpwOgXt
         t+o6sZuqWKEaoTBkCoUeE2/y2V59Nab1HCeCr9X3h2AdvxmBYiSN3QZ4RINztNpxXDRl
         gSczol9Cv/j6J4oqsIxmlp7RW407zHCFC/UUITRdz/INqEo/8eaN1oY3ftoE7tvrNqph
         qwqw==
X-Gm-Message-State: AOUpUlGQFsewuX9SLhx0Jj5Fn35kuhq9ONs7Fie5iowQcAheCTFE5wYT
        aVdy74kF/hdv7RTTZXGLH4A=
X-Google-Smtp-Source: AA+uWPxU7NG9raVo8NGpNtIdPHODXkDJBUCCnno7POAqpt5bQp0jqkD1HYYxHhoJGUjVjXwzly7Vcw==
X-Received: by 2002:a17:902:2b84:: with SMTP id l4-v6mr15396531plb.296.1535079085758;
        Thu, 23 Aug 2018 19:51:25 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h82-v6sm13976307pfa.173.2018.08.23.19.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 19:51:25 -0700 (PDT)
Date:   Thu, 23 Aug 2018 19:51:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Questions about the hash function transition
Message-ID: <20180824025123.GA186259@aiede.svl.corp.google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t4xfaes.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

>> Objective
>> ---------
>> Migrate Git from SHA-1 to a stronger hash function.
>
> Should way say "Migrate Git from SHA-1 to SHA-256" here instead?
>
> Maybe it's overly specific, i.e. really we're also describnig how /any/
> hash function transition might happen, but having just read this now
> from start to finish it takes us a really long time to mention (and at
> first, only offhand) that SHA-256 is the new hash.

I answered this question in my other reply, but my answer missed the
point.

I think it would be fine for this to say "Migrate Git from SHA-1 to a
stronger hash function (SHA-256)".  More importantly, I think the
Background section should say something about SHA-256 --- e.g. how about
replacing the sentence

  SHA-1 still possesses the other properties such as fast object
  lookup and safe error checking, but other hash functions are equally
  suitable that are believed to be cryptographically secure.

with something about SHA-256?

Rereading the background section, I see some other bits that could be
clarified, too.  It has a run-on sentence:

  Thus Git has in effect already migrated to a new hash that isn't
  SHA-1 and doesn't share its vulnerabilities, its new hash function
  just happens to produce exactly the same output for all known
  inputs, except two PDFs published by the SHAttered researchers, and
  the new implementation (written by those researchers) claims to
  detect future cryptanalytic collision attacks.

The "," after vulnerabilities should be a period, ending the sentence.
My understanding is that sha1collisiondetection's safe-hash is meant
to protect against known attacks and that the code is meant to be
adaptable for future attacks of the same kind (by updating the list of
disturbance vectors), but it doesn't claim to guard against future
novel cryptanalysis methods that haven't been published yet.

Thanks,
Jonathan
