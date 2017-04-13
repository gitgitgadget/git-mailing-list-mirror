Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C3F20960
	for <e@80x24.org>; Thu, 13 Apr 2017 20:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756245AbdDMUoO (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 16:44:14 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34165 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdDMUoN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 16:44:13 -0400
Received: by mail-pg0-f65.google.com with SMTP id o123so13485912pga.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GqGV1EyobxQ/smD/V7iqvqYkjGsPmSZ1Bn9cDwPJnZo=;
        b=r+gIpqmD9+PnPFER0agyvj/8SyheuQcv2AUjf/f+4obn0ndrj/meiUxkouYu4c2/38
         jWL1eQGKAVYNm/pWTt6AQJiyGL8NNojpD8Dh71A/9GiXSPPmcy17u7bMAscIBG/Q9tjI
         Mod7eZsm+cANixVUyMo13Pn/omz7E5eTZViinYZhJZdcrvHU5Yc6/ALxV0vKaOHCC02Y
         hmgKStCtuf6lFoINBmkChMh6CKsriNCkIO1oOFcisViO5iBlSpoCsoRtt1K2T5pUFkeI
         lwBYB/DYfHVekedcd04Ko90+vmPqRlw9fkwdiRZV4RjbW20vXqnldv/AxjO7j1rtdyCH
         gZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GqGV1EyobxQ/smD/V7iqvqYkjGsPmSZ1Bn9cDwPJnZo=;
        b=AkS1Djto88DJQyRjB5BpzQeqyNUT5e5Sy9NogQ8+GvDbf728hrzZ45sjkaabw+sUSF
         C0Ec3CuZ8TjnasT2/4XqqTCZGUfch7zzKOxJUz+87jzdb48UHWI3yZyOo8c76Cbg5ozW
         xlUy0bV49oarkNfzgUXxWnuDTPqZzgAjnkC4v+xNYj8BBSlbjPX3S26rgC6xIo0nvkZO
         fJftjoRUSKKbGSOdTwcT24KuiU8y4/pl9WcdlDaWtu4BLqrG5mYFvD7LCut0yQxkWuYf
         N9RqeVJ8slDib8MU1byMgRb4BhWwQmVYz+g+zYnmCN6ljE1cHscPFpzAicGOrf1qtcZI
         LzkA==
X-Gm-Message-State: AN3rC/7cRCcnasD/BNWUe1G+NSE56Gv3ZP3JYxPNiqMzfv+oS8VaQMBe
        Pytf1yUM0McXbAlYNqY=
X-Received: by 10.84.229.76 with SMTP id d12mr5422839pln.14.1492116252733;
        Thu, 13 Apr 2017 13:44:12 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:40ae:ac27:c1a2:6a87])
        by smtp.gmail.com with ESMTPSA id h25sm44110339pfk.119.2017.04.13.13.44.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 13:44:12 -0700 (PDT)
Date:   Thu, 13 Apr 2017 13:43:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH v2 1/6] t5550: use write_script to generate post-update
 hook
Message-ID: <20170413204358.GA10084@aiede.mtv.corp.google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
 <20170413183252.4713-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413183252.4713-2-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> The post-update hooks created in t5550-http-fetch-dumb.sh is missing the
> "!#/bin/sh" line which can cause issues with portability.  Instead
> create the hook using the 'write_script' function which includes the
> proper "#!" line.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  t/t5550-http-fetch-dumb.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

This would allow later patches to regress a previously supported
behavior.

I agree that it's silly to test that behavior as a side-effect of this
unrelated test, but I don't think we want to lose the test coverage.

Thanks for tracking this down and hope that helps,
Jonathan
