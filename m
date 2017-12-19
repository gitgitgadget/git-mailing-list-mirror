Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7672A1F406
	for <e@80x24.org>; Tue, 19 Dec 2017 23:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbdLSXPt (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 18:15:49 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:44552 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbdLSXPr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 18:15:47 -0500
Received: by mail-it0-f42.google.com with SMTP id b5so4657029itc.3
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 15:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sQhegStmDPRIC2LYhbjZh3f8W6ylf4vIBgbuCOVpO6o=;
        b=JaL76oQt2u5Q6LFhb/ACDE32VD4A9OGo+J2Gg0qIFKM7SVwBVN0pFHo9g/CAMq38vY
         DgHFijEuw6V/z8G8brS5G/pdHG0W7HHrXfjAJhvwKJMmDXrLz8Tyl30HLpvvQAd+Vvz1
         ZiTd7Y+LKSpI2RVRYFRiXnE5skKsQjFGv4CyaZgy0iS/gfnQjV5geRc8sKweqJERZdDu
         CCjIxt+AxlZ4IfNi5XUmsYSHuOS1VLLEemTlc22c4BLMb2XHFdBsJZTqqs7FHz6W6AZs
         8voEKRzEBTb2d61C2/8yKZ+PBJQcZzM0qGYxETJtiPZew004u7eTCp30vFzxcgzA7hiH
         niHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sQhegStmDPRIC2LYhbjZh3f8W6ylf4vIBgbuCOVpO6o=;
        b=kjQgSiiJNcdzjQLwSEd617XK5oS/egXpzrIG5XjPzzxyMVZBG3b6bWt1ztKVBs4dAb
         to9WdOBjshDH5/IY1BqMusJ30H2d1WWStfJN5EwqlcEJxFxSX/nvSk2OdrwkiWfRCu2D
         MAq+R8pCqBS+2Rl2036+/97T448/pbPxZ9mddj32Fl+17awK6pvTRCvrI1OTM4Xua9YE
         ARYT7V5Ffh3E03/g5q/RllUkAmVK/cL54ffW6wz9Gfzk3m5tz+/JEfmlsSm51c9sYDn1
         Irzo7aCb8Y/m7of0eI4RgDf1BLgszueRzDVdPjqLPUjia10D/6DLHU+VvXMA/oyiRDME
         TSIg==
X-Gm-Message-State: AKGB3mJyhHlLsT2OXk6Nnk3I9r+PLsttLQjeoWnTkzLbXAbhhNBp5IdA
        9LkKFBBVHG92L8YjndQBab8=
X-Google-Smtp-Source: ACJfBotPTrKE0uxOfVMBI6DJ2bqxXgb3WcyRYVq6B+q/T/ahzzXCCfITVb6NgHiPuZCHfDN3M8ODQA==
X-Received: by 10.36.204.139 with SMTP id x133mr5306965itf.138.1513725346702;
        Tue, 19 Dec 2017 15:15:46 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d186sm1707079itd.22.2017.12.19.15.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 15:15:46 -0800 (PST)
Date:   Tue, 19 Dec 2017 15:15:44 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] submodule: submodule_move_head omits old argument in
 forced case
Message-ID: <20171219231544.GH240141@aiede.mtv.corp.google.com>
References: <20171219222636.216001-1-sbeller@google.com>
 <20171219222636.216001-6-sbeller@google.com>
 <20171219224431.GG240141@aiede.mtv.corp.google.com>
 <CAGZ79kake8k2dM=NPwNoqB5Vkxy+k67PACz01-aXx6-njcisgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kake8k2dM=NPwNoqB5Vkxy+k67PACz01-aXx6-njcisgQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Tue, Dec 19, 2017 at 2:44 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>   checkout -f
>>         I think I would expect this not to touch a submodule that
>>         hasn't changed, since that would be consistent with its
>>         behavior on files that haven't changed.
[...]
> I may have a different understanding of git commands than you do,
> but a plain "checkout -f" with no further arguments is the same as
> a hard reset IMHO, and could be used interchangeably?

Ah, good catch.  Filed https://crbug.com/git/5 to clarify this in
documentation.  Thanks for clarifying.

Jonathan
