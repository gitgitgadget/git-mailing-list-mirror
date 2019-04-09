Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA8120248
	for <e@80x24.org>; Tue,  9 Apr 2019 02:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDICET (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 22:04:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44772 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDICET (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 22:04:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id i2so8339353pgj.11
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 19:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iRAXNXGLIKpvBCpBtEz55gr6ISG67xFoJ1TaLeG6/EQ=;
        b=xoySEA3llqiAVHXK/7iyeM07aUy7iBVFubYUOQa2/g9Ct1n80tHwvVajowwuhcGVyg
         u8XBKzszFMrc1M1nv61RAqu8CmIrSHNgkp6UflEMHgqhH7uhSFXM7APYqxtaiKeDDs9x
         xexCibJEDEkEWYEcVEQyJ6/L5IqoRj9BhqNlKr7OHmAY2iFjCNaHgFVXJ46tmuWgzjhx
         Kb+4gEzDBQ40k7lj86pIjt9bDCbmnlQK8ygPl6BM1/olXHm0TbH27I+lvC255BiL57PD
         NjsNv58alkzXywaFBx2loek4xnXz9FUWhe0KZPDLgMEDE2Xu85TnkDCDtkDTMEV0HYw9
         sRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iRAXNXGLIKpvBCpBtEz55gr6ISG67xFoJ1TaLeG6/EQ=;
        b=G0tfFBhC8X6wbNNyq1lGplcHAFWBD8XvBgwWr5lgh9+PRmyWGViI8OJMSiZEwJnJI5
         m2zTuNaOKz0j8ise0S23HvaBHFchcoRvLqkdXWxMT3ufS1djmFqVTXUNqzjS/MKO+pE/
         4SNnNb7Lazre6sW+O0V1cLSgJ9q1U/xwrzbz9LZ98HqSZJCb61PkuekrvPGt0lfg4Tm4
         3SuMfhiwRA2M0iV6cBZFH5MD0NF+RLL1AmFkY9c+1uZRGL64UGX6+ngcHDjbBdQxnwot
         Cv76v5V5ipoyAHfbDa47NY+JsWffuxHvsgGhJShf1kATKu/0cNHEGSvVCkBs9itYKEmr
         fqKw==
X-Gm-Message-State: APjAAAVWPBaLPigqj5XFpKNFZSDbwNWi8GnPj4RGUL4K60nog2UUGJvt
        NnzUrQfUO+UDcRzfWeGBMD2JXc7RiE4yhg==
X-Google-Smtp-Source: APXvYqw4kdyccFrLAJNNQ7baGU0FoUjlwUQyY48K6e2AFyyQNqlLkhbZOP932srYyUh7ZS+Bb8nJcA==
X-Received: by 2002:aa7:8d9a:: with SMTP id i26mr21571011pfr.220.1554775458294;
        Mon, 08 Apr 2019 19:04:18 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d869:cd1a:616d:3c11])
        by smtp.gmail.com with ESMTPSA id m25sm42556668pfa.175.2019.04.08.19.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 19:04:17 -0700 (PDT)
Date:   Mon, 8 Apr 2019 19:04:16 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC] TODO in read-cache.c
Message-ID: <20190409020416.GB81620@Taylors-MBP.hsd1.wa.comcast.net>
References: <CAMknYEPS68VEkUbNxeKQvVDGjzVpBXKNAi3uA04pLwN9k4ZTfA@mail.gmail.com>
 <CACsJy8AnXawOgC0eWKpSF7iGXAvPdP9=SZX1HePRABVdkiKs8g@mail.gmail.com>
 <CAMknYENJogZ6vxs3zxivD3TPtDnfE9DFQDTwri+eLJmTwr4zxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMknYENJogZ6vxs3zxivD3TPtDnfE9DFQDTwri+eLJmTwr4zxw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kapil,

Welcome to Git! I am thrilled to see new faces on the mailing list.

On Sat, Apr 06, 2019 at 05:43:56PM +0530, Kapil Jain wrote:
> On Sat, Apr 6, 2019 at 5:33 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > trace2 API can already take 'struct repository' (the_repository is a
> > pointer to 'struct repository'). I'm pretty sure the purpose is to
> > _not_ pass the_repository (because it implies the default repo, which
> > is not always true). Which means you read-cache.c's functions need to
> > take 'struct repository *' as an argument and let the caller decide
> > what repo they want to use.
>
> right, i mistyped.
>
> > In some cases, it will be simple. For example, if you have a look at
> > repo_read_index(), it already knows what repo it handles, so you can
> > just extend read_index_from() to take 'struct repository *' and pass
> > 'repo' to it.
> >
> > Be careful though, repository and istate does not have one-to-one
> > relationship (I'll leave it to you to find out why). So you cannot
> > replace
>
> should i run all the tests after making the changes, or are there some
> specific ones.

It is a good rule of thumb to run 'make' in the testing directory (this
is 't') at least once before sending patches to the list.

Generally when I am writing something, I will often be fixing some bug
and either (1) have a test that I know I am trying to fix, or (2) write
a test that is initially broken, which I then aim to fix.

You can see a good example of this in the last series that I sent to the
list [1]. In 2/7, I introduced several failing tests, and then fixed
them in the later commits in the series.

I also like to have a full suite of tests run on multiple platforms
before sending to the list. I have my fork [2] configured with TravisCI,
which runs builds on a number of different architectures/compilers for
completeness.

Git already has a .travis.yml in the repository, so you don't have to do
any work other than authenticate with TravisCI.

Thanks,
Taylor

[1]: https://public-inbox.org/git/cover.1554435033.git.me@ttaylorr.com/
[2]: https://github.com/ttaylorr/git
