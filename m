Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F75220966
	for <e@80x24.org>; Fri,  7 Apr 2017 16:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934255AbdDGQxT (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 12:53:19 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33055 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755546AbdDGQxR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 12:53:17 -0400
Received: by mail-pg0-f54.google.com with SMTP id x125so71813383pgb.0
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/6JPm94D9fe3qoK2vn+UWF2kv6iJgU5+0pku6uNIqRA=;
        b=dC9VWB9oB6U6qFCFCNN53POK/i1pvll6K5dBMoXxxaE5zRSc0ziIFEaYBivud/dQfg
         n7M2/KB6rh0Fo1z/fR0hYMIq0zjcMlY4KPRWb9nNdkOf1ABpuKI8BSP2SWI9aIONPxXF
         OR4V4YHVhFLbH+LZDqqRUsczDbaif3xwVHeBqw/w7/t7FZldA64N/8jGDJz4GWUtTdJm
         2Qp2Dne8MXM52oWEf3jzZ+qousm64bQuCrj7w0xx+yqeNgIdYBs42uJ0bTYLhp7qHkQ6
         UyOej4XHvAkBWW29Mt25zrL6j1mg82zqxe4GoK0tkEtTzkOd35rWJNR716nojgmvzBEm
         iiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/6JPm94D9fe3qoK2vn+UWF2kv6iJgU5+0pku6uNIqRA=;
        b=LCZk0eGvPROxBuDgRhs5Zbf0kcLb/fk1i1KDLh2NEZJVBF4guKuQXaNmVgg4ugO9Av
         VzoPTDHcZKkhHjg3Uu+EJ/PPM5+0/6YKxMkV3JkqPOzXa1d1yk/8/i7K338eFQjk0hie
         Bo9S3+Y31+NTAIs8bgFTpkymtWqmyz69jHuYjw6q4LokbJnRfAD2TEx277fHxn1pNv4B
         y1Dd7Hd9/YtItkBMcp88s3FPLK1niwMNfSZNvN412uH4/38XhBY6YZ1LowGBSX1NpQks
         uCjJ8WTgKHwH0soZNYNbi9txONsXRujTTaAfgJyMm8w0r9tSKQEQQxI79lGPVTK2jJ/2
         L75w==
X-Gm-Message-State: AFeK/H2rOGTkjR3TxIpY66JPaj4cmtOfbQhe6aYfPb8k/Fe8KBw4k3KGXMU4ZJt69h3Iq6vY
X-Received: by 10.98.216.202 with SMTP id e193mr40476995pfg.80.1491583996761;
        Fri, 07 Apr 2017 09:53:16 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:70c6:863c:4bc7:6d4f])
        by smtp.gmail.com with ESMTPSA id v11sm10648190pfi.50.2017.04.07.09.53.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 09:53:15 -0700 (PDT)
Date:   Fri, 7 Apr 2017 09:53:14 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: problem with backslash in directory name
Message-ID: <20170407165314.GB142670@google.com>
References: <9e3af7d6-a2c1-2673-53cc-d4c5105d9051@durchholz.org>
 <20170407063057.yjbqavu4uiipslpc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170407063057.yjbqavu4uiipslpc@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/07, Jeff King wrote:
> On Fri, Apr 07, 2017 at 08:12:49AM +0200, Joachim Durchholz wrote:
> 
> > So... something inside "git submodule add" is replacing the \b with a
> > backspace control code.
> > [...]
> > Whatever that "something" is, it is not doing shell expansion, otherwise it
> > would have started an interactive calculator session.
> 
> Probably it's "read" which does backslash expansion, but nothing else.
> Just grepping git-submodule.sh, some of the "read" calls should probably
> be "read -r" (I also don't know how some of those loops would cope with
> a submodule name that needed quoting).

So I blindly converted all "read" calls to "read -r" and tested against
the case Joachim ran into and it seems to solve the issues.  All test
still pass too (though that may not mean too much).

-- 
Brandon Williams
