Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9052C1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 23:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfG2XaH (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 19:30:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40380 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfG2XaG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 19:30:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so28784411pfp.7
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jxhivQFHrQ4Mk/+HvLZ5Oa8YTdU2ga4NU+tE2pDHWHg=;
        b=Jjpe3rIWJNuIH7H6o5T6TKM4DqafdRR/7FaQCXPHlth6iylIrahu+V2IxgVJqq4wPH
         QNZsC0v+ULd/RjH30gEWr/ZGTCCSDvYKKo2SMRwg55p1Ydc8vxDAQ0Zejsdriy75pkwH
         kptEKozoTwG8Xk2MQVpyT4OFIBg8E5sHviCwjTIm4Dbh9La+0m70UuqeATJbp140KuZ1
         YeUl3mVMCPlIQAJ7ym9vZ5XrRkFqXUkNOwCEzJ9zkRte58GFm1vTf97kNEEayBTEx7uw
         ROf4cwK19tOtVwPZ210UndCPjCq+Ek/1VAYTz/Ay971GWeX7ijrvqPInblX2lZU/cvln
         +b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jxhivQFHrQ4Mk/+HvLZ5Oa8YTdU2ga4NU+tE2pDHWHg=;
        b=CrqmPGfHvukHwcmSf6P06eHscT+DTXw3C5gMmRsgEF3mJ/Nk3Th42nJGsqrsuEE8iC
         F/75qMGDPrJSpKgHeRXi+WWMqZNfMaduAWlh1B2Pe2rsj91l7AJcplHIi5DpxyoExOH/
         FzrItXMm1W/oqmGznil03IXXkKhyYzFPCyeKQRZmmm68hWGItWSDq1db4JWf9Sbb1q4b
         eydkGhqffxhzujzXX6uCXKSHVInr6PLxbhM1M8FJEm3zCr1hDwhoCLE3ARYBMZOtwGFg
         b9YaJ25CQBqIt4lPE13upNGLaJq+4l/gtOV1zdd0DtQTJJ69VtZy8GGO4jLYGH7V6GFQ
         5xMA==
X-Gm-Message-State: APjAAAVIROTDjaZIZ0QlT1HWI1kd8fRRQMC61zYuq3PDHNhUuPvXRYBX
        jqQiRWWVIE+kc19E+ESBrJOQig==
X-Google-Smtp-Source: APXvYqwcjoCAb3G1LdFycuK2wY3dYxh6y0qYxc0NnIEvu5XRi0IusP9zw+KQ2QPMkBwLgRR+XA7+Xg==
X-Received: by 2002:a65:4808:: with SMTP id h8mr105336688pgs.22.1564443005162;
        Mon, 29 Jul 2019 16:30:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id z20sm99960280pfk.72.2019.07.29.16.30.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 16:30:04 -0700 (PDT)
Date:   Mon, 29 Jul 2019 16:29:55 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>, stefanbeller@gmail.com
Subject: Re: [PATCH v2 0/4] pre-merge hook
Message-ID: <20190729232955.GG43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>, stefanbeller@gmail.com
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com>
 <cover.1563490164.git.steadmon@google.com>
 <CAN0heSppzb9MCcR2296y1FFBoYyOs16e73DFhgV1bjkkxemRww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSppzb9MCcR2296y1FFBoYyOs16e73DFhgV1bjkkxemRww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.29 22:09, Martin Ågren wrote:
> On Fri, 19 Jul 2019 at 01:56, Josh Steadmon <steadmon@google.com> wrote:
> > * Martin's objection on 1/4 that the sample hook would always exit
> >   successfully is (I believe) incorrect. To test this, I ran
> >   "/bin/true && exec test 0 == 1" in a /bin/sh subshell, and it
> >   correctly had a non-zero exit status.
> 
> I retract my comment on this. It was incorrect, indeed.
> 
> >   git-merge: Honor pre-merge hook
> 
> Nit: s/H/h/

Fixed in V3.

> >   merge: do no-verify like commit
> 
> Nit (maybe just me): this could be patch 1/N, before getting started
> with the real focus of this series.

Agreed, I found the ordering strange as well, but wanted to keep it the
same as V1 to start with. Fixed in V3.

> 
> 
> Martin
