Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE9E320248
	for <e@80x24.org>; Wed, 10 Apr 2019 01:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDJByU (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 21:54:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43279 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDJByU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 21:54:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so340931plp.10
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 18:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1nuqgmi48TnHsoB6/yIpAgQPStRF/BbuZpocgXuEwsE=;
        b=dKWViMgKwDRz+1OVaDWA0yvH2Xm+jhZr0lE/Jd15YSP/wcVtGILSU7P/JCL20+abIW
         xybj8iDRcOMJv3ObRCROMKZoZ1hetB9pEnjMBINyyqu2dJnUYVYfeYd2meeqR+68auYL
         nCwSra0E6WUL+emneLGTKJVKOlqdsddJf/1het+7hY3A8xUoAABotyKdpgSGJqNYm6wL
         3qTu0XQruvNBEi5JLhjfHleFF9f8aeFdRREQlSyVezRbvoN88dojsPEScmRPx+xiqBbc
         865YVty5pho78aeDgxiUMqMpIKJK4ig7O/1uXVlx/kWfIQ4If440YC2bL6ZM5ROvmM7y
         xVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1nuqgmi48TnHsoB6/yIpAgQPStRF/BbuZpocgXuEwsE=;
        b=kcBG+8W9Xr7AtJiah2SBQPDaF6vkClb55tzsXZG05rJijgNOebeOYOqBn6CHWSIm2u
         5R1FLT2sx72tDrlzNdU/YLZDybit7r4FsnrSECF/rYbQ25Lajdk3FKkOa7O0cAuxoM7J
         tLM0Qmxgc98i5krjrvzykT5iU+aBwWsl3AHxhgUkV9ZEJg+nabw6YwpLX/+uCqphtz6N
         Di6ORihUJnzzm9KvC0qRcD/Sz7BDBnWtx8Qw2a+Mo/gkhto1ZgzbyOOIBpBmMmd2y5Jo
         J/ThkkTqpc7tyuGjL+yUOV+whV9wFVXN6CM/2sVuwe3P75HVRGgGPcW8LLD7IX1To9tL
         1jIg==
X-Gm-Message-State: APjAAAUbWqLG4zsshk2+HGs4Wg/1L253H2MqMIG8G84zTrIesLgqmF82
        vTDpWMAHeQEbAbmtdZbwrHG6CA==
X-Google-Smtp-Source: APXvYqyVBOZlDX/6UFzeYYW+Bbp7Y3K0xpSRu5FY4C4AWqBVsTREj7rL+0ihfYeNiTfv5h7GgPAHAQ==
X-Received: by 2002:a17:902:396a:: with SMTP id e39mr40686881plg.220.1554861258616;
        Tue, 09 Apr 2019 18:54:18 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:c47d:9491:9418:887])
        by smtp.gmail.com with ESMTPSA id f87sm69262307pff.56.2019.04.09.18.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 18:54:17 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 9 Apr 2019 18:54:16 -0700
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190410015416.GA56470@Taylors-MBP.hsd1.wa.comcast.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev>
 <20190405182412.GC2284@sigill.intra.peff.net>
 <CAPig+cQ7f6C-YBE5LT3qiXSyjpqQQEknmE8eHdQJvzCAzkBNPA@mail.gmail.com>
 <xmqqbm1h9et2.fsf@gitster-ct.c.googlers.com>
 <20190409023055.GF81620@Taylors-MBP.hsd1.wa.comcast.net>
 <CAPig+cS+4tTAAWsp+KX2-__kcvgDABQQCmz63d6pQUa6Qu3LKw@mail.gmail.com>
 <20190409050857.GI81620@Taylors-MBP.hsd1.wa.comcast.net>
 <CAPig+cR6v_+nmGLsnoSz6K262hQfC1R9Xdk8CfuHcx6MduZfcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cR6v_+nmGLsnoSz6K262hQfC1R9Xdk8CfuHcx6MduZfcg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, Apr 09, 2019 at 04:02:23AM -0400, Eric Sunshine wrote:
> On Tue, Apr 9, 2019 at 1:09 AM Taylor Blau <me@ttaylorr.com> wrote:
> > On Mon, Apr 08, 2019 at 11:28:19PM -0400, Eric Sunshine wrote:
> > > I suspect that Junio's "Looks good" was referring to the 'sed expression.
> >
> > I think that you are right -- and I'll happily _not_ introduce more Git
> > on the left-hand-side of a pipe instances.
> >
> > I noticed a few more instances in t6102 [...]
>
> Indeed, SZEDER mentioned those in [1]:

Aha, thanks -- I'm not sure how I missed that in [1]. Credit is given
where it is due :-).

>     Don't run git commands upstream of a pipe, because the pipe
>     hides their exit code.  This applies to several other tests
>     below as well.
>
> [1]: http://public-inbox.org/git/20190405105033.GT32732@szeder.dev/
>
> > I wrote the following patch, which I've folded into my local copy (and
> > will send with v2):
> >
> > > With all the recent work of moving away from having Git upstream of a
> > > pipe, let's not intentionally introduce a new instance. I wrote the
> > > example 'sed' expression that way merely to mirror how the original
> > > 'perl' version was written to make it easier to see the equivalence
> > > (not because it was intended as an endorsement of having Git upstream
> > > of a pipe).
> >
> > I see, and thank you for the clarification. Let me know if you like the
> > patch above.
>
> Looks fine. Thanks.

Great -- I appreciate your review. I'll send v2 shortly with these
changes in it.

Thanks,
Taylor
