Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C48D91F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbeBVS4z (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:56:55 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42224 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbeBVS4y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:56:54 -0500
Received: by mail-pl0-f68.google.com with SMTP id 31so3384910ple.9
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ADK+BGXLIjP+9T0fOaYRHbhVCm1tQsRqiUNXPO5YX8U=;
        b=kDCwb+KFUggf+ZxvUgcHvA0qV9oWSV0sPgpGol9Ly7hVVh6TAlKR8DJnYYlzb6q8Po
         cs2CObP65ng2zhIltsJLAsDr8XCfqAdQ8rkq7vZU33ul9zOnjVVoIgIsnpcuC/ykgyLS
         azJD40GS07YrnDwK6vTOEmM/rB4gyBHc6yaP5BAfa7MXkjjl5mx6AOrYvzxWROCu7d3H
         Je84hYHnUIBLxWnJv2PXdcNmJblSni2uolWZ8iOou3KbZrt9aVknWb/07ceENk5X+LNa
         XHgra+jgbPsyNYQRbCaKnEqBf3hEq/qaaVd1wjmiT/nLLuEAkfcwhsFHE7vAMGL8kQb2
         czTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ADK+BGXLIjP+9T0fOaYRHbhVCm1tQsRqiUNXPO5YX8U=;
        b=jwKN0s4KpME7UN1aeUxgqoqjTWbbk5+u11KG8IZm1+iDzXsPMjVWmVVy1twcr40Aev
         lQmPY2Set4o96F7TgfL4fnaNQuGD0y5ZF66e3MVGBEgQLT08zR0q3YuJhvxEcNmdiT4q
         khYWsDgYRLrB9gXJ7hN+5ADFDmJ18V19BfCseTDMqRqmE+SZbS/ECI3sxmLNv6Xq+luS
         t1JoWpebvUajLUdpdYnKQDX0xGVRsee/nibfG2umH3HnA4NnhjYqeKtdHbTDT6NelhpB
         rlkFwAfgMJgu/JPiWn8EDppTBbjc3J9wOFjRcTaLPw7Q8+qTVJKUEPzOH2AqJq8IV13H
         lnZg==
X-Gm-Message-State: APf1xPDxFuzPD7oeeqWrOp43fNHX5tIJ/iyTXI6FKyvggQK9ysqVM4iz
        amYG5lDlAB/ZIJEUEo6FgUgOVQ==
X-Google-Smtp-Source: AH8x226l5tJR/DZgQ42AZjhwadL2qPG6Aw2oW7ZwHSYEArSILZezzt+oIlumNClogCmIUGSTleGeRA==
X-Received: by 2002:a17:902:8289:: with SMTP id y9-v6mr1111799pln.242.1519325814105;
        Thu, 22 Feb 2018 10:56:54 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id u22sm1045415pgv.77.2018.02.22.10.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:56:53 -0800 (PST)
Date:   Thu, 22 Feb 2018 10:56:52 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 30/35] remote-curl: create copy of the service name
Message-ID: <20180222185652.GI185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-31-bmwill@google.com>
 <20180221160606.af3db12daeed08ba68bd37f8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221160606.af3db12daeed08ba68bd37f8@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Jonathan Tan wrote:
> On Tue,  6 Feb 2018 17:13:07 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > Make a copy of the service name being requested instead of relying on
> > the buffer pointed to by the passed in 'const char *' to remain
> > unchanged.
> > 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> Probably worth mentioning in the commit message:
> 
>   Currently, all service names are string constants, but a subsequent
>   patch will introduce service names from external sources.
> 
> Other than that,
> 
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

I'll add that.

-- 
Brandon Williams
