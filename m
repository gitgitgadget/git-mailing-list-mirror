Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6BA1F453
	for <e@80x24.org>; Tue, 23 Apr 2019 22:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfDWWWx (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 18:22:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34017 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDWWWx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 18:22:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so8217615plt.1
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 15:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7sjbUfEO9Kv/pOevU+EWxpGW+L3Qw1uwDiB+ZITS6jg=;
        b=aTryEZAPY5hbgIqQv5TBcnD2xzriTx6079F/M4eOwOZ13ZjR33p/VzXAjCELBzVlx7
         mhkzgXSPETK1u3vA8pW5STrBy6TrATAd37q5xvG3DBkMKqLkmoC3AO2YLDS2sD4Oxvpy
         9V5ASqt4/hTmRETRxqaUqhnhS3EGb0SCwsDZ7Dn/ILNuFeUdAqFcpixFTtf+QUxsJr7q
         pWhPIiaMnZhx3GK+LJc/TyY9MOMpb6P+2aE/TYmMUlHxNv+jrD+z6x+0DSImsICtathd
         0qa578zA8VB14BiR2cwTYl9yu+0lHRbhk4FjopqJfpjWISNeP9Haf2/WZybYksI4V13f
         UNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7sjbUfEO9Kv/pOevU+EWxpGW+L3Qw1uwDiB+ZITS6jg=;
        b=il58Cs5qOI0OrbibECS/Rg6A3TTxPB7H8nO3EUzMm24PaDMd0eu6qvSXJZELYf/pxL
         03yJdlvmzZQ5LSaQvEqnCqLBsExI+BpeRq1czvKzP7bDHLd7lXve1A5UPwJh3rrxEX8Z
         IEqJOW0q+T4h4VtvkzfyZsudODCgkzO8Euo7jvGOyc4OZsurg6HEVOZwENgAgDGEwNEc
         ObGzbdw0OiloSH+H1YMHZTIkc6ag+eGXgxbrxcJ9oZAe3hQpRaMHMPCPWWhbcHCa52HI
         e7HKgdCA0kx2qATYc++2X6d2Ig8+t2zfp9/W2BJRbGyyHtPavwK7fnmxNadVQzOWmLSm
         LaQQ==
X-Gm-Message-State: APjAAAVljHGb9bn4rXZRySGZKgitfDZlGy9KMF9VLzHIeSXza4QK6Qoc
        /NVbVDMuZ37eh8l3JersUuBN/26l
X-Google-Smtp-Source: APXvYqzsJcVgEcp62lJWxY/1bZxgWi6cWdobzIeX4RVD/XOyuIJyPIXJf7VJfuqpCRFAJbGLOYo8UA==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr28292325pla.166.1556058172396;
        Tue, 23 Apr 2019 15:22:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id d69sm33095005pfg.24.2019.04.23.15.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 15:22:51 -0700 (PDT)
Date:   Tue, 23 Apr 2019 15:22:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 5/8] Documentation: add Packfile URIs design doc
Message-ID: <20190423222249.GB98980@google.com>
References: <20190423053130.GA13162@sigill.intra.peff.net>
 <20190423203801.29156-1-jonathantanmy@google.com>
 <871s1stlf4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s1stlf4.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> This is really orthagonal to this series, but wouldn't a better
> resumption strategy here be to walk the pack we just downloaded, run the
> equivalent of 'commit-graph write' on it to figure out likely "tip"
> commits, and use those in "have" lines to negotiate with the server the
> next time around?

Do you mean this for when a pack is self-contained and contains all
objects reachable from those "tip" commits?

What would you do when a pack is not self-contained in that way?

Thanks,
Jonathan
