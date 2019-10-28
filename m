Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3532A1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 21:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfJ1VvH (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 17:51:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37455 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfJ1VvH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 17:51:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id p1so7893291pgi.4
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VHk8lGlnHlQivV8kzk5VgSfiwvDKrdiuJ8H6bte/eXc=;
        b=ED6TRHXLRToZI6mBuTxTikql90rNwjHfC62+Q0vytMyB92kK8++BS/KX8awRG4a5+d
         hZm/x+5EW+tEuUDiY2HKrzoHOcr27J8EUUoRwtG27Pr/eabCC72SkIfEqO25i3ktlQTW
         riOmPGqDbKheMoofB0E8Y4TrEaOi9Xxy8LT88JYykDNcZ8FRJNLgooMHa1PL2dmRwrxq
         s1AJA/p6y7wY2RUx/Ryv3zfwWfnN7x5sgSUFl74cXAj++frp9wB7/CFsi0TLkL4i8h41
         rcMofY+iUgXqefeIECPD/LHJkTWBl9gnRm8/k7BTID4nskMN7c2oaM0BUzLWehi6bSY2
         5NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VHk8lGlnHlQivV8kzk5VgSfiwvDKrdiuJ8H6bte/eXc=;
        b=NrZiM5RluG7+dD/zoX9gEWJi3a6E981dhNzIOqzFaxW5bMd9w0ejRBWL6sZ6yG4ItG
         WcU+m8wGj0L42rYDCgTW1tjwUWawX2Hsu+Ci/yg044/bKu4pXoOaUDNn9z41UORVq5cL
         kQI/leUVKti6myhgIGGi8Tkf3H2ifv2OV04ETE4D8kzCIBwDkmJLPXMsxrJLpsuPEPGM
         WjdQ72qCBUqliMXRkNlbImUnFBzBtm+kPJa9Qao7alhGVJRo09Om/CnA+GXu0Ev7akCc
         wAO+KtJM+iIY/q/muvlWlTDftuD4Derl/E6M+/iyagSfHTXFw8uqngAxclgLzSfVmJpx
         +qbQ==
X-Gm-Message-State: APjAAAUgyk0dLgh4qNuwtmo0LyaaAkLPT7QCBJZdvmL+dZh2BHmK6cWu
        JH1KoytfWcbSdl+et5gc3qbcHfKm
X-Google-Smtp-Source: APXvYqwllxv4uAIBrqJKtVUFkHe1i7M43VSvNpwUKlT3hf0QN8BX6dlUcDMK/e4J84DxbTs+QNRPpg==
X-Received: by 2002:a62:7dd2:: with SMTP id y201mr14409711pfc.164.1572299466627;
        Mon, 28 Oct 2019 14:51:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id z13sm13668604pgz.42.2019.10.28.14.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:51:05 -0700 (PDT)
Date:   Mon, 28 Oct 2019 14:51:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/1] help: add gitsubmodules to the list of guides
Message-ID: <20191028215104.GC12487@google.com>
References: <pull.433.git.1572267946.gitgitgadget@gmail.com>
 <8026c7e9ab2f60af770fa66097d3220259201d8f.1572267946.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8026c7e9ab2f60af770fa66097d3220259201d8f.1572267946.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain wrote:

> The guide "gitsubmodules" was added in d480345 (submodules: overhaul
> documentation, 2017-06-22), but it was not added to
> command-list.txt when commit 1b81d8c (help: use command-list.txt
> for the source of guides, 2018-05-20) taught "git help" to obtain the
> guide list from this file.
>
> Add it now, and capitalize the first word of the description of
> gitsubmodules, as was done in 1b81d8c (help: use command-list.txt
> for the source of guides, 2018-05-20) for the other guides.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  Documentation/gitsubmodules.txt | 2 +-
>  command-list.txt                | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

Good catch.  Thanks for taking care of it.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
