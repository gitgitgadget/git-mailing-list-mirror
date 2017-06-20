Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 584A520282
	for <e@80x24.org>; Tue, 20 Jun 2017 18:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdFTSob (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 14:44:31 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33742 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdFTSoa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 14:44:30 -0400
Received: by mail-pf0-f176.google.com with SMTP id 83so73355565pfr.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zceyjH/tHWr5JnRCDBxWoUBWUCLd8UKuAI+HyuokGl0=;
        b=RLykuXP9Yqbmx1YToyiW6SQ7P+6QtTEi4lvhA9iEkT4ni1CiRcOWVFde/2Wh05PGDl
         RoliUIdz1sXTL3TNj+daGM8VwA3H35aUAFuESVpJNoYedUSE4S6sVW6ZryhIX79e3KGo
         sonDT88C5mQUQSZ0wqAmTpY1dHXfBuEbfFiYczpli9hdZgQykofcUI2WtmTjyUgQ6puO
         gr8f1J8I3tOIRW+kvnsDIZ+tJ2XiXPxOGXb8Uk7KuCuDl4DgoA+rKYgXiBl4xf5yPyrx
         PDX8/LrXDvvPpS/LaLjqUlzstW6uqAr/ayBzp2MeWfoY313Dkmn04twx/ZYh+m3qSl8B
         NpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zceyjH/tHWr5JnRCDBxWoUBWUCLd8UKuAI+HyuokGl0=;
        b=lD2j5uQp47r6fj0mnsn/4dSd14lHNMix2Wb/ofMj4Wu12UF72A/oWnDI+AYkMxeeMd
         ghJybnpMIbLLbVqlGAwc7fpmjkV3V/E8+FIob0Q4k2niqN+7XFslYJrUkZ3TedGig0N7
         nqN6hF4ViaEdU1b8px5inqN1bMb7l6piUKupw9vn2Bv+J7MltkAGAj8BHPrPRuA42ChK
         loDaQRpnbZ5VZei9yybHg5lZ6ZzJ66rhwoPZk6iJzJNdHWwJ4sUosUrwOzhwGHrWnuF/
         nBQMh1GrS6f6nca6VoFldY46Imr7EGC554TSOcMyFPIaC7jNlX3MMAxCEX78v65lNFLQ
         +Ffg==
X-Gm-Message-State: AKS2vOximZU/AH7uxfe+tcluAxZ2FuSgevzpbTwqhvuiL1jkyJeaVsZE
        aYBKA70TC+4tTCLn
X-Received: by 10.84.232.71 with SMTP id f7mr17620719pln.18.1497984269641;
        Tue, 20 Jun 2017 11:44:29 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:292c:ffc6:f991:bee9])
        by smtp.gmail.com with ESMTPSA id b3sm27636909pfg.47.2017.06.20.11.44.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 11:44:28 -0700 (PDT)
Date:   Tue, 20 Jun 2017 11:44:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 4/6] submodule: port submodule subcommand status
Message-ID: <20170620184427.GB60134@google.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
 <20170619215025.10086-1-pc44800@gmail.com>
 <20170619215025.10086-4-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170619215025.10086-4-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/20, Prathamesh Chavan wrote:
> The mechanism used for porting submodule subcommand 'status'
> is similar to that used for subcommand 'foreach'.

nit: since 'foreach' is stalled atm it may be confusing to reference
that change when it hasn't been merged in yet.

> The function cmd_status from git-submodule is ported to three
> functions in the builtin submodule--helper namely: module_status,
> for_each_submodule_list and status_submodule.
> 
> print_status is also introduced for handling the output of
> the subcommand and also to reduce the code size.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>

-- 
Brandon Williams
