Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 199F81F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfFGBED (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:04:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44734 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBED (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:04:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id w187so268251qkb.11
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wuzi8mwsPbjIl9jq+nUZAlOiTf5lZP+mNJ2EKLA2WFc=;
        b=sVyfo5HldL9NZDvgO02rBKJfYdDNImXIVNgEPA2xktP0q+klmENCopFWOiiBwsG7mC
         kNfOMYYBvOsTHMjFSP9UsoX9aJjKWEEP2XEvd0FI89I2JCY4afhPdJRt2bYlREE58v6k
         RIm8ZrzSgSSpjdbUDc/c7kYEZf0gi74qYvTC5v78NOIlT++hemYGj7ImgF48raAJDVZg
         Pa5ywYQ6AhmHGbMIxbAtJO9HQYG2/YAZe8xoJJ1Sgx+SD9WdNQnVW4IiRdMZjxpKg4hh
         +/7axJdj1MHBJlgFFKcebTnvFY3NipCGPVvzJd+vBN+e8pdilULRf9qw1FyBkQhP2ggX
         1yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wuzi8mwsPbjIl9jq+nUZAlOiTf5lZP+mNJ2EKLA2WFc=;
        b=nxYPi3qdWWHT4+0IyAdS6fLsnyS/TCyKdCDzVNcGVuDSD57aw8xiO+/DazRKulgFDH
         TWmbqcByl907K5PJKXbZVd4jkD7bb7gMPYvV3Bfnh/i5DA0tLqOlDvbq2O6Gm7iWRfMZ
         zrGqrVWdV9lqgEZNJJIA/2HkDx20D3heXEgjJy7jxQeMyfS77hyYBYiO89T/wm+PDEZ4
         tCv9AQPlgQ1N70r7PI/gB5fx69ao5l5PGHtzeBTdLANlbnFVXpOaOSmiZi+yb7frbDvS
         VShTvZSB5ccGgc/6f4qDxBYzLTY3ozV2qDJEYDahNgpwJp+OeReU+Z38zzmZnKlocBMS
         dn2g==
X-Gm-Message-State: APjAAAXZjaRoiT808oN6Ix2u4LMQzMi5uxB6AjzuLljTMxiRRLkypvpg
        Q3rD04VV3iWJvfnanrmugzs=
X-Google-Smtp-Source: APXvYqymONO3wzNw/OuOhMlKzsTNf9xTocCNEzQ+i61fMKig4mBnKPFsRLiSRy3kiFVmr5KVxc6a5g==
X-Received: by 2002:a37:424a:: with SMTP id p71mr42410033qka.17.1559869441943;
        Thu, 06 Jun 2019 18:04:01 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id f9sm263927qkb.97.2019.06.06.18.04.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 18:04:01 -0700 (PDT)
Subject: Re: Git self test failure on Solaris 11.3
To:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeffrey Walton <noloader@gmail.com>
References: <CAH8yC8kynjwT8wbHYV0DpDaMX=AnfmXeOci3uYUnnfsvbq4iRg@mail.gmail.com>
 <CAH8yC8knkXtBii9KhS2iUo908zTx_NyPUgXZhqdwmwEF7Gz8Jg@mail.gmail.com>
 <CAPig+cS98DeSaF6pNqKCn6bAy=jjiTuc3AZpPB2cXm6hQ6vcqQ@mail.gmail.com>
 <20190606173516.GA25089@sigill.intra.peff.net>
 <CAPig+cQi6V=B7GtdN3+-1nPnLXiVjz-O+=WJt5f94o7wHy1VHg@mail.gmail.com>
 <20190606190503.GA3265@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0e75e5ed-3964-5027-1af3-23237674554c@gmail.com>
Date:   Thu, 6 Jun 2019 21:03:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190606190503.GA3265@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2019 3:05 PM, Jeff King wrote:
> On Thu, Jun 06, 2019 at 03:00:00PM -0400, Eric Sunshine wrote:
> 
>>> I can't reproduce the intermittent failure either on 2.21.0, or with
>>> v2.22.0-rc3.
>>
>> I can't reproduce it either on Jeff's Solaris box. Perhaps Jeff can
>> add "-v -x" to his automated build/test script in order to help
>> diagnose the problem if it occurs again.
> 
> Jeff: try "--verbose-log -x" if you're doing this as part of an automated
> run. That will leave you nice logs in t/test-results without dumping it
> all (and in particular, if you run the tests in parallel, it will avoid
> interleaving output from various tests).

Please keep me posted with any updates with exactly which command failed.
These comparison tests are intended to catch surprising interactions, but
are not very narrow. We'll need to know the exact failure spot, and the
failure could take a few forms:

* The git command failed with an error.

* The midx-enabled and midx-disabled commands differ in output.

Between these two options and the different commands that could have failed,
it's hard to dig in without more to go on.

Thanks,
-Stolee
