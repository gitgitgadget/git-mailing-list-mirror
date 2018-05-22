Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8505A1F51C
	for <e@80x24.org>; Tue, 22 May 2018 18:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeEVSkL (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 14:40:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46255 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeEVSkK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 14:40:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id p12-v6so9177599pff.13
        for <git@vger.kernel.org>; Tue, 22 May 2018 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PWHtkh7V/jmcBMigcnUXpvAWN27RMDlRnemcL5HgwQw=;
        b=X88Ta+xk/KACxHtnXg2y9udc7vuQvaf645y9UiF0AqDA6KcKwjMwwVnQx/Zo6A5X4n
         7988K8p8SEWySkh0cUNWn0a/i40IoFEJoEnJIMFJXccSSWdt9QVMWdp6flVILQgcV2zY
         E5Zg6GEEBW65RGytVZRJawLukNsU0wx6D87ZyGGVhQcnFa3eNpuDfXUV0sI/ZZQFUNL7
         9QKF2QZPNQo+TjfrVrNa5cvuR+Cpk26z0q7ySkfNXJYxonyp/MT7A0VW7MGYFcANHpwQ
         aNr2LBegyTEWy+G5B65XydlcwCr4VA69A3Az2vApXnzOpyA23pKViJR5y1sI/cXIlplV
         +Kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PWHtkh7V/jmcBMigcnUXpvAWN27RMDlRnemcL5HgwQw=;
        b=JV1fEPTBePptcbaa7nV9FciKfIn+s4RViyxs8uaLbLkgEjKjOgciuo0GwafygLFBpg
         367ZkwdaKAvcVLXloncT/yHaDJ+7MBODIk8EKcPvqwrX3SdnrO/KyiYcxm3957my+i2r
         ZS5EHR/yvDO6fz7keIKGUppSB3AGwjvkjLwgqJhJOqdO2Lp6INAzILet6NxOUFN4itBI
         tD8nrR0bHjVr21lum6wfvKRpQJdZUBgqDgMu+TbVYgu/3szZehyCSwN3VJvc3wRnaUqg
         lAOlHsXe3ehPj19OXRoX8JtkcUrQFams1z61ssd/bMKqTEXzwNAybD4bGKS4zRmrdhTA
         KLJQ==
X-Gm-Message-State: ALKqPwdWFHTdV2zeW5b2+B7/F69G5mpIZWEGfwRW679IpExc26hryPW7
        aoLcd5zocPyyzullOWxt9SHj9w==
X-Google-Smtp-Source: AB8JxZq3AExxdRtPS7Zs+IDsI05QlY6fyUf4TaFcaKLqOFCMwK/d1Q3UpKQpHJGB9JZTpwq9kPIFgg==
X-Received: by 2002:a65:648a:: with SMTP id e10-v6mr20099426pgv.34.1527014409668;
        Tue, 22 May 2018 11:40:09 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id j5-v6sm42644019pfe.119.2018.05.22.11.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 11:40:08 -0700 (PDT)
Date:   Tue, 22 May 2018 11:40:07 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Anton Golubev <anton.golubev@gmail.com>
Subject: Re: [PATCH 1/2] remote-curl: accept all encoding supported by curl
Message-ID: <20180522184007.GA177559@google.com>
References: <20180521234004.142548-1-bmwill@google.com>
 <CAGZ79kZiyi_1nxvfLttD6HPyV66Wz3pLnuAe=L7FB9ak05dGAQ@mail.gmail.com>
 <20180522010008.GI10623@aiede.svl.corp.google.com>
 <alpine.DEB.2.20.1805220824440.6210@tvnag.unkk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1805220824440.6210@tvnag.unkk.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/22, Daniel Stenberg wrote:
> On Mon, 21 May 2018, Jonathan Nieder wrote:
> 
> > > Looking at the code here, this succeeds if enough memory is available.
> > > There is no check if the given parameter is part of
> > > Curl_all_content_encodings();
> > 
> > By "this" are you referring to the preimage or the postimage?  Are you
> > suggesting a change in git or in libcurl?
> > 
> > Curl_all_content_encodings() is an internal function in libcurl, so I'm
> > assuming the latter.
> 
> Ack, that certainly isn't the most wonderful API for selecting a compression
> method. In reality, almost everyone sticks to passing on a "" to that option
> to let libcurl pick and ask for the compression algos it knows since both
> gzip and brotli are present only conditionally depending on build options.

Thanks for the clarification.  Sounds like the best option is to
continue with this patch and let curl decide using "".

> 
> I would agree that the libcurl setopt call should probably be made to fail
> if asked to use a compression method not built-in/supported. Then an
> application could in fact try different algos in order until one works or
> ask to disable compression completely.
> 
> In the generic HTTP case, it usually makes sense to ask for more than one
> algorthim though, since this is asking the server for a compressed version
> and typically a HTTP client doesn't know which compression methods the
> server offers. Not sure this is actually true to the same extent for git.
> 
> -- 
> 
>  / daniel.haxx.se

-- 
Brandon Williams
