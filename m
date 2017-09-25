Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81CA202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 22:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934938AbdIYWLF (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 18:11:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35988 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934366AbdIYWLE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 18:11:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id f84so4162927pfj.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iI774eV5vAuZHU288rizIuD6M7TaNnKeS6r61+gLbak=;
        b=DgA+L2ll1KxrsY2yhaWuMpPteA8JMMziz020y/5F9Cz5gbTKLNDzvOVB+pP8donFjY
         kKb+zB9nSMOEnK219zjZKkIgGurDyR8PHmAVsbmAlXXnzqaiEfXJ5uiS4uEtp5s6dx0v
         pb6SlcOrawvdn4FwoLt8YGUTuM1GITuZw+fw9lddRHzfUAdeEDP0CLM6SJjDKDPlu4Ms
         W9DZn4nZGUFhpwN61zniiXk3ZZh/yqkZ9daFUhHWI21rR3mb8hNJ6nKEo0jcwUzMrF48
         uNERwtCo4fs3Bu0Twn8sRb7zcMmgBc9ngZVyTJ5P434BDxwtgOgnVWww2MkzRhP8wqOL
         Tkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iI774eV5vAuZHU288rizIuD6M7TaNnKeS6r61+gLbak=;
        b=LnKz4XPFNrVs1wnO3xTcEgyKDbDS6nrJxifRvp5rM5bL0mlKcnaEaVo97leNoJkzRE
         O983u5ZzQlUcfm5YNqfsraBouyaS3/aeqU1mIVf2neC/8ycmS7pQw4kN2RcjAgnebxgG
         VItMJfCToEUSpdA7qNma9XBsCGpsM5ModuZgk+aPQQGWnss5BfA1qcqc+ZRmBL8a1z6X
         pedU6mnnAGdPF8B/ULfGzVav+n+qObjuVN/tQDym36lQVsPpaWW7ZfKNlV+MMcQefyL1
         1ui5t2Wk6RSC0z5stEaY+j23AzEZyCT46za6n1zjDsQbWNwwjBC7ws2vKyw/7eVkqHhf
         tBlQ==
X-Gm-Message-State: AHPjjUgjQffQv3GhOgZE950z0gapiBRblaGvaQOmunEGqi6c5f4urbGd
        1SpoS9RQZIBplFpFm7Is9QBPOxta
X-Google-Smtp-Source: AOwi7QCyEmUFkcZi2wMRsCD+Y8o/NaHm0yf1Z5ijvj82MoYreMz/jo5mUCQLKPv4SDb8c7utR8Z7/g==
X-Received: by 10.98.200.153 with SMTP id i25mr9022611pfk.248.1506377463718;
        Mon, 25 Sep 2017 15:11:03 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id c7sm13814025pfg.85.2017.09.25.15.11.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 15:11:03 -0700 (PDT)
Date:   Mon, 25 Sep 2017 15:11:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/7] worktree: use xsize_t to access file size
Message-ID: <20170925221101.GD27425@aiede.mtv.corp.google.com>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925203033.z4czmuhedm3f54b3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925203033.z4czmuhedm3f54b3@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> To read the "gitdir" file into memory, we stat the file and
> allocate a buffer. But we store the size in an "int", which
> may be truncated. We should use a size_t and xsize_t(),
> which will detect truncation.
>
> An overflow is unlikely for a "gitdir" file, but it's a good
> practice to model.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/worktree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
