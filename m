Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CB62018A
	for <e@80x24.org>; Tue, 28 Jun 2016 17:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbcF1Rwj (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 13:52:39 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34064 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbcF1Rwi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 13:52:38 -0400
Received: by mail-io0-f179.google.com with SMTP id g13so23651145ioj.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 10:52:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rPhCh7PVKwywmOloCmLqd/D8bVmV3+CmLEDR75+ub6Q=;
        b=aXQWO0PEVzfvmyxxlNWY5/trm8ETN6qTwS5qvIYtKtxFdnGAUqTgLQ7KB6qi/0e6Ny
         WstNCkjXHCI+q25fRAz+sbCJxM3ijxBf3blKR6eIvwNbXYwcHXRuD0/XKVRKk2Wdfvgw
         2xCRPUKndnvnPkLq0W1u83ouFeehy6Yir/tNpq1driv23Q2+4FEhphGW5QvJ0Rd0YgdB
         v48opHhfz302kR+i/FhBBRCa3ytX6c+V/UEH/xpinIh68t/k91WnnFqdpMvoXRENtVeU
         vVx0JuHig7Y2lWI3StMxgXaK1Hi/lt7rZSvIQ1q7xy7AqKUOvFfIkwTYMbFs+CQ3aG10
         Wzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rPhCh7PVKwywmOloCmLqd/D8bVmV3+CmLEDR75+ub6Q=;
        b=KKOGqKgItjqnDgoJo2ovhNNwwZ0uwkE9fGwAU2kTLJbyCtbaoUcA0LbaLuhEJUbhEg
         bTdWnd8rSTB3KG2EQoiuYiwYsel4futDzV5iRCp1n9BaWrqcd37OXbS+nZEd4F/V9xDG
         JqcF+PO7+ZV2hfIYvVXTpmC6Bj6OrXxA1kPCNc0OKIGsuo+1Q4BGP4ilI2NuWWCuhx5t
         rnKdfdgRyLIYIjTm2yrcALllHoeMZaI7vNGaj2illv/QtHZc4LBphVbrPpwH3pb1S/GR
         XVuAyv2nPfnoyxHg24/ikvfeYG3jIzc2tNAW+ys+VKN5eMHx9qM4YynuwXzYPUN13Knm
         d6+Q==
X-Gm-Message-State: ALyK8tJqUmng62kzrV3auYKLILonNR9eYMmvzYUUSZ5U/ofLtLcWnlUDT7F+PkPOdSKBjvjcEDiVtWV1X/kg7A6t
X-Received: by 10.107.186.196 with SMTP id k187mr5190148iof.173.1467136357437;
 Tue, 28 Jun 2016 10:52:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Tue, 28 Jun 2016 10:52:36 -0700 (PDT)
In-Reply-To: <CAOG-3G+umq4iqDz1aMu4qnjxSQrhO76N8wc4WwtBiN8n58=3Yw@mail.gmail.com>
References: <20160628001559.29204-1-sbeller@google.com> <CAOG-3G+xAZQV8rPgdxz8S8bqzJfm1fFNg2Y4suC-a--tbCWXow@mail.gmail.com>
 <CAOG-3G+umq4iqDz1aMu4qnjxSQrhO76N8wc4WwtBiN8n58=3Yw@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 28 Jun 2016 10:52:36 -0700
Message-ID: <CAGZ79kYnuVyEZSLviFq-ZrULF9EgJm18vk213Z7jBYK_UnwKrw@mail.gmail.com>
Subject: Re: [PATCH] submodule: test moving recursive submodule
To:	Bart Bogaerts <bartbogaerts@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 11:28 PM, Bart Bogaerts <bartbogaerts@gmail.com> wrote:
> I dit some more testing.
>
> It is important for the bug to occur that all submodules are initialised.
> So my suggestion is not yet complete, you need to add the line

Oh right. I was completely oblivious to that.

>
> git submodule update --recursive --init

Adding the initialization makes my test cases fail as well.

Thanks,
Stefan
