Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5E791F453
	for <e@80x24.org>; Tue, 18 Sep 2018 17:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbeIRWxs (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 18:53:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43515 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbeIRWxs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 18:53:48 -0400
Received: by mail-io1-f65.google.com with SMTP id y10-v6so2191948ioa.10
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9Su6/o7viLMhFxH1ezDUml23dzXe+TSgmrVr43PF6OA=;
        b=y0NP3DyiOFQF1CbaLF9SYEOOGFNhvDc5RD4Klq9vrDz3JNKC8NF8QxbH7V8qXKn5XZ
         0FC9ulqJumoO1PqLqLwCUaWmQGoj6IRD7cjN8X6+iJNPbZMk9YTW+pjioSdGHh7Burfa
         LEtqOucQmdpYf3JKnMW8fQfm02HJ2UFKrZIIXnob/pN8X2uK9kgTRurwt4pQ2iTCgqvC
         1XV2SzLSWCVhppGO3PYY9JaFY+rnew4coWAkuiTWL93A9oaaEdkrNpbHJX+T57Xb+xI7
         E263JTPKm0KCLjXPCpatgNUrrSrpZP2RBqQmIBuIFC7ZEctxtsXzoDQktOUPMO1FzTwZ
         IP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9Su6/o7viLMhFxH1ezDUml23dzXe+TSgmrVr43PF6OA=;
        b=uOLJrxw2gZwWPOwyx+4bD/Ua1Rebh84iQ/HkMdyYzN5QC5Nn5i0/SoOUd/M20+aTkY
         coHOdwU1lYj45r/YdjPTuXlVHI07X6/6vGXKF1+2paUZKphC3X/Vaw4NpLaFFl8xh3hB
         9moO+ZD92F60QrrQAM1siLDaItP3uRmot1RkDe29eAwex/F4Q8vWDQPrL/woU85BO2Ve
         gnx9/AZS89LdVQrodOYVArlSHdrPUCGtPfbA2AJt6i26edTX+YrnmBJ9OpM3YAyaPGpv
         38X8JXesYWCC5TxIeGWxLrmBwxdf+0TdYxQn78emhnzMEsGqStO45/7KHD+CqJVCrTqy
         B8ZQ==
X-Gm-Message-State: APzg51CI5mFu2S+4DgyHMC/q69pzDuuv+7jy4YA2y79zmnnoXF9RiNZu
        lYlTew5HgD0HkVxUDy6srV6RYQ==
X-Google-Smtp-Source: ANB0VdbdBK4CXqRwxD9EBRJRB351Ikwrd0kh6g1qIOeV+Y11YWsZZpaSQOUh7hsUVvaBLY6U+So8pQ==
X-Received: by 2002:a6b:bd82:: with SMTP id n124-v6mr26138434iof.244.1537291213224;
        Tue, 18 Sep 2018 10:20:13 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id l186-v6sm4524996ith.42.2018.09.18.10.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 10:20:11 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 18 Sep 2018 13:20:09 -0400
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] config doc: add missing list separator for
 checkout.optimizeNewBranch
Message-ID: <20180918172009.GA83552@syl>
References: <20180816182653.15580-1-benpeart@microsoft.com>
 <20180918053449.14047-1-avarab@gmail.com>
 <20180918165707.GC72102@syl>
 <20180918171643.GC15470@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180918171643.GC15470@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 18, 2018 at 01:16:43PM -0400, Jeff King wrote:
> On Tue, Sep 18, 2018 at 12:57:07PM -0400, Taylor Blau wrote:
>
> > Hi Ævar,
> >
> > On Tue, Sep 18, 2018 at 05:34:49AM +0000, Ævar Arnfjörð Bjarmason wrote:
> > > The documentation added in fa655d8411 ("checkout: optimize "git
> > > checkout -b <new_branch>"", 2018-08-16) didn't add the double-colon
> > > needed for the labeled list separator, as a result the added
> > > documentation all got squashed into one paragraph. Fix that by adding
> > > the list separator.
> >
> > Looks good. Here's my:
> >
> >   Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
> I'm confused here. The signoff is really about agreeing publicly to the
> DCO, and providing a chain of custody for the changes. So sometimes a
> signoff from somebody besides the patch author is good if they
> contributed content to the patch, but I don't see that here (or in any
> nearby thread).
>
> Did you mean "Reviewed-by:" ?

Indeed, I meant "Reviewed-by" instead of "Signed-off-by". I grok the
difference between the two, but without thinking about it I typed one
instead of the other.

Instead, here's my Reviewed-by:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
