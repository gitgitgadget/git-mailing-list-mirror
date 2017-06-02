Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0282027C
	for <e@80x24.org>; Fri,  2 Jun 2017 18:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbdFBSFU (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 14:05:20 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36295 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFBSFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 14:05:19 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so13091818pfb.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wIpB4UW7+3mLNRCLnLWSjvqiNOOIX1/WKJJ3lfXlZa0=;
        b=KYSFay+ja3spBpr57ClgTcp1HBOmJbCFg9pBNQ3SDjax/nNsBi6P3SV8gmRotw2bYq
         zXITRdt608ZzmxC8Cl7Ouj1+Q69Mbwc1kBAlkv9vwB5X6li44v0vaEmEzYJ9U6lwZx7b
         3af2HDr+JM7TllqJuVKl4lk+NdthhMYDnkQUYggc8JKIxWG6ykgDDg7qGZGq4EJVUe3g
         jM8Wuk7Gj+o9tDOgu0r1NkM2ckj/e69wTBo9fzdgHNeh7SgqVlAzB8tw9zKkKI5LnPvK
         ojWuVSW2whObFM9bTlhjIH1iAg79+u7CQ96e8Wja80QmMcz9t8+bh7BRPl8Wy+vIL7ft
         rF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wIpB4UW7+3mLNRCLnLWSjvqiNOOIX1/WKJJ3lfXlZa0=;
        b=ZsqSM2rt+HYrRt5RpNUE5hDvAp/QfH1PZp+GUnNgm9RKPTn9Jg5e5CgCFPgYOT3U/v
         V4zmyDh7Ix4PN4bCFkdBQFqrWG7t5GXbfdpp1ZXYfuqQp8F11/Rgr9jFgIv+5hDSIoQn
         H0NA7HqXToyp7rfFxYN29zvHUC/SqVfrkhX4zSgQ+JVvJKzm9O/IoME4Kc8nk69+Y4aB
         +DSspIJkbzQ1e3cC1q9uXRw79FSmQtszjST+7EZUCnvdH3Ib/7q4EGSngVwHGyaQlz5h
         BVIVwnpPltM7iEEPJDFcJRwPJLotYs51PEQJk2pQdIwPK4lj9aa3u0rEJ/StIHRZOoFm
         H6HQ==
X-Gm-Message-State: AODbwcCzI6aYCCuDpwfz2hELN0JWbRUYHbZs/6StELGSZOStF3tmzj/m
        7W3Ku8m4uOdIwA==
X-Received: by 10.98.12.19 with SMTP id u19mr1294552pfi.47.1496426718548;
        Fri, 02 Jun 2017 11:05:18 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:9141:378b:960d:5b13])
        by smtp.gmail.com with ESMTPSA id g23sm37391387pfb.54.2017.06.02.11.05.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 11:05:17 -0700 (PDT)
Date:   Fri, 2 Jun 2017 11:05:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests
 for console output
Message-ID: <20170602180515.GB30988@aiede.mtv.corp.google.com>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170531104213.16944-3-phillip.wood@talktalk.net>
 <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
 <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706021442190.171564@virtualbox>
 <20170602175455.GA30988@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170602175455.GA30988@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> Here's a rough list of some useful tasks, in no particular order:
>
> 1. bc/object-id: This patch series continues, eliminating assumptions
>    about the size of object ids by encapsulating them in a struct.
>    One straightforward way to find code that still needs to be
>    converted is to grep for "sha" --- often the conversion patches
>    change function and variable names to refer to oid_ where they used
>    to use sha1_, making the stragglers easier to spot.

I forgot to say: please coordinate with Brian M. Carlson if working on
this one.  That makes it possible to divide up the work in a way that
doesn't lead to people patching the same files and stepping on each
other's toes.

This is one of the larger tasks and contributions to it are very
useful.  Just do coordinate.

For comparison, the other suggestions in the list should be possible
for a rogue agent to experiment with alone, with advice from the list
where they need it. :)

Jonathan
