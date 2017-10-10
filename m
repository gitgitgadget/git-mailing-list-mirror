Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E93520372
	for <e@80x24.org>; Tue, 10 Oct 2017 02:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754789AbdJJCPw (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 22:15:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37144 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754172AbdJJCPw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 22:15:52 -0400
Received: by mail-pf0-f194.google.com with SMTP id z80so13277112pff.4
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 19:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5YXrXtZbYzKx0bGrGJ/UqI30OBceI5lEkbD/udI+vVI=;
        b=H3JAeyFNEhrQ/rXPsHltg0jjdg7iEI14WQd3bdnCvZ9bniHTqlFxUTLfTPSl+E0j8u
         pskN1rrj+xX1LwCDHEgy/KLnX/MUNJBSy4U2hwK+UuYV2IG+nXZ7dJaMai9DjwiWT2ie
         voVNdTdggVKm1K2nzIqZM9ewT5fJLCqo1763INBAb1DRDCdnAz9tEOtJ7gFuJvoKd1xr
         ttzUVECPnvG9C49z/sKyc4hhvcfS+v2GuKxaSo79Pw11TjCmbtI+f972YzmDYG1Ak2CI
         oQ3CqmgXPqGKR5pb7vmnCJK8LmTG/m4aG7Bc+sz5R1WrMRvHIVJEBqzVepQ3qDSHnJgn
         5pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5YXrXtZbYzKx0bGrGJ/UqI30OBceI5lEkbD/udI+vVI=;
        b=WsphyNr0cfwb6vG0c3Y5Ewd3S781NXZlB7USm9WMZiCNxHZJcwOpNFeFiv2rqIVmbX
         uWWc77NgB3tDjFaLaYtzuEG4lZAZfwVBh/B9sa6W6i6aL1HmazdjZ8qOQfoRmEGF/EXN
         Sxamv37fAuJcMOfmFvDkhhJ00vpzKngP8c65/TP/KxV1m/thhwDm4V8HcGFPX18znh0r
         pyTLYuoaj6gKE4aDzxKV8g2ygAqbLijLaKxRbMuNiOmFUahs6YxXpy9AMaBMCJX0ZJin
         dyYjjt3c55tHnztjdwCe4cSGYjbIaBQPxl9xlLfiSc7Dec0bA1ZSW5h4XHfvyGFXvKEN
         +lKg==
X-Gm-Message-State: AMCzsaUt7IWEHpvwOATIM3KAfOygQ3hyj3E4/xmAIOfXZcFkWb03zWNl
        eTzP+lsomhvZqfbGhywWHaE=
X-Google-Smtp-Source: AOwi7QD27dvtG2VRiaDMtDSFFOxVmA7ir7Dm2h8l5pbjaZJEL90nenniG4rHgbjNSRAo1dUkWsBPpw==
X-Received: by 10.99.109.4 with SMTP id i4mr10848933pgc.308.1507601751233;
        Mon, 09 Oct 2017 19:15:51 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id c16sm19140439pfj.123.2017.10.09.19.15.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 19:15:50 -0700 (PDT)
Date:   Mon, 9 Oct 2017 19:15:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 10/24] builtin/reflog: convert remaining unsigned char
 uses to object_id
Message-ID: <20171010021548.GR19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-11-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-11-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> Convert the remaining uses of unsigned char [20] to struct object_id.
> This conversion is needed for dwim_log.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/reflog.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Thanks.  Looks good.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
