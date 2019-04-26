Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E1B1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 23:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfDZXwY (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 19:52:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42255 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfDZXwY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 19:52:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so2259226pln.9
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 16:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pXtsmVK0X26hZJpN35ahtvyIQboOj0Y+KBqTAB4xXYM=;
        b=L4mPqRVJ3Hv0yUEBr0yOUMOr/kLA0QZFN3GrdO3AW4sz76OlK1Nhb4R0xkhNwCKMYa
         MIg3SvGT1ywN3a4a6b3aXJR/voXm29bBQNmTYwahdYyVDVKqhb1FP8mumZ0dkL1JFi4f
         FwSeBt/APU1LG4jcXN+B4w6LUomM8DkxoBGqtrUdlFLQjHYmVvM/2JN//fQA0k06n/L5
         N8263lwSTwU/v+9nsNoCGfQhbdUmXl/1qvWlSBr+3bXYXXtuSZW2cbBH8D1XSpQGAawR
         uzNhPsFSvC0QTfl03e4y/AV1CQXqWrpP4UC62kL1M/f/drCUIdPZELjZJ/3Jng3lSSNT
         fdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pXtsmVK0X26hZJpN35ahtvyIQboOj0Y+KBqTAB4xXYM=;
        b=iULN6M8K2uBMoCwG9DFLdiNRcSE5vab7WL5zhLDb15VcFvPJs9iq+6jHk2A2FQDVz3
         grNW8gK/6Efss0SfVxxAoppY1VX+aLrMIozEHNsllpNgu4f+VOaYjmB4gRwkfopo+zAm
         ByRT2ubRnE1I/Yq94QuDIhI4Wte71ZvjJWd7u2Z9419FFJsToH7BsOA7Qqg7D60/6veq
         rRethIQLMWtDbZ93w6S9CTi2X2zHylZ9PlYN3fVnaEBNOgJotoIcSemWmcUP9a36pnsH
         b/+6HwN1YkUJMiy0W0dwf9D/iinnIt6WZJkYKhSSP2Mry0bIx9IHeJ2uTt8hXl1lI8Hg
         cVpw==
X-Gm-Message-State: APjAAAUhL3WPelb8EPsx0ddDbLvH50aDKTeXsN7B3w86EZvOrqHL4qes
        GPcvmulbXUJaUqKH4LOw5ag7SiJ+
X-Google-Smtp-Source: APXvYqzeCqsf+FPrlGqhb4dk7jiMK2iDxVvqzkv7HspI60mdrqdtKRw36WYL+PdaZwhKfcxg8ApeYg==
X-Received: by 2002:a17:902:864b:: with SMTP id y11mr46149226plt.1.1556322743432;
        Fri, 26 Apr 2019 16:52:23 -0700 (PDT)
Received: from dev-l ([149.28.199.249])
        by smtp.gmail.com with ESMTPSA id t13sm18085756pgj.49.2019.04.26.16.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 16:52:22 -0700 (PDT)
Date:   Fri, 26 Apr 2019 16:52:20 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] allow checkout and branch to create branches on a
 merge base
Message-ID: <20190426235220.GB28055@dev-l>
References: <cover.1556226502.git.liu.denton@gmail.com>
 <cover.1556305561.git.liu.denton@gmail.com>
 <xmqqlfzwtlft.fsf@gitster-ct.c.googlers.com>
 <20190426234024.GA28055@dev-l>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426234024.GA28055@dev-l>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 26, 2019 at 04:40:24PM -0700, Denton Liu wrote:

[snip]

> I'm going send a reroll to update the documentation to mention "..." in
> <start_point> and, while I'm at it, I'll do the squash.

Actually, I have a quick question for you:

Out of respect for your time as the maintainer (since you have a lot of
topics to deal with), how do you prefer small fixups be submitted?

* A complete reroll of the whole series
* A replacement for one patch in the series
* A follow-up email with an "oops, please change x to y"

Thanks,

Denton

> 
> Thanks for your comments,
> 
> Denton
> 
> > 
> > Thanks.
