Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B72D1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeHMUMK (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:12:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35149 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMUMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 16:12:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so7983873pfh.2
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lcWJhrHK0fF/9rzT7a6IT/x6/Uua9rYbtmrEW2jx5Nc=;
        b=mI8mpF60NhB3CPIkv8znA0gRTS5S6naUfHPD8OMLRwpePGXHcLMrMtcxBnJPAklis3
         vCDsllCwa8f/q93Cjn497wt5DnSsg+8coOboaEt3fjVS0Pz88+Oo1arAk3KrDDtyo53G
         cI6Ka6wrlXiJ4jirRgD5QBUbmMBpE4Ec+eno35EcFfy8Bgd0NbX1TOLQYWQxN+18Sma4
         eT4SFDrWQvQ+Va4dDO58PFTtHrPRfZ7XVPAjF4AjczgxHVJk4cB92siVWGDRM8mcHTCP
         TXjRZ149o76p/2poSGIuMXrK1QAPJuUT7KJZs+rQ7cEJNxbXLmhUnHVB1buPqXKeiThB
         aSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lcWJhrHK0fF/9rzT7a6IT/x6/Uua9rYbtmrEW2jx5Nc=;
        b=TFMvPCqTykM4KUOSWd2W/N0xfPo7X5nIYgcRnLat1arXNFLudU5fGBiOkpmJsdVCz5
         iQ4r5rlGo2xlzYMFBAXssJiZamX71KAkLvNt//fWpnejqkuPe/irENT8vaQoXnbf7YgI
         zxZw0Y42jJQ/O55TAnbZ8AYPOckuMica5PL6KWguklco25KrBWEuMiIyO8aVlFgev6Wl
         1ffakOgU+G6+312QUFGQ9iZu0PdTg0Rdh0eHx7VLK+vHrCaS+2if7J1l4oLPRnFouuPk
         xhZdjFBPYBsiIEPO6MkFOvReU0kEhpD0qnIFLBwj5aotPH+KK0pnLsmdCVtIbKJU5y2o
         IFow==
X-Gm-Message-State: AOUpUlHy7ZDMEGsmo5p+Y2z8zYaqlPyTtxentQLEIOt0Q5Yk2o8ypVjK
        zK2eJlc2TiJBlGQ2LV0fWZfx8A==
X-Google-Smtp-Source: AA+uWPxLkzT+U+vxuN/UJ+sQyZ2+hE25mv2ztk9xC3BY4d3GAx3poDIDDPNP/PbyumEMIGZyXpfubA==
X-Received: by 2002:a65:6455:: with SMTP id s21-v6mr17230339pgv.394.1534181339960;
        Mon, 13 Aug 2018 10:28:59 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q140-v6sm26347931pgq.11.2018.08.13.10.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 10:28:58 -0700 (PDT)
Date:   Mon, 13 Aug 2018 10:28:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/24] Kill the_index part3
Message-ID: <20180813172857.GD240194@google.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/13, Nguyễn Thái Ngọc Duy wrote:
> This is the third part of killing the_index (at least outside
> builtin/). Part 1 [1] is dropped. Part 2 is nd/no-extern on 'pu'. This
> part is built on top of nd/no-extern.
> 
> This series would actually break 'pu' because builtin/stash.c uses
> three functions that are updated here. So we would need something like
> the following patch to make it build again.
> 
> I don't know if that adds too much work on Junio. If it does, I guess
> I'll hold this off for a while until builtin/stash.c gets merged
> because reordering these patches, pushing the patches that break
> stash.c away, really takes a lot of work.
> 
> [1] https://public-inbox.org/git/20180616054157.32433-1-pclouds@gmail.com/

I went through and found this to be a pleasant read and hopefully others
agree with the approach this series took vs what your part 1 did so that
we can get this change in.


-- 
Brandon Williams
