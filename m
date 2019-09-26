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
	by dcvr.yhbt.net (Postfix) with ESMTP id C6AD01F463
	for <e@80x24.org>; Thu, 26 Sep 2019 13:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfIZNnr (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 09:43:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38544 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfIZNnq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 09:43:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id w12so2143671wro.5
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2M2OCBF/cnXAZSKH0/9Zo6Uv7mWs6yKOw+9OzEwecSA=;
        b=oR74oG0GTDfJB6UQUeMCcixF8RzH3jigNH5HjsP7VMeQYoetdAa6hZRsy/24p4rp9W
         vNh8t+b1mbzHAGjGWhmqGVE51oQadf32ti62el+h8sjLype+lGOZedtEe25uXndHEeVV
         dctyfFKzfnEY5XwP18SNVk2JVr3tAXfX0IVdlDbsFHNNiZCLgJk0bANwxThgar0OtLo7
         aSgK5QLbiK8h5OWUdoTZtKuQPh7qyUREro7dnICpO0hfpcb09qKItT2LMyoan2vMuQ86
         IGD7z/azIz05wT3lqCwBdzqXLdXlRhhu53QGO9AZSULnB2R+raHCnI/HgUqCEAPNH13x
         sXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2M2OCBF/cnXAZSKH0/9Zo6Uv7mWs6yKOw+9OzEwecSA=;
        b=fx79sNzitjHMEIlroQYynA2TeT3WSWDeaNclDvhAX0aVi0OQCH8IQS77a2BqjUB+Nt
         WivfPEzOC/Rabyv++Z0wcoQztBo6ia7s8GIuFuG/+TzCmQOYx5MfeQuC8D0CQgU4YnQ4
         8Gd9J8fvhTYhqRR0HqfrnZWkzpORjOuErICeq3UJNWDlkt9wGt7sfy8Dwa7DxE+IZEwo
         6aucW0xz+kbZGPwWy0gRLcp0YzVXf25lYZfM1m1Yea/TzgoTSwfP0bQ/qQwByU4XkJgT
         74l6EFOz8aHQ50I/Z0iFaGUcyNboeJhcyLb45Vd2VPlF2qaEZiae4wdX8jG+6PHHq8R8
         2/0g==
X-Gm-Message-State: APjAAAVTyqgwFFg+xZQJqXUuBbmAbBTSitt0idR6ExC8+/OLSUwrTXGx
        5BbE+lIVtPn4rPyIkSm9PEs=
X-Google-Smtp-Source: APXvYqxmZPyFlizCLE51LgNjg9+sUaHfL8OBDXyfX4wID1V98lCGb4rGWniRrT5fjlNrRV9W+6/cCw==
X-Received: by 2002:adf:e84c:: with SMTP id d12mr2920525wrn.373.1569505424746;
        Thu, 26 Sep 2019 06:43:44 -0700 (PDT)
Received: from szeder.dev (x4db9381f.dyn.telefonica.de. [77.185.56.31])
        by smtp.gmail.com with ESMTPSA id t6sm4998944wmf.8.2019.09.26.06.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 06:43:43 -0700 (PDT)
Date:   Thu, 26 Sep 2019 15:43:41 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: sizeof(var) vs sizeof(type), was Re: [PATCH] git: use COPY_ARRAY
 and MOVE_ARRAY in handle_alias()
Message-ID: <20190926134341.GG2637@szeder.dev>
References: <d5eef24a-faa8-d6f3-c9e5-f13dc40219d4@web.de>
 <20190923222659.GA22645@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1909261521380.15067@tvgsbejvaqbjf.bet>
 <b79f52f7-4a7e-f7cd-ed8a-cb6cfbadd7b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b79f52f7-4a7e-f7cd-ed8a-cb6cfbadd7b2@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 09:36:44AM -0400, Derrick Stolee wrote:
> On 9/26/2019 9:22 AM, Johannes Schindelin wrote:
> > Hi Peff,
> > 
> > On Mon, 23 Sep 2019, Jeff King wrote:
> > 
> >> On Thu, Sep 19, 2019 at 10:48:30PM +0200, René Scharfe wrote:
> >>
> >>> Use the macro COPY_ARRAY to copy array elements and MOVE_ARRAY to do the
> >>> same for moving them backwards in an array with potential overlap.  The
> >>> result is shorter and safer, as it infers the element type automatically
> >>> and does a (very) basic type compatibility check for its first two
> >>> arguments.
> >>>
> >>> These cases were missed by Coccinelle and contrib/coccinelle/array.cocci
> >>> because the type of the elements is "const char *", not "char *", and
> >>> the rules in the semantic patch cautiously insist on the sizeof operator
> >>> being used on exactly the same type to avoid generating transformations
> >>> that introduce subtle bugs into tricky code.
> >>
> >> Another good reason to use "sizeof(var)" instead of sizeof(type)". :)
> > 
> > That is indeed a very good reason, in addition to getting the type right
> > automatically (by virtue of letting the compiler pick it).
> > 
> > Should we make this an explicit guideline in our documentation?
> 
> Better yet: can we create a Coccinelle script to fix it automatically?

I've already done that well over a year ago :)  But remember not being
quite satisfied with something (no idea what it was anymore) and left
it on the backburner.

Will dig it out and have a look as time permits.

