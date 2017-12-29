Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C99A1F406
	for <e@80x24.org>; Fri, 29 Dec 2017 03:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbdL2D3d (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 22:29:33 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:37012 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753732AbdL2D3c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 22:29:32 -0500
Received: by mail-qt0-f178.google.com with SMTP id f2so53119377qtj.4
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 19:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cvdZ9osrLgqOTHC6oclJO/Lk+uvhdYc1kIKLEocYCvw=;
        b=pTSkCaGGPdOvPqPu174ULpM4uvXvmO4hkV/wnOFOahcImj14CrdhnO014L1KFFA4dA
         +ygzemyNFEfS+6qd0FZyqEDgS6QHebixc/sdtWM0z6OI42YFIeVOkB3JlQpR/jTVEq7j
         MV6OYooKgPwu9IyWiiM4XL6zkjYRIM8uIgWl3azIYVe3mIQ7c4/dH9/54/eiMd5iwvVA
         Aep8MLpdpibtsEvX0uSJUxaLNklFbMg7l6M9g0lhZM/YI3jxswbmBlZxhpLhfKZT6dfJ
         pEJb5K0WVJX6O86Ig+i1xrGdXejSljcrSpj2BGzBI1AKKiZ7dDEFvL+tfHqkRC6CfzOU
         HrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cvdZ9osrLgqOTHC6oclJO/Lk+uvhdYc1kIKLEocYCvw=;
        b=r1Dzep7tmFoyke4m2BB99Im8CXNMGWEJgDgdPt+cdppdEMyGrYhP6U6tqqhLAgJLbo
         zrJy9tY6VV3MQJgbEQCfpUXP1tPnOjQjVh10scT+7Z3LNPHOqkXgbzDj3z1BHNPtaYPy
         ck1K57sLpF9QYjhw/eseawmoKezHBKeqnvf3oEUGwoep7EZMFzeAehGXhMrnJc50bbYG
         Agleoa2CYPu6wY3NoTuPIJczxLEqS9Dl2d7rZN1JO099BGuSE/BBMNPSCDqCRdffPtH7
         GpBFKVi5BxvclKqMaQMKjYuvFFzACwA3W9RVh/Bu/6FEIdeMi/TbQoXxstgSdimbsLh9
         YR9Q==
X-Gm-Message-State: AKGB3mKINBkebqFT8/jdsRXYvecTwTym5HIMhTM8Kzl8l5CzHycYfnsK
        DaewiPr7Eea/0l9TNX9aDEzN1bEv
X-Google-Smtp-Source: ACJfBovMzGqut1gPSDZK94fXmesFlLmTTj3HAKnBuKmB7uC5Hr9IK0RfNPC/F39FnyoWA5uf8SMNgw==
X-Received: by 10.200.48.51 with SMTP id f48mr43652919qte.262.1514518171807;
        Thu, 28 Dec 2017 19:29:31 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id x1sm22143747qti.91.2017.12.28.19.29.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Dec 2017 19:29:30 -0800 (PST)
Date:   Thu, 28 Dec 2017 22:29:28 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Keith Smiley <k@keith.so>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add shell completion for git remote rm
Message-ID: <20171229032927.GN3693@zaya.teonanacatl.net>
References: <01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Keith,

Keith Smiley wrote:
> Previously git remote rm did not complete your list of removes as remove
> does.

Looking through the history, the rm subcomand completion was
explicitly removed in e17dba8fe1 ("remote: prefer subcommand
name 'remove' to 'rm'", 2012-09-06).

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Genius is 1% inspiration and 99% perspiration, which is why engineers
sometimes smell really bad.
    -- Demotivators (www.despair.com)

