Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2561F403
	for <e@80x24.org>; Thu, 14 Jun 2018 18:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755220AbeFNS13 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 14:27:29 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:41012 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754819AbeFNS12 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 14:27:28 -0400
Received: by mail-pl0-f50.google.com with SMTP id w8-v6so2478150ply.8
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EuuknzPBlDRdXFjtJQ5dZ9RDVMlNtTMv0u+3fYz4vrs=;
        b=ONdQBk/CPzSrCkBkzs7PgL/dxBYqhzUhR9AQawDrTJDsFbEAzOvqcBG2amfqSvTXSp
         r2F0ZjDu6f1oPHja1MfPXql32FP1aqyh+UsFB73Fmz2KKBnJls56MZ9TlPw2qV0TFY/u
         kCcIjpwrQ7DIw0iKsa2GjmceQ/8oMR/NLqBFkpxgatV9jrMX2QqU7AnyojxTXZqHnHo4
         Mr4bmK7KL6jb6YZj5zdAYw/aPdKApfnKAMQEr9dSmICejrayrcsjOESwtAwUFj2twowF
         lDQxi9KkpBrl4rxjRZBZ13Fk5YIx0h4jCw26wd/pJvFDvOj2LNQdC4tqcPh1STnEgS06
         Lq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EuuknzPBlDRdXFjtJQ5dZ9RDVMlNtTMv0u+3fYz4vrs=;
        b=lFFYGF6k+dIcS+FkoGFIk583PhHss2gb8dRySY/bHLsozrZWXOld8g/EFVJ5/8K+Da
         fMzKLXVbcAfU+ix5di9liQrxDbHy4vvrpCSYw+E7TpFsS43kIk+nKQRnQdZK0B6j5XAD
         GVh8YqJ8at1JWi9ShzZdDpYAz7TGfglPyq8aK8Kaz5jdUzn/DKlsLjz+hyNfvYOt+IjS
         nvscdBZvR46vj+OJ2Ck1ALmpXLG3W+g7upG6qmzfhFELh9A9xu0ANzSsmK7cwaBhPluE
         o8iBLsYrj9BOsE8M/vybSqz9X2xohl1qyySvRX6esabCZlb3DgY6mRaNPiIldCJs3S4J
         gAyg==
X-Gm-Message-State: APt69E3kPYaxQBZmRa02SW/iaSEOksVDBPZNnZJy3gNC9sa6CHvpdDEk
        scnpdBez+mV3y1KmIHLWWupSAa0PmCI=
X-Google-Smtp-Source: ADUXVKJH0D3FNjqJYoa0GC8KLRxNMgjs7/UzraH9hjTy36h1REUaGOg727Px7JsBZDnbzQFBFkJ6MQ==
X-Received: by 2002:a17:902:7406:: with SMTP id g6-v6mr4165458pll.90.1529000848048;
        Thu, 14 Jun 2018 11:27:28 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id h9-v6sm12939960pfj.77.2018.06.14.11.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 11:27:26 -0700 (PDT)
Date:   Thu, 14 Jun 2018 11:27:25 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 00/31] object-store: lookup_commit
Message-ID: <20180614182725.GG220741@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
 <20180613230522.55335-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/13, Stefan Beller wrote:
> * removed mentions of cooci patches
> * added forward declaration of commit buffer slabs.
> * dropped 3 patches that add the repository to lookup_unkonwn_object,
>   parse_commit and parse_commit_gently, but were not converting those
>   functions. We'll convert these in the next series, as this series is
>   growing big already.
> * This series can be found as branch 'object-store-lookup-commit' on github,
>   it applies on top of nd/commit-util-to-slab merged with sb/object-store-grafts
> 
> v1, https://public-inbox.org/git/20180530004810.30076-1-sbeller@google.com/
> 
> This applies on the merge of nd/commit-util-to-slab and sb/object-store-grafts,
> and is available at http://github.com/stefanbeller/ as branch object-store-lookup-commit
> as the merge has some merge conflicts as well as syntactical conflicts (upload-pack.c
> and fetch-pack.c introduce new calls of functions that would want to take a repository struct
> in the object-store-grafts series)
> 
> As layed out in https://public-inbox.org/git/20180517225154.9200-1-sbeller@google.com/
> this is getting close to finishing the set of object store series though the last
> unfinished part of this RFC hints at new work on the plate:
> * To give this series a nice polish, we'd want to convert parse_commit, too.
>   But that requires the conversion of the new commit graph. Maybe we need
>   to split this series into 2. 
> * Once this is in good shape we can talk about converting parts of the revision
>   walking code,
> * which then can be used by the submodule code as the end goal for the
>   object store series.

I've taken a look at the series and it looks good.  I'm glad we're
getting closer to this set of series being completed.  Thanks for
pushing this through :)

-- 
Brandon Williams
