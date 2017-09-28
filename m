Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575C420A10
	for <e@80x24.org>; Thu, 28 Sep 2017 21:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbdI1VEz (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 17:04:55 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:56680 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbdI1VEy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 17:04:54 -0400
Received: by mail-pg0-f48.google.com with SMTP id 7so1584153pgd.13
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nbeIzpb1wciAhLNNYB2/wt0YXXz478kyatah2/RVCQ4=;
        b=ro0pkXeCpdXBORiB1tYAnRyI5QdzeGE5xUuAFEap/ERDKWPuxjmE3dFzNu0KyOiDZO
         bKd+iLpA+DKoEpEJv/CJO2CKfhEIp0GBsiEhltaWlZ7Xil0zrfcB3I9zlaNtO9j2eDb+
         Z/XPyb7sheycIiDef5w3sPGzZgEyNEHLKBNtzT5ymO8A7tUr4Z030Zihvpyunpgx0Oui
         u32PHwWo67zzCRB5eg3NqV2PM5uqg+kzV3PuM9PFXTdUCTwuSpn5jkqnrTvyOK6wNEfU
         fczo/3oSV4vf3h8GEeSYYdnPNrlRg+V7v4i5HfMs2Wn2yrLQYXpDLEXPzRFo+Ou8XNIW
         Zxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nbeIzpb1wciAhLNNYB2/wt0YXXz478kyatah2/RVCQ4=;
        b=WpazHvS0PHf/6TYcYW3AFsJHB496WwzjTryoOB0WQCW2JL/d+9yWL9YptP5grxSnFu
         /yNsBgHE8QiKZHerz6xojZaNBFzz0ayMLgr5tCgtfiUgpHgjHp33hsRGuTSw6UgTNWdj
         /K0rlAI7Jboa7NdGi/51P8OcPiPcwwqZYPPy0RAhXYVTxRuDsJAqK321kYaQYnpN1Vu6
         AaUS+AUoqF+BAfZ1j3878dOoO9S6oiD5fyE9pn1sxcXGTOCMC1RjDgsoXaRCPwXjNBja
         vhfxI7t0KX6MRjs6sTShKu7qtw3nCPO+uAxETE1iVl4CpLGJqIHN0lVwV4KriNEg6tnv
         R68g==
X-Gm-Message-State: AHPjjUhh62TH7pLgl1tQctQQqJQUanXtcRl0enWNvmZkaPke+aqDkI6H
        as9uokTlDc2FKQcOgJ0h4d9y2A==
X-Google-Smtp-Source: AOwi7QBjRptWD8IaF7Gjzzqd3PNbgvr8PcxuvAzPsXajO8+bBR0AosRKQb42fYgA5y64DVIU7LIb8w==
X-Received: by 10.98.13.81 with SMTP id v78mr5435819pfi.61.1506632694010;
        Thu, 28 Sep 2017 14:04:54 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c55b:7140:f55d:7eed])
        by smtp.gmail.com with ESMTPSA id f2sm4226266pfg.135.2017.09.28.14.04.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Sep 2017 14:04:52 -0700 (PDT)
Date:   Thu, 28 Sep 2017 14:04:51 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/9] protocol: introduce protocol extention mechanisms
Message-ID: <20170928210451.GA177031@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
 <20170926235627.79606-4-bmwill@google.com>
 <CAGZ79kZxOr3ug7V40kv77e2_kF9MBviCu99-6rcXy76tg2YVGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZxOr3ug7V40kv77e2_kF9MBviCu99-6rcXy76tg2YVGg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/26, Stefan Beller wrote:
> > +extern enum protocol_version get_protocol_version_config(void);
> > +extern enum protocol_version determine_protocol_version_server(void);
> > +extern enum protocol_version determine_protocol_version_client(const char *server_response);
> 
> It would be cool to have some documentation here.

Thanks for reminding me, I'll get to writing some more documentation :)

-- 
Brandon Williams
