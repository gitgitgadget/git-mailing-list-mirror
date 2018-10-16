Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813A51F453
	for <e@80x24.org>; Tue, 16 Oct 2018 10:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJPSUU (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 14:20:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43524 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPSUU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 14:20:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so20773488eds.10
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 03:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fZnEaGRh+BNqBNgIUqla7DRNq1VPRi8S2sg0lYKOF8g=;
        b=lmQTBAfQLO2mSombEIj5qoxKjM2H7GZuDN0NEy+CLGDOzvMOtXtNMw/TtCxg48M3DK
         2uujF4CnQqfStWgUGzxatvY61qnLHpqjvvQpEHcqKclNApww5MhJJcm0qbYYCaIbfO3A
         QFBalW20Ls/jnXuogtlhDM2uU3zt4yhcVaiUsFA8fwEZKXrHqETIq9BitytW/ofK29kc
         AglZOtYb3hLLnYRPyMvezdr0Tk0f19GghZkA+i3mFtUeBn9RDPtrBiolgnv0RAAV0FrX
         IdSjB29I2jOplatiHYuhpMXqg89R/KzwfTc8ZxIRCupjg1G9heFhXwGHJMZP1khyGBVs
         eYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fZnEaGRh+BNqBNgIUqla7DRNq1VPRi8S2sg0lYKOF8g=;
        b=VbDDyx7SxE9yoJPA689FyNbI9+XnCPRU4ThkiLUccyNqEJUki4vcT31x/UWlUMQKi4
         qQsPR11R3jDbre/1aTzl0qLHKN2JiQFQQ5yveEXXZgXqi1DC5KDJrhBPWLVs8mA9I6gj
         RNtFYdaSd5GmMM/mkuUnpOt51HwAvYYycMc1OLnTQrGd/SgQAgt0meaTlKLlVw6oy44h
         RsidZInuMH7Chz8w62n6VLxrzrTsTz4rQH7hBR2F6loN0u1PzUGuv5bPr7ulvCBgH7hX
         Et03tko2TT3KBRThNoWo0cPfRkdqflB3ETjeTaxp8/xn27zyRWYhFCpqzWaKk/y089aV
         GaWg==
X-Gm-Message-State: ABuFfoirBGvP3p+EOcyoQQUAx4ZkLEQua6q1laHouTLgJOyJT99f+f5+
        EcQdYFZmPA99Ao50r3umcks=
X-Google-Smtp-Source: ACcGV61BitWzUAwNhMBLaT06wx4ai4chB7iXhHmLG0SBgYEsEsyHfe6Z1fysdTR1iaWAFHhJa5de+A==
X-Received: by 2002:a17:906:40cd:: with SMTP id a13-v6mr22999318ejk.14.1539685832866;
        Tue, 16 Oct 2018 03:30:32 -0700 (PDT)
Received: from szeder.dev (x4d0caaf1.dyn.telefonica.de. [77.12.170.241])
        by smtp.gmail.com with ESMTPSA id c11-v6sm2842486ejr.6.2018.10.16.03.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 03:30:31 -0700 (PDT)
Date:   Tue, 16 Oct 2018 12:30:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/13] Offer to run CI/PR builds in Azure Pipelines
Message-ID: <20181016103029.GL19800@szeder.dev>
References: <pull.31.git.gitgitgadget@gmail.com>
 <pull.31.v2.git.gitgitgadget@gmail.com>
 <20181015142215.GB1764@syl.hsd1.wa.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015142215.GB1764@syl.hsd1.wa.comcast.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 07:22:15AM -0700, Taylor Blau wrote:
> Would we like to abandon Travis as our main CI service for upstream
> git.git, and build on Azure Pipelines only?

It's not only about "upstream git.git", but also about contributors,
who might have enabled Travis CI integration on their forks on GitHub.
Having a '.travis.yml' and associated 'ci/*' scripts in git.git makes
it possible for them to easily build and test their branches on their
own.

