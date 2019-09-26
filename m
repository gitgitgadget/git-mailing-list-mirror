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
	by dcvr.yhbt.net (Postfix) with ESMTP id 549EA1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfIZVyx (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:54:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32907 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfIZVyx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:54:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so7560379wme.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 14:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DSwKe0KjtBOENYEOi1Z1mliEUunJLgZvQlGp1vvqoDI=;
        b=oOtjscDtRkYBXGQ7NqVTFeDKKYUxeFS3okuVu/4U4NuhzD9mT0dzknJdRMqZ8RVOuC
         DJdAvJtgJoiWXTc+EMVFxa0a9+VxNHGOCrzQ224GfEQjBHP6jHZwmTxXav9OPIpqEl8c
         oOQDwYsjLpOn97Rmr917JUCxTWQBrgawKWxCWmejtgoXENN80aydusT4bfVcAcAUp+jH
         p7si4nOHG8QjblmN49iNY6OU6fRfqF0lOvF5EmppqS/8mqISkYd4B+u++X8/Y18HlDbV
         GqhFSYbJHNCAQC9CIVmGX0gy6dDrZEaUYj/74jImKVBkuP5ILm7B4wpX/gNSfwqcjcBI
         vERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DSwKe0KjtBOENYEOi1Z1mliEUunJLgZvQlGp1vvqoDI=;
        b=gqnoKAnACOVXFr8e8G8Z9EsBLWkcU3kLQXUS65gYUBXckXol06oGYa1XLMeibZRhiS
         rjVVCabPUXFGGupSXDSkaA7LgoolaQNPsr6gCD8kCD6r6+Ov3HdNk6LSBU6SfvBeFDLx
         QLCAn1j6OruhAH/K38FJAvj30uaCAfupk6RK+81dC8NIpuIZCEoPeEyw8/I+HjR8BDQ2
         56fSVLMnY8SNbX4kic5r9ej8RRzbJLE3d/QcDipcnyrz+rJrewze7hAJeuzTW8jUr9qo
         a/R7gzx3++QNHazYXnvQs3XApObTsJ/XH2wWS87qnJM9+z5h0pcFKYLK8Y/6H/5gTh4E
         iFUw==
X-Gm-Message-State: APjAAAUjST1z0A7bh6kp4Ec++HomEU5cR3Tgv70pr8XvT0lCEUYAm7R/
        mTh8m2kTlYjPq0DPwGR6IB8=
X-Google-Smtp-Source: APXvYqw3dfssAvGlSec6O5v5iaxs+vQa3dsHXk3wJfBlo5ngkDA7iolIPROrkuMww94NnP/7CayzOQ==
X-Received: by 2002:a7b:ce0a:: with SMTP id m10mr4645315wmc.121.1569534890887;
        Thu, 26 Sep 2019 14:54:50 -0700 (PDT)
Received: from szeder.dev (x4db9381f.dyn.telefonica.de. [77.185.56.31])
        by smtp.gmail.com with ESMTPSA id l10sm1158656wrh.20.2019.09.26.14.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 14:54:50 -0700 (PDT)
Date:   Thu, 26 Sep 2019 23:54:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190926215448.GJ2637@szeder.dev>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190904194114.GA31398@sigill.intra.peff.net>
 <20190923180649.GA2886@szeder.dev>
 <20190926094723.GE2637@szeder.dev>
 <nycvar.QRO.7.76.6.1909262132090.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1909262132090.15067@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 09:32:35PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 26 Sep 2019, SZEDER Gábor wrote:
> 
> > On Mon, Sep 23, 2019 at 08:07:09PM +0200, SZEDER Gábor wrote:
> > > Here is one more idea for microprojects:
> > >
> > >   Find a group of related preprocessor constants and turn them into an
> > >   enum.  Also find where those constants are stored in variables and
> > >   in structs and passed around as function parameters, and change the
> > >   type of those variables, fields and parameters to the new enum.
> >
> > Peff thought elsewhere in the thread that this is a good idea, so I
> > wanted to try out how this microproject would work in practice, and to
> > add a commit that we can show as a good example, and therefore set out
> > to convert 'cache_entry->ce_flags' to an enum...  and will soon send
> > out a RFH patch, because I hit a snag, and am not sure what to do
> > about it :)  Anyway:
> >
> >   - Finding a group of related preprocessor constants is trivial: the
> >     common prefixes and vertically aligned values of related constants
> >     stand out in output of 'git grep #define'.  Converting them to an
> >     enum is fairly trivial as well.
> >
> >   - Converting various integer types of variables, struct fields, and
> >     function parameters to the new enum is... well, I wouldn't say
> >     that it's hard, but it's tedious (but 'ce_flags' with about 20
> >     related constants is perhaps the biggest we have).  OTOH, it's all
> >     fairly mechanical, and doesn't require any understanding of Git
> >     internals.  Overall I think that this is indeed a micro-sized
> >     microproject, but...
> >
> >   - The bad news is that I expect that reviewing the variable, etc.
> >     type conversions will be just as tedious, and it's quite easy to
> >     miss a conversion or three, so I'm afraid that several rerolls
> >     will be necessary.
> 
> I thought Coccinelle could help with that?

Maybe it could, I don't know.  I mean, it should be able to e.g.
change the data type of the function parameter 'param' if the function
body contains a

  param & <any named value of the new enum or their combinarion>

statement, or similar statements with operators '|=', '&=', or '='.
I have no idea how to tell Coccinelle to do that.

