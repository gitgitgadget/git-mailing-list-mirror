Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220531F42B
	for <e@80x24.org>; Mon, 17 Sep 2018 22:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeIRDaJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:30:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39210 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIRDaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:30:09 -0400
Received: by mail-io1-f65.google.com with SMTP id l7-v6so12820895iok.6
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VSxLTFQJ28dJUse2wjJ/4HgdcCebL+apzeOIRBwYmdc=;
        b=vXHqtTupWR6oD1bbcihaIzwCyqnW0Gngfl2pvBDJRr31O/M6r+EBj73sOmmKXgisUb
         wABBiWwcQo9qn5EhqUffIq7X6xrIZUiFLRrQRAnJvRVGwJsBIidPkkzLbnoKLiu76Aen
         4cslTqwNTpetplD5X0XBHdUwr0dZfMAXbJNwlfwkQ17/l6tCaI329a2FrFhGlSdCwaf0
         MIstMVCph6OTCtrEHUnws+lgxtvJPIlzZJvxbvfxxLRe3DuoZbCH3u6J6GpSdFSYA2Mn
         8Yk2pw74J4VwfMFVshl2OQbX+RMDNVh2TDdFTmnPNtjvo9y7sAgo8MKyuGudMC/6Xouq
         s+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VSxLTFQJ28dJUse2wjJ/4HgdcCebL+apzeOIRBwYmdc=;
        b=IVWXoa4CWLsysR7xe0domg1oLrwVJeOa2x060ZX5V1P2ssEMCitGl4SKZB2smuJsEf
         LIDDTfSoSrTUc0A+ybi36WEW/CSAd05UeoQG+Tz3ksR5aUkNiTOS8ABdugCy2uJMfFiG
         IogTXiCA4txAwi+QbCofM1VX1ureRq+V2Y3fZZt8sFI5yUjK9awZizVfK1oiKTF5FfB6
         uPwyHKsqMyu9n8mKuCcQGrJuHj4dSSrQ8BEpJYMVlFGU/LQgeHNEElfbk5ELbyp5c50a
         BoSBC5fmeyGPSf935tpcNdMw++bN6BAywWzVTnqfClIVJqbXEjkCtwDtH/HlTTdqzOPm
         en1w==
X-Gm-Message-State: APzg51A5Lu9cqYiFnoAPBrk3YYL7Qhe9wITQHeRuM2yXq5XQHZlHF5av
        2sdHJkt9/cSlktbfNvGDPSN9aMj/oa/wsA==
X-Google-Smtp-Source: ANB0VdYItja2xVzc/RwHRelM6FJrslBDHtHb474dOhw+aU6XYLt+oBFxI6cv6maZch4BkNg6pt3+tw==
X-Received: by 2002:a6b:f201:: with SMTP id q1-v6mr21705598ioh.180.1537221653091;
        Mon, 17 Sep 2018 15:00:53 -0700 (PDT)
Received: from localhost ([173.225.52.218])
        by smtp.gmail.com with ESMTPSA id l21-v6sm5518285iom.8.2018.09.17.15.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 15:00:51 -0700 (PDT)
Date:   Mon, 17 Sep 2018 18:00:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Jonathan Nieder' <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [Question] Alternative to git-lfs under go
Message-ID: <20180917220051.GA81083@syl>
References: <008d01d44ebc$0d668df0$2833a9d0$@nexbridge.com>
 <20180917192753.GF140909@aiede.svl.corp.google.com>
 <002501d44ed1$38a49ab0$a9edd010$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002501d44ed1$38a49ab0$a9edd010$@nexbridge.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Mon, Sep 17, 2018 at 05:55:55PM -0400, Randall S. Becker wrote:
> On September 17, 2018 3:28 PM, Jonathan Nieder wrote:
> > Randall S. Becker wrote:
> >
> > > Does anyone know whether it is practical to rework git-lfs under a
> > > language other than "go"? GCC is not even close to being possible to
> > > port to my NonStop platform (may have tried, some have died - joke -
> > > trying). I would like to convert this directly to C or something more
> > > widely portable. Is there a protocol doc out there I can reference?
> >
> > Can you say more about the context?  You might like
> >
> >  git clone --filter=blob:limit=512m <repo>
> >
> > which tells Git to avoid downloading any blobs larger than 512 megabytes
> > until you know they need them.  See Documentation/technical/partial-
> > clone.txt
> > for more details.
>
> Sorry, I was not clear. I am not having issues with large files or blob
> limits.  Members of my community wish to use Git LFS support on their
> enterprise git servers, so as platform maintainer for git on NonStop, I am
> trying to accommodate them. The stumbling block is that "Go" language will
> not port to the platform.

We have an open-source specification here [1], and the rest of our API
documentation is in here [2].

Does that help?

Thanks,
Taylor

[1]: https://github.com/git-lfs/git-lfs/blob/master/docs/spec.md
[2]: https://github.com/git-lfs/git-lfs/tree/master/docs/api
