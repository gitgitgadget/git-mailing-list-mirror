Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35B520248
	for <e@80x24.org>; Thu, 28 Mar 2019 20:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfC1Upv (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 16:45:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35119 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfC1Upv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 16:45:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so300896wmd.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 13:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ye9gyIvQmmrIV5n3MOTF94lTM4uhggIbUIOJCbC5c60=;
        b=Ke+5e7G7XhkCqwmO0xok+0Ph6nxCev7DeFJF5pMtjxBkTnm3QQjTeoJtTXSqKYGvB0
         G0Vh6eQKmbkv6i4IgMigPN3lZkklG4BrhEY4E89ahad0f3aqWSEjCpUDIvqe8D/girR9
         wpqkPU6DdP6FlFbByXT91/eQSt7qGuKmMF3rGHDS9Msua3Q3lz1X85Q61pkVxFMgA4Ic
         8d5J205OP19fobSYztX1ResAXRk1YI0MvCRvUMN3RQeOosKLHQA051Kn7dUWzU97wprh
         u/+vbs3GcUpbAjbKpSLhaxedgQVFyOjw1LXv8QIfZhrQ26joRC3/D1NvbGOOLfnmBfEL
         TaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ye9gyIvQmmrIV5n3MOTF94lTM4uhggIbUIOJCbC5c60=;
        b=WwF6kWMPMhYgl3stfcv6i9S8xrMV+wanVT4QcAIrxwFIwos+W0FvjolNfBioG7dR1d
         bBy/sU5TcUGm7kkaWOfNGuY+CfMOH50Y0ptlpXuNgrpN6wmiQOBYC9RYXeqC59xT5ZV1
         K4jTchYNvJ8SMTxoMXDru/l2gv2IVdZtYf9UMPl1ymzofiwli2zupRI5FPVlnFRRGRR8
         Hm3BjTloA0D0wJnv/fHeapUoaGFT7vdj6rJLUfUhpKmzEkre8VMTRkW9QybzwP8sMWwO
         +jKQvZfecGK/tVJ8/wx+vIpOo1UoYsn5gAknE0h+vjdfOmpDOmayEWnMugcTQy/W0zNT
         SNWg==
X-Gm-Message-State: APjAAAXLzymFVuRVuf4vx0CDy6Zbjxl473BMKTxrdPuVKWaXewznGe6o
        NNeJblbg+MH0mWeBGq5ojx0=
X-Google-Smtp-Source: APXvYqw/iOoj3Rq0g8ET8gzq4PR37cxPbJaY3NV0cuRQr8FaGTf+1rTFqwtytYGm7uRkif9+CW/QcQ==
X-Received: by 2002:a1c:cbc5:: with SMTP id b188mr1291655wmg.87.1553805949413;
        Thu, 28 Mar 2019 13:45:49 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id d17sm70620wrw.88.2019.03.28.13.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 13:45:47 -0700 (PDT)
Date:   Thu, 28 Mar 2019 20:45:46 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Kraai <mkraai@its.jnj.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] stash: setup default diff output format if necessary
Message-ID: <20190328204546.GG32487@hank.intra.tgummerer.com>
References: <20190319190503.GA10066@dev-l>
 <20190319231826.GB32487@hank.intra.tgummerer.com>
 <20190320224955.GE32487@hank.intra.tgummerer.com>
 <20190320230942.GA28455@dev-l>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320230942.GA28455@dev-l>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20, Denton Liu wrote:
> On Wed, Mar 20, 2019 at 10:49:55PM +0000, Thomas Gummerer wrote:
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index 97cc71fbaf..83926ab55b 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -612,6 +612,24 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
> >  	test_cmp expected actual
> >  '
> >  
> > +test_expect_success 'stash show -v shows diff' '
> 
> s/-v/--patience/
> 
> Missed this in my last email, my bad!

I see Junio already picked this and the fix for the commit message up
already.  Thanks both!

> > +	git reset --hard &&
> > +	echo foo >>file &&
> > +	STASH_ID=$(git stash create) &&
> > +	git reset --hard &&
> > +	cat >expected <<-EOF &&
> > +	diff --git a/file b/file
> > +	index 7601807..71b52c4 100644
> > +	--- a/file
> > +	+++ b/file
> > +	@@ -1 +1,2 @@
> > +	 baz
> > +	+foo
> > +	EOF
> > +	git stash show --patience ${STASH_ID} >actual &&
> > +	test_cmp expected actual
> > +'
> > +
> >  test_expect_success 'drop: fail early if specified stash is not a stash ref' '
> >  	git stash clear &&
> >  	test_when_finished "git reset --hard HEAD && git stash clear" &&
> > -- 
> > 2.21.0.226.g764ec437b0.dirty
> > 
