Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13DBB1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeIRCjd (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 22:39:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40096 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeIRCjd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 22:39:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2-v6so18761961wrw.7
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zDemK0kIKR0dj8ZzuPnP9rnE6m0Upr4QwFqgrEgH03M=;
        b=UABFyU0xE7M8cNe9dDvpGjDslQIRtDF8/72lftmcAP964Cx5x53fqeXxdzMq8YJPFt
         b5vd87bf0InJDrDmUEUWTWL/9IrIHUnY2Znjyh0upT6U3UFl3FHqBcGWNRiQn/bmgG17
         216nnNsJtEylmazp+poYdIpZAdJdpAS7LwIT4TPglbFIypbllHgoP8BmM3sZFpGVMWKP
         BNPXkH8dI/ldTWPfqVHvFnYOfXImwDIfJ7czFZ71qcHeMNbCN+r4aNkAEKDLjO7tMhlV
         9fWPfmbSZWj7ICQjGa8osmjVwivnvvuj2ELJTQEN2NMYAAjBmG3ZU/5FG4LPSvKxZFjJ
         kEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDemK0kIKR0dj8ZzuPnP9rnE6m0Upr4QwFqgrEgH03M=;
        b=pbYcYNi2PGsnGBLtESPbLHf9l3LzN2CrNJd7C09d3/u+EY3S3GUozoleEEL/6l02fC
         iqxhvDaY7RS5CZztkaADI1tM5mArGQojKssPegv1piGkH61L5sJkkDjnJUC60LvU08Aw
         sebVZT9/H+QA/lrjb/1Dt4PFlfNhk/dKm9suKl61YBenz8ERw4mMiYqPuqdorxhz45L7
         D1AKXa8S2GCA6DEpNIVMw90sR+2FUUL+R2dlz/1oA+n1jN/5ObzKapsSVOHLruAJ3QsE
         vycc4GVq72mrzqnpOZR/AaTiUy+bRbRlAvG2617bXjwapeZy2gihKe/cNzFDIdtI98KD
         TDwA==
X-Gm-Message-State: APzg51Ae3p1K1CCaNisLF1HlIibw46jcX1vEbI9utwi+5HzkIJBYVw3v
        2C1CxnTN9HEXK9Xfqv/YedgV8UYE
X-Google-Smtp-Source: ANB0VdZ7HjskM4Gl6ZMLZHyS4cvOolZ+0yFMzbyDsCC4DnLwn3VQRjxsgJeo//QUkujFm7CeKZKHBg==
X-Received: by 2002:adf:f749:: with SMTP id z9-v6mr21165476wrp.85.1537218627797;
        Mon, 17 Sep 2018 14:10:27 -0700 (PDT)
Received: from localhost ([2.28.194.193])
        by smtp.gmail.com with ESMTPSA id b10-v6sm252551wmc.28.2018.09.17.14.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 14:10:26 -0700 (PDT)
Date:   Mon, 17 Sep 2018 22:10:26 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] t5551: compare sorted cookies files
Message-ID: <20180917211026.GA4095@hank.intra.tgummerer.com>
References: <20180917191806.19958-1-t.gummerer@gmail.com>
 <xmqqtvmn6gra.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvmn6gra.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/17, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > In t5551 we check that we save cookies correctly to a file when
> > http.cookiefile and http.savecookies are set.  To do so we create an
> > expect file that expects the cookies in a certain order.
> >
> > However after e2ef8d6fa ("cookies: support creation-time attribute for
> > cookies", 2018-08-28) in curl.git (released in curl 7.61.1) that order
> > changed.
> >
> > We document the file format as "Netscape/Mozilla cookie file
> > format (see curl(1))", so any format produced by libcurl should be
> > fine here.  Sort the files, to be agnostic to the order of the
> > cookies, and make the test pass with both curl versions > 7.61.1 and
> > earlier curl versions.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> 
> Thanks.  f5b2c9c9 ("t5551-http-fetch-smart.sh: sort cookies before
> comparing", 2018-09-07) that came from
> 
>     https://public-inbox.org/git/20180907232205.31328-1-tmz@pobox.com
> 
> has almost the identical patch text, and this (presumably an
> independent effort) confirms that the patch is needed.

Whoops awkward, I should have checked 'pu' before starting to work on
this.  This was an independent effort, but I really should
have checked 'pu' before starting on this.

>                                                         The other
> effort implicitly depends on the expected output is kept sorted, but
> this one is more explicit---I tend to prefer this approach as tools
> and automation is easier to maintain than having to remember that
> the source must be sorted.

I'm happy going with either patch, but if we want to go with mine, I'd
like to make sure Todd is credited appropriately, as he sent a very
similar patch first.  Not sure what the appropriate way here is
though?

> Thanks.
> 
> >  t/t5551-http-fetch-smart.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> > index 771f36f9ff..d13b993201 100755
> > --- a/t/t5551-http-fetch-smart.sh
> > +++ b/t/t5551-http-fetch-smart.sh
> > @@ -206,7 +206,7 @@ test_expect_success 'dumb clone via http-backend respects namespace' '
> >  cat >cookies.txt <<EOF
> >  127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
> >  EOF
> > -cat >expect_cookies.txt <<EOF
> > +cat <<EOF | sort >expect_cookies.txt
> >  
> >  127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
> >  127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
> > @@ -215,7 +215,7 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
> >  	git config http.cookiefile cookies.txt &&
> >  	git config http.savecookies true &&
> >  	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
> > -	tail -3 cookies.txt >cookies_tail.txt &&
> > +	tail -3 cookies.txt | sort >cookies_tail.txt &&
> >  	test_cmp expect_cookies.txt cookies_tail.txt
> >  '
