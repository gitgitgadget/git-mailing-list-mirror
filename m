Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA83020954
	for <e@80x24.org>; Wed, 22 Nov 2017 23:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdKVXy3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 18:54:29 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45093 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbdKVXy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 18:54:28 -0500
Received: by mail-pl0-f68.google.com with SMTP id f6so1645370pln.12
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 15:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rR9DlrTzXk4dIZyK8/DpMQJJEMZgy8kRQnBRWcig5i8=;
        b=t8cFRIq6/zSGCyOwFYNkWNLyzeUUII0Z344i2tDKiNT1euNG6qqOWlYDj31T+OIrCi
         a0OKPafkv/czoHznuuQmhpTsQGrnunuzbBJCoCGsQeRrEV5bTM0xhORw6BTw43KyKzw/
         WFLmAGASRWowMbswvBzM+lcxjanMBmE3fIUtLwtSIU98tTWCu6f51tMP2yzq1yzRdRAu
         2Fk4SoKOMcloiKDbx70L/qaN655HGelPgXylPTnssseZ6wtMiYXsW7B4a3c02vNfnB91
         dqeE0wCp6ODgOcd5R5ySWPdIA0pymSMJXZzqR7Itq1zsb9pvCcZx1Nulo6HRrsxLbGsW
         miwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rR9DlrTzXk4dIZyK8/DpMQJJEMZgy8kRQnBRWcig5i8=;
        b=Htgnh4o+NU3qosn/dT4dHWQ/22h3RCWQYZd3mKCW2PPW9o+s7SJhwAGYTgY2gL8wri
         MIa7rwlb550iA0c+U6YdFKt3N7HLeh8mxIkNZo5LHHIcctE0GiIaSm1S1z+qa0kJOIxU
         FbJayYJVpej4/P3Xdba1yu7yf85l2+2rAWCNJf0H8vPGhaMZLgtw5w6mKS4zC81CQG0H
         VijLusaj1Mde5k8XxLTgBPykOiBVhsPiCX7ioBQifWaY29wALSz1zqxtO62lsVyBC7sn
         lf55DFHJD/ky5qMuhhoKBfafpFV62CvlsJqkgzp8QzfIP824XTQV6sx0JR8wrQfxgN9x
         7Crw==
X-Gm-Message-State: AJaThX6jxoXmGI7f5f1F35zPooRUIjces0tAH+MJMwxVfDOC17LOz4jb
        92z0kardDC7I5VWNnsKtF6PNgvbX
X-Google-Smtp-Source: AGs4zMZT2bIcxBw5E0UZWmHcPJP9lP7QkqcpJ9DoukzyKaMcfOrW1mtx79ZN1I04RM0Cskcv4CKjfA==
X-Received: by 10.159.231.22 with SMTP id w22mr23344351plq.45.1511394867947;
        Wed, 22 Nov 2017 15:54:27 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j79sm20741672pfe.129.2017.11.22.15.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 15:54:27 -0800 (PST)
Date:   Wed, 22 Nov 2017 15:54:25 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 1/3] Documentation/CodingGuidelines: explain why assert
 is bad
Message-ID: <20171122235425.GK11671@aiede.mtv.corp.google.com>
References: <20171122223827.26773-1-sbeller@google.com>
 <20171122223827.26773-2-sbeller@google.com>
 <20171122225913.GF11671@aiede.mtv.corp.google.com>
 <CAGZ79kY7yrgYSM7jLQD3Q4sRpjovXY=HZwU4M-Ai_XRPseda9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY7yrgYSM7jLQD3Q4sRpjovXY=HZwU4M-Ai_XRPseda9A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Wed, Nov 22, 2017 at 2:59 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> In a certain ideal world, the preference would be reversed: you'd want
>> to use assert() wherever you can and require the compiler to check
>> that all assert()s are verifiable at compile time.  A check that a
>> static analyzer can verify is more valuable than a run-time check.
>> When a compile-time check is not possible, you'd have to fall back to
>> BUG_ON().
>
> Linux has BUILT_BUG_ON as well, which we may desire?

I thought so until I tried to use it:
https://public-inbox.org/git/20170830065631.GH153983@aiede.mtv.corp.google.com/

So I think we are stuck with run-time checking for now.

Thanks,
Jonathan
